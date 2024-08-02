Return-Path: <bpf+bounces-36249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAED945657
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 04:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B3B1F23458
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 02:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA22E1C693;
	Fri,  2 Aug 2024 02:41:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BBD613D;
	Fri,  2 Aug 2024 02:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722566484; cv=none; b=rITRYRY+y5aXIXYMnVDq5VTHbniXKmYt4g8Ik34sEMXzH1s/TEM33B1FQbLVOEL4SsQwNY4NOUBiumrE6he2i0PkloJHsaM4o+j58nf0F09UUwCejd2YJVyUIv6lFOiLNnvIylqzADHObeb50x0Gp97nhPPKSnSmKM9bErX0cJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722566484; c=relaxed/simple;
	bh=nPIBnnil8Qfd/KlJNy2Gg11pc9TGxiWflNn2Xckegl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DahENxTPKgVVlDul6YfRibSXdakgDUBNhLNxNZvsMzMqSnEMo1bl8Q/9Eipfb7irXxxZbxiTRpjuZGLwlPXN9eJl1zUttH+tXk3tB0jdEWHAlMU5JILQyWHTNd0UrOdCinHM1DCmRop1xmKLrD49xihqG1zHDpNvJOihunln2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WZql75NlMz1HFn8;
	Fri,  2 Aug 2024 10:38:27 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 83F291A0188;
	Fri,  2 Aug 2024 10:41:18 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 2 Aug 2024 10:41:17 +0800
Message-ID: <eb6d1474-a292-af20-b8b1-1c2de61405f4@huawei.com>
Date: Fri, 2 Aug 2024 10:41:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 6/8] perf/uprobe: split uprobe_unregister()
To: Andrii Nakryiko <andrii@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <oleg@redhat.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <jolsa@kernel.org>,
	<paulmck@kernel.org>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-7-andrii@kernel.org>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240731214256.3588718-7-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/1 5:42, Andrii Nakryiko 写道:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> With uprobe_unregister() having grown a synchronize_srcu(), it becomes
> fairly slow to call. Esp. since both users of this API call it in a
> loop.
> 
> Peel off the sync_srcu() and do it once, after the loop.
> 
> With recent uprobe_register()'s error handling reusing full
> uprobe_unregister() call, we need to be careful about returning to the
> caller before we have a guarantee that partially attached consumer won't
> be called anymore. So add uprobe_unregister_sync() in the error handling
> path. This is an unlikely slow path and this should be totally fine to
> be slow in the case of an failed attach.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Co-developed-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/uprobes.h                        |  8 ++++++--
>  kernel/events/uprobes.c                        | 18 ++++++++++++++----
>  kernel/trace/bpf_trace.c                       |  5 ++++-
>  kernel/trace/trace_uprobe.c                    |  6 +++++-
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c    |  3 ++-
>  5 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index a1686c1ebcb6..8f1999eb9d9f 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -105,7 +105,8 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
>  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
>  extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
> -extern void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc);
> +extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
> +extern void uprobe_unregister_sync(void);

[...]

>  static inline void
> -uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
> +uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc)
> +{
> +}
> +static inline void uprobes_unregister_sync(void)

*uprobes*_unregister_sync, is it a typo?

>  {
>  }
>  static inline int uprobe_mmap(struct vm_area_struct *vma)
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 3b42fd355256..b0488d356399 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1089,11 +1089,11 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
>  }
>  
>  /**
> - * uprobe_unregister - unregister an already registered probe.
> + * uprobe_unregister_nosync - unregister an already registered probe.
>   * @uprobe: uprobe to remove
>   * @uc: identify which probe if multiple probes are colocated.
>   */
> -void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
> +void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  {
>  	int err;
>  
> @@ -1109,10 +1109,14 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  		return;
>  
>  	put_uprobe(uprobe);
> +}
> +EXPORT_SYMBOL_GPL(uprobe_unregister_nosync);
>  
> +void uprobe_unregister_sync(void)
> +{
>  	synchronize_srcu(&uprobes_srcu);
>  }
> -EXPORT_SYMBOL_GPL(uprobe_unregister);
> +EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
>  
>  /**
>   * uprobe_register - register a probe
> @@ -1170,7 +1174,13 @@ struct uprobe *uprobe_register(struct inode *inode,
>  	up_write(&uprobe->register_rwsem);
>  
>  	if (ret) {
> -		uprobe_unregister(uprobe, uc);
> +		uprobe_unregister_nosync(uprobe, uc);
> +		/*
> +		 * Registration might have partially succeeded, so we can have
> +		 * this consumer being called right at this time. We need to
> +		 * sync here. It's ok, it's unlikely slow path.
> +		 */
> +		uprobe_unregister_sync();
>  		return ERR_PTR(ret);
>  	}
>  
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 73c570b5988b..6b632710c98e 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3184,7 +3184,10 @@ static void bpf_uprobe_unregister(struct bpf_uprobe *uprobes, u32 cnt)
>  	u32 i;
>  
>  	for (i = 0; i < cnt; i++)
> -		uprobe_unregister(uprobes[i].uprobe, &uprobes[i].consumer);
> +		uprobe_unregister_nosync(uprobes[i].uprobe, &uprobes[i].consumer);
> +
> +	if (cnt)
> +		uprobe_unregister_sync();
>  }
>  
>  static void bpf_uprobe_multi_link_release(struct bpf_link *link)
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 7eb79e0a5352..f7443e996b1b 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1097,6 +1097,7 @@ static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
>  static void __probe_event_disable(struct trace_probe *tp)
>  {
>  	struct trace_uprobe *tu;
> +	bool sync = false;
>  
>  	tu = container_of(tp, struct trace_uprobe, tp);
>  	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
> @@ -1105,9 +1106,12 @@ static void __probe_event_disable(struct trace_probe *tp)
>  		if (!tu->uprobe)
>  			continue;
>  
> -		uprobe_unregister(tu->uprobe, &tu->consumer);
> +		uprobe_unregister_nosync(tu->uprobe, &tu->consumer);
> +		sync = true;
>  		tu->uprobe = NULL;
>  	}
> +	if (sync)
> +		uprobe_unregister_sync();
>  }
>  
>  static int probe_event_enable(struct trace_event_call *call,
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 73a6b041bcce..928c73cde32e 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -478,7 +478,8 @@ static void testmod_unregister_uprobe(void)
>  	mutex_lock(&testmod_uprobe_mutex);
>  
>  	if (uprobe.uprobe) {
> -		uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
> +		uprobe_unregister_nosync(uprobe.uprobe, &uprobe.consumer);
> +		uprobe_unregister_sync();
>  		uprobe.offset = 0;
>  		uprobe.uprobe = NULL;
>  	}

-- 
BR
Liao, Chang

