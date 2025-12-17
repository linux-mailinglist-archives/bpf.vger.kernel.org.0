Return-Path: <bpf+bounces-76851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1882ACC6EDD
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 10:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EAB2306DC8A
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 09:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5D133EAEA;
	Wed, 17 Dec 2025 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um7d+U3u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E18133ADB3
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965336; cv=none; b=gHFVcGMg+OUZAuydUf8uaOuTCx5cVcz0t3SZlWQkRLJ0jgKfkruea1hbIAYg2Juzu2LEVFB6xXGUe8XAZlZiUkmmdXJnZev389HZfBenS/MRZeOBY18vEGDdWAO6nj/Vp0tdUhuDI9UykysYTYnNeDA2eHywbDZy6ljjeyjrg+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965336; c=relaxed/simple;
	bh=OJ+pmI+L2FN9LNa/GQ8rbcja6XaPYSuA8kA30fwb/sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDWfKJ8Rp6D9cV1nHq9ZZx8CVMoWHZkperBlPRduJsVNMvPw5/0OcLYQwk1UCHHNImdDsaeC+4fsu6PKupejP9diSZNBHmq3u+rYW5YW6IesS23heErTHbnxuahEJgJuTbg/6oXMZhFfyesiySl8B844aaxSlhWKxiKZI9pm8Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Um7d+U3u; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0d5c365ceso43631315ad.3
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 01:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765965333; x=1766570133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7ajHfBTTsej1M2RhwUNhnzHgFKm/6J2aHc6UMKkyQU=;
        b=Um7d+U3uWl5SYeKkDDoJIq2cnbVipGwOTFLm5gmF3jvW+Fq/EttGoefVrXTrsXThfw
         QwqQM9GdpF31ayFFqOBUqokVXB4t2yKkVXFSIGcoanl8oXgeTSjscuNcQ7O94kKIYqiz
         5c3lbMvwTAi50BtBZGRdP4mssHe7lx2EGIJ/BDPaWLZhPAoQjwQIYxHR5hs/ErqZLfrg
         ZJ9OyTlsZtdJSNLHmODSw06gSRk9zcE+UE0oN7/4uL8aQRIBWhtkPME/VPZVBb5+CaNl
         71AZbIgKc7KGGX+dth+wVYWyhzN9X+8Zm8h4qRl/y1+YwqUPzkD31INrGeALd422vKDU
         G+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965333; x=1766570133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m7ajHfBTTsej1M2RhwUNhnzHgFKm/6J2aHc6UMKkyQU=;
        b=XNGh5TlmrRfmDaK8k/btPRUfPqmrL7i+IPAZ9119+rJiXJLqbPrl1nhWwpD/w5B571
         gX3PS0uU/yaqy0hedZAEXWZ13PXo8ByFf3IHQ7VwlUhH8wFIdw1InKKTkoc3EPhDX4dx
         TpAZilkuIIrTbYc9TGzM6mJU93un7vQD9jrtj/OLFBRmKh6tUHKrHk3mf+ul7VLfUU+H
         S3xPkBoPcoYZMwjl2dRZTF3Fvswq7gDjoHUb5hdMTNqH6IDJz7iHvPw2uV1uzfOdRLfB
         YAptHGjt+pj5X83g3bXNVsBnN2lwjfRglVhHxUhZusUU310VX2jG+ZKVnJyklEO3KfVI
         2rWw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Fh8CSXSyeK4rqlrtpLkPqL1q+7QuF2svxPFpVc8tl5ej54lJhEylQH5SITDvYyiYCsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdsl7Qj90YpZe6h//wfzHoPxKY1Beytl2qa51WwD5T/JH7Itfk
	KcoX8ssvW4xcZ4Il9Y/VqBp13QjNdJLb5lbS1XFUlZ6AcHGfNg91UzWx
X-Gm-Gg: AY/fxX437AFKZz3SaL6hzpEiTI07+rq5W3okRFhkB00i5kywZVCYUBfozfo7zNnq2EI
	CCmI8GZGQaZC3+tlS7lFqkOqjYQFfpmi/oBDQ5JiL/tbIfXVP92alEhBV4iwYBOAHQI8Hql3y/e
	4SSTFYGbucXZx+K3Q7tQyS8NlION0UBqaS37orqrRrIN0ncP0ubbKQMRvH9NcLBBkXx15qPWu1y
	hpPlGXe550j4uHyVUANbt89W0EABRCzVo55iU+vOoVUqtP/DF1jNMNs4n6ab0u1PZFNCu1hqNwr
	MzSvSdut5BikP4yrZHlN9+NVIJOZvd8PACYy+/sz7S7/gDipwBO8nff9DiNRPXvAjtJz9YnbNJD
	NLyNHYghim76cCKkv8p+4vMtlyAtnBvxk8rpokyVXeTnVJFfpqG04688Aiw2DmkPvmgXRVcOUWw
	aDLHAU/zU=
X-Google-Smtp-Source: AGHT+IEWPBto4teSaddmB1eqJXnA1IXD2xBXoEGQddliKYYXcy7uKp4BcIOhpNQZDsftssScJ+vVfQ==
X-Received: by 2002:a17:902:f54b:b0:2a0:8963:c147 with SMTP id d9443c01a7336-2a08963c3fbmr154947065ad.45.1765965333540;
        Wed, 17 Dec 2025 01:55:33 -0800 (PST)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a07fa0b1aasm140715945ad.3.2025.12.17.01.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:55:33 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 6/9] bpf,x86: add tracing session supporting for x86_64
Date: Wed, 17 Dec 2025 17:54:42 +0800
Message-ID: <20251217095445.218428-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217095445.218428-1-dongml2@chinatelecom.cn>
References: <20251217095445.218428-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_SESSION supporting to x86_64, including:

1. clear the return value in the stack before fentry to make the fentry
   of the fsession can only get 0 with bpf_get_func_ret(). If we can limit
   that bpf_get_func_ret() can only be used in the
   "bpf_fsession_is_return() == true" code path, we don't need do this
   thing anymore.

2. clear all the session cookies' value in the stack. If we can make sure
   that the reading to session cookie can only be done after initialize in
   the verifier, we don't need this anymore.

2. store the index of the cookie to ctx[-1] before the calling to fsession

3. store the "is_return" flag to ctx[-1] before the calling to fexit of
   the fsession.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v4:
- some adjustment to the 1st patch, such as we get the fsession prog from
  fentry and fexit hlist
- remove the supporting of skipping fexit with fentry return non-zero

v2:
- add session cookie support
- add the session stuff after return value, instead of before nr_args
---
 arch/x86/net/bpf_jit_comp.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8cbeefb26192..99b0223374bd 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3086,12 +3086,17 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_links *tl, int stack_size,
 		      int run_ctx_off, bool save_ret,
-		      void *image, void *rw_image)
+		      void *image, void *rw_image, u64 nr_regs)
 {
 	int i;
 	u8 *prog = *pprog;
 
 	for (i = 0; i < tl->nr_links; i++) {
+		if (tl->links[i]->link.prog->call_session_cookie) {
+			/* 'stack_size + 8' is the offset of nr_regs in stack */
+			emit_st_r0_imm64(&prog, nr_regs, stack_size + 8);
+			nr_regs -= (1 << BPF_TRAMP_M_COOKIE);
+		}
 		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
 				    run_ctx_off, save_ret, image, rw_image))
 			return -EINVAL;
@@ -3208,8 +3213,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 					 struct bpf_tramp_links *tlinks,
 					 void *func_addr)
 {
-	int i, ret, nr_regs = m->nr_args, stack_size = 0;
-	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
+	int i, ret, nr_regs = m->nr_args, cookie_cnt, stack_size = 0;
+	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off,
+	    cookie_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -3282,6 +3288,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	ip_off = stack_size;
 
+	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
+	/* room for session cookies */
+	stack_size += cookie_cnt * 8;
+	cookie_off = stack_size;
+
 	stack_size += 8;
 	rbx_off = stack_size;
 
@@ -3372,9 +3383,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	if (bpf_fsession_cnt(tlinks)) {
+		/* clear all the session cookies' value */
+		for (int i = 0; i < cookie_cnt; i++)
+			emit_st_r0_imm64(&prog, 0, cookie_off - 8 * i);
+		/* clear the return value to make sure fentry always get 0 */
+		emit_st_r0_imm64(&prog, 0, 8);
+		nr_regs += (((cookie_off - regs_off) / 8) << BPF_TRAMP_M_COOKIE);
+	}
+
 	if (fentry->nr_links) {
 		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
-			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
+			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image,
+			       nr_regs))
 			return -EINVAL;
 	}
 
@@ -3434,9 +3455,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	/* set the "is_return" flag for fsession */
+	nr_regs += (1 << BPF_TRAMP_M_IS_RETURN);
+	if (bpf_fsession_cnt(tlinks))
+		emit_st_r0_imm64(&prog, nr_regs, nregs_off);
+
 	if (fexit->nr_links) {
 		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
-			       false, image, rw_image)) {
+			       false, image, rw_image, nr_regs)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
-- 
2.52.0


