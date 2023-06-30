Return-Path: <bpf+bounces-3757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417037432B6
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 04:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEEE9280F70
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 02:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C21B185D;
	Fri, 30 Jun 2023 02:23:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4110017D4
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 02:23:22 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396233585;
	Thu, 29 Jun 2023 19:23:17 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-635e0e6b829so9766856d6.0;
        Thu, 29 Jun 2023 19:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688091796; x=1690683796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxtCAW/pigRB9UCYHu0wPmoTio+PyOcCXS///ptljlo=;
        b=J4fBH17/k1RO98lxuTEK8Hr9dqoKKD3YeGMqltlVi8EDHlGJ/Y6/C13cWhXQTvArXG
         VrMjzZyHYWwr4PGXQOYWSKVeF8V4OU93otYCW/Crs59qSiZivPku64t8q94xZYnbSAWA
         nY4foY4wuHVQoX7anZbGFIuFBFSUFXHKnXVchadm1Y2Gf/eghCBK++o/sCZ+UEmygy1T
         nnTEe+aUVMdX839o9kfN6B0OGAD0hcQXR0AeT5CQpLM84CzaicsqB6EIiH6LZzJS+uai
         U8TEWfb59GgC4Ij67cq10UGJSt331aQritapOz6sKjX8rh4KCawjVzML3a2vbWwZ3cRE
         O3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688091796; x=1690683796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxtCAW/pigRB9UCYHu0wPmoTio+PyOcCXS///ptljlo=;
        b=Z81gndt6puVyspuzbjfmWNzSjGcYvsYGCBUeMuQZm7PHZZNiwJWeUajwqhsgp9zMiP
         ubkGNbfwpRIlwlIdNtDSS1a8nKPuvfiXIYYBsON3ZXX1DO9LzYWjtiHoDjvI1Z2DdYYy
         9gCc2KUN/viXXCpCvQgnA52J/iQ+RpmyR5Rr1/5ws6Gc5gZ59HepiBGVXH8zjqMvsDQR
         N/1LT9VJePBaF9pL5f4lo4LUt3mXPM7ZprKwxyvWmkg6wt4MGT6+d9SUW979J95kYXAP
         vBMHRuaU0BZgne6863qC/1ebS0J4VYoPTaJPbEVUQ0/etq0JDWhj5Q/q1PkLIwJ4Sb6C
         0AgA==
X-Gm-Message-State: ABy/qLb3Rivrq4cctqNfpBQ62CMWz7q0RyKq8CU0rPYriJ/XErlKGHlI
	+Z2wTZSaPbIh95dezZ2XW95boFf/72eSrIgG+T4=
X-Google-Smtp-Source: APBJJlHXypI2kHaZ0Fn5V977JSmzRMpKN58RC1CXMMdHsqv2vnk60q2aSis4AnWpK6194CzRDSoPQygCTUGxquhv0+8=
X-Received: by 2002:a05:6214:629:b0:62d:f3a6:872f with SMTP id
 a9-20020a056214062900b0062df3a6872fmr1767171qvx.5.1688091796249; Thu, 29 Jun
 2023 19:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628115329.248450-1-laoar.shao@gmail.com> <20230628115329.248450-3-laoar.shao@gmail.com>
 <4892a56a-44f8-c45e-c119-503d63ce0fd2@isovalent.com>
In-Reply-To: <4892a56a-44f8-c45e-c119-503d63ce0fd2@isovalent.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 30 Jun 2023 10:22:40 +0800
Message-ID: <CALOAHbAq1Yf0s=RkRsbJOHqOMkhBGRwGxk+zwJZ2p++q0=v4CA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 02/11] bpftool: Dump the kernel symbol's
 module name
To: Quentin Monnet <quentin@isovalent.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
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

On Thu, Jun 29, 2023 at 9:46=E2=80=AFPM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> 2023-06-28 11:53 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> > If the kernel symbol is in a module, we will dump the module name as
> > well. The square brackets around the module name are trimmed.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> > ---
> >  tools/bpf/bpftool/xlated_dumper.c | 6 +++++-
> >  tools/bpf/bpftool/xlated_dumper.h | 2 ++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlat=
ed_dumper.c
> > index da608e10c843..567f56dfd9f1 100644
> > --- a/tools/bpf/bpftool/xlated_dumper.c
> > +++ b/tools/bpf/bpftool/xlated_dumper.c
> > @@ -46,7 +46,11 @@ void kernel_syms_load(struct dump_data *dd)
> >               }
> >               dd->sym_mapping =3D tmp;
> >               sym =3D &dd->sym_mapping[dd->sym_count];
> > -             if (sscanf(buff, "%p %*c %s", &address, sym->name) !=3D 2=
)
> > +
> > +             /* module is optional */
> > +             sym->module[0] =3D '\0';
> > +             /* trim the square brackets around the module name */
> > +             if (sscanf(buff, "%p %*c %s [%[^]]s", &address, sym->name=
, sym->module) < 2)
>
> Looking again at this patch, we should be good for parsing the module
> name with the sscanf() because I don't expect a module name longer than
> MODULE_MAX_NAME to show up, but I wonder what guarantee we have about
> symbols names staying under SYM_MAX_NAME? Maybe we should specify the
> max length to read, to remain on the safe side (or in case these limits
> change in the future). But it doesn't have to be part of your set, I can
> send a follow-up after that.

Great, thanks for your work!

--=20
Regards
Yafang

