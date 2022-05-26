Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B00E534CA1
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241705AbiEZJld (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 05:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiEZJlc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 05:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 117B42AC73
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653558090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dCJgXyPrqdE5WIPFAQfO4gTBV7YQclo/cLfe+wOn3oI=;
        b=P/ImeNaEKJwFcXBacX+dxH8piBxLxOPtMRYuztSNLFnqISvwe/n8M2qeCcX52hJSMUJC10
        L7VIaeYNulrchyyBtwi4jchBDvj+a8VXuKtVLtTT7MAByr0cJLym6uQdDmmfv0ONEwvDe2
        XJY6JEc+toRfFRmi6rgx8J4uWAkN6GU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-yYGlUMJNPV-mJULCPKgtTw-1; Thu, 26 May 2022 05:41:29 -0400
X-MC-Unique: yYGlUMJNPV-mJULCPKgtTw-1
Received: by mail-qk1-f197.google.com with SMTP id f20-20020a05620a12f400b006a36317a58aso946567qkl.6
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 02:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dCJgXyPrqdE5WIPFAQfO4gTBV7YQclo/cLfe+wOn3oI=;
        b=QfAzgpMx9I52yb8+rhCX1O3KyF02CDXbgVlm1fBzaXyXnnGytBHqMOjx7p67a+hzVj
         VXCJpiSWFJVGV1vDPQAETLCDhkwe15Q255qnKwzKHYvucPtlcMkmZx+wrgDk19jfPW7v
         GMJ/H9BcrfHyNr64iM+u+535b5HGuIoF50M8k6IshZGXvEOIzuHW+2dh5/zWCq99iZ/q
         tj5dPMhIZRHkKMKJ+f0QgURc8qA9oUbaZPrYgy4rEWozRNj9Br0J7Id/9cAO9SxZjI2p
         v/YeBwkM8r9yAJ+U/rucj0RyHi/LS+30IViZQL7HKS8HN/RBYasN+PG680t1rqwByWJJ
         7J1A==
X-Gm-Message-State: AOAM531sB7bCu38Zo/LmgcwAs8gNJkS6OLiKd0J75TgkRoNEAvQ7CCy7
        af7rGSwr6yh4Kv2LT69dkDqL/opJEBAaBQK93HvoREJYtUGzyQwxUAG1HVGfl+z07EJVvMtcVi6
        dPu+PvghLGQ8+
X-Received: by 2002:a05:622a:174d:b0:2f9:2199:52f9 with SMTP id l13-20020a05622a174d00b002f9219952f9mr21140794qtk.431.1653558088255;
        Thu, 26 May 2022 02:41:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9EYSVd1pO5aHlLrnh4V8z54iw1RFgX8bDtKZQauCwzfPjKTPwIY6zoxAAdIKhBbkdPahptg==
X-Received: by 2002:a05:622a:174d:b0:2f9:2199:52f9 with SMTP id l13-20020a05622a174d00b002f9219952f9mr21140778qtk.431.1653558087969;
        Thu, 26 May 2022 02:41:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id d2-20020ac847c2000000b002f93fbd71c2sm698032qtr.38.2022.05.26.02.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 02:41:27 -0700 (PDT)
Message-ID: <dddf715df453e9d3bc56bc74b8e6de05cffc9e45.camel@redhat.com>
Subject: Re: [PATCH net-next v2] ipv6: Fix signed integer overflow in
 __ip6_append_data
From:   Paolo Abeni <pabeni@redhat.com>
To:     Wang Yufen <wangyufen@huawei.com>, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Date:   Thu, 26 May 2022 11:41:20 +0200
In-Reply-To: <20220525020827.1571021-1-wangyufen@huawei.com>
References: <20220525020827.1571021-1-wangyufen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-05-25 at 10:08 +0800, Wang Yufen wrote:
> Resurrect ubsan overflow checks and ubsan report this warning,
> fix it by change the variable [length] type to size_t.
> 
> UBSAN: signed-integer-overflow in net/ipv6/ip6_output.c:1489:19
> 2147479552 + 8567 cannot be represented in type 'int'
> CPU: 0 PID: 253 Comm: err Not tainted 5.16.0+ #1
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>   dump_backtrace+0x214/0x230
>   show_stack+0x30/0x78
>   dump_stack_lvl+0xf8/0x118
>   dump_stack+0x18/0x30
>   ubsan_epilogue+0x18/0x60
>   handle_overflow+0xd0/0xf0
>   __ubsan_handle_add_overflow+0x34/0x44
>   __ip6_append_data.isra.48+0x1598/0x1688
>   ip6_append_data+0x128/0x260
>   udpv6_sendmsg+0x680/0xdd0
>   inet6_sendmsg+0x54/0x90
>   sock_sendmsg+0x70/0x88
>   ____sys_sendmsg+0xe8/0x368
>   ___sys_sendmsg+0x98/0xe0
>   __sys_sendmmsg+0xf4/0x3b8
>   __arm64_sys_sendmmsg+0x34/0x48
>   invoke_syscall+0x64/0x160
>   el0_svc_common.constprop.4+0x124/0x300
>   do_el0_svc+0x44/0xc8
>   el0_svc+0x3c/0x1e8
>   el0t_64_sync_handler+0x88/0xb0
>   el0t_64_sync+0x16c/0x170
> 
> Changes since v1: 
> -Change the variable [length] type to unsigned, as Eric Dumazet suggested.
>   
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---
>  include/net/ipv6.h    | 4 ++--
>  net/ipv6/ip6_output.c | 8 ++++----
>  net/ipv6/udp.c        | 2 +-
>  net/l2tp/l2tp_ip6.c   | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index 5b38bf1a586b..de9dcc5652c4 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -1063,7 +1063,7 @@ int ip6_find_1stfragopt(struct sk_buff *skb, u8 **nexthdr);
>  int ip6_append_data(struct sock *sk,
>  		    int getfrag(void *from, char *to, int offset, int len,
>  				int odd, struct sk_buff *skb),
> -		    void *from, int length, int transhdrlen,
> +		    void *from, size_t length, int transhdrlen,
>  		    struct ipcm6_cookie *ipc6, struct flowi6 *fl6,
>  		    struct rt6_info *rt, unsigned int flags);
>  
> @@ -1079,7 +1079,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk, struct sk_buff_head *queue,
>  struct sk_buff *ip6_make_skb(struct sock *sk,
>  			     int getfrag(void *from, char *to, int offset,
>  					 int len, int odd, struct sk_buff *skb),
> -			     void *from, int length, int transhdrlen,
> +			     void *from, size_t length, int transhdrlen,
>  			     struct ipcm6_cookie *ipc6,
>  			     struct rt6_info *rt, unsigned int flags,
>  			     struct inet_cork_full *cork);
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 4081b12a01ff..7d47ddd1e1f2 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1450,7 +1450,7 @@ static int __ip6_append_data(struct sock *sk,
>  			     struct page_frag *pfrag,
>  			     int getfrag(void *from, char *to, int offset,
>  					 int len, int odd, struct sk_buff *skb),
> -			     void *from, int length, int transhdrlen,
> +			     void *from, size_t length, int transhdrlen,
>  			     unsigned int flags, struct ipcm6_cookie *ipc6)
>  {
>  	struct sk_buff *skb, *skb_prev = NULL;
> @@ -1798,7 +1798,7 @@ static int __ip6_append_data(struct sock *sk,
>  int ip6_append_data(struct sock *sk,
>  		    int getfrag(void *from, char *to, int offset, int len,
>  				int odd, struct sk_buff *skb),
> -		    void *from, int length, int transhdrlen,
> +		    void *from, size_t length, int transhdrlen,
>  		    struct ipcm6_cookie *ipc6, struct flowi6 *fl6,
>  		    struct rt6_info *rt, unsigned int flags)
>  {
> @@ -1995,13 +1995,13 @@ EXPORT_SYMBOL_GPL(ip6_flush_pending_frames);
>  struct sk_buff *ip6_make_skb(struct sock *sk,
>  			     int getfrag(void *from, char *to, int offset,
>  					 int len, int odd, struct sk_buff *skb),
> -			     void *from, int length, int transhdrlen,
> +			     void *from, size_t length, int transhdrlen,
>  			     struct ipcm6_cookie *ipc6, struct rt6_info *rt,
>  			     unsigned int flags, struct inet_cork_full *cork)
>  {
>  	struct inet6_cork v6_cork;
>  	struct sk_buff_head queue;
> -	int exthdrlen = (ipc6->opt ? ipc6->opt->opt_flen : 0);
> +	size_t exthdrlen = (ipc6->opt ? ipc6->opt->opt_flen : 0);

Is this the above line change needed? Why?

Thanks!

Paolo

