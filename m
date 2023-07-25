Return-Path: <bpf+bounces-5783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8FB760437
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 02:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839BE28167A
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 00:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2577A15B6;
	Tue, 25 Jul 2023 00:42:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EF97C
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 00:42:47 +0000 (UTC)
Received: from out-33.mta1.migadu.com (out-33.mta1.migadu.com [95.215.58.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2554A19AF
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 17:42:26 -0700 (PDT)
Message-ID: <f314091e-fa6b-3113-c64b-6e38bed907d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690245744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=seCqV6BWYTRweQc+AwxxhsUnFm8NXFPG4GUfPxlgY2c=;
	b=eeofTMWLLXFLtfmcLeWYsFDGHNXaR8Kpv609KurPpRVFs0JCFsZP94Sn7Wpvs5ZXi50aQk
	Sdz7Be/TlsJQg22Hw29T5BF+CjR6WoP9pzP1T9ep5NEgtD8nWhAsT3vw1KoB/AicwK3Q0a
	EqLpQu9hbrwN1tyxtUGtUk9hS1iVWXM=
Date: Mon, 24 Jul 2023 17:42:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 8/8] selftests/bpf: Test that SO_REUSEPORT can
 be used with sk_assign helper
Content-Language: en-US
To: Lorenz Bauer <lmb@isovalent.com>
Cc: Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Joe Stringer <joe@cilium.io>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Joe Stringer <joe@wand.net.nz>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
 <20230720-so-reuseport-v6-8-7021b683cdae@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230720-so-reuseport-v6-8-7021b683cdae@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/20/23 8:30 AM, Lorenz Bauer wrote:
> +static int echo_test_udp(int fd_sv)
> +{
> +	struct sockaddr_storage addr = {};
> +	socklen_t len = sizeof(addr);
> +	char buff[1] = {};
> +	int fd_cl = -1, ret;
> +
> +	fd_cl = connect_to_fd(fd_sv, 100);
> +	ASSERT_GT(fd_cl, 0, "create_client");
> +	ASSERT_EQ(getsockname(fd_cl, (void *)&addr, &len), 0, "getsockname");
> +
> +	ASSERT_EQ(send(fd_cl, buff, sizeof(buff), 0), 1, "send_client");
> +
> +	ret = recv(fd_sv, buff, sizeof(buff), 0);
> +	if (ret < 0)

I think this needs a close(fd_cl).

> +		return errno;


