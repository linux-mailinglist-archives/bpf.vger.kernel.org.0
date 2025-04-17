Return-Path: <bpf+bounces-56113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FFDA916D6
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 10:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D3D5A2C9E
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 08:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07049226527;
	Thu, 17 Apr 2025 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="nQQ7DQ7I"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44CF221F3B
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744879544; cv=none; b=Q0sJQt+K/3y2bf9nYP72V/wE+fLJj3+912q4pMhNTbWeVQragtY4R+WImex1u/UFnxBfqwQPObWZhWGcDXDMVmpydvkcyUo2ekQtOFFPMlwXohITSE1MoZXGqHCjoWwzIX4uy2CkkiugppLTMNALh6fLhxiWiBfJIiRTO9/Omyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744879544; c=relaxed/simple;
	bh=prARSaBN7jc/9aHhT9ze72f0f9WsaYTgJSuYmcV/gUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2e5zd9pPkU9CAlt6/EtojvEvqjsfaY9AwB3HHspVxRBxbqOVgyT9z10HjBbS5CvSciBFYN02kJSDcQ9cl7mgVe0dbkOAksJMIgy9NCbykegKxE768ftoOQrE6uD6qos6824MiMw6f0BVl2dJq+YbJPuL1VJOqjQjY6Wj3AjJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=nQQ7DQ7I; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id B93241C0E76
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 11:45:35 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:to:subject:subject
	:user-agent:mime-version:date:date:message-id; s=dkim; t=
	1744879535; x=1745743536; bh=prARSaBN7jc/9aHhT9ze72f0f9WsaYTgJSu
	YmcV/gUI=; b=nQQ7DQ7IkrN+vka9I2soOFPAOnDCb98nLdE3OeH/wTvW/wqfZlI
	8tYJYSB9a8r6jo8GIUh7bf9tEqHQIQhmQcN81y+R5GoozLCW3G4TLYYoPjKB7+An
	fTjEhh6mSmY+zmkuMgFq+ai/PfFriu5m789RXGkJJ82fhhpFn/qKObSc=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JFKRnW5UXAq2 for <bpf@vger.kernel.org>;
	Thu, 17 Apr 2025 11:45:35 +0300 (MSK)
Received: from [172.16.0.185] (unknown [176.59.174.214])
	by mail.nppct.ru (Postfix) with ESMTPSA id 426801C08C3;
	Thu, 17 Apr 2025 11:45:30 +0300 (MSK)
Message-ID: <452bac2e-2840-4db7-bbf4-c41e94d437a8@nppct.ru>
Date: Thu, 17 Apr 2025 11:45:30 +0300
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
Content-Language: en-US
From: Alexey <sdl@nppct.ru>
In-Reply-To: <0c29a3f9-9e22-4e44-892d-431f06555600@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 17.04.2025 10:12, Jürgen Groß wrote:
> On 17.04.25 09:00, Alexey wrote:
>>
>> On 17.04.2025 03:58, Jakub Kicinski wrote:
>>> On Mon, 14 Apr 2025 18:34:01 +0000 Alexey Nepomnyashih wrote:
>>>>           get_page(pdata);
>>> Please notice this get_page() here.
>>>
>>>>           xdpf = xdp_convert_buff_to_frame(xdp);
>>>> +        if (unlikely(!xdpf)) {
>>>> +            trace_xdp_exception(queue->info->netdev, prog, act);
>>>> +            break;
>>>> +        }
>> Do you mean that it would be better to move the get_page(pdata) call 
>> lower,
>> after checking for NULL in xdpf, so that the reference count is only 
>> increased
>> after a successful conversion?
>
> I think the error handling here is generally broken (or at least very
> questionable).
>
> I suspect that in case of at least some errors the get_page() is leaking
> even without this new patch.
>
> In case I'm wrong a comment reasoning why there is no leak should be
> added.
>
>
> Juergen

I think pdata is freed in xdp_return_frame_rx_napi() -> __xdp_return()


