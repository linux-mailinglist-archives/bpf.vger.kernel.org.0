Return-Path: <bpf+bounces-9940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC05A79EE5E
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 18:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7159928221E
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208662119;
	Wed, 13 Sep 2023 16:36:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE01FC6
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 16:36:19 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC0A198B
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 09:36:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2740f8d73aeso22690a91.1
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694622978; x=1695227778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYKQUK47vwV52eb/fkGdoNkk5kCGVc8NhmmrYq8GqAU=;
        b=FWTHPKda+wE49Qq1k1oh52vOPROh6P1Bo/k5WZ7RQvs8gNARvff5vwYcwuj7X4c17N
         Hrd76GO9UtZoF73cL9iHA9qLHenu1Fs9YyBDy/KAiAtmjoMvj9bTU6uTjvBJbTI6kpiy
         R+LBajGjX0feFDeWOsozXlfxLcfHnZaqK97QBpKJgSrsTjqZC+dmq5TumfJq4X+BWJKu
         rsbHOPGBZ43AtzrF1JwBQFFQ0ABX2vzQzRIViJBK2IJUbIrKWDLNRGUFkieYkuCeHxzd
         qB6XxpxgpEObskMlsfvQ0vrW0o9dCJ0kL1kQkzrd/r2rE33nkJsyFsS1VHKa7Do2f4ff
         xybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694622978; x=1695227778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYKQUK47vwV52eb/fkGdoNkk5kCGVc8NhmmrYq8GqAU=;
        b=vZrKpIXrt+QWofw0Ie0EwSXiBSR1UXRvExix2M9wGV4BF7RN26B56XKrAM68ufnMu6
         1GRR5yOcZT7j79GmPJT48NqJHMZqs4oo1YQHl9ctkf4n0ZztzHBZshYr5Guv/91iO9jE
         YvsKmUu/ed8aHatETtMkDoHX9PF4w/PVqrJgH7tjBf0zoHJ6KWJUTIRB67FJfjMewjce
         xppWKsI/9jsI9Rma6pCLeKT4nh6uLHMrWiXqbYwWQ24YbnCu+GXpkCPqyXtyFisaDH+9
         +BJHqoccYD91jt/AZywy9/zB3+RosdR0iW5VX+dbDBNs/1ZWWckC1afsPYfypj8owNN4
         QSEw==
X-Gm-Message-State: AOJu0YyLOeppEmBZrEG6HcRZkCLpIGmfGjHUG0sW46dxMO/QTpoxga4x
	EmEsYGcnAdOUNf9BId6AB5TtMLIge4w=
X-Google-Smtp-Source: AGHT+IHQPr2oDozkFswRyoE011UKCbQT8D3inf6xrKtZpgLWTdSU5yDroC/msoYyeg76S37nAuagFw==
X-Received: by 2002:a17:90b:38cc:b0:263:e423:5939 with SMTP id nn12-20020a17090b38cc00b00263e4235939mr2969251pjb.28.1694622978259;
        Wed, 13 Sep 2023 09:36:18 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id hi1-20020a17090b30c100b0025bfda134ccsm1699747pjb.16.2023.09.13.09.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 09:36:17 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tglx@linutronix.de,
	maciej.fijalkowski@intel.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next] bpf, x64: Check imm32 first at BPF_CALL in do_jit()
Date: Thu, 14 Sep 2023 00:36:07 +0800
Message-ID: <20230913163607.25428-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's unnecessary to check imm32 in both 'if' and 'else'.

It's better to check it first.

Meanwhile, refactor the code for 'offs' calculation.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2846c21d75bfa..f06e9a48afe52 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1629,17 +1629,15 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL: {
 			int offs;
 
+			if (!imm32)
+				return -EINVAL;
+
 			func = (u8 *) __bpf_call_base + imm32;
-			if (tail_call_reachable) {
+			if (tail_call_reachable)
 				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
-				if (!imm32)
-					return -EINVAL;
-				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
-			} else {
-				if (!imm32)
-					return -EINVAL;
-				offs = x86_call_depth_emit_accounting(&prog, func);
-			}
+
+			offs = (tail_call_reachable ? 7 : 0);
+			offs += x86_call_depth_emit_accounting(&prog, func);
 			if (emit_call(&prog, func, image + addrs[i - 1] + offs))
 				return -EINVAL;
 			break;

base-commit: e4f30c666b4933dcd140d5110073aa01a69d2b39
-- 
2.41.0


