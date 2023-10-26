Return-Path: <bpf+bounces-13396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9F97D8E5D
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 08:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0F4BB2129D
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 06:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3DE8C01;
	Fri, 27 Oct 2023 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN62+KP6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3663E881F
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 06:01:22 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F9A1B2
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27d45f5658fso1482894a91.3
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698386479; x=1698991279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zelpIOoWAgGbxFR3NcYgOUoojFa9hIieRbhvyFBjF8=;
        b=nN62+KP6yHpv3e74JnCzeL9/MsBs7ZFrsv9Yu5FQfXSnMtwXXZOHPb5qkY/xYuR7g1
         2UPvHBPKwS1KHMOI31rfcu2JuI+Fj3NPxeD4J+Z+BpPQgv3ASZ1bmAiI9sHucBb6PtEU
         m/6JKLnn0AVQbn3w4Nx7OK4IvTqViftHKUwDtUOHlvwb5YI2RF1u8i7mnk+TPQ4z0lrx
         Yiq2zgnHy4osYfa2HZttwFkJxXelbaOb2W1SZPo1gA5fUdXrg7qK1oxhMGVNQ0U9Whwu
         ShrhQ3EWdUQx8OVYPEJl/aNiERD2WunTM32o7bD2MirdapSUXRu9M32xM8SG+szwiQb7
         kf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698386479; x=1698991279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zelpIOoWAgGbxFR3NcYgOUoojFa9hIieRbhvyFBjF8=;
        b=U6qawUeG/9TTEACGFcD1K2wbcHPgFaRycKrW75qK/wzOfVfXB90OCygMyxgl5hrmer
         t2xxnI4fN0zz6aXyyxNQuctdrGEjp1sFB6P4PecNsyIncNYLBFVFxHJSjARv1mnwOli2
         v7eRhBkaQEi4MlaQWZuzdmjeCpXGByoUY5iwBtQ+Ne4LQ4YqGulUtHlB/thmw60C2aMA
         jUadnDfhbikltgzrzhFUps5iUvwnEtXtr0itCQOF+h1WHfQZ3U/tGCcV6p4eZ/0tJ4ll
         k+e/wD6M8t5hJl8c94Scs5EhQoozzZOkZ+jJ1Q3igJMIvsf05mrazQgrXRtqlsHtFLPD
         zvOw==
X-Gm-Message-State: AOJu0Yx0XPy7sEn0en+sfDA14KNSgi7gpcKwlWBOCNiU2cY3/VMLGEhF
	WGD+VrVxPT5KGVhFci8X5uE=
X-Google-Smtp-Source: AGHT+IGbB6lqmvFnNAP3CD23VIw7yN0hIQByt8lNkGolnRtThjkjKWvfJvwwOVugZSO/BXqfROSkmw==
X-Received: by 2002:a17:90a:1a50:b0:27d:3ed2:86a5 with SMTP id 16-20020a17090a1a5000b0027d3ed286a5mr1572448pjl.33.1698386479701;
        Thu, 26 Oct 2023 23:01:19 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.47])
        by smtp.googlemail.com with ESMTPSA id z2-20020a17090a1fc200b00277337818afsm1113667pjz.0.2023.10.26.23.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 23:01:19 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next 4/8] LoongArch: BPF: Support unconditional bswap instructions
Date: Thu, 26 Oct 2023 18:43:33 +0000
Message-Id: <20231026184337.563801-5-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026184337.563801-1-hengqi.chen@gmail.com>
References: <20231026184337.563801-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for unconditional bswap instruction. Since LoongArch
is always little-endian, just treat unconditional bswap the same
as big-endian conversion.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index ac9edf02675c..a8be6d4b058c 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -731,6 +731,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		break;
 
 	case BPF_ALU | BPF_END | BPF_FROM_BE:
+	case BPF_ALU64 | BPF_END | BPF_FROM_LE:
 		switch (imm) {
 		case 16:
 			emit_insn(ctx, revb2h, dst, dst);
-- 
2.34.1


