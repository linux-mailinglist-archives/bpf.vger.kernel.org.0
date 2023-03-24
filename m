Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9A76C879C
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 22:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjCXVpZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 17:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjCXVpY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 17:45:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339D61A679
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 14:45:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g187-20020a2520c4000000b00b74680a7904so2987223ybg.15
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 14:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679694319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dbOkGhvYXS9Ka4gC0+dDXm6O6a8TG9MqrjgEhgaFf2g=;
        b=ruUd5Y7rWctYItXoMs8yOoqVDdunTFcGzIYnW5k3GZL75VoVIVNCIJJcYTvq4Ij1bt
         HyrJsGhJxOGLumKvtWJGHI9I9C8NvRP699MAhJ3C/p49J4ms91/l4HWr6g2oJuCyqW8A
         TU2jPRFfhtw11mAFlc6+Tg8dxy0t7CPl9rTDlSLcbhMVE8Jz00d+voNRxEOCDZCCogAG
         NzQ66AB9bhNx4Z14sbGROye7QbC+b6ScwzWdLkrqxKuD7trVQRvtN+MPT2Y0AYjd/L6c
         PDMWFYyvHBl/2Ya4DLtHlKZ1zhoyGqEqOxr9AQ0ZtnB4hkNM/AAtaoeamWzsmBmLdWm1
         tGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679694319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbOkGhvYXS9Ka4gC0+dDXm6O6a8TG9MqrjgEhgaFf2g=;
        b=wwSSYIMyut9K7DNydzWh3hr2h1mBcBX+w5DDsfYde4HwmCrF1VO6taFoM3XYcIExZm
         hfwjj9T1BhZGHbSd4kxiqw1x1E2PQU78Eb8El+eVRQmb4vutT+uwUyrgWPoEwOQTYvVG
         6jsm8yowbucglR1uhWGHpFRpXHumUhvB3+Avx/Hu4xON6yP/2VO+QY9bFJ5iLcDQBlo1
         cBUz4631Ij3WYytHkqAw8pDo0tVzw8/Rvs2F4fk7wHVH1pVnGQIxdGYTNNXH1yrXL7je
         xhru0PIG1AiXY8xR5JI/tmrUALTJwD3fNsPlzO6Rcd2A+hOAmosdZzAIRVMaPP12ISEv
         4B4g==
X-Gm-Message-State: AAQBX9caR1DVJqYUMIyNB6YRVPzPPnVfWgtAVftUHaVs9NuQysrEDP5Z
        cymMWvSh/GZlFh+AWO+qEFtL0oI=
X-Google-Smtp-Source: AKy350bEmWQ+Rz5tSCe6HuZhgkGyZwbHP+Io9zds9NBzTOzJI2kZ0fKIHUvXP9Vt9YUcJ+iu8s8V2/0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:a742:0:b0:541:a0cc:2a09 with SMTP id
 e63-20020a81a742000000b00541a0cc2a09mr1834210ywh.7.1679694319515; Fri, 24 Mar
 2023 14:45:19 -0700 (PDT)
Date:   Fri, 24 Mar 2023 14:45:17 -0700
In-Reply-To: <20230323200633.3175753-4-aditi.ghag@isovalent.com>
Mime-Version: 1.0
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com> <20230323200633.3175753-4-aditi.ghag@isovalent.com>
Message-ID: <ZB4Z7cnF+RDMaKvW@google.com>
Subject: Re: [PATCH v4 bpf-next 3/4] bpf,tcp: Avoid taking fast sock lock in iterator
From:   Stanislav Fomichev <sdf@google.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/23, Aditi Ghag wrote:
> Previously, BPF TCP iterator was acquiring fast version of sock lock that
> disables the BH. This introduced a circular dependency with code paths  
> that
> later acquire sockets hash table bucket lock.
> Replace the fast version of sock lock with slow that faciliates BPF
> programs executed from the iterator to destroy TCP listening sockets
> using the bpf_sock_destroy kfunc.

> Here is a stack trace that motivated this change:

> ```
> 1) sock_lock with BH disabled + bucket lock

> lock_acquire+0xcd/0x330
> _raw_spin_lock_bh+0x38/0x50
> inet_unhash+0x96/0xd0
> tcp_set_state+0x6a/0x210
> tcp_abort+0x12b/0x230
> bpf_prog_f4110fb1100e26b5_iter_tcp6_server+0xa3/0xaa
> bpf_iter_run_prog+0x1ff/0x340
> bpf_iter_tcp_seq_show+0xca/0x190
> bpf_seq_read+0x177/0x450
> vfs_read+0xc6/0x300
> ksys_read+0x69/0xf0
> do_syscall_64+0x3c/0x90
> entry_SYSCALL_64_after_hwframe+0x72/0xdc

> 2) sock lock with BH enable

> [    1.499968]   lock_acquire+0xcd/0x330
> [    1.500316]   _raw_spin_lock+0x33/0x40
> [    1.500670]   sk_clone_lock+0x146/0x520
> [    1.501030]   inet_csk_clone_lock+0x1b/0x110
> [    1.501433]   tcp_create_openreq_child+0x22/0x3f0
> [    1.501873]   tcp_v6_syn_recv_sock+0x96/0x940
> [    1.502284]   tcp_check_req+0x137/0x660
> [    1.502646]   tcp_v6_rcv+0xa63/0xe80
> [    1.502994]   ip6_protocol_deliver_rcu+0x78/0x590
> [    1.503434]   ip6_input_finish+0x72/0x140
> [    1.503818]   __netif_receive_skb_one_core+0x63/0xa0
> [    1.504281]   process_backlog+0x79/0x260
> [    1.504668]   __napi_poll.constprop.0+0x27/0x170
> [    1.505104]   net_rx_action+0x14a/0x2a0
> [    1.505469]   __do_softirq+0x165/0x510
> [    1.505842]   do_softirq+0xcd/0x100
> [    1.506172]   __local_bh_enable_ip+0xcc/0xf0
> [    1.506588]   ip6_finish_output2+0x2a8/0xb00
> [    1.506988]   ip6_finish_output+0x274/0x510
> [    1.507377]   ip6_xmit+0x319/0x9b0
> [    1.507726]   inet6_csk_xmit+0x12b/0x2b0
> [    1.508096]   __tcp_transmit_skb+0x549/0xc40
> [    1.508498]   tcp_rcv_state_process+0x362/0x1180

> ```

> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

Don't need fixes because it doesn't trigger without your new
bpf_sock_destroy?


> ---
>   net/ipv4/tcp_ipv4.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index ea370afa70ed..f2d370a9450f 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -2962,7 +2962,6 @@ static int bpf_iter_tcp_seq_show(struct seq_file  
> *seq, void *v)
>   	struct bpf_iter_meta meta;
>   	struct bpf_prog *prog;
>   	struct sock *sk = v;
> -	bool slow;
>   	uid_t uid;
>   	int ret;

> @@ -2970,7 +2969,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file  
> *seq, void *v)
>   		return 0;

>   	if (sk_fullsock(sk))
> -		slow = lock_sock_fast(sk);
> +		lock_sock(sk);

>   	if (unlikely(sk_unhashed(sk))) {
>   		ret = SEQ_SKIP;
> @@ -2994,7 +2993,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file  
> *seq, void *v)

>   unlock:
>   	if (sk_fullsock(sk))
> -		unlock_sock_fast(sk, slow);
> +		release_sock(sk);
>   	return ret;

>   }
> --
> 2.34.1

