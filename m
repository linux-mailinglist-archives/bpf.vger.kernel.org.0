Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A7D6462D4
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiLGUvC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 15:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiLGUu3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:50:29 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A184E7E431;
        Wed,  7 Dec 2022 12:49:40 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id mn15so13498903qvb.13;
        Wed, 07 Dec 2022 12:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRxvJTGK2cDC3z7BCQUpnPVW1eaQaQ+xwEyipFCGWaw=;
        b=OeTkfMkRCDnsPu4FeogmbzLgH4sWn0MB/ihZOzWeVunHIRsQH1xgH1/5Mcpzxa1YDS
         G2AK45VZ4nAAX8RMxnpbchR/UEEy3W/ZK6UTXCC5r9M/rLdDEHvtgqhtxtdjvABD5sKu
         jX8mL9lkoD2lVGLD3IOC1yORmKAZOREHQMZKWJM15ME0jZn5jzagvG3N8iWhZGOHyd0p
         ylsR6edgruSAVN+RRLECAPOJ69zkNdpJF9Aa5lQgZNld5aTEmKg/p5qQMF8hMGb4zgdh
         ikRJ6RTB8APqvSOrItekqJKnkS4I//c29JKvlnrf5bS4Ty37lVP4Ar2topZ5ByO2W0+M
         ItJg==
X-Gm-Message-State: ANoB5pnYaZFRKLr9Y1iMNrMCgZNiWtrrETqIa3hxu4Du9wE0hsWl8X/a
        wvcy7G2R6TCGXcBqgzPvtVVTRHblP3Y7BzjG
X-Google-Smtp-Source: AA0mqf4J9Y93qmicAwgoeEZJaFwLMCYoIcEM3pNYcQ5SJM+na68si7cedCrPb3EweynuYieINCPaVQ==
X-Received: by 2002:ad4:57aa:0:b0:4c6:f83c:4741 with SMTP id g10-20020ad457aa000000b004c6f83c4741mr45473577qvx.11.1670446178850;
        Wed, 07 Dec 2022 12:49:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:629d])
        by smtp.gmail.com with ESMTPSA id z18-20020ac87112000000b0039853b7b771sm14191307qto.80.2022.12.07.12.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:49:38 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next v3 0/2] Document some recent core kfunc additions
Date:   Wed,  7 Dec 2022 14:49:09 -0600
Message-Id: <20221207204911.873646-1-void@manifault.com>
X-Mailer: git-send-email 2.38.1
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

A series of recent patch sets introduced kfuncs that allowed struct
task_struct and struct cgroup objects to be used as kptrs. These were
introduced in [0], [1], and [2].

[0]: https://lore.kernel.org/lkml/20221120051004.3605026-1-void@manifault.com/
[1]: https://lore.kernel.org/lkml/20221122145300.251210-2-void@manifault.com/T/
[2]: https://lore.kernel.org/lkml/20221122055458.173143-1-void@manifault.com/

These are "core" kfuncs, in that they may be used by a wide variety of
possible BPF tracepoint or struct_ops programs, and are defined in
kernel/bpf/helpers.c. Even though as kfuncs they have no ABI stability
guarantees, they should still be properly documented. This patch set
adds that documentation.

Some other kfuncs were added recently as well, such as
bpf_rcu_read_lock() and bpf_rcu_read_unlock(). Those could and should be
added to this "Core kfuncs" section as well in subsequent patch sets.

Note that this patch set does not contain documentation for
bpf_task_acquire_not_zero(), or bpf_task_kptr_get(). As discussed in
[3], those kfuncs currently always return NULL pending resolution on how
to properly protect their arguments using RCU.


[3]: https://lore.kernel.org/all/20221206210538.597606-1-void@manifault.com/

--
Changelog:
v2 -> v3:
- Don't document bpf_task_kptr_get(), and instead provide a more
  substantive example for bpf_cgroup_kptr_get().
- Further clarify expected behavior of bpf_task_from_pid() in comments
  (Alexei)

v1 -> v2:
- Expand comment to specify that a map holds a reference to a task kptr
  if we don't end up releasing it (Alexei)
- Just read task->pid instead of using a probed read (Alexei)

David Vernet (2):
  bpf/docs: Document struct task_struct * kfuncs
  bpf/docs: Document struct cgroup * kfuncs

 Documentation/bpf/kfuncs.rst | 198 +++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c         |   4 +-
 2 files changed, 200 insertions(+), 2 deletions(-)

-- 
2.38.1

