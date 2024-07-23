Return-Path: <bpf+bounces-35396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CA793A30F
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 16:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095241F2450F
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 14:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465CA15665E;
	Tue, 23 Jul 2024 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQdxVsZo"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB85155A57
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745774; cv=none; b=sxygyFL72eVv2oa0neiBM6ahLWBwReu7aEvfNhdG43miAz91/DhrRsMm7Eh0/V1sF9+yUVagRerzAsvp1BhMEM34cwXEg6MDsbjBiNyoohbvjRx8YxMKih7mDJQ+GGYzsx+/WMKA8ry1gRHrIe69gH5IrXYhkci8arbES/6YSfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745774; c=relaxed/simple;
	bh=qZhTX/IgIUg6BT0VgZ6WczKfnOo25gAfQcqh/GYy3ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tbq5kL4rDu+1whyVtpRrK6H9RV0RGEuZcnIPNkmj+wr4F8pM3j8diz3DVkxizU0BtIFEya2DufVFsb28QaSxVKx4zoFniJjCAMrMJZlNwgxlhQQdTbWcmFmM7eHF919bpjPVmYiZXeB7/AuUrxcp8jP4a9aVJQe0YwWPB+klsQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQdxVsZo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721745772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kigYZguNz00xoX93FOHHu8yNXn/AsLuk79NqjKnJxAU=;
	b=OQdxVsZo/cJd/IKrLuDXokt0V74l7ICiUbacBJdACBbzgRzVBcZUzl+J5VuG9RjWQt0AbC
	Fle+x/J1qbrupgTvOQa2WW4F2sJ63oeZtkNyjQbSZb++9g2/eig5kiKL2mbnIE4AnU8h4W
	SYAWSpg5d4isWhGMJhWhfou2R7lYSQg=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-ct-D1S3uNjuc5kFzYWsE4g-1; Tue, 23 Jul 2024 10:42:48 -0400
X-MC-Unique: ct-D1S3uNjuc5kFzYWsE4g-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4929c8fd8e8so1470171137.0
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 07:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745768; x=1722350568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kigYZguNz00xoX93FOHHu8yNXn/AsLuk79NqjKnJxAU=;
        b=WEWTogQcCSx3N72hqVtqbZdbGXHyU6+gqMOSxfUIVk8w0oRnGo5VEjNBJ85S/mPyXR
         gyLtZkeCVDZfj4mGV3EYB4+tQGEJGFHLD6shCMF29acZShhtxBrCTttBfdCLC0e1dIqP
         ho0IL1m3NpoGkUKTmpotR22BbEHnPQemzn/kYs7EruUNeirtz3LkkKeqHVCGru0NNkCt
         /Eco91NMt6fpFP0bfTtg+iCjQkknlgsFJh1ffEhEyeqAWfWnnm5DmImiR75Ftp3nTlfW
         Q/VLS4MsznPoFujgVzur1SiBrmvAP0zErbUdtwbzEs3cJon4XFXlI8TK5zF6McDOhihv
         9RXw==
X-Forwarded-Encrypted: i=1; AJvYcCXyxSaceMKY42bHLwKux4Rs4B2Ky/ITiiX7azNXr007bBVa89YXwM/OWTiWlUGI21hCGTAJDWgT1F6jSnvTY90gGHBu
X-Gm-Message-State: AOJu0YzXogu1xBLdCVgGri8ToQdWNJIOGV8j9eXEp5nOcPQPEkZ3uU51
	pAr1htwCf72/r3A/s6z5WV7OpC2A8G4cL5DP4T/jIrZXAJe3IXvvEPn10Z3uA0CcwMZWbYaPfMR
	zGU4yml28+cSsEjP2mcKP6BBJNHj9zcru70uphZJjFkroni0L8Q==
X-Received: by 2002:a05:6102:2b9b:b0:493:bc65:5a79 with SMTP id ada2fe7eead31-493bc656634mr1342074137.12.1721745767770;
        Tue, 23 Jul 2024 07:42:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvA8ILvkRXBvaTkEfGkpX8GjLXDaXC7zxeV7o84Dn/7uFv11tWUxV/m81omp3h3MPctGhVsg==
X-Received: by 2002:a05:6102:2b9b:b0:493:bc65:5a79 with SMTP id ada2fe7eead31-493bc656634mr1342024137.12.1721745767284;
        Tue, 23 Jul 2024 07:42:47 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19905a721sm485491585a.93.2024.07.23.07.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:42:46 -0700 (PDT)
Date: Tue, 23 Jul 2024 16:42:41 +0200
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
Message-ID: <ldyfzp5k2qmhlydflu7biz6bcrekothacitzgbmw2k264zwuxh@hmgoku5kgghp>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-10-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240710212555.1617795-10-amery.hung@bytedance.com>

On Wed, Jul 10, 2024 at 09:25:50PM GMT, Amery Hung wrote:
>From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>This commit adds the common datagram receive functionality for virtio
>transports. It does not add the vhost/virtio users of that
>functionality.
>
>This functionality includes:
>- changes to the virtio_transport_recv_pkt() path for finding the
>  bound socket receiver for incoming packets
>- virtio_transport_recv_pkt() saves the source cid and port to the
>  control buffer for recvmsg() to initialize sockaddr_vm structure
>  when using datagram
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Signed-off-by: Amery Hung <amery.hung@bytedance.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 79 +++++++++++++++++++++----
> 1 file changed, 66 insertions(+), 13 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 46cd1807f8e3..a571b575fde9 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -235,7 +235,9 @@ EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);
>
> static u16 virtio_transport_get_type(struct sock *sk)
> {
>-	if (sk->sk_type == SOCK_STREAM)
>+	if (sk->sk_type == SOCK_DGRAM)
>+		return VIRTIO_VSOCK_TYPE_DGRAM;
>+	else if (sk->sk_type == SOCK_STREAM)
> 		return VIRTIO_VSOCK_TYPE_STREAM;
> 	else
> 		return VIRTIO_VSOCK_TYPE_SEQPACKET;
>@@ -1422,6 +1424,33 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 		kfree_skb(skb);
> }
>
>+static void
>+virtio_transport_dgram_kfree_skb(struct sk_buff *skb, int err)
>+{
>+	if (err == -ENOMEM)
>+		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_RCVBUFF);
>+	else if (err == -ENOBUFS)
>+		kfree_skb_reason(skb, SKB_DROP_REASON_PROTO_MEM);
>+	else
>+		kfree_skb(skb);
>+}
>+
>+/* This function takes ownership of the skb.
>+ *
>+ * It either places the skb on the sk_receive_queue or frees it.
>+ */
>+static void
>+virtio_transport_recv_dgram(struct sock *sk, struct sk_buff *skb)
>+{
>+	int err;
>+
>+	err = sock_queue_rcv_skb(sk, skb);
>+	if (err) {
>+		virtio_transport_dgram_kfree_skb(skb, err);
>+		return;
>+	}
>+}
>+
> static int
> virtio_transport_recv_connected(struct sock *sk,
> 				struct sk_buff *skb)
>@@ -1591,7 +1620,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> static bool virtio_transport_valid_type(u16 type)
> {
> 	return (type == VIRTIO_VSOCK_TYPE_STREAM) ||
>-	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
>+	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET) ||
>+	       (type == VIRTIO_VSOCK_TYPE_DGRAM);
> }
>
> /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>@@ -1601,44 +1631,57 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 			       struct sk_buff *skb)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>+	struct vsock_skb_cb *vsock_cb;

This can be defined in the block where it's used.

> 	struct sockaddr_vm src, dst;
> 	struct vsock_sock *vsk;
> 	struct sock *sk;
> 	bool space_available;
>+	u16 type;
>
> 	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> 			le32_to_cpu(hdr->src_port));
> 	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> 			le32_to_cpu(hdr->dst_port));
>
>+	type = le16_to_cpu(hdr->type);
>+
> 	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> 					dst.svm_cid, dst.svm_port,
> 					le32_to_cpu(hdr->len),
>-					le16_to_cpu(hdr->type),
>+					type,
> 					le16_to_cpu(hdr->op),
> 					le32_to_cpu(hdr->flags),
> 					le32_to_cpu(hdr->buf_alloc),
> 					le32_to_cpu(hdr->fwd_cnt));
>
>-	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
>+	if (!virtio_transport_valid_type(type)) {
> 		(void)virtio_transport_reset_no_sock(t, skb);
> 		goto free_pkt;
> 	}
>
>-	/* The socket must be in connected or bound table
>-	 * otherwise send reset back
>+	/* For stream/seqpacket, the socket must be in connected or bound table
>+	 * otherwise send reset back.
>+	 *
>+	 * For datagrams, no reset is sent back.
> 	 */
> 	sk = vsock_find_connected_socket(&src, &dst);
> 	if (!sk) {
>-		sk = vsock_find_bound_socket(&dst);
>-		if (!sk) {
>-			(void)virtio_transport_reset_no_sock(t, skb);
>-			goto free_pkt;
>+		if (type == VIRTIO_VSOCK_TYPE_DGRAM) {
>+			sk = vsock_find_bound_dgram_socket(&dst);
>+			if (!sk)
>+				goto free_pkt;
>+		} else {
>+			sk = vsock_find_bound_socket(&dst);
>+			if (!sk) {
>+				(void)virtio_transport_reset_no_sock(t, skb);
>+				goto free_pkt;
>+			}
> 		}
> 	}
>
>-	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
>-		(void)virtio_transport_reset_no_sock(t, skb);
>+	if (virtio_transport_get_type(sk) != type) {
>+		if (type != VIRTIO_VSOCK_TYPE_DGRAM)
>+			(void)virtio_transport_reset_no_sock(t, skb);
> 		sock_put(sk);
> 		goto free_pkt;
> 	}
>@@ -1654,12 +1697,21 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>
> 	/* Check if sk has been closed before lock_sock */
> 	if (sock_flag(sk, SOCK_DONE)) {
>-		(void)virtio_transport_reset_no_sock(t, skb);
>+		if (type != VIRTIO_VSOCK_TYPE_DGRAM)
>+			(void)virtio_transport_reset_no_sock(t, skb);
> 		release_sock(sk);
> 		sock_put(sk);
> 		goto free_pkt;
> 	}
>
>+	if (sk->sk_type == SOCK_DGRAM) {
>+		vsock_cb = vsock_skb_cb(skb);
>+		vsock_cb->src_cid = src.svm_cid;
>+		vsock_cb->src_port = src.svm_port;
>+		virtio_transport_recv_dgram(sk, skb);


What about adding an API that transports can use to hide this?

I mean something that hide vsock_cb creation and queue packet in the 
socket receive queue. I'd also not expose vsock_skb_cb in an header, but 
I'd handle it internally in af_vsock.c. So I'd just expose API to 
queue/dequeue them.

Also why VMCI is using sk_receive_skb(), while we are using 
sock_queue_rcv_skb()?

Thanks,
Stefano

>+		goto out;
>+	}
>+
> 	space_available = virtio_transport_space_update(sk, skb);
>
> 	/* Update CID in case it has changed after a transport reset event */
>@@ -1691,6 +1743,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 		break;
> 	}
>
>+out:
> 	release_sock(sk);
>
> 	/* Release refcnt obtained when we fetched this socket out of the
>-- 
>2.20.1
>


