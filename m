Return-Path: <bpf+bounces-75577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0945CC89783
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 12:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4375F354D51
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3A231ED81;
	Wed, 26 Nov 2025 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzyG8aWe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9C2DF154;
	Wed, 26 Nov 2025 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155711; cv=none; b=KdCrn6Y3XjCAK45EM1/Gqm3Hwtw68POGd8pkKnPJPqtmCkepKQxAD+1skeQdhV569nRinX6nPnAKMdDB8P0qf2PdRqjRCbiUD2kewIMbvRosKYUaCltMZvprwUvSPZS8FVCF6FRP2gW20M59ilUrwcoiwdmVQomAEy+8bLgHf6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155711; c=relaxed/simple;
	bh=uneOr7UWZf997xNbwcbBJk5N8EI2Gi/4Wedz6v7jNMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLDZ3/zqyxStfNpSznO9Pg/0YOZKR5soNLuHUK55hZJa8A4ukqZZK3lLbiJq9GPqNyukYOU1BZvPjk2U/3L2VD13bOiAsiD+bj7tGRhdlLn4sw0aZ+0hgtC6/l7tsU/2Pv5Aig/I49avhM+KzE7YptvGO4okf+T2N+Ql0VY3rnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzyG8aWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526CBC113D0;
	Wed, 26 Nov 2025 11:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764155710;
	bh=uneOr7UWZf997xNbwcbBJk5N8EI2Gi/4Wedz6v7jNMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DzyG8aWeOR42SDlaOgizksjhLiulP0dpuaaJwm901Gkbm8lIHHWLhcC/htPxtOSzb
	 u+Exvfor8+3cddjribvlqtDV55x4LbkgV2IF6xtVsfRC7iK1e07WBDgNNka/mTOjTX
	 x77e0nqaUSg7S3YYpoTFBDnmio6GV8nVewwDI8HCCPD1MJchdFDh7Mg7PBFFQ5K5gL
	 V6mq/P9Jf8QZihLAbJpD5eyqChjYj0VmGqI6f52s/HuKk3kEf9cUcUduw+NCcFMqai
	 BtG2sRyEJgw+RL9i5sbgykepmRwb/gQY1Q1ervb7LtEdcpxQjPQ3cFWqYYNa8e0zDZ
	 RRmjv680yxJxQ==
Message-ID: <0be119c2-4b5f-4aa6-bb20-b3e8a8b4cf82@kernel.org>
Date: Wed, 26 Nov 2025 12:15:05 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] net: fix propagation of EPERM from tcp_connect()
Content-Language: en-GB, fr-BE
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Lorenzo Colitti <lorenzo@google.com>, Neal Cardwell <ncardwell@google.com>,
 bpf@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>,
 Jakub Kicinski <kuba@kernel.org>
References: <20251121015933.3618528-1-maze@google.com>
 <CANP3RGeK_NE+U9R59QynCr94B7543VLJnF_Sp3eecKCMCC3XRw@mail.gmail.com>
 <20251121064333.3668e50e@kernel.org>
 <CAHo-OoxLYpbXMZFY+b7Wb8Dh1MNQXb2WEPNnV_+d_MOisipy=A@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAHo-OoxLYpbXMZFY+b7Wb8Dh1MNQXb2WEPNnV_+d_MOisipy=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Maciej,

(+cc MPTCP list)

On 26/11/2025 02:08, Maciej Żenczykowski wrote:
>> FWIW this breaks the mptcp_join.sh test, too:
> 
> What do you mean by 'too', does it break something else as well, or
> just the quoted mptcp_join?
> 
>> https://netdev-3.bots.linux.dev/vmksft-mptcp/results/394900/1-mptcp-join-sh/stdout
> 
> My still very preliminary investigation is that this is actually
> correct (though obviously the tests need to be adjusted).
> 
> See tools/testing/selftests/net/mptcp/mptcp_join.sh:89
> 
> # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
> #                                (ip6 && (ip6[74] & 0xf0) == 0x30)'"
> CBPF_MPTCP_SUBOPTION_ADD_ADDR=...
> 
> mptcp_join.sh:365
>       if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
>                       -m tcp --tcp-option 30 \
>                       -m bpf --bytecode \
>                       "$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
>                       -j DROP
> 
> So basically this is using iptables -j DROP which presumably
> propagates to EPERM and thus results in a faster local failure...

I don't think that's what caused the issue: according to the logs, two
tests have failed: "delete and re-add" and "flush re-add" and they don't
use the mentioned snippet. Still it might be caused by a Netfilter rule,
because they both call:

  reset_with_tcp_filter "..." ns2 10.0.3.2 REJECT OUTPUT

This helper will call:

  iptables -A OUTPUT -s 10.0.3.2 -j REJECT

Note that you can easily reproduce the issue by only launching the
problematic tests with './mptcp_join.sh "<test name or id>"', e.g.

  cd tools/testing/selftests/net/mptcp
  ./mptcp_join.sh "delete and re-add"

> Although this is probably trying to replicate packet loss rather than
> a local error...
> 
> So I'm not sure if I should:
> (a) fix the asserts with new values (presumably easiest by far),
> or
> (b) change how it does DROP to make it more like network packet loss
> (maybe an extra namespace, so the drop is in a diff netns, during
> forwarding??? not even sure if that would help though, or maybe add
> drop on other netns INPUT instead of OUTPUT).
> or
> (c) introduce some iptables -j DROP_CN type return... (seems like that
> might be worthwhile anyway)

From what I understand, with your RFC patch, a "connect()" (or
"kernel_connect()") will get an error because of the Netfilter rule. If
that's normal, then probably the expected results can be adapted, e.g.
from ...

  join_syn_tx=3 join_connect_err=1 \
          chk_join_nr 2 2 2

... to ...

  join_connect_err=2 \
          chk_join_nr 2 2 2

At least that would show the effect of your patch.

An important note: the selftests can be executed on older kernels: if
your patch is changing the behaviour, and it is a fix that is going to
be backported to stable, that's fine. If that's not a fix, the selftests
should continue to work with and without the kernel patch. Then, the
Netfilter rule should probably be adapted instead, maybe by moving it to
the other side (ns1) in INPUT if that still makes the tests valid.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


