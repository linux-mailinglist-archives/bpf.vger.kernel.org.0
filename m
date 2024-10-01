Return-Path: <bpf+bounces-40709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDDD98C642
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 21:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D32D1F24A18
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D811CDA35;
	Tue,  1 Oct 2024 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="CpLVVc/y"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F718754F;
	Tue,  1 Oct 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812185; cv=none; b=l78UVFgBCbzxbACb3huh170J3HcZWX8G1V44YJRqpuQBI0pZBXOJzBXMD2XC2Jy1Brzfaw5puHeoZLOSSH8iPiPoQEx08Is6+tJVphzcr5x/nBd/AUCRMOkeq/pBA7+jjta76RbhIcRSM5dUm1NQZ1J+1g9WOJ1oKU2UPm3BbMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812185; c=relaxed/simple;
	bh=+zymqhK/RPac6FO790pXe9d4YYX6UL26m15YC0V1Kpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unKOYPXrIzCdtLI+edSk9WThdTRp3nepz5vbgQrKXwqqtNmTaAsrbzMav+7wgh7vLMFFHgJdtPfqMkAAIzFlU0SyxEBcHd5wXZ1PnY1mDUHMIbj8tTEE/kFqVv7ZijBKSsMdK0diSEpy25utEMRRiUJLbtwgBnqzV6nCfXoU4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=CpLVVc/y; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=OMs01vLt7QmHAEmxpjTiJRUumvfPo+lAlhZ15bA0spo=; b=CpLVVc/yX53+kGY+fjWM4YgcYB
	IHV5WjkhsAbFlFm3Nh0eBbFY+y6SIWkDS4slEs6Dbee48eNW8IchXScNkV1cf2IOajYqbNy+nJih6
	W83DxmAt7G56UKJt29GjhzDCbxXe/GpjPtN5HdDjvC3Jj3Rw40aXx9pZRsaynhzc4BsCR5NEGvO/5
	p0IxPe7QENanRxk8VuYISClcVYyZdzd30N23jFxewLyHBI6nYf2p7Hw/mrli7Rf00GeTSPPRz/ZCL
	36X8fTPZcBMdcYhwO47cabi/j+Om7QM1e6w5w2fX+5hwQteC0d+IwsaHqRCpRu+4eWTNQHRXDulsj
	YwB4SN9g==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1svisG-0008MT-UR; Tue, 01 Oct 2024 21:49:32 +0200
Received: from [178.197.249.44] (helo=[192.168.1.114])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1svisF-0001T3-1b;
	Tue, 01 Oct 2024 21:49:31 +0200
Message-ID: <4e04ef28-6c82-4624-ba40-c6072f8875a5@iogearbox.net>
Date: Tue, 1 Oct 2024 21:49:30 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Make sure internal and UAPI bpf_redirect
 flags don't overlap
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 Jesper Dangaard Brouer <brouer@redhat.com>
Cc: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240920125625.59465-1-toke@redhat.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20240920125625.59465-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27414/Tue Oct  1 10:44:50 2024)

On 9/20/24 2:56 PM, Toke Høiland-Jørgensen wrote:
> The bpf_redirect_info is shared between the SKB and XDP redirect paths,
> and the two paths use the same numeric flag values in the ri->flags
> field (specifically, BPF_F_BROADCAST == BPF_F_NEXTHOP). This means that
> if skb bpf_redirect_neigh() is used with a non-NULL params argument and,
> subsequently, an XDP redirect is performed using the same
> bpf_redirect_info struct, the XDP path will get confused and end up
> crashing, which syzbot managed to trigger.
>
> With the stack-allocated bpf_redirect_info, the structure is no longer
> shared between the SKB and XDP paths, so the crash doesn't happen
> anymore. However, different code paths using identically-numbered flag
> values in the same struct field still seems like a bit of a mess, so
> this patch cleans that up by moving the flag definitions together and
> redefining the three flags in BPF_F_REDIRECT_INTERNAL to not overlap
> with the flags used for XDP. It also adds a BUILD_BUG_ON() check to make
> sure the overlap is not re-introduced by mistake.
>
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
> Reported-by: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>   include/uapi/linux/bpf.h | 14 ++++++--------
>   net/core/filter.c        |  8 +++++---
>   2 files changed, 11 insertions(+), 11 deletions(-)
Lgtm, applied, thanks! I also added a tools header sync.I took this into 
bpf tree, so that stable can pick it up.
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c3a5728db115..0c6154272ab3 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6047,11 +6047,6 @@ enum {
>   	BPF_F_MARK_ENFORCE		= (1ULL << 6),
>   };
>   
> -/* BPF_FUNC_clone_redirect and BPF_FUNC_redirect flags. */
> -enum {
> -	BPF_F_INGRESS			= (1ULL << 0),
> -};
> -
>   /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
>   enum {
>   	BPF_F_TUNINFO_IPV6		= (1ULL << 0),
> @@ -6198,11 +6193,14 @@ enum {
>   	BPF_F_BPRM_SECUREEXEC	= (1ULL << 0),
>   };
>   
> -/* Flags for bpf_redirect_map helper */
> +/* Flags for bpf_redirect and bpf_redirect_map helpers */
>   enum {
> -	BPF_F_BROADCAST		= (1ULL << 3),
> -	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4),
> +	BPF_F_INGRESS		= (1ULL << 0), /* used for skb path */
> +	BPF_F_BROADCAST		= (1ULL << 3), /* used for XDP path */
> +	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4), /* used for XDP path */
>   };
> +#define BPF_F_REDIRECT_ALL_FLAGS (BPF_F_INGRESS | BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS)
> +
>   
Also fixed up extra newline.

Thanks,
Daniel

