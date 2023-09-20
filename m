Return-Path: <bpf+bounces-10484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD477A8B92
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 20:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C200B2099A
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15673CCFF;
	Wed, 20 Sep 2023 18:20:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB33CCE0;
	Wed, 20 Sep 2023 18:20:00 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15705CF;
	Wed, 20 Sep 2023 11:19:59 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59c2ca01f27so1473337b3.2;
        Wed, 20 Sep 2023 11:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695233998; x=1695838798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7I9Xz++bAGAsgkt8F/KVE7hX/yqLzaV8ZibltbKxpP0=;
        b=aZ4D/zHJZVlMm/kjBk7lahB8cy8bg4E4Q0xO+1uLWkwFujpmQSUTz0mUdFve9q+zi6
         aNCzYbLV6Sl36+TgLK50WAYHNwXc9+qBG/8x71ZAms30UApS4+4xo0hH7fqNW+4pXkBb
         dPgUMZAOLnXDKJ8pkh7Ts4WcuVYMEx2ic15GyJvj+it3W+1O2RhpwAew3jZ1NiSWPiP0
         eYLvxx2FdhCcHt4SJRzQ0HzuVMzNu9jYyJPaexwoC8KpZN6ikkO5Ml8GEoqgrNFSBhwm
         rnaK/miZvLzdM5HDqFJB1tY8r1qoQLf7Pa0fnJ7USiHOZh7obrOS2996tD2QsekcV85S
         4R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695233998; x=1695838798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7I9Xz++bAGAsgkt8F/KVE7hX/yqLzaV8ZibltbKxpP0=;
        b=lKmIXZqYftuUQZvp8voRhlxC3X2ccqJI+SKRtdPGeT1vZvKP+HQjH70poMI7QQY9pI
         AGbpHg3mnQehc5zg6nkgH9ak4gtZT0Re/k5L/zQC9NszgVztuzl0Wc3UyjFpYoS5iEVg
         q/AQhdCg0vHqERYemlDfD1sIVTbtvtaBDm0JNEY/FZJPYtZG54t3yYi22gQ+cPHvjCQa
         Xx4CCd6st7SAPE0zHoIIrLG3rGXHX8bcSVPKcFk3F8ypx/w+x+ygk2IdyFwVCjTPnczL
         Mg0ZTMfhIVh6q0DgKCfweF9lw90SGXRj/23GSVfykbphaM3KmYpgtxM6SlriOuwjG52C
         yGgw==
X-Gm-Message-State: AOJu0YwBurqnEp5vboN9hCmr0dhWNR3FX7PCZeAMqpuQ3wARtYMRP6pm
	RMXHpWxoXSB4yKU2er//A7M=
X-Google-Smtp-Source: AGHT+IHDqR3zMWRIZe6oRybVJ+pyFcZfbB+TZCHfFFGvH7bGX4Akvqj5UTZOPk0+7hk0C5TpJW1x0Q==
X-Received: by 2002:a81:478a:0:b0:59b:cfe1:bcf1 with SMTP id u132-20020a81478a000000b0059bcfe1bcf1mr3276561ywa.44.1695233998159;
        Wed, 20 Sep 2023 11:19:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:dcd2:9730:2c7c:239f? ([2600:1700:6cf8:1240:dcd2:9730:2c7c:239f])
        by smtp.gmail.com with ESMTPSA id fl19-20020a05690c339300b00582b239674esm2461327ywb.129.2023.09.20.11.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 11:19:57 -0700 (PDT)
Message-ID: <1224b3f1-4b2a-3c49-5f29-cfce0652ba94@gmail.com>
Date: Wed, 20 Sep 2023 11:19:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH bpf] bpf, sockmap: Reject sk_msg egress redirects to
 non-TCP sockets
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>
References: <20230920102055.42662-1-jakub@cloudflare.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230920102055.42662-1-jakub@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/20/23 03:20, Jakub Sitnicki wrote:
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index cb11750b1df5..4292c2ed1828 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -668,6 +668,8 @@ BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *, msg,
>   	sk = __sock_map_lookup_elem(map, key);
>   	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
>   		return SK_DROP;
> +	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
> +		return SK_DROP;
>   
>   	msg->flags = flags;
>   	msg->sk_redir = sk;
> @@ -1267,6 +1269,8 @@ BPF_CALL_4(bpf_msg_redirect_hash, struct sk_msg *, msg,
>   	sk = __sock_hash_lookup_elem(map, key);
>   	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
>   		return SK_DROP;
> +	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
> +		return SK_DROP;
>   
>   	msg->flags = flags;
>   	msg->sk_redir = sk;

Just be curious! Can it happen to other socket types?
I mean to redirect a msg from a sk of any type to one of another type.

