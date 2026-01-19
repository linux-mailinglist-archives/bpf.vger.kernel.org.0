Return-Path: <bpf+bounces-79462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6C1D3ABE4
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 15:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 460D3303542F
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5423237F8D9;
	Mon, 19 Jan 2026 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="k4Gl94kR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5015637BE81
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832611; cv=none; b=ImFyZoGujMb8ubgDXl08HpxpyI2AQX3zkQFbkrewQhwf96lERKm5t+VCwlE+zJGAZPGN6lofQcEp7ZkShDZdsii7cyfKrDI0szkRtgwzMoSJxd+bjW0fKR5QKvo9yEKMlq0x+YV+yKgwnZ3eg+9BoU6Kfd/cDMLX6SP/TSafAqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832611; c=relaxed/simple;
	bh=moC0t1S/fBLZmSoywp+QnSHu36Mi1Uh80eIvskYMvto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGNaqBrWY8IowlxVTI+FkL6/0uR2J9snQABW5nGIcPWMCcylVVf1fStZbDRImzicVq7px2t2Eocw0OVNdC6vkeMnbVClhZ+Cd9oGywhWNjxs3JjnxgzQ47QeXvmDvU/NovjQ1Iv3fkWq9imLMgtcOynkcQLxWO9xFVYEvOanz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=k4Gl94kR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so2215028f8f.3
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 06:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832608; x=1769437408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sm7Zp/rHDSp3gapjmf+B9iq6Y1vMVLjliOXFPyuyGcY=;
        b=k4Gl94kRmRFAjnu9qzGPGxioN9iX1KjMSTSGTxv+xzgwkti84epNI6VUvsRlyo4s/W
         UIahS/jObs56tsSvAtLPgaLcpDOsUe6f7lO7NSz1EigJi5UruQHYUH3y8bH3tVbyVxEL
         KoJxKn5PFvQ8HgfP/ecwaGFPW6KjxV3EQnEQxGyQKPfHBUGKkOjMplISP7wJfqyn0FIq
         GPxap8PWQporrKOM6Pcuei5lBajtoMq+3wt0UcVkRZ0yaNSyMUI9XOvDaO5hIxxQiw//
         gPQY7saviibDui68trFbEn26g4HNUytH0+M1Mml2XG6BWo6W/NswXg0UOp2l06Ms9q1q
         BQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832608; x=1769437408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sm7Zp/rHDSp3gapjmf+B9iq6Y1vMVLjliOXFPyuyGcY=;
        b=hsrS/XNP03PLV0Nwx0qMKZ+C36sndW3xYQjFn+B9ErW8SY9sj/T+x6suxVsRxLOOD7
         rfwxe9rSwx7Do6sSvORZoypsvO6lkFSWJNO9P4oKNgYhOsmK6X89Az22aiQR4al53L9M
         1/6r9d1LZfVvzq17T9VGEfeUPCbNXpT262hqMI5lvBrPQvPs/DFVtcN0rh4a4wq4X3AS
         w1wvStvOX9au0ayKEsdSyvjR7nlP5JFf8jPi2evesPetlBXs6bI0I8qj386bG9y2ObTx
         971wNppDiiT7wSTNHhkkBJ5it2Vw+oDmLkee3Ql7xVQx/kMYmMvq/Hcxbb5SU8Wb2Iug
         f8sw==
X-Gm-Message-State: AOJu0Yzf9IVBjk1GcqQQx7pnK2fgxsJZsgmgvIRWRNWY/KJhEHs8FLLZ
	yEO4+9mZVh4KBYQKQ8xsBQB02nSMtx0JTKKvPzC9/opvE26M4ZEfZZZutlIJUbmzflI=
X-Gm-Gg: AZuq6aIzqUXt5phN5h2zVAE6RaRCFlvV11CalW2bCT5dgHOi4rKCAIz8yWrZZqSz8PM
	6fahyg9gln5xdv77iikoGQ0aJ2+f17jJFdNMAIXLn1ds+za2H99SUBc9NRwaFX47kA2wOxxwMnL
	k4ChSVOHd3JNtNsqMPhvF0483qbtveQFrEykOejT4ho0ZS0zkptV6xATPk79Hm/02wVIQKY7AVz
	mmC0lgKUNKKzXQooD5fGmjEVnUHtp9anlNeZxh27F+ldP64wfLN6kpbTfrSV0f7CPs8EITVh2JA
	uugmG+loXFIApBjs07o9XNW4wuOl0O4I9T2FMoK/VxK4fbnwi2f25iBTZetkR96QKZixiiMzPAK
	DC6SGdGitNx0+kC759sqj5dVRiM4DxVjRzGbYDJ5dwu22YsfvpBV2LYglNP0zL7Q1E2OTH7443i
	EPJhhETit1DloqeUwpe4hNWnpO+92T3RO1RJhn0fgWSnI0TFmBTHv4z2uYJDiaU2OYBduSMw==
X-Received: by 2002:a5d:5887:0:b0:432:58f5:fb36 with SMTP id ffacd0b85a97d-43569bc7ce4mr14787035f8f.47.1768832608491;
        Mon, 19 Jan 2026 06:23:28 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6dasm23782579f8f.32.2026.01.19.06.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:23:27 -0800 (PST)
Message-ID: <d512fc03-5c16-4af2-9353-4e97c7982171@blackwall.org>
Date: Mon, 19 Jan 2026 16:23:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 14/16] selftests/net: Add env for container
 based tests
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-15-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-15-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:26, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add an env NetDrvContEnv for container based selftests. This automates
> the setup of a netns, netkit pair with one inside the netns, and a BPF
> program that forwards skbs from the NETIF host inside the container.
> 
> Currently only netkit is used, but other virtual netdevs e.g. veth can
> be used too.
> 
> Expect netkit container datapath selftests to have a publicly routable
> IP prefix to assign to netkit in a container, such that packets will
> land on eth0. The BPF skb forward program will then forward such packets
> from the host netns to the container netns.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   .../testing/selftests/drivers/net/README.rst  |   7 ++
>   .../drivers/net/hw/lib/py/__init__.py         |   7 +-
>   .../selftests/drivers/net/lib/py/__init__.py  |   7 +-
>   .../selftests/drivers/net/lib/py/env.py       | 112 ++++++++++++++++++
>   4 files changed, 127 insertions(+), 6 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


