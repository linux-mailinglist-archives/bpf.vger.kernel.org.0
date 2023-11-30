Return-Path: <bpf+bounces-16278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 945907FF328
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 16:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21AE1B21107
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249AD51C43;
	Thu, 30 Nov 2023 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Vq6gKddC"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0A310D5;
	Thu, 30 Nov 2023 07:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DOYtruExIOZ/Nqp4nuzJftAqHrayrWEPpJP1gdM610U=; b=Vq6gKddCOYJxUGbWwZ73S6TXqI
	9uaWnHIp0Tsib321eUDu6sAaSFkA4BN0Bk/gVByOga9jNsUG+raBnCKoArDe/fMbmAdUJgvtXxHBj
	pp14v0p5JA9mXgcuRU/Nzi7gfdmkVKK1wJzReWRsD/lFI35QaJN5LOOszfcb5yUGFH1zDjaRufzgG
	hgUQoTLvRrv4BWYDqNWnXMtd0LPiq2vIvk3SRJdfTGVbHaUAGnD+Zxgcm2hIcXgDqSm8fHFl3/2Xs
	NzF8ch12UE7f0a++U96C0VotE11Z7IH2h6AY0lyCqR6v2G335DU1/5xoUr0a0lO7PJLyiw9zoNyw9
	R2/3hfLg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r8iaV-0000gY-JY; Thu, 30 Nov 2023 16:04:23 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r8iaU-000HcA-Vl; Thu, 30 Nov 2023 16:04:23 +0100
Subject: Re: pull-request: bpf 2023-11-30
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 bpf@vger.kernel.org, john.fastabend@gmail.com, jakub@cloudflare.com
References: <20231129234916.16128-1-daniel@iogearbox.net>
 <CANn89i+0UuXTYzBD1=zaWmvBKNtyriWQifOhQKF3Y7z4BWZhig@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <edef4d8b-8682-c23f-31c4-57546be97299@iogearbox.net>
Date: Thu, 30 Nov 2023 16:04:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89i+0UuXTYzBD1=zaWmvBKNtyriWQifOhQKF3Y7z4BWZhig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27109/Thu Nov 30 09:44:04 2023)

On 11/30/23 3:53 PM, Eric Dumazet wrote:
> On Thu, Nov 30, 2023 at 12:49 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> Hi David, hi Jakub, hi Paolo, hi Eric,
>>
>> The following pull-request contains BPF updates for your *net* tree.
>>
>> We've added 5 non-merge commits during the last 7 day(s) which contain
>> a total of 10 files changed, 66 insertions(+), 15 deletions(-).
>>
>> The main changes are:
>>
>> 1) Fix AF_UNIX splat from use after free in BPF sockmap, from John Fastabend.
> 
> syzbot is not happy with this patch.
> 
> Would the following fix make sense?
> 
> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> index 7ea7c3a0d0d06224f49ad5f073bf772b9528a30a..58e89361059fbf9d5942c6dd268dd80ac4b57098
> 100644
> --- a/net/unix/unix_bpf.c
> +++ b/net/unix/unix_bpf.c
> @@ -168,7 +168,8 @@ int unix_stream_bpf_update_proto(struct sock *sk,
> struct sk_psock *psock, bool r
>          }
> 
>          sk_pair = unix_peer(sk);
> -       sock_hold(sk_pair);
> +       if (sk_pair)
> +               sock_hold(sk_pair);
>          psock->sk_pair = sk_pair;
>          unix_stream_bpf_check_needs_rebuild(psock->sk_proto);
>          sock_replace_proto(sk, &unix_stream_bpf_prot);
> 

Oh well :/ Above looks reasonable to me, thanks, but I'll defer to John & Jakub (both Cc'ed)
for a final look.

Thanks,
Daniel

