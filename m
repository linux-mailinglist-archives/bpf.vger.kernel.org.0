Return-Path: <bpf+bounces-36046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89050940ABB
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 10:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84B4B21ACD
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 08:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621C01922CA;
	Tue, 30 Jul 2024 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jy5eDPnh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA02188CBD
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326762; cv=none; b=FdMRov84Z+WjzIXZaarsC265zCfBw3I1JM47h0IsMGeRnBJsFrT14kOoiK7A8KHV0NkVFZHZ//MPcFLNI5hTw/gYdo60l196PQEQgU362fKnNaltB5w7G+ZuhetbW7B94S1UlbBH3rtc0iEmtj7DlqE3TtNeByC2wK9aYg9oRJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326762; c=relaxed/simple;
	bh=pimUNZNB2gtc5f7DgOK9I9O4tl9OPttYxcjsdaqFCOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rF6/ogT4EYP09oG4VLwc9C2nVpzVGCpZwueJnz2sO/TttbQq87b/aMrky31cgMNefgUfA65jmntjvfVZWofdA8uNUju0lS43PkHk4oDdeT1HE95frTKBd90AxVXVq94cV7SBXjFkMUVedlSoXIp9kGuCBt07tukDyFtBJbYoi1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jy5eDPnh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722326759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eh8EZF73LnG+wG1L4uQeusfNtosd8JnNoUVpYATm/E=;
	b=Jy5eDPnhWYWnRFSZ3fS9iPk89A7oKTdhvKiH8EOtf9Z7G/q9QTwMgliQWCqwYvXyCyh8FK
	GWaF6C0/jclJDKnmsYSHmvAOtZMnvHMnCOcpEUnOE05JnNOdQsBDTFXO8IR79/zjlX/ORm
	RsxHUnSWBeo84oebskRtHkeT631GbrA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-MtVBwhVXN16TpvgKiIBTwg-1; Tue, 30 Jul 2024 04:05:58 -0400
X-MC-Unique: MtVBwhVXN16TpvgKiIBTwg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36875698d0dso2012308f8f.3
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 01:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722326757; x=1722931557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9eh8EZF73LnG+wG1L4uQeusfNtosd8JnNoUVpYATm/E=;
        b=QbI14O7tf+3n7JUSYiQw9ZU3E2cH9NDs9Ydcymf2Yma0EK+6EmV/rnNK0yfHT5520r
         rOT/s4slZRALVwICtGYMHzEUm8s6G92p7G26Pnf6NhlGAIsxpCubB7IPpkZLsugqTNIY
         ZsJTT4OHAuwgzTQimgRhLj6zswoBfkigaWnXBexOB6zu3BJuvjbJiNkZq8ACIk2n+8DJ
         SJD4h2tw/+iQZAvJiIDmmXkyNJ3Hvo8YC4w77/E6ozruPBI723W73MAhIJsq27APpKw9
         NPYTmzrtx/IPcPl7uGSQ513If62HHATep6Mz+0w/NqMC5rLQJnNo+X2bJwdS7hrj8SLF
         qKZA==
X-Forwarded-Encrypted: i=1; AJvYcCXuy9uyBNhEaw63AehJc2R5GRHOx1h1yUGrGG2DAY7kzdkN1G8adliIxt7NX4+uAKY0Jlwpi1ghtmNbUlH8e2C2tfwJ
X-Gm-Message-State: AOJu0YwfjjeMb/QT4oKnxulHsdWGcEiEYwpRVLmSLf/A9n2t/DA0uP92
	RStqripOj7csTSPot8ZiVi4/gmXnUITTkXJPIq/xmCZOERTr6tSTifQFhWn0pNZPeR/s+t5GVvp
	FRjGUM3vPQ+4WtgjwFKqRC5gpDNP3ibIAZZ60HuvOD1qERHL4NQ==
X-Received: by 2002:adf:e743:0:b0:368:71fa:7532 with SMTP id ffacd0b85a97d-36b5d03d47emr5868790f8f.31.1722326756680;
        Tue, 30 Jul 2024 01:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVMcf3I278ckQcEneUi+srZQULTonJGRRhlMeHi0/D0JUXQfm+ZqCL8Q22Lapx7Ip82TdYYQ==
X-Received: by 2002:adf:e743:0:b0:368:71fa:7532 with SMTP id ffacd0b85a97d-36b5d03d47emr5868755f8f.31.1722326755759;
        Tue, 30 Jul 2024 01:05:55 -0700 (PDT)
Received: from sgarzare-redhat ([62.205.9.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0320sm14032984f8f.19.2024.07.30.01.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 01:05:54 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:05:47 +0200
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
Subject: Re: [RFC PATCH net-next v6 05/14] af_vsock: use a separate dgram
 bind table
Message-ID: <luie6pznvmhige4qti64ka6dgvekzpmrmmnk3naocfwj6sqvu4@wwspdc4tqced>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-6-amery.hung@bytedance.com>
 <pghfa4vh7vb7sggelop5asuyj6bqtq4rbgm2q3bdslcoeicihj@6arcanemghjo>
 <CAMB2axNL_O3Twksi+ROUz0B298A-xQ_EYsgYzc2jLRbpikrdJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axNL_O3Twksi+ROUz0B298A-xQ_EYsgYzc2jLRbpikrdJQ@mail.gmail.com>

On Sun, Jul 28, 2024 at 02:37:24PM GMT, Amery Hung wrote:
>On Tue, Jul 23, 2024 at 7:41 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Wed, Jul 10, 2024 at 09:25:46PM GMT, Amery Hung wrote:
>> >From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> >
>> >This commit adds support for bound dgram sockets to be tracked in a
>> >separate bind table from connectible sockets in order to avoid address
>> >collisions. With this commit, users can simultaneously bind a dgram
>> >socket and connectible socket to the same CID and port.
>> >
>> >Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> >---
>> > net/vmw_vsock/af_vsock.c | 103 +++++++++++++++++++++++++++++----------
>> > 1 file changed, 76 insertions(+), 27 deletions(-)
>> >
>> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> >index d571be9cdbf0..ab08cd81720e 100644
>> >--- a/net/vmw_vsock/af_vsock.c
>> >+++ b/net/vmw_vsock/af_vsock.c
>> >@@ -10,18 +10,23 @@
>> >  * - There are two kinds of sockets: those created by user action (such as
>> >  * calling socket(2)) and those created by incoming connection request packets.
>> >  *
>> >- * - There are two "global" tables, one for bound sockets (sockets that have
>> >- * specified an address that they are responsible for) and one for connected
>> >- * sockets (sockets that have established a connection with another socket).
>> >- * These tables are "global" in that all sockets on the system are placed
>> >- * within them. - Note, though, that the bound table contains an extra entry
>> >- * for a list of unbound sockets and SOCK_DGRAM sockets will always remain in
>> >- * that list. The bound table is used solely for lookup of sockets when packets
>> >- * are received and that's not necessary for SOCK_DGRAM sockets since we create
>> >- * a datagram handle for each and need not perform a lookup.  Keeping SOCK_DGRAM
>> >- * sockets out of the bound hash buckets will reduce the chance of collisions
>> >- * when looking for SOCK_STREAM sockets and prevents us from having to check the
>> >- * socket type in the hash table lookups.
>> >+ * - There are three "global" tables, one for bound connectible (stream /
>> >+ * seqpacket) sockets, one for bound datagram sockets, and one for connected
>> >+ * sockets. Bound sockets are sockets that have specified an address that
>> >+ * they are responsible for. Connected sockets are sockets that have
>> >+ * established a connection with another socket. These tables are "global" in
>> >+ * that all sockets on the system are placed within them. - Note, though,
>> >+ * that the bound tables contain an extra entry for a list of unbound
>> >+ * sockets. The bound tables are used solely for lookup of sockets when packets
>> >+ * are received.
>> >+ *
>> >+ * - There are separate bind tables for connectible and datagram sockets to avoid
>> >+ * address collisions between stream/seqpacket sockets and datagram sockets.
>> >+ *
>> >+ * - Transports may elect to NOT use the global datagram bind table by
>> >+ * implementing the ->dgram_bind() callback. If that callback is implemented,
>> >+ * the global bind table is not used and the responsibility of bound datagram
>> >+ * socket tracking is deferred to the transport.
>> >  *
>> >  * - Sockets created by user action will either be "client" sockets that
>> >  * initiate a connection or "server" sockets that listen for connections; we do
>> >@@ -116,6 +121,7 @@
>> > static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
>> > static void vsock_sk_destruct(struct sock *sk);
>> > static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
>> >+static bool sock_type_connectible(u16 type);
>> >
>> > /* Protocol family. */
>> > struct proto vsock_proto = {
>> >@@ -152,21 +158,25 @@ static DEFINE_MUTEX(vsock_register_mutex);
>> >  * VSocket is stored in the connected hash table.
>> >  *
>> >  * Unbound sockets are all put on the same list attached to the end of the hash
>> >- * table (vsock_unbound_sockets).  Bound sockets are added to the hash table in
>> >- * the bucket that their local address hashes to (vsock_bound_sockets(addr)
>> >- * represents the list that addr hashes to).
>> >+ * tables (vsock_unbound_sockets/vsock_unbound_dgram_sockets).  Bound sockets
>> >+ * are added to the hash table in the bucket that their local address hashes to
>> >+ * (vsock_bound_sockets(addr) and vsock_bound_dgram_sockets(addr) represents
>> >+ * the list that addr hashes to).
>> >  *
>> >- * Specifically, we initialize the vsock_bind_table array to a size of
>> >- * VSOCK_HASH_SIZE + 1 so that vsock_bind_table[0] through
>> >- * vsock_bind_table[VSOCK_HASH_SIZE - 1] are for bound sockets and
>> >- * vsock_bind_table[VSOCK_HASH_SIZE] is for unbound sockets.  The hash function
>> >- * mods with VSOCK_HASH_SIZE to ensure this.
>> >+ * Specifically, taking connectible sockets as an example we initialize the
>> >+ * vsock_bind_table array to a size of VSOCK_HASH_SIZE + 1 so that
>> >+ * vsock_bind_table[0] through vsock_bind_table[VSOCK_HASH_SIZE - 1] are for
>> >+ * bound sockets and vsock_bind_table[VSOCK_HASH_SIZE] is for unbound sockets.
>> >+ * The hash function mods with VSOCK_HASH_SIZE to ensure this.
>> >+ * Datagrams and vsock_dgram_bind_table operate in the same way.
>> >  */
>> > #define MAX_PORT_RETRIES        24
>> >
>> > #define VSOCK_HASH(addr)        ((addr)->svm_port % VSOCK_HASH_SIZE)
>> > #define vsock_bound_sockets(addr) (&vsock_bind_table[VSOCK_HASH(addr)])
>> >+#define vsock_bound_dgram_sockets(addr) (&vsock_dgram_bind_table[VSOCK_HASH(addr)])
>> > #define vsock_unbound_sockets     (&vsock_bind_table[VSOCK_HASH_SIZE])
>> >+#define vsock_unbound_dgram_sockets     (&vsock_dgram_bind_table[VSOCK_HASH_SIZE])
>> >
>> > /* XXX This can probably be implemented in a better way. */
>> > #define VSOCK_CONN_HASH(src, dst)                             \
>> >@@ -182,6 +192,8 @@ struct list_head vsock_connected_table[VSOCK_HASH_SIZE];
>> > EXPORT_SYMBOL_GPL(vsock_connected_table);
>> > DEFINE_SPINLOCK(vsock_table_lock);
>> > EXPORT_SYMBOL_GPL(vsock_table_lock);
>> >+static struct list_head vsock_dgram_bind_table[VSOCK_HASH_SIZE + 1];
>> >+static DEFINE_SPINLOCK(vsock_dgram_table_lock);
>> >
>> > /* Autobind this socket to the local address if necessary. */
>> > static int vsock_auto_bind(struct vsock_sock *vsk)
>> >@@ -204,6 +216,9 @@ static void vsock_init_tables(void)
>> >
>> >       for (i = 0; i < ARRAY_SIZE(vsock_connected_table); i++)
>> >               INIT_LIST_HEAD(&vsock_connected_table[i]);
>> >+
>> >+      for (i = 0; i < ARRAY_SIZE(vsock_dgram_bind_table); i++)
>> >+              INIT_LIST_HEAD(&vsock_dgram_bind_table[i]);
>> > }
>> >
>> > static void __vsock_insert_bound(struct list_head *list,
>> >@@ -271,13 +286,28 @@ static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
>> >       return NULL;
>> > }
>> >
>> >-static void vsock_insert_unbound(struct vsock_sock *vsk)
>> >+static void __vsock_insert_dgram_unbound(struct vsock_sock *vsk)
>> >+{
>> >+      spin_lock_bh(&vsock_dgram_table_lock);
>> >+      __vsock_insert_bound(vsock_unbound_dgram_sockets, vsk);
>> >+      spin_unlock_bh(&vsock_dgram_table_lock);
>> >+}
>> >+
>> >+static void __vsock_insert_connectible_unbound(struct vsock_sock *vsk)
>> > {
>> >       spin_lock_bh(&vsock_table_lock);
>> >       __vsock_insert_bound(vsock_unbound_sockets, vsk);
>> >       spin_unlock_bh(&vsock_table_lock);
>> > }
>> >
>> >+static void vsock_insert_unbound(struct vsock_sock *vsk)
>> >+{
>> >+      if (sock_type_connectible(sk_vsock(vsk)->sk_type))
>> >+              __vsock_insert_connectible_unbound(vsk);
>> >+      else
>> >+              __vsock_insert_dgram_unbound(vsk);
>> >+}
>> >+
>> > void vsock_insert_connected(struct vsock_sock *vsk)
>> > {
>> >       struct list_head *list = vsock_connected_sockets(
>> >@@ -289,6 +319,14 @@ void vsock_insert_connected(struct vsock_sock *vsk)
>> > }
>> > EXPORT_SYMBOL_GPL(vsock_insert_connected);
>> >
>> >+static void vsock_remove_dgram_bound(struct vsock_sock *vsk)
>> >+{
>> >+      spin_lock_bh(&vsock_dgram_table_lock);
>> >+      if (__vsock_in_bound_table(vsk))
>> >+              __vsock_remove_bound(vsk);
>> >+      spin_unlock_bh(&vsock_dgram_table_lock);
>> >+}
>> >+
>> > void vsock_remove_bound(struct vsock_sock *vsk)
>> > {
>> >       spin_lock_bh(&vsock_table_lock);
>> >@@ -340,7 +378,10 @@ EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
>> >
>> > void vsock_remove_sock(struct vsock_sock *vsk)
>> > {
>> >-      vsock_remove_bound(vsk);
>> >+      if (sock_type_connectible(sk_vsock(vsk)->sk_type))
>> >+              vsock_remove_bound(vsk);
>> >+      else
>> >+              vsock_remove_dgram_bound(vsk);
>>
>> Can we try to be consistent, for example we have vsock_insert_unbound()
>> which calls internally sock_type_connectible(), while
>> vsock_remove_bound() is just for connectible sockets. It's a bit
>> confusing.
>
>I agree with you. I will make the style more consistent by keeping
>vsock_insert_unbound() only work on connectible sockets.

Maybe I would have done the opposite, making vsock_remove_bound() usable 
on all sockets. But I haven't really looked at whether that's feasible 
or not.

>
>>
>> >       vsock_remove_connected(vsk);
>> > }
>> > EXPORT_SYMBOL_GPL(vsock_remove_sock);
>> >@@ -746,11 +787,19 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>> >       return vsock_bind_common(vsk, addr, vsock_bind_table, VSOCK_HASH_SIZE + 1);
>> > }
>> >
>> >-static int __vsock_bind_dgram(struct vsock_sock *vsk,
>> >-                            struct sockaddr_vm *addr)
>> >+static int vsock_bind_dgram(struct vsock_sock *vsk,
>> >+                          struct sockaddr_vm *addr)
>>
>> Why we are renaming this?
>
>I will keep the original __vsock_bind_dgram() for consistency.
>
>>
>> > {
>> >-      if (!vsk->transport || !vsk->transport->dgram_bind)
>> >-              return -EINVAL;
>> >+      if (!vsk->transport || !vsk->transport->dgram_bind) {
>>
>> Why this condition?
>>
>> Maybe a comment here is needed because I'm lost...
>
>We currently use !vsk->transport->dgram_bind to determine if this is
>VMCI dgram transport. Will add a comment explaining this.

Thanks, what's not clear to me is why before this series we returned an 
error, whereas now we call vsock_bind_common().

Thanks,
Stefano

>
>>
>> >+              int retval;
>> >+
>> >+              spin_lock_bh(&vsock_dgram_table_lock);
>> >+              retval = vsock_bind_common(vsk, addr, vsock_dgram_bind_table,
>> >+                                         VSOCK_HASH_SIZE);
>>
>> Should we use VSOCK_HASH_SIZE + 1 here?
>>
>> Using ARRAY_SIZE(x) should avoid this problem.
>
>Yes. The size here is wrong. I will remove the size check (the
>discussion is in patch 4).
>
>Thanks,
>Amery
>
>
>
>>
>>
>> >+              spin_unlock_bh(&vsock_dgram_table_lock);
>> >+
>> >+              return retval;
>> >+      }
>> >
>> >       return vsk->transport->dgram_bind(vsk, addr);
>> > }
>> >@@ -781,7 +830,7 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
>> >               break;
>> >
>> >       case SOCK_DGRAM:
>> >-              retval = __vsock_bind_dgram(vsk, addr);
>> >+              retval = vsock_bind_dgram(vsk, addr);
>> >               break;
>> >
>> >       default:
>> >--
>> >2.20.1
>> >
>>
>


