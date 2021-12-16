Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580ED47685F
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 03:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhLPCzo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 21:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbhLPCzn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 21:55:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65939C06173F
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 18:55:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EE2EB82286
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 02:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC256C36AE0;
        Thu, 16 Dec 2021 02:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639623341;
        bh=HiFl2b7gez+FJ8ZxxyfPUhvXE/yvuUjuUCdiClIMHak=;
        h=From:To:Cc:Subject:Date:From;
        b=H5GHUVc+J3SSFToaFdqApAIkU2RMRkVlum/2MdwVhVP07b7RHvAI92louE1VOrVYX
         9d2WHfG1pln41GKv+u6mFxtt4w+Ym1ezXJnrd+D253QON8jQNV0wna80TaA574BI3h
         jr/Wc+S5HzH+wIWoiU3vdpyW+HmfcZKxNz4U1z7IU9c3Cgw5KSzsbXtNk4xI8uurEf
         i17sLhHDXZpXz7Heg+sZMGV5f0J/xJwtFTAmfuZZVnn5zqBrKtBkTW0zwGj6JyYZpD
         FoiY+5FoVxmsn67AY1ss0zZNLjvg4tVj/0wHZn3zO/eXB2CAXs64z7Bo8ftu8JUkqM
         pK6epX+S6IcjQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v5 0/3] bpf: remove the cgroup -> bpf header dependecy
Date:   Wed, 15 Dec 2021 18:55:35 -0800
Message-Id: <20211216025538.1649516-1-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes to bpf.h tend to clog up our build systems. The netdev/bpf
build bot does incremental builds to save time (reusing the build
directory to only rebuild changed objects).

This is the rough breakdown of how many objects needs to be rebuilt
based on file touched:

kernel.h      40633
bpf.h         17881
bpf-cgroup.h  17875
skbuff.h      10696
bpf-netns.h    7604
netdevice.h    7452
filter.h       5003
sock.h         4959
tcp.h          4048

As the stats show touching bpf.h is _very_ expensive.

Bulk of the objects get rebuilt because MM includes cgroup headers.
Luckily bpf-cgroup.h does not fundamentally depend on bpf.h so we
can break that dependency and reduce the number of objects.

With the patches applied touching bpf.h causes 5019 objects to be rebuilt
(17881 / 5019 = 3.56x). That's pretty much down to filter.h plus noise.

v2:
Try to make the new headers wider in scope. Collapse bpf-link and
bpf-cgroup-types into one header, which may serve as "BPF kernel
API" header in the future if needed. Rename bpf-cgroup-storage.h
to bpf-inlines.h.

Add a fix for the s390 build issue.

v3: https://lore.kernel.org/all/20211215061916.715513-1-kuba@kernel.org/
Merge bpf-includes.h into bpf.h.

v4: https://lore.kernel.org/all/20211215181231.1053479-1-kuba@kernel.org/
Change course - break off cgroup instead of breaking off bpf.

v5:
Add forward declaration of struct bpf_prog to perf_event.h
when !CONFIG_BPF_SYSCALL (kbuild bot).

Jakub Kicinski (3):
  add includes masked by cgroup -> bpf dependency
  add missing bpf-cgroup.h includes
  bpf: remove the cgroup -> bpf header dependecy

 arch/s390/mm/hugetlbpage.c      |  1 +
 include/linux/bpf-cgroup-defs.h | 70 +++++++++++++++++++++++++++++++++
 include/linux/bpf-cgroup.h      | 57 +--------------------------
 include/linux/cgroup-defs.h     |  2 +-
 include/linux/perf_event.h      |  1 +
 kernel/bpf/helpers.c            |  1 +
 kernel/bpf/syscall.c            |  1 +
 kernel/bpf/verifier.c           |  1 +
 kernel/cgroup/cgroup.c          |  1 +
 kernel/trace/trace_kprobe.c     |  1 +
 kernel/trace/trace_uprobe.c     |  1 +
 net/ipv4/udp.c                  |  1 +
 net/ipv6/udp.c                  |  1 +
 net/socket.c                    |  1 +
 security/device_cgroup.c        |  1 +
 15 files changed, 84 insertions(+), 57 deletions(-)
 create mode 100644 include/linux/bpf-cgroup-defs.h

-- 
2.31.1

