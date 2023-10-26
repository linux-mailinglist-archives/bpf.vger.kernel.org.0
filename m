Return-Path: <bpf+bounces-13397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E737D8E5F
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 08:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C132822C3
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 06:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58678C1A;
	Fri, 27 Oct 2023 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZp9mzzB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74D7493
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 06:01:27 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F4F1BB
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:23 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b89ab5ddb7so1696111b3a.0
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698386483; x=1698991283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCu11tyAMn6bcFBf0dU4cUbsZOD9OVnoAoPidBrK0dw=;
        b=iZp9mzzBOubo8YgjeH8lHOyrznCgKAZ0yPDA6DjNEh2FjuItTeCLIKbvRF8t2WRcre
         GlNFAUtoXGNekRSlqVyf9BSlztlHgSGZRp1X9jEgXIyYfWzQBtgreRLr1glbYxrRKDjw
         37aDyY9WAC049JwvO1zOo6lkmAu0O1u2oV4Lk1rs9GwxnFx69GorA1C2oquXulJ4+HO1
         TtohmeDFoKDYLTlBS8KakMx8Z5U4EeeSIJ3DXi+WsLvQUiqdPDkpQfyaCAyWui94J/Zw
         glD+1yBfMAVlbG12XPpk4TvVJWhgLGRnBYyUmZOq3xYfCghsCP/MZTBWlmXfSxGuPdgB
         AB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698386483; x=1698991283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCu11tyAMn6bcFBf0dU4cUbsZOD9OVnoAoPidBrK0dw=;
        b=uzbnpq0X2N3KUWhlGaw2DtY8gXGIGlHot4JgH/bM4AC4k1Cd2p87HgUyPs3BhaLmKA
         harcOb+eDlLdBS7fHqfESdP7G5tp2dY/vxJ6v2fAW/vmKE5qxjXuOX8sLYRijcAo4tyw
         9wgzGDAM0kucNfvVmKl5wL32riZHd8wUGjB4xWjs8+apyvY2NmqWE1dKnB2su1y1oIpj
         wP3WpzXYrEsYeegTHREIOUSHbRcJXgGkmsROs22/X7/Ax2FgH7sr2BFEQkLfvpv7GdLG
         /F/wbkXWSYjvsYM9t8qJr6oo0SQcZr5VnLX1TBqBJXStT0qo1VyJTQypxzUKWVm8FK6u
         9X7A==
X-Gm-Message-State: AOJu0Yy0x/Nn6AEBwu7iKPtfYmJyep+6EHixSxCjbfkEZsyHX1OPhCXU
	BRMMRWe2LpRdNpAipa/B2Dw=
X-Google-Smtp-Source: AGHT+IGuUIL1PqYppXFOJIf0V5ue/O92A5XTGr2JcoGCzUOopOcu/Wji5+fvUJ6YofnaZyw3jB9wpA==
X-Received: by 2002:a05:6a21:198:b0:140:3aa:e2ce with SMTP id le24-20020a056a21019800b0014003aae2cemr2636338pzb.42.1698386482807;
        Thu, 26 Oct 2023 23:01:22 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.47])
        by smtp.googlemail.com with ESMTPSA id z2-20020a17090a1fc200b00277337818afsm1113667pjz.0.2023.10.26.23.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 23:01:22 -0700 (PDT)
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
Subject: [PATCH bpf-next 5/8] LoongArch: BPF: Support 32-bit offset jmp instructions
Date: Thu, 26 Oct 2023 18:43:34 +0000
Message-Id: <20231026184337.563801-6-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026184337.563801-1-hengqi.chen@gmail.com>
References: <20231026184337.563801-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for 32-bit offset jmp instruction. Currently,
we use b instruction which supports range within ±128MB
for such jumps. This should be large enough for BPF progs.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index a8be6d4b058c..050fcf233a34 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -848,7 +848,11 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 	/* PC += off */
 	case BPF_JMP | BPF_JA:
-		jmp_offset = bpf2la_offset(i, off, ctx);
+	case BPF_JMP32 | BPF_JA:
+		if (BPF_CLASS(code) == BPF_JMP)
+			jmp_offset = bpf2la_offset(i, off, ctx);
+		else
+			jmp_offset = bpf2la_offset(i, imm, ctx);
 		if (emit_uncond_jmp(ctx, jmp_offset) < 0)
 			goto toofar;
 		break;
-- 
2.34.1


