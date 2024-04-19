Return-Path: <bpf+bounces-27226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575238AB0D4
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 16:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898C51C21423
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E712E1FE;
	Fri, 19 Apr 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJNR0YWO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B47D07F;
	Fri, 19 Apr 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537352; cv=none; b=nVNugKJ5aYwZo9n8LJZ6hsDUhRATNoXDN0QMOhtirL1MEwhcbYubOV30NzfqH0zDcxB3ppnBtxbPY1u0w/oX0PIIvwE8FvpcFeM2IFUYhl2DpON1vs0cwY3a6JfvvjWU1hcY+lIXwZA/wpNDNxwnsYw113+equd0OWoSGyRYoA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537352; c=relaxed/simple;
	bh=tektgKuhRYmgS6SU9ErBRhGJ7MIojlOEbAr/RKkkEY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jd6GVSxqE3/uFst3jqSw+1tMVDBQ3Z9u55C71x33HSeL5NWbvENCWBv27iu9dAPuAqDRBpyEZVoYOJtsZcErk+wv1WYbAuBPYNG5aX2WANqRDk/svZtV/Br0aDr7ZpJpSICS2BWWAQCnMFrRCMT2fFQPld2mMjmWsmHc0Nl7iQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJNR0YWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89017C072AA;
	Fri, 19 Apr 2024 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713537351;
	bh=tektgKuhRYmgS6SU9ErBRhGJ7MIojlOEbAr/RKkkEY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CJNR0YWOKFZVDiXXRZKpI98kR2QOH7GZzR7RqXyho/eptSZVB3FvMC/Ew9+wSOQq7
	 hQLLyOAGWPwtftple3OR+thxV2vOf9OQqrIYFAny6BQkt8otQf8pmgYyW8QFMMlMbH
	 3DqIdGJDaaYk0ltyi7tCd4uN+kRDg7BheNMCmCBnxHLDW6ztRhoH/DVAM64VxriV+H
	 ZGDK2IKlBJ0Dqk9iNje6EVjokuwlKlgwqGnSVmvjqNyVPx8gJ71rPorRUbFhWeOyQ0
	 djkQp9ZZrh8QhDktL2zqXhTowSWAnCsAwy7UVafHN7WVsB+KD1Odt/6TP6Y5fohwhg
	 PX6sBXCivqL7w==
Message-ID: <4959b5c6-920e-4fe1-99d6-e694555a6530@kernel.org>
Date: Fri, 19 Apr 2024 16:35:46 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] xdp: use flags field to disambiguate broadcast
 redirect
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240418071840.156411-1-toke@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240418071840.156411-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/04/2024 09.18, Toke Høiland-Jørgensen wrote:
> When redirecting a packet using XDP, the bpf_redirect_map() helper will set
> up the redirect destination information in struct bpf_redirect_info (using
> the __bpf_xdp_redirect_map() helper function), and the xdp_do_redirect()
> function will read this information after the XDP program returns and pass
> the frame on to the right redirect destination.
> 
> When using the BPF_F_BROADCAST flag to do multicast redirect to a whole
> map, __bpf_xdp_redirect_map() sets the 'map' pointer in struct
> bpf_redirect_info to point to the destination map to be broadcast. And
> xdp_do_redirect() reacts to the value of this map pointer to decide whether
> it's dealing with a broadcast or a single-value redirect. However, if the
> destination map is being destroyed before xdp_do_redirect() is called, the
> map pointer will be cleared out (by bpf_clear_redirect_map()) without
> waiting for any XDP programs to stop running. This causes xdp_do_redirect()
> to think that the redirect was to a single target, but the target pointer
> is also NULL (since broadcast redirects don't have a single target), so
> this causes a crash when a NULL pointer is passed to dev_map_enqueue().
> 
> To fix this, change xdp_do_redirect() to react directly to the presence of
> the BPF_F_BROADCAST flag in the 'flags' value in struct bpf_redirect_info
> to disambiguate between a single-target and a broadcast redirect. And only
> read the 'map' pointer if the broadcast flag is set, aborting if that has
> been cleared out in the meantime. This prevents the crash, while keeping
> the atomic (cmpxchg-based) clearing of the map pointer itself, and without
> adding any more checks in the non-broadcast fast path.
> 
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
> Reported-and-tested-by:syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
> Signed-off-by: Toke Høiland-Jørgensen<toke@redhat.com>
> ---
>   net/core/filter.c | 42 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 32 insertions(+), 10 deletions(-)

Thanks for finding root-cause and fixing this!

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

