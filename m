Return-Path: <bpf+bounces-3154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BA473A4D4
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 17:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71824281970
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 15:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25E61F948;
	Thu, 22 Jun 2023 15:26:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9019D1F18B
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:26:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DB5211F
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687447574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s9naFD7gfaMNd05hAGGf5tsGc4tvi4lWlW620oNdE7s=;
	b=BpLmVPVRueAFlhssDppFrwQz86V9gMK8zNnvDvV73wtd1EGZM04BvpOBveYMt97mWhq5aL
	Q++BZz5j4ett+CZ2pSxe5c4YHL5WF9TY1zbM6aDPyKd+IuaZtt9kjPOg0K/N1kBmg1EITH
	Vm1mfWE2mn1hRYstMU/yzXhPtTq+D9A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-yAAdqWd1PNG6-ortOxppxQ-1; Thu, 22 Jun 2023 11:26:10 -0400
X-MC-Unique: yAAdqWd1PNG6-ortOxppxQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f9b5cc7298so16810245e9.3
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 08:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687447559; x=1690039559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9naFD7gfaMNd05hAGGf5tsGc4tvi4lWlW620oNdE7s=;
        b=axy8lFEvGzcEpOB43vjbqT8qXcWSEZ579ngsqEKuIxGvtTaKPnKvf3Nqa3yTUTTx9u
         YNUV/UZ5NJmoJaRlmJLg9JL1tYIf5MBtszLrZUxcsbDdk9Gxhku7DnOjgyxnHpb+8aYh
         3BdeZdZfSIv7cdQvV/TtKGpBDotSTGaJVtkL/q7VmRNRroQNcp8n/Aci1pt2MVeaTUnc
         8uIiWFFpiq5MG5PYxGCki70s+HmclbA4vrLmHtlx2NEnkFCfNtPEuqO2KvTmirnrxalO
         bk7/PuaBKKA2pr5zDBf8lu1deZgb8sSnBUnY96fthMXiXN7KBv80AhIYO7Oz/3wQxn/Q
         IPZg==
X-Gm-Message-State: AC+VfDw0s7OOiy4+db1DMrlHr5TGBC53eMIGsLbG/FFtzWS9VUVWuBI6
	8RSk9TX4KxR2D1yumMOTxQ+BN/bwSfPOcp1O8QF0Pwx69gl9ea4GMJSLf/MathBrvwcMtej7Dfe
	2njyCmiFQNcv1
X-Received: by 2002:a7b:cb90:0:b0:3f9:c2f6:335 with SMTP id m16-20020a7bcb90000000b003f9c2f60335mr3570372wmi.36.1687447559670;
        Thu, 22 Jun 2023 08:25:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5yc3YiqgFnTK1MzlExfaEms+r4U/DMqe75/V1PK4F+LuHCCZzMXuAmW0ik7zmWglpxBefjHA==
X-Received: by 2002:a7b:cb90:0:b0:3f9:c2f6:335 with SMTP id m16-20020a7bcb90000000b003f9c2f60335mr3570346wmi.36.1687447559371;
        Thu, 22 Jun 2023 08:25:59 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id n20-20020a1c7214000000b003f8d85b481esm19011755wmc.21.2023.06.22.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:25:58 -0700 (PDT)
Date: Thu, 22 Jun 2023 17:25:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Simon Horman <simon.horman@corigine.com>, Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH RFC net-next v4 4/8] vsock: make vsock bind reusable
Message-ID: <p2tgn3wczd3t3dodyicczetr2nqnqpwcadz6ql5hpvg2cd2dxa@phheksxhxfna>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-4-0cebbb2ae899@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230413-b4-vsock-dgram-v4-4-0cebbb2ae899@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 10, 2023 at 12:58:31AM +0000, Bobby Eshleman wrote:
>This commit makes the bind table management functions in vsock usable
>for different bind tables. For use by datagrams in a future patch.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> net/vmw_vsock/af_vsock.c | 33 ++++++++++++++++++++++++++-------
> 1 file changed, 26 insertions(+), 7 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ef86765f3765..7a3ca4270446 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -230,11 +230,12 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
> 	sock_put(&vsk->sk);
> }
>
>-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>+struct sock *vsock_find_bound_socket_common(struct sockaddr_vm *addr,
>+					    struct list_head *bind_table)
> {
> 	struct vsock_sock *vsk;
>
>-	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
>+	list_for_each_entry(vsk, bind_table, bound_table) {
> 		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
> 			return sk_vsock(vsk);
>
>@@ -247,6 +248,11 @@ static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
> 	return NULL;
> }
>
>+static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>+{
>+	return vsock_find_bound_socket_common(addr, vsock_bound_sockets(addr));
>+}
>+
> static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
> 						  struct sockaddr_vm *dst)
> {
>@@ -646,12 +652,17 @@ static void vsock_pending_work(struct work_struct *work)
>
> /**** SOCKET OPERATIONS ****/
>
>-static int __vsock_bind_connectible(struct vsock_sock *vsk,
>-				    struct sockaddr_vm *addr)
>+static int vsock_bind_common(struct vsock_sock *vsk,
>+			     struct sockaddr_vm *addr,
>+			     struct list_head *bind_table,
>+			     size_t table_size)
> {
> 	static u32 port;
> 	struct sockaddr_vm new_addr;
>
>+	if (table_size < VSOCK_HASH_SIZE)
>+		return -1;

Why we need this check now?

>+
> 	if (!port)
> 		port = get_random_u32_above(LAST_RESERVED_PORT);
>
>@@ -667,7 +678,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>
> 			new_addr.svm_port = port++;
>
>-			if (!__vsock_find_bound_socket(&new_addr)) {
>+			if (!vsock_find_bound_socket_common(&new_addr,
>+							    &bind_table[VSOCK_HASH(addr)])) {
> 				found = true;
> 				break;
> 			}
>@@ -684,7 +696,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
> 			return -EACCES;
> 		}
>
>-		if (__vsock_find_bound_socket(&new_addr))
>+		if (vsock_find_bound_socket_common(&new_addr,
>+						   &bind_table[VSOCK_HASH(addr)]))
> 			return -EADDRINUSE;
> 	}
>
>@@ -696,11 +709,17 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
> 	 * by AF_UNIX.
> 	 */
> 	__vsock_remove_bound(vsk);
>-	__vsock_insert_bound(vsock_bound_sockets(&vsk->local_addr), vsk);
>+	__vsock_insert_bound(&bind_table[VSOCK_HASH(&vsk->local_addr)], vsk);
>
> 	return 0;
> }
>
>+static int __vsock_bind_connectible(struct vsock_sock *vsk,
>+				    struct sockaddr_vm *addr)
>+{
>+	return vsock_bind_common(vsk, addr, vsock_bind_table, VSOCK_HASH_SIZE + 1);
>+}
>+
> static int __vsock_bind_dgram(struct vsock_sock *vsk,
> 			      struct sockaddr_vm *addr)
> {
>
>-- 
>2.30.2
>

The rest seems okay to me, but I agree with Simon's suggestion.

Stefano


