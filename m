Return-Path: <bpf+bounces-48372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A325A070A1
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 10:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34AEE7A1045
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 09:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704F82147E6;
	Thu,  9 Jan 2025 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SahZw7Rb"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F5880B
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413304; cv=none; b=k0xDhTWIqagk0QJLHvymplO22mdgnzmvg7EHJxnseGV78cySot02NXxlvmatF3TaNZkksObXTpxTt3OyI+/zRMFrq7L6eJD/yvZda6fyI5V+W/LfOD314OZk71/Yur75oMssfuuSY7q1RR3UeHlD8ZRJFiNDXRpeBeTROG16Hfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413304; c=relaxed/simple;
	bh=+sIdD58FlzLJ0SpEVOPekmjkzCRZ+9ERthJqbNbAqjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELorRcc1FbVUpmPdTde9+we5Bevbk+sR7TpSgMLpfOVQJiDE9Mp5+uqOLJhq7I/cxL/tHQhMMJ3NgR8/ur6NYQUZLqLHr7kAGcuipoPh7Wxz37e1GTdMAYjTQgWn3Oo82sVt24U9Kkza8d37sx0z5jAghuDzlj3qB3mI998vStg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SahZw7Rb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736413301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/+PvGvb8cisc0+olaJcorud7NkJpehAn5lKv6sXjgA=;
	b=SahZw7RbY1qZrX1qyxK+4L+Wn8fxTrXu2npdVTSZOOwR5gMZc5kIQLV+edBeyWxbdjjyVn
	ptR2mp0fW30w+TX8yxWZgnrPRvizwAvf4Zp14PLn8JUyrNHvtd/+7M5XDiHw6eMPtcHqf4
	ZgFX/b46/7tR4wvvmNbhXEgrSmj6JTA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-pj_mOrYPPAK-98RNhBUXqg-1; Thu, 09 Jan 2025 04:01:40 -0500
X-MC-Unique: pj_mOrYPPAK-98RNhBUXqg-1
X-Mimecast-MFC-AGG-ID: pj_mOrYPPAK-98RNhBUXqg
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa68b4b957fso67260066b.3
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 01:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736413299; x=1737018099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/+PvGvb8cisc0+olaJcorud7NkJpehAn5lKv6sXjgA=;
        b=e/XJ/nw9JWN0J6n4YUplUwcWUzjcsOAZd5nS/0wW5lbnOOAOKK5gT3Z7g0hvh1nJcF
         ND5QNQubicHJ2gWsxMbsayeYBZZ6mZM9nU83Bai8aJf6WjGiNZwrDaQ/QJEmGxz/LKIZ
         WoqqduJntjDenJM8Dph5KGmnDjCemC29KV7TV2jT0unNow9np5GFOAkNLVo0IBmcqb1z
         SNgbVzaW8OZt702xyekYanRegm6UCTn+zML8FHqjqJpg0q4VaIqQTK9i3GnyubFtZF1c
         sQ/YUMZLu2lQV1AosRDRPgGxGI3mNOJoONCjLPTX5p+3+NZJXp3zhyIAjQkPUCWhK8t5
         WLoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6PMYZoZlFyMOFQ/2wVIm6rhBWw1Xladw0DkmPr8Dwoq7kSh4S2YmiO9il7sKnyEGwBzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE+X7l/aqn67zYYgXkQiIS2b1wO32Xcr53hgjWZmQaXhsZWglB
	k47fw+PhNYg+oFHVIIhPBe9pEVraGCaIWZXGcJgu9TipIWbGvKeDB3auhGPM8J4XV6Tk91WW+Pd
	ZEeHH2F7LoEchB1MmcS185kfRS2YKO6aDYs4be3sXhfezUCdWSw==
X-Gm-Gg: ASbGncsGGgTWM9o/e/2dmwoBguZRgltm/X6G9XyBOmdGQddYZuy/QIbvFnbsJOowkhZ
	mTJ24PSLpzxI+0x6A5X9fzasRX9rE0Hr0WbVMqWIGtBVIHK7qWHu9hoCT/+/JCMc1FDurIv40r5
	hS5Ci1DacPvi1TP5dQGiDyS5s90vkb+wewfOEmOpjMP/etjM+IM3zdZtG5Q3r8HtmRlSV4UT5qJ
	yrXx1bQdX3+uSZLIpEALBVSyK37AKkLxfev36nOszvFhtY0KgMrK/JZqeA=
X-Received: by 2002:a17:907:a08e:b0:ab2:c1e5:397c with SMTP id a640c23a62f3a-ab2c1e53ab3mr223777666b.29.1736413299331;
        Thu, 09 Jan 2025 01:01:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOV9JHlol/Wmiz7E/zdqdsLMLcaiajVGTKl716cWZNRFMuCfB7oQmf+Zga+/+By1e+6a2YiA==
X-Received: by 2002:a17:907:a08e:b0:ab2:c1e5:397c with SMTP id a640c23a62f3a-ab2c1e53ab3mr223769366b.29.1736413298532;
        Thu, 09 Jan 2025 01:01:38 -0800 (PST)
Received: from sgarzare-redhat ([5.77.115.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c905f067sm50679166b.14.2025.01.09.01.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 01:01:37 -0800 (PST)
Date: Thu, 9 Jan 2025 10:01:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wongi Lee <qwerty@theori.io>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	virtualization@lists.linux.dev, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Luigi Leonardi <leonardi@redhat.com>, bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Michal Luczaj <mhal@rbox.co>, kvm@vger.kernel.org, 
	imv4bel@gmail.com
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
Message-ID: <77plpkw3mp4r3ue4ubmh4yhqfo777koiu65dqfqfxmjgc5uq57@aifi6mhtgtuj>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
 <Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX>

On Wed, Jan 08, 2025 at 02:31:19PM -0500, Hyunwoo Kim wrote:
>On Wed, Jan 08, 2025 at 07:06:16PM +0100, Stefano Garzarella wrote:
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
>
>If a race scenario with vsock_listen() is added to the existing
>race scenario, the patch can be bypassed.
>
>In addition to the existing scenario:
>```
>                     cpu0                                                      cpu1
>
>                                                               socket(A)
>
>                                                               bind(A, {cid: VMADDR_CID_LOCAL, port: 1024})
>                                                                 vsock_bind()
>
>                                                               listen(A)
>                                                                 vsock_listen()
>  socket(B)
>
>  connect(B, {cid: VMADDR_CID_LOCAL, port: 1024})
>    vsock_connect()
>      lock_sock(sk);
>      virtio_transport_connect()
>        virtio_transport_connect()
>          virtio_transport_send_pkt_info()
>            vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_REQUEST)
>              queue_work(vsock_loopback_work)
>      sk->sk_state = TCP_SYN_SENT;
>      release_sock(sk);
>                                                               vsock_loopback_work()
>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_REQUEST)
>                                                                   sk = vsock_find_bound_socket(&dst);
>                                                                   virtio_transport_recv_listen(sk, skb)
>                                                                     child = vsock_create_connected(sk);
>                                                                     vsock_assign_transport()
>                                                                       vvs = kzalloc(sizeof(*vvs), GFP_KERNEL);
>                                                                     vsock_insert_connected(vchild);
>                                                                       list_add(&vsk->connected_table, list);
>                                                                     virtio_transport_send_response(vchild, skb);
>                                                                       virtio_transport_send_pkt_info()
>                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RESPONSE)
>                                                                           queue_work(vsock_loopback_work)
>
>                                                               vsock_loopback_work()
>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RESPONSE)
>                                                                   sk = vsock_find_bound_socket(&dst);
>                                                                   lock_sock(sk);
>                                                                   case TCP_SYN_SENT:
>                                                                   virtio_transport_recv_connecting()
>                                                                     sk->sk_state = TCP_ESTABLISHED;
>                                                                   release_sock(sk);
>
>                                                               kill(connect(B));
>      lock_sock(sk);
>      if (signal_pending(current)) {
>      sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>      sock->state = SS_UNCONNECTED;    // [1]
>      release_sock(sk);
>
>  connect(B, {cid: VMADDR_CID_HYPERVISOR, port: 1024})
>    vsock_connect(B)
>      lock_sock(sk);
>      vsock_assign_transport()
>        virtio_transport_release()
>          virtio_transport_close()
>            if (!(sk->sk_state == TCP_ESTABLISHED || sk->sk_state == TCP_CLOSING))
>            virtio_transport_shutdown()
>              virtio_transport_send_pkt_info()
>                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>                  queue_work(vsock_loopback_work)
>            schedule_delayed_work(&vsk->close_work, VSOCK_CLOSE_TIMEOUT);	// [5]
>        vsock_deassign_transport()
>          vsk->transport = NULL;
>        return -ESOCKTNOSUPPORT;
>      release_sock(sk);
>                                                               vsock_loopback_work()
>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>                                                                   virtio_transport_recv_connected()
>                                                                     virtio_transport_reset()
>                                                                       virtio_transport_send_pkt_info()
>                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
>                                                                           queue_work(vsock_loopback_work)
>  listen(B)
>    vsock_listen()
>      if (sock->state != SS_UNCONNECTED)    // [2]
>      sk->sk_state = TCP_LISTEN;    // [3]
>
>                                                               vsock_loopback_work()
>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
>								   if ((sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {    // [4]
>								   ...
>							
>  virtio_transport_close_timeout()
>    virtio_transport_do_close()
>      vsock_stream_has_data()
>        return vsk->transport->stream_has_data(vsk);    // null-ptr-deref
>
>```
>(Yes, This is quite a crazy scenario, but it can actually be induced)
>
>Since sock->state is set to SS_UNCONNECTED during the first connect()[1],
>it can pass the sock->state check[2] in vsock_listen() and set
>sk->sk_state to TCP_LISTEN[3].
>If this happens, the check in the patch with
>`sk->sk_state != TCP_LISTEN` will pass[4], and a null-ptr-deref can
>still occur.)
>
>More specifically, because the sk_state has changed to TCP_LISTEN,
>virtio_transport_recv_disconnecting() will not be called by the
>loopback worker. However, a null-ptr-deref may occur in
>virtio_transport_close_timeout(), which is scheduled by
>virtio_transport_close() called in the flow of the second connect()[5].
>(The patch no longer cancels the virtio_transport_close_timeout() worker)
>
>And even if the `sk->sk_state != TCP_LISTEN` check is removed from the
>patch, it seems that a null-ptr-deref will still occur due to
>virtio_transport_close_timeout().
>It might be necessary to add worker cancellation at the
>appropriate location.

Thanks for the analysis!

Do you have time to cook a proper patch to cover this scenario?
Or we should mix this fix together with your patch (return 0 in 
vsock_stream_has_data()) while we investigate a better handling?

Thanks,
Stefano


