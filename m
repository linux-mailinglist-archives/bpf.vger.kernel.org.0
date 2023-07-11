Return-Path: <bpf+bounces-4741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E2E74E9CE
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41A3281591
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F971774D;
	Tue, 11 Jul 2023 09:04:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6311F17723
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:04:46 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C2D83
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:04:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-992b66e5affso686982866b.3
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066283; x=1691658283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xl9SOWGP8ddrOP0rQisqKTntp669ykt/pgKZ9RJ0p+c=;
        b=hNHIlSOHdhqWK+OHQggA+Ieg9+VkcW+Fh2hVTQmHD2AjseQ4hhajmnEFhPDT2FvEOW
         0WadnCaNfovw3UqxKuOKX96ei/ZPNk/9kWHDnNhoOe2/BIxb7n2vOkytZn1fOW2yK/nv
         /cYXrnVJE2JCHjKn3HJQSLCNi6nw7LUR/DunkhhaWUQTCGfb+VRVux3tpccZa4KaR9to
         kvABSpYC2xyUpO5k0VaRGKPeOzmz3E1IEOJD5rg93OU/QSV90ULn+5wGKh6XmGlnphAg
         DTDv3bDi8JcOCAQhNZcJRgYQzEHZ0CSpzPtPbvaYaOg448Vj04FO3xpXyYlWZFX+uMaS
         g/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066283; x=1691658283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xl9SOWGP8ddrOP0rQisqKTntp669ykt/pgKZ9RJ0p+c=;
        b=NaZ+RYiyVTU2WZjk82fJpQmjcN8nXKSkacPiBqOsr03oNCoSGi2mlVCiq73lFU/Jsy
         tBgLv19GCJb5qXMZFOst5V/3oc59oq5yC5bbreFMqh4JVVtBBoJwT7NWR0mXYuwuj/eX
         wmiK5ivuZ2rs20hDuDEfV+kJxcZxsi+WpeQIjH5M2e5GdkMYEMO7Rukzr4IAGlqsKiKN
         J0h+6p6zakDnLqVizdIOmovSpqpvgwy9YykjY9i2GyXertkVG1pdsoIW1VNdeH0tUqvH
         jGHdG9zUgej7p9OGRS7yMqLpqaMYV9TGUDImoj7bmnyPpYLdNB4ya8x1ub1IHRmRbJVN
         IO9g==
X-Gm-Message-State: ABy/qLaLl9JvEAc4vkstxV3ysVu6ZfmOfqFrl2FfqO/wME0XA8vNzNKq
	qGeltRsnecATRSHiVrvGqJ0=
X-Google-Smtp-Source: APBJJlGm4nNPZZK/EcLwRuX7TXMKWYuLUo6XPzMZdPNClrQfk7gJHElyjVZ041hIAZb95UTChzHYXA==
X-Received: by 2002:a17:906:cf83:b0:992:bc8:58d9 with SMTP id um3-20020a170906cf8300b009920bc858d9mr13897639ejb.70.1689066283235;
        Tue, 11 Jul 2023 02:04:43 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b00992b66e54e9sm860262ejb.214.2023.07.11.02.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:04:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 11:04:39 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 11/26] libbpf: Add elf_resolve_pattern_offsets
 function
Message-ID: <ZK0bJ2ovPJSO0wO3@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-12-jolsa@kernel.org>
 <CAEf4BzZsF5jyVxETLTJ507CMx75HQxEUndoqbAVqakBXkJs5eQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZsF5jyVxETLTJ507CMx75HQxEUndoqbAVqakBXkJs5eQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 08:52:13PM -0700, Andrii Nakryiko wrote:
> On Fri, Jun 30, 2023 at 1:36 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding elf_resolve_pattern_offsets function that looks up
> > offsets for symbols specified by pattern argument.
> >
> > The 'pattern' argument allows wildcards (*?' supported).
> >
> > Offsets are returned in allocated array together with its
> > size and needs to be released by the caller.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/elf.c             | 57 +++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf.c          |  2 +-
> >  tools/lib/bpf/libbpf_elf.h      |  3 ++
> >  tools/lib/bpf/libbpf_internal.h |  1 +
> >  4 files changed, 62 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > index 7e2f3b2e1fb6..f2d1a8cc2f9d 100644
> > --- a/tools/lib/bpf/elf.c
> > +++ b/tools/lib/bpf/elf.c
> > @@ -376,3 +376,60 @@ int elf_resolve_syms_offsets(const char *binary_path, int cnt,
> >         elf_close(&elf_fd);
> >         return err;
> >  }
> > +
> 
> same, leave comment that caller should free offsets on success?

yes, will add

> 
> > +int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
> > +                               unsigned long **poffsets, size_t *pcnt)
> > +{
> > +       int sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
> > +       unsigned long *offsets = NULL;
> > +       size_t cap = 0, cnt = 0;
> > +       struct elf_fd elf_fd;
> > +       int err = 0, i;
> > +
> > +       err = elf_open(binary_path, &elf_fd);
> > +       if (err)
> > +               return err;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
> > +               struct elf_sym_iter iter;
> > +               struct elf_sym *sym;
> > +
> > +               err = elf_sym_iter_new(&iter, elf_fd.elf, binary_path, sh_types[i], STT_FUNC);
> > +               if (err) {
> > +                       if (err == -ENOENT)
> > +                               continue;
> > +                       goto out;
> > +               }
> 
> ditto, minimize nesting, please

ok

> 
> > +
> > +               while ((sym = elf_sym_iter_next(&iter))) {
> > +                       if (!glob_match(sym->name, pattern))
> > +                               continue;
> > +
> > +                       err = libbpf_ensure_mem((void **) &offsets, &cap, sizeof(*offsets),
> > +                                               cnt + 1);
> > +                       if (err)
> > +                               goto out;
> > +
> > +                       offsets[cnt++] = elf_sym_offset(sym);
> > +               }
> > +
> > +               /* If we found anything in the first symbol section,
> > +                * do not search others to avoid duplicates.
> 
> DYNSYM is going to have only exposed symbols, so for this pattern
> matching, maybe it's best to start with SYMTAB and only fallback to
> DYNSYM if we didn't find anything in SYMTAB (more realistically it
> would be that SYMTAB section is missing, so we fallback to DYNSYM;
> otherwise neither DYNSYM nor SYMTAB will have matching symbols, most
> probably, but that's minor)

makes sense, will switch

> 
> other than that, LGTM

thanks,
jirka

