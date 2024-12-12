Return-Path: <bpf+bounces-46702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF269EE541
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 12:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E3A2826B2
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 11:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5BE211A0C;
	Thu, 12 Dec 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iA9FB662"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C13D1F0E57
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003630; cv=none; b=RSs81SjxfNpWy7h/Oaxv2aKEovtUK08Gn+aFk9tUmi72dvqGcl8bk3eFIla2oGC8B/nbdnZNDwyxcFs+Ril62OL/r+bIYT7EHC4DZl8JkTb26PMb4fAO2pTD+av9F5SSZr0lKOB3/N5e424pDK/0wmbncHGZAXjqsTZ0/agSc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003630; c=relaxed/simple;
	bh=81UhQFyoXEc2YYRuhb57elRZL6MCriFdu7RA9RJ39os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6cGLbQm12bl16HSHlG8OPRJFTI6yeGKMeRHyI0hJ6SNduz2vZmOVwBPFDnHuzTpM1LRSQ4qYoZw2IP6MxC72qLX1icyTdaKxoB9k3MRjiqkN0/UfYDKKHQjRy2UZ1Bh06HWA/POh5741AJSbcrvCQIpBfoi3PW8CuivFl/jJV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iA9FB662; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734003628; x=1765539628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=81UhQFyoXEc2YYRuhb57elRZL6MCriFdu7RA9RJ39os=;
  b=iA9FB662qT5jcTDmTs02A+5fxkePwEdE53ynoF9Uzixt7jAUdCla5igW
   B9TdZZfMlpuiX34yTc3Hlo6uJZSecNsss/wKjJG+UHb18wA/7xc2ubGYs
   EwBr+ze/d57R3xILH3saDebincjUpM8p744WnPY457ujIJARbzhOCdWjc
   aOUvFXaXYJ3/6tjckV7w96tMxC+QbAna833/wKmE85Vda2wLhNe/a4ZGa
   Z0uM4oDQLo+5GmivgXsFGsjRwTBezk9kTgYaHIIdQI2bewAk5lBnfPFmX
   u8VFRaqqWyQzKfZ2em9D2jRfTapjhA04w8EMnDNooY5evZYc4490YYwCW
   Q==;
X-CSE-ConnectionGUID: yRQO3TVETu+bst4IIPVDTQ==
X-CSE-MsgGUID: om48q6cJRZuKjf/ob8ANaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34288265"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34288265"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 03:40:23 -0800
X-CSE-ConnectionGUID: iGoS9x0oS/WNPVNrNcxVrA==
X-CSE-MsgGUID: L0wW7Gh2SYG16yFS6zLwOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96285074"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 12 Dec 2024 03:40:20 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLhYH-0007mj-1D;
	Thu, 12 Dec 2024 11:40:17 +0000
Date: Thu, 12 Dec 2024 19:39:32 +0800
From: kernel test robot <lkp@intel.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kkd@meta.com,
	Juri Lelli <juri.lelli@redhat.com>,
	Manu Bretelle <chantra@meta.com>, Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, kernel-team@fb.com
Subject: Re: [PATCH bpf v1 3/4] bpf: Augment raw_tp arguments with
 PTR_MAYBE_NULL
Message-ID: <202412121921.xPnFS8u5-lkp@intel.com>
References: <20241211020156.18966-4-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211020156.18966-4-memxor@gmail.com>

Hi Kumar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7d0d673627e20cfa3b21a829a896ce03b58a4f1c]

url:    https://github.com/intel-lab-lkp/linux/commits/Kumar-Kartikeya-Dwivedi/bpf-Revert-bpf-Mark-raw_tp-arguments-with-PTR_MAYBE_NULL/20241211-100358
base:   7d0d673627e20cfa3b21a829a896ce03b58a4f1c
patch link:    https://lore.kernel.org/r/20241211020156.18966-4-memxor%40gmail.com
patch subject: [PATCH bpf v1 3/4] bpf: Augment raw_tp arguments with PTR_MAYBE_NULL
config: i386-randconfig-062-20241212 (https://download.01.org/0day-ci/archive/20241212/202412121921.xPnFS8u5-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412121921.xPnFS8u5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412121921.xPnFS8u5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/btf.c:6451:29: sparse: sparse: symbol 'raw_tp_null_args' was not declared. Should it be static?
   kernel/bpf/btf.c: note: in included file (through include/linux/bpf.h, include/linux/bpf_verifier.h):
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar

vim +/raw_tp_null_args +6451 kernel/bpf/btf.c

  6450	
> 6451	struct bpf_raw_tp_null_args raw_tp_null_args[] = {
  6452		/* sched */
  6453		RAW_TP_NULL_ARGS(sched_pi_setprio, NULL_ARG(2)),
  6454		/* ... from sched_numa_pair_template event class */
  6455		RAW_TP_NULL_ARGS(sched_stick_numa, NULL_ARG(3)),
  6456		RAW_TP_NULL_ARGS(sched_swap_numa, NULL_ARG(3)),
  6457		/* afs */
  6458		RAW_TP_NULL_ARGS(afs_make_fs_call, NULL_ARG(2)),
  6459		RAW_TP_NULL_ARGS(afs_make_fs_calli, NULL_ARG(2)),
  6460		RAW_TP_NULL_ARGS(afs_make_fs_call1, NULL_ARG(2)),
  6461		RAW_TP_NULL_ARGS(afs_make_fs_call2, NULL_ARG(2)),
  6462		RAW_TP_NULL_ARGS(afs_protocol_error, NULL_ARG(1)),
  6463		RAW_TP_NULL_ARGS(afs_flock_ev, NULL_ARG(2)),
  6464		/* cachefiles */
  6465		RAW_TP_NULL_ARGS(cachefiles_lookup, NULL_ARG(1)),
  6466		RAW_TP_NULL_ARGS(cachefiles_unlink, NULL_ARG(1)),
  6467		RAW_TP_NULL_ARGS(cachefiles_rename, NULL_ARG(1)),
  6468		RAW_TP_NULL_ARGS(cachefiles_prep_read, NULL_ARG(1)),
  6469		RAW_TP_NULL_ARGS(cachefiles_mark_active, NULL_ARG(1)),
  6470		RAW_TP_NULL_ARGS(cachefiles_mark_failed, NULL_ARG(1)),
  6471		RAW_TP_NULL_ARGS(cachefiles_mark_inactive, NULL_ARG(1)),
  6472		RAW_TP_NULL_ARGS(cachefiles_vfs_error, NULL_ARG(1)),
  6473		RAW_TP_NULL_ARGS(cachefiles_io_error, NULL_ARG(1)),
  6474		RAW_TP_NULL_ARGS(cachefiles_ondemand_open, NULL_ARG(1)),
  6475		RAW_TP_NULL_ARGS(cachefiles_ondemand_copen, NULL_ARG(1)),
  6476		RAW_TP_NULL_ARGS(cachefiles_ondemand_close, NULL_ARG(1)),
  6477		RAW_TP_NULL_ARGS(cachefiles_ondemand_read, NULL_ARG(1)),
  6478		RAW_TP_NULL_ARGS(cachefiles_ondemand_cread, NULL_ARG(1)),
  6479		RAW_TP_NULL_ARGS(cachefiles_ondemand_fd_write, NULL_ARG(1)),
  6480		RAW_TP_NULL_ARGS(cachefiles_ondemand_fd_release, NULL_ARG(1)),
  6481		/* ext4, from ext4__mballoc event class */
  6482		RAW_TP_NULL_ARGS(ext4_mballoc_discard, NULL_ARG(2)),
  6483		RAW_TP_NULL_ARGS(ext4_mballoc_free, NULL_ARG(2)),
  6484		/* fib */
  6485		RAW_TP_NULL_ARGS(fib_table_lookup, NULL_ARG(3)),
  6486		/* filelock */
  6487		/* ... from filelock_lock event class */
  6488		RAW_TP_NULL_ARGS(posix_lock_inode, NULL_ARG(2)),
  6489		RAW_TP_NULL_ARGS(fcntl_setlk, NULL_ARG(2)),
  6490		RAW_TP_NULL_ARGS(locks_remove_posix, NULL_ARG(2)),
  6491		RAW_TP_NULL_ARGS(flock_lock_inode, NULL_ARG(2)),
  6492		/* ... from filelock_lease event class */
  6493		RAW_TP_NULL_ARGS(break_lease_noblock, NULL_ARG(2)),
  6494		RAW_TP_NULL_ARGS(break_lease_block, NULL_ARG(2)),
  6495		RAW_TP_NULL_ARGS(break_lease_unblock, NULL_ARG(2)),
  6496		RAW_TP_NULL_ARGS(generic_delete_lease, NULL_ARG(2)),
  6497		RAW_TP_NULL_ARGS(time_out_leases, NULL_ARG(2)),
  6498		/* host1x */
  6499		RAW_TP_NULL_ARGS(host1x_cdma_push_gather, NULL_ARG(5)),
  6500		/* huge_memory */
  6501		RAW_TP_NULL_ARGS(mm_khugepaged_scan_pmd, NULL_ARG(2)),
  6502		RAW_TP_NULL_ARGS(mm_collapse_huge_page_isolate, NULL_ARG(1)),
  6503		RAW_TP_NULL_ARGS(mm_khugepaged_scan_file, NULL_ARG(2)),
  6504		RAW_TP_NULL_ARGS(mm_khugepaged_collapse_file, NULL_ARG(2)),
  6505		/* kmem */
  6506		RAW_TP_NULL_ARGS(mm_page_alloc, NULL_ARG(1)),
  6507		RAW_TP_NULL_ARGS(mm_page_pcpu_drain, NULL_ARG(1)),
  6508		/* .. from mm_page event class */
  6509		RAW_TP_NULL_ARGS(mm_page_alloc_zone_locked, NULL_ARG(1)),
  6510		/* netfs */
  6511		RAW_TP_NULL_ARGS(netfs_failure, NULL_ARG(2)),
  6512		/* power */
  6513		RAW_TP_NULL_ARGS(device_pm_callback_start, NULL_ARG(2)),
  6514		/* qdisc */
  6515		RAW_TP_NULL_ARGS(qdisc_dequeue, NULL_ARG(4)),
  6516		/* rxrpc */
  6517		RAW_TP_NULL_ARGS(rxrpc_recvdata, NULL_ARG(1)),
  6518		RAW_TP_NULL_ARGS(rxrpc_resend, NULL_ARG(2)),
  6519		/* sunrpc */
  6520		RAW_TP_NULL_ARGS(xs_stream_read_data, NULL_ARG(1)),
  6521		/* tcp */
  6522		RAW_TP_NULL_ARGS(tcp_send_reset, NULL_ARG(1) | NULL_ARG(2)),
  6523		/* tegra_apb_dma */
  6524		RAW_TP_NULL_ARGS(tegra_dma_tx_status, NULL_ARG(3)),
  6525		/* timer_migration */
  6526		RAW_TP_NULL_ARGS(tmigr_update_events, NULL_ARG(1)),
  6527		/* writeback, from writeback_folio_template event class */
  6528		RAW_TP_NULL_ARGS(writeback_dirty_folio, NULL_ARG(2)),
  6529		RAW_TP_NULL_ARGS(folio_wait_writeback, NULL_ARG(2)),
  6530	};
  6531	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

