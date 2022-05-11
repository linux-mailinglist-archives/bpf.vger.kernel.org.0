Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D9A522F99
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 11:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiEKJjc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 05:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237366AbiEKJjS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 05:39:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE955400F
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 02:39:14 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q18so1325335pln.12
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 02:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q9QdO95hB/1a07szG5DQddpKrWRTLifgbJv4wAyhbh8=;
        b=pMf9S1yXYeBoeprJoZzPWwFGJl0HKc3tOJr6+RpuubLn7bv3HAf39sm6vrkj0d1Dhs
         QTNj3odRa1DyTvvq0E8atDB4dbMBjYI0M4rIwnjiZUcOWxft1uFDlXyPFC9TSc1LooZM
         jN+VbwtqCcxBe0mJ0htdB6T7GBryn8JORIWMNn63XUSPSSB7Mrh9WR5JdLLMlLbbycC0
         /Q5zAZcZhlSLdK/sgoK7dZuqyb1+G/Np7Fpk0fyx/hkF+SdqPV4JGWwkxKOYuO+s3AQN
         Rbv/ocVNxVpnE8J9JdYYd2jaV6O22ZZbzazz1o9xfdXhWwUDEE7ARaDHgLPFXcMuDxE5
         mqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q9QdO95hB/1a07szG5DQddpKrWRTLifgbJv4wAyhbh8=;
        b=PGiJkziCFzW/uB1bxAZd6t35jsLoziic1MO8V3p/ETu2Z58TbsCkrXCiCHMDmWKEXj
         frXtZQCgDGSFyYDRL7n3jUsRw8B5KM9+x9Dg4Q6RFaAXigT6pOYlqGAeKU8yUplaLdUw
         PNEvpQONhyGl776LV4xEyjWOInIKROYDaTwMnJsAVf4QjYyonSHoJj+GoxCdpVmDCePv
         wf5ss+tCnIhg71U144PBDDOVT2ftuN7+SKKf5Az7pu+To5WzfRuZ7SlH9Wb3Mcncf2O7
         pGG8cMMgHOsOtxmaYL16E5EezqT6mbFX3EnX9sDwQo4G8039QaQZrekN9R6G+7Ps4PQw
         69yg==
X-Gm-Message-State: AOAM530OU+iAGrjjVdQfDQMPjq4hD5VtXRMrJPHTBQV3K69dU10mOmKW
        GuD+Wf3f+hZFo9fEhrFqanZ2ag==
X-Google-Smtp-Source: ABdhPJy3C+Y7SngriFVhDdq5WFkO5tqQiSkGREQ6wh9fbEkWgxLH3aMm/RVoKi/XdKFwdTWAwnNgVw==
X-Received: by 2002:a17:90b:4ad1:b0:1dc:96fa:69aa with SMTP id mh17-20020a17090b4ad100b001dc96fa69aamr4404870pjb.189.1652261954413;
        Wed, 11 May 2022 02:39:14 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id k4-20020aa790c4000000b0050dc76281cdsm1159834pfk.167.2022.05.11.02.39.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2022 02:39:14 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, jolsa@kernel.org, davemarchevsky@fb.com,
        joannekoong@fb.com, geliang.tang@suse.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, wangdongdong.6@bytedance.com,
        cong.wang@bytedance.com, zhouchengming@bytedance.com,
        zhoufeng.zf@bytedance.com, yosryahmed@google.com
Subject: [PATCH bpf-next v2 0/2] Introduce access remote cpu elem support in BPF percpu map
Date:   Wed, 11 May 2022 17:38:52 +0800
Message-Id: <20220511093854.411-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Trace some functions, such as enqueue_task_fair, need to access the
corresponding cpu, not the current cpu, and bpf_map_lookup_elem percpu map
cannot do it. So add bpf_map_lookup_percpu_elem to accomplish it for
percpu_array_map, percpu_hash_map, lru_percpu_hash_map.

v1->v2: Addressed comments from Alexei Starovoitov.
- add a selftest for bpf_map_lookup_percpu_elem.

Feng Zhou (2):
  bpf: add bpf_map_lookup_percpu_elem for percpu map
  selftests/bpf: add test case for bpf_map_lookup_percpu_elem

 include/linux/bpf.h                           |  2 +
 include/uapi/linux/bpf.h                      |  9 ++++
 kernel/bpf/arraymap.c                         | 15 ++++++
 kernel/bpf/core.c                             |  1 +
 kernel/bpf/hashtab.c                          | 32 +++++++++++
 kernel/bpf/helpers.c                          | 18 +++++++
 kernel/bpf/verifier.c                         | 17 +++++-
 kernel/trace/bpf_trace.c                      |  2 +
 tools/include/uapi/linux/bpf.h                |  9 ++++
 .../bpf/prog_tests/map_lookup_percpu_elem.c   | 46 ++++++++++++++++
 .../bpf/progs/test_map_lookup_percpu_elem.c   | 54 +++++++++++++++++++
 11 files changed, 203 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c

-- 
2.20.1

