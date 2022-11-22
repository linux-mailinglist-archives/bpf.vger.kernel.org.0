Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24436334EF
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 06:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiKVF4f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 00:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiKVF4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 00:56:18 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B18B2F037;
        Mon, 21 Nov 2022 21:55:45 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id s18so7903679qvo.9;
        Mon, 21 Nov 2022 21:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbC6RWqxQcfi8c8Q+b8E5olDweUU9SSn0fnLj/1TWLc=;
        b=GlVo6uk4sWTO+ORiYT8dgsSC27Ry5r99KYrW0cWzvLRHIX3w51o3CECa4fYIj7q/2z
         RTMYUHLUzgHdkEBLbD5glIQ5w5WWcY4kfm56VQsom4sX/nnbqd3cOyrTl6OWssGycpqC
         ZxLLAi7JFk18BDFAahJo2A2TOB1O8s7QueyCVjr7jQcZ0tVSmVU1fWsA50PdfuRvxcgf
         eoJ7stuSVcIdOoyoDJXg4tFZQ4eka+ZIGzLkbeR+3aapMwZy4iMQAOcHMhYiGqDt8uhg
         0egbtqruLj1WJI3FUo/a0Ehp2UZ5yTwMHyzt9q5qa7YrC60uN5Q9HXnBD5pOwootSYkj
         SBwA==
X-Gm-Message-State: ANoB5pl8eOeJFPlu67PT0j49kB4HFSO9xx2EdCEq1pXAWRPxGPb63MdT
        Mg13qbj5H9i59r655dwsPcOkNX1wgbz5Jcrg
X-Google-Smtp-Source: AA0mqf51Z46T8bbhyg07pi7LrUu8yRnA/rgK9JA9TsPC1BeGbDxHm58G3b01GuSiZmvWB/L12B39UA==
X-Received: by 2002:ad4:4d53:0:b0:4a0:6e55:e841 with SMTP id m19-20020ad44d53000000b004a06e55e841mr2526445qvm.110.1669096544423;
        Mon, 21 Nov 2022 21:55:44 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:3170])
        by smtp.gmail.com with ESMTPSA id c23-20020ac85197000000b003a623e5b9ecsm7242619qtn.78.2022.11.21.21.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 21:55:43 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/4] Support storing struct cgroup * objects as kptrs
Date:   Mon, 21 Nov 2022 23:54:54 -0600
Message-Id: <20221122055458.173143-1-void@manifault.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In [0], we added support for storing struct task_struct * objects as
kptrs. This patch set extends this effort to also include storing struct
cgroup * object as kptrs.

As with tasks, there are many possible use cases for storing cgroups in
maps. During tracing, for example, it could be useful to query cgroup
statistics such as PSI averages, or tracking which tasks are migrating
to and from the cgroup.

[0]: https://lore.kernel.org/all/20221120051004.3605026-1-void@manifault.com/

David Vernet (4):
  bpf: Enable cgroups to be used as kptrs
  selftests/bpf: Add cgroup kfunc / kptr selftests
  bpf: Add bpf_cgroup_ancestor() kfunc
  selftests/bpf: Add selftests for bpf_cgroup_ancestor() kfunc

 kernel/bpf/helpers.c                          | 103 ++++++-
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     | 175 ++++++++++++
 .../selftests/bpf/progs/cgrp_kfunc_common.h   |  72 +++++
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  | 260 ++++++++++++++++++
 .../selftests/bpf/progs/cgrp_kfunc_success.c  | 170 ++++++++++++
 6 files changed, 778 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c

-- 
2.38.1

