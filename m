Return-Path: <bpf+bounces-11415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EEF7B98E1
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 01:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id CB22CB20A91
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 23:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97F13D390;
	Wed,  4 Oct 2023 23:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="anDX1AdT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8284A36B0D;
	Wed,  4 Oct 2023 23:48:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F15C9;
	Wed,  4 Oct 2023 16:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696463310; x=1727999310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sKOndc796+AQf4UbTaoyi0bTyHR1gldFNWtPzmX48ic=;
  b=anDX1AdT28/+bMX3h5KVVDAHhzFbORVmGk9UTT/9qIMDHUHwqGDp5bPm
   3wMOphHAA0v5PHrVwTtpG0OOWTsaRrbdBAmklM5zRxMUjm1RFK51LpEJe
   PAymLU65wck4lyY1S16DBl9cjHe8SnejBiI8DL6zq12IkME/eAwFa86Ge
   aO7O06aVzNNQ6Zt34iVIQ5bRujvCHVKfSDbzU9VZyqdcapngSkT59F6Hu
   Vh5GsiJVOygq4bj1viqvgrZxhc4L1ejmCI05E8VycbaKCev8X0KQGlUW0
   puAjnwQTapo7mLJNqMJJjByATMdQ+Kp/hBmKL8PJcfzy7i97zyiTE4U6T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="414312038"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="414312038"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 16:48:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="998710887"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="998710887"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 04 Oct 2023 16:48:23 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qoBbI-000Klg-2P;
	Wed, 04 Oct 2023 23:48:20 +0000
Date: Thu, 5 Oct 2023 07:47:48 +0800
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
Subject: Re: [PATCH bpf-next v3 04/10] net/mlx5e: Implement AF_XDP TX
 timestamp and checksum offload
Message-ID: <202310050738.ZFOKzSlA-lkp@intel.com>
References: <20231003200522.1914523-5-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003200522.1914523-5-sdf@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/xsk-Support-tx_metadata_len/20231004-040718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231003200522.1914523-5-sdf%40google.com
patch subject: [PATCH bpf-next v3 04/10] net/mlx5e: Implement AF_XDP TX timestamp and checksum offload
config: s390-defconfig (https://download.01.org/0day-ci/archive/20231005/202310050738.ZFOKzSlA-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310050738.ZFOKzSlA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310050738.ZFOKzSlA-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c: In function 'mlx5e_xsk_tx':
>> drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c:117:33: error: implicit declaration of function 'xsk_tx_metadata_to_compl'; did you mean 'xsk_tx_metadata_complete'? [-Werror=implicit-function-declaration]
     117 |                                 xsk_tx_metadata_to_compl(meta, &compl);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
         |                                 xsk_tx_metadata_complete
   cc1: some warnings being treated as errors


vim +117 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c

    63	
    64	bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
    65	{
    66		struct xsk_buff_pool *pool = sq->xsk_pool;
    67		struct xsk_tx_metadata *meta = NULL;
    68		union mlx5e_xdp_info xdpi;
    69		bool work_done = true;
    70		bool flush = false;
    71	
    72		xdpi.mode = MLX5E_XDP_XMIT_MODE_XSK;
    73	
    74		for (; budget; budget--) {
    75			int check_result = INDIRECT_CALL_2(sq->xmit_xdp_frame_check,
    76							   mlx5e_xmit_xdp_frame_check_mpwqe,
    77							   mlx5e_xmit_xdp_frame_check,
    78							   sq);
    79			struct mlx5e_xmit_data xdptxd = {};
    80			struct xdp_desc desc;
    81			bool ret;
    82	
    83			if (unlikely(check_result < 0)) {
    84				work_done = false;
    85				break;
    86			}
    87	
    88			if (!xsk_tx_peek_desc(pool, &desc)) {
    89				/* TX will get stuck until something wakes it up by
    90				 * triggering NAPI. Currently it's expected that the
    91				 * application calls sendto() if there are consumed, but
    92				 * not completed frames.
    93				 */
    94				break;
    95			}
    96	
    97			xdptxd.dma_addr = xsk_buff_raw_get_dma(pool, desc.addr);
    98			xdptxd.data = xsk_buff_raw_get_data(pool, desc.addr);
    99			xdptxd.len = desc.len;
   100			meta = xsk_buff_get_metadata(pool, desc.addr);
   101	
   102			xsk_buff_raw_dma_sync_for_device(pool, xdptxd.dma_addr, xdptxd.len);
   103	
   104			ret = INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
   105					      mlx5e_xmit_xdp_frame, sq, &xdptxd,
   106					      check_result, meta);
   107			if (unlikely(!ret)) {
   108				if (sq->mpwqe.wqe)
   109					mlx5e_xdp_mpwqe_complete(sq);
   110	
   111				mlx5e_xsk_tx_post_err(sq, &xdpi);
   112			} else {
   113				mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo, xdpi);
   114				if (xp_tx_metadata_enabled(sq->xsk_pool)) {
   115					struct xsk_tx_metadata_compl compl;
   116	
 > 117					xsk_tx_metadata_to_compl(meta, &compl);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

