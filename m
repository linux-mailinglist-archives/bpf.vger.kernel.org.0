Return-Path: <bpf+bounces-33813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD81926A7D
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 23:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0E4283446
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 21:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0241922E6;
	Wed,  3 Jul 2024 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NBwy4BT4"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02051849C4
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042793; cv=none; b=FnHZymx7XLzLNrBNOh6gzT0oTeZKzQ+m6j38OZE/oMkJGfGBEeSZhupZC0wuRqwsQDtOMQmlbwmdlpfpIiaOpWfcg88hDw7d+1AtvG7wK0H9XKCHl2sUBaTzVMBmuacb4u/w9kKbE4b9g/9qShljtOF0Zd3kf8BLhgg3fwE9jig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042793; c=relaxed/simple;
	bh=EL4p3JfG51k3juRcgfI6CObDN5/EKiaTsr6WUa7E1uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLumsJrbg5Gme/Fhi57oqNL84xI1jqzBM1ZTR0qO5vknPYb9ay+NbDp8dqBVpr+HQ+St6Lumx+yqU8ZqmLH/oXcUMGL8xymlUbbe+66A/qMFAC+Ec+GWTQmCLI6wlxFN56rOLjMDhkGy1zfCAUqaLiQ6cs/fZ2srQpKupjr/A/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NBwy4BT4; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720042790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgnjdw0C9ojFomnIwwPGyZhr9MxPLZEI4qlAOq/Td0k=;
	b=NBwy4BT4F0JdPG/THS+XqW3DQJNdn1+qj9GD+IQqCJ8C9ohEMdR7X4U6SlaccuNjTwKjA+
	wKPkd3B8PYAGQlGuUgejH3Kz7W4e8xSO8YA8WSFlHWjc0D6Mh6CDdz+XfGiwPLJiEsZSpN
	vqpgP01M1ogg/E+pEe4Qji5fqlXowP8=
X-Envelope-To: andrii@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: mykolal@fb.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: song@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: shuah@kernel.org
X-Envelope-To: tanggeliang@kylinos.cn
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
Message-ID: <16e5a48e-3261-4e8f-a4f3-0e4b9cb16482@linux.dev>
Date: Wed, 3 Jul 2024 14:39:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/9] selftests/bpf: Use start_server_str in
 sockmap_ktls
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1719623708.git.tanggeliang@kylinos.cn>
 <549f4b0a22ee953a57ebd3d96a5a6619e881b110.1719623708.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <549f4b0a22ee953a57ebd3d96a5a6619e881b110.1719623708.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/28/24 6:20 PM, Geliang Tang wrote:
>   static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
>   {
> +	struct network_helper_opts opts = {
> +		.backlog = SOMAXCONN,
> +	};
>   	struct sockaddr_storage addr = {0};
>   	socklen_t len = sizeof(addr);
>   	int err, cli, srv, zero = 0;
>   
> -	srv = tcp_server(family);
> +	srv = start_server_str(family, SOCK_STREAM, NULL, 0, &opts);
>   	if (srv == -1)

It should be "if (!ASSERT_GE(srv, 0, ...))" to ensure that the failure is caught 
by the test_progs.

