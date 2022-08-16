Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0078595FE6
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 18:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiHPQMO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 12:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbiHPQMM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 12:12:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299302714D
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 09:12:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z12so13191246wrs.9
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JyzOLGSlDwwbHl4waiYBkNo2oWmpsDaSyKB5IE9eaoM=;
        b=gIhN7l/LFMqiLxmyLKRiT+ItUNIwnj5A87Eh5I/EabUrnRXCmIjaX/nFst1hQNH+XQ
         zqLjhVB/Iq1GW2apk345iw0x5I8VqyVafr7OmfOZyeuEToiWAviAZ3Ti09CFaWFnsEd1
         fOiJYcsY7XTD3wGclRim40ZJPKguHccsRC2cWXJviDNqm0EE9dFvbRPzIGinid4LBa1U
         CSNqkfUhDxveYBPtBCXkZedq3GM5SgWGwleAz0H87AgNnsIGBqV2h/wCDt6FI00IcWTi
         eCZvWNHh0DTD8wK/jKVhFXmWNcJ/RaLVfTpDdirROapGn5e/NfIp73LJbREwsIAz4ZcJ
         hVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JyzOLGSlDwwbHl4waiYBkNo2oWmpsDaSyKB5IE9eaoM=;
        b=U27Vm3CnQxEqzcBnY+U2eagjfWoFSLS9IAPChJF4tFOCR9MtqUTjpvmcAu6mDCS7W4
         XnrWMi72FctwPcSyrQlD+UMRfeb7EH5vukQsI2Lu+s+4QAQMPN8AcM/eVpPaSbr8Vi3K
         13AIoPmkdGg7nZHWQGoKnKsKU15ArqiouBkvRpzHRU7y2UQmeMOY9vMqqw8LISox56F4
         qB0UYNlNLm/f/zkDmqcHkWn/hzCcVhn0RrILgefufuGG3b3YVB30jaghH13VhFJeDLX3
         4mZTBaXzhUS6jwxgufW8WzSEt/NH+qKGHsudVQcIlJJ/ZFWGobWnuYa8Ijkqj189z41X
         4iNg==
X-Gm-Message-State: ACgBeo3BD2VhPpekMoewR0l0WVv4Pz4NdHsOgjUHOojVGG5HATUaQ7Tq
        neIJ0U+WEbUKtyOl+qbEFb8gH1SGACUxONghqZqajQ==
X-Google-Smtp-Source: AA6agR5dVkssr5UQ8Z33sxNPzZ3FCjIYQNLajyoNa1J4BHxa3L0w68BgMXVESY3iiJ58D1PZZDVLA+IsV1ElRUYdxcg=
X-Received: by 2002:a5d:5266:0:b0:21f:1280:85f with SMTP id
 l6-20020a5d5266000000b0021f1280085fmr12394052wrc.412.1660666329566; Tue, 16
 Aug 2022 09:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220815202900.3961097-1-jmeng@fb.com> <CADVnQy=hav-cLt5Dy0DBPiDCxgkpRCEktEoMNjq_uKG8hynLPg@mail.gmail.com>
In-Reply-To: <CADVnQy=hav-cLt5Dy0DBPiDCxgkpRCEktEoMNjq_uKG8hynLPg@mail.gmail.com>
From:   Yuchung Cheng <ycheng@google.com>
Date:   Tue, 16 Aug 2022 09:11:32 -0700
Message-ID: <CAK6E8=cd7Q2=ZZeLmZdO25ZcPxcCEZ5oaO_jw92hA55peYE5HQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Make SYN ACK RTO tunable by BPF programs
 with TFO
To:     Neal Cardwell <ncardwell@google.com>
Cc:     Jie Meng <jmeng@fb.com>, netdev@vger.kernel.org, kafai@fb.com,
        kuba@kernel.org, edumazet@google.com, bpf@vger.kernel.org,
        Wei Wang <weiwan@google.com>
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

On Tue, Aug 16, 2022 at 6:37 AM Neal Cardwell <ncardwell@google.com> wrote:
>
> On Mon, Aug 15, 2022 at 8:30 PM Jie Meng <jmeng@fb.com> wrote:
> >
> > Instead of the hardcoded TCP_TIMEOUT_INIT, this diff calls tcp_timeout_init
> > to initiate req->timeout like the non TFO SYN ACK case.
> >
> > Tested using the following packetdrill script, on a host with a BPF
> > program that sets the initial connect timeout to 10ms.
> >
> > `../../common/defaults.sh`
> >
> > // Initialize connection
> >     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> >    +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
> >    +0 bind(3, ..., ...) = 0
> >    +0 listen(3, 1) = 0
> >
> >    +0 < S 0:0(0) win 32792 <mss 1000,sackOK,FO TFO_COOKIE>
> >    +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
> >    +.01 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
> >    +.02 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
> >    +.04 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
> >    +.01 < . 1:1(0) ack 1 win 32792
> >
> >    +0 accept(3, ..., ...) = 4
> >
> > Signed-off-by: Jie Meng <jmeng@fb.com>
> > ---
> >  net/ipv4/tcp_fastopen.c | 3 ++-
> >  net/ipv4/tcp_timer.c    | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> > index 825b216d11f5..45cc7f1ca296 100644
> > --- a/net/ipv4/tcp_fastopen.c
> > +++ b/net/ipv4/tcp_fastopen.c
> > @@ -272,8 +272,9 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
> >          * The request socket is not added to the ehash
> >          * because it's been added to the accept queue directly.
> >          */
> > +       req->timeout = tcp_timeout_init(child);
> >         inet_csk_reset_xmit_timer(child, ICSK_TIME_RETRANS,
> > -                                 TCP_TIMEOUT_INIT, TCP_RTO_MAX);
> > +                                 req->timeout, TCP_RTO_MAX);
> >
> >         refcount_set(&req->rsk_refcnt, 2);
> >
> > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > index b4dfb82d6ecb..cb79127f45c3 100644
> > --- a/net/ipv4/tcp_timer.c
> > +++ b/net/ipv4/tcp_timer.c
> > @@ -428,7 +428,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
> >         if (!tp->retrans_stamp)
> >                 tp->retrans_stamp = tcp_time_stamp(tp);
> >         inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
> > -                         TCP_TIMEOUT_INIT << req->num_timeout, TCP_RTO_MAX);
> > +                         req->timeout << req->num_timeout, TCP_RTO_MAX);
> >  }
> >
> >
> > --
>
> Looks good to me. Thanks for the feature!
>
> Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Would be great to have a companion patch on SYN timeout as well.

>
> neal
