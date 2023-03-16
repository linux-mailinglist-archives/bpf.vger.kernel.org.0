Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54B26BC363
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 02:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCPBl1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 21:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCPBl0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 21:41:26 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00659ABB1C;
        Wed, 15 Mar 2023 18:41:25 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id h19so292618qtn.1;
        Wed, 15 Mar 2023 18:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678930884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P55rgRz7v69PxyoCgb99Xdtulupv+YyUUL74psxzFss=;
        b=o8Xr1lUpwYr7kSO7EpdlIecPeiwNZGBPD2321U0mf5D4Zk2bPluVmA1d9LWEiKmr+p
         qO3ZnbG/dhEI3HX8N6KHn/w/NALeDBVuU0roD/AIXf4/r994IC7a0D578nw5SUdzETHn
         llnUAPkWVztkl087PhYC1HDgyt1d737o8TFeKAFkyW3okPo0hIor2U/YoHB7LnGqMxTO
         ol8D+VLH+QhgjC/9tBZYtGnUhBhaX27yYF3fISc+jU/UIESr6UntPqz/vrFqWT0JidPn
         ldLza/VhWacSQ+VFHsWqcuOQBvwDHyI+uBBVrMCCBeGgjmZNFlE7FbxqRtVjwiDZEe1Z
         GKAg==
X-Gm-Message-State: AO0yUKVHLsNn7kjNsslyV1uxAdHsdK4izVBBgVdOgUkwlNAxuCZ3At3Y
        AtCdjdKq6BBwF3lkbvMbVVFOiBlnyY7/sJef
X-Google-Smtp-Source: AK7set/vq5oAulAOo6+oXgQkLzxSzeDaTgB5dkSmnjSvYtDjYnIWUel1zyNTWkJNlW+Fi6jcfgmrCg==
X-Received: by 2002:ac8:7fc6:0:b0:3bf:bbaf:5c82 with SMTP id b6-20020ac87fc6000000b003bfbbaf5c82mr3700973qtk.21.1678930884435;
        Wed, 15 Mar 2023 18:41:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:5c58])
        by smtp.gmail.com with ESMTPSA id w19-20020a05620a0e9300b00746279f3fd5sm573675qkm.9.2023.03.15.18.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 18:41:23 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 0/5] Make struct bpf_cpumask RCU safe
Date:   Wed, 15 Mar 2023 20:41:17 -0500
Message-Id: <20230316014122.678082-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The struct bpf_cpumask type is currently not RCU safe. It uses the
bpf_mem_cache_{alloc,free}() APIs to allocate and release cpumasks, and
those allocations may be reused before an RCU grace period has elapsed.
We want to be able to enable using this pattern in BPF programs:

private(MASK) static struct bpf_cpumask __kptr *global;

int BPF_PROG(prog, ...)
{
	struct bpf_cpumask *cpumask;

	bpf_rcu_read_lock();
	cpumask = global;
	if (!cpumask) {
		bpf_rcu_read_unlock();
		return -1;
	}
	bpf_cpumask_setall(cpumask);
	...
	bpf_rcu_read_unlock();
}

In other words, to be able to pass a kptr to KF_RCU bpf_cpumask kfuncs
without requiring the acquisition and release of refcounts using
bpf_cpumask_kptr_get(). This patchset enables this by making the struct
bpf_cpumask type RCU safe, and removing the bpf_cpumask_kptr_get()
function.

David Vernet (5):
  bpf: Free struct bpf_cpumask in call_rcu handler
  bpf: Mark struct bpf_cpumask as rcu protected
  bpf/selftests: Test using global cpumask kptr with RCU
  bpf: Remove bpf_cpumask_kptr_get() kfunc
  bpf,docs: Remove bpf_cpumask_kptr_get() from documentation

 Documentation/bpf/cpumasks.rst                | 30 +++-----
 kernel/bpf/cpumask.c                          | 37 +++-------
 kernel/bpf/verifier.c                         |  1 +
 .../selftests/bpf/prog_tests/cpumask.c        |  2 +-
 .../selftests/bpf/progs/cpumask_common.h      |  7 +-
 .../selftests/bpf/progs/cpumask_failure.c     | 68 +++++++++++++++----
 .../selftests/bpf/progs/cpumask_success.c     | 29 ++++----
 7 files changed, 95 insertions(+), 79 deletions(-)

-- 
2.39.0

