Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD6E6ECFD6
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 15:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjDXN6i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 09:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDXN6h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 09:58:37 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34209109
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 06:58:36 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-52091c58109so4300567a12.2
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682344715; x=1684936715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w4PG051xLqM17sCPVFX7zuy/M4JZxgFjehvvQ811HLo=;
        b=cJ/uGg5Q8KVGY5DV8K1QIvd/NVOBxDA7sFNFUjcZMnQFO1+dMhXV0rASTv6vGH+3+d
         MX3Y+g3pURokVrVFyx1ExIteJbXvfVtY1EJRp5VOC9kVRp2FqytS3S6HuqIxMNt94nKp
         94AWR6lyIApdvRwM7FFShWXo3A90AHHK5L7gfhaS+ddVQUfSKHsmsda1iV2P/XBdo2G5
         vaiv2ZL6aerLbRmDxahNDEhtSxoj3vpWOhlnF3utFBcRGuxBJtRjHyOF4HuLUiKZA1tF
         88mAHemttvn3ER4SYIdSsnAtW6UkVJJO8cCqkn7f5kN2t+0nbiGItoxDf0MdUiSMjcTQ
         QPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682344715; x=1684936715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4PG051xLqM17sCPVFX7zuy/M4JZxgFjehvvQ811HLo=;
        b=k6luiNHmaCS6NSHBszjpKrekSreEP9zuaoO6QQR3Ly7rYAVM7jGh6ltXFY/yDUIgUZ
         ZvskdfOmh7h1mhvZbEkTK/hSB+XfhfSl4shiWFj+qVBthqeMLQALieKwjhbygFBd7CY6
         4np8azJYXCJ7MUFNGtVvfqnn7ZspY5op9Bybz+WuEZJ2UKr3BQLytS4XcSwS/aCQ3HKK
         TMBoX5AAi2F1XClC0UKEJjkC671WePPqz+aiO/R8KjOPdEvT5HQ8C3D9SKvrmxqH0m+0
         GxVcR+Db1oEtBqEyCkYT5SQSLlPv9NZjz0yFm1Bmka38j/z65PwrvvpJCFaBd1f3Ph4r
         VKPA==
X-Gm-Message-State: AAQBX9eGcPNv4RFsTVxQUyL1vs9Q+jhuwgqeDyeWynWx5O0ctd1OxW4K
        1YHv0rRwN3KwsKTRiZDveKO4zPxY1MRLRz3lX7uc6Lh+mnmLPw==
X-Google-Smtp-Source: AKy350boK0PTOfAxJ8Fq3VLFKCg/E5sTpDnZSVD42T5E0jCLfwJZtLCxWSZwhi52v4MFKii3bU+HzDLrMwXjatPhpDk=
X-Received: by 2002:a17:90a:8043:b0:246:97d2:dc27 with SMTP id
 e3-20020a17090a804300b0024697d2dc27mr13835836pjw.42.1682344715458; Mon, 24
 Apr 2023 06:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
 <20230421162718.440230-4-daan.j.demeyer@gmail.com> <20230421205540.bklwtswdrxybrjsl@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230421205540.bklwtswdrxybrjsl@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
Date:   Mon, 24 Apr 2023 15:58:24 +0200
Message-ID: <CAO8sHc=O2DjNjH4Xzi1R6ee8N1_jyPGk62vVVu0vTRFfEL6B+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/10] bpf: Allow read access to addr_len from
 cgroup sockaddr programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Fri, Apr 21, 2023 at 06:27:11PM +0200, Daan De Meyer wrote:
> >   *
> >   * This function will return %-EPERM if an attached program is found and
> > - * returned value != 1 during execution. In all other cases, 0 is returned.
> > + * returned value != 1 during execution. In all other cases, the new address
> > + * length of the sockaddr is returned.
> >   */
> >  int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> >                                     struct sockaddr *uaddr,
> > +                                   u32 uaddrlen,
> >                                     enum cgroup_bpf_attach_type atype,
> >                                     void *t_ctx,
> >                                     u32 *flags)
> > @@ -1469,9 +1472,11 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> >               .sk = sk,
> >               .uaddr = uaddr,
> >               .t_ctx = t_ctx,
> > +             .uaddrlen = uaddrlen,
> >       };
> >       struct sockaddr_storage unspec;
> >       struct cgroup *cgrp;
> > +     int ret;
> >
> >       /* Check socket family since not all sockets represent network
> >        * endpoint (e.g. AF_UNIX).
> > @@ -1482,11 +1487,16 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> >       if (!ctx.uaddr) {
> >               memset(&unspec, 0, sizeof(unspec));
> >               ctx.uaddr = (struct sockaddr *)&unspec;
> > +             ctx.uaddrlen = sizeof(unspec);
> >       }
> >
> >       cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> > -     return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > -                                  0, flags);
> > +     ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > +                                 0, flags);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return (int) ctx.uaddrlen;
>
> But that is big behavioral change..
> instead of 0 or 1 now it will be sizeof(unspec) or 1?
> That will surely break some of the __cgroup_bpf_run_filter_sock_addr callers.

It will now always return the size of the addrlen as set by the bpf
program or the original addrlen if the bpf program did not change it.
I modified all the callers of __cgroup_bpf_run_filter_sock_addr() to
ignore the returned addrlen so as to not introduce any breakages. Only
when unix socket support is introduced in the following patch do we
actually start making use of the addrlen returned by
__cgroup_bpf_run_filter_sock_addr(). Alternatively, I can pass in an
optional pointer to __cgroup_bpf_run_filter_sock_addr() which is set
to the modified addrlen if it is provided and then only make use of
this in af_unix.c, but I figure since we're already returning an int,
we can use that to propagate the modified address length as well.

bpf_prog_run_array_cg() will return either 0 or -EPERM so we'll either
return an error if an error occurs or the modified address length if
no error occurs.

For the default size of the address length if none is provided, I used
sizeof(unspec) since that's the size of the memory we provide to the
BPF program, but I suppose that zero could also make sense here, to
indicate that we're providing an empty address. Let me know which one
is preferred.


On Fri, 21 Apr 2023 at 22:55, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 21, 2023 at 06:27:11PM +0200, Daan De Meyer wrote:
> >   *
> >   * This function will return %-EPERM if an attached program is found and
> > - * returned value != 1 during execution. In all other cases, 0 is returned.
> > + * returned value != 1 during execution. In all other cases, the new address
> > + * length of the sockaddr is returned.
> >   */
> >  int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> >                                     struct sockaddr *uaddr,
> > +                                   u32 uaddrlen,
> >                                     enum cgroup_bpf_attach_type atype,
> >                                     void *t_ctx,
> >                                     u32 *flags)
> > @@ -1469,9 +1472,11 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> >               .sk = sk,
> >               .uaddr = uaddr,
> >               .t_ctx = t_ctx,
> > +             .uaddrlen = uaddrlen,
> >       };
> >       struct sockaddr_storage unspec;
> >       struct cgroup *cgrp;
> > +     int ret;
> >
> >       /* Check socket family since not all sockets represent network
> >        * endpoint (e.g. AF_UNIX).
> > @@ -1482,11 +1487,16 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> >       if (!ctx.uaddr) {
> >               memset(&unspec, 0, sizeof(unspec));
> >               ctx.uaddr = (struct sockaddr *)&unspec;
> > +             ctx.uaddrlen = sizeof(unspec);
> >       }
> >
> >       cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> > -     return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > -                                  0, flags);
> > +     ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > +                                 0, flags);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return (int) ctx.uaddrlen;
>
> But that is big behavioral change..
> instead of 0 or 1 now it will be sizeof(unspec) or 1?
> That will surely break some of the __cgroup_bpf_run_filter_sock_addr callers.
