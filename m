Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729DC58CFF6
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 23:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244501AbiHHV4l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 17:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244476AbiHHV4k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 17:56:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA9E1AF08;
        Mon,  8 Aug 2022 14:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659995799; x=1691531799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vJtYOJwOompnBj4Aqh2odHAundgfNzupycshZfydTio=;
  b=G160lznxSwOZ01Z4fYtfY+RAGNTVqLCZQFS5xxAUx6Akc9SJiJN1+xEp
   xFHCfRdQjT3rdf5XxqLUZockUhzF5x7Qfq9nEsKcgEzYS++1y5O5Qy+vj
   XZQiZXyIGO2v1gpc1aCnJV2prATbfLEY1PR0pktOx+kJAjPlWYNOeahK4
   L2++CDFoTTekyshNwmArbBAFoLzx8HCXKMarY8p3AHpS8A7HoSb1FFp5O
   kqX23B2N4cPhAUTz506x4I8tQqH0weEgGASY1AzZbFwquTEJcW+lMlxv6
   64liKb14Dtz3ylRbd2a8DHzK92ur1i0Mu3sY7KD8iucnMZ4WfaHdea7p4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="289456662"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="289456662"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 14:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="637473248"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Aug 2022 14:56:34 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLAji-000MYl-02;
        Mon, 08 Aug 2022 21:56:34 +0000
Date:   Tue, 9 Aug 2022 05:55:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        joannelkoong@gmail.com, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
Subject: Re: [PATCH 3/5] bpf: Add bpf_user_ringbuf_drain() helper
Message-ID: <202208090505.me3WqXOM-lkp@intel.com>
References: <20220808155341.2479054-3-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808155341.2479054-3-void@manifault.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master linus/master next-20220808]
[cannot apply to v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Vernet/bpf-Clear-callee-saved-regs-after-updating-REG0/20220808-235558
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220809/202208090505.me3WqXOM-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/70db51b231aeddaa6eecd19afeeebef610ae2686
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Vernet/bpf-Clear-callee-saved-regs-after-updating-REG0/20220808-235558
        git checkout 70db51b231aeddaa6eecd19afeeebef610ae2686
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/bpf/ringbuf.c: In function '__bpf_user_ringbuf_poll':
>> kernel/bpf/ringbuf.c:653:15: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     653 |         hdr = (u32 *)((uintptr_t)rb->data + (cons_pos & rb->mask));
         |               ^
   kernel/bpf/ringbuf.c:682:19: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     682 |         *sample = (void *)((uintptr_t)rb->data +
         |                   ^
   kernel/bpf/ringbuf.c: In function '____bpf_user_ringbuf_drain':
>> kernel/bpf/ringbuf.c:736:40: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     736 |                         ret = callback((u64)&dynptr,
         |                                        ^


vim +653 kernel/bpf/ringbuf.c

   626	
   627	static int __bpf_user_ringbuf_poll(struct bpf_ringbuf *rb, void **sample,
   628					   u32 *size)
   629	{
   630		unsigned long cons_pos, prod_pos;
   631		u32 sample_len, total_len;
   632		u32 *hdr;
   633		int err;
   634		int busy = 0;
   635	
   636		/* If another consumer is already consuming a sample, wait for them to
   637		 * finish.
   638		 */
   639		if (!atomic_try_cmpxchg(&rb->busy, &busy, 1))
   640			return -EBUSY;
   641	
   642		/* Synchronizes with smp_store_release() in user-space. */
   643		prod_pos = smp_load_acquire(&rb->producer_pos);
   644		/* Synchronizes with smp_store_release() in
   645		 * __bpf_user_ringbuf_sample_release().
   646		 */
   647		cons_pos = smp_load_acquire(&rb->consumer_pos);
   648		if (cons_pos >= prod_pos) {
   649			atomic_set(&rb->busy, 0);
   650			return -ENODATA;
   651		}
   652	
 > 653		hdr = (u32 *)((uintptr_t)rb->data + (cons_pos & rb->mask));
   654		sample_len = *hdr;
   655	
   656		/* Check that the sample can fit into a dynptr. */
   657		err = bpf_dynptr_check_size(sample_len);
   658		if (err) {
   659			atomic_set(&rb->busy, 0);
   660			return err;
   661		}
   662	
   663		/* Check that the sample fits within the region advertised by the
   664		 * consumer position.
   665		 */
   666		total_len = sample_len + BPF_RINGBUF_HDR_SZ;
   667		if (total_len > prod_pos - cons_pos) {
   668			atomic_set(&rb->busy, 0);
   669			return -E2BIG;
   670		}
   671	
   672		/* Check that the sample fits within the data region of the ring buffer.
   673		 */
   674		if (total_len > rb->mask + 1) {
   675			atomic_set(&rb->busy, 0);
   676			return -E2BIG;
   677		}
   678	
   679		/* consumer_pos is updated when the sample is released.
   680		 */
   681	
   682		*sample = (void *)((uintptr_t)rb->data +
   683				   ((cons_pos + BPF_RINGBUF_HDR_SZ) & rb->mask));
   684		*size = sample_len;
   685	
   686		return 0;
   687	}
   688	
   689	static void
   690	__bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size,
   691					  u64 flags)
   692	{
   693	
   694	
   695		/* To release the ringbuffer, just increment the producer position to
   696		 * signal that a new sample can be consumed. The busy bit is cleared by
   697		 * userspace when posting a new sample to the ringbuffer.
   698		 */
   699		smp_store_release(&rb->consumer_pos, rb->consumer_pos + size +
   700				  BPF_RINGBUF_HDR_SZ);
   701	
   702		if (flags & BPF_RB_FORCE_WAKEUP || !(flags & BPF_RB_NO_WAKEUP))
   703			irq_work_queue(&rb->work);
   704	
   705		atomic_set(&rb->busy, 0);
   706	}
   707	
   708	BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
   709		   void *, callback_fn, void *, callback_ctx, u64, flags)
   710	{
   711		struct bpf_ringbuf *rb;
   712		long num_samples = 0, ret = 0;
   713		int err;
   714		bpf_callback_t callback = (bpf_callback_t)callback_fn;
   715		u64 wakeup_flags = BPF_RB_NO_WAKEUP | BPF_RB_FORCE_WAKEUP;
   716	
   717		if (unlikely(flags & ~wakeup_flags))
   718			return -EINVAL;
   719	
   720		/* The two wakeup flags are mutually exclusive. */
   721		if (unlikely((flags & wakeup_flags) == wakeup_flags))
   722			return -EINVAL;
   723	
   724		rb = container_of(map, struct bpf_ringbuf_map, map)->rb;
   725		do {
   726			u32 size;
   727			void *sample;
   728	
   729			err = __bpf_user_ringbuf_poll(rb, &sample, &size);
   730	
   731			if (!err) {
   732				struct bpf_dynptr_kern dynptr;
   733	
   734				bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL,
   735						0, size);
 > 736				ret = callback((u64)&dynptr,
   737						(u64)(uintptr_t)callback_ctx, 0, 0, 0);
   738	
   739				__bpf_user_ringbuf_sample_release(rb, size, flags);
   740				num_samples++;
   741			}
   742		} while (err == 0 && num_samples < 4096 && ret == 0);
   743	
   744		return num_samples;
   745	}
   746	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
