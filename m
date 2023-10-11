Return-Path: <bpf+bounces-11947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D187C5B6D
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 20:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDBD28232B
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 18:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91301D524;
	Wed, 11 Oct 2023 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+yw66D8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57822231D;
	Wed, 11 Oct 2023 18:38:02 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B824C94;
	Wed, 11 Oct 2023 11:38:01 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so94599a12.1;
        Wed, 11 Oct 2023 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697049481; x=1697654281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2qbuE0qZp1qf7eX2ASC5DKh4tyeMrec4ZbV962Q/SxY=;
        b=f+yw66D8mAFKWZdhReiaSj1DXlrx4zlQ2XhAuq0+xkqWr8Cpcx123lAwnHUT3CvHEt
         tLPhlRNxcJVoSE9dmSqXitm3yV6JEz4fAscEUnaajwGafGMI9ypAD9+1ZBXbAk9zvMSz
         6V0BI1CSrtKOBYQZIA2QJhfzkCBYwR1PwawL8UyYtVzxoux4dKuRQYtdhMkrlu0XAaBp
         URqxzDzlsNOCGmqLFl3HSUtGrswIKWIJfKnvitzpAPXVyW/4YE8M3ddbvBPiCsbEUNW3
         fENkKGIq+7EiDTtUfIF+/E5mnRAD/ItssSpziVw+I7FBujBl20cZQHVmCuzopjIRS6Yt
         UroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697049481; x=1697654281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qbuE0qZp1qf7eX2ASC5DKh4tyeMrec4ZbV962Q/SxY=;
        b=ZjUOIuhVj/1t6t0mahNhF9YxYsZao7VYKbdwCZ716gEVBKVttnOnWNL551xI6EfKEh
         5A1/63j/Az8pX34tng0AjhbmUsWcws5RfipvF55tPzV0bCt64UZLs+1KM5rFeYybgJUi
         hFY/4Mhjd9/kCryt6dmCGIy/rmKS0hrb+9jex1l9+P0zcPaRZpg7HWGLf7H/MY2f+g8R
         PHL5rMJkf/m9SGHk+q0DDEbD1D8+LkxM/UQTNYTpxsJs9LuFcHyyH9koR9e4fAgJjI3k
         WVJKtRqNDY/mIAd6ryMVHRc31nNVidfcwHf08OouCPd11BBWIzCUUYdb4CPtrs487Ik6
         iuZQ==
X-Gm-Message-State: AOJu0Yyk9jM8nAvHeVtUSPMOZfALXgu4Pf7qgJ85LsQx9cHIaZ3mwBAE
	I8IVecbasgoNEz5wphLn3Kn4xVzNQ6q4eJTcQ8g=
X-Google-Smtp-Source: AGHT+IEjPLZKDBeQsntoeGYQknxssRzGxivfimhGeUylrDZDEQk5Y660SpMUMXLAe08Vxf5dAvW9h2HXmHQZuYppvi0=
X-Received: by 2002:a17:90a:d718:b0:27d:853:9109 with SMTP id
 y24-20020a17090ad71800b0027d08539109mr2026445pju.20.1697049481081; Wed, 11
 Oct 2023 11:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011170321.73950-3-daan.j.demeyer@gmail.com> <20231011173528.41599-1-kuniyu@amazon.com>
In-Reply-To: <20231011173528.41599-1-kuniyu@amazon.com>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Wed, 11 Oct 2023 20:37:49 +0200
Message-ID: <CAO8sHc=FfDo_LnpV_tF5aPF4BjpWkQk2jLxLWH50X0JzSQ+s6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 2/9] bpf: Propagate modified uaddrlen from
 cgroup sockaddr programs
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bpf@vger.kernel.org, kernel-team@meta.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > @@ -1483,11 +1488,18 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> >       if (!ctx.uaddr) {
> >               memset(&unspec, 0, sizeof(unspec));
> >               ctx.uaddr = (struct sockaddr *)&unspec;
> > -     }
> > +             ctx.uaddrlen = 0;
> > +     } else
> > +             ctx.uaddrlen = *uaddrlen;
> >
> >       cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> > -     return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > -                                  0, flags);
> > +     ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > +                                 0, flags);
> > +
> > +     if (!ret && uaddrlen)
>
> nit: no need to check uaddrlen here or maybe check ctx.uaddrlen.

Are you sure? uaddrlen can still be NULL if uaddr is also NULL


On Wed, 11 Oct 2023 at 19:35, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> From: Daan De Meyer <daan.j.demeyer@gmail.com>
> Date: Wed, 11 Oct 2023 19:03:11 +0200
> [...]
> > @@ -1483,11 +1488,18 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> >       if (!ctx.uaddr) {
> >               memset(&unspec, 0, sizeof(unspec));
> >               ctx.uaddr = (struct sockaddr *)&unspec;
> > -     }
> > +             ctx.uaddrlen = 0;
> > +     } else
> > +             ctx.uaddrlen = *uaddrlen;
> >
> >       cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> > -     return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > -                                  0, flags);
> > +     ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > +                                 0, flags);
> > +
> > +     if (!ret && uaddrlen)
>
> nit: no need to check uaddrlen here or maybe check ctx.uaddrlen.
>
>
> > +             *uaddrlen = ctx.uaddrlen;
> > +
> > +     return ret;
> >  }
> >  EXPORT_SYMBOL(__cgroup_bpf_run_filter_sock_addr);
> >

