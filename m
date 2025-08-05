Return-Path: <bpf+bounces-65090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7AEB1BBA2
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 23:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38763BACFF
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 21:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CAB24A07C;
	Tue,  5 Aug 2025 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z+UzRteo"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB63632
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754428062; cv=none; b=bTqcURNzLQg8dju3TCtcH45VxovbahNZcyt66GdQ0M5YDjQLAChrBgNdurftAdT6rDQ4aLEZP9vgknvgw8djwIsClvfXuXO+knTvnyVlydWzNRO0+b+UNZObV9OT1stRDha5kS4WcoMKfNDkZsRLn0UV8i1TlvzFr4/a6nbRknM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754428062; c=relaxed/simple;
	bh=n2tBJeLU4Jj59vch1TZH2lZrproxwWqESixZE6iNuGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBTjpP7wp1hGpkLFRuYe8DpDjv7qERsFsRu0LdKxucXba82zcpq7xdAslap4kIP8R35M3czzuP6FsXc61xvOcxHBPnrezi8byv35R6/KAaX397aHg7U2WV6whBbwv9g5IopGKuMjNpWZtwWLU1GPyUs2siufRvcVDXESVGD+X54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z+UzRteo; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f871d538-31b8-437a-b838-900836e13eb8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754428047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTH8lCWv5fN9/GBV5Io17kAeDOePVc99yGeJbJcOZJA=;
	b=Z+UzRteoLWVMxtusmEg9JJXb6xa1X/ZavAoXN1v+DBcOUbSJjY5mEhMmApRj++hC7sKDSF
	RSFmt+2HkmMG6mBBQv9isTNH6LSBe3yEbRfbFC8nCPXgNN7GLxhRJJcM0Qkeb2inImtGS6
	D3JWdUBe1tV3dM6/FINf2FfRYpzlh/o=
Date: Tue, 5 Aug 2025 14:07:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Add LINK_DETACH for iter and perf links
Content-Language: en-GB
To: Florian Lehner <dev@der-flo.net>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, netdev@vger.kernel.org
References: <20250801121053.7495-1-dev@der-flo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250801121053.7495-1-dev@der-flo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/1/25 5:10 AM, Florian Lehner wrote:
> 73b11c2a introduced LINK_DETACH and implemented it for some link types,
> like xdp, netns and others.
>
> This patch implements LINK_DETACH for perf and iter links, re-using
> existing link release handling code.
>
> Signed-off-by: Florian Lehner <dev@der-flo.net>
> ---
>   kernel/bpf/bpf_iter.c | 7 +++++++
>   kernel/bpf/syscall.c  | 7 +++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 0cbcae727079..823dad09735d 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -397,6 +397,12 @@ static void bpf_iter_link_release(struct bpf_link *link)
>   		iter_link->tinfo->reg_info->detach_target(&iter_link->aux);
>   }
>   
> +static int bpf_iter_link_detach(struct bpf_link *link)
> +{
> +	bpf_iter_link_release(link);
> +	return 0;
> +}
> +
>   static void bpf_iter_link_dealloc(struct bpf_link *link)
>   {
>   	struct bpf_iter_link *iter_link =
> @@ -490,6 +496,7 @@ static int bpf_iter_link_fill_link_info(const struct bpf_link *link,
>   
>   static const struct bpf_link_ops bpf_iter_link_lops = {
>   	.release = bpf_iter_link_release,
> +	.detach = bpf_iter_link_detach,

Not sure how useful for this one. For bpf_iter programs,
the loaded prog will expect certain bpt_iter (e.g., bpf_map_elem, bpf_map, ...).
So even if you have detach, you won't be able to attach to a different
bpf_iter flavor.

Do you have a use case for this one?

>   	.dealloc = bpf_iter_link_dealloc,
>   	.update_prog = bpf_iter_link_replace,
>   	.show_fdinfo = bpf_iter_link_show_fdinfo,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e63039817af3..e89694f6874a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3733,6 +3733,12 @@ static void bpf_perf_link_release(struct bpf_link *link)
>   	fput(perf_link->perf_file);
>   }
>   
> +static int bpf_perf_link_detach(struct bpf_link *link)
> +{
> +	bpf_perf_link_release(link);
> +	return 0;
> +}
> +
>   static void bpf_perf_link_dealloc(struct bpf_link *link)
>   {
>   	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
> @@ -4027,6 +4033,7 @@ static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
>   
>   static const struct bpf_link_ops bpf_perf_link_lops = {
>   	.release = bpf_perf_link_release,
> +	.detach = bpf_perf_link_detach,

This one may be possible. You might be able to e.g., try a different bpf_cookie, or
different perf event.

>   	.dealloc = bpf_perf_link_dealloc,
>   	.fill_link_info = bpf_perf_link_fill_link_info,
>   	.show_fdinfo = bpf_perf_link_show_fdinfo,


