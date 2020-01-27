Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D3E14AA78
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 20:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgA0T3P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 14:29:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43622 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgA0T3P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 14:29:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so4755572pfh.10
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2020 11:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7zvl5jdN15qOGTWXC9memwRy8CHJrggn/p4AeqCupmk=;
        b=pCOmn88Juc3zZX1ov0RLP7MUcUKApbSP9Tx9mQwDc2YMLnIBBzzbNo5EG5YrilsuyR
         4T05vHg63mzPeyC0vdj5hUWXmyI1Q+Wqe9NVvtG3eC8rX5ksJq6Xe9xUdCYSlWLo+zLP
         RMSterD8koziitdOT8zdUQhHxjbJjetWTO7/FZCLyZts98ogqyZWZQdQZfczCdd6bk7h
         R53AmhyXL7VmUhqsXl+Y2BahP7Wh9xvV5E12cxhUANDE/clmbILvtPKcsyiesyR8k4ZU
         BlqVmb4lULI/6TUkQ61IZ6kU3VIOMXkr14EQX887Yk0Skw9/NbM8xD7KSu/DKRB4Dl3K
         IBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=7zvl5jdN15qOGTWXC9memwRy8CHJrggn/p4AeqCupmk=;
        b=ZtSesPJZch+QzD4WKK/XMwgFVb17A4+6pwU2h7xN8Hb5H5p2q2d55G4ePfAGsBdFnq
         YAeXShkGUgj9SoQhw7IC5dNOgatMh8EOosC9aH7jyQOzhMelK0ZyotWiJi+Mh9UmRZNF
         he+W+xsmB6ItHRzqSyW6DyDnB4g+cSqa1dR5KFJC9+Aw69YqFGJ7Fo2AG6nQ8hu2o5jc
         M8VQ61E35aSGX3tMst13SAWMOAh0WUHDEEaR4puTox+mHlLZgceHEIrbtERfhFbPdHaW
         B5j5F7+2ZGRJm1ZrucOEn9zzxXhWKx3VLEaQ/S4nbbM0LQPu9qzRfcLvJ6s6JgyVUDX5
         DVXQ==
X-Gm-Message-State: APjAAAX8mvieEoR8F9SbtLiAcW+skH60p/f6fNqVJ6msGajWS4Oilbdy
        CrzD3kVTtqSjOMCK1faXi6uuCiOf
X-Google-Smtp-Source: APXvYqxcedu+VicL5ix9fTp1JljNjgFw+/gUVktQ1OG3oV1/kPfBKIhT6nksie0ClGJnjquZBGOl8w==
X-Received: by 2002:a63:78c:: with SMTP id 134mr20098544pgh.279.1580153354691;
        Mon, 27 Jan 2020 11:29:14 -0800 (PST)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id r14sm16437942pfh.10.2020.01.27.11.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 11:29:14 -0800 (PST)
Subject: [bpf PATCH v3] bpf: verifier,
 do_refine_retval_range may clamp umin to 0 incorrectly
From:   John Fastabend <john.fastabend@gmail.com>
To:     bpf@vger.kernel.org
Cc:     yhs@fb.com, john.fastabend@gmail.com, ast@kernel.org,
        daniel@iogearbox.net
Date:   Mon, 27 Jan 2020 11:29:02 -0800
Message-ID: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
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
we can set smax values of the return register, r0.

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

v3: comment had some documentation about meta set to null case which
is not relevant here and confusing to include in the comment.

v2 note: In original version we set msize_smax_value from check_func_arg()
and propagated this into smax of retval. The logic was smax is the bound
on the retval we set and because the type in the helper is ARG_CONST_SIZE
we know that the reg is a positive tnum_const() so umax=smax. Alexei
pointed out though this is a bit odd to read because the register in
check_func_arg() has a C type of u32 and the umax bound would be the
normally relavent bound here. Pulling in extra knowledge about future
checks makes reading the code a bit tricky. Further having a signed
meta data that can only ever be positive is also a bit odd. So dropped
the msize_smax_value metadata and made it a u64 msize_max_value to
indicate its unsigned. And additionally save bound from umax value in
check_arg_funcs which is the same as smax due to as noted above tnumx_cont
and negative check but reads better. By my analysis nothing functionally
changes in v2 but it does get easier to read so that is win.

Fixes: 849fa50662fbc ("bpf/verifier: refine retval R0 state for bpf_get_stack helper")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 kernel/bpf/verifier.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7d530ce8719d..adeee88102e5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -227,8 +227,7 @@ struct bpf_call_arg_meta {
 	bool pkt_access;
 	int regno;
 	int access_size;
-	s64 msize_smax_value;
-	u64 msize_umax_value;
+	u64 msize_max_value;
 	int ref_obj_id;
 	int func_id;
 	u32 btf_id;
@@ -3569,11 +3568,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
 	} else if (arg_type_is_mem_size(arg_type)) {
 		bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
 
-		/* remember the mem_size which may be used later
-		 * to refine return values.
+		/* This is used to refine r0 return value bounds for helpers
+		 * that enforce this value as an upper bound on return values.
+		 * See do_refine_retval_range() for helpers that can refine
+		 * the return value. C type of helper is u32 so we pull register
+		 * bound from umax_value however, if negative verifier errors
+		 * out. Only upper bounds can be learned because retval is an
+		 * int type and negative retvals are allowed.
 		 */
-		meta->msize_smax_value = reg->smax_value;
-		meta->msize_umax_value = reg->umax_value;
+		meta->msize_max_value = reg->umax_value;
 
 		/* The register is SCALAR_VALUE; the access check
 		 * happens using its boundaries.
@@ -4077,10 +4080,10 @@ static void do_refine_retval_range(struct bpf_reg_state *regs, int ret_type,
 	     func_id != BPF_FUNC_probe_read_str))
 		return;
 
-	ret_reg->smax_value = meta->msize_smax_value;
-	ret_reg->umax_value = meta->msize_umax_value;
+	ret_reg->smax_value = meta->msize_max_value;
 	__reg_deduce_bounds(ret_reg);
 	__reg_bound_offset(ret_reg);
+	__update_reg_bounds(ret_reg);
 }
 
 static int

