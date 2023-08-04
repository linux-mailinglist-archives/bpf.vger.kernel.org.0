Return-Path: <bpf+bounces-7049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C3E770B1A
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 23:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824D71C2103C
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 21:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC2921D2F;
	Fri,  4 Aug 2023 21:37:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692AD1ED5C
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 21:37:26 +0000 (UTC)
Received: from out-85.mta0.migadu.com (out-85.mta0.migadu.com [IPv6:2001:41d0:1004:224b::55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F3FB2
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 14:37:24 -0700 (PDT)
Message-ID: <c2776380-7550-3777-24a0-1f155785696c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691185042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/a0L2263fnp41GFITvgI6oICjbQAmG6ru0g4kpr6zg=;
	b=VTwWixWHOUpEyha9DkTsgXdOeubgqc8XTGdzCq3C/7aj5sxsRNmVHXPKupIQ/nplGrfUiE
	B6FLwYcUYHAAbh9Y5suF91LC50c/8iRj8v5ScQp/s9ek3HQUHxj3p2Sp7gqX5KMMIY/eHH
	i1ZfOGmNCksmePduXhUQs9k+pqLXtCo=
Date: Fri, 4 Aug 2023 14:37:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix the incorrect verification
 of port numbers.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 dan.carpenter@linaro.org, yonghong.song@linux.dev
References: <20230804165831.173627-1-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230804165831.173627-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/4/23 9:58 AM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Check port numbers before calling htons().
> 
> According to Dan Carpenter's report, Smatch identified incorrect port
> number checks. It is expected that the returned port number is an integer,
> with negative numbers indicating errors. However, the value was mistakenly
> verified after being translated by htons().
> 
> Major changes from v1:
> 
>   - Move the variable 'port' to the same line of 'err'.
> 
> Fixes: 539c7e67aa4a ("selftests/bpf: Verify that the cgroup_skb filters receive expected packets.")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/bpf/cafd6585-d5a2-4096-b94f-7556f5aa7737@moroto.mountain/
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
> index 95bab61a1e57..d686ef19f705 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
> @@ -110,11 +110,12 @@ static int connect_client_server_v6(int client_fd, int listen_fd)
>   		.sin6_family = AF_INET6,
>   		.sin6_addr = IN6ADDR_LOOPBACK_INIT,
>   	};
> -	int err;
> +	int err, port;
>   
> -	addr.sin6_port = htons(get_sock_port_v6(listen_fd));
> -	if (addr.sin6_port < 0)
> +	port = get_sock_port_v6(listen_fd);
> +	if (port < 0)

Applied. Some follow up questions:

Does other get_sock_port_v6() usage need to check -1 also?

It is a good idea to see if similar helpers exist in network_helpers.c e.g. 
There is get_socket_local_port() that supports both v4 and v6 in 
network_helpers.c which is equivalent to the get_sock_port_v6() here.
To a larger extent, I believe many codes in this new test can be saved by using 
the helpers in network_helpers.c. For example, the connect_client_server_v6() 
here can be replaced with connect_to_fd() from network_helpers.c to avoid the 
mistake this patch fixing. It also has some timeout limit on the socket such 
that it won't block the test_progs for a long time.

