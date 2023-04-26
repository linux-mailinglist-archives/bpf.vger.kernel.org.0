Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9C86EF5B6
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbjDZNrE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 09:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241195AbjDZNrB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 09:47:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E8A619A
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 06:46:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-246eebbde1cso6011399a91.3
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682516819; x=1685108819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=non3P1pT4O+IjmAud+o5YAYEivu4T6b1Y3dc9IHFIhc=;
        b=ltJKNFAGg9Gzbpg20jvWe96aYHkVs2mwOEcxzUAdfcl10NMCDwlODEqz73pYeFp+7+
         NyD2bf/gSuKLBjE2+8H/5ILxuaIyJpDqBRvbnIHbVInfxmpFjIiKnYvsXLMGel1k6nlX
         9MfFvWKdaY51aZWhXfh+kz3dHLFNqv3rEapY7TMMlWorzbOxnhGb9jT9aZSNVRSa1yx+
         GB975ZufhcrjiAfOa6OPtyGppU9sCKqiv78u5aGkSNBSgFHg2kgK0L6ccwUom0xdhmel
         BNPzMRKa9ylscB7VZcYZwAbxh+fbZe+ymgjOA7Cr5wSDcniMw/t3a3cjQgbCQPRy8NIv
         a7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682516819; x=1685108819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=non3P1pT4O+IjmAud+o5YAYEivu4T6b1Y3dc9IHFIhc=;
        b=UFIiIvJu5YOGUD030Gn+eLtMS7Gsariw4zC9EpRdUE2C9NjSzIi63E45x/c14ks0Op
         68DU/HF3mK4b8FIvqTH1gLNfqRGw9NwmGT6rcSug3l020sw4Sg7BHhf+QFyY6ntUCF3d
         r2JixUvxUjXrb8igUJc6Mm9PBxMzttH2b/0gwLI1pFTz1JFCpDCFRtUfs8VN8h6C1xDs
         LD+1NCNsba13MZXLr5t01yS9Y3jm2F/7/Vb6KVHuommZD4FRVeyNWCB8k99ZOJpY8y2i
         ppSXaBHJL1hq28YmSIdrR1Ne7upQ6jziEak7vNBzrsw0xR0kO6h4JKXm59wD6Q0o6kIv
         bkzw==
X-Gm-Message-State: AAQBX9c295c8g/0lWfi/KQ+6b+rjjxqwnuimpvsQ9Bc6ow5X6tiMZ3e2
        0GHdDeQznWOY6KOBtugUNmOyJe4PEk/meHZudlWio0M4g6k4EQ==
X-Google-Smtp-Source: AKy350YdngkzUo9wUNl1jFmmdgSsyUYna+46oaHCuOL+/AvfeP6ErmlmgmLXRaoMG/YEiJ4BKAcgXoecGogI7yslq/I=
X-Received: by 2002:a17:90a:ac18:b0:249:6086:a301 with SMTP id
 o24-20020a17090aac1800b002496086a301mr20759964pjq.27.1682516818608; Wed, 26
 Apr 2023 06:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
 <20230421162718.440230-4-daan.j.demeyer@gmail.com> <20230421205540.bklwtswdrxybrjsl@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CAO8sHc=O2DjNjH4Xzi1R6ee8N1_jyPGk62vVVu0vTRFfEL6B+w@mail.gmail.com> <20230426000556.dbj52tv2umqb5cxh@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230426000556.dbj52tv2umqb5cxh@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
Date:   Wed, 26 Apr 2023 15:46:47 +0200
Message-ID: <CAO8sHcnZXA8boe+pHcr_8rSLC_92X9CtiSjaaHeyOLNGFes4xA@mail.gmail.com>
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

> On Mon, Apr 24, 2023 at 03:58:24PM +0200, Daan De Meyer wrote:
> > > On Fri, Apr 21, 2023 at 06:27:11PM +0200, Daan De Meyer wrote:
> > > >   *
> > > >   * This function will return %-EPERM if an attached program is found and
> > > > - * returned value != 1 during execution. In all other cases, 0 is returned.
> > > > + * returned value != 1 during execution. In all other cases, the new address
> > > > + * length of the sockaddr is returned.
> > > >   */
> > > >  int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> > > >                                     struct sockaddr *uaddr,
> > > > +                                   u32 uaddrlen,
> > > >                                     enum cgroup_bpf_attach_type atype,
> > > >                                     void *t_ctx,
> > > >                                     u32 *flags)
> > > > @@ -1469,9 +1472,11 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> > > >               .sk = sk,
> > > >               .uaddr = uaddr,
> > > >               .t_ctx = t_ctx,
> > > > +             .uaddrlen = uaddrlen,
> > > >       };
> > > >       struct sockaddr_storage unspec;
> > > >       struct cgroup *cgrp;
> > > > +     int ret;
> > > >
> > > >       /* Check socket family since not all sockets represent network
> > > >        * endpoint (e.g. AF_UNIX).
> > > > @@ -1482,11 +1487,16 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> > > >       if (!ctx.uaddr) {
> > > >               memset(&unspec, 0, sizeof(unspec));
> > > >               ctx.uaddr = (struct sockaddr *)&unspec;
> > > > +             ctx.uaddrlen = sizeof(unspec);
> > > >       }
> > > >
> > > >       cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> > > > -     return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > > > -                                  0, flags);
> > > > +     ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > > > +                                 0, flags);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     return (int) ctx.uaddrlen;
> > >
> > > But that is big behavioral change..
> > > instead of 0 or 1 now it will be sizeof(unspec) or 1?
> > > That will surely break some of the __cgroup_bpf_run_filter_sock_addr callers.
> >
> > It will now always return the size of the addrlen as set by the bpf
> > program or the original addrlen if the bpf program did not change it.
> > I modified all the callers of __cgroup_bpf_run_filter_sock_addr() to
> > ignore the returned addrlen so as to not introduce any breakages. Only
> > when unix socket support is introduced in the following patch do we
> > actually start making use of the addrlen returned by
> > __cgroup_bpf_run_filter_sock_addr(). Alternatively, I can pass in an
> > optional pointer to __cgroup_bpf_run_filter_sock_addr() which is set
> > to the modified addrlen if it is provided and then only make use of
> > this in af_unix.c, but I figure since we're already returning an int,
> > we can use that to propagate the modified address length as well.
> >
> > bpf_prog_run_array_cg() will return either 0 or -EPERM so we'll either
> > return an error if an error occurs or the modified address length if
> > no error occurs.
> >
> > For the default size of the address length if none is provided, I used
> > sizeof(unspec) since that's the size of the memory we provide to the
> > BPF program, but I suppose that zero could also make sense here, to
> > indicate that we're providing an empty address. Let me know which one
> > is preferred.
>
> I still don't understand how it's possible to modify the callers to
> have correct behavior.
>
> - return bpf_prog_run_array_cg();
> + ret = bpf_prog_run_array_cg();
> +       if (ret)
> +               return ret;
> +
> +       return (int) ctx.uaddrlen;
>
> It used to return 0 or 1.
> Now 1 is indistinguishable between 1 from prog and 0 from prog, but uaddrlen == 1.
> I don't see how callers can deal with that.

I think I'm missing something crucial somewhere. If I understand
bpf_prog_run_array_cg(() correctly, when called with retval = 0, it
will return -EPERM on failure and 0 on success. If I understand that
correctly, with this change, we'll still return -EPERM on failure but
instead of returning 0 on success, we'll now return the address
length. Am I misunderstanding how bpf_prog_run_array_cg() behaves in
this case?


On Wed, 26 Apr 2023 at 02:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 24, 2023 at 03:58:24PM +0200, Daan De Meyer wrote:
> > > On Fri, Apr 21, 2023 at 06:27:11PM +0200, Daan De Meyer wrote:
> > > >   *
> > > >   * This function will return %-EPERM if an attached program is found and
> > > > - * returned value != 1 during execution. In all other cases, 0 is returned.
> > > > + * returned value != 1 during execution. In all other cases, the new address
> > > > + * length of the sockaddr is returned.
> > > >   */
> > > >  int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> > > >                                     struct sockaddr *uaddr,
> > > > +                                   u32 uaddrlen,
> > > >                                     enum cgroup_bpf_attach_type atype,
> > > >                                     void *t_ctx,
> > > >                                     u32 *flags)
> > > > @@ -1469,9 +1472,11 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> > > >               .sk = sk,
> > > >               .uaddr = uaddr,
> > > >               .t_ctx = t_ctx,
> > > > +             .uaddrlen = uaddrlen,
> > > >       };
> > > >       struct sockaddr_storage unspec;
> > > >       struct cgroup *cgrp;
> > > > +     int ret;
> > > >
> > > >       /* Check socket family since not all sockets represent network
> > > >        * endpoint (e.g. AF_UNIX).
> > > > @@ -1482,11 +1487,16 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> > > >       if (!ctx.uaddr) {
> > > >               memset(&unspec, 0, sizeof(unspec));
> > > >               ctx.uaddr = (struct sockaddr *)&unspec;
> > > > +             ctx.uaddrlen = sizeof(unspec);
> > > >       }
> > > >
> > > >       cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> > > > -     return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > > > -                                  0, flags);
> > > > +     ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > > > +                                 0, flags);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     return (int) ctx.uaddrlen;
> > >
> > > But that is big behavioral change..
> > > instead of 0 or 1 now it will be sizeof(unspec) or 1?
> > > That will surely break some of the __cgroup_bpf_run_filter_sock_addr callers.
> >
> > It will now always return the size of the addrlen as set by the bpf
> > program or the original addrlen if the bpf program did not change it.
> > I modified all the callers of __cgroup_bpf_run_filter_sock_addr() to
> > ignore the returned addrlen so as to not introduce any breakages. Only
> > when unix socket support is introduced in the following patch do we
> > actually start making use of the addrlen returned by
> > __cgroup_bpf_run_filter_sock_addr(). Alternatively, I can pass in an
> > optional pointer to __cgroup_bpf_run_filter_sock_addr() which is set
> > to the modified addrlen if it is provided and then only make use of
> > this in af_unix.c, but I figure since we're already returning an int,
> > we can use that to propagate the modified address length as well.
> >
> > bpf_prog_run_array_cg() will return either 0 or -EPERM so we'll either
> > return an error if an error occurs or the modified address length if
> > no error occurs.
> >
> > For the default size of the address length if none is provided, I used
> > sizeof(unspec) since that's the size of the memory we provide to the
> > BPF program, but I suppose that zero could also make sense here, to
> > indicate that we're providing an empty address. Let me know which one
> > is preferred.
>
> I still don't understand how it's possible to modify the callers to
> have correct behavior.
>
> - return bpf_prog_run_array_cg();
> + ret = bpf_prog_run_array_cg();
> +       if (ret)
> +               return ret;
> +
> +       return (int) ctx.uaddrlen;
>
> It used to return 0 or 1.
> Now 1 is indistinguishable between 1 from prog and 0 from prog, but uaddrlen == 1.
> I don't see how callers can deal with that.
