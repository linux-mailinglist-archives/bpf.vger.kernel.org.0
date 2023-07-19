Return-Path: <bpf+bounces-5232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99420758B06
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 03:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7B31C20E8A
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 01:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BCE17D8;
	Wed, 19 Jul 2023 01:50:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16417C8
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 01:50:26 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC45F1BCD
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 18:50:24 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-765a5b93b5bso577956985a.3
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 18:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689731423; x=1690336223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I89MHVoZ+gnDdKXkyd7yq763VTrh2CwmUSASTUm6jws=;
        b=dajJy/NCNaTafYmwQAMJ8D5RxXgzWnJ5fAMwf4CVmahveOu+gr8TSEBXiRp3JpnneQ
         gM3DWpG5xllf5zwak2zhtELpdYC2Y04PugOd/Bsfjly1jBj/nKN5axUxg1CcHjqZZJg1
         oXT+rHPTC2Gfnr0pT6ekhzI0rpXz+G30cQ2G6Yx6OFbjyV46liMQhQ/ywjaEcSJXxAOE
         EpcM8tpB3wS4s7atkP6Faz8/F+pkypH2TxZLF67JFRYSMWeWSb58lbhMkfS7ThTrajVQ
         e+JXsKzidMP7JvVkBzGenpYvd4lo7YjFkcMDjtahgOFPl39T4KtHT9yIUf732You8Rof
         M8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689731423; x=1690336223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I89MHVoZ+gnDdKXkyd7yq763VTrh2CwmUSASTUm6jws=;
        b=Md9VpmzdFztxtB/hbI7TraaNhdZtX35+FuBXhL/4Ivo6C7+9oGO+GomjEnmZES2r0M
         /118hZYttaBtSYmHa3hFjERBOF+Db0WBvwVQUbcV/0tOzJT37qkAhId8cnlYNEeQC4cF
         lDrutc/2216AbaROmP0gSgqO6NriFaPk5Xzds6egBTp2FXoYwtMXAMp/B6SNN6utTKUI
         Z0N2/kkH62lcf3ZcFEjm3JzzYYJmmvjNh2uc0GRAyt7KBF5pfrC4oCou9CZGAHYpzU/l
         +Sr+pE4ytNNq9/zHOU08Eees2XnZGZDaNWePydWBe6t+f7XAqUGmKClkWgi8NmTR+GkR
         5YOw==
X-Gm-Message-State: ABy/qLZF6oPoHhOJNjJYEX3Jz/Spc7r3qMdZHygh1brcFGmA29g1aRwq
	HBj07bVfhfEEbchOJg8NR3AWlqIN+vZsww==
X-Google-Smtp-Source: APBJJlFARBWppk2URJVhG+xOvNqboxtIjZTwae2BLEiR094K9g1rDLSJRuZeff81u91YHZ9FusNcbg==
X-Received: by 2002:a05:620a:47b0:b0:767:2aca:7641 with SMTP id dt48-20020a05620a47b000b007672aca7641mr17674947qkb.52.1689731423444;
        Tue, 18 Jul 2023 18:50:23 -0700 (PDT)
Received: from pc.tail5bae4.ts.net ([71.125.252.241])
        by smtp.gmail.com with ESMTPSA id e27-20020a05620a12db00b00767cd764ecfsm59869qkl.33.2023.07.18.18.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 18:50:23 -0700 (PDT)
From: Andrew Werner <awerner32@gmail.com>
To: bpf@vger.kernel.org
Cc: kernel-team@dataexmachina.dev,
	Andrew Werner <awerner32@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: fix ringbuf benchmark output
Date: Tue, 18 Jul 2023 21:47:45 -0400
Message-Id: <20230719014744.3480131-1-awerner32@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The headers were confusing.
---
 tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
index 91e3567962ff..8dd97f5108f0 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
@@ -6,12 +6,12 @@ set -eufo pipefail
 
 RUN_RB_BENCH="$RUN_BENCH -c1"
 
-header "Single-producer, parallel producer"
+header "Single-consumer, parallel producer"
 for b in rb-libbpf rb-custom pb-libbpf pb-custom; do
 	summarize $b "$($RUN_RB_BENCH $b)"
 done
 
-header "Single-producer, parallel producer, sampled notification"
+header "Single-consumer, parallel producer, sampled notification"
 for b in rb-libbpf rb-custom pb-libbpf pb-custom; do
 	summarize $b "$($RUN_RB_BENCH --rb-sampled $b)"
 done
-- 
2.39.2


