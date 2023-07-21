Return-Path: <bpf+bounces-5659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A728B75D7EC
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 01:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CA21C2180C
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 23:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1F523BE4;
	Fri, 21 Jul 2023 23:44:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914ADF42;
	Fri, 21 Jul 2023 23:44:02 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5576430DD;
	Fri, 21 Jul 2023 16:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tXQPvQtAOFCki8Nheq98+voSt9DzGq/F75IlnqbdHpU=; b=qIKCz+OaTusHCvVhTZgc8HgWsD
	LrmhWnyN/dXafnCgi2c9CxvPS11QN9C3u+wuvhyRWEdqeyeJHy1AUjudqIgoQ9s4OP3BuI68uFDsw
	ahonlTwSVA0pJCn67o+XZbHNnfZbgkFgqMHsa0wqI3dhuwm0Gzns5U+zSMUFw79FkXrY5bMqYmz2u
	2ilvCld9hLjXYiT9z5GL7J1OXU74QlAfFKSVHpiRMqJL4zKADGNoK8KrFXzCjYSBFOVSci4/hOvMw
	n4a0D3ZKpLYd1l+1drObvjbl/fImqlvmfcbF9p5N2fhwuqyM5TT2lug49iB6LCrKRMNzBQIMo2yzi
	mcn/HRFQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qMzmn-0004rf-VF; Sat, 22 Jul 2023 01:43:49 +0200
Received: from [123.243.13.99] (helo=192-168-1-114.tpgi.com.au)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qMzmn-000U0P-2A; Sat, 22 Jul 2023 01:43:49 +0200
Subject: Re: [PATCH bpf-next v6 2/8] bpf: Add fd-based tcx multi-prog infra
 with link support
To: Petr Machata <petrm@nvidia.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
 kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org,
 davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230719140858.13224-1-daniel@iogearbox.net>
 <20230719140858.13224-3-daniel@iogearbox.net> <87a5vp6vrv.fsf@nvidia.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <aaed850b-0c30-ab8f-09f6-9245f1af4e46@iogearbox.net>
Date: Sat, 22 Jul 2023 01:43:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87a5vp6vrv.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26976/Fri Jul 21 09:28:26 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/21/23 4:57 PM, Petr Machata wrote:
> As of this patch (commit e420bed02507), TC qdisc installation and/or
> removal cause memory access issues in the system.
> 
> A semi-minimal reproducer is:
> 
>      bash-5.2# ip l a name v1 type veth peer name v2
>      bash-5.2# ip l s dev v1 up
>      bash-5.2# ip l s dev v2 up
>      bash-5.2# tc q a dev v1 ingress
>      bash-5.2# tc q d dev v1 ingress
>      bash-5.2# tc q a dev v1 ingress
>      bash-5.2# tc q d dev v1 ingress
> 
> It's a bit finnicky, but only a little. For me, the first two "tc q"
> operations never triggered a splat. Then it could take a few "tc q a"
> "tc q d" iterations to get it to splat. So it looks like maybe the first
> "tc q d" is the problematic bit? And then there's some likelihood of
> failing on any following "tc q" operation. The above in particular
> produced three warning splats for me (attached as decoded.txt,
> decoded2.txt and decoded3.txt). Probing further:
> 
>      bash-5.2# tc q a dev v1 ingress
> 
> Produced two more splats from KASAN (decoded4.txt and decoded5.txt),
> which look more serious.
> 
> Further attempts to prod the system deadlock it, I guess because RTNL
> was left locked.
> 
> Reverting e420bed02507, and fe20ce3a5126 + 55cc3768473e that fail to
> build without it, makes net-next/main work again.

Sorry about that, fix should be here:
https://lore.kernel.org/netdev/20230721233330.5678-1-daniel@iogearbox.net/

Thanks,
Daniel

