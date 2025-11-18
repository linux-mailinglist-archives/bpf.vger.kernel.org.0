Return-Path: <bpf+bounces-74833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DECAC66BE6
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50CFA4E981A
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FE2304BAB;
	Tue, 18 Nov 2025 00:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="ejcojN4F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ABC303A19
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427202; cv=none; b=WlMB54I5a5/F7r9nD1N+H9wO7Qqzrw8n53weSd2DnerHrB5brUmE6EWF+I6f+gK+mOgLypggeY7Z4xf6u8Qk1ONI0OJy7YE7HdUtI0tJu8J1XxVH+w2lq/gR01xbcdgHUiskupHrjPff0imBHOXwonFgurVJdJC+pjquKZzw1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427202; c=relaxed/simple;
	bh=Zrn+p+qMGfDRzIJWvVmHVzhZ6SSP7NOvxFXyyl7qG2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYbfst20+VjxomXncvaa20xwD+1JlzQcWp3egvpcarGVLYhV0gk56c21V3F6gaJQKKdu/OsUIm7A6xXIXmDsH3VTWQ7QE2pftdaMCsudpkjc0xs95z2v+aoN1J2B3wG4YwX+l0yRPXis//wwIyquo/Q2A7zIYzLWMY6vWo3nbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=ejcojN4F; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bc07266d011so158941a12.1
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763427198; x=1764031998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRmr4TJaLT4TSx3gKS19LTLI3SYTE0KLtbCqYCLL0GM=;
        b=ejcojN4FSv3O6+gXg4aObDniJCU826oFcxlcxhxuHO1lXUMKcDe1eweb8mAQhZIfH1
         X65my+G0z9ZRRHCP0UVxgrD0F04B3LT1apOp6JMg3Wqr+J7SERFmeCogx0cwE4w4Is0m
         TTw0hR+0WO3jJ8tmyslRqubZqLR2w/ZEActfr7ioSlUsy2g5iqtd4k2ItcZqoGPkMxfU
         8OfcRR5AQYAnGYxxibHUgi4nzpgpkUrrTs409RQpHl2pVWq3l5VeBpJdqqAI2wCALisX
         p/RbbIHoY5xwfe55BZrjoc73aRq8yWGTULHKJ+kWy1larwnzOfuPhphsxe6pABWEqNxw
         clEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427198; x=1764031998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRmr4TJaLT4TSx3gKS19LTLI3SYTE0KLtbCqYCLL0GM=;
        b=upJbrUw/v3cqejRh4J/8ivA8wiFRHvu2vMAAUn+zWU2LT1fLz9dQBLwF1EcbX3EDTF
         5usu6cWr9A8lmfdE9MHeR9NEoJAnGRx7dnKFaeWDRT/6QdHkRIXNYtfFu1SopxoOTiLT
         UKfEHI12OlXkLLF0xjjczINuxgWGSfvMiK8rkvDNKWzllPZ6fgdsNbkHBbsTXgK1EnIZ
         VtS0d/2JuM1EuR7yU4/Rs6pTm+9Qlrlc2cP+MtOJVhZA8o13fvhsRZiaZ5jTGcflIMTH
         sRg9f2CAGHLwh6zhF1lMvaSMeJhi7gUUhl2rNV8UVos0iorQBMt+ZxzlVlzUBHBxZHYO
         WejA==
X-Gm-Message-State: AOJu0YxUSf/6f8GP+YBlT63Hba2PMnXewCvIxkKuvo24zPlItIBd8TGI
	PxM6aPHsjB6o5SODn1QnN6jNVbuolbRUzSS3annWyL2AGSxqdLtktBznzBoGdZzooNIzoU0LU8y
	z2BvP
X-Gm-Gg: ASbGncv6haaQCXw/DZUPNSZ3eDwJhi0APG4ORsnUmBCUw7Ne00qTug4dtRUwYuph4E2
	Zw2GNTM3GuVWGahFtknwbRTvm7JKopq8GI5WC5trwWj3cUtAxZs5kDYZ+kt7UwKEkuRiq3tXh/f
	8kVe1co8EU+cr/HuURP065x5aqATqkoGW+L5YOD+vL6uJ5kpEKYLxLZhlbHEmyCuNRDdAEn6QOc
	TCRAnT6UcIsP2577fekw819/d6kHn+g7FEpXvNiNtIZpcYtXckZ+FSXShBWOwpfkNfzuR98ZJQf
	2xPVEOFP15yYBuPrZrMEDimf71ivSQFyOoQsjL0qbSiAb+K5JGzxe209vJY13GR/AwqgsEoAed0
	eh8mcuEW0XfPnCjkzUIv1h3eb56XqJjZXCOYnZyxyRYzjgslWwHA9MQlkGISTHfrCGoST29xFD9
	I=
X-Google-Smtp-Source: AGHT+IEO1zOxdD8wQil2LI5KwSO8MQLnWTrfWuipBo+pWWrpf29yptHnZPtimYMHyz4mxlU81XpbqA==
X-Received: by 2002:a05:693c:408d:b0:2a4:3593:2c07 with SMTP id 5a478bee46e88-2a6c985b102mr366146eec.0.1763427197571;
        Mon, 17 Nov 2025 16:53:17 -0800 (PST)
Received: from t14.. ([2001:5a8:47ec:d700:ef59:f68f:7ffe:54f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d9ead79sm67568555eec.1.2025.11.17.16.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:53:17 -0800 (PST)
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
Subject: [RFC PATCH bpf-next 5/7] bpf, s390: Make program update work for trampoline ops
Date: Mon, 17 Nov 2025 16:52:57 -0800
Message-ID: <20251118005305.27058-6-jordan@jrife.io>
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
 arch/s390/net/bpf_jit_comp.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index cf461d76e9da..bf70302d1009 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2508,20 +2508,19 @@ static void load_imm64(struct bpf_jit *jit, int dst_reg, u64 val)
 
 static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 			   const struct btf_func_model *m,
-			   struct bpf_tramp_link *tlink, bool save_ret)
+			   struct bpf_prog *p, u64 cookie, bool save_ret)
 {
 	struct bpf_jit *jit = &tjit->common;
 	int cookie_off = tjit->run_ctx_off +
 			 offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
-	struct bpf_prog *p = tlink->link.prog;
 	int patch;
 
 	/*
-	 * run_ctx.cookie = tlink->cookie;
+	 * run_ctx.cookie = cookie;
 	 */
 
-	/* %r0 = tlink->cookie */
-	load_imm64(jit, REG_W0, tlink->cookie);
+	/* %r0 = cookie */
+	load_imm64(jit, REG_W0, cookie);
 	/* stg %r0,cookie_off(%r15) */
 	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W0, REG_0, REG_15, cookie_off);
 
@@ -2768,7 +2767,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	}
 
 	for (i = 0; i < fentry->nr_links; i++)
-		if (invoke_bpf_prog(tjit, m, fentry->links[i],
+		if (invoke_bpf_prog(tjit, m, bpf_tramp_links_prog(fentry, i),
+				    fentry->links[i]->cookie,
 				    flags & BPF_TRAMP_F_RET_FENTRY_RET))
 			return -EINVAL;
 
@@ -2782,7 +2782,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		       0xf000 | tjit->retval_off);
 
 		for (i = 0; i < fmod_ret->nr_links; i++) {
-			if (invoke_bpf_prog(tjit, m, fmod_ret->links[i], true))
+			if (invoke_bpf_prog(tjit, m,
+					    bpf_tramp_links_prog(fmod_ret, i),
+					    fmod_ret->links[i]->cookie, true))
 				return -EINVAL;
 
 			/*
@@ -2850,7 +2852,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	/* do_fexit: */
 	tjit->do_fexit = jit->prg;
 	for (i = 0; i < fexit->nr_links; i++)
-		if (invoke_bpf_prog(tjit, m, fexit->links[i], false))
+		if (invoke_bpf_prog(tjit, m, bpf_tramp_links_prog(fexit, i),
+				    fexit->links[i]->cookie, false))
 			return -EINVAL;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
@@ -2946,6 +2949,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	return ret < 0 ? ret : tjit.common.prg;
 }
 
+bool bpf_trampoline_supports_update_prog(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_subprog_tailcalls(void)
 {
 	return true;
-- 
2.43.0


