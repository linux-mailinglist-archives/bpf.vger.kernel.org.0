Return-Path: <bpf+bounces-57741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED705AAF638
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 11:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 552FC7AEA86
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 08:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1D4263F52;
	Thu,  8 May 2025 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EntaS6PE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49142144BF;
	Thu,  8 May 2025 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694851; cv=none; b=qEnyfDe1IKJeKDtTMEuyFlELCsO7KDyqf+l4N+6J13tDQ0A7YTVk/Hwr8Z74M6VzBlNpAZlanWwOTpnNio/Ux3aHZJWlSfYYYU8M3WQK718xKGypRx68eiHawawRRtisN/9Q2u8Yj4RQ91GdIOwJTm9wRknQAxWIuc6otSLNds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694851; c=relaxed/simple;
	bh=oRy169AiB0biyCJ04ORgqiwlaZYY4hkb7T/QWvZpwEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haKZjMcZpXe2sWhcl/yNRCzTGN0Th94gcB549RExMvb+4oIqNQJ1/xINDN5MU+0gKqd5XdlOcOxaNkdfvfGx9jEfwFmdY4FhhWmpThdmMjDksna2cZU4Cv9ldBJyriiT4Iswbiea/r7LljIM163Srlcz9R/HVMbSROwrmPDEOQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EntaS6PE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0515CC4CEF0;
	Thu,  8 May 2025 09:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746694851;
	bh=oRy169AiB0biyCJ04ORgqiwlaZYY4hkb7T/QWvZpwEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EntaS6PEywHgSY68Uq+kYEw12OnDvY0LVobq7FZrTDNUYABlCZvvYQnxlt0Q/ewT5
	 78EiqYGC33KPUTcQCUqHd1MuJc9tstNHMR3v0MYt/Cn52Jxk+IXjxhgn8VPTquuNZa
	 5lWovRaljPJs5crlM+VB2hJCTiXocIC8hCbjrv5fwZMh87ZUOkSywlMEa+sA2RLGSC
	 Tt8jCwXyQ3XxLBr2vbFHMFeEUXo4a6bntXTXCG3u4+G88YF5y6hMLk4mW+bBfdZWPh
	 8ONSRl01UUnkv6EKgfUaLoxo1+R5HM7H0a1Tt7N7xsBWjCnxDv89TzIfJ02e7oF7Gn
	 Xm1GkWF8QHr7A==
Message-ID: <32dbb1b7-8f9d-4025-9f74-be04b31e2816@kernel.org>
Date: Thu, 8 May 2025 10:00:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Fix cgroup command to only show cgroup
 bpf programs
To: Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
 'Andrii Nakryiko ' <andrii@kernel.org>, netdev@vger.kernel.org,
 kernel-team@meta.com, Takshak Chahande <ctakshak@meta.com>
References: <20250507203232.1420762-1-martin.lau@linux.dev>
 <dcada116-20c7-45d6-8a94-8492d87f026e@iogearbox.net>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <dcada116-20c7-45d6-8a94-8492d87f026e@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-05-07 23:00 UTC+0200 ~ Daniel Borkmann <daniel@iogearbox.net>
> On 5/7/25 10:32 PM, Martin KaFai Lau wrote:
>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> The netkit program is not a cgroup bpf program and should not be shown
>> in the output of the "bpftool cgroup show" command.
>>
>> However, if the netkit device happens to have ifindex 3,
>> the "bpftool cgroup show" command will output the netkit
>> bpf program as well:
>>
>>> ip -d link show dev nk1
>> 3: nk1@if2: ...
>>      link/ether ...
>>      netkit mode ...
>>
>>> bpftool net show
>> tc:
>> nk1(3) netkit/peer tw_ns_nk2phy prog_id 469447
>>
>>> bpftool cgroup show /sys/fs/cgroup/...
>> ID       AttachType      AttachFlags     Name
>> ...      ...                             ...
>> 469447   netkit_peer                     tw_ns_nk2phy
>>
>> The reason is that the target_fd (which is the cgroup_fd here) and
>> the target_ifindex are in a union in the uapi/linux/bpf.h. The bpftool
>> iterates all values in "enum bpf_attach_type" which includes
>> non cgroup attach types like netkit. The cgroup_fd is usually 3 here,
>> so the bug is triggered when the netkit ifindex just happens
>> to be 3 as well.
>>
>> The bpftool's cgroup.c already has a list of cgroup-only attach type
>> defined in "cgroup_attach_types[]". This patch fixes it by iterating
>> over "cgroup_attach_types[]" instead of "__MAX_BPF_ATTACH_TYPE".
>>
>> Cc: Quentin Monnet <qmo@kernel.org>
>> Reported-by: Takshak Chahande <ctakshak@meta.com>
>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> 
> Outch, good catch!
> 
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> 


Nice one indeed, thanks!

Reviewed-by: Quentin Monnet <qmo@kernel.org>

