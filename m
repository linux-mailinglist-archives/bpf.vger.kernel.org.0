Return-Path: <bpf+bounces-48390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78F6A07802
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 14:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AE6169E34
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 13:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA63D21C17B;
	Thu,  9 Jan 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuW+lAK/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15621B1AA
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430184; cv=none; b=q6hmvA+l+Dt0i0NpdfrjP+G5k2eQTRpGvwLR0g6Kxy5dqVGXvnZpHstEqem6hc5DZkPpxq2NTpRbuuSt7OD5XdcAw0zogebY7wmQGXC6SP1MHpYthirfm94Xd+FIv8OTQ7G1x+NExivaSWEwgO3VVHyYPuvzRODuUlyxDiqH9MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430184; c=relaxed/simple;
	bh=8dqpi+3F9iCh0CcG9gTM7Zeb5SSODkpsvXGULp+sSA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JP5SE/B1QaHuvthYDn1mIn1tjZtNQw7i4WF/orY4tR8Axw8qncJIgGSX6A3OlvpE8cmqne058lQTUj5K2loKbiMgOVPz8tA6c4n9hxvfnwTHbSiXr5RtikUa9BaY/u52MywzoH1NafxuBShfdVZsyHoU3M98FN8od4I/IuF6cpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cuW+lAK/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736430182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kkO1Khp0HMapbaFR2ikf7uwESckJYrFFK8Z3Z9FYmUA=;
	b=cuW+lAK/AMJP2nc8FNsU4Ah4juGDuDROBHQj9TomWnWwxV//e1yBdBW5aX16qHuIUpfLuV
	X/1IGBzPcVzX2/YCDDHXTgC1xWc+U2m/zmRbxr4wSecjXzkAuOfcuWhHu97u3bYaFIIgjR
	f+JT4+EeC742g7+hbgFCMvQqqH4ID2M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-vfc0tZW3PByXbCm_MSu_3g-1; Thu, 09 Jan 2025 08:42:58 -0500
X-MC-Unique: vfc0tZW3PByXbCm_MSu_3g-1
X-Mimecast-MFC-AGG-ID: vfc0tZW3PByXbCm_MSu_3g
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436248d1240so4831115e9.0
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 05:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736430178; x=1737034978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkO1Khp0HMapbaFR2ikf7uwESckJYrFFK8Z3Z9FYmUA=;
        b=Igp8ZJVAlNLvfcv8nsP7r18pxwGcbphNYmvS3JOgp5faQ8KE3GfNe3ogaRyVGO0dXc
         o9S5LVbtAEXZUlAuFxR2LBevcqYqgK+FY8wms0Za7fd24vyOrS5sOq096NNTwS71ALSU
         9cZfGgI9PpPisR+s1rjMo+MmBbIGqwWAJdn8+b9ASUmte0/zN3Poxpyngv5y5N6alRUO
         qKX+eQmq5wtNkRCVYprFGie2ilFIhcO76oq4olTwGaqdq4WArS3qXZ6BIAJCjk0a3a/5
         I0dW0sOVG9Ql/pFQ/bpgM/dwJCQAIid80q0YholQnUeG4xR1NJ8UWemCS4XwvjSYKVtK
         d9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVBI6QwpByRFprYkECNUGcyojI2QvRPpnBETlvnTCoehJymG5rm/MtFuH5el5uvU4UvOUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjyhwsbgY0IqmwdFXqJh4k1Q03bSNmTa75oV0sSRn2dljucCi7
	o0buoN7JFXkhOiRvYWfesITLIA1Dprovl3BU81MyK/wgwMXY1ooqIVjvsSuhI05IdDKggspl3ef
	3j2sTQ9wyml586KuWcG82HqVfUGU1p6Iq9dj6tzJTBA5gRrzKOg==
X-Gm-Gg: ASbGncuocYVdnWDUD4UEC+SuJo/6XMxm+bEt64AlP8A0XRYecuezcngEQ1JVf1TFVbp
	NcncQRwZVV83y8NaX88jjNwbKRx673sPhYfVrSEHv2cA1fuXSfWI+/Qx27V1k2zfd1AcvQDs7KM
	Y51LRQC1R8isQ5yh/fgoE1Ov5QzvQXIyJ3w75deNsIsUEZYoT4eAaKl/IPoP2ClbOvp84I7FSRD
	B1RQH1XTL0OdPwGpf3/5VOWIFAPu9SYrnL0STod6n+K/bZgqmjlbEIbSZ4=
X-Received: by 2002:a05:600c:1f86:b0:436:51bb:7a43 with SMTP id 5b1f17b1804b1-436ee0f8af6mr486185e9.5.1736430177662;
        Thu, 09 Jan 2025 05:42:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5m4tfgVUXXtQrzZe1N8yHzwLbDrucPzBnV0KJqzaPNouhBoh4EpWaQZfS/qgi6tjX8hNSVA==
X-Received: by 2002:a05:600c:1f86:b0:436:51bb:7a43 with SMTP id 5b1f17b1804b1-436ee0f8af6mr485655e9.5.1736430176950;
        Thu, 09 Jan 2025 05:42:56 -0800 (PST)
Received: from sgarzare-redhat ([5.77.115.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0bdsm1871927f8f.3.2025.01.09.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 05:42:56 -0800 (PST)
Date: Thu, 9 Jan 2025 14:42:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wongi Lee <qwerty@theori.io>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	virtualization@lists.linux.dev, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Luigi Leonardi <leonardi@redhat.com>, bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Hyunwoo Kim <v4bel@theori.io>, kvm@vger.kernel.org
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
Message-ID: <wix5cx7uhthr6imrpsliysktyae6xwuzpvg77uscswyqwszzfb@ms5osa4ckdcm>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
 <2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co>

On Thu, Jan 09, 2025 at 02:34:28PM +0100, Michal Luczaj wrote:
>On 1/8/25 19:06, Stefano Garzarella wrote:
>> If the socket has been de-assigned or assigned to another transport,
>> we must discard any packets received because they are not expected
>> and would cause issues when we access vsk->transport.
>>
>> A possible scenario is described by Hyunwoo Kim in the attached link,
>> where after a first connect() interrupted by a signal, and a second
>> connect() failed, we can find `vsk->transport` at NULL, leading to a
>> NULL pointer dereference.
>>
>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>> Reported-by: Hyunwoo Kim <v4bel@theori.io>
>> Reported-by: Wongi Lee <qwerty@theori.io>
>> Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 9acc13ab3f82..51a494b69be8 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>>
>>  	lock_sock(sk);
>>
>> -	/* Check if sk has been closed before lock_sock */
>> -	if (sock_flag(sk, SOCK_DONE)) {
>> +	/* Check if sk has been closed or assigned to another transport before
>> +	 * lock_sock (note: listener sockets are not assigned to any transport)
>> +	 */
>> +	if (sock_flag(sk, SOCK_DONE) ||
>> +	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
>>  		(void)virtio_transport_reset_no_sock(t, skb);
>>  		release_sock(sk);
>>  		sock_put(sk);
>
>FWIW, I've tried simplifying Hyunwoo's repro to toy with some tests. Ended
>up with
>
>```
>from threading import *
>from socket import *
>from signal import *
>
>def listener(tid):
>	while True:
>		s = socket(AF_VSOCK, SOCK_SEQPACKET)
>		s.bind((1, 1234))
>		s.listen()
>		pthread_kill(tid, SIGUSR1)
>
>signal(SIGUSR1, lambda *args: None)
>Thread(target=listener, args=[get_ident()]).start()
>
>while True:
>	c = socket(AF_VSOCK, SOCK_SEQPACKET)
>	c.connect_ex((1, 1234))
>	c.connect_ex((42, 1234))
>```
>
>which gives me splats with or without this patch.
>
>That said, when I apply this patch, but drop the `sk->sk_state !=
>TCP_LISTEN &&`: no more splats.

We can't drop `sk->sk_state != TCP_LISTEN &&` because listener socket 
doesn't have any transport (vsk->transport == NULL), so every connection 
request will receive an error, so maybe this is the reason of no splats.

I'm cooking some more patches to fix Hyunwoo's scenario handling better 
the close work when the virtio destructor is called.

I'll run your reproduces to test it, thanks for that!

Stefano


