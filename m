Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCF6595D7A
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 15:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiHPNhG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 09:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbiHPNhF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 09:37:05 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BB96BCE2
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 06:37:02 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g21so4401875qka.5
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 06:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=h7XZUh4pcD7ssomSIPnFHEFK+MI/fUtvM+ERSPwsmlI=;
        b=FLgZD7SnarqyFLEScMLmSpRfpLiu2ZSm87XTxPgz5IeWBYruh+fVGMycazoJh/LS1y
         KZrg4hDjDdvPvB9cMSt8i/BaXgIRkLgD+awINz4MXbi2lFhjBicVsYzrhDb1LDrGDZC2
         Vb+fvCd8JkOi12q+rhMyvKn2Y0TgbRa5kVTcaMNPBxJS/atmXKRW4lcCqPeh5bqQb2RV
         1Twu2P7MyxGC2u+3XLc3+cOvm8k5n+GYGB6t0WhP9CJ0QtO7BH8Tb8gynmDwP8OmteKB
         K9hlTZN9uynxPr9tL+iLmT1cnJFRD0+Dks9kG6PInHUyQwEf8631Pme0tTnyBhMEMa2L
         MPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=h7XZUh4pcD7ssomSIPnFHEFK+MI/fUtvM+ERSPwsmlI=;
        b=PbajOXTacixe56Q6ar6BVCBVtmgAeC63rSnhJvxvgP9byKBRA2A3fX0VhtR2qB4HQA
         QnKxVrO8N95qlDv07vRP9jusMe96xJInq5VMxtyFYxN58AW56SnMNsGMpQtg0PQ6vQrW
         bFzfqUC7gKO4ul5jlgvxlem4R7Q9QdvwHwFsjxPAYuyAiAfA55WFv6DSCmi0Krj5TPaU
         3bBabNZtJ3UoY0dB1si3qb0qoS6S4frdr6lD42EGMG+F+q98wZ1nifiEAAbUEQSMttYh
         XfW6Gqvs7o7f4FMg7g71pYsMhJlSgJ4YH16/XrY9LJNrrOr2kpwQCKh7PNWANNyCU4an
         EHJg==
X-Gm-Message-State: ACgBeo0FU0X05Dhx4fr4hsDqEKNUoU6sHICScBS68z2DELOi3YUraSKj
        fjcPdTa96s7JPLWk9KUsTZDy18zrsv2sR6KpEaQOmw==
X-Google-Smtp-Source: AA6agR56MQhc8yY/e4J0iQxfMP/yjqWm+aaFIbXvhMb7fV1byW+RjJFaDggwE3FWTxkfzhYnN1CczW5iFfsbz4BwuiA=
X-Received: by 2002:a05:620a:410c:b0:6b2:82d8:dcae with SMTP id
 j12-20020a05620a410c00b006b282d8dcaemr14704044qko.259.1660657021099; Tue, 16
 Aug 2022 06:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220815202900.3961097-1-jmeng@fb.com>
In-Reply-To: <20220815202900.3961097-1-jmeng@fb.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Tue, 16 Aug 2022 09:36:44 -0400
Message-ID: <CADVnQy=hav-cLt5Dy0DBPiDCxgkpRCEktEoMNjq_uKG8hynLPg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Make SYN ACK RTO tunable by BPF programs
 with TFO
To:     Jie Meng <jmeng@fb.com>
Cc:     netdev@vger.kernel.org, kafai@fb.com, kuba@kernel.org,
        edumazet@google.com, bpf@vger.kernel.org,
        Yuchung Cheng <ycheng@google.com>, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 8:30 PM Jie Meng <jmeng@fb.com> wrote:
>
> Instead of the hardcoded TCP_TIMEOUT_INIT, this diff calls tcp_timeout_init
> to initiate req->timeout like the non TFO SYN ACK case.
>
> Tested using the following packetdrill script, on a host with a BPF
> program that sets the initial connect timeout to 10ms.
>
> `../../common/defaults.sh`
>
> // Initialize connection
>     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
>    +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
>    +0 bind(3, ..., ...) = 0
>    +0 listen(3, 1) = 0
>
>    +0 < S 0:0(0) win 32792 <mss 1000,sackOK,FO TFO_COOKIE>
>    +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
>    +.01 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
>    +.02 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
>    +.04 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
>    +.01 < . 1:1(0) ack 1 win 32792
>
>    +0 accept(3, ..., ...) = 4
>
> Signed-off-by: Jie Meng <jmeng@fb.com>
> ---
>  net/ipv4/tcp_fastopen.c | 3 ++-
>  net/ipv4/tcp_timer.c    | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 825b216d11f5..45cc7f1ca296 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -272,8 +272,9 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
>          * The request socket is not added to the ehash
>          * because it's been added to the accept queue directly.
>          */
> +       req->timeout = tcp_timeout_init(child);
>         inet_csk_reset_xmit_timer(child, ICSK_TIME_RETRANS,
> -                                 TCP_TIMEOUT_INIT, TCP_RTO_MAX);
> +                                 req->timeout, TCP_RTO_MAX);
>
>         refcount_set(&req->rsk_refcnt, 2);
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index b4dfb82d6ecb..cb79127f45c3 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -428,7 +428,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
>         if (!tp->retrans_stamp)
>                 tp->retrans_stamp = tcp_time_stamp(tp);
>         inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
> -                         TCP_TIMEOUT_INIT << req->num_timeout, TCP_RTO_MAX);
> +                         req->timeout << req->num_timeout, TCP_RTO_MAX);
>  }
>
>
> --

Looks good to me. Thanks for the feature!

Acked-by: Neal Cardwell <ncardwell@google.com>

neal
