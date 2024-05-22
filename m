Return-Path: <bpf+bounces-30270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41448CBCC7
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 10:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46999B21BC3
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 08:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FB97F482;
	Wed, 22 May 2024 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ae3AipL7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A5524D7
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365877; cv=none; b=pslSXHT+S3htGFNasm3SQOOuiefSulYrY4bYHuqyWwfopsJdZRpOc/a/vVDPZ15S7Jbqp5rVhfWJFp5dfxEkIAnM1l1BuJH8x9FY2bSNFtWl2boBUe/mAAPm6MqXaFALHRD8ndEXnSB0OKyWUO+nar4Kvea/3tYXNIjli90k04g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365877; c=relaxed/simple;
	bh=KRBeh0DdzrLvU7l5ny5ENlQMSYfiQWMjqFDiggLGPn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HOehQqsSyUJzjnZxSVKW6qAqMTjsTJo+5TlHNcIBLKG5csTbY9GsIsc+K32G3eB9dEkwn6nErYqHsGpBSRQjZpyIxeIM6823AefItdqXdSKGdPKah1R2+F77yu+3mYQjxjL3YJxx2D54PgpsiJq2RGhMZcogt7Pqmq4hBiamfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ae3AipL7; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a352bbd9so108470966b.1
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716365873; x=1716970673; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMZX+gUjvefttmyDfynhRPtuaQ62yDGI7HlZysTaOMc=;
        b=Ae3AipL7vM4KWmKtyt07bPyr7/Zfq9ZshsEvoeJLdaXYRVYGzJ9NxTrD5aSGaApbIy
         fuMPVdz65r+LED5HW/CmANhnqTMXHJIgt3hWNVjnqgm/sODMcRLybiX3Iv59lr5Ze26m
         FLAwCSZaZyeMahwB61RX/OiGLbHyXUW/mwUxuQQ2hinITDIvRA7N4skMrl004LXyOs5P
         8HdeJ74VTKGStpIclTGkETdld5PiUw35uelhnTh4GwnPr4sL2BEYp+HIWn79Qju5aBkE
         sw5JM6EhYUryCalqVBCrAMQFTKejyeTkqc7BYT5FEEEqj8B29MSl51KDZbDlItwy5HQ0
         Gp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716365873; x=1716970673;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMZX+gUjvefttmyDfynhRPtuaQ62yDGI7HlZysTaOMc=;
        b=QVHzqSCLd2jAzXf7LSCmbqNOtwF/d7jBfuoCtgBjOpUIfEOtUIF9iDIJeWFqaLwj29
         luaQGjlNwGYh2LD/zZH97TLglp7wwslJHaI6HD2Fdr3nqZ8ZtSYGb+J4nZgplxVxtFVP
         k5pjnqwJE1Bg4STFEJ0SHgQP4JbxT28p9sXBuLwUyYmOZH6esc8Yqc+O+aHTmqqRh3ns
         FWaOIyeuK1EESScEnmudVUm+/Kroas/IXiJUv0+kAKKSnxl6qn5OzBJtZzTScTWHE4e2
         v5c6pW253qK84X4EZ7ypxjRgCcxhGSwP1Wx5jW1BAABq8tGZA4iFzmcVcggFfLI9esIs
         ikJw==
X-Forwarded-Encrypted: i=1; AJvYcCXHD9PMA7HDpr2rWBcXw1X6VJOYxDno+9yOX6R5MQqbUPn8zjSczruAv/E3pJb9JGzIfQ5qQ7kC2OklLRV6PVOsnX9w
X-Gm-Message-State: AOJu0Ywio9yTH342s/anQIoDW+ngwCDAnXITBy7lDul8Hb7AVzmS2r++
	/1uvayb5em2/szSuSVp0ObH/gkGxD6yaG/c5MjsIA5B/7FavBnkD/s2X7hlqy2A=
X-Google-Smtp-Source: AGHT+IEDc5zZ/BMuk/6O/B8g9U1NqatChVZfiw6B2VP0OFFSX7TPukAxT+LyMOUNoDWUaW+9sE0kAw==
X-Received: by 2002:a17:906:497:b0:a5c:d4b2:6a44 with SMTP id a640c23a62f3a-a5d59db36acmr1077008366b.16.1716365873228;
        Wed, 22 May 2024 01:17:53 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm1729610566b.111.2024.05.22.01.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:17:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Geliang Tang <geliang@kernel.org>,  andrii@kernel.org,
  eddyz87@gmail.com,  mykolal@fb.com,  ast@kernel.org,
  daniel@iogearbox.net,  martin.lau@linux.dev,  song@kernel.org,
  yonghong.song@linux.dev,  john.fastabend@gmail.com,  kpsingh@kernel.org,
  sdf@google.com,  haoluo@google.com,  jolsa@kernel.org,  shuah@kernel.org,
  tanggeliang@kylinos.cn,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix prog numbers in test_sockmap
In-Reply-To: <171631563033.25358.8200564796951629702.git-patchwork-notify@kernel.org>
	(patchwork-bot's message of "Tue, 21 May 2024 18:20:30 +0000")
References: <9c10d9f974f07fcb354a43a8eca67acb2fafc587.1715926605.git.tanggeliang@kylinos.cn>
	<171631563033.25358.8200564796951629702.git-patchwork-notify@kernel.org>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Wed, 22 May 2024 10:17:51 +0200
Message-ID: <87bk4yxntc.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 21, 2024 at 06:20 PM GMT, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
>
> This patch was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:
>
> On Fri, 17 May 2024 14:21:46 +0800 you wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>> 
>> bpf_prog5 and bpf_prog7 are removed from progs/test_sockmap_kern.h in
>> commit d79a32129b21 ("bpf: Selftests, remove prints from sockmap tests"),
>> now there are only 9 progs in it, not 11:
>> 
>> 	SEC("sk_skb1")
>> 	int bpf_prog1(struct __sk_buff *skb)
>> 	SEC("sk_skb2")
>> 	int bpf_prog2(struct __sk_buff *skb)
>> 	SEC("sk_skb3")
>> 	int bpf_prog3(struct __sk_buff *skb)
>> 	SEC("sockops")
>> 	int bpf_sockmap(struct bpf_sock_ops *skops)
>> 	SEC("sk_msg1")
>> 	int bpf_prog4(struct sk_msg_md *msg)
>> 	SEC("sk_msg2")
>> 	int bpf_prog6(struct sk_msg_md *msg)
>> 	SEC("sk_msg3")
>> 	int bpf_prog8(struct sk_msg_md *msg)
>> 	SEC("sk_msg4")
>> 	int bpf_prog9(struct sk_msg_md *msg)
>> 	SEC("sk_msg5")
>> 	int bpf_prog10(struct sk_msg_md *msg)
>> 
>> [...]
>
> Here is the summary with links:
>   - [bpf-next] selftests/bpf: Fix prog numbers in test_sockmap
>     https://git.kernel.org/bpf/bpf-next/c/6c8d7598dfed
>
> You are awesome, thank you!

We don't need prog_types and attach_types at all.
I was too late too comment so here's a patch to address that:

https://lore.kernel.org/bpf/20240522080936.2475833-1-jakub@cloudflare.com/

