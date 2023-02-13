Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BAA694080
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 10:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjBMJPQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 04:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjBMJPP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 04:15:15 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803CFB74D
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:12 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id bt8so6088621edb.12
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKRLfQHZlRLGYU7EeqTaJjmPKgZI+D7UIDAiJ92z6P0=;
        b=JAltTbciLFZoRiG/7tWzBMqYm/myJaIP/hqGa+T1KnhM8p0WXb+OeA5shZ7tGVB+eD
         30hkSwlmgkIrDt8N09U3XaCbxjMKkbcDACedKw69poHYihkZcTXa5b3ZHxFqLFi/GNY0
         AF0zCZmkAIGBNrMwSyCJ3meKaiC4+nUvLPrMbjBIpgp5XfsTpd6knr7ASYJdBk9neYbB
         KZKbM6TZUlowWeatYq8/FfJvkkbgfRRqOeThRG+M/qgwxtCz8YSa0yOZyKuBoPomlCcB
         7/qMqA4NPhpkAxhvbdg473iSf8f3nVwXDSUKWPSmpMJo+9QFmBCN5pJVZKr0ckxsEoF5
         2EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKRLfQHZlRLGYU7EeqTaJjmPKgZI+D7UIDAiJ92z6P0=;
        b=ChBTo3R3ysVwlydiQGbfQ0vVE2fOdoP2WTdL8q8epHKHbU7DCnwUhDAldeYm9c/24g
         tUtqXzIeejXvnvAQ+4zELIhlkHrj8dpgXeMGjXOGlvyEqQWpwYqkruEatMAIkVypzHuB
         7twiMn97Hg19jZqXnmshH7YTG1mqZ/wbZVdEGDs+bOK6k7Kp6jgMRV8vIzjp0RPWgSxK
         Vzm99X07ubcjEWOA1Tz6ShyIR/oHfmrs+EFNofO8MyQSKXsViDNEG9oYuX4ZmTWM4uar
         gPn6SY5iy0pDAMKXGEBjhowdzIwLlxs2Egow2TZcHvdo+9I562IzcSZPQ2VSdOWvHdGx
         efmg==
X-Gm-Message-State: AO0yUKWxiRRT1jjiABZFMzeYjzZnHx5XjzoQ+VGnvyNgDropXWY/QkE/
        4ggbia1wtmlh3DmcGWmItGUpKFIKb1afNiKxjnA=
X-Google-Smtp-Source: AK7set+CcM8wklG3OC2ycI2zBvYwKlvd4ORoqUzs1+YiQBPZyrvPWRZ4Q1QgVjqRQpV7m8WPOiCNug==
X-Received: by 2002:a50:a454:0:b0:4aa:dedd:41e0 with SMTP id v20-20020a50a454000000b004aadedd41e0mr5791061edb.8.1676279710900;
        Mon, 13 Feb 2023 01:15:10 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id f8-20020a50d548000000b004ab33d52d03sm5336587edj.22.2023.02.13.01.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 01:15:10 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next v2 1/7] selftest/bpf/benchs: fix a typo in bpf_hashmap_full_update
Date:   Mon, 13 Feb 2023 09:15:13 +0000
Message-Id: <20230213091519.1202813-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213091519.1202813-1-aspsk@isovalent.com>
References: <20230213091519.1202813-1-aspsk@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To call the bpf_hashmap_full_update benchmark, one should say:

    bench bpf-hashmap-ful-update

The patch adds a missing 'l' to the benchmark name.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 .../selftests/bpf/benchs/bench_bpf_hashmap_full_update.c        | 2 +-
 .../selftests/bpf/benchs/run_bench_bpf_hashmap_full_update.sh   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
index cec51e0ff4b8..44706acf632a 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
@@ -85,7 +85,7 @@ void hashmap_report_final(struct bench_res res[], int res_cnt)
 }
 
 const struct bench bench_bpf_hashmap_full_update = {
-	.name = "bpf-hashmap-ful-update",
+	.name = "bpf-hashmap-full-update",
 	.validate = validate,
 	.setup = setup,
 	.producer_thread = producer,
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_bpf_hashmap_full_update.sh b/tools/testing/selftests/bpf/benchs/run_bench_bpf_hashmap_full_update.sh
index 1e2de838f9fa..cd2efd3fdef3 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_bpf_hashmap_full_update.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_bpf_hashmap_full_update.sh
@@ -6,6 +6,6 @@ source ./benchs/run_common.sh
 set -eufo pipefail
 
 nr_threads=`expr $(cat /proc/cpuinfo | grep "processor"| wc -l) - 1`
-summary=$($RUN_BENCH -p $nr_threads bpf-hashmap-ful-update)
+summary=$($RUN_BENCH -p $nr_threads bpf-hashmap-full-update)
 printf "$summary"
 printf "\n"
-- 
2.34.1

