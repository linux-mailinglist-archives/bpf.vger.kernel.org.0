Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA3E67ED3C
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 19:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjA0SPy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 13:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjA0SPv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 13:15:51 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F55887346
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 10:15:13 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u21so5482170edv.3
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 10:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKRLfQHZlRLGYU7EeqTaJjmPKgZI+D7UIDAiJ92z6P0=;
        b=X7NLE9HyM3OlCUan7t+ejxD4dvMZu3wnDfyvgkFW+IKhzVOAtZRa4CgPgkT+g2qTpm
         IknkJVhqU2beEp/f3BQcABs8JeOQFVFu2Yjowc5A4D/1xvOgDuGXXgf1Y/Ta9/pdcJqB
         vVidacaqcPfVqL0nB8ENcytU9CL+VxJ5tfiiheKP68+Pn2oIbPMftIBy9b0wjAMlxe9v
         njoOJ0cQMQXEGO8wFEXE7+bb1N04gX6WY0vgTInuIAOwYfKQ1ghhNK/MuxxFO4LAAX+x
         cQrh+EwL8hkby8PPeR6v/u4Tii42HadTz3oq1cretIVSEd9ls4Clvr3BtdJx3WzGW9/j
         mA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKRLfQHZlRLGYU7EeqTaJjmPKgZI+D7UIDAiJ92z6P0=;
        b=QvYiTGnz0jmH/DG1jqXMlRWrfGZl/QB9jv4kLIbVFXHMJWwx0Srsk0lyzZvEud3gJH
         1zNnTS0XOWX5vEjcWyNBLoO3KLKJNHBKHSsDfikf0ZENZ97pr3rO7EiCHxLfqlLYScpI
         FVnLWxvwiV91UnKAIhzu/aP5k0O6HVeNnn7nfacRIc7KLaQVYWy5JGyyQ3t31indoLHB
         Cb2DXo9MmKNZ6N6b0pQj2ekmIpNr0wZxLMWlL0ucN/q2MdzKWQ9gu8TzBLnt+q1T8KL8
         lgNTPh0SZ4OrYn0U58OfNIreVnYn1RcUBGW4gtEeFwOG9ONRtx31ybwc0EkNopu+G9x/
         erhw==
X-Gm-Message-State: AFqh2kooo2Z3ImJ1dzkeV4Lijh8uCgwwcRqrjO9xdabTRy/0FhYsjASR
        lH1WFSq+JMCI8qm9QeqMmg0/qSdfr4mw1f10IkQ=
X-Google-Smtp-Source: AMrXdXvDyyJF12/u1uC3svq/GWf007qnOFci2tro8I8ZsZwvZG5sSfuDvl53uCgn5pgawXD1lKZhrA==
X-Received: by 2002:a05:6402:448:b0:492:798:385e with SMTP id p8-20020a056402044800b004920798385emr56534958edw.33.1674843285714;
        Fri, 27 Jan 2023 10:14:45 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm2639651edr.28.2023.01.27.10.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:14:45 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 1/6] selftest/bpf/benchs: fix a typo in bpf_hashmap_full_update
Date:   Fri, 27 Jan 2023 18:14:52 +0000
Message-Id: <20230127181457.21389-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127181457.21389-1-aspsk@isovalent.com>
References: <20230127181457.21389-1-aspsk@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

