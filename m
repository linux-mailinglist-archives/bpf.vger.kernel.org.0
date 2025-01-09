Return-Path: <bpf+bounces-48384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C824A07440
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 12:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6E816869D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9286F216604;
	Thu,  9 Jan 2025 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="UgLiaiih"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5CC2153FE
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736421022; cv=none; b=APMKw2e9vd+is1dnp5tyeJXjKV+BahGgXDlRFp73D9fbM2jzzr3uiUFRNeug9tUXP+4kPQBs1jnA+Z96kbg5kjiSsFVvm8L8GccJN/X7zGWaM0omUWGUduFrZjMtM1wOPPHaeIK1WDTf1kdtP43PL1riBxRbC7e5kzFyfSNLvKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736421022; c=relaxed/simple;
	bh=UUeZRcbvFQU0IU5zd+krxlu/oPz539Cj6HEwFZKEK0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVHMNAN64P4JaXKYW6LiV6urbTEMxkYm19ijnp4KTE7ZUO1aL9RQW3Zk8ni0x5auMJj5tg/FbIysv/eafG7AAAIYiUg1uLhJ25B0Q0lKzXKjNsIsmDeqsQbsXijRL1MynsW+naSHFSyFG2vE0WikpIOE4snSOjA7cULCsxOYu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=UgLiaiih; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2167141dfa1so13074965ad.1
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 03:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1736421018; x=1737025818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+ljKu7GZzEGvp6RrMbhl8PlBYJNNWnzxd6tP/33TRU=;
        b=UgLiaiih3C9M3r+V4I9ArJ7mNSvM0PMgwrjt9aFi3nB+IpT8p9CeewHO+v+ENO+Lu4
         PeYHG4joDaCLcLvTHG1jt9mdv0rUwZqa7sQAWMAmf2+3bCjsb4E3METP0x8TscIE43jT
         C5/UZ0l0nEYoMI3oIhgb2vte9aValpoHhrq3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736421018; x=1737025818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+ljKu7GZzEGvp6RrMbhl8PlBYJNNWnzxd6tP/33TRU=;
        b=q0ZjTzYYd/fT6R0PVMGz4ix9jrQhBPkfLLB8WOafFEfHw8elbNWSZvSg4sbVF12tkc
         jBLDJj2Ctn/pwIzdSEkE2OM6fahxGr1Z9z+/HWjRifg0tdn0akkdGBpniOEkJKljF3kw
         pya9gGdznUz1ylMMXSCIed6MJvZYhl7p9LJWnyWGWqSnZRD3b/YbGZ/hMTtCegy52Oao
         5mkL/LEyTA2OdlkF3AeWq4Z4zoWixIFyTwHLTo30MojkjzIJ92sMHT6u83CoanuZ9M3O
         HMS+oHQyrLq/U80QEiB1Aohp3fpX3UjOeQy3KDqPilFg207BbSMgOFsd26/sG+JcMB9A
         5zTA==
X-Forwarded-Encrypted: i=1; AJvYcCWURPyD6rhRk65RIO4ypy6QF7EWb56WgKYfm3fBuWc05EllkyW5eNo19fF1ge5xqOuyLLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ7ICKxuOtrFOt62tAt8f3IaUckee4vQItLuXa1fi7kSrL1nM3
	AdhNWbfsZ1WixSI3ssJL/sfXXeYj9ToZdQk3Aag7xg+uUS3h+2nqXsMKuVwf0fs=
X-Gm-Gg: ASbGncvqziFZkfJ1JcfU6LPuEeRs/P8sNemKjCbmSKfuB5G9pCMJBotIYRdzCL3d2ON
	/egfHdgUWid01NNTnETQ6yNTT9fv4tDTm6HGsrPk6gPpYIYyk2xagrmGoGOsnxv7kMSwQdRrz0Z
	FuFNOv+ZGvelWTkKOQuq4KDhdtP88rjj7+TGlKvUCRg1qzHNn+C0LrHVjw6HX2GlnMkSvmvykC0
	NdZKaL69lbZEsWFtmZHHJ7RKYsXf4CthEuiL7BFsL9htkec68LcvCBU511Ah4roJAU5qw==
X-Google-Smtp-Source: AGHT+IE6kHjF6VMW7zKKnf4D3URfl2Zhbkt1AYg7UxtWOKnbCc5MRKenY3iXJIlmvTUmO1+DA+iBUw==
X-Received: by 2002:a17:903:2a90:b0:216:1079:82bb with SMTP id d9443c01a7336-21a8d6c7c8cmr46825095ad.19.1736421018208;
        Thu, 09 Jan 2025 03:10:18 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a91767dd4sm10210695ad.23.2025.01.09.03.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 03:10:17 -0800 (PST)
Date: Thu, 9 Jan 2025 06:10:10 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wongi Lee <qwerty@theori.io>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	virtualization@lists.linux.dev,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>, bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, Michal Luczaj <mhal@rbox.co>,
	kvm@vger.kernel.org, imv4bel@gmail.com, v4bel@theori.io
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
Message-ID: <Z3+ukoUBYp5VVXRX@v4bel-B760M-AORUS-ELITE-AX>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
 <Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX>
 <77plpkw3mp4r3ue4ubmh4yhqfo777koiu65dqfqfxmjgc5uq57@aifi6mhtgtuj>
 <Z3+TSNfTJr2X8oQV@v4bel-B760M-AORUS-ELITE-AX>
 <x3gyqgbor4syfy56j5qolppiec3du4hbkywncmlipt2sw6bp46@vtk4apoy7w3o>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x3gyqgbor4syfy56j5qolppiec3du4hbkywncmlipt2sw6bp46@vtk4apoy7w3o>

On Thu, Jan 09, 2025 at 11:59:21AM +0100, Stefano Garzarella wrote:
> On Thu, Jan 09, 2025 at 04:13:44AM -0500, Hyunwoo Kim wrote:
> > On Thu, Jan 09, 2025 at 10:01:31AM +0100, Stefano Garzarella wrote:
> > > On Wed, Jan 08, 2025 at 02:31:19PM -0500, Hyunwoo Kim wrote:
> > > > On Wed, Jan 08, 2025 at 07:06:16PM +0100, Stefano Garzarella wrote:
> > > > > If the socket has been de-assigned or assigned to another transport,
> > > > > we must discard any packets received because they are not expected
> > > > > and would cause issues when we access vsk->transport.
> > > > >
> > > > > A possible scenario is described by Hyunwoo Kim in the attached link,
> > > > > where after a first connect() interrupted by a signal, and a second
> > > > > connect() failed, we can find `vsk->transport` at NULL, leading to a
> > > > > NULL pointer dereference.
> > > > >
> > > > > Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> > > > > Reported-by: Hyunwoo Kim <v4bel@theori.io>
> > > > > Reported-by: Wongi Lee <qwerty@theori.io>
> > > > > Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
> > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > ---
> > > > >  net/vmw_vsock/virtio_transport_common.c | 7 +++++--
> > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > > index 9acc13ab3f82..51a494b69be8 100644
> > > > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > > > @@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > > >
> > > > >  	lock_sock(sk);
> > > > >
> > > > > -	/* Check if sk has been closed before lock_sock */
> > > > > -	if (sock_flag(sk, SOCK_DONE)) {
> > > > > +	/* Check if sk has been closed or assigned to another transport before
> > > > > +	 * lock_sock (note: listener sockets are not assigned to any transport)
> > > > > +	 */
> > > > > +	if (sock_flag(sk, SOCK_DONE) ||
> > > > > +	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
> > > >
> > > > If a race scenario with vsock_listen() is added to the existing
> > > > race scenario, the patch can be bypassed.
> > > >
> > > > In addition to the existing scenario:
> > > > ```
> > > >                     cpu0                                                      cpu1
> > > >
> > > >                                                               socket(A)
> > > >
> > > >                                                               bind(A, {cid: VMADDR_CID_LOCAL, port: 1024})
> > > >                                                                 vsock_bind()
> > > >
> > > >                                                               listen(A)
> > > >                                                                 vsock_listen()
> > > >  socket(B)
> > > >
> > > >  connect(B, {cid: VMADDR_CID_LOCAL, port: 1024})
> > > >    vsock_connect()
> > > >      lock_sock(sk);
> > > >      virtio_transport_connect()
> > > >        virtio_transport_connect()
> > > >          virtio_transport_send_pkt_info()
> > > >            vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_REQUEST)
> > > >              queue_work(vsock_loopback_work)
> > > >      sk->sk_state = TCP_SYN_SENT;
> > > >      release_sock(sk);
> > > >                                                               vsock_loopback_work()
> > > >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_REQUEST)
> > > >                                                                   sk = vsock_find_bound_socket(&dst);
> > > >                                                                   virtio_transport_recv_listen(sk, skb)
> > > >                                                                     child = vsock_create_connected(sk);
> > > >                                                                     vsock_assign_transport()
> > > >                                                                       vvs = kzalloc(sizeof(*vvs), GFP_KERNEL);
> > > >                                                                     vsock_insert_connected(vchild);
> > > >                                                                       list_add(&vsk->connected_table, list);
> > > >                                                                     virtio_transport_send_response(vchild, skb);
> > > >                                                                       virtio_transport_send_pkt_info()
> > > >                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RESPONSE)
> > > >                                                                           queue_work(vsock_loopback_work)
> > > >
> > > >                                                               vsock_loopback_work()
> > > >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RESPONSE)
> > > >                                                                   sk = vsock_find_bound_socket(&dst);
> > > >                                                                   lock_sock(sk);
> > > >                                                                   case TCP_SYN_SENT:
> > > >                                                                   virtio_transport_recv_connecting()
> > > >                                                                     sk->sk_state = TCP_ESTABLISHED;
> > > >                                                                   release_sock(sk);
> > > >
> > > >                                                               kill(connect(B));
> > > >      lock_sock(sk);
> > > >      if (signal_pending(current)) {
> > > >      sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
> > > >      sock->state = SS_UNCONNECTED;    // [1]
> > > >      release_sock(sk);
> > > >
> > > >  connect(B, {cid: VMADDR_CID_HYPERVISOR, port: 1024})
> > > >    vsock_connect(B)
> > > >      lock_sock(sk);
> > > >      vsock_assign_transport()
> > > >        virtio_transport_release()
> > > >          virtio_transport_close()
> > > >            if (!(sk->sk_state == TCP_ESTABLISHED || sk->sk_state == TCP_CLOSING))
> > > >            virtio_transport_shutdown()
> > > >              virtio_transport_send_pkt_info()
> > > >                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
> > > >                  queue_work(vsock_loopback_work)
> > > >            schedule_delayed_work(&vsk->close_work, VSOCK_CLOSE_TIMEOUT);	// [5]
> > > >        vsock_deassign_transport()
> > > >          vsk->transport = NULL;
> > > >        return -ESOCKTNOSUPPORT;
> > > >      release_sock(sk);
> > > >                                                               vsock_loopback_work()
> > > >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
> > > >                                                                   virtio_transport_recv_connected()
> > > >                                                                     virtio_transport_reset()
> > > >                                                                       virtio_transport_send_pkt_info()
> > > >                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
> > > >                                                                           queue_work(vsock_loopback_work)
> > > >  listen(B)
> > > >    vsock_listen()
> > > >      if (sock->state != SS_UNCONNECTED)    // [2]
> > > >      sk->sk_state = TCP_LISTEN;    // [3]
> > > >
> > > >                                                               vsock_loopback_work()
> > > >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
> > > > 								   if ((sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {    // [4]
> > > > 								   ...
> > > > 							
> > > >  virtio_transport_close_timeout()
> > > >    virtio_transport_do_close()
> > > >      vsock_stream_has_data()
> > > >        return vsk->transport->stream_has_data(vsk);    // null-ptr-deref
> > > >
> > > > ```
> > > > (Yes, This is quite a crazy scenario, but it can actually be induced)
> > > >
> > > > Since sock->state is set to SS_UNCONNECTED during the first connect()[1],
> > > > it can pass the sock->state check[2] in vsock_listen() and set
> > > > sk->sk_state to TCP_LISTEN[3].
> > > > If this happens, the check in the patch with
> > > > `sk->sk_state != TCP_LISTEN` will pass[4], and a null-ptr-deref can
> > > > still occur.)
> > > >
> > > > More specifically, because the sk_state has changed to TCP_LISTEN,
> > > > virtio_transport_recv_disconnecting() will not be called by the
> > > > loopback worker. However, a null-ptr-deref may occur in
> > > > virtio_transport_close_timeout(), which is scheduled by
> > > > virtio_transport_close() called in the flow of the second connect()[5].
> > > > (The patch no longer cancels the virtio_transport_close_timeout() worker)
> > > >
> > > > And even if the `sk->sk_state != TCP_LISTEN` check is removed from the
> > > > patch, it seems that a null-ptr-deref will still occur due to
> > > > virtio_transport_close_timeout().
> > > > It might be necessary to add worker cancellation at the
> > > > appropriate location.
> > > 
> > > Thanks for the analysis!
> > > 
> > > Do you have time to cook a proper patch to cover this scenario?
> > > Or we should mix this fix together with your patch (return 0 in
> > > vsock_stream_has_data()) while we investigate a better handling?
> > 
> > For now, it seems better to merge them together.
> 
> Okay, since both you and Michael agree on that, I'll include your changes in
> this series, but adding a warning message, since it should not happen.
> 
> Is that fine with you?

Yes, I agree.

> 
> > 
> > It seems that covering this scenario will require more analysis and
> > testing.
> 
> Yeah, scheduling a task during the release is tricky, especially when we are
> changing the transport, so I think we should handle that better.
> 
> One idea that I have it to cancel delayed works in
> virtio_transport_destruct(), I'll test it a bit and add a patch for that in
> the next version of this series.

OK. once the patch is submitted, I will review it.

> 
> We also need to reset SOCK_DONE after changing the transports.
> 
> Thanks,
> Stefano
> 

