Return-Path: <bpf+bounces-76102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5062DCA7C95
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 14:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 623FB344D51F
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 10:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A387E2F39DE;
	Fri,  5 Dec 2025 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDMHyCer"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD23101A8
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764928895; cv=none; b=anzcZuMWq3StqGFOsVPDLzSJcX+XKtK35zAgViIK/Zj2jH5d97F7QyoJP1JDZ0Kzp2KSYrsXTTHpi3NDjeonzoVOjqg4xuS+7oy4yOin6j0rVFrwYZdMUnQr1VpoH3iw3cm0sOo3QBdGgWTFwMuTlppodhWCN5L8Q3Fx3gE1ilc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764928895; c=relaxed/simple;
	bh=1jYBKTOg7BIKBzDahdtYTj1jUUfjC1+UndIdQnOGxcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EADt1YQtM0UQ3yYrI9CWCMc+aFmcXoRNMU1wuy+fMBnVz6VafPJD6A83rCAHtU34GT6cdGJ1DhZWSZ2vHFC6xDomkwoI2fA+HEAuo+/mmDGUbOTqxb5vQRFUz6nEMHKGMRFPVciK+mfsy14T6bDaZ6HMYv4N8ZGYyuqe19ln6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDMHyCer; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182E9C4CEF1;
	Fri,  5 Dec 2025 10:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764928894;
	bh=1jYBKTOg7BIKBzDahdtYTj1jUUfjC1+UndIdQnOGxcQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WDMHyCervh2BatAh1AzVWP57GZwRS38NxnkYiMwnlM2wVn5nmNp3IEhmeGRUQMlDq
	 x9Cj1vUj9hYqQjxjxZKluSXj+ZhwXrlmnyL5trOu5c/kzb9MtvYAk2aC/c34w8eEZl
	 F7I3CbmYzFA/JiXCLOKFm+FhYACus/yZW2Lf6dVgmg95HoR7YLMXazly3d6DUelcm5
	 cZw4C5ZDWEN9f7WLCq1JXzX2PrxD7tvz1EMimDbZaF9KctzvDGW44uoI3ruYx2p4Ax
	 2IrDY8EEKKZCXkFtLv11oz4iOq0X26i6gLihm1FWfJbzngoWHqWgUBY6c4Fdg9BQsC
	 Bvekw/eR6DKKA==
Message-ID: <ced99329-f7ee-444a-86a4-81081ce753a4@kernel.org>
Date: Fri, 5 Dec 2025 10:01:28 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] tools: bpftool: fix truncated netlink dumps
To: Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
References: <20251205011823.751868-1-kuba@kernel.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20251205011823.751868-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/12/2025 01:18, Jakub Kicinski wrote:
> Netlink requires that the recv buffer used during dumps is at least
> min(PAGE_SIZE, 8k) (see the man page). Otherwise the messages will
> get truncated. Make sure bpftool follows this requirement, avoid
> missing information on systems with large pages.
> 
> Fixes: 7084566a236f ("tools/bpftool: Remove libbpf_internal.h usage in bpftool")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: qmo@kernel.org
> CC: ast@kernel.org
> CC: daniel@iogearbox.net
> CC: andrii@kernel.org
> CC: martin.lau@linux.dev
> CC: eddyz87@gmail.com
> CC: song@kernel.org
> CC: yonghong.song@linux.dev
> CC: john.fastabend@gmail.com
> CC: kpsingh@kernel.org
> CC: sdf@fomichev.me
> CC: haoluo@google.com
> CC: jolsa@kernel.org
> CC: bpf@vger.kernel.org
> ---
>  tools/bpf/bpftool/net.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index cfc6f944f7c3..7f248fc01332 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c
> @@ -156,7 +156,7 @@ static int netlink_recv(int sock, __u32 nl_pid, __u32 seq,
>  	bool multipart = true;
>  	struct nlmsgerr *err;
>  	struct nlmsghdr *nh;
> -	char buf[4096];
> +	char buf[8192];
>  	int len, ret;
>  
>  	while (multipart) {
> @@ -201,6 +201,10 @@ static int netlink_recv(int sock, __u32 nl_pid, __u32 seq,
>  					return ret;
>  			}
>  		}
> +
> +		if (len)
> +	                fprintf(stderr, "Invalid message or trailing data in Netlink response: %d\n",
> +				len);


Hi, it's been a while, thanks! :)

Can you please use p_err() rather than fprintf()? I'd also add what the
printed value is, for example:

    p_err("Invalid message or trailing data in Netlink response: %d bytes left", len);

Can you please also check function libbpf_netlink_recv() in
tools/lib/bpf/netlink.c? That's where the one in bpftool comes from and
it seems it has the same issue.

Thanks,
Quentin

