Return-Path: <bpf+bounces-49648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E57FA1AF51
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 05:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35B03A38C6
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 04:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AF51D86ED;
	Fri, 24 Jan 2025 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M881ePrX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF723B0;
	Fri, 24 Jan 2025 04:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737691848; cv=none; b=aJ9i071lPCRnsMwPpCgtA6DHAECtJAg7J8/mmE48JQU/PODE6OermyJ++Y9PZViazJ+PFPpt+Dwt1XvGcBTm08QAcaiq1SevPIlq9ui6H1sBwgfEk8geDaC6F1wbA/zgNuq7WfxLKn0N8O2JJtv6LAoMkRaB1T0JSKq6+jp0VSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737691848; c=relaxed/simple;
	bh=MIJ1jgZDwALjGwqZaVentcWeZw4dsL9WAxAAZDG/1Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ov9ciUA6S0t9w7ivl3ag9MpoO9oOTgXuLHr7zJz4tCLBjJtUZD615ARb/I6s612ObN/Fpg8vkp8v1rshPWoJhMnxB/MJOx838V4iRvEsdOIfXutOiOjfc7qe90zmsKyND/3QpSzM2CExQrAWJwY0IZHLwIse1rrp8uqhHa3t8VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M881ePrX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737691846; x=1769227846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MIJ1jgZDwALjGwqZaVentcWeZw4dsL9WAxAAZDG/1Uo=;
  b=M881ePrXFXOhtarPbrt78dCJw3SkhnSf4VpyHv8cgtBamSQimTyu579W
   mIB5EqwD9GPhE0INC2461FXA+FIimvDokuEclWkpLkaJRWq5DFf9amake
   UpHtKNG5B2t7pktiJ45Byd8DciCZ4gaxlg5ZWXYDTHoK/2jgt+MWEInIy
   gI7oohUMDHw0UfQGOy+VitAI3tBNmGkmDGHL05TpJwIFcobrq+fjd5X3c
   D9qcU8eRMtpYUfrQ0FmN13QjyFOU5c2ZNev9Um3v03KUWrGuiVXndTtyz
   nN0J8nxwEf496Syr9jlfXQyTxn+uLlxOuZR3ygw8bIf1DIkw3r38qaA87
   A==;
X-CSE-ConnectionGUID: RmxlPdaESyWJns9U4GrhXA==
X-CSE-MsgGUID: hF7TGNpPRnGZnWz0lZtRaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="55764030"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="55764030"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 20:10:45 -0800
X-CSE-ConnectionGUID: KBf9L3xqRj2dTmcFB3GFfA==
X-CSE-MsgGUID: 6iz2VM1SRCWJIdgpFZtQ5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="112671059"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jan 2025 20:10:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tbB1i-000c7v-10;
	Fri, 24 Jan 2025 04:10:38 +0000
Date: Fri, 24 Jan 2025 12:10:17 +0800
From: kernel test robot <lkp@intel.com>
To: Suman Ghosh <sumang@marvell.com>, horms@kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
	hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Suman Ghosh <sumang@marvell.com>
Subject: Re: [net-next PATCH v4 3/6] octeontx2-pf: AF_XDP zero copy receive
 support
Message-ID: <202501241139.g1v0lH4V-lkp@intel.com>
References: <20250116191116.3357181-4-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116191116.3357181-4-sumang@marvell.com>

Hi Suman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Suman-Ghosh/octeontx2-pf-Don-t-unmap-page-pool-buffer/20250117-031510
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250116191116.3357181-4-sumang%40marvell.com
patch subject: [net-next PATCH v4 3/6] octeontx2-pf: AF_XDP zero copy receive support
config: loongarch-randconfig-001-20250124 (https://download.01.org/0day-ci/archive/20250124/202501241139.g1v0lH4V-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250124/202501241139.g1v0lH4V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501241139.g1v0lH4V-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c: In function 'otx2_probe':
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:3222:1: warning: label 'err_dcbnl_set_ops' defined but not used [-Wunused-label]
    3222 | err_dcbnl_set_ops:
         | ^~~~~~~~~~~~~~~~~


vim +/err_dcbnl_set_ops +3222 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

  3217	
  3218		otx2_qos_init(pf, qos_txqs);
  3219	
  3220		return 0;
  3221	
> 3222	err_dcbnl_set_ops:
  3223		bitmap_free(pf->af_xdp_zc_qidx);
  3224	err_af_xdp_zc:
  3225		otx2_sriov_vfcfg_cleanup(pf);
  3226	err_pf_sriov_init:
  3227		otx2_shutdown_tc(pf);
  3228	err_mcam_flow_del:
  3229		otx2_mcam_flow_del(pf);
  3230	err_unreg_netdev:
  3231		unregister_netdev(netdev);
  3232	err_ipsec_clean:
  3233		cn10k_ipsec_clean(pf);
  3234	err_mcs_free:
  3235		cn10k_mcs_free(pf);
  3236	err_del_mcam_entries:
  3237		otx2_mcam_flow_del(pf);
  3238	err_ptp_destroy:
  3239		otx2_ptp_destroy(pf);
  3240	err_detach_rsrc:
  3241		if (pf->hw.lmt_info)
  3242			free_percpu(pf->hw.lmt_info);
  3243		if (test_bit(CN10K_LMTST, &pf->hw.cap_flag))
  3244			qmem_free(pf->dev, pf->dync_lmt);
  3245		otx2_detach_resources(&pf->mbox);
  3246		otx2_disable_mbox_intr(pf);
  3247		otx2_pfaf_mbox_destroy(pf);
  3248		pci_free_irq_vectors(hw->pdev);
  3249	err_free_netdev:
  3250		pci_set_drvdata(pdev, NULL);
  3251		free_netdev(netdev);
  3252	err_release_regions:
  3253		pci_release_regions(pdev);
  3254		return err;
  3255	}
  3256	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

