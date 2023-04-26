Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBDF6EEB47
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 02:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbjDZAKJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 20:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237915AbjDZAKI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 20:10:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074741FF9
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 17:10:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b51fd2972so5117564b3a.3
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 17:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682467807; x=1685059807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5UscEh5hrsrPadpcleoEaIoH4Ni1rMWLQNZhEpSKiF4=;
        b=FdHCkoHYnosp5u5EY9/LSjjLHVnx0Whf6Mvq2KjZazo+U2sb1RQNEY5madAYto3DAJ
         M/z05YmA87nPFSXBGW/0lschCU8vN/FDaylnuz/p2ZZ9Rd5jOETe7guj3OggZ4gzYIP9
         suilKRaQZhKYHrfDMBsaJAgPXNKErGyexG7oT5JSF604K226iELGb/phmzsDnZ8F+B/x
         D3icyQ3kbO/V+SAW4SDEaxxTUn1QBvFur3xOMTYzGURAoRW/JhK3/KafLuwQDIcwpbaV
         xC45OyTEL8ltADcxk9CuUnpgdqx0s0sAdZUtZh1oaA6g9MH0o9J/POUxPgJHoBDmXYXv
         Kt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682467807; x=1685059807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UscEh5hrsrPadpcleoEaIoH4Ni1rMWLQNZhEpSKiF4=;
        b=LhfZI9vuLJRYu8VEOisC26fTQsapr10kn1jr/GdEG73xwEFOZ1IUUetbBY1nLOo9iJ
         BJ3XWvqgCVtqcA6CMHJcHUjxqw82dFD/wu4zNbAiPuSmXp8XlQkLZ6KyWPShwXrF2XJQ
         bvstesfpswA5kEl9OrFxALSmoj9xZQlDqjp6PzaKm0DlY7vqBQuYblxfV4dJ+llWkqFD
         +znkXHUhkFVedOIAg+iT5sSChwDyKP5dhEu877I3aEzXrZ2hx/WA548NvYcbiHhmuerR
         C1pUckYN2DzcYDvM0iusMq5+QYLaWEp+CGi4GRmiExf5pl/95yiIY6gABHB6qtQwFGxy
         MPGw==
X-Gm-Message-State: AAQBX9fkuZdOHoLBfyJeu09R7tKwmgRkt9Q/zwQBQwk3otQVf0vq06m1
        8jcreKqNMNR1Pr7zZuVVzG8=
X-Google-Smtp-Source: AKy350bml9pNdr8E8a4ajCPrjXJ53GLNTjF6ulihzDi6+p7QsWJymsqX3TadMeJtmf3GXcelDkYuGw==
X-Received: by 2002:a05:6a00:2346:b0:63b:7fc0:a4af with SMTP id j6-20020a056a00234600b0063b7fc0a4afmr25966791pfj.26.1682467807261;
        Tue, 25 Apr 2023 17:10:07 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:f9d6])
        by smtp.gmail.com with ESMTPSA id y136-20020a62ce8e000000b0063d63d48215sm9804015pfg.3.2023.04.25.17.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 17:10:06 -0700 (PDT)
Date:   Tue, 25 Apr 2023 17:10:04 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 05/10] bpf: Add bpf_sock_addr_set() to allow
 writing sockaddr len from bpf
Message-ID: <20230426001004.nn6dyugtwsgn5e2c@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
 <20230421162718.440230-6-daan.j.demeyer@gmail.com>
 <20230421210135.v4msbkuj433j75g4@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CAO8sHcnE6rBTdMJv7Z8oB81wJODH5+j8tKpYKrc8esxd8AMRsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO8sHcnE6rBTdMJv7Z8oB81wJODH5+j8tKpYKrc8esxd8AMRsA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 24, 2023 at 04:07:13PM +0200, Daan De Meyer wrote:
> bpf_sock_addr_set
> > On Fri, Apr 21, 2023 at 06:27:13PM +0200, Daan De Meyer wrote:
> > > As prep for adding unix socket support to the cgroup sockaddr hooks,
> > > let's add a kfunc bpf_sock_addr_set() that allows modifying the
> > > sockaddr length from bpf. This is required to allow modifying AF_UNIX
> > > sockaddrs correctly.
> > >
> > > Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> > > ---
> > >  net/core/filter.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 51 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 44fb997434ad..1c656e2d7b58 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -81,6 +81,7 @@
> > >  #include <net/xdp.h>
> > >  #include <net/mptcp.h>
> > >  #include <net/netfilter/nf_conntrack_bpf.h>
> > > +#include <linux/un.h>
> > >
> > >  static const struct bpf_func_proto *
> > >  bpf_sk_base_func_proto(enum bpf_func_id func_id);
> > > @@ -11670,6 +11671,44 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
> > >
> > >       return 0;
> > >  }
> > > +
> > > +__bpf_kfunc int bpf_sock_addr_set(struct bpf_sock_addr_kern *sa_kern,
> > > +                               const void *addr, u32 addrlen__sz)
> >
> > I think the verifier doesn't check validity of void* pointer for kfuncs.
> > Should it be 'struct sockaddr_un *' ?
> 
> I had to make it 'void *' because the __sz tag only works on void
> pointers. 

Why do you think so?

__bpf_kfunc struct nf_conn___init *
bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
                 u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
                   enum hid_report_type rtype, enum hid_class_request reqtype)

> If it should be 'struct sockaddr_un *', how do I make the
> addrlen__sz tag work properly?
> 
> > > +{
> > > +     const struct sockaddr *sa = addr;
> > > +
> > > +     if (addrlen__sz <= offsetof(struct sockaddr, sa_family))
> > > +             return -EINVAL;
> > > +
> > > +     if (addrlen__sz > sizeof(struct sockaddr_storage))
> > > +             return -EINVAL;
> > > +
> > > +     if (sa->sa_family != sa_kern->uaddr->sa_family)
> > > +             return -EINVAL;
> > > +
> > > +     switch (sa->sa_family) {
> > > +     case AF_INET:
> > > +             if (addrlen__sz < sizeof(struct sockaddr_in))
> > > +                     return -EINVAL;
> > > +             break;
> > > +     case AF_INET6:
> > > +             if (addrlen__sz < SIN6_LEN_RFC2133)
> > > +                     return -EINVAL;
> > > +             break;
> > > +     case AF_UNIX:
> > > +             if (addrlen__sz <= offsetof(struct sockaddr_un, sun_path) ||
> > > +                 addrlen__sz > sizeof(struct sockaddr_un))
> > > +                     return -EINVAL;
> > > +             break;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     memcpy(sa_kern->uaddr, sa, addrlen__sz);
> > > +     sa_kern->uaddrlen = addrlen__sz;
> > > +
> > > +     return 0;
> > > +}
> > >  __diag_pop();
> > >
> > >  int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
> > > @@ -11694,6 +11733,10 @@ BTF_SET8_START(bpf_kfunc_check_set_xdp)
> > >  BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
> > >  BTF_SET8_END(bpf_kfunc_check_set_xdp)
> > >
> > > +BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
> > > +BTF_ID_FLAGS(func, bpf_sock_addr_set)
> >
> > It probably needs KF_TRUSTED_ARGS.
> 
> If I understand the documentation of `KF_TRUSTED_ARGS` correctly, this
> wouldn't allow me to pass arbitrary sockaddr structs into
> bpf_sock_addr_set() anymore since those wouldn't be trusted?

KF_TRUSTED_ARGS won't allow legacy and untrusted PTR_TO_BTF_ID to
be passed into as 1st arg == struct bpf_sock_addr_kern *.
