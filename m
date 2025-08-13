Return-Path: <bpf+bounces-65526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEB8B24D9E
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 17:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63806560163
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 15:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ABF269CE5;
	Wed, 13 Aug 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfR+04mt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36283F50F
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099311; cv=none; b=eOJLMZYiyisWjaMZp/pYcj+lWwBqvQfk1YR683zgLaFjx39TF79BxX5d1SzDc0g+M2Dhm7mit5yj+Qn8mS05MjMaxGJcNT2MY/Bg/NRSGNpEDcNHCUd5BknhCsz8bmzmnWmY1SdP+x1suJ6eq+Eud0qhQnULilMmaCpVVYRWDTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099311; c=relaxed/simple;
	bh=+onVo9La/MyOlxSjtV1xFQIJiVaZXgdwv8hHRlgWxwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNEO6/dzCxGIYZYFrlMAm00YaWssZUm9UFR5kyIkxO/OrudnIfWfjRiHbgCyb/WORTTSh+5vKCQs+7BgzbRE4+iPcw9eb3HmkpQUfo/qfIBS/SxGLL5BH1ncGNKFeO3Am5QIoZQaV1vYk3LnsNM/yqRflHOzRMiYz6mgdOpRmGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfR+04mt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-458bf6d69e4so60730675e9.2
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099308; x=1755704108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JrjBc+O0kdTRGB26KhYmjj1VR62uIG8IrlVl64N/L3M=;
        b=CfR+04mtaH+o83H0Yb9sO6csXSfRnaHkj/RgjxioTf+K8iSrV9aekmRTGQbaX2OR36
         0GI6gicQ+Z9eUu2OmDBIqJHwzquDnaaguh9UcxRHzGMwl7+DR8shq7Ub2PasiFrKOiZM
         TuGXqKt+xGe2BVfQPjC59YwttTBmKiQPjIVu8ii/VpLigN++amTSLeu3QXA7+0yLsKF7
         fDeheD2MdxOA2eKK1PFqM8uwOzI16EFJXuLkq6LJNEFvsyDwWJ5nDrQvJO0ZRZdfwkJ/
         uISdncxbr/zQOTgUMZFtAXQgZ7a7Ij7DySxMMzJ6ZjYlldQM+tX51RIVTBbC3cC4rSCZ
         pW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099308; x=1755704108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrjBc+O0kdTRGB26KhYmjj1VR62uIG8IrlVl64N/L3M=;
        b=R3G1mAlCMbQdJwZaTcdy+mE4FCPsSVFdBO9yYA+3nFHszX377U/pRdqFtMctGJR74z
         eSr9kbPI/fFLcGSS0fMS/DyVExPrUNEwhviOWiafucF+L0jm58kUxOpNGJHt/BcC5QAA
         lww99kx7JA/NETEibfQgkJxeDQ2JID68PopNekuEGsyIC0rC3vCJVwmOfSNYdaOUpWGe
         8dPcSm5W5JRo9j4Zo3CY8Juyxxgv/jp9V0KlcVbqoZZKOiYljWF6U+LS4AJB9c3zHqeu
         t2tPXprmvjoG0mVwlSFvGV0HJ5juG+o5sBGhVvYxE64E5ndhV6Pz0U9tx0vmQQD7b8NF
         +DlQ==
X-Gm-Message-State: AOJu0YxxoFdiNJoZiC7GbAJyJVN1iTN7YBsluun6mXXl97CqfR4sUNzL
	4eWGkMMELMlRgt87R+2TZIYNWxtSBKQqrs1RF9M0s/3GRX0OqYSIUJcoa9qq5miT
X-Gm-Gg: ASbGncsg5k7ngTnaS45xd/4HfO1ZNukCfvqtiv02XQIefCbkzulHcPSGUkKYfrDF6u5
	hLQRgH7T/zIVlMwwhZWPqDSeHzXPfUdMRk/DkOdv1sqgtexGhFBmfuJFMwdVHQtAIpNHQV5e3Ec
	4Z4cV9ziSG+Xom7ORua7lPGAq0ZV1qf6SuQhR9NojzBXqIlmmXdzQUu7CaoD/vedbcrgf37bAyF
	y3xXIiHJ9aQ8NmPZVVEGUL1cu5yIAQlf8u+JShTnV9oW+6a6oCb4FX9iN4vcq6Yy6J60aQpiRwv
	WbBVLUFu2K2HFDnnFrliGCAP16zW2cWgJG+cDDp0QEHYQRFboGG1RL6WSK/fzEN7ne/sucu7ibV
	I0ibwcY7fmSeIJdiMxnlWdfaJEVCaE1LitIQorGM3dqMITNZc032mfNGWZcNxcFDzecV9dqW4Z5
	GLll+eBfygHXxf/82oa80/
X-Google-Smtp-Source: AGHT+IG1rKNlcD98TzXlPYDawa+Z28i5W50MLH9LKPHO85oTNGIPDMxzciGo4ZYiYvO9iN5PCPSBgQ==
X-Received: by 2002:a05:600c:35cc:b0:456:1204:e7e6 with SMTP id 5b1f17b1804b1-45a165cb0a8mr27070575e9.11.1755099308259;
        Wed, 13 Aug 2025 08:35:08 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c989eb83deecebd8.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c989:eb83:deec:ebd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b9163ae600sm4129794f8f.5.2025.08.13.08.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:35:07 -0700 (PDT)
Date: Wed, 13 Aug 2025 17:35:06 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Tests for is_scalar_branch_taken
 tnum logic
Message-ID: <85f82f190955844509eb77ae95f4ef20a587acd7.1755098817.git.paul.chaignon@gmail.com>
References: <ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com>

This patch adds tests for the new jeq and jne logic in
is_scalar_branch_taken. The following shows the first test failing
before the previous patch is applied. Once the previous patch is
applied, the verifier can use the tnum values to deduce that instruction
7 is dead code.

  0: call bpf_get_prandom_u32#7  ; R0_w=scalar()
  1: w0 = w0                     ; R0_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
  2: r0 >>= 30                   ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=3,var_off=(0x0; 0x3))
  3: r0 <<= 30                   ; R0_w=scalar(smin=0,smax=umax=umax32=0xc0000000,smax32=0x40000000,var_off=(0x0; 0xc0000000))
  4: r1 = r0                     ; R0_w=scalar(id=1,smin=0,smax=umax=umax32=0xc0000000,smax32=0x40000000,var_off=(0x0; 0xc0000000)) R1_w=scalar(id=1,smin=0,smax=umax=umax32=0xc0000000,smax32=0x40000000,var_off=(0x0; 0xc0000000))
  5: r1 += 1024                  ; R1_w=scalar(smin=umin=umin32=1024,smax=umax=umax32=0xc0000400,smin32=0x80000400,smax32=0x40000400,var_off=(0x400; 0xc0000000))
  6: if r1 != r0 goto pc+1       ; R0_w=scalar(id=1,smin=umin=umin32=1024,smax=umax=umax32=0xc0000000,smin32=0x80000400,smax32=0x40000000,var_off=(0x400; 0xc0000000)) R1_w=scalar(smin=umin=umin32=1024,smax=umax=umax32=0xc0000000,smin32=0x80000400,smax32=0x40000400,var_off=(0x400; 0xc0000000))
  7: r10 = 0
  frame pointer is read only

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 87a2c60d86e6..fbccc20555f4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1668,4 +1668,45 @@ l0_%=:	r0 = 0;				\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("dead jne branch due to disagreeing tnums")
+__success __log_level(2)
+__naked void jne_disagreeing_tnums(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	w0 = w0;			\
+	r0 >>= 30;			\
+	r0 <<= 30;			\
+	r1 = r0;			\
+	r1 += 1024;			\
+	if r1 != r0 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("dead jeq branch due to disagreeing tnums")
+__success __log_level(2)
+__naked void jeq_disagreeing_tnums(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	w0 = w0;			\
+	r0 >>= 30;			\
+	r0 <<= 30;			\
+	r1 = r0;			\
+	r1 += 1024;			\
+	if r1 == r0 goto +1;		\
+	exit;				\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


