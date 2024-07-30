Return-Path: <bpf+bounces-36050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47169940BBD
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 10:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AE328C303
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 08:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D049F1990BC;
	Tue, 30 Jul 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kp28W/Tk"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF960198A07
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328376; cv=none; b=NQ5qv0rt8hTnpdJrm99I3TGHnKHT4U6c0KZa/KsUvTfFfNlhy4Nj51p1lxDlr3gNJjf2lKaP6NuTle+HplaJLFlzfk5v6lFV7E8xV9lK6H+HkZF2uqkMyRQ8zpw1USqpiWlZKpEmK5W3ZKTaOK2o5PWz9V7ubgfUBXb4Ce+c/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328376; c=relaxed/simple;
	bh=E6gmvD0Q7zeWVOo4lEzOWRmLUPeP28JDg0QFfxt2s8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4ZxgDkOw/2RPblAzir7Wi6nZXhm2lJTfp7ULRW2wxAfhAWdmvo9cCk/0IS2LsDS5MbpHv2jyb3uvqBTtDuO7HIH5ZH90AmXJS/R8ZKI3JNl6TtevaZQVa6TrHtoQqgz8FFElwsZQlqq75dMF81UNVqec55fhgWLqeOlYpSthjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kp28W/Tk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722328373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUu9DqweMZplPZPw8zixj088PoW8Kyk6wuUBLwD2TsA=;
	b=Kp28W/TkLva9fitao4Iib4y5TH3KR+B+rVKwU9Fr+kj4XCPIhuwBEQVhhVJWo8LCdB5Ll6
	mZ+wBZxAcRu2wQkZNaE6ZXP1rL/Cz5BGPck+40Ikrg7gTReC9sKB3iaXzSMhp1yXBHjuHH
	mRqVIGIuUu/W0TL4w/ZjtZWxH2wheg8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-TF2NkSBbOOCkmcK5qr4T2w-1; Tue, 30 Jul 2024 04:32:50 -0400
X-MC-Unique: TF2NkSBbOOCkmcK5qr4T2w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280c6b3614so25263245e9.2
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 01:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722328369; x=1722933169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUu9DqweMZplPZPw8zixj088PoW8Kyk6wuUBLwD2TsA=;
        b=Vc6e7dP5BbxlD9BDvxJ+RcMTaQ0jiMDkcovGdoQaLWC/gWRaFfNS/hJ1L4bYujw7L7
         AJXCEUMEr0JcUQQRspfbaH2fAviyw+9G8ESEUy7B1QL7mc4yXPEGATtSChKLmygaZSlb
         EWaA/2oVCiLT1RTGJLtpAYNrwQ/mf6P3A/hJMu5XxyqfMFYAogg/YZpM+ZP38zGb2ty8
         kVRRpl406aSfnFPMy6tizKbPz3OL+D0DpBUhFvqkrpA2vSyUUCoW2buPRTzTFcjVVZti
         OtS6/00nZZMCytYarWTeSSGY2ZU5Ftujm50pNyDDSM2uLMELcXyTr3BWXx/7RrLRd3wV
         nBqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl3zlUDPt0cKVjL94QEickHZWWkZljPMcSfWVdA4oAJ8teh/ex1QDLCyRlGsT211UDMl1i+mLE4UctQpGhQ/EuJicx
X-Gm-Message-State: AOJu0YyKWn3Ga7y88Zbexg6Pj9ERoKvmHhbmYvIEVG0X5zQvK0ETeVbi
	U10DkXJkTmYarKt8vRwIjDpfn0s4jGvIXwFTwNf7RJYlrv7Y0SX4LfgzizJPVj+o259CmEmnFGL
	mMZZlzLDVKI0+OgB6sC4PmgdMqle6MA2l1MN+CsPVNY+42XfYFw==
X-Received: by 2002:a05:600c:2d53:b0:426:59fc:cdec with SMTP id 5b1f17b1804b1-42811da1b88mr71529965e9.21.1722328369121;
        Tue, 30 Jul 2024 01:32:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIZbaDTrEZBCLXIF/bnAzy6Ax7DEDAW4LkM0HdYou7XpcwkGyKPBEX2idkqwXBZnxwkKn71A==
X-Received: by 2002:a05:600c:2d53:b0:426:59fc:cdec with SMTP id 5b1f17b1804b1-42811da1b88mr71529585e9.21.1722328368349;
        Tue, 30 Jul 2024 01:32:48 -0700 (PDT)
Received: from sgarzare-redhat ([62.205.9.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574b2c2sm203448165e9.28.2024.07.30.01.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 01:32:47 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:32:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com, 
	dan.carpenter@linaro.org, simon.horman@corigine.com, oxffffaa@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org, bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH net-next v6 09/14] virtio/vsock: add common datagram
 recv path
Message-ID: <yx5phoynacbxobystxaa3zca5ehzbupzzwz3ayptb7wu5d74mc@ic3lvpjnvkkr>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-10-amery.hung@bytedance.com>
 <ldyfzp5k2qmhlydflu7biz6bcrekothacitzgbmw2k264zwuxh@hmgoku5kgghp>
 <CAMB2axNx=nCh-B-=XLtto2nEsKsV0p+b7yzXRX9OKSgUbRzzWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axNx=nCh-B-=XLtto2nEsKsV0p+b7yzXRX9OKSgUbRzzWA@mail.gmail.com>

On Mon, Jul 29, 2024 at 05:35:01PM GMT, Amery Hung wrote:
>On Tue, Jul 23, 2024 at 7:42 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Wed, Jul 10, 2024 at 09:25:50PM GMT, Amery Hung wrote:
>> >From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> >
>> >This commit adds the common datagram receive functionality for virtio
>> >transports. It does not add the vhost/virtio users of that
>> >functionality.
>> >
>> >This functionality includes:
>> >- changes to the virtio_transport_recv_pkt() path for finding the
>> >  bound socket receiver for incoming packets
>> >- virtio_transport_recv_pkt() saves the source cid and port to the
>> >  control buffer for recvmsg() to initialize sockaddr_vm structure
>> >  when using datagram
>> >
>> >Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> >Signed-off-by: Amery Hung <amery.hung@bytedance.com>
>> >---
>> > net/vmw_vsock/virtio_transport_common.c | 79 +++++++++++++++++++++----
>> > 1 file changed, 66 insertions(+), 13 deletions(-)
>> >
>> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >index 46cd1807f8e3..a571b575fde9 100644
>> >--- a/net/vmw_vsock/virtio_transport_common.c
>> >+++ b/net/vmw_vsock/virtio_transport_common.c
>> >@@ -235,7 +235,9 @@ EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);
>> >
>> > static u16 virtio_transport_get_type(struct sock *sk)
>> > {
>> >-      if (sk->sk_type == SOCK_STREAM)
>> >+      if (sk->sk_type == SOCK_DGRAM)
>> >+              return VIRTIO_VSOCK_TYPE_DGRAM;
>> >+      else if (sk->sk_type == SOCK_STREAM)
>> >               return VIRTIO_VSOCK_TYPE_STREAM;
>> >       else
>> >               return VIRTIO_VSOCK_TYPE_SEQPACKET;
>> >@@ -1422,6 +1424,33 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>> >               kfree_skb(skb);
>> > }
>> >
>> >+static void
>> >+virtio_transport_dgram_kfree_skb(struct sk_buff *skb, int err)
>> >+{
>> >+      if (err == -ENOMEM)
>> >+              kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_RCVBUFF);
>> >+      else if (err == -ENOBUFS)
>> >+              kfree_skb_reason(skb, SKB_DROP_REASON_PROTO_MEM);
>> >+      else
>> >+              kfree_skb(skb);
>> >+}
>> >+
>> >+/* This function takes ownership of the skb.
>> >+ *
>> >+ * It either places the skb on the sk_receive_queue or frees it.
>> >+ */
>> >+static void
>> >+virtio_transport_recv_dgram(struct sock *sk, struct sk_buff *skb)
>> >+{
>> >+      int err;
>> >+
>> >+      err = sock_queue_rcv_skb(sk, skb);
>> >+      if (err) {
>> >+              virtio_transport_dgram_kfree_skb(skb, err);
>> >+              return;
>> >+      }
>> >+}
>> >+
>> > static int
>> > virtio_transport_recv_connected(struct sock *sk,
>> >                               struct sk_buff *skb)
>> >@@ -1591,7 +1620,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>> > static bool virtio_transport_valid_type(u16 type)
>> > {
>> >       return (type == VIRTIO_VSOCK_TYPE_STREAM) ||
>> >-             (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
>> >+             (type == VIRTIO_VSOCK_TYPE_SEQPACKET) ||
>> >+             (type == VIRTIO_VSOCK_TYPE_DGRAM);
>> > }
>> >
>> > /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>> >@@ -1601,44 +1631,57 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>> >                              struct sk_buff *skb)
>> > {
>> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>> >+      struct vsock_skb_cb *vsock_cb;
>>
>> This can be defined in the block where it's used.
>>
>
>Got it.
>
>> >       struct sockaddr_vm src, dst;
>> >       struct vsock_sock *vsk;
>> >       struct sock *sk;
>> >       bool space_available;
>> >+      u16 type;
>> >
>> >       vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
>> >                       le32_to_cpu(hdr->src_port));
>> >       vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
>> >                       le32_to_cpu(hdr->dst_port));
>> >
>> >+      type = le16_to_cpu(hdr->type);
>> >+
>> >       trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
>> >                                       dst.svm_cid, dst.svm_port,
>> >                                       le32_to_cpu(hdr->len),
>> >-                                      le16_to_cpu(hdr->type),
>> >+                                      type,
>> >                                       le16_to_cpu(hdr->op),
>> >                                       le32_to_cpu(hdr->flags),
>> >                                       le32_to_cpu(hdr->buf_alloc),
>> >                                       le32_to_cpu(hdr->fwd_cnt));
>> >
>> >-      if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
>> >+      if (!virtio_transport_valid_type(type)) {
>> >               (void)virtio_transport_reset_no_sock(t, skb);
>> >               goto free_pkt;
>> >       }
>> >
>> >-      /* The socket must be in connected or bound table
>> >-       * otherwise send reset back
>> >+      /* For stream/seqpacket, the socket must be in connected or bound table
>> >+       * otherwise send reset back.
>> >+       *
>> >+       * For datagrams, no reset is sent back.
>> >        */
>> >       sk = vsock_find_connected_socket(&src, &dst);
>> >       if (!sk) {
>> >-              sk = vsock_find_bound_socket(&dst);
>> >-              if (!sk) {
>> >-                      (void)virtio_transport_reset_no_sock(t, skb);
>> >-                      goto free_pkt;
>> >+              if (type == VIRTIO_VSOCK_TYPE_DGRAM) {
>> >+                      sk = vsock_find_bound_dgram_socket(&dst);
>> >+                      if (!sk)
>> >+                              goto free_pkt;
>> >+              } else {
>> >+                      sk = vsock_find_bound_socket(&dst);
>> >+                      if (!sk) {
>> >+                              (void)virtio_transport_reset_no_sock(t, skb);
>> >+                              goto free_pkt;
>> >+                      }
>> >               }
>> >       }
>> >
>> >-      if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
>> >-              (void)virtio_transport_reset_no_sock(t, skb);
>> >+      if (virtio_transport_get_type(sk) != type) {
>> >+              if (type != VIRTIO_VSOCK_TYPE_DGRAM)
>> >+                      (void)virtio_transport_reset_no_sock(t, skb);
>> >               sock_put(sk);
>> >               goto free_pkt;
>> >       }
>> >@@ -1654,12 +1697,21 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>> >
>> >       /* Check if sk has been closed before lock_sock */
>> >       if (sock_flag(sk, SOCK_DONE)) {
>> >-              (void)virtio_transport_reset_no_sock(t, skb);
>> >+              if (type != VIRTIO_VSOCK_TYPE_DGRAM)
>> >+                      (void)virtio_transport_reset_no_sock(t, skb);
>> >               release_sock(sk);
>> >               sock_put(sk);
>> >               goto free_pkt;
>> >       }
>> >
>> >+      if (sk->sk_type == SOCK_DGRAM) {
>> >+              vsock_cb = vsock_skb_cb(skb);
>> >+              vsock_cb->src_cid = src.svm_cid;
>> >+              vsock_cb->src_port = src.svm_port;
>> >+              virtio_transport_recv_dgram(sk, skb);
>>
>>
>> What about adding an API that transports can use to hide this?
>>
>> I mean something that hide vsock_cb creation and queue packet in the
>> socket receive queue. I'd also not expose vsock_skb_cb in an header, but
>> I'd handle it internally in af_vsock.c. So I'd just expose API to
>> queue/dequeue them.
>>
>
>Got it. I will move vsock_skb_cb to af_vsock.c and create an API:
>
>vsock_dgram_skb_save_src_addr(struct sk_buff *skb, u32 cid, u32 port)

This is okay, but I would try to go further by directly adding an API to 
queue dgrams in af_vsock.c (if it's feasible).

>
>Different dgram implementations will call this API instead of the code
>block above to save the source address information into the control
>buffer.
>
>A side note on why this is a vsock API instead of a member )unction in
>transport: As we move to support multi-transport dgram, different
>transport implementations can place skb into the sk->sk_receive_queue.
>Therefore, we cannot call transport-specific function in
>vsock_dgram_recvmsg() to initialize struct sockaddr_vm. Hence, the
>receiving paths of different transports need to call this API to save
>source address.

What I meant is, why virtio_transport_recv_dgram() can't be exposed by 
af_vsock.c as vsock_recv_dgram() and handle all internally, like 
populate vsock_cb, call sock_queue_rcv_skb(), etc.

>
>> Also why VMCI is using sk_receive_skb(), while we are using
>> sock_queue_rcv_skb()?
>>
>
>I _think_ originally we referred to UDP and UDS when designing virtio
>dgram, and ended up with placing skb into sk_receive_queue directly. I
>will look into this to provide better justification.

Great, thanks.

Maybe we can also ping VMCI maintainers to understand if they can switch 
to sock_queue_rcv_skb(). But we should understand better the difference.

Thanks,
Stefano


