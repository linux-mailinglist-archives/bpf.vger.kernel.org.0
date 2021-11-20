Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF38457C1E
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 08:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbhKTHd7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Nov 2021 02:33:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232750AbhKTHdp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Nov 2021 02:33:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D79260E94;
        Sat, 20 Nov 2021 07:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637393442;
        bh=+5RvHa5Ai/YCF3S6v0KXmQzd9HmqMFiM+R60ANhXvZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JqvOpFaZvSiSg05ffnTxgeAZVbDsDpJrweaUkeyC6+XBKPN5ci3EXmvgsoZHv9cQy
         Fk/ZnChWBlOf77zrFwtMS1zvKe9cneahfXEkC4Qg92gPpmch5Zs3qSnRoElzZrCuB5
         LULBq5hscr8gzsHs4OufNfI+k450KbRCVrm8YJWRjGzGCP+CuDzuyIHz1bewAcdgUU
         0tdJcfyL9BGIfLFU+jLaIMr3oFsMpklzeQwsrZWNVd1RclHR8HX6V5SNp3UusagnQ/
         ZdDeyfgaarZAxmMsHQPUNsNApUNdCUnhd5Nh3dyUnrM/0s0pr6X+dnnSIOSa7T6+8d
         KNG4buY68v6Mw==
Date:   Sat, 20 Nov 2021 15:30:11 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     bpf@vger.kernel.org, axboe@kernel.dk,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, yuq825@gmail.com, robdclark@gmail.com,
        sean@poorly.run, christian.koenig@amd.com, ray.huang@amd.com,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, jingoohan1@gmail.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzysztof.kozlowski@canonical.com,
        mani@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, gregkh@linuxfoundation.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sj@kernel.org, akpm@linux-foundation.org,
        thomas.hellstrom@linux.intel.com, matthew.auld@intel.com,
        colin.king@intel.com, geert@linux-m68k.org,
        linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH bpf] treewide: add missing includes masked by cgroup ->
 bpf dependency
Message-ID: <20211120073011.GA36650@Peter>
References: <20211120035253.72074-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120035253.72074-1-kuba@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 21-11-19 19:52:53, Jakub Kicinski wrote:
> cgroup.h (therefore swap.h, therefore half of the universe)
> includes bpf.h which in turn includes module.h and slab.h.
> Since we're about to get rid of that dependency we need
> to clean things up.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  static inline struct inode *bdev_file_inode(struct file *file)
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 7b9f69f21f1e..bca0de92802e 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -9,6 +9,7 @@
>  #include <linux/shmem_fs.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> +#include <linux/module.h>
>  
>  #ifdef CONFIG_X86
>  #include <asm/set_memory.h>
> diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.c b/drivers/gpu/drm/i915/gt/intel_gtt.c
> index 67d14afa6623..b67f620c3d93 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gtt.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gtt.c
> @@ -6,6 +6,7 @@
>  #include <linux/slab.h> /* fault-inject.h is not standalone! */
>  
>  #include <linux/fault-inject.h>
> +#include <linux/sched/mm.h>
>  
>  #include "gem/i915_gem_lmem.h"
>  #include "i915_trace.h"
> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
> index 820a1f38b271..89cccefeea63 100644
> --- a/drivers/gpu/drm/i915/i915_request.c
> +++ b/drivers/gpu/drm/i915/i915_request.c
> @@ -29,6 +29,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/clock.h>
>  #include <linux/sched/signal.h>
> +#include <linux/sched/mm.h>
>  
>  #include "gem/i915_gem_context.h"
>  #include "gt/intel_breadcrumbs.h"
> diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/lima_device.c
> index 65fdca366e41..f74f8048af8f 100644
> --- a/drivers/gpu/drm/lima/lima_device.c
> +++ b/drivers/gpu/drm/lima/lima_device.c
> @@ -4,6 +4,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/clk.h>
> +#include <linux/slab.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/platform_device.h>
>  
> diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> index 4a1420b05e97..086dacf2f26a 100644
> --- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
> +++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/vmalloc.h>
> +#include <linux/sched/mm.h>
>  
>  #include "msm_drv.h"
>  #include "msm_gem.h"
> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> index 7e83c00a3f48..79c870a3bef8 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> @@ -34,6 +34,7 @@
>  #include <linux/sched.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/file.h>
> +#include <linux/module.h>
>  #include <drm/drm_cache.h>
>  #include <drm/ttm/ttm_bo_driver.h>
>  
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_sriov.c b/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
> index a78c398bf5b2..01e7d3c0b68e 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
> @@ -8,6 +8,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/etherdevice.h>
>  #include <linux/netdevice.h>
> +#include <linux/module.h>
>  
>  #include "hinic_hw_dev.h"
>  #include "hinic_dev.h"
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
> index 0ef68fdd1f26..61c20907315f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
> @@ -5,6 +5,8 @@
>   *
>   */
>  
> +#include <linux/module.h>
> +
>  #include "otx2_common.h"
>  #include "otx2_ptp.h"
>  
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index c24dab383654..722dacdd5a17 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -19,6 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/module.h>
>  
>  #include "pcie-designware.h"
>  
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 7b17da2f9b3f..cfe66bf04c1d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -18,6 +18,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> +#include <linux/module.h>
>  
>  #include "pcie-designware.h"
>  
> diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
> index 84dadfa726aa..9643b905e2d8 100644
> --- a/drivers/usb/cdns3/host.c
> +++ b/drivers/usb/cdns3/host.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <linux/platform_device.h>
> +#include <linux/slab.h>

Should be "#include <linux/module.h>"?

-- 

Thanks,
Peter Chen

