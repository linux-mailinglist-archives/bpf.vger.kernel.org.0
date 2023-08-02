Return-Path: <bpf+bounces-6671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3CA76C34A
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 05:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61001281B6A
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 03:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C2CEA5;
	Wed,  2 Aug 2023 03:04:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E1A40;
	Wed,  2 Aug 2023 03:04:13 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B85B272B;
	Tue,  1 Aug 2023 20:04:11 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686b643df5dso4517143b3a.1;
        Tue, 01 Aug 2023 20:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690945450; x=1691550250;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2afhM0nZYzEtfKChrLu1PZLw4Km118Jq79AW9hzH33c=;
        b=W0xBdSvO7y3PiJ5YCryMmqlKYyAzlrX0c/CkknRSuWa/qcy0ElubyvsJLQ+VVPAlEs
         QJuR8Ghn6A99rxR+3ny6TsMtVXTsmJzpFDIUMU+DvOXro83w7Xtadf7zFJ4HusqKfi60
         b7RiQ4a2aRvVCdd7DrBXfrNCgOgXj2NxqVMX4sKj7j7QbLIX6LqvYmNVN7+05Xl12lfg
         VDjZCiVrVPi05arzhH75pw/I785yoWBQ112B/rERCjb9wjZVN54evwT5ClqyL5MmkAek
         Q6YXIMINr9UKG94JRp9A4f2+u4/gn6SJyBAggXQ49/bh1oyiRDUK9lPayMd3N+ZfXDOn
         jhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690945450; x=1691550250;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2afhM0nZYzEtfKChrLu1PZLw4Km118Jq79AW9hzH33c=;
        b=kdjxJ+qTnF+rM7ZS6TPMvMkwO+s8FdcTVE/iwXkJxZyeOg4RZBxdczU2AP4XKqCoZt
         8zlobDggh/KC7DXeMvkQk8JqjORNMh2PqrGk2a1Yp8j1I3VXHeSbuwBQokQHgQMADPqS
         TvznxyrFhJb4IcctCt2luinfF9FKN5Be3IFLZaNsnLJ/h/ABUNbzYrqPQOUgbcn1AgiL
         MLC0AuHi5xyUIBBE9Llc++Vz+/awh4K98YrIff7fdJtNRAFHfhrhHDvjlcOVc9vctTJy
         exBqUCaXjnW5jRebCA1bMckG20S0ixhs/67ZpqlDGbytKOVDKm8iaz/H9sFU8W4psh7n
         BzpA==
X-Gm-Message-State: ABy/qLZtXiz5dp2Jqb5pRrSxy4zxu3n0WxSzkApibArRLn0ZGp7XzlsK
	uRlrgEao/uEIbnDSbClg8BA=
X-Google-Smtp-Source: APBJJlE6RPN2t6sd1fl2nx74pX3gKiPPRu5toAxPMJSCMtzoBw7DE1DA59Wk1A+BT3zYMNW7LYaWtA==
X-Received: by 2002:a05:6a20:9195:b0:135:38b5:7e58 with SMTP id v21-20020a056a20919500b0013538b57e58mr14731006pzd.37.1690945449534;
        Tue, 01 Aug 2023 20:04:09 -0700 (PDT)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm11104289plb.195.2023.08.01.20.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 20:04:08 -0700 (PDT)
Date: Tue, 01 Aug 2023 20:04:07 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>
Message-ID: <64c9c7a788bad_2c0b20833@john.notmuch>
In-Reply-To: <20230731134536.4058181-1-xukuohai@huaweicloud.com>
References: <20230731134536.4058181-1-xukuohai@huaweicloud.com>
Subject: RE: [PATCH bpf] bpf, sockmap: Fix NULL deref in sk_psock_backlog
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> sk_psock_backlog triggers a NULL dereference:
> 
>  BUG: kernel NULL pointer dereference, address: 000000000000000e
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] PREEMPT SMP PTI
>  CPU: 0 PID: 70 Comm: kworker/0:3 Not tainted 6.5.0-rc2-00585-gb11bbbe4c66e #26
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-p4
>  Workqueue: events sk_psock_backlog
>  RIP: 0010:0xffffffffc0205254
>  Code: 00 00 48 89 94 24 a0 00 00 00 41 5f 41 5e 41 5d 41 5c 5d 5b 41 5b 41 5a 41 59 41 50
>  RSP: 0018:ffffc90000acbcb8 EFLAGS: 00010246
>  RAX: ffffffff81c5ee10 RBX: ffff888018260000 RCX: 0000000000000001
>  RDX: 0000000000000003 RSI: ffffc90000acbd58 RDI: 0000000000000000
>  RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000080100005
>  R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000003
>  R13: 0000000000000000 R14: 0000000000000021 R15: 0000000000000003
>  FS:  0000000000000000(0000) GS:ffff88803ea00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000000000000000e CR3: 000000000b0de002 CR4: 0000000000170ef0
>  Call Trace:
>   <TASK>
>   ? __die+0x24/0x70
>   ? page_fault_oops+0x15d/0x480
>   ? fixup_exception+0x26/0x330
>   ? exc_page_fault+0x72/0x1d0
>   ? asm_exc_page_fault+0x26/0x30
>   ? __pfx_inet_sendmsg+0x10/0x10
>   ? 0xffffffffc0205254
>   ? inet_sendmsg+0x20/0x80
>   ? sock_sendmsg+0x8f/0xa0
>   ? __skb_send_sock+0x315/0x360
>   ? __pfx_sendmsg_unlocked+0x10/0x10
>   ? sk_psock_backlog+0xb4/0x300
>   ? process_one_work+0x292/0x560
>   ? worker_thread+0x53/0x3e0
>   ? __pfx_worker_thread+0x10/0x10
>   ? kthread+0x102/0x130
>   ? __pfx_kthread+0x10/0x10
>   ? ret_from_fork+0x34/0x50
>   ? __pfx_kthread+0x10/0x10
>   ? ret_from_fork_asm+0x1b/0x30
>   </TASK>
> 
> The bug flow is as follows:
> 
> thread 1                                   thread 2
> 
> sk_psock_backlog                           sock_close
>   sk_psock_handle_skb                        __sock_release
>     __skb_send_sock                            inet_release
>       sendmsg_unlocked                           tcp_close
>         sock_sendmsg                               lock_sock
>                                                      __tcp_close
>                                                    release_sock
>                                                  sock->sk = NULL // (1)
>           inet_sendmsg
>             sk = sock->sk // (2)
>             inet_send_prepare
>               inet_sk(sk)->inet_num // (3)

We are doing a lot of hoping through calls here to find something we
should already know. We know the psock we are sending has a protocol
of tcp, udp, ... and could call the send directly instead of walking
back into the sk_socket and so on. For tcp example we could simply
call tcp_sendmsg(sk, msg, size).

I haven't tried it yet, but I wonder if a lot of this logic gets
easier to reason about if we have per protocol backlog logic. Its
just a hunch at this point though.

> 
> sock->sk is set to NULL by thread 2 at time (1), then fetched by
> thread 1 at time (2), and used by thread 1 to access memory at
> time (3), resulting in NULL pointer dereference.
> 
> To fix it, add lock_sock back on the egress path for sk_psock_handle_skb.
> 
> Fixes: 799aa7f98d53 ("skmsg: Avoid lock_sock() in sk_psock_backlog()")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  net/core/skmsg.c | 44 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 7c2764beeb04..8b758c51aa0d 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -609,15 +609,42 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
>  	return err;
>  }
>  
> +static int sk_psock_handle_ingress_skb(struct sk_psock *psock,
> +				       struct sk_buff *skb,
> +				       u32 off, u32 len)
> +{
> +	if (sock_flag(psock->sk, SOCK_DEAD))
> +		return -EIO;

We didn't previously have the SOCK_DEAD check on ingress which
looks fine because we will come along and flush the ingress
queue when psock is being torn down. Adding it looks fine
though because __tcp_close is flushing the sk_receive_queue
and detaching the user from the socket so we have no way
to read the data anyways. This will then abort the backlog
which moves the psock destruct op along a bit faster.

> +	return sk_psock_skb_ingress(psock, skb, off, len);
> +}
> +
> +static int sk_psock_handle_egress_skb(struct sk_psock *psock,
> +				      struct sk_buff *skb,
> +				      u32 off, u32 len)
> +{
> +	int ret;
> +
> +	lock_sock(psock->sk);
> +
> +	if (sock_flag(psock->sk, SOCK_DEAD))
> +		ret = -EIO;

OK, the sock_orphan() call from tcp_close adjudge_to_death block will set
the SOCK_DEAD flag and ensure we abort the send here. EIO then forces
backlog to abort. This looks correct to me.

> +	else if (!sock_writeable(psock->sk))
> +		ret = -EAGAIN;
> +	else
> +		ret = skb_send_sock_locked(psock->sk, skb, off, len);
> +
> +	release_sock(psock->sk);
> +
> +	return ret;
> +}
> +
>  static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
>  			       u32 off, u32 len, bool ingress)
>  {
> -	if (!ingress) {
> -		if (!sock_writeable(psock->sk))
> -			return -EAGAIN;
> -		return skb_send_sock(psock->sk, skb, off, len);
> -	}
> -	return sk_psock_skb_ingress(psock, skb, off, len);
> +	if (ingress)
> +		return sk_psock_handle_ingress_skb(psock, skb, off, len);
> +	else
> +		return sk_psock_handle_egress_skb(psock, skb, off, len);
>  }
>  
>  static void sk_psock_skb_state(struct sk_psock *psock,
> @@ -660,10 +687,7 @@ static void sk_psock_backlog(struct work_struct *work)
>  		ingress = skb_bpf_ingress(skb);
>  		skb_bpf_redirect_clear(skb);
>  		do {
> -			ret = -EIO;
> -			if (!sock_flag(psock->sk, SOCK_DEAD))
> -				ret = sk_psock_handle_skb(psock, skb, off,
> -							  len, ingress);
> +			ret = sk_psock_handle_skb(psock, skb, off, len, ingress);
>  			if (ret <= 0) {
>  				if (ret == -EAGAIN) {
>  					sk_psock_skb_state(psock, state, len, off);

OK LGTM nice catch I left my commentary above that helped as I reviewed it. I
guess we need more stress testing along this path all of our testing is on
ingress path at the moment. Do you happen to have something coded up that
stress tests the redirect send paths?

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

