Return-Path: <bpf+bounces-57767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C669FAAFCB0
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 16:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA313A4F4C
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E5C26D4C5;
	Thu,  8 May 2025 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqUhs+Qe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688A26B951;
	Thu,  8 May 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713809; cv=none; b=Zug5gkgWTq6BrcoY8iA4H1Sv1w5c3WpgvliQnk1A66wVkijA7N+SBxkSK5nZapxOmE2W+iuJBt4QO7Z2EmAYtWAz64ufI2kxGm+QDR+AnN2I3arQdfSfo41aupwIgP3Lj8ix3MQwgNBpvC5ZScBJ/oGUVh7EcAm44laNBpXHEaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713809; c=relaxed/simple;
	bh=ovep3td4uhMl2JDELfr3J+3Sc94hCbggOo1ww1YQUPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYhcag6qJa7eGpBhdzCU+ZAtI8/RR5uSLhr004qDoMJhXZqOksnJzAHpVu/o8bftE5AZb9/wvvyw99j/xq3ImvZ/9lzLeCXgSQEEvM+5oN7Tb3scb7UWgqKaMtBhfGLZrvnkE6yIn4aEJA38lyMkISZ3h4z6TM6pJTDRaA9gHzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqUhs+Qe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADACC4CEE9;
	Thu,  8 May 2025 14:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746713807;
	bh=ovep3td4uhMl2JDELfr3J+3Sc94hCbggOo1ww1YQUPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QqUhs+QeYSke81JsCvFNOd6KerKW4Ci0i0ZMO3RcF9J/uKr2twNcozLy74wDK2v5Q
	 hPmQPuazbwMB7K/EIyHgcqal6xBeWPyT63XENcuHVDpJOnm5HrlXDwgQrnSVgK2S2Y
	 prBYEQkA/XCF8jAbTUCRyflH+5W5FBueuaRJ6p69kDudY7XNyMQu6iMGHoM1kDU+HV
	 w0DfM+MoJa31qc8/9hWgy7jZahiDU9oxrIide4Zo7/snlCUrqfpNnyVmt2n9wOXY6W
	 0zL34M32DdRyTazEzP9SOwjng49DA4aW2HA4ACYtglUG9A5UOvF8Qzrs64DZhOvnLE
	 lktOcV8EWoVMA==
Message-ID: <962b227f-9673-4050-90b2-334850087487@kernel.org>
Date: Thu, 8 May 2025 16:16:41 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tun: use xdp_get_frame_len()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <20250507161912.3271227-1-jon@nutanix.com>
 <681bc8f326126_20e9e6294b1@willemb.c.googlers.com.notmuch>
 <1DDEC6DE-C54A-4267-8F99-462552B41786@nutanix.com>
 <681cb1d4cb20_2574d529466@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <681cb1d4cb20_2574d529466@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/05/2025 15.29, Willem de Bruijn wrote:
> Jon Kohler wrote:
>>
>>
>>> On May 7, 2025, at 4:56 PM, Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
>>>
>>>
>>> Jon Kohler wrote:
>>>> Use xdp_get_frame_len helper to ensure xdp frame size is calculated
>>>> correctly in both single buffer and multi buffer configurations.
>>>
>>> Not necessarily opposed, but multi buffer is not actually possible
>>> in this code path, right?
>>>
>>> tun_put_user_xdp only copies xdp_frame->data, for one.
>>>
>>> Else this would also be fix, not net-next material.
>>
>> Correct, this is a prep patch for future multi buffer support,
>> I’m not aware of any path that can currently do that thru
>> this code.
>>

This is a good example of a performance paper-cut, from my rant.
Adding xdp_get_frame_len() where it is not needed, adds extra code,
in-form of an if-statement and a potential touching of a colder
cache-line in skb_shared_info area.


>> The reason for pursuing multi-buffer is to allow vhost/net
>> batching to work again for large payloads.
> 
> I was not aware of that context. I'd add a comment to that in the
> commit message, and send it as part of that series.

It need to part of that series, as that batching change should bring a
larger performance benefit that outweighs the paper-cut.

AFAICR there is also some dual packet handling code path for XDP in
vhost_net/tun.  I'm also willing to take the paper-cut, for cleaning
that up.

--Jesper

