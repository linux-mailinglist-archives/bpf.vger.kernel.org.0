Return-Path: <bpf+bounces-48383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA88A07403
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 11:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C93163DFC
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF87C2165E9;
	Thu,  9 Jan 2025 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+T7hHue"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A130215F40
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736420374; cv=none; b=oAJu+TQwMXUPzsUOLo4MDE9mt8OShGEk/iORzKoUyOSvA7nP1Bv7zmQDg2uRbd99LBKVKokYSUGHb+vFE5qjQC6xru/WUSATuZI0MQt9IJt6rzLVE5OPlHW3Eo7c3LvLT8nt4fHoPM1/2x5ZirbXq5CLzpRELO3kFp1D0WgoWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736420374; c=relaxed/simple;
	bh=8gTxMeuerEWpQWjnJQBfXbFvuDIGI6pIRCOcuKQzVF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz7un4NnjlfW83Tzm7XdIH5Et0CCqkPD71DvU4ywIwXCKbbjY1p6ok3gcRKL6IS2c6umhYBDev1oGC6uLdM1rso8uUwByf2dkBwIr8fzRoFG9Ln9iKuZH5pKNGybKbLWDnEcK5bPASzWeReTjgYcXoohUBgL7brCEK2UVJdPOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+T7hHue; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736420371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bBjt704Q5NUC3thmEpPZtPuoZ1c7o5TcD6pXJ6D3qsk=;
	b=M+T7hHueD510YjD1Zv0v3WcMLBL/w3YH3/ZJeH+08VhYYlTLtmpZGbtX8h/n6yLWM08Ruu
	JIs7YERLfEM5k7NqRoJaC9fsjnIQYcobVUJQTHsCQIRMoy+JzkGsbsRy+0FoU10EA6x3Xh
	8q0s8CYdmNkxClVj1Z0yYa8956SzjXc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-MpyTpcqMPVqwK4GmsKF1Hg-1; Thu, 09 Jan 2025 05:59:30 -0500
X-MC-Unique: MpyTpcqMPVqwK4GmsKF1Hg-1
X-Mimecast-MFC-AGG-ID: MpyTpcqMPVqwK4GmsKF1Hg
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aaf8396f65fso86663866b.0
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 02:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736420369; x=1737025169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBjt704Q5NUC3thmEpPZtPuoZ1c7o5TcD6pXJ6D3qsk=;
        b=XZHNM8EFQ0fX7i/n8BLbZ1kSQeA+g/PkWhDEPb2EyX2xxaEpR4OVPO6i1a2mwXsve3
         QsgM/ThdJcKKYR5krHyCYicL+4Mladh5iIA3BLJtTT22q2Q2KARO1B533+JYMs83ZraT
         92Xx4Z5j1awiBJ/OStrZaiOX2C8KqfDrziXUDD683+0qxpPGl++TxNRL7OYSkGVvbdya
         4S5DOBP20vVPEYIzSJuIyBSMd5XD+LU1f8Y0gBp6xQrO32B3R5kdjfyWUf/9hxGggo6Q
         OIknKxe41fk3+ofZ92pKoikMZrg4dtNJ8IxNo0hMxICdV+eRjuoRXnp2HjJgvkS+82fx
         ztYA==
X-Forwarded-Encrypted: i=1; AJvYcCV58PJXitsh9/GmtvppbM2bq/4DKmhJt3U2HJL9vUVcKZOLuvqbNV3HoLtgV8qiUwiwEQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypaVcTfNtV7vW1I1MHsg1ytoDd6GbvSaGMXdMeNu4kpmHiruZM
	unE4z6rp+wp0V0s9ZGmjYxwNxxjN3P8LqX8GjpxEhAw8eH0kqxvrAAXLTo9b1EE4DFskTRvY5KI
	l9THvIb9xEnbU5mzfGK7L/hWhWW0u3ip4Io9iIOdk7bKsfjZotg==
X-Gm-Gg: ASbGncv6wOirEwoZa1LbjHjWbZ836eX7O1shGOoRh9P9i5SKEJHpsBo6Vz25XV+T7AF
	I7S3Y6PdtY3J3wCxA69ho3R/XJlzp4vOP59Ny+FkyCttkDkFFEfgermGWsk9W8i+6ddwavWiG7F
	Wl/9FERcjN0UwK6QeswhLa/vYstUzxI2ti1jBSUmfToL0XsvBppUE/5sy0sLKrkQ6c8yNRCtsCs
	PKUmV4JMcUB7TW8wPyDRu7FzYDQmZ88/unY2akWozWRMo850ixYT3w/sxE=
X-Received: by 2002:a17:907:720f:b0:aa6:691f:20a9 with SMTP id a640c23a62f3a-ab2ab66dd04mr524977066b.4.1736420368672;
        Thu, 09 Jan 2025 02:59:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrT5EksSyWrHn723GTlT0TpsOhz9cpWIfw9mWd3UiShHT9qOMymVSjg8KppWEZVOo07fXQ5w==
X-Received: by 2002:a17:907:720f:b0:aa6:691f:20a9 with SMTP id a640c23a62f3a-ab2ab66dd04mr524973966b.4.1736420367896;
        Thu, 09 Jan 2025 02:59:27 -0800 (PST)
Received: from sgarzare-redhat ([5.77.115.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9563ae8sm59395266b.129.2025.01.09.02.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 02:59:27 -0800 (PST)
Date: Thu, 9 Jan 2025 11:59:21 +0100
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
Message-ID: <x3gyqgbor4syfy56j5qolppiec3du4hbkywncmlipt2sw6bp46@vtk4apoy7w3o>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
 <Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX>
 <77plpkw3mp4r3ue4ubmh4yhqfo777koiu65dqfqfxmjgc5uq57@aifi6mhtgtuj>
 <Z3+TSNfTJr2X8oQV@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z3+TSNfTJr2X8oQV@v4bel-B760M-AORUS-ELITE-AX>

On Thu, Jan 09, 2025 at 04:13:44AM -0500, Hyunwoo Kim wrote:
>On Thu, Jan 09, 2025 at 10:01:31AM +0100, Stefano Garzarella wrote:
>> On Wed, Jan 08, 2025 at 02:31:19PM -0500, Hyunwoo Kim wrote:
>> > On Wed, Jan 08, 2025 at 07:06:16PM +0100, Stefano Garzarella wrote:
>> > > If the socket has been de-assigned or assigned to another transport,
>> > > we must discard any packets received because they are not expected
>> > > and would cause issues when we access vsk->transport.
>> > >
>> > > A possible scenario is described by Hyunwoo Kim in the attached link,
>> > > where after a first connect() interrupted by a signal, and a second
>> > > connect() failed, we can find `vsk->transport` at NULL, leading to a
>> > > NULL pointer dereference.
>> > >
>> > > Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>> > > Reported-by: Hyunwoo Kim <v4bel@theori.io>
>> > > Reported-by: Wongi Lee <qwerty@theori.io>
>> > > Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > ---
>> > >  net/vmw_vsock/virtio_transport_common.c | 7 +++++--
>> > >  1 file changed, 5 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > > index 9acc13ab3f82..51a494b69be8 100644
>> > > --- a/net/vmw_vsock/virtio_transport_common.c
>> > > +++ b/net/vmw_vsock/virtio_transport_common.c
>> > > @@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>> > >
>> > >  	lock_sock(sk);
>> > >
>> > > -	/* Check if sk has been closed before lock_sock */
>> > > -	if (sock_flag(sk, SOCK_DONE)) {
>> > > +	/* Check if sk has been closed or assigned to another transport before
>> > > +	 * lock_sock (note: listener sockets are not assigned to any transport)
>> > > +	 */
>> > > +	if (sock_flag(sk, SOCK_DONE) ||
>> > > +	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
>> >
>> > If a race scenario with vsock_listen() is added to the existing
>> > race scenario, the patch can be bypassed.
>> >
>> > In addition to the existing scenario:
>> > ```
>> >                     cpu0                                                      cpu1
>> >
>> >                                                               socket(A)
>> >
>> >                                                               bind(A, {cid: VMADDR_CID_LOCAL, port: 1024})
>> >                                                                 vsock_bind()
>> >
>> >                                                               listen(A)
>> >                                                                 vsock_listen()
>> >  socket(B)
>> >
>> >  connect(B, {cid: VMADDR_CID_LOCAL, port: 1024})
>> >    vsock_connect()
>> >      lock_sock(sk);
>> >      virtio_transport_connect()
>> >        virtio_transport_connect()
>> >          virtio_transport_send_pkt_info()
>> >            vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_REQUEST)
>> >              queue_work(vsock_loopback_work)
>> >      sk->sk_state = TCP_SYN_SENT;
>> >      release_sock(sk);
>> >                                                               vsock_loopback_work()
>> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_REQUEST)
>> >                                                                   sk = vsock_find_bound_socket(&dst);
>> >                                                                   virtio_transport_recv_listen(sk, skb)
>> >                                                                     child = vsock_create_connected(sk);
>> >                                                                     vsock_assign_transport()
>> >                                                                       vvs = kzalloc(sizeof(*vvs), GFP_KERNEL);
>> >                                                                     vsock_insert_connected(vchild);
>> >                                                                       list_add(&vsk->connected_table, list);
>> >                                                                     virtio_transport_send_response(vchild, skb);
>> >                                                                       virtio_transport_send_pkt_info()
>> >                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RESPONSE)
>> >                                                                           queue_work(vsock_loopback_work)
>> >
>> >                                                               vsock_loopback_work()
>> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RESPONSE)
>> >                                                                   sk = vsock_find_bound_socket(&dst);
>> >                                                                   lock_sock(sk);
>> >                                                                   case TCP_SYN_SENT:
>> >                                                                   virtio_transport_recv_connecting()
>> >                                                                     sk->sk_state = TCP_ESTABLISHED;
>> >                                                                   release_sock(sk);
>> >
>> >                                                               kill(connect(B));
>> >      lock_sock(sk);
>> >      if (signal_pending(current)) {
>> >      sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>> >      sock->state = SS_UNCONNECTED;    // [1]
>> >      release_sock(sk);
>> >
>> >  connect(B, {cid: VMADDR_CID_HYPERVISOR, port: 1024})
>> >    vsock_connect(B)
>> >      lock_sock(sk);
>> >      vsock_assign_transport()
>> >        virtio_transport_release()
>> >          virtio_transport_close()
>> >            if (!(sk->sk_state == TCP_ESTABLISHED || sk->sk_state == TCP_CLOSING))
>> >            virtio_transport_shutdown()
>> >              virtio_transport_send_pkt_info()
>> >                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>> >                  queue_work(vsock_loopback_work)
>> >            schedule_delayed_work(&vsk->close_work, VSOCK_CLOSE_TIMEOUT);	// [5]
>> >        vsock_deassign_transport()
>> >          vsk->transport = NULL;
>> >        return -ESOCKTNOSUPPORT;
>> >      release_sock(sk);
>> >                                                               vsock_loopback_work()
>> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>> >                                                                   virtio_transport_recv_connected()
>> >                                                                     virtio_transport_reset()
>> >                                                                       virtio_transport_send_pkt_info()
>> >                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
>> >                                                                           queue_work(vsock_loopback_work)
>> >  listen(B)
>> >    vsock_listen()
>> >      if (sock->state != SS_UNCONNECTED)    // [2]
>> >      sk->sk_state = TCP_LISTEN;    // [3]
>> >
>> >                                                               vsock_loopback_work()
>> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
>> > 								   if ((sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {    // [4]
>> > 								   ...
>> > 							
>> >  virtio_transport_close_timeout()
>> >    virtio_transport_do_close()
>> >      vsock_stream_has_data()
>> >        return vsk->transport->stream_has_data(vsk);    // null-ptr-deref
>> >
>> > ```
>> > (Yes, This is quite a crazy scenario, but it can actually be induced)
>> >
>> > Since sock->state is set to SS_UNCONNECTED during the first connect()[1],
>> > it can pass the sock->state check[2] in vsock_listen() and set
>> > sk->sk_state to TCP_LISTEN[3].
>> > If this happens, the check in the patch with
>> > `sk->sk_state != TCP_LISTEN` will pass[4], and a null-ptr-deref can
>> > still occur.)
>> >
>> > More specifically, because the sk_state has changed to TCP_LISTEN,
>> > virtio_transport_recv_disconnecting() will not be called by the
>> > loopback worker. However, a null-ptr-deref may occur in
>> > virtio_transport_close_timeout(), which is scheduled by
>> > virtio_transport_close() called in the flow of the second connect()[5].
>> > (The patch no longer cancels the virtio_transport_close_timeout() worker)
>> >
>> > And even if the `sk->sk_state != TCP_LISTEN` check is removed from the
>> > patch, it seems that a null-ptr-deref will still occur due to
>> > virtio_transport_close_timeout().
>> > It might be necessary to add worker cancellation at the
>> > appropriate location.
>>
>> Thanks for the analysis!
>>
>> Do you have time to cook a proper patch to cover this scenario?
>> Or we should mix this fix together with your patch (return 0 in
>> vsock_stream_has_data()) while we investigate a better handling?
>
>For now, it seems better to merge them together.

Okay, since both you and Michael agree on that, I'll include your 
changes in this series, but adding a warning message, since it should 
not happen.

Is that fine with you?

>
>It seems that covering this scenario will require more analysis and 
>testing.

Yeah, scheduling a task during the release is tricky, especially when we 
are changing the transport, so I think we should handle that better.

One idea that I have it to cancel delayed works in 
virtio_transport_destruct(), I'll test it a bit and add a patch for that 
in the next version of this series.

We also need to reset SOCK_DONE after changing the transports.

Thanks,
Stefano


