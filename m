Return-Path: <bpf+bounces-11569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C047BC03A
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 22:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE7B2820FA
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 20:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBE943ABF;
	Fri,  6 Oct 2023 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgF1nKu0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722DC28692
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 20:22:20 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1434BE
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 13:22:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5032a508e74so214e87.1
        for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 13:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696623737; x=1697228537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/4hSoCDyaBEYy7aXsgoLzXeIlCi3RJAlrp96XY1SLQ=;
        b=KgF1nKu0lGe2xmMn80uRxeexdo4SSk/JFsTSn2t7igSpS4bbQFKblxTmezmIDGwq6F
         uA9rXTEDr5yGBHDa6mgn3cXF6sm43SpaMfyIRkgO84r6L57j/g4vegE2nyDtgC+VoLcs
         OZrcFb3cPw8xsMdJigFXI0x9UK52LSpEC/T41Fq5LIViviq8BoCiqIlX4U5k9H+YQCRR
         AJOw+dzbch+8mQBvFrxb/AJxv8pAzCpJ4E+8bmg2n3CeGhx903NEyQsmr+S0pzZKsaV1
         wNQE5cqK41/EcguwkOfi5we7zDHjO0X4SMc+Pj6POyNZ94iFU1wk+CPQD9X4hv7/3QMA
         VpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623737; x=1697228537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/4hSoCDyaBEYy7aXsgoLzXeIlCi3RJAlrp96XY1SLQ=;
        b=c/kXQbr0YpprUcbU+BrP3ezMYAKAvFEm09oh3WV2wWEa3PlNrg6mBucnKGymhc57s5
         PsUIBjJUp4uXh8lOkYL4IjjbpCaUgcjiICz0FDd8j05yUBkBaczfVgxa1Qx/CIqNepQd
         BL4S8qAWW2f8KjhTikTPkjvqLFLyBFfwiOlt2rNXI1MXVfHNwB/0QUrL4dpa829uZyoq
         lMlFhzevMugcoYTs1hBRb9tPc+v+3xFpnobdtxMftw8RmGCmlDcnSyQz/QWOkd2Q4Qk4
         qSfxuqxt0KZbI60USzHrRXKlXsv+NCpqykmGrAebVtlh4tDdZhH09jVeYklZVxf/syyW
         Znkw==
X-Gm-Message-State: AOJu0Yw8oRtli9cRW6euwbyZ1iHsuEM4ovA39Uzul2y9F9Vaqk4mx6Q1
	d7Q4hxgoQ/5yew4J3CSMZjbK2freTNI+jJUKNVNsFw==
X-Google-Smtp-Source: AGHT+IHhKTU1D0Ef+p5VelaG4Up6LZ2v8VqW7+q726CrnzSrF9GjvVQH5R7kGBvYSniUUm/TR+Aals4sbq1T7/fPsag=
X-Received: by 2002:a05:6512:4801:b0:502:a55e:fec0 with SMTP id
 eo1-20020a056512480100b00502a55efec0mr146330lfb.6.1696623736764; Fri, 06 Oct
 2023 13:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005220324.3635499-1-irogers@google.com> <CAEf4Bza0YGVW0G-oO3h1j0L0ytiKsn-pRbuqU39C2wO0VP__BA@mail.gmail.com>
In-Reply-To: <CAEf4Bza0YGVW0G-oO3h1j0L0ytiKsn-pRbuqU39C2wO0VP__BA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Oct 2023 13:22:05 -0700
Message-ID: <CAP-5=fW=v9oFr1+B_JcEe+kG60wB2W0dtKkD7Fmkh8KSKdu7Aw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] bpftool: Align output skeleton ELF code
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
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 1:20=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 5, 2023 at 3:03=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
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
> > Acked-by: Quentin Monnet <quentin@isovalent.com>
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  tools/bpf/bpftool/gen.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
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
>
> Seems like you based this on top of bpf tree, can you please rebase
> onto bpf-next, it has a small change here and I can't apply it cleanly
> anymore. Other than that it looks good. Thanks!

Sure thing, sorry for so many V-s, we'll get there in the end.

Thanks,
Ian

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

