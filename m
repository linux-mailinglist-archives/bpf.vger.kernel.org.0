Return-Path: <bpf+bounces-35617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 281A593BFBA
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 12:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBE6B21F74
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 10:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94633198E6C;
	Thu, 25 Jul 2024 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="WGGHz3VH"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281D7339A0;
	Thu, 25 Jul 2024 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721902152; cv=none; b=pkpMew3oHXuT5YYiCFEdsODF0WoU2j8zckbUAeZVJyDZeoLkEWBlZwqJfY4mvc2OtaboI5ZiJzeTALO/aUxevOCIFtGhdcuFDUFNs4noz3zRb4JXqPUJTvYmC7Nd4bT25rs6XVTxSc84+jfpiD1nq+PPcQ5xK2CHpMLeC/4voNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721902152; c=relaxed/simple;
	bh=dccd50OcfvpBXhYyffFfrcG65sQZ8CMbrc9mal8Ajm8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ieRGTP10LzF8Di76SLFeBzF3osDPNDatAZLvxp3IA0b/6Lt2nti46Hg0zPpmY2qWv2LWeAkC3g/0iYx9l2MaC6OWFl+OkPmYQQese9TzKYvQFZLaTj52n2Xpwi2+OqLPFeEMtcrqxFbLXl5JGbTX7wihyitHneFg1H4YbIKRsew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=WGGHz3VH; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uIqaPgiuxH40adJRSLEvk9/EV1ojn03gZFl+Izd0gEc=; b=WGGHz3VHywBi8qjcCBVfvfWI3i
	b3mTh+X7qvwNc0VP9ypeC9ESkMCGJ8sqGcdhQgS6P0njQUEDOUYN3gKxPWF7BjCPiM9hqsX5XQIk3
	eoXlUCzAz5swvr1JpK8rm6Wux+BxqlhrQ34CtD1d8QhYHQY2YfPXWeMqSiqs7FlEhjcSd6AHIg5Lw
	aUB+1/ViI7BdWskBABp7oJ8ZfcdDKlnbZkMtJ24MtU09YIEbc4XEv6HX9ZWvCj90l6QC8HS5gJE/O
	bGVzELPNrWtH1TSIMqVpx5uwIYpzxKlpcOwIK9gh7ThkqoTUZThS5CBFGSf7+QbmxTNNCGjbe0DI6
	reG4NwEQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sWvPI-000PvU-Bj; Thu, 25 Jul 2024 12:09:08 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sWvPI-0002Ja-1G;
	Thu, 25 Jul 2024 12:09:07 +0200
Subject: Re: [PATCH bpf v5] bpf: Fixed segment issue when downgrade gso_size
To: Fred Li <dracodingfly@gmail.com>, willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <CAF=yD-+Hx9Tg-Fj+7hutPJ7inL_GpgiY4WAXXdhN-tzj5Q1caQ@mail.gmail.com>
 <20240724133712.7263-1-dracodingfly@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bc7f6b4a-0474-99d3-ff38-139712b4e8f4@iogearbox.net>
Date: Thu, 25 Jul 2024 12:09:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240724133712.7263-1-dracodingfly@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27347/Thu Jul 25 10:27:42 2024)

On 7/24/24 3:37 PM, Fred Li wrote:
>>>
>>> Linearize skb when downgrad gso_size to prevent triggering
>>> the BUG_ON during segment skb as described in [1].
>>>
>>> v5 changes:
>>>   - add bpf subject prefix.
>>>   - adjust message to imperative mood.
>>>
>>> v4 changes:
>>>   - add fixed tag.
>>>
>>> v3 changes:
>>>   - linearize skb if having frag_list as Willem de Bruijn suggested [2].
>>>
>>> [1] https://lore.kernel.org/all/20240626065555.35460-2-dracodingfly@gmail.com/
>>> [2] https://lore.kernel.org/all/668d5cf1ec330_1c18c32947@willemb.c.googlers.com.notmuch/
>>>
>>> Fixes: 2be7e212d541 ("bpf: add bpf_skb_adjust_room helper")
>>> Signed-off-by: Fred Li <dracodingfly@gmail.com>
>>
>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>>
>> My comments were informational, for a next patch if any, really. v4
>> was fine. v5 is too.
> 
> Thanks for your advise.
> 
> Fred Li

lgtm, I slightly improved wording & applied, thanks!

