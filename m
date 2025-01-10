Return-Path: <bpf+bounces-48529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ABDA08A82
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 09:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80EB33A97ED
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 08:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A7E208986;
	Fri, 10 Jan 2025 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSJ+h6YE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839031ADFE4
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498369; cv=none; b=s3p0+CXV1bFgaY+CYRkNBAFJabPX9CcPzdhrYd8AV+9yJf5gYOq+NzQcFVWkZLKKh7hRvvnsf5uNbxtaKASC1I126VyihqbCaK2Wkrp3dLxq38EFfPNNhlhBRji0vPMbD9rWWHwn6oelkmu69m6PH90Pxo3qryO9ySwHWy2tZsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498369; c=relaxed/simple;
	bh=iJsV4mrkuXUAlTF79pi0keywbZpwBmWfcU2SNaEDdkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXzeBg+Aj5dpXuBMRwigjdkC3oj2VjK4P0sMpf50DJ4vUXr5rRCuH/AxsEPxT3/iR0Sb6SCZXToGrPM6tb0n5iCOzfr9w+qhSjYIIak3iSwQu2vQLjgm+5eBbWVH0AkSRuAf6QyIezfDVuFFeCPb5Bvp48r7KWCJWjZ9eZF/Z0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSJ+h6YE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CXoL+WQHSf+XTBr1CBk1hX3xSrp4GoYvIVG/Iw0rQu8=;
	b=KSJ+h6YEUU3Cq6jsmws5ap7RDmBv50VtXc3/2vbaer5oA1cyjZ00AV9TCNOFtEtzLqYL6U
	VgfbN7Bu5zoz5sG3+FCI6dqL97K3gV1CSmUTxBhtqE4wMln6v7IN45lzNUKbyr4asPnLA4
	FFKhe5GHNthmjrBh7KHASbb54m35PFg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-t3jTfVVEMFyVodlkDZEEMg-1; Fri, 10 Jan 2025 03:39:24 -0500
X-MC-Unique: t3jTfVVEMFyVodlkDZEEMg-1
X-Mimecast-MFC-AGG-ID: t3jTfVVEMFyVodlkDZEEMg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e1339790so1116075f8f.2
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 00:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498363; x=1737103163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXoL+WQHSf+XTBr1CBk1hX3xSrp4GoYvIVG/Iw0rQu8=;
        b=QVUxzwhE0VtlB5WslyV/98WNo8DdoYzs5L80/qroQRH6YHpKkhvGRJm0ZCyUN2GIRJ
         n3wzHJf/bc1bGtACBJXCD4+7qeitIr/Hban1XBcYDybF2m+IglZ8GPGe1795NlRuf2ey
         xWTTF7nb1k5fPF3MOVVDKP3ooxS4hOnrn061yvg6R6uqkQANH1YE7cQ0pPOsozTF2fPk
         vKiriBhv6ErO8d2fmuC9DbzYHamVWMpdkfIiVwYDVn3ZHuYwPTCZBs2/siZO37r/VuuY
         4Zdp515HQiAV5grU3pju1i6RusFZt6bWV2wIRmVBxXBbLn8VTY0BWJOpt6TZf1CxLftg
         J7qw==
X-Forwarded-Encrypted: i=1; AJvYcCXojivpZCqItRG6NFBocRgFZbvLM0nWvpqHc1rvDp6+xIjbrfQuzOC5mwWeNjDXAhcvLYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT0urbFAziSXjUn9muMOlOFZSWv7ASSzgVmiMhs8YmS1FPtdsu
	WqhVOC249QDwrZKFWs5oeYy1E5dzkSfpljSODjHniYVyfOQP3BzIfr/Jf8sHkUc1WAxSdMFaqH7
	9LjPJLkH1aNsvoSRqLhqprfSTznlfrs6vfCfNtPY1s1z7F+D+LRqmZPoEvbnb
X-Gm-Gg: ASbGnctyZpt4fEXgOD1jeTCbtQFsF4NWg/l64Ud2CTusYRQgRbPJmtAVqZX69HKBDOJ
	g2W/R+6ZGid3IZc4wJpeepErZ6ENdvmqPUdy1AERDhg+hG6H4jjc4YnCUhhlDxDv2A+TPrSsHqE
	mhKPak4libS6cI8x79j5/Wzg+gjhvEVxWS8VjyPXZiI7gUWrAdnErwh4UfyQ35xNWB/b2u0jxcO
	FfhBKG82Wx/MtlbCow8qeh9WA4zJYUi+L8JK4AwkScPznxfv2KVAJOVtQ==
X-Received: by 2002:a5d:6483:0:b0:385:fabf:13d5 with SMTP id ffacd0b85a97d-38a8730d55cmr9428507f8f.25.1736498362856;
        Fri, 10 Jan 2025 00:39:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxWFzsARmI1wzAKHZHOe31pA0LmSwGyB/GI2e+cfrQc0ZXGW0pe8rXUAHFnRj3NAhqLwSr2g==
X-Received: by 2002:a5d:6483:0:b0:385:fabf:13d5 with SMTP id ffacd0b85a97d-38a8730d55cmr9428445f8f.25.1736498362219;
        Fri, 10 Jan 2025 00:39:22 -0800 (PST)
Received: from sgarzare-redhat ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1b44sm3942825f8f.90.2025.01.10.00.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:39:21 -0800 (PST)
Date: Fri, 10 Jan 2025 09:39:16 +0100
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
Message-ID: <2wsi6sehglavj75jr5gugdq6oqtor7gonx5zhmetzqwvfwc5gn@e3xlsfvygfgj>
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

Thanks again for the repro, it worked for me, only if a G2H transport
wasn't loaeded (e.g. virtio-vsock driver).

I tested on the v2 I just sent [1], and I can't see the kernel oops
anymore, but please do test/review too.

Thanks,
Stefano

[1] https://lore.kernel.org/netdev/20250110083511.30419-1-sgarzare@redhat.com/


