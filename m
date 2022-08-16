Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0485596387
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 22:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbiHPUMR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 16:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiHPUMQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 16:12:16 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD697E82D
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 13:12:16 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id o12-20020a170902d4cc00b0016e81c62cc8so7119834plg.13
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 13:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=BNuVQQZxdajTB3T169cXzpyA2YAOrtCcl5Gl2MyqPzk=;
        b=mhkl0/axiptzeDpKM3NO7ecDyqN8fheN39FklCzTw6XeOr2pyQkxzqTorHH39AqoqV
         0PD0BemnUZkIxa/C5gYOVzTVcq6Q7qwGulAId8wOLES47g1Po7iUHNSvkxrySPNzPiL0
         NmH4/8Gtuy973piQV3Bfvot8JlXiJMMSqd/gwsn6h+pq5fFIBwLCwly5avXdIWnz1PjV
         PRh5kJ30bzfojPWyuwR3aFRQcjlQDzmyr9UBV7EFgriwVVunY4pPKmjj2/JRohsRrH4h
         ep7TALIsEM37jNr954ntGV4Vy5oZ33mGXuABSz1bIAGKriUaIWiLDKZBYelnq7lAVBqV
         b30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=BNuVQQZxdajTB3T169cXzpyA2YAOrtCcl5Gl2MyqPzk=;
        b=ZxdI+tLyCVm8p5Hk/ivVp4bg5kBNJ0yYFlh7xVTguOTBp69e5GsPnPyxLDU2I+CgOl
         9OGh3NhNLarcy5GcH4XBtTWzWrlTTo6o9nYT8Q+M/GtpFjNYxcLIttvmxPeQ2o3Ttgi8
         Pq2zuQjMwz3+opRXd8m78VWDudkMCusZccRJ+/lyKo1OVfLeQmvwt2rJDPhzg1oxiKtn
         axoM7Y9AIJ0bTzwuZxPeeh4IDZ9xtaxP4Ud3j09JwW4f/4AlgME587APu6uX7JhCvlWV
         nfUjte8MyHgiKa0gEivLZkR1ni5CL9/e7iHlKh2vrYCMFx0GFI+lRaibVA/IOEHR6qvQ
         xDdQ==
X-Gm-Message-State: ACgBeo0pH/dXzb0VgXR+3xbAcc7NA8UWoSg65F8YtnZUuI9rIs+2fK61
        BBYMZocsp26aeXy/sucxX3iHBM58kfgj08UDVgvUXM6gkSWa5NVF6meb42K0CmJk6BXM/pKOnX/
        qC1ogmrbPxGBcibiPDIFZwzB1pXj/VozDKV1GuPlQd35J+G2wdg==
X-Google-Smtp-Source: AA6agR46XcOZZrrgwumzQ8jrrn39c/H/Fas12R6s7A9NlbiSlOIZRqrRKn90NKzYmFq7enB5D3a2KGc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:8486:b0:171:48cd:1356 with SMTP id
 c6-20020a170902848600b0017148cd1356mr22565944plo.153.1660680735629; Tue, 16
 Aug 2022 13:12:15 -0700 (PDT)
Date:   Tue, 16 Aug 2022 13:12:11 -0700
Message-Id: <20220816201214.2489910-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v2 0/3] bpf: expose bpf_{g,s}et_retval to more cgroup hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Apparently, only a small subset of cgroup hooks actually falls
back to cgroup_base_func_proto. This leads to unexpected result
where not all cgroup helpers have bpf_{g,s}et_retval.

It's getting harder and harder to manage which helpers are exported
to which hooks. We now have the following call chains:

- cg_skb_func_proto
  - sk_filter_func_proto
    - bpf_sk_base_func_proto
      - bpf_base_func_proto

So by looking at cg_skb_func_proto it's pretty hard to understand
what's going on.

For cgroup helpers, I'm proposing we do the following instead:

  func_proto = cgroup_common_func_proto();
  if (func_proto) return func_proto;

  /* optional, if hook has 'current' */
  func_proto = cgroup_current_func_proto();
  if (func_proto) return func_proto;

  ...

  switch (func_id) {
  /* hook specific helpers */
  case BPF_FUNC_hook_specific_helper:
    return &xyz;
  default:
    /* always fall back to plain bpf_base_func_proto */
    bpf_base_func_proto(func_id);
  }

If this turns out more workable, we can follow up with converting
the rest to the same pattern.

v2:
- move everything into kernel/bpf/cgroup.c instead (Martin)
- use cgroup_common_func_proto in lsm (Martin)

Stanislav Fomichev (3):
  bpf: Introduce cgroup_{common,current}_func_proto
  bpf: Use cgroup_{common,current}_func_proto in more hooks
  selftests/bpf: Make sure bpf_{g,s}et_retval is exposed everywhere

 include/linux/bpf.h                           |  18 +-
 kernel/bpf/bpf_lsm.c                          |  19 +-
 kernel/bpf/cgroup.c                           | 333 +++++++++++++++++-
 kernel/bpf/helpers.c                          | 205 +----------
 net/core/filter.c                             |  92 ++---
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../bpf/cgroup_getset_retval_hooks.h          |  25 ++
 .../bpf/prog_tests/cgroup_getset_retval.c     |  48 +++
 .../bpf/progs/cgroup_getset_retval_hooks.c    |  16 +
 9 files changed, 466 insertions(+), 291 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c

-- 
2.37.1.595.g718a3a8f04-goog

