Return-Path: <bpf+bounces-1767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85262721473
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 05:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2DA281712
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 03:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52AB1C26;
	Sun,  4 Jun 2023 03:22:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B102B17F6
	for <bpf@vger.kernel.org>; Sun,  4 Jun 2023 03:22:31 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CE4CF
	for <bpf@vger.kernel.org>; Sat,  3 Jun 2023 20:22:29 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-5ed99ebe076so36877016d6.2
        for <bpf@vger.kernel.org>; Sat, 03 Jun 2023 20:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685848949; x=1688440949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f00RJioAbqTKZqGtB/VKBIfUgLCrnzqSe1PH2knYmdw=;
        b=XwW4u/8IOF/FoB8JqVzzS0GRmQ1x3d9DAn9jJl1dXCJvBVtyr2oti9aof5yi6/b1CG
         t7AwrIfKgCSNZw8xOzA29/qwTvGxSpQ2OplATUqiyHcHJwmrdnDNwcaoRjY1VpVi3//s
         j2Ej1y51HtvSeJbhkxiQxraLbmuIXrNdL+2+1aWOWGXk7xkA0ikNSHput0hcmQdeQSiu
         Tkvbg/VABu5nvUIf+HnvmRIC7XMzY2Yy1m9Ko1bi0EmLY4Tz6eGpAN8r/6a7g+kDlVXD
         AuJKiG3xpPXQ8wZy/4wfeJa6tJb1qoJkUeHJK7OR6V4dG1+Q5Qxvjgnx2Zdz7RlCEzkT
         rT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685848949; x=1688440949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f00RJioAbqTKZqGtB/VKBIfUgLCrnzqSe1PH2knYmdw=;
        b=PX6g3ml0+H0a9aT9okiGkNtM/DlP+YUlGhFhHkjOy7dFTVGHdJx8EWzmxeJIfqiExv
         CG4TIxr7GundQUz69mcOQkU0NjcT9VB4qaVyE1oJoUXIhT2zYTSMKdMrSUGX+r6M7Kot
         6uKWjKHEABkOClIqdJxsKv/7GWklmpIWju1iUVNbrE3Gs3EvusFmg4RZnXrAl2uuvPwp
         CZ9UK0RF0SHcKHiz09M1OMLcrdYMAYhhwXNdaP+wctuV4vjU+k3KhIDnYSG0vHqRN45+
         YH4J9ZRrA0DiiBeKnJzKHms/SOBpLt3jrO5gX+zBoNyyCxFwPJ2Mo5LbEH2a6no1di5A
         4lfA==
X-Gm-Message-State: AC+VfDzZF5kfwlOFPaUzrb/+4MtYJtYgQoafGyriqU5HPIj/FAwiUP+o
	co3iyFcMowRnrV++Tjn3wn3l7iRQU9b/OuJK27M=
X-Google-Smtp-Source: ACHHUZ63Up8cbbQ23wpjLqHWLDPxmlzGKYYa+gG4sIXaNG3eQvAXvem4XFXSe4cHAdfoDeCxDvRl64+DtWtu00BzoLg=
X-Received: by 2002:a05:6214:f6d:b0:625:8b9a:b426 with SMTP id
 iy13-20020a0562140f6d00b006258b9ab426mr4914512qvb.46.1685848948982; Sat, 03
 Jun 2023 20:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602085239.91138-1-laoar.shao@gmail.com> <20230602085239.91138-2-laoar.shao@gmail.com>
 <ZHocxh+VsAR1kgI1@google.com>
In-Reply-To: <ZHocxh+VsAR1kgI1@google.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 4 Jun 2023 11:21:53 +0800
Message-ID: <CALOAHbCmxarvvRe3hZYZzBjqW5h=LW532mj99y9YW+_dT_2-Sw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: Support ->fill_link_info for kprobe_multi
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 3, 2023 at 12:46=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 06/02, Yafang Shao wrote:
> > By adding support for ->fill_link_info to the kprobe_multi link, users =
will
> > be able to inspect it using `bpftool link show`. This enhancement will
> > expose both the count of probed functions and their respective addresse=
s to
> > the user.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h       |  4 ++++
> >  kernel/trace/bpf_trace.c       | 26 ++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  4 ++++
> >  3 files changed, 34 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index a7b5e91..22c8168 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6438,6 +6438,10 @@ struct bpf_link_info {
> >                       __s32 priority;
> >                       __u32 flags;
> >               } netfilter;
> > +             struct {
> > +                     __u64 addrs;
> > +                     __u32 count;
> > +             } kprobe_multi;
> >       };
> >  } __attribute__((aligned(8)));
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 2bc41e6..ec53bc9 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2548,9 +2548,35 @@ static void bpf_kprobe_multi_link_dealloc(struct=
 bpf_link *link)
> >       kfree(kmulti_link);
> >  }
> >
> > +static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link =
*link,
> > +                                             struct bpf_link_info *inf=
o)
> > +{
> > +     u64 *uaddrs =3D (u64 *)u64_to_user_ptr(info->kprobe_multi.addrs);
>
> Maybe tag this as __user as well?
>
>         u64 __user *uaddrs =3D u64_to_user_ptr(info->kprobe_multi.addrs);
>
> copy_to_user expects __user tagged memory, so most likely sparse tool
> will complain on your current approach.

Thanks for pointing it out. Will correct it.

>
> > +     struct bpf_kprobe_multi_link *kmulti_link;
> > +     u32 ucount =3D info->kprobe_multi.count;
> > +
> > +     if (!uaddrs ^ !ucount)
> > +             return -EINVAL;
> > +
> > +     kmulti_link =3D container_of(link, struct bpf_kprobe_multi_link, =
link);
> > +     if (!uaddrs) {
> > +             info->kprobe_multi.count =3D kmulti_link->cnt;
> > +             return 0;
> > +     }
> > +
> > +     if (!ucount)
> > +             return 0;
> > +     if (ucount !=3D kmulti_link->cnt)
> > +             return -EINVAL;
>
> [..]
>
> > +     if (copy_to_user(uaddrs, kmulti_link->addrs, ucount * sizeof(u64)=
))
> > +             return -EFAULT;
>
> I'm not super familiar with this part, so maybe stupid question:
> do we need to hold any locks during the copy? IOW, can kmulti_link->addrs
> be updated concurrently?

No, we can't update kmulti_link->addrs concurrently.  Once a fprobe is
registered, we can't update it unless we unregister it. When we reach
the ->fill_link_info, it can't be released, so it is safe.


--
Regards
Yafang

