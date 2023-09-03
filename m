Return-Path: <bpf+bounces-9157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EE8790CB9
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 17:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F49D280F81
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548D53D92;
	Sun,  3 Sep 2023 15:15:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297FD3D81
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 15:15:34 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D9310E4
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 08:15:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a3cae6d94so614453b3a.0
        for <bpf@vger.kernel.org>; Sun, 03 Sep 2023 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693754101; x=1694358901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwTt6bTsElcFaLllQU3Hvsx7Yta+HwnMn6jcrhvLCBw=;
        b=pOZ7YDTX7QBZVB2wjzhrNu9wcy05gHgtwXBs+mKv6rQpbF3bk1ZeWL9KwCt1U385Ts
         FdzUFyv2zO0up9tzPuNvFusfdxGvfBe8tubs2fEx4mzx5kcmh9OevEtrf3ZygSB+tSWp
         xDWlm1udIDD08sKvYe6Ob8sLI7CIVQV+bYI4GGV3+aS0wNg487zsZcj7llH/3QIM7Kz/
         iQCW+AXbywx07pgGvgWVoGjruZLV7l1CZ6UVK68t08Zw29U2cWr8W3GRo9nx8Mb+Uukg
         gKtZAUKMe0AMsYHWXRLOYg+dVnlJb7KYaOCc1PX6gT6DKCHXPH/CWxUNnMRU6Wih/LZy
         Dfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693754101; x=1694358901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwTt6bTsElcFaLllQU3Hvsx7Yta+HwnMn6jcrhvLCBw=;
        b=ke1NLD7rBttbtb0xNT/hTWn6AQoyLCzmfMfgSaQnXL9rUm3bGplNvvKwb3RzBG4bke
         R90f4vRQMyXdvFGryAF3n8AJpDLynlbJi6KEE9KseFNzzs6ip0D4xWGL6I2Oczn6bryG
         sSdqQXberlLkpKCUMf1vdB/soWbR7n/KDPnRGBc/xklw7dRLsqf0rRx1NP+epX2YxWcv
         kB5ztOTTjR87YJ2iGBC/p8Pk/DaZjsO3OUaGvwgNnXqm1C2mlj9S3vYV7QwABk6DUvlf
         17oA0eH4DqyPlU5bclO06NW1YCGth4xuvb75fhNK0hxaD9k0FoFwhCO/hPUFLN20jmTW
         eZqQ==
X-Gm-Message-State: AOJu0Yz0rpriz1fVyxqeKzFviCt2U7N7vUPaW0tm+OuGFQ9fTBNLOjuy
	qPlv0GOumuIbPQR+OAsy5Bc=
X-Google-Smtp-Source: AGHT+IGY50dM9f30f8dyaLW0+1qaYnn3htcyoIlDrqi+3ycg9lo1cQsQ8eDaDKyboi5q6O6L/0n7lQ==
X-Received: by 2002:a05:6a00:15c9:b0:68b:dbad:7ae2 with SMTP id o9-20020a056a0015c900b0068bdbad7ae2mr10912507pfu.21.1693754101376;
        Sun, 03 Sep 2023 08:15:01 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id x17-20020aa784d1000000b00686940bfb77sm5882268pfn.71.2023.09.03.08.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:15:01 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com
Cc: song@kernel.org,
	iii@linux.ibm.com,
	jakub@cloudflare.com,
	hffilwlqm@gmail.com,
	bpf@vger.kernel.org
Subject: [RFC PATCH bpf-next v4 1/4] bpf, x64: Comment tail_call_cnt initialisation
Date: Sun,  3 Sep 2023 23:14:45 +0800
Message-ID: <20230903151448.61696-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230903151448.61696-1-hffilwlqm@gmail.com>
References: <20230903151448.61696-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Without understanding emit_prologue(), it is really hard to figure out
where does tail_call_cnt come from, even though searching tail_call_cnt
in the whole kernel repo.

By adding these comments, it is a little bit easy to understand
tail_call_cnt initialisation.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a5930042139d3..bcca1c9b9a027 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -303,8 +303,12 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	prog += X86_PATCH_SIZE;
 	if (!ebpf_from_cbpf) {
 		if (tail_call_reachable && !is_subprog)
+			/* When it's the entry of the whole tailcall context,
+			 * zeroing rax means initialising tail_call_cnt.
+			 */
 			EMIT2(0x31, 0xC0); /* xor eax, eax */
 		else
+			/* Keep the same instruction layout. */
 			EMIT2(0x66, 0x90); /* nop2 */
 	}
 	EMIT1(0x55);             /* push rbp */
-- 
2.41.0


