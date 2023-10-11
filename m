Return-Path: <bpf+bounces-11960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC7E7C5D6B
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 21:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A59282A00
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B9312E5C;
	Wed, 11 Oct 2023 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxD4j6H3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F73A296;
	Wed, 11 Oct 2023 19:09:46 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1333D90;
	Wed, 11 Oct 2023 12:09:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27ce05a23e5so1071535a91.1;
        Wed, 11 Oct 2023 12:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697051384; x=1697656184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w3bqlqLMcqSzzO28omMpnVsJCdKQl//HrMRuNlrJBLs=;
        b=FxD4j6H3rIfIgmNUFSO3GAc2iEiLBuryLZkZhGuRH8lA44p3btYYESIslekiHc39Ix
         uO8Zbc5C7tDmw0l0P+p2vlAp37Ca/VzeIdQCPVAnNdKk+TZoPB5JS9J7ZpcgRRyBWFB9
         1D/yvOgjjpPjAux3dPQ++zGcVCxcXsbvpLYo+Ixfw9pCrAo5REPi3bNFPoPFOXXJRQNo
         rSE9isKuzvlMZvMeQZvvfQXeXkvVNHG2NXQNqb5FFcd1xPNoLzGsKQF/YalfusKIc5xj
         CNk8dSkSn4doIQ4Sge2dJhJWVSy0uzJlfOPSPSnmCA0IGfxhisTFwfIWAhpTX9AHudHI
         g4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697051384; x=1697656184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3bqlqLMcqSzzO28omMpnVsJCdKQl//HrMRuNlrJBLs=;
        b=Kp1VYVbRotf1jjX8AFIKIgrI56j7LJUngSOY3Gd8TA9uckyezzea5oG5Tjz0u7RI8/
         27v2KUJDIDd2bE4ocFxB3DnDOqjdijxKWCxZMdCdcTvrrxGlKn7VjBTu3UDlU+ivwxmQ
         khyJkwqN4FBfitCsbgKz8cxkqhVlsVKdJy0pGzLmBZP707lhG9tPdgcFj5ilTQuipvA+
         ohQHaDPVzdnPWnOgMkPuKrhatKCo5+C2WO2UU510jib6LvN/Smcx/XE4UZNlnB4Tmld/
         BDy0WZrMFeScyN929smZw9gj/bQeD/4Bt+R4jXw6n1PvHjuuA+HS8v2bEzPrWWzllOMj
         no4g==
X-Gm-Message-State: AOJu0YwiXnuXEWedY0BVC0YJB1gF40YzH++pIdy4DvfWmqAVRMwQ+qjf
	GJXss1K3MHJx3aYv/HygMHOx6ABlrLVGA/QE8k+a8ATuxdnD1zXl
X-Google-Smtp-Source: AGHT+IE88VHET0gASa81d6KlHa5MrIFcGO0NCdHs88aK191VzY8OtEwe0v+TW3J4pDYvsiajkWHIxg/68HOq1KOlMVM=
X-Received: by 2002:a17:90b:82:b0:27d:d9a:be8b with SMTP id
 bb2-20020a17090b008200b0027d0d9abe8bmr2926854pjb.6.1697051384289; Wed, 11 Oct
 2023 12:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO8sHc=FfDo_LnpV_tF5aPF4BjpWkQk2jLxLWH50X0JzSQ+s6Q@mail.gmail.com>
 <20231011185814.53217-1-kuniyu@amazon.com>
In-Reply-To: <20231011185814.53217-1-kuniyu@amazon.com>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Wed, 11 Oct 2023 21:09:33 +0200
Message-ID: <CAO8sHcmFHLpk2LfJKxHcA_9y6TyouS0sr=8oj09gLGvGmhYavw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 2/9] bpf: Propagate modified uaddrlen from
 cgroup sockaddr programs
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bpf@vger.kernel.org, kernel-team@meta.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> From: Daan De Meyer <daan.j.demeyer@gmail.com>
> Date: Wed, 11 Oct 2023 20:37:49 +0200
> > > > @@ -1483,11 +1488,18 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> > > >       if (!ctx.uaddr) {
> > > >               memset(&unspec, 0, sizeof(unspec));
> > > >               ctx.uaddr = (struct sockaddr *)&unspec;
> > > > -     }
> > > > +             ctx.uaddrlen = 0;
> > > > +     } else
> > > > +             ctx.uaddrlen = *uaddrlen;
> > > >
> > > >       cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> > > > -     return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > > > -                                  0, flags);
> > > > +     ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > > > +                                 0, flags);
> > > > +
> > > > +     if (!ret && uaddrlen)
> > >
> > > nit: no need to check uaddrlen here or maybe check ctx.uaddrlen.
> >
> > Are you sure? uaddrlen can still be NULL if uaddr is also NULL
>
> How?  In the patch 2 and 4, it seems uaddrlen always points to an
> actual variable.

Right, I was assuming we don't know for sure how callers are calling
this function. It is right that right now no caller calls it with uaddrlen set
to NULL.

It still seems like a good idea to check for uaddr instead of uaddrlen though,
to mimic the same check that is done earlier in this function.


On Wed, 11 Oct 2023 at 20:58, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> From: Daan De Meyer <daan.j.demeyer@gmail.com>
> Date: Wed, 11 Oct 2023 20:37:49 +0200
> > > > @@ -1483,11 +1488,18 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> > > >       if (!ctx.uaddr) {
> > > >               memset(&unspec, 0, sizeof(unspec));
> > > >               ctx.uaddr = (struct sockaddr *)&unspec;
> > > > -     }
> > > > +             ctx.uaddrlen = 0;
> > > > +     } else
> > > > +             ctx.uaddrlen = *uaddrlen;
> > > >
> > > >       cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> > > > -     return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > > > -                                  0, flags);
> > > > +     ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > > > +                                 0, flags);
> > > > +
> > > > +     if (!ret && uaddrlen)
> > >
> > > nit: no need to check uaddrlen here or maybe check ctx.uaddrlen.
> >
> > Are you sure? uaddrlen can still be NULL if uaddr is also NULL
>
> How?  In the patch 2 and 4, it seems uaddrlen always points to an
> actual variable.

