Return-Path: <bpf+bounces-60674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152D6ADA159
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 10:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A13D3B37A8
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 08:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9521B1802B;
	Sun, 15 Jun 2025 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Khyqouh3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFB12033A
	for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749977730; cv=none; b=HXBoPiZJg68/3+nBxr77YTBfsr2ThxbfHiQZSQMiqMrpWI7h4rxall1niI1gyvbooQBR0J68UDGhnBk3MYwGmuZ5j8M+Z/uBSRizzfj6sBxVYXFIydZOgdhEZYZSdPtiHFWMzatAaxU251BdOeQKUrCVMrsgtQAp7C3qetZTMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749977730; c=relaxed/simple;
	bh=2VssHOR09VrWzhL3E98tIRfQYYwYydI2kTaKd1i6q/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=axiAJZ3Sl5aPx8B7/CdIvPcE9OOQGfM2Yz2pgQSKt+bqXvEYVzZGdgCnjBMPfgcM+UjvJKs9PuIuP/krAIfPgKHt7W9oPsCwdkAH43QKGPBk+fjQvkDU/w7pnhKAKNEY3ij3XYD1YZjFHOHhUIT2eQWIyFnxjL5q3he9t15+dV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Khyqouh3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a54690d369so3656093f8f.3
        for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 01:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749977726; x=1750582526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5CDxabimCQ8umTncI/iQ5EL+X68HBEZf8KpK+Gmje4=;
        b=Khyqouh34SiNIs1NLj/PtsV5fB1aUUK+XSNTZgtQvR0n7OlDCEyjrrj1gIv3XQuNaA
         DkHrOHZ3BEwzsaNdabFKQvR8RhcixTWW1b3vqIIwUMbQzBMByJ/165Q1ADX23QIv83HO
         q9O8IlOkew5WuZOW/qKLVBjQ8a7lA9X80mxcPRJ94P5W6miUuhisJD+VZAemDLi57uQn
         nFljrCaianT5FszvdG0xtqCVLzuu/sTP80H7q8VeJE+qxxn78jeuLEbXmDA4Sog7NRFO
         emID7zdjK2yXKTB4BvhVBnGq95NfsxTEFYnTs8IeDZxzAIKTN9SPv7GQtXScCubWt7O8
         SUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749977726; x=1750582526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5CDxabimCQ8umTncI/iQ5EL+X68HBEZf8KpK+Gmje4=;
        b=gF39DWfjQSr+bcuyPdelgHSY671Eb+SBticANfj7X/xiluhHsaiUaqUoobd6gvhDfN
         HhoulHL1ys9jHZhWgU5kSARVs9HJ6SYIvx2kZKsW8JEHz2dh8zmaeyMyjrdrCLi1zeJy
         Jh9OLHsvMVH6Lr1AkucbvNWMZxEjHjuYCpWLR4wpBy1k+uE+HW8Wi3AMYR5W/i+2w9IC
         4FVr6YvX+NuymhhlqgzR2Z29EUIf+vvd1B2BMkBPb0cPm6HB4TnM7ST4cVT70iI3K9GA
         tiOy87XOdtQTRaBfXk3PAkSFcOVo5N4Ykjw+n2+19E6uyO0oi+RVZqPiYzE9MJClYafs
         CPVw==
X-Gm-Message-State: AOJu0YytPB6mCiAC45WZHyP60roOzh90BMQS30GXUUypDsXlTEZW3/u9
	K6WTwTIT0zGfDwmfX3+s23oWcIyBer0dRtQkD5/bfAmpEhYQfXkwsj95yQU04g==
X-Gm-Gg: ASbGnctegzldaf5mdljfhtl28zeqpX5/aM1ZIwVlj7U1DOiBMjyMVQmh9Qcxl7p/jG9
	Udd4h+v24IyeCR7fNZaF44a4GdtPkKrvGFGZMjsqoV8qHEscyujiHdZbMC2UefSWb+hIxRa2ag0
	iBJ5KwqLKK5ER1k9qLvx7djFt1Q+UhnezvFsRptfBrR+ydgyqlFLMFQmvQeEzunglV39897cYXk
	nKXMD/NOXSOvxmHc0x4nwoMxUpBe+1Rv+byBEt2dP89Rxd2H7rNC0mbkhZ9ISTVzrPdudK7SYye
	j9Lg4v+TRhRLaXGxo/qWpdE0U+VqWIgJcdwAwIBbrddiGVpNspk5hFxEaNicpXvyKr8mk4xeVwt
	HRBI+7Q==
X-Google-Smtp-Source: AGHT+IG8qMkh+6HdVSxgiN92HSU9UN6yn8KX0S+QmSLPM4I6xWtTG47J3ysn5PuV47dNV7LyF4Ukmw==
X-Received: by 2002:a05:6000:18af:b0:3a4:f7d9:3f56 with SMTP id ffacd0b85a97d-3a572367e04mr5143250f8f.2.1749977726421;
        Sun, 15 Jun 2025 01:55:26 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a633ddsm7196105f8f.26.2025.06.15.01.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 01:55:26 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [RFC bpf-next 1/9] bpf: save the start of functions in bpf_prog_aux
Date: Sun, 15 Jun 2025 08:59:35 +0000
Message-Id: <20250615085943.3871208-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new subprog_start field in bpf_prog_aux. This field may
be used by JIT compilers wanting to know the real absolute xlated
offset of the function being jitted. The func_info[func_id] may have
served this purpose, but func_info may be NULL, so JIT compilers
can't rely on it.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5dd556e89cce..8189f49e43d6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1555,6 +1555,7 @@ struct bpf_prog_aux {
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
+	u32 subprog_start;
 	struct btf *attach_btf;
 	struct bpf_ctx_arg_aux *ctx_arg_info;
 	void __percpu *priv_stack_ptr;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 279a64933262..98c51f824956 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21389,6 +21389,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
+		func[i]->aux->subprog_start = subprog_start;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
-- 
2.34.1


