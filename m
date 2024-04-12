Return-Path: <bpf+bounces-26593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 781678A22FF
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 02:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A7D1C2283F
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 00:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7297A4414;
	Fri, 12 Apr 2024 00:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="twapsL1J"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB117E9
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712882746; cv=none; b=GFsEEh+DOX75KxhOKToRDyo/1vP4pS1STjzcTNLs3rHMbg7rRdMxO9WGyJEF3YxuDcW2HjjQGQM61oy7ZqO1EUlB+u+NYXhmYG3+736YJ1f+PcKWlLT7yYjufedJz3BSbqh6+IzIF3gVVXemhjU3b+PDJgKd4GSKzHwJG0Yrc7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712882746; c=relaxed/simple;
	bh=WICWHin3hX1DW3QNHTdvtD49sau2s6Cge+RHt79rDCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdMLvCizHs2MhxPx6Me6qvXxd89/1otFWyZC4k3AeY/u5hZu2pYx2hX13B/vA446XN3/uI1lH2jzk0KlEdBwsg+m92TL45CSNZ4QMhGHzmE4noGwjZdxzyFKTrFpTBlPxka8Hfn4IWA1NDABHYVArxOunAqDWvHZuHHqgTxqDOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=twapsL1J; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c0cef1f9-64db-49a2-8c64-3eb9e5092a0f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712882741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDBXv8VvuEuihDknHFwM75wDdGn0/XWeRQX26GRUPxg=;
	b=twapsL1Jjoj1zy7LLzzUeNWJTUK3ZtRc7x566xQXsm/N4mdhUHvG3hFcP0ET/NLLoK1kix
	c7ZZaYGlddtYLxNu0rcVWlAJee7/64webEYd4CJek2WlmvwPMQXp/uVcKuS+b/9I3aUzsK
	4OPw9iVDyzI+pJe8Uji4ZvbARif0RqU=
Date: Thu, 11 Apr 2024 17:45:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] net: netfilter: Make ct zone id configurable for
 bpf ct helper functions
To: Brad Cowie <brad@faucet.nz>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 coreteam@netfilter.org, daniel@iogearbox.net, davem@davemloft.net,
 john.fastabend@gmail.com, jolsa@kernel.org, kuba@kernel.org,
 lorenzo@kernel.org, memxor@gmail.com, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org,
 sdf@google.com, song@kernel.org
References: <29325462-d001-4cb3-909d-27f7243a5c05@linux.dev>
 <20240411022933.2946226-1-brad@faucet.nz>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240411022933.2946226-1-brad@faucet.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/10/24 7:29 PM, Brad Cowie wrote:
> On Sat, 6 Apr 2024 at 09:01, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>> How about the other fields (flags and dir) in the "struct nf_conntrack_zone" and
>> would it be useful to have values other than the default?
> 
> Good question, it would probably be useful to make these configurable
> as well. My reason for only adding ct zone id was to avoid changing
> the size of bpf_ct_opts (NF_BPF_CT_OPTS_SZ).
> 
> I would be interested in some opinions here on if it's acceptable to
> increase the size of bpf_ct_opts, if so, should I also add back some
> reserved options to the struct for future use?

I think the reserved[2] was there for the padding reason.

It should be the first time there is a __sz increase. May be worth to explore 
how it should work.

The opts_len check will need to check == old_size or == new_size. Only use the 
new fields if it is new_size.

There is

enum {
         NF_BPF_CT_OPTS_SZ = 12,
};

This enum probably needs to update with the new size also. NF_BPF_CT_OPTS_SZ 
should be under CO-RE and its enum value will be updated with the running kernel.

The bpf prog has its own struct bpf_ct_opts during compilation (from vmlinux.h 
or defined a local one), so may be the bpf prog can do something like this:

#include "vmlinux.h"

struct bpf_ct_opts___newer {
	s32 netns_id;
	s32 error;
	u8 l4proto;
	u8 dir;
	u8 reserved[2];
	u32 new_field; /* for example */
} __attribute__((preserve_access_index));

SEC("tc")
int run_in_older_kernel(struct __sk_buff *ctx)
{
	struct bpf_ct_opts___newer opts = {};

	/* min of the running kernel opts size or the
	 * local ___newer opts size
	 */
	bpf_skb_ct_lookup(ctx, &tup, sizeof(tup.ipv4), &opts,
			  min(NF_BPF_CT_OPTS_SZ, sizeof(opts));
}


> 
>> Can it actually test an alloc and lookup of a non default zone id?
> 
> Yes, I have a test written now and will include this in my v2 submission.
> 
>> Please also separate the selftest into another patch.
> 
> Will do.
> 


