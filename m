Return-Path: <bpf+bounces-6490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA4476A530
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 01:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503FB1C20D48
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 23:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9241D1EA92;
	Mon, 31 Jul 2023 23:52:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3B1DDC1
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 23:52:52 +0000 (UTC)
Received: from out-89.mta1.migadu.com (out-89.mta1.migadu.com [95.215.58.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0196B10EB
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 16:52:48 -0700 (PDT)
Message-ID: <8c5398ac-1187-97e3-4124-30a6392e8edb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690847567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fw0m3TLuuN632tVVayNUXrrdys6H1C1Dg1mWpY0EH8U=;
	b=Ig5jGFu/fCYzCvRg7K0/2pAUowLCiwLCuCl70K8WMNz92Lp/eCjQjUMDNfirzH+3WSuapT
	I5YAeWeskif+kjA1r1NMzygvFEvweShaXsK/YJhSBKCOlsoL9ek+7f4TJ0RWgyZXYQHONK
	1D9Oe12dB12juAgsPYUnAy3gmDYVwmg=
Date: Mon, 31 Jul 2023 16:52:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf 1/2] bpf: fix skb_do_redirect return values
Content-Language: en-US
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@cloudflare.com, Jordan Griege <jgriege@cloudflare.com>,
 Markus Elfring <Markus.Elfring@web.de>, Jakub Sitnicki <jakub@cloudflare.com>
References: <cover.1690332693.git.yan@cloudflare.com>
 <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
 <266ab56e-ae83-7ddc-618e-3af228df81bd@linux.dev>
 <CAO3-Pbon7tCdChnK9kZ4992C-AFPvE5gTDWre6dQT9npEMxS2Q@mail.gmail.com>
 <2f285967-6cc0-c492-6a79-edc233c1368e@linux.dev>
 <CAO3-PboZ5eQUbL3UO1HsaQ0s5CyS0ch=ksFVP1R6s8zv0+FTAg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAO3-PboZ5eQUbL3UO1HsaQ0s5CyS0ch=ksFVP1R6s8zv0+FTAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/31/23 4:01 PM, Yan Zhai wrote:
> What I commented was an exact same issue at different location: BPF
> reroute may trigger the crash as well, since it also returns
> dev_queue_xmit status in bpf_xmit. Need to fix this, or instead fixing
> LWTUNNEL_XMIT_CONTINUE value and correct the behavior at lwtunnel_xmit
> rather than bpf_xmit.

Ah. I think I got it. You meant the bpf_lwt_xmit_reroute() / BPF_LWT_REROUTE 
case? It would be clearer if some of these names were quoted instead. "reroute" 
could mean many things.

Please put details comment in v5. Thanks.

> 
> Yan
> 
>>
>>> As Dan suggested, packets might not have been freed when this is
>>> returned from drivers. The caller of dev_queue_xmit might need to free
>>> skb when this happens.
>>>
>>> Yan
>>


