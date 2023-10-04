Return-Path: <bpf+bounces-11408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A55E7B97D4
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 00:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6CF53281819
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 22:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEB6250F6;
	Wed,  4 Oct 2023 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PlM56leG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29532250E5
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 22:21:56 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0761FD7
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 15:21:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50348c54439so736e87.1
        for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696458113; x=1697062913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRYb+Nos6yDxCQJYwqOzPdAjSY5dhjaa83JaZUviEiE=;
        b=PlM56leGd34N3gHvuP5shCEJnnF2EDHvUZtXzDMepNIWs7JhlMLE7Cl71fjWwCunV+
         zbb/bYnpxj2lANxVZZByKJTa6HaAByGyu6/u9fGN3BkyUvy5VH+T5N93V/EV2NgtmVP+
         fNwPBtzWYTiZeKH3gZaYwXzo0OXhuVAEXWERLvCMT5lcd2jt1/50Ap641SAr/yxT1yYE
         Qq1aQeEn4uqdwtFJKLLteEfOTxXlZxLPs0P4AtgfAxhOv9OOrWtZ9O087CDx9LaRz1DQ
         ojd6H2hC1ZOEAdDEFcLfJ2+8CxO3ago0cIxkEArz989VZ9FswugO6S1jtebTBS1yfAHg
         islw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696458113; x=1697062913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRYb+Nos6yDxCQJYwqOzPdAjSY5dhjaa83JaZUviEiE=;
        b=wHMn6HzC6jjpZd/B8od0UK0qoGGpQhHW/NiB1nDVMVcrPJP05o16MNIRivjosGJjph
         9epMW7vHCnz+nKqnRaFCItrK2GRxbIYD+2FzpiEy088SMu4JSAtlvNl3gTXaHOzE9Sw3
         4WTldSFh8UPpV7OTE42G0/IMHs11SlZXBhIHf5j3Or3jo4CgcCDEklV3wE5dytgctEwT
         BGuYUsaxEnd8LsJRKRXojLC6gvJrSjA1ltWK0GCN/LD+2ZdFbCGB7B2c+LJcUgV7SAks
         6bCECKLikuH7mqdgRcJlwhbYo+4BU9H0LER33IrShqesUVzTM0XtCmaZw+rCkS2tBY1p
         k9mg==
X-Gm-Message-State: AOJu0YzOErZ35qQooH2OvCfRYMVYtvYR+eEnxod/O9bqWf7T5XjZEifa
	mSBkbSFE9ssAn91f6rbpN42kGjTYaJ4TL46y4SYJvQ==
X-Google-Smtp-Source: AGHT+IHOZwKOIzXYv0rnMV44X3j6tDuj846UZOfywXJyvDqJY3dmmQt7XRg5LbxJSpoKEYUZ2uDg/BkZ4kweXrxTiqM=
X-Received: by 2002:a19:f50d:0:b0:505:6e12:9e70 with SMTP id
 j13-20020a19f50d000000b005056e129e70mr32520lfb.6.1696458112755; Wed, 04 Oct
 2023 15:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004204334.3465116-1-irogers@google.com> <CAEf4BzaftfOjHCy_tOnXeX7_ZioBwZtKfT-3yvcQ2M9XfzRM-w@mail.gmail.com>
In-Reply-To: <CAEf4BzaftfOjHCy_tOnXeX7_ZioBwZtKfT-3yvcQ2M9XfzRM-w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Oct 2023 15:21:38 -0700
Message-ID: <CAP-5=fUo2hb--bcZ2B-HvAYqDHTX=tE+WFqMyhDTHb+H3e2NVw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpftool: Align output skeleton ELF code
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 4, 2023 at 2:56=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Oct 4, 2023 at 1:43=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > libbpf accesses the ELF data requiring at least 8 byte alignment,
> > however, the data is generated into a C string that doesn't guarantee
> > alignment. Fix this by assigning to an aligned char array. Use sizeof
> > on the array, less one for the \0 terminator, rather than generating a
> > constant.
> >
> > Fixes: a6cc6b34b93e ("bpftool: Provide a helper method for accessing sk=
eleton's embedded ELF data")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  tools/bpf/bpftool/gen.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
>
> CI is not happy still, see [0]
>
>   [0] https://github.com/kernel-patches/bpf/actions/runs/6411371996/job/1=
7406696212

Thanks, typo crept into patch 2/2. Will send v4.

Ian

> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index 2883660d6b67..b8ebcee9bc56 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -1209,7 +1209,7 @@ static int do_skeleton(int argc, char **argv)
> >         codegen("\
> >                 \n\
> >                                                                        =
     \n\
> > -                       s->data =3D (void *)%2$s__elf_bytes(&s->data_sz=
);     \n\
> > +                       s->data =3D (void *)%1$s__elf_bytes(&s->data_sz=
);     \n\
> >                                                                        =
     \n\
> >                         obj->skeleton =3D s;                           =
       \n\
> >                         return 0;                                      =
     \n\
> > @@ -1218,12 +1218,12 @@ static int do_skeleton(int argc, char **argv)
> >                         return err;                                    =
     \n\
> >                 }                                                      =
     \n\
> >                                                                        =
     \n\
> > -               static inline const void *%2$s__elf_bytes(size_t *sz)  =
     \n\
> > +               static inline const void *%1$s__elf_bytes(size_t *sz)  =
     \n\
> >                 {                                                      =
     \n\
> > -                       *sz =3D %1$d;                                  =
       \n\
> > -                       return (const void *)\"\\                      =
     \n\
> > -               "
> > -               , file_sz, obj_name);
> > +                       static const char data[] __attribute__((__align=
ed__(8))) =3D \"\\\n\
> > +               ",
> > +               obj_name
> > +       );
> >
> >         /* embed contents of BPF object file */
> >         print_hex(obj_data, file_sz);
> > @@ -1231,6 +1231,9 @@ static int do_skeleton(int argc, char **argv)
> >         codegen("\
> >                 \n\
> >                 \";                                                    =
     \n\
> > +                                                                      =
     \n\
> > +                       *sz =3D sizeof(data) - 1;                      =
       \n\
> > +                       return (const void *)data;                     =
     \n\
> >                 }                                                      =
     \n\
> >                                                                        =
     \n\
> >                 #ifdef __cplusplus                                     =
     \n\
> > --
> > 2.42.0.609.gbb76f46606-goog
> >

