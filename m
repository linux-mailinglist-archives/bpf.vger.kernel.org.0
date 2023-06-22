Return-Path: <bpf+bounces-3165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B06D73A631
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 18:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8081C21193
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8F8200A3;
	Thu, 22 Jun 2023 16:37:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01691F17C
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 16:37:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CC51FC0
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687451869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9JewwlfUhZBK+i/3ORJq58l+o9JnC1L/BGtep803e2U=;
	b=WoXtPGAWji56lU96Km4vJPoHWZCv8m8DWNTsxnEOUd3DUo8UTE3SjGPdKjsi6pRGqFuJFn
	9f2ySdUc4gQJbDjrGzz78RN4oEwSEf1GfGlxJZOUhbZ0u5/1LK2g5i0YL2ZYMrvDj5YwE1
	no0E8a/QkkKKJuNbPL3/+t1IDxSIj5Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-DtdL2qewN5mN44yILNmmyw-1; Thu, 22 Jun 2023 12:37:44 -0400
X-MC-Unique: DtdL2qewN5mN44yILNmmyw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a355cf318so544643866b.2
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 09:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687451844; x=1690043844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JewwlfUhZBK+i/3ORJq58l+o9JnC1L/BGtep803e2U=;
        b=STThv78bR7WjXjm0hY9nbdrw5AjtKjcNH7ouGWgxt0bWJKxqT6igFvG2W7C1sBCgvI
         fjCceeAJMSR+Dc6b+zgNXK3Zm/YvueKgShNhdPLhFekHS5znSfQKOPmvkit0DC0+XDVk
         EGty2RFXc6LZPn32A6vWrd09i8nj93U7c3zm7n0m7W0e+Bt9jlgYCgKlgM3dUJirV/YF
         5QLtbqROZ/MJPEMwsriBtNoGrUh3SGN0GS0VuIwwThlg5LpWrgluWJJyOq81XpBg4MIU
         ltstsxNfIdCvHFQgAouRuuETkceyGytUzoAw1A1b5kv7AmR9Mqnq2wymKS+mWYvk9wJd
         dh4Q==
X-Gm-Message-State: AC+VfDz4TvpY3VyPu3L/ySZNy/W+LMzY7iy8pcl6B1z6cNYCD43bNEb9
	++5mlrpUEfUoFuK0zEtuacVfMDn34rIp4xqmadM+gV0O+ZKrSt3/DkpProT6ZFsn6qSfkYCOaYQ
	+JqI+IqLMkDvo
X-Received: by 2002:a17:906:1d05:b0:98d:3b40:eecf with SMTP id n5-20020a1709061d0500b0098d3b40eecfmr1372771ejh.4.1687451844708;
        Thu, 22 Jun 2023 09:37:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6WBDrRLIvqjb1enN3k1BFXMWSMSHxFtm3j7J6yA27lcpfSf8BJASjPHEgLDkecnWxmEIbgwA==
X-Received: by 2002:a17:906:1d05:b0:98d:3b40:eecf with SMTP id n5-20020a1709061d0500b0098d3b40eecfmr1372763ejh.4.1687451844433;
        Thu, 22 Jun 2023 09:37:24 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id e22-20020a1709067e1600b0096f675ce45csm4808601ejr.182.2023.06.22.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 09:37:23 -0700 (PDT)
Date: Thu, 22 Jun 2023 18:37:21 +0200
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
Subject: Re: [PATCH RFC net-next v4 7/8] vsock: Add lockless sendmsg() support
Message-ID: <6aif4uoucg6fhqwg2fmx76jkt6542dt7cqsxrtnebpboihfjeb@akpxj3yd2xle>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-7-0cebbb2ae899@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230413-b4-vsock-dgram-v4-7-0cebbb2ae899@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 10, 2023 at 12:58:34AM +0000, Bobby Eshleman wrote:
>Because the dgram sendmsg() path for AF_VSOCK acquires the socket lock
>it does not scale when many senders share a socket.
>
>Prior to this patch the socket lock is used to protect both reads and
>writes to the local_addr, remote_addr, transport, and buffer size
>variables of a vsock socket. What follows are the new protection schemes
>for these fields that ensure a race-free and usually lock-free
>multi-sender sendmsg() path for vsock dgrams.
>
>- local_addr
>local_addr changes as a result of binding a socket. The write path
>for local_addr is bind() and various vsock_auto_bind() call sites.
>After a socket has been bound via vsock_auto_bind() or bind(), subsequent
>calls to bind()/vsock_auto_bind() do not write to local_addr again. bind()
>rejects the user request and vsock_auto_bind() early exits.
>Therefore, the local addr can not change while a parallel thread is
>in sendmsg() and lock-free reads of local addr in sendmsg() are safe.
>Change: only acquire lock for auto-binding as-needed in sendmsg().
>
>- buffer size variables
>Not used by dgram, so they do not need protection. No change.
>
>- remote_addr and transport
>Because a remote_addr update may result in a changed transport, but we
>would like to be able to read these two fields lock-free but coherently
>in the vsock send path, this patch packages these two fields into a new
>struct vsock_remote_info that is referenced by an RCU-protected pointer.
>
>Writes are synchronized as usual by the socket lock. Reads only take
>place in RCU read-side critical sections. When remote_addr or transport
>is updated, a new remote info is allocated. Old readers still see the
>old coherent remote_addr/transport pair, and new readers will refer to
>the new coherent. The coherency between remote_addr and transport
>previously provided by the socket lock alone is now also preserved by
>RCU, except with the highly-scalable lock-free read-side.
>
>Helpers are introduced for accessing and updating the new pointer.
>
>The new structure is contains an rcu_head so that kfree_rcu() can be
>used. This removes the need of writers to use synchronize_rcu() after
>freeing old structures which is simply more efficient and reduces code
>churn where remote_addr/transport are already being updated inside RCU
>read-side sections.
>
>Only virtio has been tested, but updates were necessary to the VMCI and
>hyperv code. Unfortunately the author does not have access to
>VMCI/hyperv systems so those changes are untested.

@Dexuan, @Vishnu, @Bryan, can you test this?

>
>Perf Tests (results from patch v2)
>vCPUS: 16
>Threads: 16
>Payload: 4KB
>Test Runs: 5
>Type: SOCK_DGRAM
>
>Before: 245.2 MB/s
>After: 509.2 MB/s (+107%)
>
>Notably, on the same test system, vsock dgram even outperforms
>multi-threaded UDP over virtio-net with vhost and MQ support enabled.
>
>Throughput metrics for single-threaded SOCK_DGRAM and
>single/multi-threaded SOCK_STREAM showed no statistically signficant
>throughput changes (lowest p-value reaching 0.27), with the range of the
>mean difference ranging between -5% to +1%.
>

Quite nice. Did you see any improvements also on stream/seqpacket
sockets?

However this is a big change, maybe I would move it to another series,
because it takes time to be reviewed and tested properly.

WDYT?

Thanks,
Stefano


