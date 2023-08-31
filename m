Return-Path: <bpf+bounces-9050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 124CE78ECC8
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 14:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06AF281559
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 12:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC539111BF;
	Thu, 31 Aug 2023 12:09:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7DEC8C0;
	Thu, 31 Aug 2023 12:09:09 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9F0C5;
	Thu, 31 Aug 2023 05:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8a4slKVv/K6FTf6axtxItTQ1c7A/x1G9SFC2cF/bkCM=; b=UDnks1r48rEuxEbvUjCpibstA8
	zlOxnzt5HyPJqaeFjLXKLXEbEe2SZ3B5QOrvat6HAbL+k416Sb6iIhsLXTKMo1qoDZVjDc12+bZcm
	xW2I84u20lOgXBBK/oHmP2/fJErTcKY5MFAcyO2zGdt1H98dTGnsvZbTKEfHsHnjaAreABkAqX5Sv
	EeTB/kV8wvNQgXOA6XjSWBYduKJdrC3X5i5luN++5bXQXCaj7We3GsQxshvQS8VDUwInHWDFAqECJ
	InCFKKuczHtqpgdHVhQhmS9GQ2MoeE8LV4hkDt9r33l2LBPa1ufDUuCd4pjJvQZNxqc7SZaV+Uknd
	wn8zojiw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbgTx-00014N-EK; Thu, 31 Aug 2023 14:09:05 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbgTx-000NPU-Hm; Thu, 31 Aug 2023 14:09:05 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a CI failure caused by vsock
 write
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>
References: <20230831013105.2930824-1-xukuohai@huaweicloud.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9cf7982c-ec8a-4af9-98a8-549cd87dca70@iogearbox.net>
Date: Thu, 31 Aug 2023 14:09:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230831013105.2930824-1-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27017/Thu Aug 31 09:40:48 2023)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/31/23 3:31 AM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> While commit 90f0074cd9f9 ("selftests/bpf: fix a CI failure caused by vsock sockmap test")
> fixes a receive failure of vsock sockmap test, there is still a write failure:
> 
> Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
> Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
>    ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
>    vsock_unix_redir_connectible:FAIL:1501
>    ./test_progs:vsock_unix_redir_connectible:1501: ingress: write: Transport endpoint is not connected
>    vsock_unix_redir_connectible:FAIL:1501
>    ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
>    vsock_unix_redir_connectible:FAIL:1501
> 
> The reason is that the vsock connection in the test is set to ESTABLISHED state
> by function virtio_transport_recv_pkt, which is executed in a workqueue thread,
> so when the user space test thread runs before the workqueue thread, this
> problem occurs.
> 
> To fix it, before writing the connection, wait for it to be connected.
> 
> Fixes: d61bd8c1fd02 ("selftests/bpf: add a test case for vsock sockmap")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Thanks for the fix! Looks like this is gone now at least in the tests which succeed,
but there are still two issues:

1) s390x fails in BPF CI as below:

https://github.com/kernel-patches/bpf/actions/runs/6031993528/job/16366784236

Error: #211 sockmap_listen
Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
   Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
   ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
   vsock_socketpair_connectible:FAIL:1456
   ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
   vsock_unix_redir_connectible:FAIL:1494
   ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
   vsock_socketpair_connectible:FAIL:1456
   ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
   vsock_unix_redir_connectible:FAIL:1494
   ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
   vsock_socketpair_connectible:FAIL:1456
   ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
   vsock_unix_redir_connectible:FAIL:1494
   ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
   vsock_socketpair_connectible:FAIL:1456
   ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
   vsock_unix_redir_connectible:FAIL:1494
Error: #211/158 sockmap_listen/sockhash VSOCK test_vsock_redir
   Error: #211/158 sockmap_listen/sockhash VSOCK test_vsock_redir
   ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
   vsock_socketpair_connectible:FAIL:1456
   ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
   vsock_unix_redir_connectible:FAIL:1494
   ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
   vsock_socketpair_connectible:FAIL:1456
   ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
   vsock_unix_redir_connectible:FAIL:1494
   ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
   vsock_socketpair_connectible:FAIL:1456
   ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
   vsock_unix_redir_connectible:FAIL:1494
   ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
   vsock_socketpair_connectible:FAIL:1456
   ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
   vsock_unix_redir_connectible:FAIL:1494

2) Various panics, some GPFs but also seen NULL pointer derefs, discussed in the other
    thread: https://lore.kernel.org/bpf/ZO+RQwJhPhYcNGAi@krava/

I believe issue 1) might still be related to your fix in here, ptal.

Thanks,
Daniel

