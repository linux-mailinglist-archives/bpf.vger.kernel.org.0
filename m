Return-Path: <bpf+bounces-40338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554B9986D68
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 09:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E68B21C77
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 07:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8A7188CB8;
	Thu, 26 Sep 2024 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ggzoTZc6"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86DA224D6
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 07:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727335191; cv=none; b=EJ0hjhrQoK5o3odObo+QxsTtFRQPg8V/cVqBTm7QjaqXBwhoDotYMiKDEDZHb6BcwFsNTcsxSthbCk70oFV2c2auTZ597Ec2QwZd1ZhCKMkS9eEH9NbiOiXlgySGggzFO4YzcMJyJRIeVutOnmgtvRHV5m1fyeaUtRxiefU/Ylo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727335191; c=relaxed/simple;
	bh=fqWjJ5x2DDDNlNPeLap+iQ5YKNYxtlT2Hh+zyQ7LTVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHj5ovBVbY0fKqD10uzUGMZzK1cAEp8ryEGSdwiy6xSokVJFrpJ/o4d9sc8cJTGJkSgxHRLhM8CNWm7vndQyYaERebTA+SRaigtoX3LRfcHfESmMLEA8r7VIHTgGl1icxMsMQhtJGwYbek2IZznlVh1EScyyVrSqpZSHDUiIF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ggzoTZc6; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0583343e-874c-4af7-a405-3e939a34762f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727335187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0S46fLE/Ll60j3bERSN5WiMsvc6qU9gkdj9vWZyJoYY=;
	b=ggzoTZc61Jj4ivKJrsTH+6tNFdBnVYIGN0zqs+ZJ0Hs93hJseL22nB1odCIiVjOGoKssm+
	dUjBNcX1qlXwpsOuGZtDhA+5Rh+IFUFb0HLSGkKQ7p4Ik0WHnoQAxdHCRTMWucZmtkbc0G
	eEFj5fxMrQj9ddVcVVoniSBYPLy+TZ0=
Date: Thu, 26 Sep 2024 15:19:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Prevent extending tail callee prog
 with freplace
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 xukuohai@huaweicloud.com, iii@linux.ibm.com, kernel-patches-bot@fb.com
References: <20240923134044.22388-1-leon.hwang@linux.dev>
 <20240923134044.22388-3-leon.hwang@linux.dev>
 <ab4afb61e39cea42fb2ae2f4a2e134415417bbf6.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <ab4afb61e39cea42fb2ae2f4a2e134415417bbf6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 25/9/24 13:32, Eduard Zingerman wrote:
> On Mon, 2024-09-23 at 21:40 +0800, Leon Hwang wrote:
> 
> [...]
> 
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 048aa2625cbef..b864b37e67c17 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1484,6 +1484,7 @@ struct bpf_prog_aux {
>>  	bool exception_cb;
>>  	bool exception_boundary;
>>  	bool is_extended; /* true if extended by freplace program */
>> +	atomic_t tail_callee_cnt;
> 
> Nit: the name is a bit misleading, this counts how many times the
>      program resides it prog maps. Confusing w/o additional comments.
>      Maybe something like 'member_of_prog_array_cnt'?
> 

'member_of_prog_array_cnt' is not accurate enough.

'prog_array_member_cnt' is better, and should alongside comment /*
counts how many times as member of prog_array */.

>>  	struct bpf_arena *arena;
>>  	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
>>  	const struct btf_type *attach_func_proto;
>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index 8d97bae98fa70..c12e0e3bf6ad0 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
>> @@ -961,13 +961,17 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
>>  		return ERR_PTR(-EINVAL);
>>  	}
>>  
>> +	atomic_inc(&prog->aux->tail_callee_cnt);
>>  	return prog;
>>  }
> 
> [...]
> 
>>  static u32 prog_fd_array_sys_lookup_elem(void *ptr)
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 18b3f9216b050..be829016d8182 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3501,6 +3501,18 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>>  		tgt_prog = prog->aux->dst_prog;
>>  	}
>>  
>> +	if (prog->type == BPF_PROG_TYPE_EXT &&
>> +	    atomic_read(&tgt_prog->aux->tail_callee_cnt)) {
>> +		/* Program extensions can not extend target prog when the target
>> +		 * prog has been updated to any prog_array map as tail callee.
>> +		 * It's to prevent a potential infinite loop like:
>> +		 * tgt prog entry -> tgt prog subprog -> freplace prog entry
>> +		 * --tailcall-> tgt prog entry.
>> +		 */
>> +		err = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>>  	err = bpf_link_prime(&link->link.link, &link_primer);
>>  	if (err)
>>  		goto out_unlock;
> 
> Is it possible there is a race between map update and prog attach?

Yes, it is possible.

> E.g. suppose the following sequence of events:
> - thread #1 enters prog_fd_array_get_ptr()
> - thread #1 successfully completes prog->aux->is_extended check (not extended)
> - thread #2 enters bpf_tracing_prog_attach()
> - thread #2 does atomic_read() for tgt_prog and it returns 0
> - thread #2 proceeds attaching freplace to tgt_prog
> - thread #1 does atomic_inc(&prog->aux->tail_callee_cnt)
> 
> Thus arriving to a state when tgt_prog is both a member of a map and
> is freplaced. Is this a valid scenario?
> 

This patch series aims to prevent such case that tgt_prog is a member of
prog_array and is freplaced at the same time.

Without this patch series, a prog can be extended by freplace prog and then
be updated to prog_array, or can be updated to prog_array and then be
extended by freplace prog, in order to construct such case.

This patch aims to prevent "be updated to prog_array and then be extended
by freplace prog".
The previous patch aims to prevent "be extended by freplace prog and then
be updated to prog_array".

So, in order to avoid the above case:

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index a43e62e2a8bb..da4e26029a33 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -948,7 +948,9 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
        if (IS_ERR(prog))
                return prog;

-       if (!bpf_prog_map_compatible(map, prog)) {
+       atomic_inc(&prog->aux->tail_callee_cnt);
+       if (!bpf_prog_map_compatible(map, prog) || prog->aux->is_extended) {
+               atomic_dec(&prog->aux->tail_callee_cnt);
                bpf_prog_put(prog);
                return ERR_PTR(-EINVAL);
        }

1. Increment tail_callee_cnt.
2. Decrement tail_callee_cnt, if prog->aux->is_extended.

Then, thread #2 does atomic_read() for tgt_prog, and it won't return 0.

Thanks,
Leon

