Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1315A5638
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 23:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiH2VcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 17:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiH2Vbo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 17:31:44 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4752722B19
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 14:31:07 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSmLN-0006af-I1; Mon, 29 Aug 2022 23:30:53 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSmLN-000N2o-8H; Mon, 29 Aug 2022 23:30:53 +0200
Subject: Re: [PATCH v4 bpf-next 01/15] bpf: Introduce any context BPF specific
 memory allocator.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     andrii@kernel.org, tj@kernel.org, memxor@gmail.com, delyank@fb.com,
        linux-mm@kvack.org, bpf@vger.kernel.org, kernel-team@fb.com
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
 <20220826024430.84565-2-alexei.starovoitov@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <74acd56b-21bb-8ea8-092f-d1b4fcfc0790@iogearbox.net>
Date:   Mon, 29 Aug 2022 23:30:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220826024430.84565-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26642/Mon Aug 29 09:54:26 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/26/22 4:44 AM, Alexei Starovoitov wrote:
[...]
> +
> +/* Called from BPF program or from sys_bpf syscall.
> + * In both cases migration is disabled.
> + */
> +void notrace *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size)
> +{
> +	int idx;
> +	void *ret;
> +
> +	if (!size)
> +		return ZERO_SIZE_PTR;
> +
> +	idx = bpf_mem_cache_idx(size + LLIST_NODE_SZ);
> +	if (idx < 0)
> +		return NULL;
> +
> +	ret = unit_alloc(this_cpu_ptr(ma->caches)->cache + idx);
> +	return !ret ? NULL : ret + LLIST_NODE_SZ;
> +}
> +
> +void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
> +{
> +	int idx;
> +
> +	if (!ptr)
> +		return;
> +
> +	idx = bpf_mem_cache_idx(__ksize(ptr - LLIST_NODE_SZ));
> +	if (idx < 0)
> +		return;
> +
> +	unit_free(this_cpu_ptr(ma->caches)->cache + idx, ptr);
> +}
> +
> +void notrace *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma)
> +{
> +	void *ret;
> +
> +	ret = unit_alloc(this_cpu_ptr(ma->cache));
> +	return !ret ? NULL : ret + LLIST_NODE_SZ;
> +}
> +
> +void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
> +{
> +	if (!ptr)
> +		return;
> +
> +	unit_free(this_cpu_ptr(ma->cache), ptr);
> +}

Looks like smp_processor_id() needs to be made aware that preemption might
be ok just not migration to a different CPU?

   [...]
   [  593.639025] BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u16:246/1946
   [  593.639026] BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u16:83/1642
   [  593.639138] caller is bpf_mem_cache_free+0x14/0x40
   [  593.640971] caller is bpf_mem_cache_free+0x14/0x40
   [  593.641060] CPU: 6 PID: 1642 Comm: kworker/u16:83 Not tainted 5.19.0-gf0d7b67fb6f8 #1
   [  593.641874] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
   [  593.641874] Workqueue: events_unbound bpf_map_free_deferred
   [  593.641874] Call Trace:
   [  593.641874]  <TASK>
   [  593.641874]  dump_stack_lvl+0x69/0x9b
   [  593.641874]  check_preemption_disabled+0x10b/0x120
   [  593.641874]  bpf_mem_cache_free+0x14/0x40
   [  593.641874]  htab_map_free+0x13f/0x2a0
   [  593.641874]  process_one_work+0x28e/0x580
   [  593.641874]  worker_thread+0x1fb/0x420
   [  593.641874]  ? rcu_lock_release+0x20/0x20
   [  593.641874]  kthread+0xf1/0x110
   [  593.641874]  ? kthread_blkcg+0x40/0x40
   [  593.641874]  ret_from_fork+0x22/0x30
   [  593.641874]  </TASK>
   [  593.654117] CPU: 5 PID: 1946 Comm: kworker/u16:246 Not tainted 5.19.0-gf0d7b67fb6f8 #1
   [  593.654317] BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u16:83/1642
   [  593.654560] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
   [  593.654560] Workqueue: events_unbound bpf_map_free_deferred
   [  593.654560] Call Trace:
   [  593.654560]  <TASK>
   [  593.654560]  dump_stack_lvl+0x69/0x9b
   [  593.658872] caller is bpf_mem_cache_free+0x14/0x40
   [  593.654560]  check_preemption_disabled+0x10b/0x120
   [  593.654560]  bpf_mem_cache_free+0x14/0x40
   [  593.654560]  htab_map_free+0x13f/0x2a0
   [  593.654560]  process_one_work+0x28e/0x580
   [  593.654560]  worker_thread+0x1fb/0x420
   [  593.654560]  ? rcu_lock_release+0x20/0x20
   [  593.654560]  kthread+0xf1/0x110
   [  593.654560]  ? kthread_blkcg+0x40/0x40
   [  593.654560]  ret_from_fork+0x22/0x30
   [  593.654560]  </TASK>
   [...]
   [ 1158.399989] test_maps invoked oom-killer: gfp_mask=0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), order=0, oom_score_adj=0
   [ 1158.401948] CPU: 1 PID: 4147 Comm: test_maps Not tainted 5.19.0-gf0d7b67fb6f8 #1
   [ 1158.402612] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
   [ 1158.402666] Call Trace:
   [ 1158.402666]  <TASK>
   [ 1158.402666]  dump_stack_lvl+0x69/0x9b
   [ 1158.402666]  dump_header+0x4d/0x370
   [ 1158.402666]  out_of_memory+0x5a2/0x5e0
   [ 1158.402666]  __alloc_pages_slowpath+0xbf4/0x1140
   [ 1158.402666]  __alloc_pages+0x222/0x2c0
   [ 1158.402666]  folio_alloc+0x14/0x40
   [ 1158.402666]  filemap_alloc_folio+0x43/0x150
   [ 1158.402666]  __filemap_get_folio+0x263/0x3a0
   [ 1158.402666]  filemap_fault+0x20f/0x540
   [ 1158.410527]  __do_fault+0x4a/0x100
   [ 1158.410527]  do_fault+0x13a/0x630
   [ 1158.410527]  handle_mm_fault+0x83d/0x13d0
   [ 1158.410527]  do_user_addr_fault+0x33c/0x4e0
   [ 1158.410527]  exc_page_fault+0x72/0x280
   [ 1158.410527]  asm_exc_page_fault+0x22/0x30
   [ 1158.410527] RIP: 0033:0x7fa4d11a6ffc
   [ 1158.410527] Code: Unable to access opcode bytes at RIP 0x7fa4d11a6fd2.
   [ 1158.410527] RSP: 002b:00007ffd4fa8ac00 EFLAGS: 00000206
   [ 1158.410527] RAX: 0000000000000240 RBX: 0000000000000075 RCX: 00007fa4d11d4610
   [ 1158.410527] RDX: 0000000000000065 RSI: 00007fa4d11d42a0 RDI: 000055d328f91ac8
   [ 1158.410527] RBP: 00007ffd4fa8ace0 R08: 00007fa4d1198aa0 R09: 0000000000000001
   [ 1158.419624] R10: 00007ffd4fa8ace0 R11: 0000000000000246 R12: 000055d328f91ac8
   [ 1158.420234] R13: 000055d328f9e4e0 R14: 0000000000000000 R15: 00007fa4d11d3000
   [ 1158.420234]  </TASK>
   [...]
