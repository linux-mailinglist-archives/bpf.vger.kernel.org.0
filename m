Return-Path: <bpf+bounces-51789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B59DA390F1
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 03:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279901890405
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 02:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3085914885D;
	Tue, 18 Feb 2025 02:47:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBC923DE;
	Tue, 18 Feb 2025 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739846868; cv=none; b=ka1FYiOJwqAiJ8dnZm/B7vVZ6AZ29xPayX2GZDVO52goMIaREnvPrqzuIQZd9yBkBRfoeESdPhsCfbAwKT1wn44UIcNkhP263f4zdBfA48mZkKG84qtrx2y/Lh7Rn8zTS7dDwpZc/2jqYwozHIoulUISG/uuwi+Q/QAev/UME/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739846868; c=relaxed/simple;
	bh=vh6R4AHkmbR3moZclidczJg93/g+4eY55HePj1+pZ0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AdbwTWhV0NnvZvDlmkngK+OlQM9dKjaNJYzXJ4xZ3cSpLdcjk5LuwqC5VY14QbwbVIeQNNAOtNWiirEwSYdAqfdA3dQOIvNK6XsJx7YhXZh2DXcgEQWwZ5KscIjy8T8q07DcA7DKD9OG+I8gLNzD4s0aEcKqxM7agKwvZx6P12A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YxkP22X9Zz2JYZk;
	Tue, 18 Feb 2025 10:43:50 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C9611A016C;
	Tue, 18 Feb 2025 10:47:43 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Feb 2025 10:47:41 +0800
Message-ID: <c2924e9e-1a42-a4f6-5066-ea2e15477c11@huawei.com>
Date: Tue, 18 Feb 2025 10:47:41 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Add Morton,Peter and David for discussion//Re: [PATCH -next] uprobes:
 fix two zero old_folio bugs in __replace_page()
To: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, David Hildenbrand
	<david@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>,
	<wangkefeng.wang@huawei.com>, linux-mm <linux-mm@kvack.org>
References: <20250217123826.88503-1-tongtiangen@huawei.com>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20250217123826.88503-1-tongtiangen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk500005.china.huawei.com (7.202.194.90)



在 2025/2/17 20:38, Tong Tiangen 写道:
> We triggered the following error logs in syzkaller test:
> 
>    BUG: Bad page state in process syz.7.38  pfn:1eff3
>    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eff3
>    flags: 0x3fffff00004004(referenced|reserved|node=0|zone=1|lastcpupid=0x1fffff)
>    raw: 003fffff00004004 ffffe6c6c07bfcc8 ffffe6c6c07bfcc8 0000000000000000
>    raw: 0000000000000000 0000000000000000 00000000fffffffe 0000000000000000
>    page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x32/0x50
>     bad_page+0x69/0xf0
>     free_unref_page_prepare+0x401/0x500
>     free_unref_page+0x6d/0x1b0
>     uprobe_write_opcode+0x460/0x8e0
>     install_breakpoint.part.0+0x51/0x80
>     register_for_each_vma+0x1d9/0x2b0
>     __uprobe_register+0x245/0x300
>     bpf_uprobe_multi_link_attach+0x29b/0x4f0
>     link_create+0x1e2/0x280
>     __sys_bpf+0x75f/0xac0
>     __x64_sys_bpf+0x1a/0x30
>     do_syscall_64+0x56/0x100
>     entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
>     BUG: Bad rss-counter state mm:00000000452453e0 type:MM_FILEPAGES val:-1
> 
> The following syzkaller test case can be used to reproduce:
> 
>    r2 = creat(&(0x7f0000000000)='./file0\x00', 0x8)
>    write$nbd(r2, &(0x7f0000000580)=ANY=[], 0x10)
>    r4 = openat(0xffffffffffffff9c, &(0x7f0000000040)='./file0\x00', 0x42, 0x0)
>    mmap$IORING_OFF_SQ_RING(&(0x7f0000ffd000/0x3000)=nil, 0x3000, 0x0, 0x12, r4, 0x0)
>    r5 = userfaultfd(0x80801)
>    ioctl$UFFDIO_API(r5, 0xc018aa3f, &(0x7f0000000040)={0xaa, 0x20})
>    r6 = userfaultfd(0x80801)
>    ioctl$UFFDIO_API(r6, 0xc018aa3f, &(0x7f0000000140))
>    ioctl$UFFDIO_REGISTER(r6, 0xc020aa00, &(0x7f0000000100)={{&(0x7f0000ffc000/0x4000)=nil, 0x4000}, 0x2})
>    ioctl$UFFDIO_ZEROPAGE(r5, 0xc020aa04, &(0x7f0000000000)={{&(0x7f0000ffd000/0x1000)=nil, 0x1000}})
>    r7 = bpf$PROG_LOAD(0x5, &(0x7f0000000140)={0x2, 0x3, &(0x7f0000000200)=ANY=[@ANYBLOB="1800000000120000000000000000000095"], &(0x7f0000000000)='GPL\x00', 0x7, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, @fallback=0x30, 0xffffffffffffffff, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x10, 0x0, @void, @value}, 0x94)
>    bpf$BPF_LINK_CREATE_XDP(0x1c, &(0x7f0000000040)={r7, 0x0, 0x30, 0x1e, @val=@uprobe_multi={&(0x7f0000000080)='./file0\x00', &(0x7f0000000100)=[0x2], 0x0, 0x0, 0x1}}, 0x40)
> 
> The cause is that zero pfn is set to the pte without increasing the rss
> count in mfill_atomic_pte_zeropage() and the refcount of zero folio does
> not increase accordingly. Then, the operation on the same pfn is performed
> in uprobe_write_opcode()->__replace_page() to unconditional decrease the
> rss count and old_folio's refcount.
> 
> Therefore, two bugs are introduced:
> 1. The rss count is incorrect, when process exit, the check_mm() report
>     error "Bad rss-count".
> 2. The reserved folio (zero folio) is freed when folio->refcount is zero,
>     then free_pages_prepare->free_page_is_bad() report error "Bad page state".
> 
> To fix it, add zero folio check before rss counter and refcount decrease.
> 
> Fixes: 7396fa818d62 ("uprobes/core: Make background page replacement logic account for rss_stat counters")
> Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>   kernel/events/uprobes.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 46ddf3a2334d..ff5694acfa68 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -213,7 +213,8 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
>   		dec_mm_counter(mm, MM_ANONPAGES);
>   
>   	if (!folio_test_anon(old_folio)) {
> -		dec_mm_counter(mm, mm_counter_file(old_folio));
> +		if (!is_zero_folio(old_folio))
> +			dec_mm_counter(mm, mm_counter_file(old_folio));
>   		inc_mm_counter(mm, MM_ANONPAGES);
>   	}
>   
> @@ -227,7 +228,8 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
>   	if (!folio_mapped(old_folio))
>   		folio_free_swap(old_folio);
>   	page_vma_mapped_walk_done(&pvmw);
> -	folio_put(old_folio);
> +	if (!is_zero_folio(old_folio))
> +		folio_put(old_folio);
>   
>   	err = 0;
>    unlock:

