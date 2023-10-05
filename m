Return-Path: <bpf+bounces-11481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B32B7BAE93
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 00:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E15952820DC
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 22:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC7D42BEF;
	Thu,  5 Oct 2023 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="saxmJmKl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F80141E45
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 22:03:28 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16B99E
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 15:03:26 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4053f24c900so15235e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 15:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696543405; x=1697148205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT1UXws5EaLoSLlRb6+SPNkgqpM3S+hu1ZvOKq4ES/E=;
        b=saxmJmKlGUJ+FQMfZsmD1UF+pwbmXD3WGRqwnalbmkj7HgcZyfte9FhDIj1ITEH444
         Obvm2GpZenL60foXRjLT08cKdZ0d1VhHA8qEHf/hSQuGkWNYfQY2urQN9UdfXN8UYkvh
         3CmV9IvfbZDQ1vQhIGP0TBXdm6k7sju1BURzn3ypRpX/rfsE7vLAzBPGLqoFMeUqpr0v
         NAXrxfdDFznfpWAWfa7gZ7AH+lB8jlVBQYLsCIHgsRmErJ53aK1UVYwS/Dt+svmhr3a7
         II3Pkcf1i2blTiZ197xw5+A94TDYWqU+T63Y/9+WpfTwvSwXEJun5R3i8nFJ+aqCqCZw
         G91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696543405; x=1697148205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MT1UXws5EaLoSLlRb6+SPNkgqpM3S+hu1ZvOKq4ES/E=;
        b=OljKncgZDw97BCVit8wlRnUjusRiRIcUsua9Vkx0zbio4yJVqayTAXy3vnA1oKJwE2
         EJ8tNCmlbIiAIIX3MfTFlGHPcaw5+DGXXQ9SMpnfWff1spIQNZUbChj3GO2iggbNR7ds
         SNcrC+0wk/C/K2mtbaBo7RN7hjzG0paeNLPZG0PpqauYGY3OPBAoPI+tPAD4qtaWRWPY
         WLPGxjCWf4FP9tjVkvToPm/hzLdpC5Jsyuh620C1pBOuX4UEdTsEBsIrmMYAf4SOExNw
         f0iSlbIiA75W35PULShCCmzD7WLEjCZz0BGpGbioM6Xr34bQvs6g2Knfh11OvLk71yNB
         ZiAg==
X-Gm-Message-State: AOJu0YxHJQVgBV54LxDXT6sPGTFXCLVHJ5Yr2dN5eb8NkKBXrITMyZ6e
	8ooUBmDiAgrj97ralLn+4+kPAlFfsdwV6JV2c1wy+g==
X-Google-Smtp-Source: AGHT+IHgdetxaCDp/Q2yZTcDE1g0qogeilw5jplia3TNRnClpg1xF2p5U/mvDp+4nAWn1MzWyfPRsmQYFtu7/KnuDmA=
X-Received: by 2002:a05:600c:2182:b0:404:7462:1f87 with SMTP id
 e2-20020a05600c218200b0040474621f87mr106347wme.6.1696543405189; Thu, 05 Oct
 2023 15:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004222323.3503030-1-irogers@google.com> <20231004222323.3503030-2-irogers@google.com>
 <173829f3-817e-4937-808f-7f9bfc22207f@isovalent.com>
In-Reply-To: <173829f3-817e-4937-808f-7f9bfc22207f@isovalent.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 5 Oct 2023 15:03:12 -0700
Message-ID: <CAP-5=fUyDUV_XzaTKF4V5h5yzkqtM27AfK2qRTncQiAryHHYcg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] bpftool: Align bpf_load_and_run_opts insns and data
To: Quentin Monnet <quentin@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 8:54=E2=80=AFAM Quentin Monnet <quentin@isovalent.co=
m> wrote:
>
> On 04/10/2023 23:23, Ian Rogers wrote:
> > A C string lacks alignment so use aligned arrays to avoid potential
> > alignment problems. Switch to using sizeof (less 1 for the \0
> > terminator) rather than a hardcode size constant.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/bpf/bpftool/gen.c | 47 ++++++++++++++++++++++-------------------
> >  1 file changed, 25 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index b8ebcee9bc56..7a545dcabe38 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -408,8 +408,8 @@ static void codegen(const char *template, ...)
> >               /* skip baseline indentation tabs */
> >               for (n =3D skip_tabs; n > 0; n--, src++) {
> >                       if (*src !=3D '\t') {
> > -                             p_err("not enough tabs at pos %td in temp=
late '%s'",
> > -                                   src - template - 1, template);
> > +                             p_err("not enough tabs at pos %td in temp=
late '%s'\n'%s'",
> > +                                     src - template - 1, template, src=
);
>
> Nit: This line is no longer aligned with the opening parenthesis.
>
> Other than that:
>
> Acked-by: Quentin Monnet <quenti@isovalent.com>

Thanks! Nit fixed in v5.

Ian

