Return-Path: <bpf+bounces-10164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215107A24A3
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 19:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DEC1C208FA
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0852E15EA3;
	Fri, 15 Sep 2023 17:28:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEC1125A1
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 17:28:01 +0000 (UTC)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA581FE0
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 10:28:00 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-44ee3a547adso1191094137.2
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694798879; x=1695403679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBx1hoY5PaQpXwL2dsImRM31NJgrOYqyresVxtCo5BM=;
        b=vz+trQObzDkoX89BRND9Ty2ng0XqR6JM0orE3ykotWtS+NzAEE15Rt+R1zR99hSA1y
         SrCQZti93wizutuPem4gEFe/dd5H0T8uHuxDYx3KskmMy3H7Nln6x1opO67lXOZLjWoV
         lsDsWvqYBNV+Bcufc/uqu3R579zEf2aFf51BkCHc8Jwn5kFg58hsUma004TOgBuHy5I2
         o0NhguXqD2vyF/rK6LcRs+/yy/nNsxp+Z+KQLlR0ZO9YHipmz9V5KgpCGEop2R9rvE+x
         n3C8UHcKiOp36momCoJtf4WmwPfWj693weWIXt/kZjhVLIfhZvo1zYd4WmFQVzDBiBHd
         rUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798879; x=1695403679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBx1hoY5PaQpXwL2dsImRM31NJgrOYqyresVxtCo5BM=;
        b=fkZphSlLtK1B+bhACEtuS80ZtUIxEDnD0T2fg1OwZP+Ih9Sye2FZxuhCEEZS2eDNBi
         R6YoMJZF9CzxdP5qUgKoHpv/oY2csrGs3MO/cgQATzMVlAudrJyx/YaoLWKN5mNdCetD
         CIb8LPd5as1ETyauTKRxwYpmkIV/8B3HOlG5kpNFHV6Ig/oixTBsmsmiUzIOqVfHyer+
         EQHA4qwtazKmomyPF+vaxGJdOLJU5+o/wBP6eHxda6cF1Op+yulD/nLpPSxpd2b/0L4x
         sEI63GEDmCrMfbfxVZe0yZX8Hb/XPYBowE4jR8RIB9a2OjExyCe2UtjAGktFE1yM9sQI
         BFLQ==
X-Gm-Message-State: AOJu0YxMIrPfC4zXRnen2Cu1yMv6olJi4xrCGHgi6rJpKn8jEmO2J+Ix
	ot6jDI7mGi1Xwlzzid8gLa2noQGJ8McZIrHu4kxcTA==
X-Google-Smtp-Source: AGHT+IHoXwv0U1iZvbuzdBD1l9a76pV9SltA1MClPWdM60chw6iXLS8T8UaRiPGVw21kyR23xujQjsZKrwc719PpkTM=
X-Received: by 2002:a05:6102:2e5:b0:44f:c528:6255 with SMTP id
 j5-20020a05610202e500b0044fc5286255mr2507484vsj.16.1694798879090; Fri, 15 Sep
 2023 10:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915103228.1196234-1-jolsa@kernel.org> <CAKwvOd=XXry=gbaUCUqprPqxeSnFKbe2drPygFU8SDFw=HwuXw@mail.gmail.com>
In-Reply-To: <CAKwvOd=XXry=gbaUCUqprPqxeSnFKbe2drPygFU8SDFw=HwuXw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 15 Sep 2023 10:27:44 -0700
Message-ID: <CAKwvOdnqnacgCJspRAJwxz0nYOi+nVFgt7_TYRvTR9x-iLY=ig@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix BTF_ID symbol generation
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Marcus Seyfarth <m.seyfarth@gmail.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 9:25=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Sep 15, 2023 at 3:32=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >
> > Marcus and Nick reported issue where BTF_ID macro generates same
> > symbol in separate objects and that breaks final vmlinux link.
> >
> > Adding __LINE__ number suffix to make BTF_ID symbol more unique,
> > which is not real fix, but it would help for now and meanwhile
> > we can work on better solution as suggested by Andrii in [2].
> >
> > [1] https://github.com/ClangBuiltLinux/linux/issues/1913
> > [2] https://lore.kernel.org/bpf/ZQQVr35crUtN1quS@krava/T/#m64d7c29c407d=
6adf0e7b420359958b3aafa7bf69
> > Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/btf_ids.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > index a3462a9b8e18..a9cb10b0e2e9 100644
> > --- a/include/linux/btf_ids.h
> > +++ b/include/linux/btf_ids.h
> > @@ -49,7 +49,7 @@ word                                                 =
 \
> >         ____BTF_ID(symbol, word)
> >
> >  #define __ID(prefix) \
> > -       __PASTE(prefix, __COUNTER__)
> > +       __PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
>
> I think __COUNTER__ and __LINE__ both expand to string literals; you

ah, no I was wrong.

But this change needs to go into tools/include/linux/btf_ids.h, too.

I'll wrap that up in my v3.

> can avoid another expansion via __PASTE by just putting them adjacent,
> like so:
> https://github.com/ClangBuiltLinux/linux/issues/1913#issuecomment-1710794=
319
> I'll send that as a v2 and link back to your v1.
>
> >
> >  /*
> >   * The BTF_ID defines unique symbol for each ID pointing
> > --
> > 2.41.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers

