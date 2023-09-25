Return-Path: <bpf+bounces-10764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6197ADEAB
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 20:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 199E1281707
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 18:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83613224F0;
	Mon, 25 Sep 2023 18:27:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A99224CA;
	Mon, 25 Sep 2023 18:27:36 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAD295;
	Mon, 25 Sep 2023 11:27:34 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bf58009a8dso4353746a34.1;
        Mon, 25 Sep 2023 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695666454; x=1696271254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hORITzYCrCj4rLhQhCGh606G9+/re5bZyItzl2r+Jjw=;
        b=B7qjSkIKyyjJgclQzFXrmqEp6H0IPyBDdviQo6W1qNfYtSXEtvogQWA6gUrNODQVyu
         0sYiaE26+sRJV8Z5/f/sTn85M29bx9BKZtHC1yqHhaPufhqRRbooadOIJHLw/UhBQBKL
         6BgnNm0Eui595fS+a7/pUgjuOCtDXYdGDepA5w/B2u98TOzpEnSi6ODx66uSpZZLZS72
         SrVXalvvbZoF1jZy/M8wZ1C96S7fDeYCCqYCEFU1jDoFJqw/Mn0StnoKMbEsWN59vmy2
         1DzdEuVCBRZG+5dLC9JLR2+xv9jXGoaD9uRmodA0CTs/FNcjmOOilQq2SWHpD4vYiwNl
         g7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695666454; x=1696271254;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hORITzYCrCj4rLhQhCGh606G9+/re5bZyItzl2r+Jjw=;
        b=TKq373NEbJdaQtwxAs25rEzi6n2qIL4YL5oAb9C+XHOTY8+0rgQg5adZIBurDy2f7x
         gHTm+hnyPKh3HMNo3zWGKBYwsGV44GG3pzSRsbI/2dUKtDZ2Im3cIGAruSGezIJ8nITm
         iL9qyrmIHhlyvx2dzQ071InKFLgGYkHtoerqUy/ZXZ0UCzYjAHOiPa7XjNxAkrzhEFvj
         /MqYNnmRasUePCM/PdV/uMxciNDndDD9jSeT0HuF/n+AIk0BQB4JAB1H4bRTy9NshEZt
         1eoOXzoLFBozC2wQO1ZFBJXcnBHVtH5bhIxa/jlP2MnwsAHWKsKQLAVKAkqBq0UQ7/E1
         5YAA==
X-Gm-Message-State: AOJu0YyMw6n9KWAbc31S3EcplhCDrECRwJ0NllQm4ArCMxmTKLby0x3p
	7AS6jO74XkoRMXuuiBbX/mRkKNOc8Ls=
X-Google-Smtp-Source: AGHT+IETQ+D4lE/eOVkhNhtvqvSBiHvKSq2Yx+ZFEpXDng3OTbYWEMx9xVDZhp3XYlfyl+BYhjdihA==
X-Received: by 2002:a05:6830:2004:b0:6bd:63b:4b21 with SMTP id e4-20020a056830200400b006bd063b4b21mr7799078otp.15.1695666454009;
        Mon, 25 Sep 2023 11:27:34 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba00:51e:699c:e63:c15a])
        by smtp.gmail.com with ESMTPSA id g1-20020a62e301000000b0068bbd43a6e2sm8632708pfh.10.2023.09.25.11.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:27:33 -0700 (PDT)
Date: Mon, 25 Sep 2023 11:27:32 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, 
 kernel-team@cloudflare.com, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Cong Wang <cong.wang@bytedance.com>
Message-ID: <6511d1143dc59_110e52088a@john.notmuch>
In-Reply-To: <20230920102055.42662-1-jakub@cloudflare.com>
References: <20230920102055.42662-1-jakub@cloudflare.com>
Subject: RE: [PATCH bpf] bpf, sockmap: Reject sk_msg egress redirects to
 non-TCP sockets
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Sitnicki wrote:
> With a SOCKMAP/SOCKHASH map and an sk_msg program user can steer messages
> sent from one TCP socket (s1) to actually egress from another TCP
> socket (s2):
> 
> tcp_bpf_sendmsg(s1)		// = sk_prot->sendmsg
>   tcp_bpf_send_verdict(s1)	// __SK_REDIRECT case
>     tcp_bpf_sendmsg_redir(s2)
>       tcp_bpf_push_locked(s2)
> 	tcp_bpf_push(s2)
> 	  tcp_rate_check_app_limited(s2) // expects tcp_sock
> 	  tcp_sendmsg_locked(s2)	 // ditto
> 
> There is a hard-coded assumption in the call-chain, that the egress
> socket (s2) is a TCP socket.
> 
> However in commit 122e6c79efe1 ("sock_map: Update sock type checks for
> UDP") we have enabled redirects to non-TCP sockets. This was done for the
> sake of BPF sk_skb programs. There was no indention to support sk_msg
> send-to-egress use case.
> 
> As a result, attempts to send-to-egress through a non-TCP socket lead to a
> crash due to invalid downcast from sock to tcp_sock:
> 
>  BUG: kernel NULL pointer dereference, address: 000000000000002f
>  ...
>  Call Trace:
>   <TASK>
>   ? show_regs+0x60/0x70
>   ? __die+0x1f/0x70
>   ? page_fault_oops+0x80/0x160
>   ? do_user_addr_fault+0x2d7/0x800
>   ? rcu_is_watching+0x11/0x50
>   ? exc_page_fault+0x70/0x1c0
>   ? asm_exc_page_fault+0x27/0x30
>   ? tcp_tso_segs+0x14/0xa0
>   tcp_write_xmit+0x67/0xce0
>   __tcp_push_pending_frames+0x32/0xf0
>   tcp_push+0x107/0x140
>   tcp_sendmsg_locked+0x99f/0xbb0
>   tcp_bpf_push+0x19d/0x3a0
>   tcp_bpf_sendmsg_redir+0x55/0xd0
>   tcp_bpf_send_verdict+0x407/0x550
>   tcp_bpf_sendmsg+0x1a1/0x390
>   inet_sendmsg+0x6a/0x70
>   sock_sendmsg+0x9d/0xc0
>   ? sockfd_lookup_light+0x12/0x80
>   __sys_sendto+0x10e/0x160
>   ? syscall_enter_from_user_mode+0x20/0x60
>   ? __this_cpu_preempt_check+0x13/0x20
>   ? lockdep_hardirqs_on+0x82/0x110
>   __x64_sys_sendto+0x1f/0x30
>   do_syscall_64+0x38/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Reject selecting a non-TCP sockets as redirect target from a BPF sk_msg
> program to prevent the crash. When attempted, user will receive an EACCES
> error from send/sendto/sendmsg() syscall.
> 
> Fixes: 122e6c79efe1 ("sock_map: Update sock type checks for UDP")
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
> FYI, I'm working on revamping the sockmap_listen selftest, which exercises
> some of redirect combinations, to cover the whole combination matrix so
> that we can catch these kinds of problems early on.

Yes this would be appreciated.

> 
>  net/core/sock_map.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index cb11750b1df5..4292c2ed1828 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -668,6 +668,8 @@ BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *, msg,
>  	sk = __sock_map_lookup_elem(map, key);
>  	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
>  		return SK_DROP;
> +	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
> +		return SK_DROP;
>  
>  	msg->flags = flags;
>  	msg->sk_redir = sk;
> @@ -1267,6 +1269,8 @@ BPF_CALL_4(bpf_msg_redirect_hash, struct sk_msg *, msg,
>  	sk = __sock_hash_lookup_elem(map, key);
>  	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
>  		return SK_DROP;
> +	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
> +		return SK_DROP;

As a stop gap I think this is fine. If anyone wants to add support though
I do think as a use case it would make sense to redirect TCP into an
AF_UNIX socket and vice versa.

Acked-by: John Fastabend <john.fastabend@gmail.com>

