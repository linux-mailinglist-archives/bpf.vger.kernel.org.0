Return-Path: <bpf+bounces-12358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165177CB73E
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 02:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475F41C20BA3
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 00:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DCD468F;
	Tue, 17 Oct 2023 00:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGsYxnhU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD41864F;
	Tue, 17 Oct 2023 00:00:45 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA5F93;
	Mon, 16 Oct 2023 17:00:43 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7db1f864bso61110487b3.3;
        Mon, 16 Oct 2023 17:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697500843; x=1698105643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=upT2SOaSlFax2SLg8LDtHnOPLY2rWaXpDNXwsy0h3Fk=;
        b=WGsYxnhUgIjCfUWNaRw8ftFQvnkTfotNwUU6KUQmBVCDgCtfp4u9Q15KCaVxb+cdCR
         dCPtBqO+Sv7l3PsMzEdYvbXjkT1ZIXvHv8MxJTzwWfEdErIoCcJZTmpVTf4+qYCOfMbq
         4lFyq+74VSxjdQ7J2VFOHgp0VQO0eo8WmMMImePSIvUVXPdJt1X1R2LpdMGnP5DLAJPe
         qjApmRqmMcJGy/XlN/0doOW/L1rgwzQjHfxwauYVoE2UBLxcyWQLtV1NIZqF/nMPlbtl
         JIpXe5weayIMx+/fsMd+rMfcaKPTrDYU56Kyxkr5ajDJElwiVt/84s3c5dHnbLbkU0s9
         1Xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697500843; x=1698105643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upT2SOaSlFax2SLg8LDtHnOPLY2rWaXpDNXwsy0h3Fk=;
        b=r7JeTUHkYdrGoHTI8ZEBW95tsNm+1HOCRl7ClhUgq8LJfHJi3b3WOyi9jUcJAADOZo
         ll1siXe2nvA8qQJXlIr7HziNNUtRWHEnscKoTP4cD0GeS8CEKpYjUSCccM5/oKDJiqI4
         Cgs1PAfzZpIPpjebJEhf0RlaGwe95Y0+nB/EaBKZTg4I/5nrL2QAb6wjQO+w257ksNm6
         PL1pOEgBzaQUKtQbNs42GaQbhGrfb4N1JMqeSvutNm/YsZGVd98ZubtrxVCmSFoqi+3K
         LhrLP0o5HK4r3+ytoxYQ3EL6dNpZQA8TjEt4tVodFVmSz4gmzc82jEY0KuETsMJC9k39
         uYPA==
X-Gm-Message-State: AOJu0YzhSlnIE7NV/g5wWWJv7Sbh0/FDGns6qN6kXe6u9HIc06tJ7G5b
	ZEt+/f5XFTtAWhC+tavwsjs=
X-Google-Smtp-Source: AGHT+IGNIDIJESdR6oou3kp6rQDvkjrkmJQajbAyh07uYV0h1QeCQwFyf0Mz27sbFzJNV17i6h4XRw==
X-Received: by 2002:a81:7157:0:b0:5a7:aaac:2bce with SMTP id m84-20020a817157000000b005a7aaac2bcemr732300ywc.35.1697500842740;
        Mon, 16 Oct 2023 17:00:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ee9:2f3e:b2a:a5c3? ([2600:1700:6cf8:1240:ee9:2f3e:b2a:a5c3])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05690c314a00b00577269ba9e9sm128325ywb.86.2023.10.16.17.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 17:00:42 -0700 (PDT)
Message-ID: <effba957-26ce-4b04-841a-40c863e6931f@gmail.com>
Date: Mon, 16 Oct 2023 17:00:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 bpf-next 03/11] tcp: Clean up goto labels in
 cookie_v[46]_check().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20231013220433.70792-1-kuniyu@amazon.com>
 <20231013220433.70792-4-kuniyu@amazon.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20231013220433.70792-4-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/13/23 15:04, Kuniyuki Iwashima wrote:
> We will add a SOCK_OPS hook to validate SYN Cookie.
> 
> We invoke the hook after allocating reqsk.  In case it fails,
> we will respond with RST instead of just dropping the ACK.
> 
> Then, there would be more duplicated error handling patterns.
> To avoid that, let's clean up goto labels.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>   net/ipv4/syncookies.c | 22 +++++++++++-----------
>   net/ipv6/syncookies.c |  4 ++--
>   2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 64280cf42667..b0cf6f4d66d8 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -369,11 +369,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>   	if (!cookie_timestamp_decode(net, &tcp_opt))
>   		goto out;
>   
> -	ret = NULL;
>   	req = cookie_tcp_reqsk_alloc(&tcp_request_sock_ops,
>   				     &tcp_request_sock_ipv4_ops, sk, skb);
>   	if (!req)
> -		goto out;
> +		goto out_drop;
>   
>   	ireq = inet_rsk(req);
>   	treq = tcp_rsk(req);
> @@ -405,10 +404,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>   	 */
>   	RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(net, skb));
>   
> -	if (security_inet_conn_request(sk, skb, req)) {
> -		reqsk_free(req);
> -		goto out;
> -	}
> +	if (security_inet_conn_request(sk, skb, req))
> +		goto out_free;
>   
>   	req->num_retrans = 0;
>   
> @@ -425,10 +422,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>   			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
>   	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
>   	rt = ip_route_output_key(net, &fl4);
> -	if (IS_ERR(rt)) {
> -		reqsk_free(req);
> -		goto out;
> -	}
> +	if (IS_ERR(rt))
> +		goto out_free;
>   
>   	/* Try to redo what tcp_v4_send_synack did. */
>   	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
> @@ -452,5 +447,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>   	 */
>   	if (ret)
>   		inet_sk(ret)->cork.fl.u.ip4 = fl4;
> -out:	return ret;
> +out:
> +	return ret;
> +out_free:
> +	reqsk_free(req);
> +out_drop:
> +	return NULL;
>   }

Looks like you don't use out_free and out_drop at all
in the patch 5 & 6. Are these changes still necessary?
Especially, the line 'goto out_drop' can be 'return NULL' concisely.


> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index cbee2df8a006..b8ef6efbb60e 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -171,11 +171,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
>   	if (!cookie_timestamp_decode(net, &tcp_opt))
>   		goto out;
>   
> -	ret = NULL;
>   	req = cookie_tcp_reqsk_alloc(&tcp6_request_sock_ops,
>   				     &tcp_request_sock_ipv6_ops, sk, skb);
>   	if (!req)
> -		goto out;
> +		goto out_drop;
>   
>   	ireq = inet_rsk(req);
>   	treq = tcp_rsk(req);
> @@ -263,5 +262,6 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
>   	return ret;
>   out_free:
>   	reqsk_free(req);
> +out_drop:
>   	return NULL;
>   }
Same here!

