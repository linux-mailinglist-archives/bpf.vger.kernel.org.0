Return-Path: <bpf+bounces-67777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFBBB4996E
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 21:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9664D3B9901
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C9123770D;
	Mon,  8 Sep 2025 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JaNplB5v"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0949A2367D5
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358581; cv=none; b=sEbi7p6zScqR+lKaSXYBHza3r9v2PTi3NPybZ6qCwGNhDsa2kbB5Dd926burU7YoWI5kFSyZJa6uqGNovsl4TZNz1HbSYuaMraRAuOyttoIRvdj+h+Yq/7NQupO8MgL4hgPnX45RAS4wi8O9W1G8kJOjqZeip3JcoOZrs/+nTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358581; c=relaxed/simple;
	bh=UY606G9c6Xos96OsBX8d4fV7GF3rjANcDbzoWR7Dg/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqKGpmyHtnxBsLHMinRygjE92ZL5C2prXXztHHU4sDOVgiIkHggB23xztMC0/lXrmXpuzo22v1JghxDlm0KV/BxMcik/W3mMoB3YpGFN9D8zLrGw+NHe2Qx0c5ZUvCc3XYVz2n2I4nsxgBRgTjIPgbZfIkhDZk5d3hJRZVu3CPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JaNplB5v; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6903137a-6e78-4fcc-8f86-6d20aeb0ca9b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757358576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9tBRy2Uws8/DFVHJt4kEDZx23tKui5miCgOFJqaJ7k=;
	b=JaNplB5vLAGvP8zsqQJmTbXSzi1Pqw+lKkGBwd4COr36ZI9yT5R7tyJTh7gDASW4WsSakN
	SDoeDv7JBwfWxm8UzIBbrwpcedudYd9ggbwT0SYIDiklmbPOIuzm/pbqm0PmDXtxDeOzp4
	cQG/dEA1wnL4/1j445seHfpV6UVs6MI=
Date: Mon, 8 Sep 2025 12:09:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/4] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
To: Paul Chaignon <paul.chaignon@gmail.com>, Amery Hung <ameryhung@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
References: <cover.1756983951.git.paul.chaignon@gmail.com>
 <a3f372a017489ae75545f42a903b12710c2836ca.1756983952.git.paul.chaignon@gmail.com>
 <CAADnVQ+EGdXHBfzrm_FC2mxtZ-Y-VU5Py5GOt9KriC8hVfRB8A@mail.gmail.com>
 <a9751ae4-adf1-4829-a5c9-2153e79d1ba9@iogearbox.net>
 <a3a927f6-7cad-46c7-9b20-89c9978acad7@gmail.com>
 <aLrkb-6ZFMLfMd-o@mail.gmail.com>
 <CAMB2axML8WkmA2Bv3gtvTnyq75cDO8ctqnPetB0jsYLQZVmNyg@mail.gmail.com>
 <aL8VXGQASeRo92xz@Tunnel>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <aL8VXGQASeRo92xz@Tunnel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/8/25 10:41 AM, Paul Chaignon wrote:
>>>> How about letting users specify the linear size through ctx->data_end? I am
>>>> working on a set that introduces a kfunc, bpf_xdp_pull_data(). A part of is
>>>> to support non-linear xdp_buff in test_run_xdp, and I am doing it through
>>>> ctx->data_end. Is it something reasonable for test_run_skb?
>>> Oh, nice! That was next on my list 🙂
>>>
>>> Why use data_end though? I guess it'd work for skb, but can't we just
>>> add a new field to the anonymous struct for BPF_PROG_TEST_RUN?
>>>
>> I choose to use ctx_in because it doesn't change the interface and
>> feels natural. kattr->test.ctx_in is already copied from users and
>> shows users' expectation about the input ctx. I think we should honor
>> that (as long as the value makes sense). WDYT?
> Ok, I think I see your point of view. To me, test.ctx_in*is* the
> context and not metadata about it. I'm worried it would be weird to
> users if we overload that field. I'm not against using that though if
> it's the consensus.

On the xdp side, the test_run_xdp has been using the ctx_in->data[_meta] to 
allow the user to specify the meta data (since commit 47316f4a3053). Using 
ctx_in->data_end [1]  to specify the end of the linear part seems to be a 
logical addition in xdp.

> 
>> Thanks for working on this. It would be great if there is some
>> consistency between test_run_skb and test_run_xdp.
> Definitely agree! Do you have a prototype anywhere I could check? If
> not, you can always flag any inconsistency when I send the v2.
[1]: https://lore.kernel.org/bpf/20250905173352.3759457-6-ameryhung@gmail.com/

