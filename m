Return-Path: <bpf+bounces-76615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACE5CBED8D
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 17:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEBD23002165
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 16:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CDA32C303;
	Mon, 15 Dec 2025 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="nEqhskbJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810AE32BF51
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815224; cv=none; b=WUrIP6JeqgrPoSGa1o0RyIOD2mfcnsJx0uHvrGV8bTFUrvrg4ZsKwGdPu2Nt7yrALB7/n8kGdlSkZZ3zeJsW46A2jZekDEQuqU2oeoRduuBlXCFEexjNNHV0l2rn/xqrchtITW3Hq7glXN6N9Si8Y6xMMwE1FvXER9JPv5Cx+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815224; c=relaxed/simple;
	bh=NhJMVrjiRFOE0mw8L1o7xuP4X7ieDkv/V2l1KeVVITc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqOCF07JOJxRpXgfl1bHAbCTrXPFoB5/0A73po+DXqdbG7Kx4SYoblcpknvQoyFVWwf6rMIthlOVzJ1/YHItfMfA9iLOvDBaBsYYGmox88mlojWnmaR+sGXWTiZzsQGg+9fckTJzsBJG/cNbvSm3GK4LNUpbb+eiFY78/PfGUYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=nEqhskbJ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b2da83f721so394331785a.1
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 08:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765815220; x=1766420020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHScx3SL8giVDS3u2HIqyy1YgrkKM2cfykQCv8AkPWc=;
        b=nEqhskbJTFvp3+3XBolpI71htyrVxpHfgLkqE1AiMvbEoXIUZb5aJpVTT2d8zIcB7L
         iDeutZVjWk0f74D0+p9wU2oO0WweTUmlZRBC8bCSObwAN0WmQORBpeS9cxYv6jrBDjHP
         l1B2GRSuk2hw6I9qKe49YGhGZ5+gJB10GCFVQrnH4aEezEct85/nU14wlI3Tkp+OmCJa
         K80CtLeQ88wW0eyFvmwTg6n0DKDizS/rZp4N6uMlJ7k8R2QNG0kEaGlb1k7y2/oAmTb3
         ZFwOkwfQ3Zgl6Lvqtdvfk9FzwwvIRGgydQbrFIYSk/XZisYySFCYJpcxKb4fGuYw2n/V
         D/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765815220; x=1766420020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wHScx3SL8giVDS3u2HIqyy1YgrkKM2cfykQCv8AkPWc=;
        b=TTQJdEjMMtUR42MfIcCUJMnMyGsxsx3bWEOLWn9mb2jX/xy6CApPN8BUVWIddQbqGr
         9SryUqbFm90wluHQmI73GQ5FHEUJet4bhotzwH3MYTFqeaHNF1HKwk1Id6GJC6K1S6lL
         s5/66YHBBMHI4sg9v7wRmwxSBt38lIPm+60Rr3zPQUMbSFZ7jfgtBz54CUr6Ho/9KeSg
         kBmkH1JGSmFujgkTRUKpXpZs8hC9Go1SYpZ3uq2VGknQ8TtVOU2xP8WU7/8YtsXz1+Cl
         Kk+7SXm2eECk3xqYR+A95SqmXd1VMMfpc4uVTZxzR/Eon00yh2t/R/3cYQMTgE8IiUwV
         J49Q==
X-Gm-Message-State: AOJu0YzLKZ1Xz8lgZsBvWo8ageZ9YYvdKS+NsT9Dh4tzcu/+unTQUZYl
	kdRshfyhw5ui5Wm84AxNudTRJChJ1ruGyqPRd0x5y9s3LflIj7fh5EavYOyV0C/pCn5R9fKAbfN
	JldM9
X-Gm-Gg: AY/fxX6vhS8P7U8qi3tJwIz07/4ZXSKGf9E5qJxxIjViF5v63i3tzr6xvdrHQbjsaxH
	Rbc9qOp3w+CgX0oj9sQkkFoU3UsJ5Mm/0sDauUEzAy+jyk6f/U8thjCsFSrn1esEeMWlw/fThqb
	XeIXZR1CL4IWJIZrH59I3OMBU8QNFn8mEPgb3ml/UznGWoJgosjaepAVdadJzbSVG3VFQHIC7wd
	xIa5FcJ9gTElbLq1b+LmqYOpSEsC3Vtson7yTRumPR4hsAvCTxa3F7hXQ70KM/Dy6W4risxW+F+
	Ua4wyodjTYm8HQiSc5C3ls/mIRAttQSmzH6CJN9aTrFDKaDbAWxVdIPJ1JFOKuD87u+a66IvQCF
	fJMI9jPuQU6wUvQpPDvBmg1Q0sivpKIDaWA6q31CHZQ0EyFnvSMKONC8fXUj6GgPQwHzTpa8QI1
	KmQHqHJENxaA==
X-Google-Smtp-Source: AGHT+IHeAlPb//tBOT4Q+8A8DZRGF1d878smSDaPfn1ryAo7K5ckGJtNq5Bdk44C6vl8b9huUopI2g==
X-Received: by 2002:a05:620a:4005:b0:8a6:92d1:2dae with SMTP id af79cd13be357-8bb397cc2f5mr1495413985a.5.1765815218345;
        Mon, 15 Dec 2025 08:13:38 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5c3c85bsm1142195585a.26.2025.12.15.08.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:13:38 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v3 3/5] libbpf: turn relo_core->sym_off unsigned
Date: Mon, 15 Dec 2025 11:13:11 -0500
Message-ID: <20251215161313.10120-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251215161313.10120-1-emil@etsalapatis.com>
References: <20251215161313.10120-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The symbols' relocation offsets in BPF are stored in an int field,
but cannot actually be negative. When in the next patch libbpf relocates
globals to the end of the arena, it is also possible to have valid
offsets > 2GiB that are used to calculate the final relo offsets.
Avoid accidentally interpreting large offsets as negative by turning
the sym_off field unsigned.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c7c79014d46c..5e66bbc2ab85 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -380,7 +380,7 @@ struct reloc_desc {
 		const struct bpf_core_relo *core_relo; /* used when type == RELO_CORE */
 		struct {
 			int map_idx;
-			int sym_off;
+			unsigned int sym_off;
 			/*
 			 * The following two fields can be unionized, as the
 			 * ext_idx field is used for extern symbols, and the
@@ -763,7 +763,7 @@ struct bpf_object {
 
 	struct {
 		struct bpf_program *prog;
-		int sym_off;
+		unsigned int sym_off;
 		int fd;
 	} *jumptable_maps;
 	size_t jumptable_map_cnt;
-- 
2.49.0


