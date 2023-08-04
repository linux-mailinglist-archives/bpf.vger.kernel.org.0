Return-Path: <bpf+bounces-6913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAF476F6F9
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 03:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25705282428
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 01:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C39110ED;
	Fri,  4 Aug 2023 01:31:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31502EA8
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 01:31:09 +0000 (UTC)
Received: from out-117.mta1.migadu.com (out-117.mta1.migadu.com [IPv6:2001:41d0:203:375::75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F235049D7
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 18:30:41 -0700 (PDT)
Message-ID: <2501f80c-23c6-a509-fd6a-c44797d9f345@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691112632; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcxvYQmtOutoTtbSxHSjruw7wZL1oVKCh0+CGq78EfE=;
	b=FPk1H+yOaNRCVt7lorOPG79lxnEQ+6Xi9bBGrlY5I8e1G2zXSTpLB3sfT1drDurUQ9bt/b
	cVgOcrWAlAM96ZMMEpOpFHcg9g0Wh6oZWDxjb09m2eNwliwpm6/Gcc059tjOwyUoizGgmP
	Fk53GmOhDl9aEiJWnzePX6QBEnST9yw=
Date: Thu, 3 Aug 2023 18:30:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] selftests/bpf: fix the incorrect verification of
 port numbers.
Content-Language: en-US
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, dan.carpenter@linaro.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20230803215316.688220-1-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230803215316.688220-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/23 2:53 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Check port numbers before calling htons().
> 
> According to Dan Carpenter's report, Smatch identified incorrect port
> number checks. It is expected that the returned port number is an integer,
> with negative numbers indicating errors. However, the value was mistakenly
> verified after being translated by htons().
> 
> Fixes: 8a8c2231cab2 ("selftests/bpf: fix the incorrect verification of port numbers.")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/bpf/cafd6585-d5a2-4096-b94f-7556f5aa7737@moroto.mountain/
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

Ack with a small nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
> index 95bab61a1e57..0df95bc88a9b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
> @@ -110,11 +110,13 @@ static int connect_client_server_v6(int client_fd, int listen_fd)
>   		.sin6_family = AF_INET6,
>   		.sin6_addr = IN6ADDR_LOOPBACK_INIT,
>   	};
> +	int port;
>   	int err;

No need for a separate line for 'int port'.
Just doing 'int err, port;' sounds better.

>   
> -	addr.sin6_port = htons(get_sock_port_v6(listen_fd));
> -	if (addr.sin6_port < 0)
> +	port = get_sock_port_v6(listen_fd);
> +	if (port < 0)
>   		return -1;
> +	addr.sin6_port = htons(port);
>   
>   	err = connect(client_fd, (struct sockaddr *)&addr, sizeof(addr));
>   	if (err < 0) {

