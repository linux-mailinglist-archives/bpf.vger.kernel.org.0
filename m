Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB99517D63
	for <lists+bpf@lfdr.de>; Tue,  3 May 2022 08:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiECGe7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 May 2022 02:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiECGe6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 May 2022 02:34:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E355381A4
        for <bpf@vger.kernel.org>; Mon,  2 May 2022 23:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651559487; x=1683095487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1f1O3yMU6c3p0LycQq2IAcghpdqtIOFHigL4woggFCM=;
  b=Q35ecMlea/o4jXyiYO3T3Eb1eFvpWJ2qluNbUK2Q41hgwPuYGI5mlbEi
   t6KE+UkIn3HlaYawS+j5QjQfdXzACSFYFefgcDI0ihWLblhpYn+TNmJ/q
   0RuRwtt6kGp2a6jbNS8FqaSMtxl4WIPVjXkVDe3Zlc8leuK4efwU68WWN
   VPKRJZ2gEI2OlEBuLsNwdHMiJ89Ly+K4Ts4+Wv6kZyHb/0edg8WolcGAi
   gF8NrkU2o9U0m4uxskEC6l1Q0IVCkfS6TQbaxb40w2vuI42zYtZI40hQz
   amugHGwri+FwZbH1mWwtoLGV6hMUdw1FoY4U8gzo1QACx22JEzSm5GroZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267287220"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="267287220"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 23:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="516447000"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 May 2022 23:31:25 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlm4C-000ADb-I4;
        Tue, 03 May 2022 06:31:24 +0000
Date:   Tue, 3 May 2022 14:30:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Delyan Kratunov <delyank@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH bpf-next v2 2/5] bpf: implement sleepable uprobes by
 chaining tasks_trace and normal rcu
Message-ID: <202205031441.1fhDuUQK-lkp@intel.com>
References: <588dd77e9e7424e0abc0e0e624524ef8a2c7b847.1651532419.git.delyank@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <588dd77e9e7424e0abc0e0e624524ef8a2c7b847.1651532419.git.delyank@fb.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Delyan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Delyan-Kratunov/sleepable-uprobe-support/20220503-071247
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220503/202205031441.1fhDuUQK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/cfa0f114829902b579da16d7520a39317905c502
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Delyan-Kratunov/sleepable-uprobe-support/20220503-071247
        git checkout cfa0f114829902b579da16d7520a39317905c502
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/trace/trace_uprobe.c: In function '__uprobe_perf_func':
>> kernel/trace/trace_uprobe.c:1349:23: error: implicit declaration of function 'uprobe_call_bpf'; did you mean 'trace_call_bpf'? [-Werror=implicit-function-declaration]
    1349 |                 ret = uprobe_call_bpf(call, regs);
         |                       ^~~~~~~~~~~~~~~
         |                       trace_call_bpf
   cc1: some warnings being treated as errors


vim +1349 kernel/trace/trace_uprobe.c

  1334	
  1335	static void __uprobe_perf_func(struct trace_uprobe *tu,
  1336				       unsigned long func, struct pt_regs *regs,
  1337				       struct uprobe_cpu_buffer *ucb, int dsize)
  1338	{
  1339		struct trace_event_call *call = trace_probe_event_call(&tu->tp);
  1340		struct uprobe_trace_entry_head *entry;
  1341		struct hlist_head *head;
  1342		void *data;
  1343		int size, esize;
  1344		int rctx;
  1345	
  1346		if (bpf_prog_array_valid(call)) {
  1347			u32 ret;
  1348	
> 1349			ret = uprobe_call_bpf(call, regs);
  1350			if (!ret)
  1351				return;
  1352		}
  1353	
  1354		esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
  1355	
  1356		size = esize + tu->tp.size + dsize;
  1357		size = ALIGN(size + sizeof(u32), sizeof(u64)) - sizeof(u32);
  1358		if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE, "profile buffer not large enough"))
  1359			return;
  1360	
  1361		preempt_disable();
  1362		head = this_cpu_ptr(call->perf_events);
  1363		if (hlist_empty(head))
  1364			goto out;
  1365	
  1366		entry = perf_trace_buf_alloc(size, NULL, &rctx);
  1367		if (!entry)
  1368			goto out;
  1369	
  1370		if (is_ret_probe(tu)) {
  1371			entry->vaddr[0] = func;
  1372			entry->vaddr[1] = instruction_pointer(regs);
  1373			data = DATAOF_TRACE_ENTRY(entry, true);
  1374		} else {
  1375			entry->vaddr[0] = instruction_pointer(regs);
  1376			data = DATAOF_TRACE_ENTRY(entry, false);
  1377		}
  1378	
  1379		memcpy(data, ucb->buf, tu->tp.size + dsize);
  1380	
  1381		if (size - esize > tu->tp.size + dsize) {
  1382			int len = tu->tp.size + dsize;
  1383	
  1384			memset(data + len, 0, size - esize - len);
  1385		}
  1386	
  1387		perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
  1388				      head, NULL);
  1389	 out:
  1390		preempt_enable();
  1391	}
  1392	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
