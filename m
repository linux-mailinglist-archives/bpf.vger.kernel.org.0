Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC7647605A
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 19:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbhLOSMe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 13:12:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40462 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhLOSMe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 13:12:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26A9C61A0D
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 18:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B39C36AE2;
        Wed, 15 Dec 2021 18:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639591953;
        bh=USDPYtiH9PbIaetruFrQY8DHH7jgBgupjWHmPoaJfu8=;
        h=From:To:Cc:Subject:Date:From;
        b=lHMT4yd54cwvzl6an7nSTwXuzPUgcIDoXpsyUnOr0RicC4IpPReo5MDoYElSp8U+W
         V3ouK4Urq7bhQusxPgIJgyUN18ErM7geeA0yGp7lq0PDwyF+S2lCwiwrgm3a+bGCqt
         BoWzr0RXp146se/D4U5dMPmebrKlku4lxvWnoFY1o9DJE6+xsFauR0UubBYLRZv2Qu
         z9g7HC5hmKIprZz0fes9olZsAQwkOm0mxfmAvrjxBr5k/LOqgNl2nrMQ4+/QiMdpC5
         sDKlsHrk4AGL9JllRLGqiIvii9Q55EWm8R6cdYHxBEzuWBCjopxFFEP2YIaN9s5bv3
         DG05pKIJV+2Cw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v4 0/3] bpf: remove the cgroup -> bpf header dependecy
Date:   Wed, 15 Dec 2021 10:12:28 -0800
Message-Id: <20211215181231.1053479-1-kuba@kernel.org>
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
tcp.h          4048
sock.h         4959

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
Remember to git format-patch after fixing build issues.

v4:
Change course - break off cgroup instead of breaking off bpf.

Jakub Kicinski (3):
  add includes masked by cgroup -> bpf dependency
  add missing bpf-cgroup.h includes
  bpf: remove the cgroup -> bpf header dependecy

 arch/s390/mm/hugetlbpage.c      |  1 +
 include/linux/bpf-cgroup-defs.h | 70 +++++++++++++++++++++++++++++++++
 include/linux/bpf-cgroup.h      | 57 +--------------------------
 include/linux/cgroup-defs.h     |  2 +-
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
 14 files changed, 83 insertions(+), 57 deletions(-)
 create mode 100644 include/linux/bpf-cgroup-defs.h

-- 
2.31.1

