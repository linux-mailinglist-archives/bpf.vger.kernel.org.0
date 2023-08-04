Return-Path: <bpf+bounces-7058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E4770C14
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 00:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866381C217B6
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3059421D33;
	Fri,  4 Aug 2023 22:40:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C511AD4A
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 22:40:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FFB46B3;
	Fri,  4 Aug 2023 15:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691188855; x=1722724855;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KIHq1/BLnN0GMEwjg4gEEkT8zWZgQ+MJx2PmCBPEvjM=;
  b=b4Z/LdGzBXxYmMltFpDwzsFfLSCwwz0TH6z1GD2GZl5zMBHKxA2nsRNG
   vDTRlWgqMhSqph5637wu8qdupmdj3ZeXb7hYGdRvDFOLcVP74fTXi6E4P
   bD6/EwD+N8wYq1JUhglFtEWYkO3WxIHRL/mrs+hpSqucde63bVqg8QnNR
   Np2gt7SbupILD9/RzdPDfOCHIHpv4PnRJ8MpJ8836/wSoxRZVKlI7VT8p
   XcPcW11Qpoy5bpSWpUDZuxCQklnTaJH++AZdg/cmuOXDUeigS7a5K0tA6
   9fgiw+Cm9B1925bZaMywvNx8/pG5B+F0WCJ+0c9nGeXQZn7fmhPvnFtWH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="373916930"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="373916930"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 15:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="844286842"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="844286842"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2023 15:40:51 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qS3TW-00039j-1d;
	Fri, 04 Aug 2023 22:40:50 +0000
Date: Sat, 5 Aug 2023 06:40:06 +0800
From: kernel test robot <lkp@intel.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [linux-next:master 4617/7272] kernel/bpf/disasm.c:90:12: sparse:
 sparse: symbol 'bpf_alu_sign_string' was not declared. Should it be static?
Message-ID: <202308050615.wxAn1v2J-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   bdffb18b5dd8071cd25685b966f380a30b1fadaa
commit: f835bb6222998c8655bc4e85287d42b57c17b208 [4617/7272] bpf: Add kernel/bpftool asm support for new instructions
config: i386-randconfig-i063-20230730 (https://download.01.org/0day-ci/archive/20230805/202308050615.wxAn1v2J-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230805/202308050615.wxAn1v2J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308050615.wxAn1v2J-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/disasm.c:90:12: sparse: sparse: symbol 'bpf_alu_sign_string' was not declared. Should it be static?
>> kernel/bpf/disasm.c:95:12: sparse: sparse: symbol 'bpf_movsx_string' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

