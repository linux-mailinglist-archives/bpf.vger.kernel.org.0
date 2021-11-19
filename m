Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABA04576B1
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 19:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhKSSxz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 13:53:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233284AbhKSSxu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 13:53:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4ABAE61A86;
        Fri, 19 Nov 2021 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637347847;
        bh=PStOTv82i8pael9g1fxcdETYpOj1sWI/gPQbeKPOwis=;
        h=From:To:Cc:Subject:Date:From;
        b=WseMCbzNWirZm4T67HTcHhNITypIPr7Bdc1Oxy1MlT17j83xrSXyYxOaiPUo8skXS
         twnbNqFqygpzcSQBh606v+xrQ8XkqsoBvpd8lAHAt/70tSMhAWLoITnVj5yAc5sVvO
         r5HB6tWFMxNYg85LFVwe9sYm+fap6ZVIu4872tUO6tcZ06sZQQ6u1YDuLxT6Se+QhV
         +jqNUjFzTaCuan9Z8RoGr4hPy1UXhBNtDhJsH+JTBWSSJ/FKRp9BZQeOBiLZYmez3w
         aVqTVGF9XFNf6uhccTlBaxSgR5TaDUhwI2QLwlAW7Ma8QTH3LyQHKkx/1823GG+9IR
         Ai8Czxui17Eng==
From:   Jakub Kicinski <kuba@kernel.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [RFC bpf-next 0/6] bpf: remove the cgroup -> bpf header dependecy
Date:   Fri, 19 Nov 2021 10:50:37 -0800
Message-Id: <20211119185043.3937836-1-kuba@kernel.org>
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

As the stats show touching bpf.h is _very_ expensive. Recent 20+ patch
series from Jirka took 10 hours to build patch-by-patch on a 72 CPU VM.

Bulk of the objects get rebuilt because MM includes cgroup headers.
Luckily bpf-cgroup.h does not fundamentally depend on bpf.h so we
can break that dependency and reduce the number of objects.

With the patches applied touching bpf.h causes 5019 objects to be rebuilt
(17881 / 5019 = 3.56x). That's pretty much down to filter.h plus noise.

Sending as an RFC because:
 - bpf-link.h or bpf_link.h ?
 - we probably want the header include fixes to go via bpf first

Jakub Kicinski (6):
  treewide: add missing includes masked by cgroup -> bpf dependency
  bpf: add header for enum bpf_cgroup_storage_type
  bpf: create a header for cgroup_storage_type()
  bpf: create a header for struct bpf_link
  bpf: remove the cgroup -> bpf header dependecy
  bpf: push down the bpf-link include

 block/fops.c                                  |  1 +
 drivers/gpu/drm/drm_gem_shmem_helper.c        |  1 +
 drivers/gpu/drm/i915/gt/intel_gtt.c           |  1 +
 drivers/gpu/drm/i915/i915_request.c           |  1 +
 drivers/gpu/drm/lima/lima_device.c            |  1 +
 drivers/gpu/drm/msm/msm_gem_shrinker.c        |  1 +
 drivers/gpu/drm/ttm/ttm_tt.c                  |  1 +
 .../net/ethernet/huawei/hinic/hinic_sriov.c   |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_ptp.c |  2 ++
 drivers/pci/controller/dwc/pci-exynos.c       |  1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  1 +
 drivers/usb/cdns3/host.c                      |  1 +
 include/linux/bpf-cgroup-storage.h            | 17 ++++++++++++++
 include/linux/bpf-cgroup-types.h              | 13 +++++++++++
 include/linux/bpf-cgroup.h                    | 13 +++--------
 include/linux/bpf-link.h                      | 23 +++++++++++++++++++
 include/linux/bpf.h                           | 19 ++-------------
 include/linux/device/driver.h                 |  1 +
 include/linux/filter.h                        |  2 +-
 kernel/bpf/bpf_iter.c                         |  1 +
 kernel/bpf/helpers.c                          |  1 +
 kernel/bpf/local_storage.c                    |  1 +
 kernel/bpf/syscall.c                          |  1 +
 mm/damon/vaddr.c                              |  1 +
 mm/memory_hotplug.c                           |  1 +
 mm/swap_slots.c                               |  1 +
 net/core/dev.c                                |  1 +
 27 files changed, 81 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/bpf-cgroup-storage.h
 create mode 100644 include/linux/bpf-cgroup-types.h
 create mode 100644 include/linux/bpf-link.h

-- 
2.31.1

