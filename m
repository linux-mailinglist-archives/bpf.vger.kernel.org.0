Return-Path: <bpf+bounces-11230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9E87B5C7C
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 23:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A07A3281C46
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 21:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8847A20333;
	Mon,  2 Oct 2023 21:29:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13BF20304
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 21:29:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5BFAB
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 14:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696282193; x=1727818193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tQ0+nywVtg5+h0Tn/WFi+kvhkW9yeJ4ztgRkLq0F2Yw=;
  b=QBXqy8x7lt0ztKI35ouO1lX4aDtQLZfPiu3rXuqamuRCTTzI6SA7u9qB
   WrKLTr3WV+jSA+pxTYTXPSkk+HXF7eeh2RzAz6MWxa9HpgsZZc4AqxrNP
   Nll/drjQmgJjUULbi+DQijiSP6BsYXMLvqblcj0AU/h9zoDr6A5S5KsAx
   nn584smBHH86dcM1CzuyAlJKGg+0jzPD11L8kjLQvJEKb+BdmNObsjVKE
   hW2HpLlI0ZVN0/ZxTVgqlbhP1qj3Y2Beh6+lHlKL+YY6RYi7UfxSzWGyq
   IbkESJ9NfRuFWq4bD/p7w4b7t1ItUdcxR10mO6vrqqF0i2mW8lcDyEEe5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="4308301"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="4308301"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 14:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="816441017"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="816441017"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 02 Oct 2023 14:29:50 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qnQU7-0006OX-3A;
	Mon, 02 Oct 2023 21:29:47 +0000
Date: Tue, 3 Oct 2023 05:29:43 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	Nathan Slingerland <slinger@meta.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
Message-ID: <202310030525.R8YDHYsO-lkp@intel.com>
References: <20231002195341.2940874-3-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002195341.2940874-3-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Marchevsky/bpf-Don-t-explicitly-emit-BTF-for-struct-btf_iter_num/20231003-035600
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231002195341.2940874-3-davemarchevsky%40fb.com
patch subject: [PATCH v4 bpf-next 2/3] bpf: Introduce task_vma open-coded iterator kfuncs
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231003/202310030525.R8YDHYsO-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231003/202310030525.R8YDHYsO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310030525.R8YDHYsO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/task_iter.c:827:17: warning: no previous prototype for 'bpf_iter_task_vma_new' [-Wmissing-prototypes]
     827 | __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
         |                 ^~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/task_iter.c:871:36: warning: no previous prototype for 'bpf_iter_task_vma_next' [-Wmissing-prototypes]
     871 | __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/task_iter.c:880:18: warning: no previous prototype for 'bpf_iter_task_vma_destroy' [-Wmissing-prototypes]
     880 | __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/bpf_iter_task_vma_new +827 kernel/bpf/task_iter.c

   826	
 > 827	__bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
   828					      struct task_struct *task, u64 addr)
   829	{
   830		struct bpf_iter_task_vma_kern *kit = (void *)it;
   831		bool irq_work_busy = false;
   832		int err;
   833	
   834		BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) != sizeof(struct bpf_iter_task_vma));
   835		BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) != __alignof__(struct bpf_iter_task_vma));
   836	
   837		/* is_iter_reg_valid_uninit guarantees that kit hasn't been initialized
   838		 * before, so non-NULL kit->data doesn't point to previously
   839		 * bpf_mem_alloc'd bpf_iter_task_vma_kern_data
   840		 */
   841		kit->data = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_iter_task_vma_kern_data));
   842		if (!kit->data)
   843			return -ENOMEM;
   844	
   845		kit->data->task = get_task_struct(task);
   846		kit->data->mm = task->mm;
   847		if (!kit->data->mm) {
   848			err = -ENOENT;
   849			goto err_cleanup_iter;
   850		}
   851	
   852		/* kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work */
   853		irq_work_busy = bpf_mmap_unlock_get_irq_work(&kit->data->work);
   854		if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
   855			err = -EBUSY;
   856			goto err_cleanup_iter;
   857		}
   858	
   859		vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
   860		return 0;
   861	
   862	err_cleanup_iter:
   863		if (kit->data->task)
   864			put_task_struct(kit->data->task);
   865		bpf_mem_free(&bpf_global_ma, kit->data);
   866		/* NULL kit->data signals failed bpf_iter_task_vma initialization */
   867		kit->data = NULL;
   868		return err;
   869	}
   870	
 > 871	__bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
   872	{
   873		struct bpf_iter_task_vma_kern *kit = (void *)it;
   874	
   875		if (!kit->data) /* bpf_iter_task_vma_new failed */
   876			return NULL;
   877		return vma_next(&kit->data->vmi);
   878	}
   879	
 > 880	__bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
   881	{
   882		struct bpf_iter_task_vma_kern *kit = (void *)it;
   883	
   884		if (kit->data) {
   885			bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
   886			put_task_struct(kit->data->task);
   887			bpf_mem_free(&bpf_global_ma, kit->data);
   888		}
   889	}
   890	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

