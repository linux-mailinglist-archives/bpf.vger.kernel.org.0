Return-Path: <bpf+bounces-22277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0327485B083
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 02:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87BE0B2252B
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 01:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0D938DCC;
	Tue, 20 Feb 2024 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LoNyJhQF"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2ED23751
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708392181; cv=none; b=hLmKPpUPOXUQrUfd58ZKAkCutJJprJn3bOM5jEeZVrVSyLHqe0QJsW1mgjU69T0Zlt4/AZpbD/IfXckQWbrp/dlSR7ph8Dz0JQU0JHyb/50tw94eVXDS8R00FsrWCMpoLCwsSbzanwxzMJ33JcEJwhcPCFo/4MfPMoMJOOTVNHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708392181; c=relaxed/simple;
	bh=f3nN/5PpZM0caoaynQ86bQe1QVx4/xRtyeiOgAEOB7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b89Lzsp6VPrFbKPA8/XRLnFxKbV1mWNIk/TIFEkCKi//fnqZGB/GtT6VyOM8KOmxR4rnJCw8rUkACHZ+vXiKTk6cf9KEmGYT6sjG+/6Rry9SkOaaGlgxCXLAumZZ2jKrqQBe/fGXq5MoIcEttPbzRMUk12eunvRAbjmeFruv2Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LoNyJhQF; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0aa59bdf-b443-4a56-bdec-368c958c9629@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708392177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBqvF6iC/OuLYWDwHocV8oS8tZGfT7FBrSCnWvofwPY=;
	b=LoNyJhQFffMOMrqH7rAZfjhPtvsbOJLZ0fS/IZIYPHW6F4aiZUaOkdiN8Uy3EkTBFPmqMK
	0K3P6Ee7ItBMH0x4b4mzgAWW4qpiceOW92uDPrJW5DCh7ny9RjYvRPZEVbfpFKycGzD2ew
	GyRjDnwkN2cCCl7q2iYtLVyZxCwoRw4=
Date: Mon, 19 Feb 2024 17:22:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Memory corruption in out_batch parameter of batch lookup APIs
Content-Language: en-GB
To: Martin Kelly <martin.kelly@crowdstrike.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
References: <1f98a10d-9fd7-4a0c-baa8-be31c1e78fa8@crowdstrike.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <1f98a10d-9fd7-4a0c-baa8-be31c1e78fa8@crowdstrike.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/16/24 4:24 PM, Martin Kelly wrote:
> Hi, I noticed there's a subtlety to to the batch APIs 
> (bpf_map_lookup_batch and bpf_map_lookup_and_delete_batch) that can 
> lead to bugs if callers are not careful, and I'm wondering about the 
> best way to document or address it.
>
> Specifically, the size of the data pointed to by in_batch/out_batch is 
> not clear, and if it's too small, the caller can see memory/stack 
> corruption. The function documentation isn't super clear about this, 
> calling in_batch "address of the first element in batch to read", so a 
> caller might reasonably assume that a pointer size is fine. However, 
> the right size actually depends on the map type.
>
> For hash and array maps, out_batch will be u32 (as the parameter is 
> used as an index). But for LPM trie, it will be the size of the key 
> (in the case of LPM trie, I think that's 260 bytes). If a caller 
> passes a pointer to memory smaller the key size, the kernel will 
> overwrite past that memory and corrupt the stack (or wherever 
> out_batch points). This is because of the copy_to_user(uobatch, 
> prev_key, map->key_size) at the end of generic_map_lookup_batch.
>
> It seems to me that we could add documentation to these functions 
> indicating that out_batch should be able to hold at least one key to 
> be safe. This is simple but overly strict (at the moment) for all map 
> types other than LPM trie. However, if we specifically call out LPM 
> trie as needing key-sized width while other map types need 4 bytes, 
> then this documentation could easily become out-of-date as new map 
> types are added.
>
> We could alternatively add a statement like "out_batch should 
> generally point to memory large enough to hold a single key, but for 
> some map implementations a smaller type is possible". This gives more 
> information but might be too vague for many API users, and it means 
> future kernels could be tied to this implementation to avoid breaking 
> users.
>
> Any thoughts/preferences on how best to handle this? I'm happy to send 
> a patch clarifying the documentation, but I'd like to get a general 
> consensus on the best way to proceed first.

For in_batch/out_batch, the only exception is hashmap which has in_batch/out_batch memory size to be 32.
For all other supported maps, in_batch/out_batch memory size should be equal to their corresponding key size.
Maybe you can clarify this in include/uapi/linux/bpf.h?

We can update the documentation later if there are any exceptions to the above rule.

>
> Thanks,
>
> Martin
>

