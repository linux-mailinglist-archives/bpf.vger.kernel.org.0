Return-Path: <bpf+bounces-9100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D2078F9EF
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 10:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86631C20B90
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDCF9448;
	Fri,  1 Sep 2023 08:22:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC876ABC;
	Fri,  1 Sep 2023 08:22:24 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586AC193;
	Fri,  1 Sep 2023 01:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xTxVa1UAcrjHlVMmFYLml5BtOfYxt3hGcJB8ouNw63o=; b=pNpudNUgAwyIV9mbzxjKnKYdHc
	fmGj/XA0AveUpMGCPgEbOUAVt/VtPrdpd/Ws6611Wf3nvI/x9Xhji7Er6N5vjaBnhWxRBU9PYf0ob
	rAOJZ5t7jOC2sU8H5xuFrOpRTvfVf4bC3oSHvipOLu3obwGnsql4ZC9HotqpJP3oloUjyTTbY9hTS
	bK9UE85zpv5EyleODtrSfFTo8CGIP97NzHxhnuTeH55FOHBEjtukQ1M/33uaCxokzItR4OPTyu3v3
	CB9IdoC7f5EQg/C/Ig6WOnhPafE5kI4HJqFkHEOFRGJZ7i2kXr/RDmpqm0cDhiO3it+P7tDpHR4uF
	P5sRgJsA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbzPx-000KpU-1o; Fri, 01 Sep 2023 10:22:13 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbzPx-000Ate-5f; Fri, 01 Sep 2023 10:22:13 +0200
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix a CI failure caused by
 vsock write
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>
References: <20230901031037.3314007-1-xukuohai@huaweicloud.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <485647ed-e791-0781-afed-03c2d636a00b@iogearbox.net>
Date: Fri, 1 Sep 2023 10:22:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230901031037.3314007-1-xukuohai@huaweicloud.com>
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

On 9/1/23 5:10 AM, Xu Kuohai wrote:
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
> ---
> v1->v2: initialize esize to sizeof(eval) to avoid getsockopt() reading
> uninitialized value
> ---
>   .../bpf/prog_tests/sockmap_helpers.h          | 29 +++++++++++++++++++
>   .../selftests/bpf/prog_tests/sockmap_listen.c |  5 ++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> index d12665490a90..abd13d96d392 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> @@ -179,6 +179,35 @@
>   		__ret;                                                         \
>   	})
>   
> +static inline int poll_connect(int fd, unsigned int timeout_sec)
> +{
> +	struct timeval timeout = { .tv_sec = timeout_sec };
> +	fd_set wfds;
> +	int r;
> +	int eval;
> +	socklen_t esize = sizeof(eval);
> +
> +	FD_ZERO(&wfds);
> +	FD_SET(fd, &wfds);
> +
> +	r = select(fd + 1, NULL, &wfds, NULL, &timeout);
> +	if (r == 0)
> +		errno = ETIME;
> +
> +	if (r != 1)
> +		return -1;
> +
> +	if (getsockopt(fd, SOL_SOCKET, SO_ERROR, &eval, &esize) < 0)
> +		return -1;
> +
> +	if (eval != 0) {
> +		errno = eval;
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>   static inline int poll_read(int fd, unsigned int timeout_sec)
>   {
>   	struct timeval timeout = { .tv_sec = timeout_sec };
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index 5674a9d0cacf..2d3bf38677b6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -1452,6 +1452,11 @@ static int vsock_socketpair_connectible(int sotype, int *v0, int *v1)
>   	if (p < 0)
>   		goto close_cli;
>   
> +	if (poll_connect(c, IO_TIMEOUT_SEC) < 0) {
> +		FAIL_ERRNO("poll_connect");
> +		goto close_cli;
> +	}
> +
>   	*v0 = p;
>   	*v1 = c;
>   
> 

Should the error path rather be ?

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 2d3bf38677b6..8df8cbb447f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1454,7 +1454,7 @@ static int vsock_socketpair_connectible(int sotype, int *v0, int *v1)

         if (poll_connect(c, IO_TIMEOUT_SEC) < 0) {
                 FAIL_ERRNO("poll_connect");
-               goto close_cli;
+               goto close_acc;
         }

         *v0 = p;
@@ -1462,6 +1462,8 @@ static int vsock_socketpair_connectible(int sotype, int *v0, int *v1)

         return 0;

+close_acc:
+       close(p);
  close_cli:
         close(c);
  close_srv:


Let me know and I'll squash this into the fix.

Anyway, BPF CI went through fine, only the ongoing panic left to be fixed after that.

Thanks,
Daniel

