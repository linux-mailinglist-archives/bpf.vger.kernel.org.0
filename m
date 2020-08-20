Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBBA24C80A
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 00:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgHTWyy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 18:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgHTWyy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 18:54:54 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F8EC061385
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 15:54:53 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q75so3946045iod.1
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 15:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZ9RCEDYy0Jv7CL1iweZtq7KZE1Pa4Rqj0pAp5KNN+4=;
        b=vcVii9Xozm1NiX9HUBWiTu59L91FPbln8Pi7oURmk1ILxiTGFj5r8NlCjWIPFllRNt
         GkcUcRrpvqcvSLDEFf1EWm0dftn80P/q8tkoUBOWpNtIOeALMUXeReMnZdV+fM8vrswA
         bg0F2r14VwMcBJSooRlHPei+iFoaWqscgd5K4pqdZ/I/7f7+Ksd+Q3fHW5YiN9U6fqJ3
         Hxxnc6rJnCHP0kOFfKSkJD89Sy+QEvYCc10MrW+OAopiz6HpDd0hXpuxvgWfZz4mD3+O
         j9P/v3vIQHRTpZLRs1zKhTC4oC9qk9PGLoRroQFeer8oe4Cxf8Fy32yrYGtfTRVxyCEO
         QBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZ9RCEDYy0Jv7CL1iweZtq7KZE1Pa4Rqj0pAp5KNN+4=;
        b=ZZJdbfygUKCIUnGFRfldzEaGT+GRLW1HNwcKdJdhvxx6uEE3WAkbH5Onuuph/Ij+hu
         pMmHUIqV+/mC6m9u7MDgIJrIchuwtUydv4UYJlDtwmpCbHQQo9Swr2nUEqHqX6rse5Ce
         5zT/SwXm8WiEXQJj4jzkRx5EAR7aSzHe2OWq2Mjpgx003RtKT0xovPu8Y2O5GRdfC1HL
         X06nOwYW3fe+e31jbAlAhtUGiqfiHcAsoN4CrO0QuJl5jR5Q8xWwDVLbW/WMV/wAQ5LL
         9Ro31gcWXLjlKB0z2yWT01FqEYBtOXkZ9U0SoezHPDfOjrxXlgFurgB3wyFZjBpwgVqJ
         cM5w==
X-Gm-Message-State: AOAM533VksldY0aw8jLIaZ6mp6UHDXTdW0wcVuGI2de44jxh1iZ9l2pJ
        jU01nhOPbYgf8G9elYzv0ZZwT3DFNh9MNAUI0OcI6w==
X-Google-Smtp-Source: ABdhPJwc2RwKrGlo6izY21jXM03aX6zRakNqYeo+rANcunKg4EughUCRiYuX9t9Jv+WXmOwpKInr/UlXqtxAFVQdaWw=
X-Received: by 2002:a02:3f0d:: with SMTP id d13mr32867jaa.99.1597964092417;
 Thu, 20 Aug 2020 15:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200820190008.2883500-1-kafai@fb.com> <20200820190052.2885316-1-kafai@fb.com>
 <alpine.OSX.2.23.453.2008201529350.59053@mjmartin-mac01.local>
In-Reply-To: <alpine.OSX.2.23.453.2008201529350.59053@mjmartin-mac01.local>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 20 Aug 2020 15:54:40 -0700
Message-ID: <CANn89iKVEUVbL7mKmGzq7DGXFFL2JwGneR=PKoO_NX0Vym-JpA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 07/12] bpf: tcp: Add bpf_skops_hdr_opt_len()
 and bpf_skops_write_hdr_opt()
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@fb.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Neal Cardwell <ncardwell@google.com>,
        netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 20, 2020 at 3:39 PM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
>
> On Thu, 20 Aug 2020, Martin KaFai Lau wrote:
>
> > The bpf prog needs to parse the SYN header to learn what options have
> > been sent by the peer's bpf-prog before writing its options into SYNACK.
> > This patch adds a "syn_skb" arg to tcp_make_synack() and send_synack().
> > This syn_skb will eventually be made available (as read-only) to the
> > bpf prog.  This will be the only SYN packet available to the bpf
> > prog during syncookie.  For other regular cases, the bpf prog can
> > also use the saved_syn.

> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 5084333b5ab6..631a5ee0dd4e 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
>
> ...
>
> > @@ -826,6 +886,15 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
> >                       opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
> >       }
> >
> > +     if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
> > +                                         BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG))) {
> > +             unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
> > +
> > +             bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts, &remaining);
> > +
> > +             size = MAX_TCP_OPTION_SPACE - remaining;
> > +     }
> > +
> >       return size;
> > }
> >
>
> Since bpf_skops_hdr_opt_len() is called after the SACK code tries to use
> up all remaining option space for SACK blocks, it's less likely that there
> will be sufficient space remaining. Did you consider moving this hunk
> before the SACK option space is allocated to give the bpf prog higher
> priority?

We have tcp_is_sack(tp) returning a bool. We do not want to return a
flaky value.

If you need to limit the number of sack ranges to one, please handle
this separately.
