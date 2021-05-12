Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BDC37B9D2
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 11:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhELKAL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 06:00:11 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50259 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230096AbhELKAL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 12 May 2021 06:00:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yunbo.xufeng@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UYdyiiS_1620813539;
Received: from localhost.localdomain(mailfrom:yunbo.xufeng@linux.alibaba.com fp:SMTPD_---0UYdyiiS_1620813539)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 May 2021 17:59:00 +0800
From:   Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>
To:     kpsingh@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     revest@chromium.org, jackmanb@chromium.org, yhs@fb.com,
        songliubraving@fb.com, kafai@fb.com, john.fastabend@gmail.com,
        joe@cilium.io, quentin@isovalent.com,
        Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>
Subject: [RFC] [PATCH bpf-next 0/1] Implement getting cgroup path bpf helper
Date:   Wed, 12 May 2021 17:58:22 +0800
Message-Id: <20210512095823.99162-1-yunbo.xufeng@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order to protect the running application containers by utilizing
bpf LSM, we need to upload the security rules into bpf maps in container
granularity, however, there is no effective bpf helper to identify the
container, especially for cgroup v1. Generally, the only thing which the
user side can get is container ID, and the cgroup path for this running
container is fixed if we know the container ID, therefore, bpf programs
also need to get the cgroup path for the running task in order to apply
security rules stored in bpf maps.

This patch add a bpf helper - bpf_get_current_cpuset_cgroup_path(), which
return the cpuset cgroup path for the current task, since cgroup_path_ns()
can sleep, this helper is only allowed for sleepable LSM hooks.

Concern:
  Since cgroup_path_ns() takes 'cgroup_mutex' and 'css_set_lock' lock,
  I'm not sure if there is any dead lock code path in LSM hooks.

Xufeng Zhang (1):
bpf: Add a BPF helper for getting the cgroup path of current task
---
 include/uapi/linux/bpf.h       | 13 +++++++++++++
 kernel/bpf/bpf_lsm.c           | 28 ++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 13 +++++++++++++
 3 files changed, 54 insertions(+)
