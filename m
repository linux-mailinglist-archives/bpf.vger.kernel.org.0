Return-Path: <bpf+bounces-35844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD6193EB37
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 04:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9FB1F22036
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 02:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3617577113;
	Mon, 29 Jul 2024 02:25:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDAC1B86D6
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219915; cv=none; b=rCPkV1zZNOG204ZhcYwVduiCJifUd/iEfpyrBRY1hzFtkf71//fpYiccT8YLS+3SpnYoNWIdoSbbeNNBAwTOJjIhxPYozhki7Yq7CYhXT7dURyDpJoneElULIgGnrW+ywz72uwlw/5ZFYdnc4hL5ceBfwr5jGL/8TUM3sOSxx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219915; c=relaxed/simple;
	bh=qBrv5e9q++Zily007wHWRTtpqVexwmX4KRQupdLZC2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3oxynnf30LrTshmpB1CH+OWX3bB1BBwp1B3uZplbaOffKnDgfhne7K0fca4pwBFysYUZl6MtF+s/6FGcB2t/RSUN+b0xeOOI26IbAPUIfndol1znn4KwbUO2EX/lfeOlNLHPnMOSqLbmNjSu/4WNepAUcqDr3k0oih7OxZnzYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WXMdF3LVHz4f3kvw
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 10:24:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4BDB21A1342
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 10:25:03 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgCXSLd9_aZmtdyVAA--.32548S2;
	Mon, 29 Jul 2024 10:25:03 +0800 (CST)
Message-ID: <bea581c0-5d47-4767-b8c8-194193fa86fe@huaweicloud.com>
Date: Mon, 29 Jul 2024 10:25:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix updating attached freplace prog
 to prog_array map
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 kernel-patches-bot@fb.com
References: <20240728114612.48486-1-leon.hwang@linux.dev>
 <20240728114612.48486-2-leon.hwang@linux.dev>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20240728114612.48486-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXSLd9_aZmtdyVAA--.32548S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1fZFW8Xr48XF4xJw48Xrb_yoW5tFyfpF
	WkursrGF1kXay7Ww4jkayxZ34SvrWUXry3Kr1Fgw1jvF12qr48WFyUWFyqkF98KrWFgw40
	v3W29Fs5GayUXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2024/7/28 19:46, Leon Hwang wrote:
> The commit f7866c358733 ("bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT")
> fixed a NULL pointer dereference panic, but didn't fix the issue that
> fails to update attached freplace prog to prog_array map.
> 
> Since commit 1c123c567fb1 ("bpf: Resolve fext program type when checking map compatibility"),
> freplace prog and its target prog are able to tail call each other.
> 
> And the commit 3aac1ead5eb6 ("bpf: Move prog->aux->linked_prog and trampoline into bpf_link on attach")
> sets prog->aux->dst_prog as NULL after attaching freplace prog to its
> target prog.
> 
> Then, as for following example:
> 
> tailcall_freplace.c:
> 
> // SPDX-License-Identifier: GPL-2.0
> 
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
> 
> struct {
> 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> 	__uint(max_entries, 1);
> 	__uint(key_size, sizeof(__u32));
> 	__uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
> 
> int count = 0;
> 
> SEC("freplace")
> int entry_freplace(struct __sk_buff *skb)
> {
> 	count++;
> 	bpf_tail_call_static(skb, &jmp_table, 0);
> 	return count;
> }
> 
> char __license[] SEC("license") = "GPL";
> 
> tc_bpf2bpf.c:
> 
> // SPDX-License-Identifier: GPL-2.0
> 
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
> \#include "bpf_misc.h"
> 
> __noinline
> int subprog(struct __sk_buff *skb)
> {
> 	int ret = 1;
> 
> 	__sink(ret);
> 	return ret;
> }
> 
> SEC("tc")
> int entry_tc(struct __sk_buff *skb)
> {
> 	return subprog(skb);
> }
> 
> char __license[] SEC("license") = "GPL";
> 
> And entry_freplace's target is the entry_tc's subprog.
> 
> After loading entry_freplace, the jmp_table's owner type is
> BPF_PROG_TYPE_SCHED_CLS.
> 
> Next, after attaching entry_freplace to entry_tc's subprog, its prog->aux->
> dst_prog is NULL.
> 
> Next, while updating entry_freplace to jmp_table, bpf_prog_map_compatible()
> returns false because resolve_prog_type() returns BPF_PROG_TYPE_EXT instead
> of BPF_PROG_TYPE_SCHED_CLS.
> 
> With this patch, resolve_prog_type() returns BPF_PROG_TYPE_SCHED_CLS to
> support updating the attached entry_freplace to jmp_table.
> 
> Fixes: f7866c358733 ("bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT")
> Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf_verifier.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 5cea15c81b8a8..bfd093ac333f2 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -874,8 +874,8 @@ static inline u32 type_flag(u32 type)
>  /* only use after check_attach_btf_id() */
>  static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
>  {
> -	return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->dst_prog) ?
> -		prog->aux->dst_prog->type : prog->type;
> +	return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->saved_dst_prog_type) ?
> +		prog->aux->saved_dst_prog_type : prog->type;
>  }
>  
>  static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)

This is indeed a better way to fix both two issues we encountered. LGTM.


