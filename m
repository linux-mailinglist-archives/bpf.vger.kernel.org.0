Return-Path: <bpf+bounces-2628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699F773183A
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 14:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2366D280E46
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 12:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F4715AC2;
	Thu, 15 Jun 2023 12:11:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D83156F1
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 12:11:24 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144B21B2;
	Thu, 15 Jun 2023 05:11:23 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-62de85dd962so25485726d6.0;
        Thu, 15 Jun 2023 05:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686831082; x=1689423082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fegt9akVYBSE0LUaHpMRKpjWLqmUt7+8r975NZq+Uao=;
        b=f44NpdKqr1HzhqlBzEbl1xqY41UcOYkKLWkadu1I+bjq2A79B0gr1JvosVQ/66xb9g
         /bg6i6XUsnhWeFp5PabrFvh9yxj+6iY6/fKCqeOiLWqrhTRXN4htlJzEZm7DfONHovWh
         gQmnzCE7MQSpODo7LT9afIuF+7EHeD9TM8w8xkLzFIVUbmAnJql2yY9j4C4eNjDnFD4p
         zHNxGsJ1sFdFMM1558BE8IDsOGQlfykZYjOWqof62ONBnnj4R2/4daNVl/Nkpmjo3H8Q
         RhYxmq1xhSQ/3bBgh03LLrLzTkn4IC25VvzKEYNzSbJQU9+rEF8En5fmZ5DOhsPmU45Z
         VJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686831082; x=1689423082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fegt9akVYBSE0LUaHpMRKpjWLqmUt7+8r975NZq+Uao=;
        b=jLIhX+30B+X1LRCIA7biPYRfhpwNCpHgq3HxvGaclmYLyJ3ehjvV6BGrXLuNBKgqnc
         8cr6+jK/Qcup5m9RohQKeugz/gDfPSHDMHRFxMYL/vqxmgLxRYLXPl3oziKBFYkn3+g9
         4aTpAbrPik0wjXVQ+0FeIX/3YnFUZGraVQn/0sAVBdrpw4Y5P6wgTvlcwuu4Di4V8gzT
         pnt7AnjmhdoWp/1ABU0ztUwwiJ8yR2ivHNWR8xXmrsDf1PSdhsG6EajY2R12LkDXRKbU
         3/2tHi8jdNtYsieJjAEDqsekyb/vE74w7FFU7DdKnTIq3CMEfnaCY9rh+iH33lQVLBDi
         V2VA==
X-Gm-Message-State: AC+VfDx4OK9OgzYfls6G9hZlxx/OLCho/f/+jfIcvl4rA53DN5nUxxFw
	tDVaqVow1VHN+Kn/aus443EnVQCbKKbvCxVLaTw=
X-Google-Smtp-Source: ACHHUZ4gTzMVfAZJaUQ1KPRjVXpE16EfvHodbXUSKJm9uEkAAUXrQ9LivKUC3WLmAvfQbaQ/vq9XdfLOqcqvjWwDXy0=
X-Received: by 2002:a05:6214:e8e:b0:5d5:fd1d:6ef5 with SMTP id
 hf14-20020a0562140e8e00b005d5fd1d6ef5mr24240424qvb.12.1686831081998; Thu, 15
 Jun 2023 05:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-9-laoar.shao@gmail.com>
 <ZIrmLo9UH//V4sYP@krava>
In-Reply-To: <ZIrmLo9UH//V4sYP@krava>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 15 Jun 2023 20:10:46 +0800
Message-ID: <CALOAHbDOmnEW9BJD=GfuXWwThoxOTqxkxpXPfL8HCDoBUszyYg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 08/10] bpf: Support ->fill_link_info for perf_event
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, quentin@isovalent.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 15, 2023 at 6:21=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Jun 12, 2023 at 03:16:06PM +0000, Yafang Shao wrote:
>
> SNIP
>
> >
> >  /* User bpf_sock_addr struct to access socket fields and sockaddr stru=
ct passed
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 80c9ec0..fe354d5 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3303,9 +3303,133 @@ static void bpf_perf_link_dealloc(struct bpf_li=
nk *link)
> >       kfree(perf_link);
> >  }
> >
> > +static int bpf_perf_link_fill_name(const struct perf_event *event,
> > +                                char __user *uname, u32 ulen,
> > +                                u64 *probe_offset, u64 *probe_addr,
> > +                                u32 *fd_type)
> > +{
>
> this function name sounds misleading, it does query all the link data
> plus copying the name.. seems like this should be renamed and separated

Will do it.

>
>
> > +     const char *buf;
> > +     u32 prog_id;
> > +     size_t len;
> > +     int err;
> > +
> > +     if (!ulen ^ !uname)
> > +             return -EINVAL;
> > +     if (!uname)
> > +             return 0;
> > +
> > +     err =3D bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
> > +                                   probe_offset, probe_addr);
> > +     if (err)
> > +             return err;
> > +
> > +     len =3D strlen(buf);
> > +     if (buf) {
> > +             err =3D bpf_copy_to_user(uname, buf, ulen, len);
> > +             if (err)
> > +                     return err;
> > +     } else {
> > +             char zero =3D '\0';
> > +
> > +             if (put_user(zero, uname))
> > +                     return -EFAULT;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int bpf_perf_link_fill_probe(const struct perf_event *event,
> > +                                 struct bpf_link_info *info)
> > +{
> > +     char __user *uname;
> > +     u64 addr, offset;
> > +     u32 ulen, type;
> > +     int err;
> > +
> > +#ifdef CONFIG_KPROBE_EVENTS
>
> this will break compilation when CONFIG_KPROBE_EVENTS or CONFIG_UPROBE_EV=
ENTS
> options are not defined

Indeed. Will improve it.

--=20
Regards
Yafang

