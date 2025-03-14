Return-Path: <bpf+bounces-54053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01ADA614C0
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 16:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974A719C1665
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE96202961;
	Fri, 14 Mar 2025 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="iVkP3H0D"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA51FFC50;
	Fri, 14 Mar 2025 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965766; cv=none; b=mGknvg728mjLYwi7vRdaGGVP7QB/fSsFIwgoOHkhr5WF0PRwAnY6p5VMwqO5fwjMwtzuoTiprwRa0XnKsCDKzIm5kJjcr0nWlJmBoPNT7guq2hM4GO91K9sCvXHsgcfkbAbLS2uonCmg1lNh0k/p4AF+Hdi2G0JNNHMM1ID6Lz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965766; c=relaxed/simple;
	bh=eJSLWEhTvkiMA6Dti2k3l0C/8o83ZXMRPUdaq8/EY+4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uvvMPhihnM2Lp5BiAYT49evQgoKiYmIFIf8V6ZY4dz1wupDKesnyNnphOdp7Pcht9pNPMZ1zCuryiAXhIJs+UdsybHrrL4vpdF8hL3DGyny5KP3Qlmhdk+9+a6X0A+RszON7rFv9XjzdNd0036ZhGjkVX12BoewwYxW7vop2k6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=iVkP3H0D; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tt6rv-006FZg-9Y; Fri, 14 Mar 2025 16:22:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=+TX5auO+Sp/XNcHwkCoFMPh3FVcUqaRUx7KOCoi/TRo=; b=iVkP3H0D6G4zbFZCVJJVkOQBii
	GXcFykn67ktKPIlZy0blBbRT41J7dsVd/aY8RhTPhiO4J7wd6o0kfEKonpQI8+bdPAQHofroWyRZ3
	UXlLkfOFt0e2S61XSu3n2sTcb7cpzz9/TBmzT8RJ0zEwttVhduh9pd64ytwE6ZGq54V+Repysst6k
	BCwPij+RcSfM1zXnMjpA0XcVn0NOt7qyCs7cVz8ci7Epd9dpA6GB/YzO86TvXI08OHptjAJ19aO7m
	AWrnPKXYpbiNDoqX0Rx+HFybtx/xbp924KPePcVNEKNCy3LdMGBLKqbsp8VAenyjw0NxvEov5k7Hb
	cOJgeeOA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tt6rs-0004ce-M7; Fri, 14 Mar 2025 16:22:37 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tt6rd-00FUzy-N8; Fri, 14 Mar 2025 16:22:21 +0100
Message-ID: <90a758f2-e079-4148-8d47-ad2ec9161a13@rbox.co>
Date: Fri, 14 Mar 2025 16:22:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <a96febaf-1d32-47d4-ad18-ce5d689b7bdb@rbox.co>
 <vhda4sdbp725w7mkhha72u2nt3xpgyv2i4dphdr6lw7745qpuu@7c3lrl4tbomv>
 <032764f5-e462-4f42-bfdc-8e31b25ada27@rbox.co>
 <4pvmvfviu6jnljfigf4u7vjrktn3jub2sdw2c524vopgkjj7od@dmrjmx3pzgyq>
Content-Language: pl-PL, en-GB
In-Reply-To: <4pvmvfviu6jnljfigf4u7vjrktn3jub2sdw2c524vopgkjj7od@dmrjmx3pzgyq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 14:49, Luigi Leonardi wrote:
> Hi Michal,
> 
> On Fri, Mar 07, 2025 at 05:01:11PM +0100, Michal Luczaj wrote:
>> On 3/7/25 15:35, Stefano Garzarella wrote:
>>> On Fri, Mar 07, 2025 at 10:58:55AM +0100, Michal Luczaj wrote:
>>>>> Signal delivered during connect() may result in a disconnect of an already
>>>>> TCP_ESTABLISHED socket. Problem is that such established socket might have
>>>>> been placed in a sockmap before the connection was closed. We end up with a
>>>>> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>>>>> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>>>>> contract. As manifested by WARN_ON_ONCE.
>>>>
>>>> Note that Luigi is currently working on a (vsock test suit) test[1] for a
>>>> related bug, which could be neatly adapted to test this bug as well.
>>>> [1]: https://lore.kernel.org/netdev/20250306-test_vsock-v1-0-0320b5accf92@redhat.com/
>>>
>>> Can you work with Luigi to include the changes in that series?
>>
>> I was just going to wait for Luigi to finish his work (no rush, really) and
>> then try to parametrize it.
>>
> 
> Here[1] I pushed the v2 of the series, it addresses Stefano's comments.
> I use b4 to send the patches, so one commit looks "strange". It is used 
> by b4 and it contains the cover letter.
> [1]https://github.com/luigix25/linux/tree/test_vsock_v2
> 
> It would be nice to send both tests together, so whenever your patch is 
> ready, feel free to open me a PR on github or send the series directly 
> in the ML :)

I've noticed you've already sent it to ML and I agree it's better this way.
Perhaps my wording was unclear: by "wait for you to finish" I've meant
"wait for you to get your work merged".

Sorry for confusion,
Michal

