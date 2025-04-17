Return-Path: <bpf+bounces-56124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC07A91A8D
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 13:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0D946237B
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 11:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2BC23BCF8;
	Thu, 17 Apr 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="IP1EghCx"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E8523959A
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888799; cv=none; b=T9g011Jo/sC1iDFb98GODWc3zZfzjZKGMxGLh6j/uWb7LAdYHYz99P0AaCXtOCLPnT44bJHdnOlOxhaDaX3qQ4aH/fgAHGnltctbRIzXIi26Xid/BLxFlIvw9tQ+vUqZzh9EPYzNlsjyBpcEznyiDH39EwG9YISGmdwMGPHn2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888799; c=relaxed/simple;
	bh=EaA/y+zhy5Or9j5JTA2kf0Ms6ZLviEs08ZXslBXBvVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPOuOfqWLe1E1cEJXbNrsYPXUxHhmN3q8m/n6S3u6WNUIPuGMeAkfOiuWG58T/+zSlZeaG6qiLKq7KPpxyUtANI9y40WaRcatL5CnA1vQPcpTS8xrWbwIQD5p70QgRvm+27S3B3Yr8sCHvS7Mllipac2uUw6xXzYPJpmW0RMM+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=IP1EghCx; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 48A7F1C0E76
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 14:19:54 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:to:subject:subject
	:user-agent:mime-version:date:date:message-id; s=dkim; t=
	1744888789; x=1745752790; bh=EaA/y+zhy5Or9j5JTA2kf0Ms6ZLviEs08ZX
	slBXBvVU=; b=IP1EghCxVJNI5E2m5ldGSukylBB3RN/tu4US6WnQjAFDWET3qo4
	QAs5O1VMXXaTUmzo1qJsjh4XrVLJdr4E02h8gV08f74iCtUfCUuwOvSai2h46gCW
	P7WCAXV9t3Q9GhXVwRIRrHtocNKnVWFjr/pSRLvlpbDlyWeEVs/mHPzo=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id et47TbGKQby5 for <bpf@vger.kernel.org>;
	Thu, 17 Apr 2025 14:19:49 +0300 (MSK)
Received: from [172.16.0.185] (unknown [176.59.174.214])
	by mail.nppct.ru (Postfix) with ESMTPSA id 750791C08C3;
	Thu, 17 Apr 2025 14:19:37 +0300 (MSK)
Message-ID: <ff6eed52-5f1f-4070-90dc-8cf057f35e41@nppct.ru>
Date: Thu, 17 Apr 2025 14:19:36 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen-netfront: handle NULL returned by
 xdp_convert_buff_to_frame()
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20250414183403.265943-1-sdl@nppct.ru>
 <20250416175835.687a5872@kernel.org>
 <fa91aad9-f8f3-4b27-81b3-4c963e2e64aa@nppct.ru>
 <0c29a3f9-9e22-4e44-892d-431f06555600@suse.com>
 <452bac2e-2840-4db7-bbf4-c41e94d437a8@nppct.ru>
 <ed8dec2a-f507-49be-a6f3-fb8a91bfef01@suse.com>
 <8264519a-d58a-486e-b3c5-dba400658513@nppct.ru>
 <4679ca25-572b-44aa-bc00-cb9dc1c0080c@suse.com>
Content-Language: en-US
From: Alexey <sdl@nppct.ru>
In-Reply-To: <4679ca25-572b-44aa-bc00-cb9dc1c0080c@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 17.04.2025 13:23, Jürgen Groß wrote:
> On 17.04.25 12:06, Alexey wrote:
>>
>> On 17.04.2025 11:51, Juergen Gross wrote:
>>> On 17.04.25 10:45, Alexey wrote:
>>>>
>>>> On 17.04.2025 10:12, Jürgen Groß wrote:
>>>>> On 17.04.25 09:00, Alexey wrote:
>>>>>>
>>>>>> On 17.04.2025 03:58, Jakub Kicinski wrote:
>>>>>>> On Mon, 14 Apr 2025 18:34:01 +0000 Alexey Nepomnyashih wrote:
>>>>>>>>           get_page(pdata);
>>>>>>> Please notice this get_page() here.
>>>>>>>
>>>>>>>>           xdpf = xdp_convert_buff_to_frame(xdp);
>>>>>>>> +        if (unlikely(!xdpf)) {
>>>>>>>> + trace_xdp_exception(queue->info->netdev, prog, act);
>>>>>>>> +            break;
>>>>>>>> +        }
>>>>>> Do you mean that it would be better to move the get_page(pdata) 
>>>>>> call lower,
>>>>>> after checking for NULL in xdpf, so that the reference count is 
>>>>>> only increased
>>>>>> after a successful conversion?
>>>>>
>>>>> I think the error handling here is generally broken (or at least very
>>>>> questionable).
>>>>>
>>>>> I suspect that in case of at least some errors the get_page() is 
>>>>> leaking
>>>>> even without this new patch.
>>>>>
>>>>> In case I'm wrong a comment reasoning why there is no leak should be
>>>>> added.
>>>>>
>>>>>
>>>>> Juergen
>>>>
>>>> I think pdata is freed in xdp_return_frame_rx_napi() -> __xdp_return()
>>>
>>> Agreed. But what if xennet_xdp_xmit() returns an error < 0?
>>>
>>> In this case xdp_return_frame_rx_napi() won't be called.
>>>
>>>
>>> Juergen
>>
>> Agreed. There is no explicit freed pdata in the calling function
>> xennet_get_responses(). Without this, the page referenced by pdata
>> could be leaked.
>>
>> I suggest:
>
> Could you please merge the two if () blocks, as they share the
> call of xdp_return_frame_rx_napi() now? Something like:
>
> if (unlikely(err <= 0)) {
>     if (err < 0)
>         trace_xdp_exception(queue->info->netdev, prog, act);
>     xdp_return_frame_rx_napi(xdpf);
> }
>
> Juergen
>
> P.S.: please don't use HTML in emails

I can't do this because xennet_xdp_xmit() can return a value > 0



