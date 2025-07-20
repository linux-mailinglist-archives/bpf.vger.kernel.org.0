Return-Path: <bpf+bounces-63859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C92FB0B70B
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 18:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D861895586
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 16:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890A52206A6;
	Sun, 20 Jul 2025 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ofP0STnR"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFEA930
	for <bpf@vger.kernel.org>; Sun, 20 Jul 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753030509; cv=none; b=P0I7FEng6rkFYzqhyrgVg3J0EftDx97vhBR97Zj3pw/WiDHs8zsgvD6Iv0cyuEXf0wr4voGCx0nmFhuJtZSYzBlPJxEVgnZcqnFx5c/i6Hv3g/LPhSSJ2LKrlpkiirmTA0OqyILoEmuczSYLgMMar6Kx8gLvBefViydhb+AH2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753030509; c=relaxed/simple;
	bh=nFhs36PsggzZ2S4l9X3zF8agI99OSEplT6czX5kHmS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iar5HefvxNy5ixDIVCCIVvyRu2XvBsZYcoSrUJegoqvHiXdyqS1vG5CkjaUkMUoUyjc4T8rDE1H0RER07kQExyXMbAlkwUlqvXGJ8mKBX09kcxTsO+V4alkD4FeWyd/oPMqINuB5KVtwzfsHBQC0pGfVPVRdhkXRIlF0p03ILxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ofP0STnR; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4105903a-470c-4808-b0b8-aa32eb36191d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753030504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNDS5QyE6DXcHr+EMDsjwO4EjpUASLLtOxWcFEtzaAE=;
	b=ofP0STnR6yKsGLz69L8WJNemTHWD6p+3iwl/GXebUAqJ5MvnbP2Dt8mpy2iQ780326Gyst
	1niJnluSQ1kHb7xN0GY4dBJGYV9TgJKCqkZOIABCYLijWYyj2d8RHVkxVcHxNGL6wwqcLz
	0HqjIEyyE2tEecS6DWoSUUVwyWlksYg=
Date: Mon, 21 Jul 2025 00:54:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] netfilter: bpf: Disable migrate before bpf_prog
 run
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Florian Westphal <fw@strlen.de>,
 netfilter-devel <netfilter-devel@vger.kernel.org>, coreteam@netfilter.org,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 syzbot+92c5daf9a23f04ccfc99@syzkaller.appspotmail.com
References: <20250718172746.1268813-1-chen.dylane@linux.dev>
 <CAADnVQKMVJ_2SMcm0hvg2GDc-RPVU7GVAWRqbSdGn2ZtwUbUng@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQKMVJ_2SMcm0hvg2GDc-RPVU7GVAWRqbSdGn2ZtwUbUng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/19 02:25, Alexei Starovoitov 写道:
> On Fri, Jul 18, 2025 at 10:30 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>>
>> The cant_migrate() check in __bpf_prog_run requires to disable
>> migrate before running the bpf_prog, it seems that migrate is
>> not disabled in the above execution path.
> 
> bpf@vger mailing list exists, so that developers
> read it and participate in the community.
> 
> https://lore.kernel.org/bpf/20250717185837.1073456-1-kuniyu@google.com/
> 
> --
> pw-bot: cr

well, since it's already under review, I'm happy to drop my version. Thanks.

-- 
Best Regards
Tao Chen

