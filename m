Return-Path: <bpf+bounces-248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264886FC9C0
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 17:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC362812F1
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9634017FFC;
	Tue,  9 May 2023 15:00:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D6417FE2
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 15:00:07 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476973A82
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 07:59:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso11604141a12.2
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683644398; x=1686236398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADXiPsxIN6T0wAbewWhpTZxTvEZYbRMztt7aAo/Vs9U=;
        b=T6TJR9aauydj86HPmGPfaCAfvE2CQo/HbS+BtFoJZjO8eg1HxSwAd2cN5fGvqTNaO1
         OcDdtqRasHi6ddUiAGn63vsTICsZase0MjL11mtqKvhgCW/RrCT5r61QD5gPq1d3nJeF
         uGuaAay1JkRmBPsrMNlSWPJxXt08jBf0A3CxtTB+C7vxFzztYySoZMit8MOK8Ujis4xe
         ylO5E+X/3/uGK742hoAAqKPQqQQJWfpVPnfRZiEgR90y4lDVHO9Tc9FvxAH5mdob3Ayv
         bLj3xkYUprXywc48lCoHmIOTedpXTKCCxqNhfGovnnRGagXKomHM1N5MRJ0Z605QVJTn
         BCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683644398; x=1686236398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADXiPsxIN6T0wAbewWhpTZxTvEZYbRMztt7aAo/Vs9U=;
        b=cLc9B1TGV1GG1MqtBJbgXloJypqcjyqTmniedCF61HHCyGvqsAezj4ECsziT/cC75O
         1S2pezC8aSLyr0CGtSJSmNQBzcduHnreO0OlYJV3d4qyqlJhN5GPHAzxTyUJeZ60PYI7
         ylgYruWNtM8Q9C19xKoUSrcg9ZvoIMlPxc2cMryIs279fp5ZNHg6qpagkkImh89mbWci
         t+Cv7LNt30Xxl7ONJzUhQkZJ+Q0RVCUf9G87WFHQdvESKxLBu9E06vQtH49WhxNUyZE5
         KT7oyNKRUmsrotl7ilPhX5Ml5KITu4OYnIvcOfvnf6TfeXULdD9PuxFsfQlg3fc4wlI+
         mWfw==
X-Gm-Message-State: AC+VfDySBJSjO6+TWhKIzvm/42VE6RLgAF4RB1MI+AMSiTCaRzzGSGmG
	WZUMGtE8X9asj/MJpZw3GL6ElhVY82QoP7rj8WI=
X-Google-Smtp-Source: ACHHUZ5wkz26fTGZm09mzV+1OREn8/7VXaXygL/H+k7R8zGaLmB1Sdi6g5GBscAF0uYHWRpqvDsPgCK0HKuKe7D6snA=
X-Received: by 2002:a17:906:58cd:b0:966:350f:f42d with SMTP id
 e13-20020a17090658cd00b00966350ff42dmr9663315ejs.23.1683644397530; Tue, 09
 May 2023 07:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509065502.2306180-1-andrii@kernel.org> <2ce2dbb1-20d5-cd4d-9e84-97d505b57bb5@meta.com>
In-Reply-To: <2ce2dbb1-20d5-cd4d-9e84-97d505b57bb5@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 May 2023 07:59:45 -0700
Message-ID: <CAEf4Bzampv=wkcdJct2BR3VmAPZvx8_S7RJ_3dbzVo0H2U+Mpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix offsetof() and container_of() to
 work with CO-RE
To: Yonghong Song <yhs@meta.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 9, 2023 at 6:33=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 5/8/23 11:55 PM, Andrii Nakryiko wrote:
> > It seems like __builtin_offset() doesn't preserve CO-RE field
> > relocations properly. So if offsetof() macro is defined through
> > __builtin_offset(), CO-RE-enabled BPF code using container_of() will be
> > subtly and silently broken.
>
> This is true. See 63fe3fd393dc("libbpf: Do not use __builtin_offsetof
> for offsetof"). At some point, we used __builtin_offset() and found
> CO-RE relocation won't work, so the above commit switched back to
> use ((unsigned long)&((TYPE *)0)->MEMBER).
>
> >
> > To avoid this problem, redefine offsetof() and container_of() in the
> > form that works with CO-RE relocations more reliably.
>
> I am okay with the change to forcefully define offsetof() and
> container_of() since this is critical for correct CO-RE
> relocations.
>
> >
> > Fixes: 5fbc220862fc ("tools/libpf: Add offsetof/container_of macro in b=
pf_helpers.h")
> > Reported-by: Lennart Poettering <lennart@poettering.net>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Ack with a nit below.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> >   tools/lib/bpf/bpf_helpers.h | 15 ++++++++++-----
> >   1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> > index 929a3baca8ef..bbab9ad9dc5a 100644
> > --- a/tools/lib/bpf/bpf_helpers.h
> > +++ b/tools/lib/bpf/bpf_helpers.h
> > @@ -77,16 +77,21 @@
> >   /*
> >    * Helper macros to manipulate data structures
> >    */
> > -#ifndef offsetof
> > -#define offsetof(TYPE, MEMBER)       ((unsigned long)&((TYPE *)0)->MEM=
BER)
> > -#endif
> > -#ifndef container_of
> > +
> > +/* offsetof() definition that uses __builtin_offset() might not preser=
ve field
> > + * offset CO-RE relocation properly, so force-redefine offsetof() usin=
g
> > + * old-school approach which works with CO-RE correctly
> > + */
> > +#undef offsetof
>
> I am not sure whether the above 'undef' is good or bad. In my opinion,
> I would just remove the above 'undef'. If user defines
> offset as __builtin_offset, the compiler will issue a warning
> and user should remove that macro or undef them.

If we don't #undef, we are almost guaranteed to get a compilation
warning. See [0], where I repro this problem based on Lennart's
original code.

  [0] https://github.com/anakryiko/libbpf-bootstrap/commit/2bad3e7f48e4e4ee=
a1a083620f21eba59aa75b1a

>
> Otherwise, user may get impression that their __builtin_offset
> is working but actually it is not. the same for container_of.

Can we just fix __builtin_offset() to generate/preserve field offset
CO-RE relocation?

>
> > +#define offsetof(type, member)       ((unsigned long)&((type *)0)->mem=
ber)
> > +
> > +/* redefined container_of() to ensure we use the above offsetof() macr=
o */
> > +#undef container_of
> >   #define container_of(ptr, type, member)                             \
> >       ({                                                      \
> >               void *__mptr =3D (void *)(ptr);                   \
> >               ((type *)(__mptr - offsetof(type, member)));    \
> >       })
> > -#endif
> >
> >   /*
> >    * Compiler (optimization) barrier.

