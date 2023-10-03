Return-Path: <bpf+bounces-11241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C30C7B5FDC
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 06:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D958E2818F6
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 04:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C800B111C;
	Tue,  3 Oct 2023 04:27:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD07F5;
	Tue,  3 Oct 2023 04:27:26 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6E9A4;
	Mon,  2 Oct 2023 21:27:25 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5809d5fe7f7so269391a12.3;
        Mon, 02 Oct 2023 21:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696307244; x=1696912044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0i2+2bzLaAw4UfvDPBpBDW2+pEt9VCrTIzNCf4JObI=;
        b=WQ92RfzjATeE7mdBj4ATf9ea/c52OMYmYZ1Zq8tddkLoe42sjq8OZJqCOmPcdoi99+
         Ml4ZK2SI9rAwl98Sxz9OsQUaKSLjmp8W2LAyOCa2kKnSfuTuH1XdytfNY2xF0KuIvDeO
         JAnlRNWdVkQod3aAULT212/bl2okhzK1bjhcA1rrLsgtTTCa66bLRR2arpm7YGr6jo6i
         l6G0tCtX8z10oe1pLxqNrrSJt8gS6HRamzPU3RcugjpEV+mnd4TBTaA0sWeJPI/UKhSe
         Tv7crlivsFPt8DcvspnSgeqp6j1tSwxwxUr6rFrHWlvbCf5zJ5KtCaVVEbtdsyP3qeZh
         igkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696307244; x=1696912044;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y0i2+2bzLaAw4UfvDPBpBDW2+pEt9VCrTIzNCf4JObI=;
        b=kCx18+8mjknGqnh/JPdMHaaEcXcVepyVLeizb5vuR0b23qT3bNQ9iw9X9PMuhiQwkt
         KELML6dGCFliE/SUqfB5WlqU6TUbmFKZ97ABH9ftn8HAnWtagoVsRUI8yfkjwsAGRXfj
         HXPFQGioG5a4XWn63J1OdY/JSh9X2Dfm6g0Fv7s67B4IBeaK2gEPI96q7N7hFZBvKn3w
         kP+w5kNi/xobXSPXtAjPfwx32C8wGZJkVgZsecy5kHodttXsORZpnVCoJxulexW4xGuj
         PGms1G+vSH74ptEHd/8sR8bqwK8TiCz8nXtsj3BiT+IjUmezidTH/CUdbk2/JKwOwOdU
         ZhpQ==
X-Gm-Message-State: AOJu0YxtIExiWdyURGfUp4pa9XaQT/35AL4FgC3C63e2f9qfJStCEp4N
	9Vn0HKuCKqa9cXXMMrDlvTI=
X-Google-Smtp-Source: AGHT+IEzNjy+rb1mjbi6bqioDSUpBIVdZ0de8tTc4kjeIH5Yv2jt+r8Cgtk/ug3bzfqzUsqCoigkSg==
X-Received: by 2002:a05:6a20:3206:b0:154:9943:7320 with SMTP id hl6-20020a056a20320600b0015499437320mr10413897pzc.28.1696307244397;
        Mon, 02 Oct 2023 21:27:24 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba00:2a00:5720:bdb8:2705])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090282c500b001c446dea2c5sm317952plz.143.2023.10.02.21.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 21:27:23 -0700 (PDT)
Date: Mon, 02 Oct 2023 21:27:22 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Liu Jian <liujian56@huawei.com>, 
 john.fastabend@gmail.com, 
 jakub@cloudflare.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 kpsingh@kernel.org, 
 sdf@google.com, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 liujian56@huawei.com
Message-ID: <651b982a1b22a_4fa3f20854@john.notmuch>
In-Reply-To: <20230927093013.1951659-2-liujian56@huawei.com>
References: <20230927093013.1951659-1-liujian56@huawei.com>
 <20230927093013.1951659-2-liujian56@huawei.com>
Subject: RE: [PATCH bpf-next v5 1/7] bpf, sockmap: add BPF_F_PERMANENT flag
 for skmsg redirect
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Liu Jian wrote:
> If the sockmap msg redirection function is used only to forward packets
> and no other operation, the execution result of the BPF_SK_MSG_VERDICT
> program is the same each time. In this case, the BPF program only needs to
> be run once. Add BPF_F_PERMANENT flag to bpf_msg_redirect_map() and
> bpf_msg_redirect_hash() to implement this ability.
> 
> Then we can enable this function in the bpf program as follows:
> bpf_msg_redirect_hash(xx, xx, xx, BPF_F_INGRESS | BPF_F_PERMANENT);
> 
> Test results using netperf  TCP_STREAM mode:
> for i in 1 64 128 512 1k 2k 32k 64k 100k 500k 1m;then
> netperf -T 1,2 -t TCP_STREAM -H 127.0.0.1 -l 20 -- -m $i -s 100m,100m -S 100m,100m
> done
> 
> before:
> 3.84 246.52 496.89 1885.03 3415.29 6375.03 40749.09 48764.40 51611.34 55678.26 55992.78
> after:
> 4.43 279.20 555.82 2080.79 3870.70 7105.44 41836.41 49709.75 51861.56 55211.00 54566.85
> 
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---

First sorry for the delay I was thinking about this a bit. I decided it likely makes
a lot of sense if you want to build an l7 load balancer where you just read some
keys off an initial msg and then pin the rest of the connection to a specific
backend or proxy socket, etc.

>  include/linux/skmsg.h          |  1 +
>  include/uapi/linux/bpf.h       | 45 ++++++++++++++++++++++++++--------
>  net/core/skmsg.c               |  6 ++++-
>  net/core/sock_map.c            |  4 +--
>  net/ipv4/tcp_bpf.c             | 12 +++++----
>  tools/include/uapi/linux/bpf.h | 45 ++++++++++++++++++++++++++--------
>  6 files changed, 85 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index c1637515a8a4..acd7de85608b 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -83,6 +83,7 @@ struct sk_psock {
>  	u32				cork_bytes;
>  	u32				eval;
>  	bool				redir_ingress; /* undefined if sk_redir is null */
> +	bool				redir_permanent;
>  	struct sk_msg			*cork;
>  	struct sk_psock_progs		progs;
>  #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 70bfa997e896..cec6c34f4486 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3029,11 +3029,23 @@ union bpf_attr {
>   * 		socket level. If the message *msg* is allowed to pass (i.e. if
>   * 		the verdict eBPF program returns **SK_PASS**), redirect it to
>   * 		the socket referenced by *map* (of type
> - * 		**BPF_MAP_TYPE_SOCKMAP**) at index *key*. Both ingress and
> - * 		egress interfaces can be used for redirection. The
> - * 		**BPF_F_INGRESS** value in *flags* is used to make the
> - * 		distinction (ingress path is selected if the flag is present,
> - * 		egress path otherwise). This is the only flag supported for now.
> + * 		**BPF_MAP_TYPE_SOCKMAP**) at index *key*.
> + *
> + *		The following *flags* are supported:
> + *
> + *		**BPF_F_INGRESS**
> + *		        Both ingress and egress interfaces can be used for redirection.
> + *		        The **BPF_F_INGRESS** value in *flags* is used to make the
> + *		        distinction. Ingress path is selected if the flag is present,
> + *		        egress path otherwise.
> + *		**BPF_F_PERMANENT**
> + *		        Indicates that redirect verdict and the target socket should be
> + *		        remembered. The verdict program will not be run for subsequent
> + *		        packets, unless an error occurs when forwarding packets.

Why clear it on error? The error is almost always because either the socket is
being torn down or there is a memory ENOMEM error that is going to be kicked
back to user.

Is the idea that you can try anopther backend possibly by picking another socket
out of the table? But, I'm not sure how that might work because you probably
don't know that this is even the beginning of a msg block.

I'm wondering if I missed some other reason or if its just simpler to pass the
error up the stack and keep the same sk_redir.

Thanks,
John

