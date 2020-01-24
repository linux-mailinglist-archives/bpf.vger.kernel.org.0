Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8987A1478D3
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 08:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAXHK5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 02:10:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42159 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgAXHK5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 02:10:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so538303pgb.9
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 23:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YHPrZknP3aSvwBkLZpZhgDzuWSkvih7tjHMfkkf3BWQ=;
        b=dvlxQFE/c7t4VYANjXgi1oSTOuyFdC68jp2ivGKCnhDIL5qL77vzjVKVzWmLHKNwWE
         rdIrBFT5WBpJtwVtfIPPAtss5yuaOfEO2PpP7PvCx5v2yI1/b+vRSVgIknYq6xEUFx/I
         QGjxl/lYr+VHzBWj6TxOvIb19etguv5ORiYmkBSnAW9Ar/qu0vav1jFC8OitaLSS7ae4
         bpSPn0W+JhBBHLRTy8nyvS3xgQQ4kBFzYTudzwaVahm5+VdnMABKqYretv0xrM68CArl
         Hytvw/lSx1aGcrIOBTVeTdVwiCBxwGp1qJkpRzj55jixPg3PYP5eBfTXlmjpXwwmYCmD
         3wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=YHPrZknP3aSvwBkLZpZhgDzuWSkvih7tjHMfkkf3BWQ=;
        b=kbvv+3BSY7jLNZSZD26XyybPe4FLoQTdHTqme6GtNzw83by0iFQtIZK8MTEda89t85
         H4nawxrjW4cA62C5M9cjagAsCIwgH6uy8l6K5TobNMsiiLBLpQ1QmFJO2m3rRlhNozmH
         0FGCCCP3s/uJAj0TqebCdJguQvMpQnWNP4WJV57MqrdrZLZOkk4BoGpPhHPF5FyX9QL6
         UKAsC8uEKArWv23jt6RMWtbxRFSQw9LhGgR2grG3T5UdZm/Jkp3jvISpBkL3gRGoP546
         h5PGt7tjIiPLpN/a4nsZ36m3vskjkSXWgJkkGlsJSIBO8jPdmU0CQ3N2i6NGQpcBJEya
         8dhA==
X-Gm-Message-State: APjAAAWtzMTrYX0p/KgdDkIwmyP56/qGhwd9y48Us7ScOEM6sHVmfkRT
        T5o5VSTfGC1slY6nwCMloZw=
X-Google-Smtp-Source: APXvYqxI7zP8yKs4/VmJw528yxrYHkxb75+yg4WHlhV5UWqBJqLPXbDg/w3BXpVgxmkRaQRVmBAEYw==
X-Received: by 2002:a62:83c5:: with SMTP id h188mr2035886pfe.0.1579849856672;
        Thu, 23 Jan 2020 23:10:56 -0800 (PST)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id f81sm4746924pfa.118.2020.01.23.23.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 23:10:56 -0800 (PST)
Subject: [bpf PATCH] bpf: verifier,
 do_refine_retval_range may clamp umin to 0 incorrectly
From:   John Fastabend <john.fastabend@gmail.com>
To:     bpf@vger.kernel.org
Cc:     yhs@fb.com, john.fastabend@gmail.com, ast@kernel.org,
        daniel@iogearbox.net
Date:   Thu, 23 Jan 2020 23:10:42 -0800
Message-ID: <157984984270.18622.13529102486040865869.stgit@john-XPS-13-9370>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

do_refine_retval_range() is called to refine return values from specified
helpers, probe_read_str and get_stack at the moment, the reasoning is
because both have a max value as part of their input arguments and
because the helper ensure the return value will not be larger than this
we can set umax and smax values of the return register, r0.

However, the return value is a signed integer so setting umax is incorrect
It leads to further confusion when the do_refine_retval_range() then calls,
__reg_deduce_bounds() which will see a umax value as meaning the value is
unsigned and then assuming it is unsigned set the smin = umin which in this
case results in 'smin = 0' and an 'smax = X' where X is the input argument
from the helper call.

Here are the comments from _reg_deduce_bounds() on why this would be safe
to do.

 /* Learn sign from unsigned bounds.  Signed bounds cross the sign
  * boundary, so we must be careful.
  */
 if ((s64)reg->umax_value >= 0) {
	/* Positive.  We can't learn anything from the smin, but smax
	 * is positive, hence safe.
	 */
	reg->smin_value = reg->umin_value;
	reg->smax_value = reg->umax_value = min_t(u64, reg->smax_value,
						  reg->umax_value);

But now we incorrectly have a return value with type int with the
signed bounds (0,X). Suppose the return value is negative, which is
possible the we have the verifier and reality out of sync. Among other
things this may result in any error handling code being falsely detected
as dead-code and removed. For instance the example below shows using
bpf_probe_read_str() causes the error path to be identified as dead
code and removed.

>From the 'llvm-object -S' dump,

 r2 = 100
 call 45
 if r0 s< 0 goto +4
 r4 = *(u32 *)(r7 + 0)

But from dump xlate

  (b7) r2 = 100
  (85) call bpf_probe_read_compat_str#-96768
  (61) r4 = *(u32 *)(r7 +0)  <-- dropped if goto

Due to verifier state after call being

 R0=inv(id=0,umax_value=100,var_off=(0x0; 0x7f))

To fix omit setting the umax value because its not safe. The only
actual bounds we know is the smax. This results in the correct bounds
(SMIN, X) where X is the max length from the helper. After this the
new verifier state looks like the following after call 45.

R0=inv(id=0,smax_value=100)

Then xlated version no longer removed dead code giving the expected
result,

  (b7) r2 = 100
  (85) call bpf_probe_read_compat_str#-96768
  (c5) if r0 s< 0x0 goto pc+4
  (61) r4 = *(u32 *)(r7 +0)

Note, bpf_probe_read_* calls are root only so we wont hit this case
with non-root bpf users.

Fixes: 849fa50662fbc ("bpf: verifier, refine bounds may clamp umin to 0 incorrectly")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 kernel/bpf/verifier.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7d530ce8719d..9f310db68073 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -228,7 +228,6 @@ struct bpf_call_arg_meta {
 	int regno;
 	int access_size;
 	s64 msize_smax_value;
-	u64 msize_umax_value;
 	int ref_obj_id;
 	int func_id;
 	u32 btf_id;
@@ -3573,7 +3572,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
 		 * to refine return values.
 		 */
 		meta->msize_smax_value = reg->smax_value;
-		meta->msize_umax_value = reg->umax_value;
 
 		/* The register is SCALAR_VALUE; the access check
 		 * happens using its boundaries.
@@ -4078,9 +4076,9 @@ static void do_refine_retval_range(struct bpf_reg_state *regs, int ret_type,
 		return;
 
 	ret_reg->smax_value = meta->msize_smax_value;
-	ret_reg->umax_value = meta->msize_umax_value;
 	__reg_deduce_bounds(ret_reg);
 	__reg_bound_offset(ret_reg);
+	__update_reg_bounds(ret_reg);
 }
 
 static int

