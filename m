Return-Path: <bpf+bounces-74832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F01CC66BE3
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45C324E8E5D
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC3D2FF677;
	Tue, 18 Nov 2025 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="ZOHwYFSI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0412FD676
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 00:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427199; cv=none; b=NLWl2k3rbEd/KVOT+4tymsQdNxzjRDAgzhCUCTYgrOvo0In0PqcQWORqa/DdhgGZEMe5mV8dLm4fu7foyWTfrOTsXPr357d6Lj+3NzncWvMBPN7q6uL4NTNv+1kpkTmO+HY44VO9u4SUi5kzg6bugw/L7RXwHyDBkIxVd/bP0P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427199; c=relaxed/simple;
	bh=sNhITglOy0f3+s217bW965fty7mv+b7ZmF/sPBEGWs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ek32/xCMSyphtqWYPUZGln4l8yTIwcOHgs7d7L0D8JCLcA81loYPlVFeHblsMqNtnainTMr4qQp5JwU3372tgej2Bz2sReVkn6Vm/RUxkPHteB/FHKuOHEw2TZIkeWELj7YZD6UJ8yefML/wnIAy79RgkgT5XFeisFOcF8DDQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=ZOHwYFSI; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bd2decde440so58279a12.0
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763427196; x=1764031996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ayb9pPHVUiqszckHV2tH4q+CRDbN82GvMT0+j17xZms=;
        b=ZOHwYFSIHrm5NWfiu2cDoyMMkgGo6gTWtJCuRtU/9S4Jcc0MwkKL5lf22zJJEah48v
         tykOapTq7J3NLVTa4cLiH9ErnFw7u8qR5rk+tq0UG9CDVt0l0iv2HRp2YZbmhxKZCuB5
         mu4cyPka6AwPH3pL8z4MEZBxMrJs1y7qrCfIUXhQB135LRv9gS7+ZnsVf2TMNa9g/sKk
         E0bLjB7OlsXS8YQT86IYFTIOoXxWC9WHOXxGBVqyOStYqMCorttlqm/AP9FaqcRXanVr
         I5YJb4DUtJel+bb8CRque3IDxbJ8zTVwGG4BBj5YQP4BrQTVfWI8ALwA6n+b4Z1EUvZ3
         fOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427196; x=1764031996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ayb9pPHVUiqszckHV2tH4q+CRDbN82GvMT0+j17xZms=;
        b=wpZF1tYtZRPjL21YDvU87Cxs44s9uHH/By3XMgy/vAqeemWaEYwZXGjRYdZfN7TELw
         9kzND16LAToJarHGsxmAFjQbGutJ1nPgG5LCTUWg49+0kvPkxpkaaica2wTpvNCKDr0Y
         kxAAuVmLfCmqGblhPru9PVBHUd110CJ/srahul9WjiR2PssS76l9UQ8gXXE4RxfMLlBH
         hRXfGYagCj+Kg41ItiqPMh81lk33oddfDR+aLytzxUb/2mADi/Muy8hcgqOAyh3P9aPA
         zr+DlUD5Aa9qC5Aq3a05V7QWQTSBkPLJgxoeqnVZxonS5Atp9VnvvEWEGR6N2dor/u73
         uBog==
X-Gm-Message-State: AOJu0YxDx99uMw8QV7tz/Oy8MPGlt/ksgEYv026JcRE7AYo1y3W8Shlu
	5a6hoOypaWHQOfrx1qQWpSSKwL5aCRzuziJcltMTVuYBK2s8T0WTJPyk8leCz4/oeP1ZIbw3fFe
	hFE0/
X-Gm-Gg: ASbGncvbC0OWp+KGUUAAYYYrp4l0i2EeWbLMH8mriJuLrtRZmiDVMl+mRGfTCXPJsBw
	Egy0VLO3M/NPgxVehpQAI4ijoCiFn9IBnhB6USvttTujdrNX/36Re8sgmjfCRpSV/UHB/d4JU/a
	6kYy6DQ5uRWvHulB0SmKgxRpXgblh21sNtFAZN7WJjV3BRRcRCIoxxWR/KNr6roxvA13GGTBCBy
	YdieKHVqjPtKw8K8cdIlZ02bnsRCiw93T2dHzvjQ3MbguT2BzgneqGXqgtdr/JnWAH6BrQBgq02
	/tK/fNrhg3efkKScoIGzjFikzLmNPIB6gB/Y+6yD/m0JApGUyenVywk2/L5BT7pS/NuCXlOCcqs
	iIgBFUe7mWDoymEHtGe70Avx2+AoHhMUNIvdRKG3MvTMWvwyu7L8ZpYfgmz+NakUxjv1EDgZyet
	gsi2xeDs0bTA==
X-Google-Smtp-Source: AGHT+IEUGIODZx1Wfz3Wv6oc+vJ9J5EjB/D861mEHl/oVQT6yaLvmVCdz0ng891OAriQViGzaRdEKQ==
X-Received: by 2002:a05:7300:e885:b0:2a4:3592:cf89 with SMTP id 5a478bee46e88-2a6c984eab4mr335227eec.0.1763427196317;
        Mon, 17 Nov 2025 16:53:16 -0800 (PST)
Received: from t14.. ([2001:5a8:47ec:d700:ef59:f68f:7ffe:54f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d9ead79sm67568555eec.1.2025.11.17.16.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:53:15 -0800 (PST)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: [RFC PATCH bpf-next 4/7] bpf, x86: Make program update work for trampoline ops
Date: Mon, 17 Nov 2025 16:52:56 -0800
Message-ID: <20251118005305.27058-5-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118005305.27058-1-jordan@jrife.io>
References: <20251118005305.27058-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use update_prog in place of current link prog when link matches
update_link.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 arch/x86/net/bpf_jit_comp.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 36a0d4db9f68..2b3ea20b39b9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2956,15 +2956,13 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog,
 }
 
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
-			   struct bpf_tramp_link *l, int stack_size,
+			   struct bpf_prog *p, u64 cookie, int stack_size,
 			   int run_ctx_off, bool save_ret,
 			   void *image, void *rw_image)
 {
 	u8 *prog = *pprog;
 	u8 *jmp_insn;
 	int ctx_cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
-	struct bpf_prog *p = l->link.prog;
-	u64 cookie = l->cookie;
 
 	/* mov rdi, cookie */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) cookie >> 32, (u32) (long) cookie);
@@ -3079,7 +3077,8 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 	u8 *prog = *pprog;
 
 	for (i = 0; i < tl->nr_links; i++) {
-		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
+		if (invoke_bpf_prog(m, &prog, bpf_tramp_links_prog(tl, i),
+				    tl->links[i]->cookie, stack_size,
 				    run_ctx_off, save_ret, image, rw_image))
 			return -EINVAL;
 	}
@@ -3101,8 +3100,9 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 	for (i = 0; i < tl->nr_links; i++) {
-		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, true,
-				    image, rw_image))
+		if (invoke_bpf_prog(m, &prog, bpf_tramp_links_prog(tl, i),
+				    tl->links[i]->cookie, stack_size,
+				    run_ctx_off, true, image, rw_image))
 			return -EINVAL;
 
 		/* mod_ret prog stored return value into [rbp - 8]. Emit:
@@ -3486,6 +3486,11 @@ int arch_protect_bpf_trampoline(void *image, unsigned int size)
 	return 0;
 }
 
+bool bpf_trampoline_supports_update_prog(void)
+{
+	return true;
+}
+
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
 				const struct btf_func_model *m, u32 flags,
 				struct bpf_tramp_links *tlinks,
-- 
2.43.0


