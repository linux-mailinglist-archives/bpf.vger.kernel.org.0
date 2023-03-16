Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634E86BC5C0
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 06:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCPFki (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 01:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCPFkh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 01:40:37 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FD75A1B1;
        Wed, 15 Mar 2023 22:40:36 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id t9so630215qtx.8;
        Wed, 15 Mar 2023 22:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678945235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gx8P9tdeavAC4aPkocyjuTvmm5X5ZTzcBVhYiXD4Vpc=;
        b=wF5P8JoqSlViI0H2jeeP9RpbZYeVfb3LzXWv0EJWBdQYCVQ7H5VV2EztXXKbX+c6Hk
         LLIDhp+4nK8WL9waXmgvlbin7v6Icb/J1kbr3cq+VYmfA3S+pD7x2tYoDTlvqdfQOKey
         sgXgRngrbnmUR1t4KPs50iXijSZkwTGlS30Qc7B41uD5tmu03aCoGmDy6SLyMmQyok/+
         SOWUuJ+q5uFJXbvtnujIzbJuesYjhtD5kcjSLjDD68aEmEY0n3MRXVk07nIZMef+DyYY
         YqarDBN4m6QUQJwhFcWlpJbKs5MTJ2gsjGiQ7qPkMZZbIkBZN+EOPbuS7kT+qmn0DIv/
         T0Dw==
X-Gm-Message-State: AO0yUKUQON90hstRCpLcVM+i9itzTwi3AHYj+MxVOOmTrnDCJzTBjz93
        CliEzc09N6wC274pJEtBGhNrtUOHiEsx+RPL
X-Google-Smtp-Source: AK7set+phJ+KOiu2yL8q+dRqhBG83beMeOWWQVZKTBIJ/f+/oRJShptiv6opDiT1DmSuOmtP2adaTg==
X-Received: by 2002:a05:622a:1909:b0:3bf:e43f:6992 with SMTP id w9-20020a05622a190900b003bfe43f6992mr3261787qtc.57.1678945235156;
        Wed, 15 Mar 2023 22:40:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:7f57])
        by smtp.gmail.com with ESMTPSA id x4-20020ac84a04000000b003b82489d8acsm5097903qtq.21.2023.03.15.22.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 22:40:34 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/5] Make struct bpf_cpumask RCU safe
Date:   Thu, 16 Mar 2023 00:40:23 -0500
Message-Id: <20230316054028.88924-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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

---
v1: https://lore.kernel.org/all/20230316014122.678082-2-void@manifault.com/

Changelog:
----------
v1 -> v2:
- Add doxygen comment for new @rcu field in struct bpf_cpumask.

David Vernet (5):
  bpf: Free struct bpf_cpumask in call_rcu handler
  bpf: Mark struct bpf_cpumask as rcu protected
  bpf/selftests: Test using global cpumask kptr with RCU
  bpf: Remove bpf_cpumask_kptr_get() kfunc
  bpf,docs: Remove bpf_cpumask_kptr_get() from documentation

 Documentation/bpf/cpumasks.rst                | 30 +++-----
 kernel/bpf/cpumask.c                          | 38 +++--------
 kernel/bpf/verifier.c                         |  1 +
 .../selftests/bpf/prog_tests/cpumask.c        |  2 +-
 .../selftests/bpf/progs/cpumask_common.h      |  7 +-
 .../selftests/bpf/progs/cpumask_failure.c     | 68 +++++++++++++++----
 .../selftests/bpf/progs/cpumask_success.c     | 29 ++++----
 7 files changed, 96 insertions(+), 79 deletions(-)

-- 
2.39.0
