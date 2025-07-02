Return-Path: <bpf+bounces-62115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35149AF5A43
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 15:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD314E51A0
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB95283FF7;
	Wed,  2 Jul 2025 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKsiD9vE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1A727A122
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464500; cv=none; b=A/CutqucDZaDonuSiUIwJi2ZK1dYWlv1KUeS4/mQHRFa3dTVuRIwQfZqInL2KL/9SRwrGTzIaWlYIdOPNGQDGqbXhyiAXMBrenHdyjlqsZWKbqv4SMMhu9F/Kb4L63H6swCdWL0LrXzZR6Vtqv9rrfNKmJr4mmQg0948O0RQYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464500; c=relaxed/simple;
	bh=B4pCNBQsF+PBEMl+WxtbO0xFxmqEAi3XxE1Isceb0PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA9Nh2t+G9zxEyjLGkRCOtW/SBHSDkXOun6ghsEoza071wWtjsTxhAZuEao729XJMxNVFtHJDl4oxz7EdJIXvI7salQTT6+mlOj6FDNJOPvsl4Wb7I54IHNML6+mmpci2HQkPNcPAZzeTdqHNaY1B472ZIigfVkrf1wGTArAWUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKsiD9vE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a5257748e1so3024910f8f.2
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 06:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751464497; x=1752069297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rISt0n/4lRlS1otI15eHXZluKgaq0K9tnY7ePXbnBV0=;
        b=fKsiD9vEPQzK2i5ZpFWDQn4fvAB5hyiHXhE5yzvbmALsUI7Twvx2k0SeJ2oV7imKAH
         uYVvc25yhSHxzrNvABo2gwxldUeXXhSCbxRjtSS5TXzRaLjFeWQH1BAoDbcX07/qSu41
         E/4FYDHrTuHhTuAybYMpz+Rd6xSVxVqiMe/idM7d0yi0W4Ki+fI9oZdkzeZ13nlIx7VK
         uTVM+dqQSj5Y8fYEdF8Z+uROe3myuEWYkSyYhRxqCaqKIGOf5cyMoYKaxAZahuYvlrcw
         7QJLhk5AMlXKJ0GnZXS0qab6sOG+L2eZmCuXQaP9jJnbaO4H/3xsK8AOzv/JzqvFDbXL
         0YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751464497; x=1752069297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rISt0n/4lRlS1otI15eHXZluKgaq0K9tnY7ePXbnBV0=;
        b=tTW4JpbBqyutUq+AiCAYItOVZPiTsfn3AqcCIvNOaxnfBnawd77oqHiOOvqD8pTqj6
         a0/d02VaQAlNkOiIL9VsHjrCc7eVxAW9wZi7az3eI7tWYy3V5xBg2/Xbr2fpGeDECy7Q
         IZYhp42UeFLOiyO21QNGnA+URR3itkmWreGRFhsFgqMu4z+PJmV55Bosuoy0bU7f1hf8
         DaH7Hvpdzx4j18oDOsCdy5shStTQsXJc+h3yy3oxqY+vEW4lmURDiIRFrWaDtuVUs3um
         im000sDDMwOe/kybeDdQekG8+s1ev4db1RXxKzhit/gL45pSeZKrUWShVYcIAKpECN4K
         Ptzg==
X-Gm-Message-State: AOJu0YxVGKvy2imEkRq4eHpBB6w0lMmmrOZyqo3RuQ85JZt6fhWoIvKw
	amIfWjncN58Boh/8fkSQ9Zm4v1vyNU1MC7uuTWz2Xf14JtzQQzoDscPW+/iPCLCf
X-Gm-Gg: ASbGncvzB21u9lwyOcMqnXNVImMjtI3CaIO9TqTEK9N4ouMRpnqLu2t5EK13fKvuJbZ
	MMwvxm9kGaFOeI7dvhJ5QAQgoQzNPNBrEwnDyr9uLTnJvpcWdTFxAFk4W1kTodXc47HPxmY4nK8
	2V4mdx/xN/hbVOeNgTSIZcyghL+C1ZE0YgkUF0fYdQvOLnxWHphGmr8XLkOHlhf4m3/ndUzW+5x
	NuzkyxrB6tOSwTeLdwRWy00bo+GpBeBS/4oA08D/E39q9HforRL36pc7g4J476DSBNzroPVqQ4O
	JRjRPqQjefqN8np61V45aP8nw5YvJttCToyz7DOx8hz/5vTvJiCh9pBV5Vef3jjv7zyHqwIgrr1
	23wHVu6RnBGoWP3JWHL/68SkP83frMjto5H14uivmsJyqgNayTg==
X-Google-Smtp-Source: AGHT+IFQONSSCn8fdoSxvxiyccM+5WplLYCFtAIEZlDQDCzKf/ZM4CXP+E3RkF6BRsd6AXZPap+6VA==
X-Received: by 2002:a5d:64c8:0:b0:3a4:dfaa:df8d with SMTP id ffacd0b85a97d-3b1fe5bef10mr2465035f8f.9.1751464496819;
        Wed, 02 Jul 2025 06:54:56 -0700 (PDT)
Received: from Tunnel (2a01cb089436c000d0fa69457aba7254.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:d0fa:6945:7aba:7254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e598d2sm16018936f8f.76.2025.07.02.06.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 06:54:56 -0700 (PDT)
Date: Wed, 2 Jul 2025 15:54:54 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 2/2] bpf: Avoid warning on multiple referenced args
 in call
Message-ID: <cd09afbfd7bef10bbc432d72693f78ffdc1e8ee5.1751463262.git.paul.chaignon@gmail.com>
References: <3ba78e6cda47ccafd6ea70dadbc718d020154664.1751463262.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ba78e6cda47ccafd6ea70dadbc718d020154664.1751463262.git.paul.chaignon@gmail.com>

The description of full helper calls in syzkaller [1] and the addition of
kernel warnings in commit 0df1a55afa83 ("bpf: Warn on internal verifier
errors") allowed syzbot to reach a verifier state that was thought to
indicate a verifier bug [2]:

    12: (85) call bpf_tcp_raw_gen_syncookie_ipv4#204
    verifier bug: more than one arg with ref_obj_id R2 2 2

This error can be reproduced with the program from the previous commit:

    0: (b7) r2 = 20
    1: (b7) r3 = 0
    2: (18) r1 = 0xffff92cee3cbc600
    4: (85) call bpf_ringbuf_reserve#131
    5: (55) if r0 == 0x0 goto pc+3
    6: (bf) r1 = r0
    7: (bf) r2 = r0
    8: (85) call bpf_tcp_raw_gen_syncookie_ipv4#204
    9: (95) exit

bpf_tcp_raw_gen_syncookie_ipv4 expects R1 and R2 to be
ARG_PTR_TO_FIXED_SIZE_MEM (with a size of at least sizeof(struct iphdr)
for R1). R0 is a ring buffer payload of 20B and therefore matches this
requirement.

The verifier reaches the check on ref_obj_id while verifying R2 and
rejects the program because the helper isn't supposed to take two
referenced arguments.

This case is a legitimate rejection and doesn't indicate a kernel bug,
so we shouldn't log it as such and shouldn't emit a kernel warning.

Link: https://github.com/google/syzkaller/pull/4313 [1]
Link: https://lore.kernel.org/all/686491d6.a70a0220.3b7e22.20ea.GAE@google.com/T/ [2]
Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
Reported-by: syzbot+69014a227f8edad4d8c6@syzkaller.appspotmail.com
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Note: I'm sending this to bpf-next instead of bpf because the kernel
warning hasn't made it into bpf yet and I consider that the main error
(vs. the incorrect verifier log).

 kernel/bpf/verifier.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a352b35be479..712a5c4fb6a4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9673,10 +9673,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 
 	if (reg->ref_obj_id && base_type(arg_type) != ARG_KPTR_XCHG_DEST) {
 		if (meta->ref_obj_id) {
-			verifier_bug(env, "more than one arg with ref_obj_id R%d %u %u",
-				     regno, reg->ref_obj_id,
-				     meta->ref_obj_id);
-			return -EFAULT;
+			verbose(env, "more than one arg with ref_obj_id R%d %u %u",
+				regno, reg->ref_obj_id,
+				meta->ref_obj_id);
+			return -EACCES;
 		}
 		meta->ref_obj_id = reg->ref_obj_id;
 	}
-- 
2.43.0


