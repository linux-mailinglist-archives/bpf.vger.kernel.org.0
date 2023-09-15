Return-Path: <bpf+bounces-10130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245897A13EB
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 04:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9649281868
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 02:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E6620EA;
	Fri, 15 Sep 2023 02:45:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BA17F;
	Fri, 15 Sep 2023 02:45:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BF426AB;
	Thu, 14 Sep 2023 19:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694745919; x=1726281919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bknfMAASl4tDMfba7zMcHuWz0AayuUezqHpZNb2hdkw=;
  b=KRtBnh24klc74AEARGSgK4G0/a3RYa12+PFQmMTRNdfUpm2s4BEb1YVi
   GO7krgnIgOJHBHp7xHb0U6mviGcmGfVZ8z98jFMKaF9W+sLJ0lnmhuqC0
   aadVjIcPDu3nrXUsPivxHWx1LG4FtYQWrIGOMUpBccndfREk7RO5kbo7r
   mAl7+mcphKFHTXNhvR/i53uxrwf1gbpOiizemH3Yx+osWqxGN98eYyChz
   SPjY4pdnev8bJ+xWbogXE5WP6gnpOftFPX10arBQqed+B9nPQzgZ8IJrh
   fWTBoHefHZkmW/voQNKVbFstHKxym8TL2WqAGUpp+OFKOtaSz6QXhggon
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="379061817"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="379061817"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 19:45:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="738165607"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="738165607"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Sep 2023 19:45:12 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qgypR-0002KT-0l;
	Fri, 15 Sep 2023 02:45:09 +0000
Date: Fri, 15 Sep 2023 10:44:14 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	kuba@kernel.org, toke@kernel.org, willemb@google.com,
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
	maciej.fijalkowski@intel.com, hawk@kernel.org,
	yoong.siang.song@intel.com, netdev@vger.kernel.org,
	xdp-hints@xdp-project.net, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH bpf-next v2 4/9] net/mlx5e: Implement AF_XDP TX timestamp
 and checksum offload
Message-ID: <202309151024.ZDZ6mRxc-lkp@intel.com>
References: <20230914210452.2588884-5-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914210452.2588884-5-sdf@google.com>

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/xsk-Support-tx_metadata_len/20230915-051153
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230914210452.2588884-5-sdf%40google.com
patch subject: [PATCH bpf-next v2 4/9] net/mlx5e: Implement AF_XDP TX timestamp and checksum offload
config: s390-defconfig (https://download.01.org/0day-ci/archive/20230915/202309151024.ZDZ6mRxc-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309151024.ZDZ6mRxc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309151024.ZDZ6mRxc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/net/xdp_sock_drv.h:9,
                    from drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:34:
   include/net/xdp_sock.h:183:52: warning: 'struct xsk_tx_metadata_comp' declared inside parameter list will not be visible outside of this definition or declaration
     183 | static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_comp *compl,
         |                                                    ^~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c: In function 'mlx5e_free_xdpsq_desc':
>> drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:719:58: error: passing argument 1 of 'xsk_tx_metadata_complete' from incompatible pointer type [-Werror=incompatible-pointer-types]
     719 |                                 xsk_tx_metadata_complete(compl, &mlx5e_xsk_tx_metadata_ops, &priv);
         |                                                          ^~~~~
         |                                                          |
         |                                                          struct xsk_tx_metadata_compl *
   include/net/xdp_sock.h:183:74: note: expected 'struct xsk_tx_metadata_comp *' but argument is of type 'struct xsk_tx_metadata_compl *'
     183 | static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_comp *compl,
         |                                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:36,
                    from drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c:6:
   include/net/xdp_sock.h:183:52: warning: 'struct xsk_tx_metadata_comp' declared inside parameter list will not be visible outside of this definition or declaration
     183 | static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_comp *compl,
         |                                                    ^~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c: In function 'mlx5e_xsk_tx':
>> drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c:117:33: error: implicit declaration of function 'xsk_tx_metadata_to_compl'; did you mean 'xsk_tx_metadata_complete'? [-Werror=implicit-function-declaration]
     117 |                                 xsk_tx_metadata_to_compl(meta, &compl);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
         |                                 xsk_tx_metadata_complete
   cc1: some warnings being treated as errors


vim +/xsk_tx_metadata_complete +719 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c

   641	
   642	static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
   643					  struct mlx5e_xdp_wqe_info *wi,
   644					  u32 *xsk_frames,
   645					  struct xdp_frame_bulk *bq,
   646					  struct mlx5e_cq *cq,
   647					  struct mlx5_cqe64 *cqe)
   648	{
   649		struct mlx5e_xdp_info_fifo *xdpi_fifo = &sq->db.xdpi_fifo;
   650		u16 i;
   651	
   652		for (i = 0; i < wi->num_pkts; i++) {
   653			union mlx5e_xdp_info xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
   654	
   655			switch (xdpi.mode) {
   656			case MLX5E_XDP_XMIT_MODE_FRAME: {
   657				/* XDP_TX from the XSK RQ and XDP_REDIRECT */
   658				struct xdp_frame *xdpf;
   659				dma_addr_t dma_addr;
   660	
   661				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
   662				xdpf = xdpi.frame.xdpf;
   663				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
   664				dma_addr = xdpi.frame.dma_addr;
   665	
   666				dma_unmap_single(sq->pdev, dma_addr,
   667						 xdpf->len, DMA_TO_DEVICE);
   668				if (xdp_frame_has_frags(xdpf)) {
   669					struct skb_shared_info *sinfo;
   670					int j;
   671	
   672					sinfo = xdp_get_shared_info_from_frame(xdpf);
   673					for (j = 0; j < sinfo->nr_frags; j++) {
   674						skb_frag_t *frag = &sinfo->frags[j];
   675	
   676						xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
   677						dma_addr = xdpi.frame.dma_addr;
   678	
   679						dma_unmap_single(sq->pdev, dma_addr,
   680								 skb_frag_size(frag), DMA_TO_DEVICE);
   681					}
   682				}
   683				xdp_return_frame_bulk(xdpf, bq);
   684				break;
   685			}
   686			case MLX5E_XDP_XMIT_MODE_PAGE: {
   687				/* XDP_TX from the regular RQ */
   688				u8 num, n = 0;
   689	
   690				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
   691				num = xdpi.page.num;
   692	
   693				do {
   694					struct page *page;
   695	
   696					xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
   697					page = xdpi.page.page;
   698	
   699					/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
   700					 * as we know this is a page_pool page.
   701					 */
   702					page_pool_recycle_direct(page->pp, page);
   703				} while (++n < num);
   704	
   705				break;
   706			}
   707			case MLX5E_XDP_XMIT_MODE_XSK: {
   708				/* AF_XDP send */
   709				struct xsk_tx_metadata_compl *compl = NULL;
   710				struct mlx5e_xsk_tx_complete priv = {
   711					.cqe = cqe,
   712					.cq = cq,
   713				};
   714	
   715				if (xp_tx_metadata_enabled(sq->xsk_pool)) {
   716					xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
   717					compl = &xdpi.xsk_meta;
   718	
 > 719					xsk_tx_metadata_complete(compl, &mlx5e_xsk_tx_metadata_ops, &priv);
   720				}
   721	
   722				(*xsk_frames)++;
   723				break;
   724			}
   725			default:
   726				WARN_ON_ONCE(true);
   727			}
   728		}
   729	}
   730	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

