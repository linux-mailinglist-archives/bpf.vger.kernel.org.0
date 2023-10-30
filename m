Return-Path: <bpf+bounces-13591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DEF7DB5E0
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 10:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84FFF1C20AD8
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABFDD531;
	Mon, 30 Oct 2023 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ME+oxpv5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5F9D50F
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 09:11:57 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8319BBD
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 02:11:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso6797957a12.2
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 02:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698657111; x=1699261911; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=68F4Nugtl6JmNyuxi5kC0lowONV3iMbK9eM0e7VxFDE=;
        b=ME+oxpv56vEn1NDi3glLaaZ2NB/d5Yy8M9xlKUPMR+cvcuFmmZnxPV3efnCH8Eq59d
         +/jePruzVNCAdpjNU5BraIq4BchxVzmfZXN6OpZ7ECjipxpP/4w2rrZI+J0Ejbp/Con4
         ZcuMNqijY9BcR8oadJSjs6dvim2LvF+7j9CX3+hik/gkp0dJGWEKbeTPjiq7wbSjYhkX
         v0fmhotPj7FFrY8udi59CarRMvfHJAawoz/5exJ/R+kRdRTfPsn3k7UmnMCMteL9B5wb
         nCOWdS2oCg65UEIneUpb+DbNc4HL+WYIV6VRp6Cir8lF40/+Bwms5JPg74RvY+a8FbiP
         CpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698657111; x=1699261911;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68F4Nugtl6JmNyuxi5kC0lowONV3iMbK9eM0e7VxFDE=;
        b=dj5lez8NPhO6u67Zarkonc1nlhiZqGc0BtY8Qq5NjM6ICnpG2XsNNY7uqEopmRzrZn
         sEjtxjzDQyIrZeOqrHNRKNz9kZ929LODqCTmHjeyahbt4DGdB79PVcPWqfIZvXo/AiX3
         2gIxFA64N7pbRPMlUlK+NbLOgNi9FdoaBm3ignLE+FhZa+sD63JZryNy7vFTsji4TAdv
         aI59PFfK3cGllXFKLV+bVEgDT9dH171gL1xI+vFP8dsWAx4WfeX7O/lo8pEMHERmigj3
         dn1KI25UmF6ZERLiOGhmnj7aGSSIxq71rttiFTQPuvAhWcy82IlYJh8aOyVsfICJraZ2
         tzKg==
X-Gm-Message-State: AOJu0YxENU6zNLTL3nDd7tWGj37PIkVD6GdVKpjsFcTa5tnpTEtwNhvI
	/bH2BEjHJ6DS7Oo7r5zX6fP6fw==
X-Google-Smtp-Source: AGHT+IGgMDyiGE1uiui2ycx+5YGKiTLigU2lmyJm3sD7BkIU7BEPVbulx6Ppd2BUsQxuxgAfTWxcsg==
X-Received: by 2002:a50:9ec2:0:b0:53e:e6eb:c838 with SMTP id a60-20020a509ec2000000b0053ee6ebc838mr7136522edf.8.1698657111004;
        Mon, 30 Oct 2023 02:11:51 -0700 (PDT)
Received: from cloudflare.com (79.184.209.104.ipv4.supernova.orange.pl. [79.184.209.104])
        by smtp.gmail.com with ESMTPSA id fd10-20020a056402388a00b0053e5a1bf77dsm5747877edb.88.2023.10.30.02.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:11:49 -0700 (PDT)
References: <20231028100552.2444158-1-liujian56@huawei.com>
 <20231028100552.2444158-8-liujian56@huawei.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Liu Jian <liujian56@huawei.com>
Cc: john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 7/7] selftests/bpf: add tests for verdict
 skmsg to closed socket
Date: Mon, 30 Oct 2023 10:04:35 +0100
In-reply-to: <20231028100552.2444158-8-liujian56@huawei.com>
Message-ID: <87fs1s1nl2.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Oct 28, 2023 at 06:05 PM +08, Liu Jian wrote:
> Add four tests for verdict skmsg to closed socket in sockmap_basic.c.
>
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 42 +++++++++++++++----
>  1 file changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 75107762a86e..4d49129cdd6b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c

[...]

> @@ -651,15 +669,23 @@ void test_sockmap_basic(void)
>  	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
>  		test_sockmap_skb_verdict_peek();
>  	if (test__start_subtest("sockmap msg_verdict"))
> -		test_sockmap_msg_verdict(false, false, false);
> +		test_sockmap_msg_verdict(false, false, false, false);
>  	if (test__start_subtest("sockmap msg_verdict ingress"))
> -		test_sockmap_msg_verdict(true, false, false);
> +		test_sockmap_msg_verdict(true, false, false, false);
>  	if (test__start_subtest("sockmap msg_verdict permanent"))
> -		test_sockmap_msg_verdict(false, true, false);
> +		test_sockmap_msg_verdict(false, true, false, false);
>  	if (test__start_subtest("sockmap msg_verdict ingress permanent"))
> -		test_sockmap_msg_verdict(true, true, false);
> +		test_sockmap_msg_verdict(true, true, false, false);
>  	if (test__start_subtest("sockmap msg_verdict permanent self"))
> -		test_sockmap_msg_verdict(false, true, true);
> +		test_sockmap_msg_verdict(false, true, true, false);
>  	if (test__start_subtest("sockmap msg_verdict ingress permanent self"))
> -		test_sockmap_msg_verdict(true, true, true);
> +		test_sockmap_msg_verdict(true, true, true, false);
> +	if (test__start_subtest("sockmap msg_verdict permanent shutdown"))
> +		test_sockmap_msg_verdict(false, true, false, true);
> +	if (test__start_subtest("sockmap msg_verdict ingress permanent shutdown"))
> +		test_sockmap_msg_verdict(true, true, false, true);
> +	if (test__start_subtest("sockmap msg_verdict shutdown"))
> +		test_sockmap_msg_verdict(false, false, false, true);
> +	if (test__start_subtest("sockmap msg_verdict ingress shutdown"))
> +		test_sockmap_msg_verdict(true, false, false, true);
>  }

I appreciate the split up of test changes into commits. Thanks.

As you see, the args for test_sockmap_msg_verdict became quite cryptic.
I think having dedicated aliases for 'true' would make it more readable:

        const bool INGRESS = true;
        const bool PERMANENT = true;
        const bool TO_SELF = true;
        const bool TARGET_SHUTDOWN = true;

Then invocations as:

        test_sockmap_msg_verdict(true, false, false, true);

become:

        test_sockmap_msg_verdict(INGRESS, !PERMANENT, !TO_SELF, TARGET_SHUTDOWN);

