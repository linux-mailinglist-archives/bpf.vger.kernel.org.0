Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62116F0E55
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 00:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbjD0W3a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 18:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbjD0W33 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 18:29:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD1235BD
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 15:29:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5067736607fso15807030a12.0
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682634566; x=1685226566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nu9c+JYVDXoXRe7gMJDNxF765maXU8cKOOwpQT2K5c=;
        b=kEbrB9n6AIeUH92NxhIH4jUusc03GjByYNLSu6mfNU+XP/aVA9BFgvWiy4ROEFRSyB
         6nL7TE1K5qjUv2uUpoodM3hy7d8/Ic5VUEbrzlOaXnbDxT/9kTFfrYTSPRrX8YquVo8n
         G9z8emcdQJk5QkkIkYHARVYv9nn55tGWwY2teK4M3B/5hMk+sQhHm7Cpfv6ZHCRXlEZt
         UuRHuN46MjaAGhxsamFC2AYKwNTZ2i3xuyrzg04YnuvsJn5wXT3fMhDIml6Kg+h1YsCB
         VdrO03ZDAgFBYBrsENmMd4j/YFCVKGSguZqhelCczCwS33Mcn09hC26WiNcmH10oBy1b
         WQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682634566; x=1685226566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nu9c+JYVDXoXRe7gMJDNxF765maXU8cKOOwpQT2K5c=;
        b=Jx3vpQUcNuLWLOmCF0Al8CXAJWcTNFyVm+cmi/09GXaqjWCXOc0KRIma7ufaMjxytV
         /Ndg+2jA4zn8Ybbcud+hcOL1hKzMRFqA5vS9Q9dz8HCt1JN63lizvjMS0KFwMcteG5Uv
         j4Yp5ux1OgQqNng7ssmcM4sZZjGBWjow+HFpY5fhr7jXxHFETqUekJQs7MOb08PhEZZW
         TKqunBIxe4vqHV/ikD5yQRY67TZ96KzypKemYYishPor/ZHLWx9Lcux6Dy+um5mqsX08
         Mu3fJyZT2wCvaEI6vJO+7Y8nZARXyetFmfllRRNjxO/1p4MzlgFssxCw2qVeCdOjhaQM
         XMaQ==
X-Gm-Message-State: AC+VfDy6biKRmLduIjNoIsgQA4vItaeFrmmyKE3jUHLA52cvywqrEqcN
        l64+eGMwg5j/UuhjniKSPCphfmdRQQojpzWYvsk=
X-Google-Smtp-Source: ACHHUZ5w5ljNLxqiuZUnGgoIyfrjKgm8NDgDyPNEpnhpF5CAJvEZ+7bU1yBWrCNnF2lyEkAQShYi9s0oZYHfoUlMg5o=
X-Received: by 2002:aa7:c85a:0:b0:504:8efb:c103 with SMTP id
 g26-20020aa7c85a000000b005048efbc103mr2754973edt.0.1682634566332; Thu, 27 Apr
 2023 15:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org> <20230424160447.2005755-9-jolsa@kernel.org>
 <CAEf4BzYKkPHBqbr1pXjA6jEkvJTpu0bjFHt0Nu0bm4un3DD6mQ@mail.gmail.com> <ZEp2xfXGu4kTY7Q3@krava>
In-Reply-To: <ZEp2xfXGu4kTY7Q3@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Apr 2023 15:29:13 -0700
Message-ID: <CAEf4BzbKF+meB5N-eN0tcMdacofhh8hed0Oy2nKtL=AK5ngSnA@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 08/20] libbpf: Add elf_find_patern_func_offset
 function
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 27, 2023 at 6:21=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Apr 26, 2023 at 12:24:16PM -0700, Andrii Nakryiko wrote:
> > On Mon, Apr 24, 2023 at 9:06=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Adding elf_find_patern_func_offset function that looks up
> > > offsets for symbols specified by pattern argument.
> > >
> > > The 'pattern' argument allows wildcards (*?' supported).
> > >
> > > Offsets are returned in allocated array together with its
> > > size and needs to be released by the caller.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> >
> >
> > Why do we need to expose any elf-related helpers as libbpf public API?
> > Just to use them in selftests? If yes, then selftests can use libbpf
> > internal helpers just like bpftool due to static linking. In general,
> > it of course doesn't make sense for libbpf to provide ELF helpers as
> > part of its API.
>
> I use them in bpftrace ;-) I can move the implementation in there,
> if we don't want to expose it.. it was just convenient to use libbpf

yep, let's not expose elf helpers as libbpf UAPI

>
> >
> > Also s/patern/pattern/.
>
> ok
>
> >
> >
> > >  tools/lib/bpf/libbpf.c   | 121 +++++++++++++++++++++++++++++++++++++=
++
> > >  tools/lib/bpf/libbpf.h   |   7 +++
> > >  tools/lib/bpf/libbpf.map |   1 +
> > >  3 files changed, 129 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 0b15609d4573..7eb7035f7b73 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -11052,6 +11052,127 @@ elf_find_multi_func_offset(const char *bina=
ry_path, int cnt,
> > >         return ret;
> > >  }
> > >
> > > +struct match_pattern_data {
> > > +       const char *pattern;
> > > +       struct elf_func_offset *func_offs;
> > > +       size_t func_offs_cnt;
> > > +       size_t func_offs_cap;
> > > +};
> > > +
> > > +static int pattern_done(void *_data)
> > > +{
> > > +       struct match_pattern_data *data =3D _data;
> > > +
> > > +       // If we found anything in the first symbol section, do not s=
earch others
> > > +       // to avoid duplicates.
> >
> > C++ comment
>
> ok, will fix
>
> thanks,
> jirka
