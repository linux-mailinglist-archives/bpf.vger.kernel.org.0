Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9320658A2DA
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 23:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiHDVqj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 17:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbiHDVqi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 17:46:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF22915FE0
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 14:46:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gb36so1608840ejc.10
        for <bpf@vger.kernel.org>; Thu, 04 Aug 2022 14:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUoTYv8iLPd1QlRpHn2cdhhhnLs1Q0ib2cFRywbi+U8=;
        b=NbcpVBgqagdGY3SIXm6pTV//CIJS09CgmlVI81wqAAKEFUmNYz0SQHs2iUe9u3BaSy
         I1qprGQkoctB2qdrNinRMsrn+uHa91eJd3Qz3WpfC1/wl0zW4w5wUtnGZXB9AcWENZ3e
         7WJlU4Xl4MTn8wRbGCBBbLBdAszbDIBXIY43tFR80hENyLUmTszlWBBnvdtoy9Ex2RdU
         q0c09DGK3LKZ1FOJgNlTmOcLcWU0HZWFxuvOZ/97rzDB/hRXRkNAhp6ge4uj1OFd7oi6
         eVbZO6kGq4Z+PNNBfdc8cvUeHxrswwhoC5ub6qfXEonRWHBrgIRgjFzb5yPSHB/sSFih
         uf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUoTYv8iLPd1QlRpHn2cdhhhnLs1Q0ib2cFRywbi+U8=;
        b=LJcEKG01GCB/IGl7sT/2P8jUsLBr9blCYvYNG9EvYxrUg51/hrsCy0R84VKXDCsshO
         4Ui6QyAq2T2sF7dAdhySgLDdQsUEpJl2xlyYZedYEY0l6Eypcr8D2pa7Ev/NUKBCedhy
         WCgpAtAKWUO48fknsPHXy8psNEFZqeqt4MzWt/dcjyRG88RQ8gliZsx8zlZ+VGAQK0Hp
         NclbPJH6sUhwkakVrHyb7Jw+xy1Cgt6AzpmJBUh3Vj0qsv+sz+NK5e2Zty7wQ1C3DQXE
         lcll+YSnlKjGbBJ19D4gUVFwokDyTI2mF76lp6T4mms1mwqiZXPsfInffMyuwaFLGSFK
         m3Sw==
X-Gm-Message-State: ACgBeo0LcC/UnPrSLQNUfaRDuZ7UNeiha5FNDV5pScP4cP5ktAgHdylu
        TvmQSLHl4gWVIQDO2IpVyuZOSeokhvzIoC4Y68guj5XY
X-Google-Smtp-Source: AA6agR4wkcqi1XqRju7j6B5m6lBKP7fQ5foOMSTWgxqew5e2Avg8vuCpErM1yxYJZeq4xK72NWHrdn+f0NfVXGK9Afg=
X-Received: by 2002:a17:907:7d8b:b0:72f:2306:329a with SMTP id
 oz11-20020a1709077d8b00b0072f2306329amr2727388ejc.369.1659649595459; Thu, 04
 Aug 2022 14:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-4-joannelkoong@gmail.com> <CAADnVQJiA+Ari7_MmBLgNSDPoCY_wmQTdE9oqCX1DGqo6nVXxw@mail.gmail.com>
 <CAJnrk1ZV4xLXG1kozt3tCyZAdPyAe-W7u6EuyR2btWEta5rQ-w@mail.gmail.com>
In-Reply-To: <CAJnrk1ZV4xLXG1kozt3tCyZAdPyAe-W7u6EuyR2btWEta5rQ-w@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 4 Aug 2022 14:46:24 -0700
Message-ID: <CAJnrk1a+waYLyXWtx9t-+BAtor-m3RW31c8NOQppRrVa0Jrn9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: tests for using dynptrs to
 parse skb and xdp buffers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 2, 2022 at 3:21 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Mon, Aug 1, 2022 at 12:12 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jul 26, 2022 at 11:48 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >
> > >
> > > -static __always_inline int handle_ipv4(struct xdp_md *xdp)
> > > +static __always_inline int handle_ipv4(struct xdp_md *xdp, struct bpf_dynptr *xdp_ptr)
> > >  {
> > > -       void *data_end = (void *)(long)xdp->data_end;
> > > -       void *data = (void *)(long)xdp->data;
> > > +       struct bpf_dynptr new_xdp_ptr;
> > >         struct iptnl_info *tnl;
> > >         struct ethhdr *new_eth;
> > >         struct ethhdr *old_eth;
> > > -       struct iphdr *iph = data + sizeof(struct ethhdr);
> > > +       struct iphdr *iph;
> > >         __u16 *next_iph;
> > >         __u16 payload_len;
> > >         struct vip vip = {};
> > > @@ -90,10 +90,12 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
> > >         __u32 csum = 0;
> > >         int i;
> > >
> > > -       if (iph + 1 > data_end)
> > > +       iph = bpf_dynptr_data(xdp_ptr, ethhdr_sz,
> > > +                             iphdr_sz + (tcphdr_sz > udphdr_sz ? tcphdr_sz : udphdr_sz));
> > > +       if (!iph)
> > >                 return XDP_DROP;
> >
> > dynptr based xdp/skb access looks neat.
> > Maybe in addition to bpf_dynptr_data() we can add helper(s)
> > that return skb/xdp_md from dynptr?
> > This way the code will be passing dynptr only and there will
> > be no need to pass around 'struct xdp_md *xdp' (like this function).
>
> Great idea! I'll add this to v2.

Thinking about this some more, I don't think the extra helpers will be
that useful. We'd have to add 2 custom helpers (bpf_dynptr_get_xdp +
bpf_dynptr_get_skb) and calling them would always require a null check
(since we'd return NULL if the dyntpr is invalid/null). I think it'd
be faster / easier for the program to just pass in the ctx as an extra
arg in the special cases where it needs that.

>
> >
> > Separately please keep the existing tests instead of converting them.
> > Either ifdef data/data_end vs dynptr style or copy paste
> > the whole test into a new .c file. Whichever is cleaner.
>
> Will do for v2.
