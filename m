Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D33457AED
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 04:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhKTD4I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 22:56:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhKTD4I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 22:56:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 939FF60EBD;
        Sat, 20 Nov 2021 03:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637380385;
        bh=MPXp1QGXgUy21poiTg6O1s2Zh/1I/eH6DmPFLVJRgTM=;
        h=From:To:Cc:Subject:Date:From;
        b=r4v1RdmZxd1nL6ySESYEQBoNU89dQ+Xqv4j7vh0qbt6gsjglfZqlFgJWkFIZt2mlE
         PPQ3Vi4NAQdln03a6CZOKI0MK8x/oVo+gjOJ6CS0KxMuvj+cUdmOeydWxBlh2BdY3z
         l386m7ead1egf9dv8j1S1EqRrI57Li8OBPT0C5lDHA3TsoMZ6e4dMCzKMbsj7YdMeR
         aT/4CdiQmwMMKoibcfzWQMhFpo2Eqsg4SUKmrr6eX9mMue5aU8/l9V1nRdra/N6cG5
         NXwVhHzD+MaROsQL9qRWz7hYC3E/OX3wJk7bUgDl3f0xhhY55AqbR0zTLlrwxQySTP
         GoQJnuJ7lsmbw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, axboe@kernel.dk,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, yuq825@gmail.com, robdclark@gmail.com,
        sean@poorly.run, christian.koenig@amd.com, ray.huang@amd.com,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, jingoohan1@gmail.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzysztof.kozlowski@canonical.com,
        mani@kernel.org, pawell@cadence.com, peter.chen@kernel.org,
        rogerq@kernel.org, a-govindraju@ti.com, gregkh@linuxfoundation.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sj@kernel.org,
        akpm@linux-foundation.org, thomas.hellstrom@linux.intel.com,
        matthew.auld@intel.com, colin.king@intel.com, geert@linux-m68k.org,
        linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH bpf] treewide: add missing includes masked by cgroup -> bpf dependency
Date:   Fri, 19 Nov 2021 19:52:53 -0800
Message-Id: <20211120035253.72074-1-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cgroup.h (therefore swap.h, therefore half of the universe)
includes bpf.h which in turn includes module.h and slab.h.
Since we're about to get rid of that dependency we need
to clean things up.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: axboe@kernel.dk
CC: maarten.lankhorst@linux.intel.com
CC: mripard@kernel.org
CC: tzimmermann@suse.de
CC: airlied@linux.ie
CC: daniel@ffwll.ch
CC: jani.nikula@linux.intel.com
CC: joonas.lahtinen@linux.intel.com
CC: rodrigo.vivi@intel.com
CC: yuq825@gmail.com
CC: robdclark@gmail.com
CC: sean@poorly.run
CC: christian.koenig@amd.com
CC: ray.huang@amd.com
CC: sgoutham@marvell.com
CC: gakula@marvell.com
CC: sbhatta@marvell.com
CC: hkelam@marvell.com
CC: jingoohan1@gmail.com
CC: lorenzo.pieralisi@arm.com
CC: robh@kernel.org
CC: kw@linux.com
CC: bhelgaas@google.com
CC: krzysztof.kozlowski@canonical.com
CC: mani@kernel.org
CC: pawell@cadence.com
CC: peter.chen@kernel.org
CC: rogerq@kernel.org
CC: a-govindraju@ti.com
CC: gregkh@linuxfoundation.org
CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: andrii@kernel.org
CC: kafai@fb.com
CC: songliubraving@fb.com
CC: yhs@fb.com
CC: john.fastabend@gmail.com
CC: kpsingh@kernel.org
CC: sj@kernel.org
CC: akpm@linux-foundation.org
CC: thomas.hellstrom@linux.intel.com
CC: matthew.auld@intel.com
CC: colin.king@intel.com
CC: geert@linux-m68k.org
CC: linux-block@vger.kernel.org
CC: dri-devel@lists.freedesktop.org
CC: intel-gfx@lists.freedesktop.org
CC: lima@lists.freedesktop.org
CC: linux-arm-msm@vger.kernel.org
CC: freedreno@lists.freedesktop.org
CC: linux-pci@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-samsung-soc@vger.kernel.org
CC: linux-usb@vger.kernel.org
CC: bpf@vger.kernel.org
CC: linux-mm@kvack.org

Well, let's see if this makes it thru email servers...
---
 block/fops.c                                          | 1 +
 drivers/gpu/drm/drm_gem_shmem_helper.c                | 1 +
 drivers/gpu/drm/i915/gt/intel_gtt.c                   | 1 +
 drivers/gpu/drm/i915/i915_request.c                   | 1 +
 drivers/gpu/drm/lima/lima_device.c                    | 1 +
 drivers/gpu/drm/msm/msm_gem_shrinker.c                | 1 +
 drivers/gpu/drm/ttm/ttm_tt.c                          | 1 +
 drivers/net/ethernet/huawei/hinic/hinic_sriov.c       | 1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c | 2 ++
 drivers/pci/controller/dwc/pci-exynos.c               | 1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c             | 1 +
 drivers/usb/cdns3/host.c                              | 1 +
 include/linux/device/driver.h                         | 1 +
 include/linux/filter.h                                | 2 +-
 mm/damon/vaddr.c                                      | 1 +
 mm/memory_hotplug.c                                   | 1 +
 mm/swap_slots.c                                       | 1 +
 17 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index ad732a36f9b3..3cb1e81929bc 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -15,6 +15,7 @@
 #include <linux/falloc.h>
 #include <linux/suspend.h>
 #include <linux/fs.h>
+#include <linux/module.h>
 #include "blk.h"
 
 static inline struct inode *bdev_file_inode(struct file *file)
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 7b9f69f21f1e..bca0de92802e 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -9,6 +9,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/module.h>
 
 #ifdef CONFIG_X86
 #include <asm/set_memory.h>
diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.c b/drivers/gpu/drm/i915/gt/intel_gtt.c
index 67d14afa6623..b67f620c3d93 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h> /* fault-inject.h is not standalone! */
 
 #include <linux/fault-inject.h>
+#include <linux/sched/mm.h>
 
 #include "gem/i915_gem_lmem.h"
 #include "i915_trace.h"
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 820a1f38b271..89cccefeea63 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -29,6 +29,7 @@
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/mm.h>
 
 #include "gem/i915_gem_context.h"
 #include "gt/intel_breadcrumbs.h"
diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/lima_device.c
index 65fdca366e41..f74f8048af8f 100644
--- a/drivers/gpu/drm/lima/lima_device.c
+++ b/drivers/gpu/drm/lima/lima_device.c
@@ -4,6 +4,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/clk.h>
+#include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 4a1420b05e97..086dacf2f26a 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/vmalloc.h>
+#include <linux/sched/mm.h>
 
 #include "msm_drv.h"
 #include "msm_gem.h"
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 7e83c00a3f48..79c870a3bef8 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -34,6 +34,7 @@
 #include <linux/sched.h>
 #include <linux/shmem_fs.h>
 #include <linux/file.h>
+#include <linux/module.h>
 #include <drm/drm_cache.h>
 #include <drm/ttm/ttm_bo_driver.h>
 
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_sriov.c b/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
index a78c398bf5b2..01e7d3c0b68e 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/etherdevice.h>
 #include <linux/netdevice.h>
+#include <linux/module.h>
 
 #include "hinic_hw_dev.h"
 #include "hinic_dev.h"
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
index 0ef68fdd1f26..61c20907315f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
@@ -5,6 +5,8 @@
  *
  */
 
+#include <linux/module.h>
+
 #include "otx2_common.h"
 #include "otx2_ptp.h"
 
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index c24dab383654..722dacdd5a17 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
+#include <linux/module.h>
 
 #include "pcie-designware.h"
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 7b17da2f9b3f..cfe66bf04c1d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -18,6 +18,7 @@
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/module.h>
 
 #include "pcie-designware.h"
 
diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index 84dadfa726aa..9643b905e2d8 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include "core.h"
 #include "drd.h"
 #include "host-export.h"
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index a498ebcf4993..15e7c5e15d62 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -18,6 +18,7 @@
 #include <linux/klist.h>
 #include <linux/pm.h>
 #include <linux/device/bus.h>
+#include <linux/module.h>
 
 /**
  * enum probe_type - device driver probe type to try
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 24b7ed2677af..871e1673dc88 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -6,6 +6,7 @@
 #define __LINUX_FILTER_H__
 
 #include <linux/atomic.h>
+#include <linux/bpf.h>
 #include <linux/refcount.h>
 #include <linux/compat.h>
 #include <linux/skbuff.h>
@@ -26,7 +27,6 @@
 
 #include <asm/byteorder.h>
 #include <uapi/linux/filter.h>
-#include <uapi/linux/bpf.h>
 
 struct sk_buff;
 struct sock;
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 35fe49080ee9..47f47f60440e 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -13,6 +13,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
 #include <linux/pagewalk.h>
+#include <linux/sched/mm.h>
 
 #include "prmtv-common.h"
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 852041f6be41..2a9627dc784c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -35,6 +35,7 @@
 #include <linux/memblock.h>
 #include <linux/compaction.h>
 #include <linux/rmap.h>
+#include <linux/module.h>
 
 #include <asm/tlbflush.h>
 
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 16f706c55d92..2b5531840583 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -30,6 +30,7 @@
 #include <linux/swap_slots.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
+#include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/mutex.h>
 #include <linux/mm.h>
-- 
2.31.1

