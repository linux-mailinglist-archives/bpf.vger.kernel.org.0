Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156AA6EEB3B
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 02:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjDZAGC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 20:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbjDZAGB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 20:06:01 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB038699
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 17:06:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a682eee3baso49673615ad.0
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 17:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682467559; x=1685059559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJcVLPjKWigUCPJ2EVoTI63lTLp14+hEVorqEhKF7Jo=;
        b=KY6Vz0qPk/nVI4E9KvbKlwYXdAPrZRujcu4AWhtLZO06l1JMujKoyQBXjTF/oeGSRm
         xMgB9h9ox3fM2ydCxqj8pq//LwVSDQFfWAaVni+L95mwsu3/+prP1lJ4FAdMLfVf9ceq
         CFG+7MdgE6ZKXVT14oklCh/e2fxPW7OV8pfHHAyAmtyb3htQiHNVAcId8pJqoZ5rtngw
         NRjGsuypWD1gn/VxO1IG3ikM7fnvjq7ivuqkDEZmNp2DFCRTJCABgYBnelkJVWJ+Zkxx
         JnrO5/XgOtpIF74AvoxsyC0FuYeNvhqbC7SFrSwimWGGae2hhKG57/gmwMmZ6phWAEVL
         1xZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682467559; x=1685059559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJcVLPjKWigUCPJ2EVoTI63lTLp14+hEVorqEhKF7Jo=;
        b=FQuS0l4Tj7MtnHB0TekmkO0xoXBHNptDCz+VPNbccJOUb+n+yGFBMGarZffPVRQTu0
         XmwwnGAwdb7tEgkJwMX7IVdx8F/Y3IUJ2/kAddRMJMEvYS21/JLHtK1eufR+482JWLow
         aKCNj7x4BuJ9lyzNJbOL8CO1kP8DJnPf0JQuM8rJxSMnDSCiodTcDdtcf0tN/HvcuU3q
         JDxHxIub5wun/W5bEhWmXHJZDn53okwm7+WCfN4NMuU7OEAKdL/5m84yDpUheAo9HRIe
         igikE0omIwaPsvQHgEmD9LS1hAodkNxrymgAm9DLYXuQEyYU1GoHxH+JabbkNgYzI6po
         qexA==
X-Gm-Message-State: AAQBX9e7ZCvaPb9zTLTfuPhFpvOusjCDL2POGo0Se7oXb2dDep0Rs88A
        WYY/naNVwwkEvePywhC8MFk0FxhfQ7o=
X-Google-Smtp-Source: AKy350ZnzqgFqfaR2ZlUHp6aYqR9CnxmSzWdBJQI96FafqJhTXeawpZT3m0lEFOfKmQfROcddZNVPQ==
X-Received: by 2002:a17:903:48a:b0:1a8:1a06:abfc with SMTP id jj10-20020a170903048a00b001a81a06abfcmr18469245plb.61.1682467559217;
        Tue, 25 Apr 2023 17:05:59 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:f9d6])
        by smtp.gmail.com with ESMTPSA id iy1-20020a170903130100b001a65258011bsm8754546plb.26.2023.04.25.17.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 17:05:58 -0700 (PDT)
Date:   Tue, 25 Apr 2023 17:05:56 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 03/10] bpf: Allow read access to addr_len
 from cgroup sockaddr programs
Message-ID: <20230426000556.dbj52tv2umqb5cxh@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
 <20230421162718.440230-4-daan.j.demeyer@gmail.com>
 <20230421205540.bklwtswdrxybrjsl@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CAO8sHc=O2DjNjH4Xzi1R6ee8N1_jyPGk62vVVu0vTRFfEL6B+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO8sHc=O2DjNjH4Xzi1R6ee8N1_jyPGk62vVVu0vTRFfEL6B+w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 24, 2023 at 03:58:24PM +0200, Daan De Meyer wrote:
> > On Fri, Apr 21, 2023 at 06:27:11PM +0200, Daan De Meyer wrote:
> > >   *
> > >   * This function will return %-EPERM if an attached program is found and
> > > - * returned value != 1 during execution. In all other cases, 0 is returned.
> > > + * returned value != 1 during execution. In all other cases, the new address
> > > + * length of the sockaddr is returned.
> > >   */
> > >  int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> > >                                     struct sockaddr *uaddr,
> > > +                                   u32 uaddrlen,
> > >                                     enum cgroup_bpf_attach_type atype,
> > >                                     void *t_ctx,
> > >                                     u32 *flags)
> > > @@ -1469,9 +1472,11 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> > >               .sk = sk,
> > >               .uaddr = uaddr,
> > >               .t_ctx = t_ctx,
> > > +             .uaddrlen = uaddrlen,
> > >       };
> > >       struct sockaddr_storage unspec;
> > >       struct cgroup *cgrp;
> > > +     int ret;
> > >
> > >       /* Check socket family since not all sockets represent network
> > >        * endpoint (e.g. AF_UNIX).
> > > @@ -1482,11 +1487,16 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> > >       if (!ctx.uaddr) {
> > >               memset(&unspec, 0, sizeof(unspec));
> > >               ctx.uaddr = (struct sockaddr *)&unspec;
> > > +             ctx.uaddrlen = sizeof(unspec);
> > >       }
> > >
> > >       cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> > > -     return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > > -                                  0, flags);
> > > +     ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > > +                                 0, flags);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return (int) ctx.uaddrlen;
> >
> > But that is big behavioral change..
> > instead of 0 or 1 now it will be sizeof(unspec) or 1?
> > That will surely break some of the __cgroup_bpf_run_filter_sock_addr callers.
> 
> It will now always return the size of the addrlen as set by the bpf
> program or the original addrlen if the bpf program did not change it.
> I modified all the callers of __cgroup_bpf_run_filter_sock_addr() to
> ignore the returned addrlen so as to not introduce any breakages. Only
> when unix socket support is introduced in the following patch do we
> actually start making use of the addrlen returned by
> __cgroup_bpf_run_filter_sock_addr(). Alternatively, I can pass in an
> optional pointer to __cgroup_bpf_run_filter_sock_addr() which is set
> to the modified addrlen if it is provided and then only make use of
> this in af_unix.c, but I figure since we're already returning an int,
> we can use that to propagate the modified address length as well.
> 
> bpf_prog_run_array_cg() will return either 0 or -EPERM so we'll either
> return an error if an error occurs or the modified address length if
> no error occurs.
> 
> For the default size of the address length if none is provided, I used
> sizeof(unspec) since that's the size of the memory we provide to the
> BPF program, but I suppose that zero could also make sense here, to
> indicate that we're providing an empty address. Let me know which one
> is preferred.

I still don't understand how it's possible to modify the callers to
have correct behavior.

- return bpf_prog_run_array_cg();
+ ret = bpf_prog_run_array_cg();
+       if (ret)
+               return ret;
+
+       return (int) ctx.uaddrlen;

It used to return 0 or 1.
Now 1 is indistinguishable between 1 from prog and 0 from prog, but uaddrlen == 1.
I don't see how callers can deal with that.
