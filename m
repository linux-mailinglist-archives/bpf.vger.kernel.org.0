Return-Path: <bpf+bounces-27491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B88AC8AD941
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 01:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51854B236D5
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 23:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3334594A;
	Mon, 22 Apr 2024 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bEMY83EE"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E6945034
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829427; cv=none; b=NlACwp4qj+U8u9uAuIzvYliWokP/Aa8TWEJXioc6GPMbM7zPBK89IlAEj/B6FafBEovuSHdXzN7Sx6OcudswlQLa9UdDonmFbcT+UiUoZuRt4hzDhmrtbXOZGiqxN9Q8mvyIGC9388EMUCKXoSuOX7RDaW7vHLYXHW7x9x97xNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829427; c=relaxed/simple;
	bh=Rli/JncFiBCH3n4tSbz1+yzNTi67z/MrREvXVfW6xuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trQlhJkGrkxC/CMZ/M6rY2RuWwZ/pv9Nc316SVYkPTGmFJxLyyOYriyoK04yWUswKFh+88NqOyfHSOqEdjdW3QeToujp68E5V6zvLRx9IuC7zdXo7YOpfzZkCTyCvE0NDcE+WRGWF9G40DeILGEGl+ez2xwUaM9LDhpC5v4f1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bEMY83EE; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <54f32ade-ec17-4c35-b993-44907111e7ca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713829422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyG9wZPTsvmDWyEAjye1BlAvXBjTBtVPfW+KHKgrk48=;
	b=bEMY83EEBbL3A2tDLAyzdzPNYpbn+A1TbNQH2g4UOctPIkaTsAkPJU2vjN66isXurJ+kIp
	L0AtRQRq/oNWxX5xsEKblha8lwGf5AAn5bxASYsOcAt4VHswkBWZ/KcELNZKCgM42fi+q8
	KuwoEB07zysGlk+hOJFK9xzny96Yvqg=
Date: Mon, 22 Apr 2024 16:43:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: enable the "open" operator on a pinned
 path of a struct_osp link.
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: andrii@kernel.org, kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org,
 song@kernel.org, kernel-team@meta.com
References: <20240417002513.1534535-1-thinker.li@gmail.com>
 <20240417002513.1534535-2-thinker.li@gmail.com>
 <8dadfcc9-1f6a-4b93-951b-548e4560ce5a@linux.dev>
 <0326d150-6b43-465c-ba43-7e7033b13408@gmail.com>
 <70bf97a6-19d8-4a26-8879-17db7c44a2cc@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <70bf97a6-19d8-4a26-8879-17db7c44a2cc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/22/24 10:30 AM, Kui-Feng Lee wrote:
> 
> 
> On 4/22/24 10:12, Kui-Feng Lee wrote:
>>
>>
>> On 4/19/24 17:05, Martin KaFai Lau wrote:
>>> On 4/16/24 5:25 PM, Kui-Feng Lee wrote:
>>>> +int bpffs_struct_ops_link_open(struct inode *inode, struct file *filp)
>>>> +{
>>>> +    struct bpf_struct_ops_link *link = inode->i_private;
>>>> +
>>>> +    /* Paired with bpf_link_put_direct() in bpf_link_release(). */
>>>> +    bpf_link_inc(&link->link);
>>>> +    filp->private_data = link;
>>>> +    return 0;
>>>> +}
>>>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
>>>> index af5d2ffadd70..b020d761ab0a 100644
>>>> --- a/kernel/bpf/inode.c
>>>> +++ b/kernel/bpf/inode.c
>>>> @@ -360,11 +360,16 @@ static int bpf_mkmap(struct dentry *dentry, umode_t 
>>>> mode, void *arg)
>>>>   static int bpf_mklink(struct dentry *dentry, umode_t mode, void *arg)
>>>>   {
>>>> +    const struct file_operations *fops;
>>>>       struct bpf_link *link = arg;
>>>> -    return bpf_mkobj_ops(dentry, mode, arg, &bpf_link_iops,
>>>> -                 bpf_link_is_iter(link) ?
>>>> -                 &bpf_iter_fops : &bpffs_obj_fops);
>>>> +    if (bpf_link_is_iter(link))
>>>> +        fops = &bpf_iter_fops;
>>>> +    else if (link->type == BPF_LINK_TYPE_STRUCT_OPS)
>>>
>>> Open a pinned link and then update should not be specific to struct_ops link. 
>>> e.g. should be useful to the cgroup link also?
>>
>> It could be. Here, I played safe in case it creates any unwanted side
>> effect for links of unknown types.
> 
> By the way, may I put it in a follow up patch if we want cgroup links?

This does not feel right. It is not struct_ops specific.

Before we dive in further, there is BPF_OBJ_GET which can get a fd of a pinned 
bpf obj (prog, map, and link). Take a look at bpf_link__open() in libbpf. Does 
it work for the use case that needs to update the link?


