Return-Path: <bpf+bounces-4381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 606A774A8A5
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 03:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEEA1C20EDD
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262B41114;
	Fri,  7 Jul 2023 01:50:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE77F
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 01:50:14 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EE71BFC;
	Thu,  6 Jul 2023 18:50:13 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4039a42467fso690161cf.3;
        Thu, 06 Jul 2023 18:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688694612; x=1691286612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xkwwxsjnj6O7GN890m3K1TW36EBzEJUTmiZuak1j/OQ=;
        b=NLCgH94I79YHekZmvGafQoaSn/+lUJBQWYNBsQvVoXYGlUC8c8xHBeCioWYDjZUr52
         oLPCFvEHPPW05yDdsQikFfdifcIcO9gBq0gl7JBKxkqGT0K3bItvhlaF0RVBMimxbKU0
         UEYlBiCCYEFvMMiWC8Jkq69vppIbcujTrJtI7C0UkEN0BogPzsv8yNmjaauVahqjx6Ck
         H/pPshz6ldA+zZVLAZ7VlzK9PM16XWQP19N6lM6MHwhba+bqITXXRn1QrF8CDqOdoH55
         wIIMSxFBG347mh3hSmw/hcK3osYRghg0qEVU7evTMdztYBcV4T4ORlyT7vcV78G4LETT
         a6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688694612; x=1691286612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xkwwxsjnj6O7GN890m3K1TW36EBzEJUTmiZuak1j/OQ=;
        b=bUjVVUZvdYqp2wIjekEvGCf6XtpLdaNcm7zmVxurxViisxkeFhT6HxVbdjx/avTby1
         y8cbvYP3RdqsEb4u9aJ56tWifBwuwLzpDwtJXVl699Ot2DElHZo1Ffd5JE5Cyn7tYPSE
         Jv/jOZZUh0erdgrJ1QXW90QGbVrQEigC/DHiqB0+bdubtlQ6CXadcoRTa0qgAqFt9I3Z
         JNDjljn1YL9c3+vd3XT52rD2Sr2W3CWhaOld+1GDqvLTtrNNMJWI7E1yMwLIN+QuKOcN
         4QmYeaKobsMJwvhJV1QHl0G78B93U1O06PW/zgXvzzv4VEMZ/3RZIjFHvsHKKfuibJGr
         kvuQ==
X-Gm-Message-State: ABy/qLZEFl0G+TZas+pNvoiCv9zVvhaCvDUMpQdqCwZNc5FBZIlF5hbQ
	v7Tm7XzTempEpJmxUJ/7sd3/oCxQS37wKkm9Ivo=
X-Google-Smtp-Source: APBJJlF1MZ/wrCEMRWL6Rxpy2SCH4BuT8kP9EMglQF/uVWtzJZ14MiFS0bXHWLyiH+PitmcVH7AVrJb9CxAZM478tFA=
X-Received: by 2002:a05:622a:1a10:b0:400:ab3a:1714 with SMTP id
 f16-20020a05622a1a1000b00400ab3a1714mr5055466qtb.11.1688694612438; Thu, 06
 Jul 2023 18:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628115329.248450-1-laoar.shao@gmail.com> <20230628115329.248450-9-laoar.shao@gmail.com>
 <CAEf4BzYOQQHFo6OwRb4ORsCq0iqYRp=MtVFNeGgSW9NCMrdnAw@mail.gmail.com>
In-Reply-To: <CAEf4BzYOQQHFo6OwRb4ORsCq0iqYRp=MtVFNeGgSW9NCMrdnAw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 7 Jul 2023 09:49:35 +0800
Message-ID: <CALOAHbC93w3ECSed+9q9rANnGg=C1m+3+_Hp38+Su1+Bbz-W-A@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 08/11] bpf: Add bpf_perf_link_fill_common()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 6:00=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jun 28, 2023 at 4:53=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Add a new helper bpf_perf_link_fill_common(), which will be used by
> > perf_link based tracepoint, kprobe and uprobe.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/syscall.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 4aa6e5776a04..72de91beabbc 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3364,6 +3364,40 @@ static void bpf_perf_link_dealloc(struct bpf_lin=
k *link)
> >         kfree(perf_link);
> >  }
> >
> > +static int bpf_perf_link_fill_common(const struct perf_event *event,
> > +                                    char __user *uname, u32 ulen,
> > +                                    u64 *probe_offset, u64 *probe_addr=
,
> > +                                    u32 *fd_type)
> > +{
> > +       const char *buf;
> > +       u32 prog_id;
> > +       size_t len;
> > +       int err;
> > +
> > +       if (!ulen ^ !uname)
> > +               return -EINVAL;
> > +       if (!uname)
> > +               return 0;
> > +
> > +       err =3D bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
> > +                                     probe_offset, probe_addr);
> > +       if (err)
> > +               return err;
> > +
> > +       len =3D strlen(buf);
> > +       if (buf) {
>
> if buf is NULL, strlen above will crash, so you need to calculate len
> inside this if branch

Nice catch. Will fix it.

--=20
Regards
Yafang

