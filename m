Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809B6458B7F
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 10:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbhKVJci (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 04:32:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:53776 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230447AbhKVJch (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 04:32:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="320980423"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="320980423"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 01:29:31 -0800
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="508879579"
Received: from rmcdonax-mobl.ger.corp.intel.com (HELO localhost) ([10.252.19.217])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 01:29:13 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, axboe@kernel.dk,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        yuq825@gmail.com, robdclark@gmail.com, sean@poorly.run,
        christian.koenig@amd.com, ray.huang@amd.com, sgoutham@marvell.com,
        gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        jingoohan1@gmail.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        krzysztof.kozlowski@canonical.com, mani@kernel.org,
        pawell@cadence.com, peter.chen@kernel.org, rogerq@kernel.org,
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
In-Reply-To: <20211120035253.72074-1-kuba@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211120035253.72074-1-kuba@kernel.org>
Date:   Mon, 22 Nov 2021 11:29:10 +0200
Message-ID: <87fsroo7x5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 19 Nov 2021, Jakub Kicinski <kuba@kernel.org> wrote:
> cgroup.h (therefore swap.h, therefore half of the universe)
> includes bpf.h which in turn includes module.h and slab.h.
> Since we're about to get rid of that dependency we need
> to clean things up.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: axboe@kernel.dk
> CC: maarten.lankhorst@linux.intel.com
> CC: mripard@kernel.org
> CC: tzimmermann@suse.de
> CC: airlied@linux.ie
> CC: daniel@ffwll.ch
> CC: jani.nikula@linux.intel.com
> CC: joonas.lahtinen@linux.intel.com
> CC: rodrigo.vivi@intel.com
> CC: yuq825@gmail.com
> CC: robdclark@gmail.com
> CC: sean@poorly.run
> CC: christian.koenig@amd.com
> CC: ray.huang@amd.com
> CC: sgoutham@marvell.com
> CC: gakula@marvell.com
> CC: sbhatta@marvell.com
> CC: hkelam@marvell.com
> CC: jingoohan1@gmail.com
> CC: lorenzo.pieralisi@arm.com
> CC: robh@kernel.org
> CC: kw@linux.com
> CC: bhelgaas@google.com
> CC: krzysztof.kozlowski@canonical.com
> CC: mani@kernel.org
> CC: pawell@cadence.com
> CC: peter.chen@kernel.org
> CC: rogerq@kernel.org
> CC: a-govindraju@ti.com
> CC: gregkh@linuxfoundation.org
> CC: ast@kernel.org
> CC: daniel@iogearbox.net
> CC: andrii@kernel.org
> CC: kafai@fb.com
> CC: songliubraving@fb.com
> CC: yhs@fb.com
> CC: john.fastabend@gmail.com
> CC: kpsingh@kernel.org
> CC: sj@kernel.org
> CC: akpm@linux-foundation.org
> CC: thomas.hellstrom@linux.intel.com
> CC: matthew.auld@intel.com
> CC: colin.king@intel.com
> CC: geert@linux-m68k.org
> CC: linux-block@vger.kernel.org
> CC: dri-devel@lists.freedesktop.org
> CC: intel-gfx@lists.freedesktop.org
> CC: lima@lists.freedesktop.org
> CC: linux-arm-msm@vger.kernel.org
> CC: freedreno@lists.freedesktop.org
> CC: linux-pci@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-samsung-soc@vger.kernel.org
> CC: linux-usb@vger.kernel.org
> CC: bpf@vger.kernel.org
> CC: linux-mm@kvack.org
>
> Well, let's see if this makes it thru email servers...
> ---
>  block/fops.c                                          | 1 +
>  drivers/gpu/drm/drm_gem_shmem_helper.c                | 1 +
>  drivers/gpu/drm/i915/gt/intel_gtt.c                   | 1 +
>  drivers/gpu/drm/i915/i915_request.c                   | 1 +

For the i915 parts,

Acked-by: Jani Nikula <jani.nikula@intel.com>


-- 
Jani Nikula, Intel Open Source Graphics Center
