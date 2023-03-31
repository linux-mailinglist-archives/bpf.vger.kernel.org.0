Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912666D1485
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 02:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCaA5x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 20:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjCaA5s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 20:57:48 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC46C11EBA;
        Thu, 30 Mar 2023 17:57:37 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id p2so15227046qtw.13;
        Thu, 30 Mar 2023 17:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680224256; x=1682816256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJ1dpMPje81BSTbH4meHXMrj3lRV6Nvccz4UL4mrSY4=;
        b=aBCBzBD7+sN6opFiwlYmd2tLXBC9WRxUnRDSg7CAZ3q+UhzujzH/OYCSC1aFLhjnU8
         Mugq6pGToAkvlO/i7T6WJJ9QJB7OoLR0mSWVz32skX4LopU5tONYvBFr7sG1o5suL6rQ
         YaJLvsLq0qaTJT+ER/csXHAjvwGuEbapXSnBR4hhNojZvwBltkKKfGh/ILlGTK0TzvOK
         7Jz731yxkIf2yCPXC2DJNxXzi4FU8dSepdnzINKVyay1rzm6oADtglI00mwwwVcbEBKr
         W2ur5/cik+J3Nc8/Dt0dOS8Qx8BiMMyrTU0xWrDWRUe8ElDopl7aJOcJvcIsHrBVuCrc
         +5NQ==
X-Gm-Message-State: AO0yUKW0H+N9vJ+xY/iya6c4AVL0NWXPRHMVRmxQp7TMm46jWs6hFFGU
        9C6FMmIHJ+nRoeWKXOQG97Nkn26eoxEsw9eA
X-Google-Smtp-Source: AK7set8cdqCl1Ccbi6bY6IHStv1RYhtQbV93P49J9OOELuKGOafR5weHiW8S5clqOLZANC0VWpKc7g==
X-Received: by 2002:ac8:5cd2:0:b0:3bf:a061:6cb1 with SMTP id s18-20020ac85cd2000000b003bfa0616cb1mr43945071qta.46.1680224256505;
        Thu, 30 Mar 2023 17:57:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:d9ee])
        by smtp.gmail.com with ESMTPSA id bn29-20020a05620a2add00b007441b675e81sm283005qkb.22.2023.03.30.17.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 17:57:35 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 0/3] Enable RCU semantics for task kptrs
Date:   Thu, 30 Mar 2023 19:57:30 -0500
Message-Id: <20230331005733.406202-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In commit 22df776a9a86 ("tasks: Extract rcu_users out of union"), the
'refcount_t rcu_users' field was extracted out of a union with the
'struct rcu_head rcu' field. This allows us to use the field for
refcounting struct task_struct with RCU protection, as the RCU callback
no longer flips rcu_users to be nonzero after the callback is scheduled.

This patch set leverages this to do a few things:

1. Marks struct task_struct as RCU safe in the verifier, allowing
   referenced kptr tasks stored in maps to be accessed in an RCU
   read region without acquiring a reference (with just a NULL check).
2. Makes bpf_task_acquire() a KF_ACQUIRE | KF_RCU | KF_RET_NULL kfunc.
3. Removes bpf_task_kptr_get() and bpf_task_acquire_not_zero(), as
   they're now redundant with the above two changes.
4. Updates selftests and documentation accordingly.

David Vernet (3):
  bpf: Make struct task_struct an RCU-safe type
  bpf: Remove now-defunct task kfuncs
  bpf,docs: Update documentation to reflect new task kfuncs

 Documentation/bpf/kfuncs.rst                  |  49 ++++++-
 kernel/bpf/helpers.c                          |  78 +----------
 kernel/bpf/verifier.c                         |   1 +
 .../selftests/bpf/prog_tests/task_kfunc.c     |   4 +-
 .../selftests/bpf/progs/rcu_read_lock.c       |   9 +-
 .../selftests/bpf/progs/task_kfunc_common.h   |   6 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  | 126 ++++++++----------
 .../selftests/bpf/progs/task_kfunc_success.c  |  76 +++++++++--
 8 files changed, 174 insertions(+), 175 deletions(-)

-- 
2.39.0

