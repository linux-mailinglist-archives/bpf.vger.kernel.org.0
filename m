Return-Path: <bpf+bounces-49253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B41A15C37
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 10:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BCF21887BD8
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 09:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BA418873E;
	Sat, 18 Jan 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQew/f41"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B072A176AB5;
	Sat, 18 Jan 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737193438; cv=none; b=JQPfm1A8MUuompn31oOR2teEexjadq61a7ldSmMbAPQCCKEnMI8Hu5YbQjzsF3x0beWEueknOpjNkeLUDXnxDFUH4BjSeJEJsqa7f5JSWgw1dhCyBo37V5k64/zJB/w6iekBOt6Un57S9AiAEuRZ1tyIw7n0or1e2kcYrFauyBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737193438; c=relaxed/simple;
	bh=DZn3SLH5AzE3aHMq6EC3TENadrF6Smv7SFRMTVHdYYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=et5eoMEexf+wamtY5jcnJPHEpB2Kow07pfgVQrD2GtlWG7VdCAGDJ25rfYyxOmZFVRFpGkS7h4Y4PpchrssGfPp4XGSi4bzKIt6/tfioNwpTf5Y10YU8UgeVvFJNeso4kWz/0rFWtuf/sPcLL8UdA+BJuQoKy6has9Fd2NSmwxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQew/f41; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737193435; x=1768729435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DZn3SLH5AzE3aHMq6EC3TENadrF6Smv7SFRMTVHdYYk=;
  b=eQew/f41hendHMT2/p3HuhzwCS43FiJcpXoWjW+RCM2cyWpRycQ9MK3O
   PuyyVKJUir98AcLQnAPImgbr0/6MtbgluBEB/3xaPPteV6K4mgyAs8FM3
   tX6NrjKrHL90uOcqJ1sRjFpVbEYnRq6CiHg4WTgAcxo7FYsvcHarOu0BZ
   StcXMs3tsuswDAe1Y8K7idCTOb60SnavnTrgEisOF+5oij3HlbGbsFbOa
   Lpy0BklNVqHrXySiIasZFfV4Pz0KL4Ospo3pSMCz/Khyh3rhvngG+e/iH
   8a6MGo1BJ3sQ1Rv8aPnHnF2XRRrHrrM7WmZ+HZ6oFK7HaqfAYkP1Aln7U
   w==;
X-CSE-ConnectionGUID: wx6qLCW+TaWTEU2W4ltgTQ==
X-CSE-MsgGUID: 583w82ctTs+sKB2WZZxjPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="62997014"
X-IronPort-AV: E=Sophos;i="6.13,214,1732608000"; 
   d="scan'208";a="62997014"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2025 01:43:55 -0800
X-CSE-ConnectionGUID: /JYe9enJRKaTjHIOzPhqeA==
X-CSE-MsgGUID: qRDORRzrSoGszkCXSOD4gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,214,1732608000"; 
   d="scan'208";a="111018072"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 18 Jan 2025 01:43:50 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZ5Mp-000UHT-3B;
	Sat, 18 Jan 2025 09:43:47 +0000
Date: Sat, 18 Jan 2025 17:43:44 +0800
From: kernel test robot <lkp@intel.com>
To: Suman Ghosh <sumang@marvell.com>, horms@kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
	hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Suman Ghosh <sumang@marvell.com>
Subject: Re: [net-next PATCH v4 3/6] octeontx2-pf: AF_XDP zero copy receive
 support
Message-ID: <202501181725.LopOJSa2-lkp@intel.com>
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
config: arm64-randconfig-001-20250118 (https://download.01.org/0day-ci/archive/20250118/202501181725.LopOJSa2-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250118/202501181725.LopOJSa2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501181725.LopOJSa2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c:740:1: warning: unused label 'err_dcbnl_set_ops' [-Wunused-label]
     740 | err_dcbnl_set_ops:
         | ^~~~~~~~~~~~~~~~~~
   1 warning generated.
--
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:3222:1: warning: unused label 'err_dcbnl_set_ops' [-Wunused-label]
    3222 | err_dcbnl_set_ops:
         | ^~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/err_dcbnl_set_ops +740 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c

   535	
   536	static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
   537	{
   538		int num_vec = pci_msix_vec_count(pdev);
   539		struct device *dev = &pdev->dev;
   540		int err, qcount, qos_txqs;
   541		struct net_device *netdev;
   542		struct otx2_nic *vf;
   543		struct otx2_hw *hw;
   544	
   545		err = pcim_enable_device(pdev);
   546		if (err) {
   547			dev_err(dev, "Failed to enable PCI device\n");
   548			return err;
   549		}
   550	
   551		err = pci_request_regions(pdev, DRV_NAME);
   552		if (err) {
   553			dev_err(dev, "PCI request regions failed 0x%x\n", err);
   554			return err;
   555		}
   556	
   557		err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
   558		if (err) {
   559			dev_err(dev, "DMA mask config failed, abort\n");
   560			goto err_release_regions;
   561		}
   562	
   563		pci_set_master(pdev);
   564	
   565		qcount = num_online_cpus();
   566		qos_txqs = min_t(int, qcount, OTX2_QOS_MAX_LEAF_NODES);
   567		netdev = alloc_etherdev_mqs(sizeof(*vf), qcount + qos_txqs, qcount);
   568		if (!netdev) {
   569			err = -ENOMEM;
   570			goto err_release_regions;
   571		}
   572	
   573		pci_set_drvdata(pdev, netdev);
   574		SET_NETDEV_DEV(netdev, &pdev->dev);
   575		vf = netdev_priv(netdev);
   576		vf->netdev = netdev;
   577		vf->pdev = pdev;
   578		vf->dev = dev;
   579		vf->iommu_domain = iommu_get_domain_for_dev(dev);
   580	
   581		vf->flags |= OTX2_FLAG_INTF_DOWN;
   582		hw = &vf->hw;
   583		hw->pdev = vf->pdev;
   584		hw->rx_queues = qcount;
   585		hw->tx_queues = qcount;
   586		hw->max_queues = qcount;
   587		hw->non_qos_queues = qcount;
   588		hw->rbuf_len = OTX2_DEFAULT_RBUF_LEN;
   589		/* Use CQE of 128 byte descriptor size by default */
   590		hw->xqe_size = 128;
   591	
   592		hw->irq_name = devm_kmalloc_array(&hw->pdev->dev, num_vec, NAME_SIZE,
   593						  GFP_KERNEL);
   594		if (!hw->irq_name) {
   595			err = -ENOMEM;
   596			goto err_free_netdev;
   597		}
   598	
   599		hw->affinity_mask = devm_kcalloc(&hw->pdev->dev, num_vec,
   600						 sizeof(cpumask_var_t), GFP_KERNEL);
   601		if (!hw->affinity_mask) {
   602			err = -ENOMEM;
   603			goto err_free_netdev;
   604		}
   605	
   606		err = pci_alloc_irq_vectors(hw->pdev, num_vec, num_vec, PCI_IRQ_MSIX);
   607		if (err < 0) {
   608			dev_err(dev, "%s: Failed to alloc %d IRQ vectors\n",
   609				__func__, num_vec);
   610			goto err_free_netdev;
   611		}
   612	
   613		vf->reg_base = pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
   614		if (!vf->reg_base) {
   615			dev_err(dev, "Unable to map physical function CSRs, aborting\n");
   616			err = -ENOMEM;
   617			goto err_free_irq_vectors;
   618		}
   619	
   620		otx2_setup_dev_hw_settings(vf);
   621		/* Init VF <=> PF mailbox stuff */
   622		err = otx2vf_vfaf_mbox_init(vf);
   623		if (err)
   624			goto err_free_irq_vectors;
   625	
   626		/* Register mailbox interrupt */
   627		err = otx2vf_register_mbox_intr(vf, true);
   628		if (err)
   629			goto err_mbox_destroy;
   630	
   631		/* Request AF to attach NPA and LIX LFs to this AF */
   632		err = otx2_attach_npa_nix(vf);
   633		if (err)
   634			goto err_disable_mbox_intr;
   635	
   636		err = otx2vf_realloc_msix_vectors(vf);
   637		if (err)
   638			goto err_detach_rsrc;
   639	
   640		err = otx2_set_real_num_queues(netdev, qcount, qcount);
   641		if (err)
   642			goto err_detach_rsrc;
   643	
   644		err = cn10k_lmtst_init(vf);
   645		if (err)
   646			goto err_detach_rsrc;
   647	
   648		/* Don't check for error.  Proceed without ptp */
   649		otx2_ptp_init(vf);
   650	
   651		/* Assign default mac address */
   652		otx2_get_mac_from_af(netdev);
   653	
   654		netdev->hw_features = NETIF_F_RXCSUM | NETIF_F_IP_CSUM |
   655				      NETIF_F_IPV6_CSUM | NETIF_F_RXHASH |
   656				      NETIF_F_SG | NETIF_F_TSO | NETIF_F_TSO6 |
   657				      NETIF_F_GSO_UDP_L4;
   658		netdev->features = netdev->hw_features;
   659		/* Support TSO on tag interface */
   660		netdev->vlan_features |= netdev->features;
   661		netdev->hw_features  |= NETIF_F_HW_VLAN_CTAG_TX |
   662					NETIF_F_HW_VLAN_STAG_TX;
   663		netdev->features |= netdev->hw_features;
   664	
   665		netdev->hw_features |= NETIF_F_NTUPLE;
   666		netdev->hw_features |= NETIF_F_RXALL;
   667		netdev->hw_features |= NETIF_F_HW_TC;
   668	
   669		netif_set_tso_max_segs(netdev, OTX2_MAX_GSO_SEGS);
   670		netdev->watchdog_timeo = OTX2_TX_TIMEOUT;
   671	
   672		netdev->netdev_ops = &otx2vf_netdev_ops;
   673	
   674		netdev->min_mtu = OTX2_MIN_MTU;
   675		netdev->max_mtu = otx2_get_max_mtu(vf);
   676		hw->max_mtu = netdev->max_mtu;
   677	
   678		/* To distinguish, for LBK VFs set netdev name explicitly */
   679		if (is_otx2_lbkvf(vf->pdev)) {
   680			int n;
   681	
   682			n = (vf->pcifunc >> RVU_PFVF_FUNC_SHIFT) & RVU_PFVF_FUNC_MASK;
   683			/* Need to subtract 1 to get proper VF number */
   684			n -= 1;
   685			snprintf(netdev->name, sizeof(netdev->name), "lbk%d", n);
   686		}
   687	
   688		if (is_otx2_sdp_rep(vf->pdev)) {
   689			int n;
   690	
   691			n = vf->pcifunc & RVU_PFVF_FUNC_MASK;
   692			n -= 1;
   693			snprintf(netdev->name, sizeof(netdev->name), "sdp%d-%d",
   694				 pdev->bus->number, n);
   695		}
   696	
   697		err = cn10k_ipsec_init(netdev);
   698		if (err)
   699			goto err_ptp_destroy;
   700	
   701		err = register_netdev(netdev);
   702		if (err) {
   703			dev_err(dev, "Failed to register netdevice\n");
   704			goto err_ipsec_clean;
   705		}
   706	
   707		err = otx2_vf_wq_init(vf);
   708		if (err)
   709			goto err_unreg_netdev;
   710	
   711		otx2vf_set_ethtool_ops(netdev);
   712	
   713		err = otx2vf_mcam_flow_init(vf);
   714		if (err)
   715			goto err_unreg_netdev;
   716	
   717		err = otx2_init_tc(vf);
   718		if (err)
   719			goto err_unreg_netdev;
   720	
   721		err = otx2_register_dl(vf);
   722		if (err)
   723			goto err_shutdown_tc;
   724	
   725		vf->af_xdp_zc_qidx = bitmap_zalloc(qcount, GFP_KERNEL);
   726		if (!vf->af_xdp_zc_qidx) {
   727			err = -ENOMEM;
   728			goto err_af_xdp_zc;
   729		}
   730	
   731	#ifdef CONFIG_DCB
   732		err = otx2_dcbnl_set_ops(netdev);
   733		if (err)
   734			goto err_dcbnl_set_ops;
   735	#endif
   736		otx2_qos_init(vf, qos_txqs);
   737	
   738		return 0;
   739	
 > 740	err_dcbnl_set_ops:
   741		bitmap_free(vf->af_xdp_zc_qidx);
   742	err_af_xdp_zc:
   743		otx2_unregister_dl(vf);
   744	err_shutdown_tc:
   745		otx2_shutdown_tc(vf);
   746	err_unreg_netdev:
   747		unregister_netdev(netdev);
   748	err_ipsec_clean:
   749		cn10k_ipsec_clean(vf);
   750	err_ptp_destroy:
   751		otx2_ptp_destroy(vf);
   752	err_detach_rsrc:
   753		free_percpu(vf->hw.lmt_info);
   754		if (test_bit(CN10K_LMTST, &vf->hw.cap_flag))
   755			qmem_free(vf->dev, vf->dync_lmt);
   756		otx2_detach_resources(&vf->mbox);
   757	err_disable_mbox_intr:
   758		otx2vf_disable_mbox_intr(vf);
   759	err_mbox_destroy:
   760		otx2vf_vfaf_mbox_destroy(vf);
   761	err_free_irq_vectors:
   762		pci_free_irq_vectors(hw->pdev);
   763	err_free_netdev:
   764		pci_set_drvdata(pdev, NULL);
   765		free_netdev(netdev);
   766	err_release_regions:
   767		pci_release_regions(pdev);
   768		return err;
   769	}
   770	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

