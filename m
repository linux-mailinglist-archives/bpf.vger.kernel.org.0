Return-Path: <bpf+bounces-35047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 693EF937274
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 04:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128841F21A24
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 02:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA98BA39;
	Fri, 19 Jul 2024 02:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nxIb3rBI"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2489B184D
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 02:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721355954; cv=none; b=gHM98qPCLV3jkO7PLSMGnxXqvGJFFHnhFEm1geA+6Qu+YFdVH+3s/Z3Axe6AMvLHjwhNO/ZfJkVKfhppcNp7R8GxOrUUk08HN1nHN5GtuVwjyfbvoSbT+YtrP/jekI8VBl1HA2akTkRz60nle2qCxihYzONJptbM+CXdIiTDhu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721355954; c=relaxed/simple;
	bh=T77R5RyzX0nHq/IJc20Ki5FR8bebYPGI1ztUNJ1sEv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tu11gHRDjz4t89GzldB23nB7rt0uUi7AC6J6TaHkemHoymH/Mn0YYDmOA0WLjewIypOvGaUJbLOX+w/6QD3BbXkPV0Sen1DFRsG03rr5uMquUiRJGwAN5q5/2F7sNx9DhqYEgeLt5gUAS859qs18+fWMDtQZ0cEB2RO5B3zUh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nxIb3rBI; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: houtao@huaweicloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721355951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LarI9buMmMtEMjPDmndw6Pk2fDlCMDlc6lIj2iOEviQ=;
	b=nxIb3rBIVGCyjPhWiGryJFPqF55mCIP6bb0EBWwsvi1aB1X9IQsuPtKu1AhcnBQ3QqZkv2
	wJ22TTVe5UbmXaOJ5Bq4ss4ZNx6xV7r04XTSnk9Xu6b5zPkQLSyw78CkwNnBypXZBKq/+N
	KJyEWv/LVArmpRrOYQ1dFF/f1oQuzXQ=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-perf-users@vger.kernel.org
X-Envelope-To: acme@kernel.org
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: yhs@fb.com
X-Envelope-To: kjlx@templeofstupid.com
X-Envelope-To: houtao1@huawei.com
Message-ID: <9e3d8130-f5a7-459d-b1f4-033c367cd838@linux.dev>
Date: Thu, 18 Jul 2024 19:25:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] perf/bpf: Use prog to emit ksymbol event for
 main program
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
 Krister Johansen <kjlx@templeofstupid.com>, houtao1@huawei.com
References: <20240714065533.1112616-1-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240714065533.1112616-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/13/24 11:55 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Since commit 0108a4e9f358 ("bpf: ensure main program has an extable"),
> prog->aux->func[0]->kallsyms is left as uninitialized. For bpf program
> with subprogs, the symbol for the main program is missed just as shown
> in the output of perf script below:
>
>   ffffffff81284b69 qp_trie_lookup_elem+0xb9 ([kernel.kallsyms])
>   ffffffffc0011125 bpf_prog_a4a0eb0651e6af8b_lookup_qp_trie+0x5d (bpf...)
>   ffffffff8127bc2b bpf_for_each_array_elem+0x7b ([kernel.kallsyms])
>   ffffffffc00110a1 +0x25 ()
>   ffffffff8121a89a trace_call_bpf+0xca ([kernel.kallsyms])
>
> Fix it by always using prog instead prog->aux->func[0] to emit ksymbol
> event for the main program. After the fix, the output of perf script
> will be correct:
>
>   ffffffff81284b96 qp_trie_lookup_elem+0xe6 ([kernel.kallsyms])
>   ffffffffc001382d bpf_prog_a4a0eb0651e6af8b_lookup_qp_trie+0x5d (bpf...)
>   ffffffff8127bc2b bpf_for_each_array_elem+0x7b ([kernel.kallsyms])
>   ffffffffc0013779 bpf_prog_245c55ab25cfcf40_qp_trie_lookup+0x25 (bpf...)
>   ffffffff8121a89a trace_call_bpf+0xca ([kernel.kallsyms])
>
> Fixes: 0108a4e9f358 ("bpf: ensure main program has an extable")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
> Hi,
>
> ksymbol for bpf program had been broken twice, and I think it is better
> to add a bpf selftest for it, but I'm not so familiar with the
> perf_event_open(), for now I just post the fix patch and will post the
> selftest later.
>
>   kernel/events/core.c | 28 +++++++++++++---------------
>   1 file changed, 13 insertions(+), 15 deletions(-)

I actually just hit this issue with patch in
    https://lore.kernel.org/bpf/20240718205158.3651529-1-yonghong.song@linux.dev/T/#m92fd74865d93306757a10eb27d1e4f84cfffd5a8

This patch fixed the issue. So

Tested-by: Yonghong Song <yonghong.song@linux.dev>

>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f0128c5ff278..e1b7d9e61fa0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9289,21 +9289,19 @@ static void perf_event_bpf_emit_ksymbols(struct bpf_prog *prog,
>   	bool unregister = type == PERF_BPF_EVENT_PROG_UNLOAD;
>   	int i;
>   
> -	if (prog->aux->func_cnt == 0) {
> -		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
> -				   (u64)(unsigned long)prog->bpf_func,
> -				   prog->jited_len, unregister,
> -				   prog->aux->ksym.name);
> -	} else {
> -		for (i = 0; i < prog->aux->func_cnt; i++) {
> -			struct bpf_prog *subprog = prog->aux->func[i];
> -
> -			perf_event_ksymbol(
> -				PERF_RECORD_KSYMBOL_TYPE_BPF,
> -				(u64)(unsigned long)subprog->bpf_func,
> -				subprog->jited_len, unregister,
> -				subprog->aux->ksym.name);
> -		}
> +	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
> +			   (u64)(unsigned long)prog->bpf_func,
> +			   prog->jited_len, unregister,
> +			   prog->aux->ksym.name);
> +
> +	for (i = 1; i < prog->aux->func_cnt; i++) {
> +		struct bpf_prog *subprog = prog->aux->func[i];
> +
> +		perf_event_ksymbol(
> +			PERF_RECORD_KSYMBOL_TYPE_BPF,
> +			(u64)(unsigned long)subprog->bpf_func,
> +			subprog->jited_len, unregister,
> +			subprog->aux->ksym.name);
>   	}
>   }
>   

