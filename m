Return-Path: <bpf+bounces-11513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB0F7BB129
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 07:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF79282171
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 05:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB7646AC;
	Fri,  6 Oct 2023 05:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xpgC48eG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D903FDB
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 05:18:34 +0000 (UTC)
Received: from out-193.mta0.migadu.com (out-193.mta0.migadu.com [91.218.175.193])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A0AEB
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 22:18:31 -0700 (PDT)
Message-ID: <1124e2ba-2856-41c7-713f-5a4b4ffd3ec5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1696569509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6FIhk3CVKDciV5afGmTwULasUwhSwoj3cfp90UAl38=;
	b=xpgC48eG7s8e5z7dO/gh8e7FX2WhT5alwGx3sV/dVLcWnOwpB3AkKzNELYQRJPhEljYX9N
	equgtyyLlb0gfvOSpGVgeNyGcasCkqIyQ0YnH/DS5WJNv+YgC5KQ0oYw0rfmrCv9/06CBX
	Q1FnBzvfWDEppcxQ8kDyqrWHYIntmnc=
Date: Thu, 5 Oct 2023 22:18:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add
 pairs_redir_to_connected helper
Content-Language: en-US
To: Geliang Tang <geliang.tang@suse.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1696490003.git.geliang.tang@suse.com>
 <10920edc470974553e66e2391400dfa81ec03d47.1696490003.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <10920edc470974553e66e2391400dfa81ec03d47.1696490003.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/5/23 12:21 AM, Geliang Tang wrote:
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -1336,32 +1336,22 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
>   	}
>   }
>   
> -static void unix_redir_to_connected(int sotype, int sock_mapfd,
> -			       int verd_mapfd, enum redir_mode mode)
> +static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
> +				     int sock_mapfd, int verd_mapfd, enum redir_mode mode)
>   {
>   	const char *log_prefix = redir_mode_str(mode);
> -	int c0, c1, p0, p1;
>   	unsigned int pass;
>   	int err, n;
> -	int sfd[2];
>   	u32 key;
>   	char b;
>   
>   	zero_verdict_count(verd_mapfd);
>   
> -	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
> -		return;
> -	c0 = sfd[0], p0 = sfd[1];
> -
> -	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
> -		goto close0;
> -	c1 = sfd[0], p1 = sfd[1];
> -
> -	err = add_to_sockmap(sock_mapfd, p0, p1);
> +	err = add_to_sockmap(sock_mapfd, peer0, peer1);
>   	if (err)
>   		goto close;
>   
> -	n = write(c1, "a", 1);
> +	n = write(cli1, "a", 1);
>   	if (n < 0)
>   		FAIL_ERRNO("%s: write", log_prefix);
>   	if (n == 0)
> @@ -1376,16 +1366,34 @@ static void unix_redir_to_connected(int sotype, int sock_mapfd,
>   	if (pass != 1)
>   		FAIL("%s: want pass count 1, have %d", log_prefix, pass);
>   
> -	n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0, IO_TIMEOUT_SEC);
> +	n = recv_timeout(mode == REDIR_INGRESS ? peer0 : cli0, &b, 1, 0, IO_TIMEOUT_SEC);
>   	if (n < 0)
>   		FAIL_ERRNO("%s: recv_timeout", log_prefix);
>   	if (n == 0)
>   		FAIL("%s: incomplete recv", log_prefix);
>   
>   close:
> -	xclose(c1);
> -	xclose(p1);
> -close0:
> +	xclose(cli1);
> +	xclose(peer1);
> +}
> +
> +static void unix_redir_to_connected(int sotype, int sock_mapfd,
> +			       int verd_mapfd, enum redir_mode mode)
> +{
> +	int c0, c1, p0, p1;
> +	int sfd[2];
> +
> +	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
> +		return;
> +	c0 = sfd[0], p0 = sfd[1];
> +
> +	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
> +		goto close;
> +	c1 = sfd[0], p1 = sfd[1];
> +
> +	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
> +
> +close:
>   	xclose(c0);
>   	xclose(p0);
>   }
> @@ -1661,51 +1669,19 @@ static int inet_socketpair(int family, int type, int *s, int *c)
>   static void udp_redir_to_connected(int family, int sock_mapfd, int verd_mapfd,
>   				   enum redir_mode mode)
>   {
> -	const char *log_prefix = redir_mode_str(mode);
>   	int c0, c1, p0, p1;
> -	unsigned int pass;
> -	int err, n;
> -	u32 key;
> -	char b;
> -
> -	zero_verdict_count(verd_mapfd);
> +	int err;
>   
>   	err = inet_socketpair(family, SOCK_DGRAM, &p0, &c0);
>   	if (err)
>   		return;
>   	err = inet_socketpair(family, SOCK_DGRAM, &p1, &c1);
>   	if (err)
> -		goto close_cli0;
> -
> -	err = add_to_sockmap(sock_mapfd, p0, p1);
> -	if (err)
> -		goto close_cli1;
> -
> -	n = write(c1, "a", 1);
> -	if (n < 0)
> -		FAIL_ERRNO("%s: write", log_prefix);
> -	if (n == 0)
> -		FAIL("%s: incomplete write", log_prefix);
> -	if (n < 1)
> -		goto close_cli1;
> -
> -	key = SK_PASS;
> -	err = xbpf_map_lookup_elem(verd_mapfd, &key, &pass);
> -	if (err)
> -		goto close_cli1;
> -	if (pass != 1)
> -		FAIL("%s: want pass count 1, have %d", log_prefix, pass);
> +		goto close;
>   
> -	n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0, IO_TIMEOUT_SEC);
> -	if (n < 0)
> -		FAIL_ERRNO("%s: recv_timeout", log_prefix);
> -	if (n == 0)
> -		FAIL("%s: incomplete recv", log_prefix);
> +	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
>   
> -close_cli1:
> -	xclose(c1);
> -	xclose(p1);
> -close_cli0:
> +close:
>   	xclose(c0);
>   	xclose(p0);

Patch 1 is applied. Thanks.

In patch 2, the xclose() here is confusing after this change. It is also 
inconsistent from how other tests in sockmap_listen.c is doing it. c0/p0 and 
c1/p1 are opened here but only c0/p0 is closed here and c1/p1 is closed in the 
pairs_redir_to_connected() above instead.




