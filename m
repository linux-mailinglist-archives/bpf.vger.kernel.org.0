Return-Path: <bpf+bounces-65149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ABAB1CC15
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 20:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0221C72374A
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799DE29CB49;
	Wed,  6 Aug 2025 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n9waFYFD"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5038129CB48
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505887; cv=none; b=aET8+qd8OBim5AXGzUEt9a+MAQ/sUGRwWq9+l6CVY69cZNVx2LK14SntcxOLn0KWV7/XsXQvtd2hcUflU8VHRsVKZ5dWhUTKJ/WrCp+eE5XSshXxW/YVL2kZ649L7Iv9hElad7cYkXePdtITOrTGyGdrrDbUNQoAq417RXwgcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505887; c=relaxed/simple;
	bh=T2p8ZKyFRQ6fALZvxoRXSKm5IUIAkW0Y/RBQIJBY2nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzBWa7jvo0nDrC1nXbxsA7CZ0cpw5K+x+Y2b7/IulfOn/vs04qngVUI4UqTEsBXLSbS4qSDDJJ5sfk9yFaWLf65wlVGM8wjMT2Rr5o7Rx0feGtXMzXC6kVdk3vjqhgHfgrfnqB6UEvAdsI26RpvxzlnBXQ2dQavwKPz5eGlbGzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n9waFYFD; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3381e84d-2027-489a-b3e6-7ee16e2b14a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754505871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rseq+yM6khcjxXYpXh8TF5KJrGhBlcpX+a0L6c4BioE=;
	b=n9waFYFDMFzW4t4taVixze3GRZCWDuQVdQlu0JzkxiCNs846pvEWNSeNVeolO4U8UcmOYW
	6dwOvuMMviW/Wco20ko/9+QlITou3kELFZMTYAyncrExLAP5UX/K/++hguGLsgBZpyRjPV
	eJFxRfwbMj7/fdONto3TXvisVYYYnY0=
Date: Wed, 6 Aug 2025 11:44:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Add LINK_DETACH for iter and perf links
Content-Language: en-GB
To: Florian Lehner <dev@der-flo.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, netdev@vger.kernel.org
References: <20250801121053.7495-1-dev@der-flo.net>
 <f871d538-31b8-437a-b838-900836e13eb8@linux.dev>
 <aJOhPoTLdYnZmHYA@der-flo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aJOhPoTLdYnZmHYA@der-flo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/6/25 11:38 AM, Florian Lehner wrote:
> On Tue, Aug 05, 2025 at 02:07:20PM -0700, Yonghong Song wrote:
>>
>> On 8/1/25 5:10 AM, Florian Lehner wrote:
>>> 73b11c2a introduced LINK_DETACH and implemented it for some link types,
>>> like xdp, netns and others.
>>>
>>> This patch implements LINK_DETACH for perf and iter links, re-using
>>> existing link release handling code.
> [..]
>>>    static void bpf_iter_link_dealloc(struct bpf_link *link)
>>>    {
>>>    	struct bpf_iter_link *iter_link =
>>> @@ -490,6 +496,7 @@ static int bpf_iter_link_fill_link_info(const struct bpf_link *link,
>>>    static const struct bpf_link_ops bpf_iter_link_lops = {
>>>    	.release = bpf_iter_link_release,
>>> +	.detach = bpf_iter_link_detach,
>> Not sure how useful for this one. For bpf_iter programs,
>> the loaded prog will expect certain bpt_iter (e.g., bpf_map_elem, bpf_map, ...).
>> So even if you have detach, you won't be able to attach to a different
>> bpf_iter flavor.
>>
>> Do you have a use case for this one?
>>
> A key reason for adding this was to enable the temporary disabling and re-enabling of
> an attached BPF program while keeping the same bpf_iter flavor. If you don't think
> this is a strong enough use case, I'm open to removing this from the patch.
>
>>>    static void bpf_perf_link_dealloc(struct bpf_link *link)
>>>    {
>>>    	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
>>> @@ -4027,6 +4033,7 @@ static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
>>>    static const struct bpf_link_ops bpf_perf_link_lops = {
>>>    	.release = bpf_perf_link_release,
>>> +	.detach = bpf_perf_link_detach,
>> This one may be possible. You might be able to e.g., try a different bpf_cookie, or
>> different perf event.
>>
> The primary use case for this feature is to allow for the temporary disabling of
> uprobes that are attached using bpf_perf_links.

Okay, you patch looks good to me.

Acked-by: Yonghong Song <yonghong.song@linux.dev>



