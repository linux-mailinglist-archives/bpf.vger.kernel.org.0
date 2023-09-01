Return-Path: <bpf+bounces-9123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7021C79031A
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 23:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D8F281980
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 21:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0053F9FB;
	Fri,  1 Sep 2023 21:20:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A049FAD53;
	Fri,  1 Sep 2023 21:20:27 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D93E1BEA;
	Fri,  1 Sep 2023 14:20:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so307199366b.3;
        Fri, 01 Sep 2023 14:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693603224; x=1694208024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4dldIwgNEpPQFglzCzo8pFQ3UovGlXL2/K3eeqVnTg=;
        b=F+DfKIIBNX3I+GY7ZkCuBQ6kCkToh52JxyqwLoOPlItQf+7GvHynw1gLMOPaI9o4fW
         FUx8AyHzkmrd8DAR+9RcMSdudnbxjc3RffT5T6Y9cDDE06/FM53/XUR2FCG/hTaQMRt6
         TH3wigigdSdbBOUFfF1vBcA0q+fyddIBxLT4+9s0oForwMocmEJaopz2iZ539EaMuzdA
         4B5hU+3uYcnuFzGGppT8Q94U+yZdrcg936e4jB2eSJ+7UOqDNOdufrfRbvetDZ32Q/Tn
         XEwZbvC2YXLRqOKfiCxOHTBnWTh9XB3q/GCxOGL3BPrebD2rj6iaGf8K0DDtIY2vDY/v
         AAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693603224; x=1694208024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4dldIwgNEpPQFglzCzo8pFQ3UovGlXL2/K3eeqVnTg=;
        b=klQlD0kwnjP1kA7PLCixVoTM3ozAlLEDEB1BlMnStlDv0wHQuhQhp1weM1HoKKyEsm
         aD1P3KIv5zOT+tuETuMOpVLXepNs2WlmkSrGA92GlWCT8mZV0i8ZFdbagrxqOanRQrB7
         5NlMnop3u6CXaGllIO5/eHoCRroEb9RA0wbj9v9f9thYSrNwpj9qcpyzTiUqcx/JgW6K
         DCxlzRYk7gGYq572T1XYo7D+1OpAaQfQgoc9NsEDz5U8WH02bMv3E1e/YQnKjkg6JXH/
         hfBHG6DqWiTuSMZEt1PVB7/A2ImvghOKgVPtg0bCoRDC4WhLia6PzRIzTSRenxiuLkfU
         7vTg==
X-Gm-Message-State: AOJu0YzaG9gKitaaN/Oo6V/G9zT7OMYetVIgYG2v3on6rVNVtol+Xd6G
	q9vMQ5f3DsNefwiitpqXOk6FXhpq9fI=
X-Google-Smtp-Source: AGHT+IFVb1D850RV7+VoqBViGyDgMTXGfWyc5GyZtVZuhSq1vhXMXqSGw62BuiXEU1lDQeFb20IcMA==
X-Received: by 2002:a17:907:7751:b0:9a2:28dc:4168 with SMTP id kx17-20020a170907775100b009a228dc4168mr2789290ejc.61.1693603223600;
        Fri, 01 Sep 2023 14:20:23 -0700 (PDT)
Received: from krava ([83.240.63.222])
        by smtp.gmail.com with ESMTPSA id p27-20020a17090635db00b00991d54db2acsm2471947ejb.44.2023.09.01.14.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 14:20:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 1 Sep 2023 23:20:20 +0200
To: John Fastabend <john.fastabend@gmail.com>
Cc: olsajiri@gmail.com, xukuohai@huawei.com, eddyz87@gmail.com,
	edumazet@google.com, cong.wang@bytedance.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: sockmap, fix skb refcnt race after locking
 changes
Message-ID: <ZPJVlLXB/mggaLh5@krava>
References: <20230901202137.214666-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901202137.214666-1-john.fastabend@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 01, 2023 at 01:21:37PM -0700, John Fastabend wrote:
> There is a race where skb's from the sk_psock_backlog can be referenced
> after userspace side has already skb_consumed() the sk_buff and its
> refcnt dropped to zer0 causing use after free.
> 
> The flow is the following,
> 
>   while ((skb = skb_peek(&psock->ingress_skb))
>     sk_psock_handle_Skb(psock, skb, ..., ingress)
>     if (!ingress) ...
>     sk_psock_skb_ingress
>        sk_psock_skb_ingress_enqueue(skb)
>           msg->skb = skb
>           sk_psock_queue_msg(psock, msg)
>     skb_dequeue(&psock->ingress_skb)
> 
> The sk_psock_queue_msg() puts the msg on the ingress_msg queue. This is
> what the application reads when recvmsg() is called. An application can
> read this anytime after the msg is placed on the queue. The recvmsg
> hook will also read msg->skb and then after user space reads the msg
> will call consume_skb(skb) on it effectively free'ing it.
> 
> But, the race is in above where backlog queue still has a reference to
> the skb and calls skb_dequeue(). If the skb_dequeue happens after the
> user reads and free's the skb we have a use after free.
> 
> The !ingress case does not suffer from this problem because it uses
> sendmsg_*(sk, msg) which does not pass the sk_buff further down the
> stack.
> 
> The following splat was observed with 'test_progs -t sockmap_listen':
> 
> [ 1022.710250][ T2556] general protection fault, ...
>  ...
> [ 1022.712830][ T2556] Workqueue: events sk_psock_backlog
> [ 1022.713262][ T2556] RIP: 0010:skb_dequeue+0x4c/0x80
> [ 1022.713653][ T2556] Code: ...
>  ...
> [ 1022.720699][ T2556] Call Trace:
> [ 1022.720984][ T2556]  <TASK>
> [ 1022.721254][ T2556]  ? die_addr+0x32/0x80^M
> [ 1022.721589][ T2556]  ? exc_general_protection+0x25a/0x4b0
> [ 1022.722026][ T2556]  ? asm_exc_general_protection+0x22/0x30
> [ 1022.722489][ T2556]  ? skb_dequeue+0x4c/0x80
> [ 1022.722854][ T2556]  sk_psock_backlog+0x27a/0x300
> [ 1022.723243][ T2556]  process_one_work+0x2a7/0x5b0
> [ 1022.723633][ T2556]  worker_thread+0x4f/0x3a0
> [ 1022.723998][ T2556]  ? __pfx_worker_thread+0x10/0x10
> [ 1022.724386][ T2556]  kthread+0xfd/0x130
> [ 1022.724709][ T2556]  ? __pfx_kthread+0x10/0x10
> [ 1022.725066][ T2556]  ret_from_fork+0x2d/0x50
> [ 1022.725409][ T2556]  ? __pfx_kthread+0x10/0x10
> [ 1022.725799][ T2556]  ret_from_fork_asm+0x1b/0x30
> [ 1022.726201][ T2556]  </TASK>
> 
> To fix we add an skb_get() before passing the skb to be enqueued in
> the engress queue. This bumps the skb->users refcnt so that consume_skb
> and kfree_skb will not immediately free the sk_buff. With this we can
> be sure the skb is still around when we do the dequeue. Then we just
> need to decrement the refcnt or free the skb in the backlog case which
> we do by calling kfree_skb() on the ingress case as well as the sendmsg
> case.
> 
> Before locking change from fixes tag we had the sock locked so we
> couldn't race with user and there was no issue here.
> 
> Fixes: 799aa7f98d53e (skmsg: Avoid lock_sock() in sk_psock_backlog())
> Reported-by: Jiri Olsa  <jolsa@kernel.org>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  net/core/skmsg.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index a0659fc29bcc..6c31eefbd777 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -612,12 +612,18 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
>  static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
>  			       u32 off, u32 len, bool ingress)
>  {
> +	int err = 0;
> +
>  	if (!ingress) {
>  		if (!sock_writeable(psock->sk))
>  			return -EAGAIN;
>  		return skb_send_sock(psock->sk, skb, off, len);
>  	}
> -	return sk_psock_skb_ingress(psock, skb, off, len);
> +	skb_get(skb);
> +	err = sk_psock_skb_ingress(psock, skb, off, len);
> +	if (err < 0)
> +		kfree_skb(skb);
> +	return err;
>  }
>  
>  static void sk_psock_skb_state(struct sk_psock *psock,
> @@ -685,9 +691,7 @@ static void sk_psock_backlog(struct work_struct *work)
>  		} while (len);
>  
>  		skb = skb_dequeue(&psock->ingress_skb);
> -		if (!ingress) {
> -			kfree_skb(skb);
> -		}
> +		kfree_skb(skb);
>  	}
>  end:
>  	mutex_unlock(&psock->work_mutex);
> -- 
> 2.33.0
> 

there's no crash wit with fix, but I noticed I occasionally get FAIL

#212/78  sockmap_listen/sockmap Unix test_unix_redir:OK
./test_progs:vsock_unix_redir_connectible:1501: ingress: write: Transport endpoint is not connected
vsock_unix_redir_connectible:FAIL:1501
./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
vsock_unix_redir_connectible:FAIL:1501
#212/79  sockmap_listen/sockmap VSOCK test_vsock_redir:FAIL
#212/80  sockmap_listen/sockhash IPv4 TCP test_insert_invalid:OK

no idea if it's related

jirka

