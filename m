Return-Path: <bpf+bounces-16362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1802580074E
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 10:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C692818EC
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 09:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4651DA5B;
	Fri,  1 Dec 2023 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FMjZgsVZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF55B2
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 01:40:38 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a195e0145acso135053066b.2
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 01:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701423637; x=1702028437; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=RxV7uY5cndZ8gVvvHBGuynsrgK6rQa8uI5lCXiOByio=;
        b=FMjZgsVZ5n4L49BIxiONH/6zX+9DbUGua1XFqyivWYOmhgmsXAGuXsrkrDmAZdfyUE
         Fprm4UupM45KFBIdprVfyMoF6E0Vq6PTpzD1ExmwbMsZ8j0tlP/fR3HpWuloLmCPaTDl
         pTV73l5Ab5FnLWXJjcjLWrGmnLxIsRQOZ14lTYQt77b4U4FyVern0cCd0gPZBcQ+8aOU
         CVSMZnUTb9q0xxpQ1p+moPoQA5PLhtQikhUWHnF8FPbobe1dliW5ovTIe4ZzIH7YEmG+
         upomhpZW/sp0gcTA9UP4v82Y9TrSq7DeDNFr52kVLJD2EEbsCH1laCI7lS7xdzQAyaKX
         pPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701423637; x=1702028437;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxV7uY5cndZ8gVvvHBGuynsrgK6rQa8uI5lCXiOByio=;
        b=bF4TPzsFFluww/GOxjdZFSGxrqEkCxMzyOkF/CwI2Qf9BzwoHdrt+2j8ykYRX1gIPg
         Pc7toIb55ji0o6uuxGMfCzXiaSIlpppWPXu+lp78vyrSO+4s4Q9wzzMNNpjByXm9OP7B
         FXzdHoZ8x4FD0WjBVWNyhg7PZ/a4x/ncOzjnEUvvxxQmM7sMeJJ1BKy5Dq+TmzueCE3e
         Q0hD6vm3HJXMIBwLaasMmUT2FeH9kH/PZcBwu7v9Mx3DfXesVMsmKBbqqNezkNk4VY7a
         CmwhpJaLnlLt7DMzhAtmxMENpBWDrndxvSmkTWCmIeuLvr/0+uYgFCwunBI00H98K97C
         7x9Q==
X-Gm-Message-State: AOJu0Ywpy1jKhDjvJPGGLxt8STM4/YkRb4Kga7pi/J63xkOB0eC/tQdQ
	wanIavnsI+q3z6Q1WL6ZU63vMg==
X-Google-Smtp-Source: AGHT+IG6Vv2EaOyMPcb68zhQSpKCoKIV1XA1+FtJu2iCKIwbXC1JEOb9Od3j3/YGMkVGr3RYoek1WQ==
X-Received: by 2002:a17:906:3f5c:b0:a19:a19b:426d with SMTP id f28-20020a1709063f5c00b00a19a19b426dmr367380ejj.216.1701423637230;
        Fri, 01 Dec 2023 01:40:37 -0800 (PST)
Received: from cloudflare.com ([2a09:bac1:5ba0:d60::49:54])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906279500b009dddec5a96fsm1703152ejc.170.2023.12.01.01.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:40:36 -0800 (PST)
References: <20231201032316.183845-1-john.fastabend@gmail.com>
 <20231201032316.183845-3-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: kuniyu@amazon.com, edumazet@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf 2/2] bpf: sockmap, test for unconnected af_unix sock
Date: Fri, 01 Dec 2023 10:39:20 +0100
In-reply-to: <20231201032316.183845-3-john.fastabend@gmail.com>
Message-ID: <87edg62rcc.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 30, 2023 at 07:23 PM -08, John Fastabend wrote:
> Add test to sockmap_basic to ensure af_unix sockets that are not connected
> can not be added to the map. Ensure we keep DGRAM sockets working however
> as these will not be connected typically.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index f75f84d0b3d7..ad96f4422def 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -524,6 +524,37 @@ static void test_sockmap_skb_verdict_peek(void)
>  	test_sockmap_pass_prog__destroy(pass);
>  }
>  
> +static void test_sockmap_unconnected_unix(void)
> +{
> +	int err, map, stream = 0, dgram = 0, zero = 0;
> +	struct test_sockmap_pass_prog *skel;
> +
> +	skel = test_sockmap_pass_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	map = bpf_map__fd(skel->maps.sock_map_rx);
> +
> +	stream = xsocket(AF_UNIX, SOCK_STREAM, 0);
> +	if (!ASSERT_GT(stream, -1, "socket(AF_UNIX, SOCK_STREAM)"))
> +		return;

Isn't it redudant to use both the xsocket wrapper and ASSERT_* macro?
Or is there some debugging value that comes from that, which I missed?

> +
> +	dgram = xsocket(AF_UNIX, SOCK_DGRAM, 0);
> +	if (!ASSERT_GT(dgram, -1, "socket(AF_UNIX, SOCK_DGRAM)")) {
> +		close(stream);
> +		return;
> +	}
> +
> +	err = bpf_map_update_elem(map, &zero, &stream, BPF_ANY);
> +	ASSERT_ERR(err, "bpf_map_update_elem(stream)");
> +
> +	err = bpf_map_update_elem(map, &zero, &dgram, BPF_ANY);
> +	ASSERT_OK(err, "bpf_map_update_elem(dgram)");
> +
> +	close(stream);
> +	close(dgram);
> +}
> +
>  void test_sockmap_basic(void)
>  {
>  	if (test__start_subtest("sockmap create_update_free"))
> @@ -566,4 +597,7 @@ void test_sockmap_basic(void)
>  		test_sockmap_skb_verdict_fionread(false);
>  	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
>  		test_sockmap_skb_verdict_peek();
> +
> +	if (test__start_subtest("sockmap unconnected af_unix"))
> +		test_sockmap_unconnected_unix();
>  }


