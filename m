Return-Path: <bpf+bounces-36045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CF9940A9F
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 10:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBA62858E2
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 08:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40C9193065;
	Tue, 30 Jul 2024 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHUnyPR5"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B331A12F5B3
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326436; cv=none; b=QsthvmObIGtef4awJefSJAeeXNaUQu52bfEmRTnI2lA3w2AP3ax7LZSegWmpntAEiGYnHe86UlZCqrl9alkJsizcr93D3EutWL0bOcYLtPcHQiHHe488rAbG/7sDmVwlDDhKsZE8F6sdvUGHCGZGvOQiStzuEifO+TIm5Ufycyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326436; c=relaxed/simple;
	bh=trwZ6o7rehpDaqVsUVCfcq0HbmYKcWR5iz0dYHW4Jrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBPzRWB9Mr7U1GLDAFlBgZzgPuGdDnno6QRDFnhg0cHNDLTIROwqYM2abPkj6K0aJ9D/BIi0MvCfA1UMBIO3mPWa1j5S9KS9AGFpwoNkk2cnZHvuDJHRuweg0q5NWDS0Ul8jd0wDmhv17rP+58PuJuEskrNMa2dXDNAOnvWivkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHUnyPR5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722326433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxacbdL3FJeAXrV3TFbvw9W3EhUwqie1OGKtk+yVIvU=;
	b=OHUnyPR5tUrIx9f43PlTJSWq7kTZuVh9nneo6/R/miyZRfIWIEGNAwHmGBHrGwdwdQc6Ti
	JgyTZkBQkaCYE/Bt+THW9lNtnegz4TDZZqrDLc7U/eF6tAo1LsiM0ZR/bv02hvdZukGO07
	2kcTZlAwdtAEbsEjZn9ILToZtB3UGL0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-Vh-kBGM8OZis221XvsYufQ-1; Tue, 30 Jul 2024 04:00:32 -0400
X-MC-Unique: Vh-kBGM8OZis221XvsYufQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4281b7196bbso17255235e9.0
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 01:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722326431; x=1722931231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxacbdL3FJeAXrV3TFbvw9W3EhUwqie1OGKtk+yVIvU=;
        b=mfBvuynv9N8p1awfVl45Ro3KdBtRbgdWFO0BZVpZ6KYmschb783HuducGsJIvTu9BJ
         Q8BxLhV0PkFPhZAIxBPKp6ntwg0q6IcP1tshuueTMMbe+Luzu6K/U97cuk3azhMmwDqq
         rJpD62ODjR32BEuJ2RwutbYv917HoqplsiUbPkVJZfpVSbMSMbjeeXRGdYVuCeN9mYrr
         XccbQzEwC916uJVYGRY+1LKg0kgGg/fUBkqjsd30jFX2OPZ7eF6BHfmWmc5Ii1CprIha
         E7gb8/mJcGr0JsIrSiFmAeIJK6BxL9Z1g2K22XcyRHD3Ejd+QnRhqigT7gh/7j1DQsfX
         EqYw==
X-Forwarded-Encrypted: i=1; AJvYcCW/M3W32mPyTR7QWlxct9RuDfEmysKROQniG7WGfG3F9g7E9wAg1zdz1XGLKu5ChE4M+V7mXtagBFZWFZHsgKD+73KR
X-Gm-Message-State: AOJu0Yzlm9v1AWl8e2qATYWkO+X5gP/4h5nGoNkEqlT4UdiYeT53qlio
	q/7Z23mXzD6i6XnmJg0PJ1ZVXl+5p6SCIK8E6DLWOMWT9jZIDpHAhHitOIduNPtXbtT7Y/56TEv
	8cN3ATlY59A2msjICns3/E9iOdKMxn3R0g8/7PWTkT6mopWHLOQ==
X-Received: by 2002:a05:600c:1c83:b0:426:622d:9e6b with SMTP id 5b1f17b1804b1-42811dd79fbmr66277015e9.23.1722326430691;
        Tue, 30 Jul 2024 01:00:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOWCFqW/SaDwkVD/PGge9k+/l+vMiylzg43IopSMzOrTgQOVgmPKCvBcKQbTb1kZSxSstYJw==
X-Received: by 2002:a05:600c:1c83:b0:426:622d:9e6b with SMTP id 5b1f17b1804b1-42811dd79fbmr66276385e9.23.1722326429913;
        Tue, 30 Jul 2024 01:00:29 -0700 (PDT)
Received: from sgarzare-redhat ([62.205.9.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857e3bsm13973574f8f.81.2024.07.30.01.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 01:00:28 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:00:25 +0200
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
Subject: Re: [RFC PATCH net-next v6 04/14] af_vsock: generalize bind table
 functions
Message-ID: <ba2hivznnjcyeftr7ch7gvrwjvkimx5u2t2anv7wv7n7yb3j36@dbagnaylvu6o>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-5-amery.hung@bytedance.com>
 <CAGxU2F7wCUR-KhDRBopK+0gv=bM0PCKeWM87j1vEYmbvhO8WHQ@mail.gmail.com>
 <CAMB2axNUZa221WKTjLt0G5KNdtkAbm20ViDZRGBh6pL9y3wosg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axNUZa221WKTjLt0G5KNdtkAbm20ViDZRGBh6pL9y3wosg@mail.gmail.com>

On Sun, Jul 28, 2024 at 11:52:54AM GMT, Amery Hung wrote:
>On Tue, Jul 23, 2024 at 7:40 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Wed, Jul 10, 2024 at 09:25:45PM GMT, Amery Hung wrote:
>> >From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> >
>> >This commit makes the bind table management functions in vsock usable
>> >for different bind tables. Future work will introduce a new table for
>> >datagrams to avoid address collisions, and these functions will be used
>> >there.
>> >
>> >Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> >---
>> > net/vmw_vsock/af_vsock.c | 34 +++++++++++++++++++++++++++-------
>> > 1 file changed, 27 insertions(+), 7 deletions(-)
>> >
>> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> >index acc15e11700c..d571be9cdbf0 100644
>> >--- a/net/vmw_vsock/af_vsock.c
>> >+++ b/net/vmw_vsock/af_vsock.c
>> >@@ -232,11 +232,12 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
>> >       sock_put(&vsk->sk);
>> > }
>> >
>> >-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>> >+static struct sock *vsock_find_bound_socket_common(struct sockaddr_vm *addr,
>> >+                                                 struct list_head *bind_table)
>> > {
>> >       struct vsock_sock *vsk;
>> >
>> >-      list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
>> >+      list_for_each_entry(vsk, bind_table, bound_table) {
>> >               if (vsock_addr_equals_addr(addr, &vsk->local_addr))
>> >                       return sk_vsock(vsk);
>> >
>> >@@ -249,6 +250,11 @@ static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>> >       return NULL;
>> > }
>> >
>> >+static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>> >+{
>> >+      return vsock_find_bound_socket_common(addr, vsock_bound_sockets(addr));
>> >+}
>> >+
>> > static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
>> >                                                 struct sockaddr_vm *dst)
>> > {
>> >@@ -671,12 +677,18 @@ static void vsock_pending_work(struct work_struct *work)
>> >
>> > /**** SOCKET OPERATIONS ****/
>> >
>> >-static int __vsock_bind_connectible(struct vsock_sock *vsk,
>> >-                                  struct sockaddr_vm *addr)
>> >+static int vsock_bind_common(struct vsock_sock *vsk,
>> >+                           struct sockaddr_vm *addr,
>> >+                           struct list_head *bind_table,
>> >+                           size_t table_size)
>> > {
>> >       static u32 port;
>> >       struct sockaddr_vm new_addr;
>> >
>> >+      if (WARN_ONCE(table_size < VSOCK_HASH_SIZE,
>> >+                    "table size too small, may cause overflow"))
>> >+              return -EINVAL;
>> >+
>>
>> I'd add this in another commit.
>>
>> >       if (!port)
>> >               port = get_random_u32_above(LAST_RESERVED_PORT);
>> >
>> >@@ -692,7 +704,8 @@ static int __vsock_bind_connectible(struct
>> >vsock_sock *vsk,
>> >
>> >                       new_addr.svm_port = port++;
>> >
>> >-                      if (!__vsock_find_bound_socket(&new_addr)) {
>> >+                      if (!vsock_find_bound_socket_common(&new_addr,
>> >+                                                          &bind_table[VSOCK_HASH(addr)])) {
>>
>> Can we add a macro for `&bind_table[VSOCK_HASH(addr)])` ?
>>
>
>Definitely. I will add the following macro:
>
>#define vsock_bound_sockets_in_table(bind_table, addr) \
>        (&bind_table[VSOCK_HASH(addr)])

yeah.

>
>> >                               found = true;
>> >                               break;
>> >                       }
>> >@@ -709,7 +722,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>> >                       return -EACCES;
>> >               }
>> >
>> >-              if (__vsock_find_bound_socket(&new_addr))
>> >+              if (vsock_find_bound_socket_common(&new_addr,
>> >+                                                 &bind_table[VSOCK_HASH(addr)]))
>> >                       return -EADDRINUSE;
>> >       }
>> >
>> >@@ -721,11 +735,17 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>> >        * by AF_UNIX.
>> >        */
>> >       __vsock_remove_bound(vsk);
>> >-      __vsock_insert_bound(vsock_bound_sockets(&vsk->local_addr), vsk);
>> >+      __vsock_insert_bound(&bind_table[VSOCK_HASH(&vsk->local_addr)], vsk);
>> >
>> >       return 0;
>> > }
>> >
>> >+static int __vsock_bind_connectible(struct vsock_sock *vsk,
>> >+                                  struct sockaddr_vm *addr)
>> >+{
>> >+      return vsock_bind_common(vsk, addr, vsock_bind_table, VSOCK_HASH_SIZE + 1);
>>
>> What about using ARRAY_SIZE(x) ?
>>
>> BTW we are using that size just to check it, but all the arrays we use
>> are statically allocated, so what about a compile time check like
>> BUILD_BUG_ON()?
>>
>
>I will remove the table_size check you mentioned earlier and the
>argument here as the arrays are allocated statically like you
>mentioned.
>
>If you think this check may be a good addition, I can add a
>BUILD_BUG_ON() in the new vsock_bound_sockets_in_table() macro.

If you want to add it, we need to do it in a separate commit. But since 
we already have so many changes and both arrays are statically allocated 
in the same file, IMHO we can avoid the check.

Stefano


