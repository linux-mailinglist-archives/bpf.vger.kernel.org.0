Return-Path: <bpf+bounces-75177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B645C75FB7
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 19:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A37B358663
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 18:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906A52C0F68;
	Thu, 20 Nov 2025 18:57:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB821283FFC
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665074; cv=none; b=SHpVSiPbpBMJ8pWLny3EIq/o/H6TCGc5mFfl7Eq/92fyjegB7sXUscL7+W21RTJSP5rjheqUW8xGtc+q/LW89/gHWaZdYYTTh7Wp1lEFQoIOyyVeCpuoyOnPZJwZr9IcEz66H2AP2zhogLzYuJzPC0I0l9gQ3p+GKCveAElKYVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665074; c=relaxed/simple;
	bh=4j5+DZ7AAu1NTYsJ4k3KYh9ipSMgsKwRH4EvQWGwbMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1Q4X7XH+fKskCEHliim2rje+Sr1a4SYjT3RW4Q8UKv7Y/gnmkBx1dfqPsNCC1Ci/apETDrb+G9Rw26PhWUlkZP2HexTKnk1iZFeme7xWEQufG/1l1xd6+omdAXySn1K5Htd4Jj4h45MtYBf4PJaPAXcpzpSykjHHnMIPkBs2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from localhost (chethan-pc.asicdesigners.com [10.193.177.170] (may be forged))
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 5AKI5Urk015577;
	Thu, 20 Nov 2025 10:05:31 -0800
Date: Thu, 20 Nov 2025 23:35:30 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: Kernel build fails if both CONFIG_DEBUG_INFO_BTF and
 CONFIG_CHELSIO_T4=y (was CONFIG_KCSAN)
Message-ID: <aR9YasvOhnSI564i@chelsio.com>
References: <2412725b-916c-47bd-91c3-c2d57e3e6c7b@acm.org>
 <d296ec97-933a-4b19-aa75-714e69b3ac4f@oracle.com>
 <7161e3e3-7bd0-47ec-892d-72a58b06df33@acm.org>
 <87641066-a837-41ff-acbc-9f4453d0ae58@oracle.com>
 <b8e8b560-bce5-414b-846d-0da6d22a9983@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8e8b560-bce5-414b-846d-0da6d22a9983@oracle.com>

On Thursday, November 11/20/25, 2025 at 23:23:39 +0530, Alan Maguire wrote:
> On 20/11/2025 14:20, Alan Maguire wrote:
> > On 18/11/2025 16:47, Bart Van Assche wrote:
> >> On 11/18/25 4:07 AM, Alan Maguire wrote:
> >>> hi Bart, thanks for the report! Not a know issue to me at least; I tried
> >>> to reproduce it with pahole v1.31 + gcc 12 and no luck. Would you mind
> >>> sharing a few additional details:
> >>>
> >>> - compiler version
> >>> - pahole version
> >>> - full .config
> >>
> >> Hi Alan,
> >>
> >> My answers to your questions are as follows:
> >> * Compiler version: gcc version 14.2.0 (Debian 14.2.0-19+build5)
> >> * pahole version: v1.30
> >> * Kernel config: has been attached to this email.
> >>
> > 
> > thanks Bart! I've reproduced this now with gcc-14.2.1 + pahole 1.30 and
> > it is also observed with latest pahole 1.31. Investigating now, but if
> > you want to work around it in the short term, disabling CONFIG_WERROR
> > should allow resolve_btfids to proceed even where duplicate types are
> > present. Hopefully we will have a root cause/fix shortly though. Thanks
> > again for the report!
> >
> 
> [adding cxgb4 maintainer, for reasons that will become clearer below.
> Context here is that Bart is seeing kernel builds fail at the
> resolve_btfids stage; resolve_btfids is finding the BPF Type Format
> representation of core kernel data structures has duplicate entries for
> key kernel data structures like task_struct]

> 
> After adding some debug-only messaging to btf__dedup() in libbpf (which
> I will send as a patch as it makes debugging these situations much
> easier) I saw:
> 
> libbpf: struct 'task_struct' (size 2560 vlen 194) appears equivalent but
> differs for 23-indexed cand/canon member 'sched_class'/'sched_class': 0
> 
> Examining sched_class we see:
> 
> [107] STRUCT 'task_struct' size=2560 vlen=194
> 	...
>         'sched_class' type_id=480 bits_offset=5440
> 	...
> 
> [479] CONST '(anon)' type_id=8624
> [480] PTR '(anon)' type_id=479
> 
> [8624] STRUCT 'sched_class' size=216 vlen=27
>         'enqueue_task' type_id=8844 bits_offset=0
>         'dequeue_task' type_id=8846 bits_offset=64
>         'yield_task' type_id=8823 bits_offset=128
>         'yield_to_task' type_id=8848 bits_offset=192
>         'wakeup_preempt' type_id=8844 bits_offset=256
>         'balance' type_id=8851 bits_offset=320
>         'pick_task' type_id=8853 bits_offset=384
>         'pick_next_task' type_id=8855 bits_offset=448
>         'put_prev_task' type_id=8857 bits_offset=512
>         'set_next_task' type_id=8859 bits_offset=576
>         'select_task_rq' type_id=8861 bits_offset=640
>         'migrate_task_rq' type_id=8863 bits_offset=704
>         'task_woken' type_id=8865 bits_offset=768
>         'set_cpus_allowed' type_id=8868 bits_offset=832
>         'rq_online' type_id=8823 bits_offset=896
>         'rq_offline' type_id=8823 bits_offset=960
>         'find_lock_rq' type_id=8870 bits_offset=1024
>         'task_tick' type_id=8844 bits_offset=1088
>         'task_fork' type_id=236 bits_offset=1152
>         'task_dead' type_id=236 bits_offset=1216
>         'switching_to' type_id=8865 bits_offset=1280
>         'switched_from' type_id=8865 bits_offset=1344
>         'switched_to' type_id=8865 bits_offset=1408
>         'reweight_task' type_id=8873 bits_offset=1472
>         'prio_changed' type_id=8844 bits_offset=1536
>         'get_rr_interval' type_id=8875 bits_offset=1600
>         'update_curr' type_id=8823 bits_offset=1664
> 
> 
> Now looking at the first duplicate:
> 
> [36354] STRUCT 'task_struct' size=2560 vlen=194
> 	...
>         'sched_class' type_id=36389 bits_offset=5440
> 	...
> 
> 
> [36387] STRUCT 'sched_class' size=64 vlen=6
>         'state' type_id=28 bits_offset=0
>         'idx' type_id=28 bits_offset=8
>         'info' type_id=38195 bits_offset=32
>         'bind_type' type_id=38228 bits_offset=256
>         'entry_list' type_id=90 bits_offset=320
>         'refcnt' type_id=84 bits_offset=448
> [36388] CONST '(anon)' type_id=36387
> [36389] PTR '(anon)' type_id=36388
> 
> 
> sched_class looks totally different! The reason is cxgb4 declares its
> own sched_class while also #include'ing task_struct-related headers.
> Bart's config exposed this because he had CONFIG_CHELSIO_T4=y (I had 'm'
> in my config).
> 
> If we look at drivers/net/ethernet/chelsio/cxgb4/sched.h we indeed see:
> 
> struct sched_class {
>         u8 state;
>         u8 idx;
>         struct ch_sched_params info;
>         enum sched_bind_type bind_type;
>         struct list_head entry_list;
>         atomic_t refcnt;
> };
> 
> ..and cxgb4_main.c has #include <linux/sched.h> and #include <sched.h>
> with the clashing sched_class. Using pahole we can establish that the
> BTF encoding is simply reflecting the DWARF representation ("pahole
> cxgb4.ko" shows this), so BTF is effectively correctly reflecting the
> underlying DWARF representation. This will make life confusing for
> debuggers too.
> 
> So although it is a bit of a pain, I would suggest the simplest approach
> is to perhaps look at renaming sched_class to be a bit more
> domain-specific - ch_sched_class perhaps? That way it will not clash
> with task_struct's sched_class.
> 
> I can send a patch but it would be great to get cxgb4 maintainers' take
> here first.
Thanks for adding me and the detailed debug, Alan and Bart.
I will try this and let you know.
> 
> Thanks!
> 
> Alan

