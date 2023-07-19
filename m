Return-Path: <bpf+bounces-5381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45331759F98
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 22:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0067280FFC
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 20:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8CC22EE7;
	Wed, 19 Jul 2023 20:22:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1261FB5E
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 20:22:02 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C401135
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 13:22:00 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7679ea01e16so7335285a.2
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689798119; x=1690402919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ETOEjXx+6pumR+iQsKygYInTPjKbnAHEO9snffbCFZI=;
        b=h4D6VzTKXIXelOcUcgNDBd3g8YZ/gNx5zGpl1EaSY8wk4ettY4pIGWZ6u9qof0n6ER
         ocVt9qKRfsos++dmHUUcr4wMaclCTGQfKPC8xtB8m+6hVLu+LyqhwTqSvSgrdtOcgp9K
         G62KJQs55re9ThuKs6ObyhWTYhEvIPDLvf7Rn/aD81g0vDtgiJIA3nATXu0DklcbI+y+
         YqLH4uuPxcCea/3jCRPM02ikuLLmrSCEAupojFtlyG7UTyDd43t28u6Fvu+n0GLHZg0Z
         6SfaEovmoFe4vu+NcDtUbiQ44Xkzr2hANwHHltceiUMY1dBPGtbvlS2Vm5wJYdbnvtsk
         WHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689798119; x=1690402919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETOEjXx+6pumR+iQsKygYInTPjKbnAHEO9snffbCFZI=;
        b=ZG0CSCabsZiD4Whj86lUZxa/fJ77cuRgDVgOVyQ9N7k7cpMsGYfHZr3DEu8uXwCxSE
         bCy5pDIVHFrQspi6pI/YWoZE2UluNoNzVMAWpXcAfbinLggC4wdJO2iHZCwm1gw1qkL9
         qD7IX4VSS5UTkbOpua4KK1YmPOTPAqy1GRnTzQugoNRHcvJEqMC7UH3mqd+sr/b3YlSa
         Vl8k2LGRUE12ow8qBfwMdSMnCK7q/XRSDNs0fHNqTmTPzwPiR0bAmOLOTUkMQK/s/03U
         YRTpuKv/97Ml7IurMiwYN2dApy50PXz/DL5K+K3WxYVrflmcp51ljMOkTXoUaxWflMCL
         imtQ==
X-Gm-Message-State: ABy/qLZeYNFKdymnWKZX2lm14q1SUckbSiHcudx27ObCeSLW/zbd06vY
	pS5RaPtsqzx2XzPSircsHhIUcqTgH+SGvZK8
X-Google-Smtp-Source: APBJJlEjs29pmfR0clmwy3HtG4OOZznykANNZehezCBP/QUZ3skIGKP6FH0PW9S2Y4SIpPqQNbLl1A==
X-Received: by 2002:a05:620a:8ec6:b0:765:73e8:da9b with SMTP id rg6-20020a05620a8ec600b0076573e8da9bmr469247qkn.78.1689798118851;
        Wed, 19 Jul 2023 13:21:58 -0700 (PDT)
Received: from pc.tail5bae4.ts.net ([71.125.252.241])
        by smtp.gmail.com with ESMTPSA id m18-20020ae9e712000000b0076825e43d98sm1491648qka.125.2023.07.19.13.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:21:58 -0700 (PDT)
From: Andrew Werner <awerner32@gmail.com>
To: bpf@vger.kernel.org
Cc: kernel-team@dataexmachina.dev,
	alexei.starovoitov@gmail.com,
	Andrew Werner <awerner32@gmail.com>
Subject: [PATCH bpf-next v2] selftests/bpf: improve ringbuf benchmark output
Date: Wed, 19 Jul 2023 16:15:34 -0400
Message-Id: <20230719201533.176702-1-awerner32@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The ringbuf benchmarks print headers for each section of benchmarks.
The naming conventions lead a user of the benchmarks to some confusion.
This change is a cosmetic update to the output of that benchmark; no
changes were made to what the script actually executes.

The back-to-back exploration of sample rates for Perfbuf and Ringbuf
have been combined into a single section.

Some of the variables in the script were renamed for clarity; b is
always a benchmark name, s is a sampling rate, n is a number of
producers. Before the change, b was the only variable.

After:
```
Parallel producer
=================
rb-libbpf            43.072 ± 0.165M/s (drops 0.940 ± 0.016M/s)
rb-custom            20.274 ± 0.442M/s (drops 0.000 ± 0.000M/s)
pb-libbpf            1.480 ± 0.015M/s (drops 0.000 ± 0.000M/s)
pb-custom            1.492 ± 0.023M/s (drops 0.000 ± 0.000M/s)

Parallel producer, sampled notifications
========================================
rb-libbpf            41.132 ± 0.113M/s (drops 0.000 ± 0.000M/s)
rb-custom            33.228 ± 0.086M/s (drops 0.000 ± 0.000M/s)
pb-libbpf            22.498 ± 0.142M/s (drops 0.052 ± 0.171M/s)
pb-custom            22.399 ± 0.060M/s (drops 0.030 ± 0.100M/s)

Back-to-back producer
=====================
rb-libbpf            59.951 ± 0.712M/s (drops 0.000 ± 0.000M/s)
rb-libbpf-sampled    57.751 ± 4.694M/s (drops 0.000 ± 0.000M/s)
rb-custom            71.568 ± 12.584M/s (drops 0.000 ± 0.000M/s)
rb-custom-sampled    71.919 ± 7.540M/s (drops 0.000 ± 0.000M/s)
pb-libbpf            1.961 ± 0.013M/s (drops 0.000 ± 0.000M/s)
pb-libbpf-sampled    22.339 ± 0.129M/s (drops 0.000 ± 0.000M/s)
pb-custom            1.972 ± 0.009M/s (drops 0.000 ± 0.000M/s)
pb-custom-sampled    22.802 ± 0.374M/s (drops 0.000 ± 0.000M/s)

Back-to-back producer, varying sample rate
==========================================
rb-custom-1          1.529 ± 0.008M/s (drops 0.000 ± 0.000M/s)
rb-custom-5          5.817 ± 1.945M/s (drops 0.000 ± 0.000M/s)
rb-custom-10         12.884 ± 0.032M/s (drops 0.000 ± 0.000M/s)
rb-custom-25         25.634 ± 0.031M/s (drops 0.000 ± 0.000M/s)
rb-custom-50         39.970 ± 0.309M/s (drops 0.000 ± 0.000M/s)
rb-custom-100        51.868 ± 0.210M/s (drops 0.000 ± 0.000M/s)
rb-custom-250        69.466 ± 0.039M/s (drops 0.000 ± 0.000M/s)
rb-custom-500        76.370 ± 0.181M/s (drops 0.000 ± 0.000M/s)
rb-custom-1000       79.778 ± 0.248M/s (drops 0.000 ± 0.000M/s)
rb-custom-2000       82.952 ± 0.198M/s (drops 0.000 ± 0.000M/s)
rb-custom-3000       82.314 ± 0.155M/s (drops 0.000 ± 0.000M/s)
pb-custom-1          1.418 ± 0.004M/s (drops 0.000 ± 0.000M/s)
pb-custom-5          5.655 ± 0.066M/s (drops 0.000 ± 0.000M/s)
pb-custom-10         9.091 ± 0.109M/s (drops 0.000 ± 0.000M/s)
pb-custom-25         14.338 ± 0.144M/s (drops 0.000 ± 0.000M/s)
pb-custom-50         17.841 ± 0.318M/s (drops 0.000 ± 0.000M/s)
pb-custom-100        20.491 ± 0.099M/s (drops 0.000 ± 0.000M/s)
pb-custom-250        22.047 ± 0.270M/s (drops 0.000 ± 0.000M/s)
pb-custom-500        22.475 ± 0.676M/s (drops 0.000 ± 0.000M/s)
pb-custom-1000       23.013 ± 0.786M/s (drops 0.000 ± 0.000M/s)
pb-custom-2000       23.305 ± 0.182M/s (drops 0.000 ± 0.000M/s)
pb-custom-3000       23.855 ± 0.071M/s (drops 0.000 ± 0.000M/s)

Back-to-back producer, rb-custom reserve+commit vs output
=========================================================
reserve              76.244 ± 0.469M/s (drops 0.000 ± 0.000M/s)
output               64.707 ± 5.618M/s (drops 0.000 ± 0.000M/s)

Parallel producer, rb-custom reserve+commit vs output, sampled notifications
============================================================================
reserve-sampled      33.560 ± 0.024M/s (drops 0.000 ± 0.000M/s)
output-sampled       30.348 ± 0.313M/s (drops 0.000 ± 0.000M/s)

Concurrent producer (same CPU as consumer), low batch count
===========================================================
rb-libbpf            0.563 ± 0.007M/s (drops 0.000 ± 0.000M/s)
rb-custom            0.571 ± 0.001M/s (drops 0.000 ± 0.000M/s)
pb-libbpf            0.523 ± 0.001M/s (drops 0.000 ± 0.000M/s)
pb-custom            0.530 ± 0.004M/s (drops 0.000 ± 0.000M/s)

Multiple parallel producers (contention)
========================================
rb-libbpf nr_prod 1  44.711 ± 0.058M/s (drops 0.183 ± 0.012M/s)
rb-libbpf nr_prod 2  23.534 ± 0.069M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 3  14.011 ± 0.023M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 4  14.858 ± 0.021M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 8  6.184 ± 0.031M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 12 4.719 ± 0.058M/s (drops 0.006 ± 0.021M/s)
rb-libbpf nr_prod 16 4.607 ± 0.055M/s (drops 0.010 ± 0.028M/s)
rb-libbpf nr_prod 20 5.001 ± 0.052M/s (drops 0.010 ± 0.025M/s)
rb-libbpf nr_prod 24 5.234 ± 0.114M/s (drops 0.006 ± 0.021M/s)
rb-libbpf nr_prod 28 5.021 ± 0.020M/s (drops 0.007 ± 0.014M/s)
rb-libbpf nr_prod 32 4.316 ± 0.142M/s (drops 0.614 ± 0.121M/s)
rb-libbpf nr_prod 36 4.353 ± 0.157M/s (drops 0.708 ± 0.126M/s)
rb-libbpf nr_prod 40 4.230 ± 0.058M/s (drops 0.775 ± 0.120M/s)
rb-libbpf nr_prod 44 4.212 ± 0.050M/s (drops 0.736 ± 0.084M/s)
rb-libbpf nr_prod 48 4.276 ± 0.057M/s (drops 0.784 ± 0.095M/s)
rb-libbpf nr_prod 52 4.222 ± 0.141M/s (drops 0.777 ± 0.172M/s)
```

Before:
```
Single-producer, parallel producer
==================================
rb-libbpf            43.366 ± 0.277M/s (drops 0.848 ± 0.027M/s)
rb-custom            17.831 ± 0.391M/s (drops 0.065 ± 0.216M/s)
pb-libbpf            1.494 ± 0.012M/s (drops 0.000 ± 0.000M/s)
pb-custom            1.521 ± 0.002M/s (drops 0.000 ± 0.000M/s)

Single-producer, parallel producer, sampled notification
========================================================
rb-libbpf            41.163 ± 0.031M/s (drops 0.000 ± 0.000M/s)
rb-custom            33.364 ± 0.347M/s (drops 0.025 ± 0.082M/s)
pb-libbpf            21.039 ± 3.350M/s (drops 0.014 ± 0.036M/s)
pb-custom            22.570 ± 0.267M/s (drops 0.136 ± 0.319M/s)

Single-producer, back-to-back mode
==================================
rb-libbpf            60.671 ± 0.274M/s (drops 0.000 ± 0.000M/s)
rb-libbpf-sampled    59.229 ± 0.422M/s (drops 0.000 ± 0.000M/s)
rb-custom            77.296 ± 0.156M/s (drops 0.000 ± 0.000M/s)
rb-custom-sampled    71.147 ± 0.281M/s (drops 0.000 ± 0.000M/s)
pb-libbpf            1.960 ± 0.007M/s (drops 0.000 ± 0.000M/s)
pb-libbpf-sampled    22.230 ± 0.115M/s (drops 0.000 ± 0.000M/s)
pb-custom            1.969 ± 0.005M/s (drops 0.000 ± 0.000M/s)
pb-custom-sampled    22.883 ± 0.122M/s (drops 0.000 ± 0.000M/s)

Ringbuf back-to-back, effect of sample rate
===========================================
rb-sampled-1         1.507 ± 0.004M/s (drops 0.000 ± 0.000M/s)
rb-sampled-5         7.095 ± 0.016M/s (drops 0.000 ± 0.000M/s)
rb-sampled-10        13.091 ± 0.046M/s (drops 0.000 ± 0.000M/s)
rb-sampled-25        26.259 ± 0.061M/s (drops 0.000 ± 0.000M/s)
rb-sampled-50        39.831 ± 0.122M/s (drops 0.000 ± 0.000M/s)
rb-sampled-100       51.536 ± 2.984M/s (drops 0.000 ± 0.000M/s)
rb-sampled-250       67.850 ± 1.267M/s (drops 0.000 ± 0.000M/s)
rb-sampled-500       75.257 ± 0.438M/s (drops 0.000 ± 0.000M/s)
rb-sampled-1000      74.939 ± 0.295M/s (drops 0.000 ± 0.000M/s)
rb-sampled-2000      81.481 ± 0.769M/s (drops 0.000 ± 0.000M/s)
rb-sampled-3000      82.637 ± 0.448M/s (drops 0.000 ± 0.000M/s)

Perfbuf back-to-back, effect of sample rate
===========================================
pb-sampled-1         1.408 ± 0.003M/s (drops 0.000 ± 0.000M/s)
pb-sampled-5         5.667 ± 0.012M/s (drops 0.000 ± 0.000M/s)
pb-sampled-10        9.162 ± 0.026M/s (drops 0.000 ± 0.000M/s)
pb-sampled-25        14.389 ± 0.033M/s (drops 0.000 ± 0.000M/s)
pb-sampled-50        17.977 ± 0.049M/s (drops 0.000 ± 0.000M/s)
pb-sampled-100       20.541 ± 0.079M/s (drops 0.000 ± 0.000M/s)
pb-sampled-250       22.176 ± 0.523M/s (drops 0.000 ± 0.000M/s)
pb-sampled-500       23.121 ± 0.124M/s (drops 0.000 ± 0.000M/s)
pb-sampled-1000      22.415 ± 1.860M/s (drops 0.000 ± 0.000M/s)
pb-sampled-2000      23.333 ± 0.679M/s (drops 0.000 ± 0.000M/s)
pb-sampled-3000      23.032 ± 0.649M/s (drops 0.000 ± 0.000M/s)

Ringbuf back-to-back, reserve+commit vs output
==============================================
reserve              77.180 ± 0.304M/s (drops 0.000 ± 0.000M/s)
output               60.890 ± 7.685M/s (drops 0.000 ± 0.000M/s)

Ringbuf sampled, reserve+commit vs output
=========================================
reserve-sampled      30.724 ± 0.166M/s (drops 0.000 ± 0.000M/s)
output-sampled       30.261 ± 0.454M/s (drops 0.000 ± 0.000M/s)

Single-producer, consumer/producer competing on the same CPU, low batch count
=============================================================================
rb-libbpf            0.570 ± 0.004M/s (drops 0.000 ± 0.000M/s)
rb-custom            0.569 ± 0.003M/s (drops 0.000 ± 0.000M/s)
pb-libbpf            0.539 ± 0.002M/s (drops 0.000 ± 0.000M/s)
pb-custom            0.549 ± 0.003M/s (drops 0.000 ± 0.000M/s)

Ringbuf, multi-producer contention
==================================
rb-libbpf nr_prod 1  44.359 ± 0.319M/s (drops 0.091 ± 0.027M/s)
rb-libbpf nr_prod 2  23.722 ± 0.024M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 3  14.128 ± 0.011M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 4  14.896 ± 0.020M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 8  6.056 ± 0.061M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 12 4.612 ± 0.042M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 16 4.684 ± 0.040M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 20 5.007 ± 0.046M/s (drops 0.001 ± 0.004M/s)
rb-libbpf nr_prod 24 5.207 ± 0.093M/s (drops 0.006 ± 0.013M/s)
rb-libbpf nr_prod 28 4.951 ± 0.073M/s (drops 0.030 ± 0.069M/s)
rb-libbpf nr_prod 32 4.509 ± 0.069M/s (drops 0.582 ± 0.057M/s)
rb-libbpf nr_prod 36 4.361 ± 0.064M/s (drops 0.733 ± 0.126M/s)
rb-libbpf nr_prod 40 4.261 ± 0.049M/s (drops 0.713 ± 0.116M/s)
rb-libbpf nr_prod 44 4.150 ± 0.207M/s (drops 0.841 ± 0.191M/s)
rb-libbpf nr_prod 48 4.033 ± 0.064M/s (drops 1.009 ± 0.082M/s)
rb-libbpf nr_prod 52 4.025 ± 0.049M/s (drops 1.012 ± 0.069M/s)

```

Signed-off-by: Andrew Werner <awerner32@gmail.com>
---
v1->v2:
 - Improved commit message
 - Added SOB
 - Reworked all section headers for uniformity

v1: https://lore.kernel.org/bpf/20230719014744.3480131-1-awerner32@gmail.com/
---
 .../bpf/benchs/run_bench_ringbufs.sh          | 30 +++++++++----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
index 91e3567962ff..c495013c1d88 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
@@ -6,46 +6,44 @@ set -eufo pipefail
 
 RUN_RB_BENCH="$RUN_BENCH -c1"
 
-header "Single-producer, parallel producer"
+header "Parallel producer"
 for b in rb-libbpf rb-custom pb-libbpf pb-custom; do
 	summarize $b "$($RUN_RB_BENCH $b)"
 done
 
-header "Single-producer, parallel producer, sampled notification"
+header "Parallel producer, sampled notifications"
 for b in rb-libbpf rb-custom pb-libbpf pb-custom; do
 	summarize $b "$($RUN_RB_BENCH --rb-sampled $b)"
 done
 
-header "Single-producer, back-to-back mode"
+header "Back-to-back producer"
 for b in rb-libbpf rb-custom pb-libbpf pb-custom; do
 	summarize $b "$($RUN_RB_BENCH --rb-b2b $b)"
 	summarize $b-sampled "$($RUN_RB_BENCH --rb-sampled --rb-b2b $b)"
 done
 
-header "Ringbuf back-to-back, effect of sample rate"
-for b in 1 5 10 25 50 100 250 500 1000 2000 3000; do
-	summarize "rb-sampled-$b" "$($RUN_RB_BENCH --rb-b2b --rb-batch-cnt $b --rb-sampled --rb-sample-rate $b rb-custom)"
-done
-header "Perfbuf back-to-back, effect of sample rate"
-for b in 1 5 10 25 50 100 250 500 1000 2000 3000; do
-	summarize "pb-sampled-$b" "$($RUN_RB_BENCH --rb-b2b --rb-batch-cnt $b --rb-sampled --rb-sample-rate $b pb-custom)"
+header "Back-to-back producer, varying sample rate"
+for b in rb-custom pb-custom; do
+  for r in 1 5 10 25 50 100 250 500 1000 2000 3000; do
+	  summarize "$b-$r" "$($RUN_RB_BENCH --rb-b2b --rb-batch-cnt $r --rb-sampled --rb-sample-rate $r $b)"
+  done
 done
 
-header "Ringbuf back-to-back, reserve+commit vs output"
+header "Back-to-back producer, rb-custom reserve+commit vs output"
 summarize "reserve" "$($RUN_RB_BENCH --rb-b2b                 rb-custom)"
 summarize "output"  "$($RUN_RB_BENCH --rb-b2b --rb-use-output rb-custom)"
 
-header "Ringbuf sampled, reserve+commit vs output"
+header "Parallel producer, rb-custom reserve+commit vs output, sampled notifications"
 summarize "reserve-sampled" "$($RUN_RB_BENCH --rb-sampled                 rb-custom)"
 summarize "output-sampled"  "$($RUN_RB_BENCH --rb-sampled --rb-use-output rb-custom)"
 
-header "Single-producer, consumer/producer competing on the same CPU, low batch count"
+header "Concurrent producer (same CPU as consumer), low batch count"
 for b in rb-libbpf rb-custom pb-libbpf pb-custom; do
 	summarize $b "$($RUN_RB_BENCH --rb-batch-cnt 1 --rb-sample-rate 1 --prod-affinity 0 --cons-affinity 0 $b)"
 done
 
-header "Ringbuf, multi-producer contention"
-for b in 1 2 3 4 8 12 16 20 24 28 32 36 40 44 48 52; do
-	summarize "rb-libbpf nr_prod $b" "$($RUN_RB_BENCH -p$b --rb-batch-cnt 50 rb-libbpf)"
+header "Parallel producers (multiple, contention)"
+for n in 1 2 3 4 8 12 16 20 24 28 32 36 40 44 48 52; do
+	summarize "rb-libbpf nr_prod $n" "$($RUN_RB_BENCH -p$n --rb-batch-cnt 50 rb-libbpf)"
 done
 
-- 
2.39.2


