Return-Path: <bpf+bounces-19045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841618246ED
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 18:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA90DB23594
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 17:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C320D288D7;
	Thu,  4 Jan 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G198+TT6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7448286A6;
	Thu,  4 Jan 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d8909a6feso7002635e9.2;
        Thu, 04 Jan 2024 09:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704388329; x=1704993129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG8Bg4Obabo/M1F6Z0bcCE/ORgoAsgpcDvLFbC7PvC0=;
        b=G198+TT6ZkGF44YR0ReYgh3GxKH1C1vlzbj5CoBo5runEdmXyo1aotE6IKZezRmp9v
         +GICWuyeRJED+mS3lJcD2TbczAsxGTc7CMDDsv/8awSadopBIEjRlAtw4YZIo7+6J/z/
         1sX2E+9VLYI23YoWnT3cH2HHlRSNH0+RBEMB/tR3bGP9Erf+4AbaN6CM64TkLliLL+IH
         McaAsY+vFmoAqIkWPI8VCF+Npf1EBBmBVJghpeiLaMj05Jw7FSED9SXjEPYs7j50SqmI
         CzgyeGLwq19rOTicBLLU0ZCJM30NESAoVjZNfakk8CICV1ReBKMESz2eBaClnLptGrl2
         RoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704388329; x=1704993129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sG8Bg4Obabo/M1F6Z0bcCE/ORgoAsgpcDvLFbC7PvC0=;
        b=JYVoXPAeaEJ8XnzZwyXJVcyk3RcIPO8P8uRS7pkq7ab8FLdDij81T8/oq6Qk25fFiy
         gw9Jqj+LHqtf9O2L7U2DZjoUGQy5293jugy2uLqZXPPfzUBXKDKLKH7j3fyCdW1H2+B+
         PPdUKDwYgu3WOjXT1O5SFdXr2/nRtJVNhyXPRDD3G4kodZnKa7GlgsirS5Qj5vOKIhBa
         5Qd4vOE+zf1/TppdMV4nHJ7sPczE6Rrf46rRoZvNxtV0UfLd1vl3rb0gZJ2jxL+3tahk
         vjw2MC9X4SNjC7H9W0kKm2VejF9rgiIslBlWztP7+GsTHLN6mH2Tp6tyP+gYlqlZlW6l
         nqRg==
X-Gm-Message-State: AOJu0YwlCW1a3nGP/uLRL6rc6KETgG/QoZU+YPgbLBl/8xT2iNYCYGFO
	IopLL4v6SXg+L+Jvw4AKsJIQUw4+pYnaBCYHVAc=
X-Google-Smtp-Source: AGHT+IEMMu2uhBo+XARafZVBagZiw6E1pz8inc+1+2/Ix3sZhgiZK3K5cAZz98+da3SU+qFBFOPWLfix5gCO+rPTC9c=
X-Received: by 2002:a05:600c:21d7:b0:40d:432e:9984 with SMTP id
 x23-20020a05600c21d700b0040d432e9984mr385322wmj.176.1704388328704; Thu, 04
 Jan 2024 09:12:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704324602.git.dxu@dxuuu.xyz> <29644dc7906c7c0e6843d8acf92c3e29089845d0.1704324602.git.dxu@dxuuu.xyz>
 <ZZaVFxMvmMjbOlra@krava>
In-Reply-To: <ZZaVFxMvmMjbOlra@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jan 2024 09:11:56 -0800
Message-ID: <CAADnVQKZZw-e12-BOJsMMiA3s+vOskQEYRqhviQC2rBMf4AckA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: btf: Support optional flags for
 BTF_SET8 sets
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Quentin Monnet <quentin@isovalent.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 3:23=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, Jan 03, 2024 at 04:31:55PM -0700, Daniel Xu wrote:
> > This commit adds support for optional flags on BTF_SET8s.
> > struct btf_id_set8 already supported 32 bits worth of flags, but was
> > only used for alignment purposes before.
> >
> > We now use these bits to encode flags. The next commit will tag all
> > kfunc sets with a flag so that pahole can recognize which
> > BTF_ID_FLAGS(func, ..) are actual kfuncs.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  include/linux/btf_ids.h | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > index a9cb10b0e2e9..88f914579fa1 100644
> > --- a/include/linux/btf_ids.h
> > +++ b/include/linux/btf_ids.h
> > @@ -183,17 +183,21 @@ extern struct btf_id_set name;
> >   * .word (1 << 3) | (1 << 1) | (1 << 2)
> >   *
> >   */
> > -#define __BTF_SET8_START(name, scope)                        \
> > +#define ___BTF_SET8_START(name, scope, flags)                \
> >  asm(                                                 \
> >  ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"   \
> >  "." #scope " __BTF_ID__set8__" #name ";        \n"   \
> >  "__BTF_ID__set8__" #name ":;                   \n"   \
> > -".zero 8                                       \n"   \
> > +".zero 4                                       \n"   \
> > +".long " #flags                               "\n"   \
> >  ".popsection;                                  \n");
> >
> > -#define BTF_SET8_START(name)                         \
> > +#define __BTF_SET8_START(name, scope, flags, ...)    \
> > +___BTF_SET8_START(name, scope, flags)
> > +
> > +#define BTF_SET8_START(name, ...)                    \
> >  __BTF_ID_LIST(name, local)                           \
> > -__BTF_SET8_START(name, local)
> > +__BTF_SET8_START(name, local, ##__VA_ARGS__, 0)
>
> I think it'd better to use something like:
>
>   BTF_SET8_KFUNCS_START(fsverity_set_ids)
>
> instead of:
>
>   BTF_SET8_START(fsverity_set_ids, BTF_SET8_KFUNC)
>
> and to keep current BTF_SET8_START without flags argument, like:
>
>   #define BTF_SET8_START(name) \
>     __BTF_SET8_START(... , 0, ...
>
>   #define BTF_SET8_KFUNCS_START(name) \
>     __BTF_SET8_START(... , BTF_SET8_KFUNC, ...

I was about to suggest the same :)

We can drop SET8 part as well, since it's implementation detail.
Just BTF_KFUNCS_START and pair it with BTF_KFUNCS_END
that will be the same as BTF_SET8_END.
Until we need to do something else with these macros.

>
> also I'd rename BTF_SET8_KFUNC to BTF_SET8_KFUNCS (with S)
>
> do you have the pahole changes somewhere? would be great to
> see all the related changes and try the whole thing

+1
without corresponding pahole changes it's not clear whether
it actually helps.

