Return-Path: <bpf+bounces-68746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EDDB837A8
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 10:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04413B9B55
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 08:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1A42F4A14;
	Thu, 18 Sep 2025 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hFIUlkbm"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43412F3C32
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182887; cv=none; b=B5RLEgjNgkTcfyLilPu/39x6VTgkX/Z2YDvhSrElUwI9WpwgDFOUXfo2JQrXWlDbvnfDZFbfu4JzqhSe/rGW6EkGZETZVjSQ3AgkaDJ4/4AZnFJPlWIw+FIT5hW3bIMMNipoAs2CCu369XYi8sqwt3tDJeqnLI+PWl7O9dHu2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182887; c=relaxed/simple;
	bh=1yC27wxXhKzjbkzZpZR3Ai96oSEiCjx7Z+SO0xTeWt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVYo34dtDEqurr88fJyy9pkvZcM0vQqA0rfTM/lqp9+aB1enMmavsf5irG4bvp5/g8WgmPEB0UpwzqflUK9419+23zV5aonc0Vxik/yMXx7T5iZUfTyPtgTOdPATldW4N2mwW/Kqjy8GiaymVHXxO84tcpLWQv2d08AjWrhLLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hFIUlkbm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1334B1A0E8D;
	Thu, 18 Sep 2025 08:08:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D27D56062C;
	Thu, 18 Sep 2025 08:08:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13040102F1818;
	Thu, 18 Sep 2025 10:07:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758182881; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=NUIQ6q5npgVP/axVpG0xCOPzetUw8W0RvK8A/nQzlw0=;
	b=hFIUlkbmI55oIwEzk9k1G/kcOFNdJO/vkCWLWKCMLFiTXTvDSAFaicR8XxupBDsn/bSqgJ
	foA0BdU1dlIzw2iUVOvM9GQvOuatXUEpWQNNVm0IILlA7dOpMcLPBkJ4RgEEvE6t8k+xH9
	rT2wzVKuFajqOh+Fsb2nmUjogZhljUxwrHfcQbrxW0f/FXFEaovDHgP38HRsmCTnGPzHwr
	fCaljv1gxc9UEMHoAK/KDxR9SDlUee+9nPRbIf88tzAnIaBR0HV8k+RNLvMc5laHI/0fK+
	Wxlmnujl93gKe+jwBuViXKTn/oHsIy0cCnHGb9XEvkCvjytsoqPc3NU1nfOnOA==
Message-ID: <9c96720e-091c-434e-9060-c47ea59ad91e@bootlin.com>
Date: Thu, 18 Sep 2025 10:07:47 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 03/14] selftests/bpf: test_xsk: Fix memory
 leaks
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
 <20250904-xsk-v3-3-ce382e331485@bootlin.com> <aMmlNc1z5ULnOjJY@boxer>
 <6ac21f07-45ef-4e80-bedf-c0470df47bc7@bootlin.com> <aMr+/NDFQsGChdI4@boxer>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <aMr+/NDFQsGChdI4@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/17/25 8:33 PM, Maciej Fijalkowski wrote:
> On Wed, Sep 17, 2025 at 05:32:55PM +0200, Bastien Curutchet wrote:
>> Hi Maciej
>>
>> On 9/16/25 7:58 PM, Maciej Fijalkowski wrote:
>>> On Thu, Sep 04, 2025 at 12:10:18PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
>>>> Some tests introduce memory leaks by not freeing all the pkt_stream
>>>> objects they're creating.
>>>>
>>>> Fix these memory leaks.
>>>
>>> I would appreciate being more explicit here as I've been scratching my
>>> head here.
>>>
>>
>> Indeed it lacks details sorry. IIRC I spotted these with valgrind, maybe I
>> can add valgrind's output to the commit log in next iteration.
>>
>>>   From what I see the problem is with testapp_stats_rx_dropped() as it's the
>>> one case that uses replace and receive half of pkt streams, both of which
>>> overwrite the default pkt stream. So we lose a pointer to one of pkt
>>> streams and leak it eventually.
>>>
>>
>> Exactly, we lose pointers in some cases when xsk->pkt_stream gets replaced
>> by a new stream. testapp_stats_rx_dropped() is the most convoluted of these
>> cases.
> 
> pkt_stream_restore_default() is supposed to delete overwritten pkt_stream
> and set ::pkt_stream to default one, explicit pkt_stream_delete() in bunch
> of tests is redundant IMHO.
> 
> Per my understanding testapp_stats_rx_dropped() and
> testapp_xdp_shared_umem() need fixing. First generate pkt_stream twice and
> second generates pkt_stream on each xsk from xsk_arr, where normally
> xsk_arr[0] gets pkt_streams and xsk_arr[1] have them NULLed.
> 

I took another look at it, and I agree with you: the pkt_stream_delete() 
calls I added in testapp_stats_rx_full() and testapp_stats_fill_empty() 
don't seem necessary.
It still feels a bit strange to overwrite a pointer without freeing it 
right away, but I don't have a strong opinion on this. I'm fine with 
only fixing testapp_stats_rx_dropped() and testapp_xdp_shared_umem() in 
the next iteration.


Best regards,
-- 
Bastien Curutchet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


