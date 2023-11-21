Return-Path: <bpf+bounces-15478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634F37F22F5
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0AB281834
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE7B5394;
	Tue, 21 Nov 2023 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnIr4X86"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E9991
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:14:40 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c88b7e69dfso593061fa.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700529278; x=1701134078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCqpOYPf4+UezrOorh46d01YDBuUlTd/+NGfYa3Xew4=;
        b=LnIr4X86fm7nX+n49P4Qw/oSaa+4xxXsi+EhLU5GO26FMaN27YFor1Sdt+QkEvmEl9
         9/8FPDq2lxOnyRODRUnVV2ATe18KEFSwN50AU0HkxJ7PzCGW1WU2oHrOWQrfv6AZF7kS
         jlj/pAnxS8nZ3A6hNTjz2MpFxty/VKzXy0jqxh4073UYnW71G7Fjet7Sq7JCMPyYVyHG
         XmznXQQah/TR+insYpNNhngFWhVuNzkQrsQKcj/Nz86NTse6UdPmB5L7K2FJu79UDbSy
         z89A/8wSJK+LCz8hgVDL7wDnvR8qPMuAeT5tcKo89PQl3sNH5oZCb5l7a3SV0YeaRJe5
         BMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700529278; x=1701134078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCqpOYPf4+UezrOorh46d01YDBuUlTd/+NGfYa3Xew4=;
        b=bnVxX9y6Pp1+LRpXdMloa0vVcqyRUiFE73OhbyCJylMDPLgnJze9k24SHuiz1zunwN
         OAwVuVjmQWv5bHg3EVK6vOs9i7EJVW6IaTYYdILpfI92mCj1lWK5GGm6GAm1wCPX2BMB
         yRJUMiICekkRgDIOaPlCYqtN4LQijDdX7F7PndjtELIHWalICmKyx891FOe8bxJAoHEM
         AesCZZkTOw5x4bUwA6h1hyeLoam4WlCfnJNeC9gcswZlAlUA8zn194RXqapd6oGUxnzh
         qoe645O6//ke2J+U22n4BNGHvMMlkLUC3BX8q5GQqFIxgKP26kXucfF6p97Aw85nV+Ol
         3b+g==
X-Gm-Message-State: AOJu0YyNWqQCupK5ue79EcXXFcsC27YL9YF6zFPBqoDdhHMYJQQNNu3F
	i1w57zyFDopX+HQKvIRLztK8yoKsTAPJ5HCfaI0=
X-Google-Smtp-Source: AGHT+IFQ2hKnJyJAewUcFcDxYo2d7Dwm9EZMILu8UcyMrXnOKOgYQMN0X1IQLqJeXrFl4BKad8V9f9nPt9DVmKqs9Bc=
X-Received: by 2002:a05:651c:1494:b0:2c5:1542:57e9 with SMTP id
 t20-20020a05651c149400b002c5154257e9mr4824079lje.41.1700529278026; Mon, 20
 Nov 2023 17:14:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120225945.11741-1-eddyz87@gmail.com> <20231120225945.11741-11-eddyz87@gmail.com>
 <CAEf4BzZc8eCQ=2qCqWD9+LHobrSA3cxQ-yHpVFm4zRQ0Phn1bg@mail.gmail.com> <b0d346784ff3aac63927f1798cf1fcd14ebfde1e.camel@gmail.com>
In-Reply-To: <b0d346784ff3aac63927f1798cf1fcd14ebfde1e.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 20 Nov 2023 17:14:26 -0800
Message-ID: <CAEf4BzYghTaNgn+0E66N4X2hZ0wG8KOpza=O9BonKwhdviq2kw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 10/11] bpf: keep track of max number of bpf_loop
 callback iterations
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 5:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2023-11-20 at 17:04 -0800, Andrii Nakryiko wrote:
> [...]
> > > @@ -10309,8 +10311,19 @@ static int check_helper_call(struct bpf_veri=
fier_env *env, struct bpf_insn *insn
> > >                 break;
> > >         case BPF_FUNC_loop:
> > >                 update_loop_inline_state(env, meta.subprogno);
> > > -               err =3D push_callback_call(env, insn, insn_idx, meta.=
subprogno,
> > > -                                        set_loop_callback_state);
> > > +               /* Verifier relies on R1 value to determine if bpf_lo=
op() iteration
> > > +                * is finished, thus mark it precise.
> > > +                */
> > > +               mark_chain_precision(env, BPF_REG_1);
> >
> > huh? What about error handling?
>
> My bad.
> Should I fix and re-send as V4 immediately or wait till tomorrow?

Other than this issue everything looks good to me, but perhaps give
Alexei a bit of time to take a look over latest version, just in case?

