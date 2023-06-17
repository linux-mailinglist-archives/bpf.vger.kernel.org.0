Return-Path: <bpf+bounces-2777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A90FE733DAF
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 04:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6471A281927
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 02:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69632A3D;
	Sat, 17 Jun 2023 02:55:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA0627
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 02:55:39 +0000 (UTC)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019A635BE;
	Fri, 16 Jun 2023 19:55:38 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-63008f9293dso1382976d6.1;
        Fri, 16 Jun 2023 19:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686970537; x=1689562537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbG2B9brCE1tYRhzSdEpyG6hHDchvWAmjWMkvG4uHrE=;
        b=CQEyYcF3VBMeAzbeVHffFPoDWqyak/TzeqFR6bdljHvCgQ1pcqk6r8bb1jxoknNTro
         hH/lJ/17wi+gcWbadRt6dFaJ6/JOVtGQSoKgnKc8aIhjgkHOBPJmf0P2LjaG2ETShiV7
         VCejAy1pCtTRcArH2gsW8uByuFHJOzIyowDipR0xoOZ1qcFcVIA1DaSwbzq95+fga9B3
         JBTJVYLeI3yZROXQAIi6OSBaYs1Zu+x06AGl0lEG00gEo0RcW7OWMP5qqLvb33SJsSLV
         41hC+M7X2vKhrKsYwe4yvKnMYOFbdJ/hRnX82XZop91RMbioDspwu6o9Xy8PbU+KyHJj
         uprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686970537; x=1689562537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbG2B9brCE1tYRhzSdEpyG6hHDchvWAmjWMkvG4uHrE=;
        b=eZYrIFhQrT9CeJV6GMGW6YBMHJoB0ufvYRkwHM45+nolYBhvpKFah6JcQ5NPKmdwbJ
         9k4ypxQb/FevBZdZJOaMARNOjRMd6A4wsHw6+C0aQC4jQ8Hr9o6AWYwBaUVicB5ut6nn
         0Pi7bcqWDCkCPF30T8EdnsCUu4o1+TKUAZWlbSEp+eoQ8BxdMmNTLiAnkzihi94Uc1z2
         TczFNilb7dg2dE6eBxA5goZwCc2232puo3VmDUtr8t1Iz36QC+PKowqIAL+lTfHBY0C9
         FrznX+foUUYw1aamOKa/wPjcFUTyrXe0YSAdIC4ZwhwC7wowRxTnadzfAKYrpKGUoYKn
         sYaw==
X-Gm-Message-State: AC+VfDyssGr3sZdIlkYdzS9jqLURbixgtyz37Tp/YY4erGWIgOwX3fwf
	T32PJt5nsCmWaA2gSBd4pwKneSZvnc64SJ1lGCg=
X-Google-Smtp-Source: ACHHUZ6PjmVeRtsHFxAWFq6GDTi48I1CT+9yRZo1kn/px+DFlAZHDjhQBwBwnB52+XjCWOZdueM/u3tNMtCJSdqDS4k=
X-Received: by 2002:a05:6214:20e4:b0:62d:e668:b668 with SMTP id
 4-20020a05621420e400b0062de668b668mr4296797qvk.12.1686970537091; Fri, 16 Jun
 2023 19:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-3-laoar.shao@gmail.com>
 <CAEf4BzYWMu9LDBewPh+dJ7niCURbSEtdNmDEmAbkrfeBr5QnYw@mail.gmail.com>
In-Reply-To: <CAEf4BzYWMu9LDBewPh+dJ7niCURbSEtdNmDEmAbkrfeBr5QnYw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 17 Jun 2023 10:55:01 +0800
Message-ID: <CALOAHbB4KW+F_djDz-ScX_0DCO1n_8Epj+tUTsZUySvuTgsLug@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 02/10] bpftool: Dump the kernel symbol's
 module name
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

On Sat, Jun 17, 2023 at 1:25=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jun 12, 2023 at 8:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > If the kernel symbol is in a module, we will dump the module name as
> > well.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/bpf/bpftool/xlated_dumper.c | 6 +++++-
> >  tools/bpf/bpftool/xlated_dumper.h | 2 ++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlat=
ed_dumper.c
> > index da608e1..dd917f3 100644
> > --- a/tools/bpf/bpftool/xlated_dumper.c
> > +++ b/tools/bpf/bpftool/xlated_dumper.c
> > @@ -46,7 +46,11 @@ void kernel_syms_load(struct dump_data *dd)
> >                 }
> >                 dd->sym_mapping =3D tmp;
> >                 sym =3D &dd->sym_mapping[dd->sym_count];
> > -               if (sscanf(buff, "%p %*c %s", &address, sym->name) !=3D=
 2)
> > +
> > +               /* module is optional */
> > +               sym->module[0] =3D '\0';
> > +               if (sscanf(buff, "%p %*c %s %s", &address, sym->name,
> > +                   sym->module) < 2)
>
> nit: please keep it single line if it fits in under 100 characters

Will change it.
I thought it is 80 characters.

--=20
Regards
Yafang

