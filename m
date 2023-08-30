Return-Path: <bpf+bounces-8978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF98C78D3DE
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 10:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A002812E7
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB131C10;
	Wed, 30 Aug 2023 08:10:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1770D1871;
	Wed, 30 Aug 2023 08:10:57 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F231A2;
	Wed, 30 Aug 2023 01:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Ie3n1j0GD6Ahdh475HUS4ED4u7BERMvo0xFGOV0m6LA=; b=kuh/KXDN7wmwjUiXoD5GlGe7tl
	pA75X2Wgj/YYAN0ezmqY/WbYmTdYujOck6U23+gSrs2kx/kSQZk+UuoyJzXp4LrMHuROc+SoRbq2h
	mkfELD4sLXujZXi0SNEYxs2Ytz1Xe5rpxZUs+28vkM3BC0izQQDpWeCEXUyrQV1JDidFgyd4iXn6v
	CaDMvX0S3mAVmwF/pMJrlvUwD5O5xVfIyrx7mgLr8f/lsgMky83Im8w/bAayqtI5l39vBTa5g9LKG
	b3FRZ9PNq3U4j4uIHIo48+riI10c794ryudRyrDYTet4Wbfeiih1cBhb3koRrGNYDNx4uesS9XrEA
	Xp8exH0A==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbGHt-0006SV-2P; Wed, 30 Aug 2023 10:10:53 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbGHs-000Gf5-VE; Wed, 30 Aug 2023 10:10:52 +0200
Subject: Re: [PATCH bpf v3 3/4] selftests/bpf: fix a CI failure caused by
 vsock sockmap test
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>
References: <20230804073740.194770-1-xukuohai@huaweicloud.com>
 <20230804073740.194770-4-xukuohai@huaweicloud.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <13ccc3b5-a392-9391-79ec-143a8701c1f5@iogearbox.net>
Date: Wed, 30 Aug 2023 10:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230804073740.194770-4-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27015/Tue Aug 29 09:39:45 2023)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Xu,

On 8/4/23 9:37 AM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> BPF CI has reported the following failure:
> 
> Error: #200/79 sockmap_listen/sockmap VSOCK test_vsock_redir
>    Error: #200/79 sockmap_listen/sockmap VSOCK test_vsock_redir
>    ./test_progs:vsock_unix_redir_connectible:1506: egress: write: Transport endpoint is not connected
>    vsock_unix_redir_connectible:FAIL:1506
>    ./test_progs:vsock_unix_redir_connectible:1506: ingress: write: Transport endpoint is not connected
>    vsock_unix_redir_connectible:FAIL:1506
>    ./test_progs:vsock_unix_redir_connectible:1506: egress: write: Transport endpoint is not connected
>    vsock_unix_redir_connectible:FAIL:1506
>    ./test_progs:vsock_unix_redir_connectible:1514: ingress: recv() err, errno=11
>    vsock_unix_redir_connectible:FAIL:1514
>    ./test_progs:vsock_unix_redir_connectible:1518: ingress: vsock socket map failed, a != b
>    vsock_unix_redir_connectible:FAIL:1518
>    ./test_progs:vsock_unix_redir_connectible:1525: ingress: want pass count 1, have 0
> 
> It’s because the recv(... MSG_DONTWAIT) syscall in the test case is
> called before the queued work sk_psock_backlog() in the kernel finishes
> executing. So the data to be read is still queued in psock->ingress_skb
> and cannot be read by the user program. Therefore, the non-blocking
> recv() reads nothing and reports an EAGAIN error.
> 
> So replace recv(... MSG_DONTWAIT) with xrecv_nonblock(), which calls
> select() to wait for data to be readable or timeout before calls recv().
> 
> Fixes: d61bd8c1fd02 ("selftests/bpf: add a test case for vsock sockmap")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

This is unfortunately still flaky and showing up from time to time in BPF CI, e.g. a
very recent one can be found here:

https://github.com/kernel-patches/bpf/actions/runs/6021475685/job/16335248421

[...]
Error: #211 sockmap_listen
Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
   Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
   ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
   vsock_unix_redir_connectible:FAIL:1501
   ./test_progs:vsock_unix_redir_connectible:1501: ingress: write: Transport endpoint is not connected
   vsock_unix_redir_connectible:FAIL:1501
   ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
   vsock_unix_redir_connectible:FAIL:1501

Could you continue to look into it to make the test more robust?

Thanks a lot,
Daniel

