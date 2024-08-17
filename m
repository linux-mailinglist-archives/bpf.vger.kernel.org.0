Return-Path: <bpf+bounces-37405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A9A9554B3
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 03:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443181F21BD4
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 01:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65F78BE8;
	Sat, 17 Aug 2024 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGRUbF2L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD8645
	for <bpf@vger.kernel.org>; Sat, 17 Aug 2024 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723859520; cv=none; b=tHfRn7/JB7beA2u+BUPjeHfz4KfT6heUxN76aFyjfNUu3s2Trtpr3B49KlvxcIuiJrhyb6l/m7f9pdfiv+5XaZgaXyHKJoSSBQqIPvXuuZPDAMYzuLJMyP46B6a3QqlSlqc8uBqDUeUi4Y8qQqwlwGo0WRBGaC/jeM5tZDPFgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723859520; c=relaxed/simple;
	bh=eMZcJ+wv1H0JVXNMRl2ZznMxMQ4f7uGxWNJplB6Rjns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqOe5Bb6ZCGNWEHJ2YcdVl/ZgNhdxXevxDLs9OznC4qj6D1lS9III1pmFeyK7+8LskEkjp4nYIylR+peENbluGZPc6w4rlOlajrDk4U2nBnCjbSx1rZXUnTUOfxAn+3vfNj/9xpZ7J0ClusUE/ntUd2gDFDE0QADTjQsrj8qMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGRUbF2L; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db14cc9066so1709675b6e.3
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 18:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723859517; x=1724464317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3a97YRzTAbvR8a09WWdFGAawONuJMtPYPHKqZfZNeMo=;
        b=NGRUbF2Lekt/BWEzg/wunX3PErDeEriCC/34Luzhn+eZ6xcFgzZfIqkhXSfFe5bFZH
         XprqmbeFzyR7KMG02R0AFaNV9O7M8tC61z+l5TO4gP4GXbR1GNYvb/45qQckRotQniWO
         2wfMc194ERnxG/9f+Qx+kzTR7G/otgwtVbhDKcj7ZvdAP9K+5GcHAuPyGjKiqocAyDyt
         +JR1ZbepeJHzTREic1ncqvLSogt7MMPnWP+XHLlFwKNtWsSUhZ54KZ+EVmE2oQs3ww6a
         J9t39FKNfqTaQhMYyx0ZjBro7I6BAcGOk0dLPkT4CL2G+lfHjcaYayJVScVs/AKFJ5si
         k1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723859517; x=1724464317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3a97YRzTAbvR8a09WWdFGAawONuJMtPYPHKqZfZNeMo=;
        b=phTcFPIgQSJ1Rz9yVa2PfTOUkUZzw2JVsCbmQ3/yiu1aNJDCU5WcoIMXEUA4OtDEjk
         LmTHFzGlZx2EFYJEJ6Wv7UZBaPl2xZlh13EjGLiNq9fFRahgxPFpQ2CoHBbI07irUVHg
         zovNd78VUcSABHm2ZcA5GNAh2/XirdbQHsU5bDSFT58C6lSYbcrOHUAgX5IyFnRN68F2
         ZKHXiHr8w0orDaAT61sSVRhAEPTO0eT0cQ/c2hUMN3U7O9+Y/yyc4zulBsSLPHAnD/Vu
         hsXzUYQwiC5iZg/eFpQz70zeSaHkKBMqaL2orFZTrB2iraTSgVNai287qzY4/02uQnwl
         2mng==
X-Gm-Message-State: AOJu0YyHlapOjleAS7hs3lk33otYibIrfwy1pP46M/wHfwhVxgWj9QSZ
	mfkatS19oO42NPbyY8SsFjvhUrKFmNPebuIDBRDdmpphNlD8172zj3vC7UMvpmE=
X-Google-Smtp-Source: AGHT+IFme/NribhGyoogM0/yBMkzKGGp3+aPFDCg9LyeceXn7mlwGSb+UtY3ntk/2GtCM7SwN1ALBQ==
X-Received: by 2002:a05:6808:1153:b0:3d9:37b8:dae7 with SMTP id 5614622812f47-3dd3ad167f7mr5601205b6e.1.1723859517096;
        Fri, 16 Aug 2024 18:51:57 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356ad2sm3598887a12.69.2024.08.16.18.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 18:51:56 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 3/5] bpf: support bpf_fastcall patterns for kfuncs
Date: Fri, 16 Aug 2024 18:51:38 -0700
Message-ID: <20240817015140.1039351-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240817015140.1039351-1-eddyz87@gmail.com>
References: <20240817015140.1039351-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recognize bpf_fastcall patterns around kfunc calls.
For example, suppose bpf_cast_to_kern_ctx() follows bpf_fastcall
contract (which it does), in such a case allow verifier to rewrite BPF
program below:

  r2 = 1;
  *(u64 *)(r10 - 32) = r2;
  call %[bpf_cast_to_kern_ctx];
  r2 = *(u64 *)(r10 - 32);
  r0 = r2;

By removing the spill/fill pair:

  r2 = 1;
  call %[bpf_cast_to_kern_ctx];
  r0 = r2;

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b18a21bb5e6e..5dafcfff729e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16112,7 +16112,7 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
  */
 static u32 helper_fastcall_clobber_mask(const struct bpf_func_proto *fn)
 {
-	u8 mask;
+	u32 mask;
 	int i;
 
 	mask = 0;
@@ -16140,6 +16140,28 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	}
 }
 
+/* Same as helper_fastcall_clobber_mask() but for kfuncs, see comment above */
+static u32 kfunc_fastcall_clobber_mask(struct bpf_kfunc_call_arg_meta *meta)
+{
+	const struct btf_param *params;
+	u32 vlen, i, mask;
+
+	params = btf_params(meta->func_proto);
+	vlen = btf_type_vlen(meta->func_proto);
+	mask = 0;
+	if (!btf_type_is_void(btf_type_by_id(meta->btf, meta->func_proto->type)))
+		mask |= BIT(BPF_REG_0);
+	for (i = 0; i < vlen; ++i)
+		mask |= BIT(BPF_REG_1 + i);
+	return mask;
+}
+
+/* Same as verifier_inlines_helper_call() but for kfuncs, see comment above */
+static bool is_fastcall_kfunc_call(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return false;
+}
+
 /* LLVM define a bpf_fastcall function attribute.
  * This attribute means that function scratches only some of
  * the caller saved registers defined by ABI.
@@ -16237,6 +16259,19 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 				  bpf_jit_inlines_helper_call(call->imm));
 	}
 
+	if (bpf_pseudo_kfunc_call(call)) {
+		struct bpf_kfunc_call_arg_meta meta;
+		int err;
+
+		err = fetch_kfunc_meta(env, call, &meta, NULL);
+		if (err < 0)
+			/* error would be reported later */
+			return;
+
+		clobbered_regs_mask = kfunc_fastcall_clobber_mask(&meta);
+		can_be_inlined = is_fastcall_kfunc_call(&meta);
+	}
+
 	if (clobbered_regs_mask == ALL_CALLER_SAVED_REGS)
 		return;
 
-- 
2.45.2


