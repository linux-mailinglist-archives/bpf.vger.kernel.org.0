Return-Path: <bpf+bounces-11537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19877BB91C
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 15:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0DE1C20A0C
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 13:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4276222EF9;
	Fri,  6 Oct 2023 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1fNHY5L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF241F614;
	Fri,  6 Oct 2023 13:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C94C433C9;
	Fri,  6 Oct 2023 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696599155;
	bh=IeMRVtfQmH5C4V8rZgSrWdBPRGrRwHeORgCnMcY0L5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e1fNHY5LdtjNlNbHGVbYkN08L2796yA8ybzLyROpBKeC4FQMS5oIuVANb6H6upMJx
	 4t56p7Yx40ehBhPE8651WQO/oCPa7ODutSfWBTGbHIaPRPTeGSa46GWgA6XdJP9KjR
	 nWbBI6jTy34jQXWgkduNj7DhS5BrxeDUM/pwR6TMrgZTFSSYSoFY4EFr36TniTChB5
	 P3pkBHmFI0hncurjxUD716bGGV2B+0eKUSQKy6Q515cDU23zvHDbCesDNLEY4Qx3r3
	 rG969PZyHRutN5DagHF8LFeRR7o84ltA1GjMqT6bialCh974QmT46X+lXyhuGyinKD
	 5TKhW2raZ/QUQ==
Date: Fri, 6 Oct 2023 06:32:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira
 <victor@mojatatu.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 paulb@nvidia.com, netdev@vger.kernel.org, kernel@mojatatu.com,
 martin.lau@linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/1] net/sched: Disambiguate verdict from
 return code
Message-ID: <20231006063233.74345d36@kernel.org>
In-Reply-To: <2ce3a5a1-375d-43a6-052d-d44d7b4a4bf8@iogearbox.net>
References: <20230919145951.352548-1-victor@mojatatu.com>
	<beb5e6f3-e2a1-637d-e06d-247b36474e95@iogearbox.net>
	<CAM0EoMncgehpwCOxaUUKhOP7V0DyJtbDP9Q5aUkMG2h5dmfQJA@mail.gmail.com>
	<97f318a1-072d-80c2-7de7-6d0d71ca0b10@iogearbox.net>
	<CAM0EoMnPVxYA=7jn6AU7D3cJJbY5eeMLOxCrj4UJcFr=pCZ+Aw@mail.gmail.com>
	<1df2e804-5d58-026c-5daa-413a3605c129@iogearbox.net>
	<CAM0EoM=SH8i_-veiyUtT6Wd4V7DxNm-tF9sP2BURqN5B2yRRVQ@mail.gmail.com>
	<cb4db95b-89ff-02ef-f36f-7a8b0edc5863@iogearbox.net>
	<CAM0EoMkYCaxHT22-b8N6u7A=2SUydNp9vDcio29rPrHibTVH5Q@mail.gmail.com>
	<96532f62-6927-326c-8470-daa1c4ab9699@iogearbox.net>
	<CAM0EoMkUFcw7k0vX3oH8SHDoXW=DD-h2MkUE-3_MssXvP_uJbA@mail.gmail.com>
	<2ce3a5a1-375d-43a6-052d-d44d7b4a4bf8@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Oct 2023 13:18:40 +0200 Daniel Borkmann wrote:
> That should be possible with some work this way, agree. I've been toying a bit
> more on this issue, and actually there is an even better way which would cleanly
> solve all use cases and we likely would utilize it for bpf as well in future.
> I wasn't aware of it before, but the drop reason actually has per-subsystem infra
> already which so far only mac80211 and ovs makes use of.

FWIW I'm not sure if leaning into the subsys specific error codes for
something as core as TC is a good direction. I'd think that what
matters to the user is was it an intentional policy drop or some form
of an error / exception. More detailed info can come from stats.

Maybe I'm overly conservative because I don't care about debugging
mac80211 or ovs but do very much care about TC :) And I think Alastair 
(bpftrace) is working on auto-prettifying enums when bpftrace outputs
maps. So we can do something like:

$ bpftrace -e 'tracepoint:skb:kfree_skb { @[args->reason] = count(); }'
Attaching 1 probe...
^C

@[SKB_DROP_REASON_TC_INGRESS]: 2
@[SKB_CONSUMED]: 34

  ^^^^^^^^^^^^ names!!

Auto-magically.

Which will no longer work with the "pack multiple values into 
the reason" scheme of subsys-specific values :(

What I'm saying is that there is a trade-off here between providing 
as much info as possible vs basic user getting intelligible data..

