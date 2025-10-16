Return-Path: <bpf+bounces-71166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC7EBE5D12
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 01:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3802D4E6702
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 23:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57A72E03FB;
	Thu, 16 Oct 2025 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dtN8AumE"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78771273D75
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 23:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760658723; cv=none; b=TIoy7BjMo33JHVfUzuYTWw4bhvhwZVGN6cLWPinQaYojzagjTFkjdA7V+o37VKedBtn/2fETxjkPMh0Vz7xCWJctZyG7JCsiOFUSoQxOhzGToZhK6IxrLEWuniQwdcbQ75eJ+GJw/cPIOxfEjjzFQt0Em/hHkxI4/MFoXvqVKLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760658723; c=relaxed/simple;
	bh=tAvhMX5aztr0Z9DAri+fzHHncZlsyVexnJ57AL6jcqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGn4rDgYmdxfL2pRbtUW04WgPi+XIDJvct03gkXT4fKTLwnkcdsoW2BGDjf7fxLRSa4E9dkJ+BC1gw04me7Op6JTcskXobtrDbpuQiZJyKGBuHHqPjLW7CRbVqVGXYQjPSnm4m9MkCBQQNy7vydyZwF9T2PGyQ0uGJzRq3sNBgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dtN8AumE; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5bf014d-46d7-44da-8a63-1982cd45d9ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760658718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMkN1P35QJXcNpqEISntYLu4gs0QGz5ABpRC4dfIYEE=;
	b=dtN8AumE+YYpYEMFyNeM565Hg/X1VuYn0CtEWYGZ09O2iJUPGsx0wxyczvhRTmztv/VHbH
	QfAytOz0yXqyBX/Cwu8ExdxsqErrRHkbuuSY6q8dHvB5OWoI09pn5HWtmlxazE5cLCIB6C
	FZ8i2poFwteXMF+M+GjDK4KtqG1oRDA=
Date: Thu, 16 Oct 2025 16:51:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Support associating BPF program with
 struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com
References: <20251016204503.3203690-1-ameryhung@gmail.com>
 <20251016204503.3203690-3-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251016204503.3203690-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/16/25 1:45 PM, Amery Hung wrote:
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index a41e6730edcf..e060d9823e4a 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -528,6 +528,7 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
>   	for (i = 0; i < st_map->funcs_cnt; i++) {
>   		if (!st_map->links[i])
>   			break;
> +		bpf_prog_disassoc_struct_ops(st_map->links[i]->prog);

It took me some time to understand why it needs to specifically call 
bpf_prog_disassoc_struct_ops here for struct_ops programs. bpf_prog_put 
has not been done yet. The BPF_PTR_POISON could be set back to NULL. My 
understanding is the BPF_PTR_POISON should stay with the prog's lifetime?
>   		bpf_link_put(st_map->links[i]);
>   		st_map->links[i] = NULL;
>   	}
> @@ -801,6 +802,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   			goto reset_unlock;
>   		}
>   
> +		/* If the program is reused, prog->aux->st_ops_assoc will be poisoned */
> +		bpf_prog_assoc_struct_ops(prog, &st_map->map);
> +
>   		link = kzalloc(sizeof(*link), GFP_USER);
>   		if (!link) {
>   			bpf_prog_put(prog);
> @@ -1394,6 +1398,46 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>   	return err;
>   }
>   
> +int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map)
> +{
> +	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
> +	void *kdata = &st_map->kvalue.data;
> +	int ret = 0;
> +
> +	mutex_lock(&prog->aux->st_ops_assoc_mutex);
> +
> +	if (prog->aux->st_ops_assoc && prog->aux->st_ops_assoc != kdata) {
> +		if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
> +			WRITE_ONCE(prog->aux->st_ops_assoc, BPF_PTR_POISON);
> +
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	WRITE_ONCE(prog->aux->st_ops_assoc, kdata);
> +out:
> +	mutex_unlock(&prog->aux->st_ops_assoc_mutex);
> +	return ret;
> +}
> +
> +void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
> +{
> +	mutex_lock(&prog->aux->st_ops_assoc_mutex);

Can it check the prog type here and decide if bpf_struct_ops_put needs 
to be called?

> +	WRITE_ONCE(prog->aux->st_ops_assoc, NULL);



