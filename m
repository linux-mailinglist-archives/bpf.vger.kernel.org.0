Return-Path: <bpf+bounces-8762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BEC7899BC
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 00:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2101C208BD
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 22:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BBA10957;
	Sat, 26 Aug 2023 22:43:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733C29B0
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 22:43:22 +0000 (UTC)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A30198
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 15:43:21 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 2adb3069b0e04-4ffae5bdc9aso3251504e87.1
        for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 15:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693089800; x=1693694600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDu1HpNfTx5GoTSAa2/QnPJW5tTxovljP1p0crf9eR0=;
        b=HWsAU0G+5uFABNRkVJReQ40DS3kU+VLZeJLroJ7EVHfsNy9n0fnjY/YGeBzQgHGi2C
         cH7BcLfqXYFavVnp2APcL3VJ2a5Yvl1vC+c+45HzCR2gPfo5DpGzGFNnYOb8mzVDFFDd
         ozBmg4s8oG9b90J+LssioigHtc1LsR5PKNH5Ysp9ooZs/4G8Ma4zdzxt7ivAY1gslexK
         /w7FNz3hyTNmbiuUnLLTEQ70U6JMd4quVYPqaE5mxaMwy0HPrmpKwmV/+VlnlFQEFaTm
         A3s7X2yDnNydBA84QpDheGuD7bp1wFLAj0uRKS/J6vT7t9fK0h4UIAYNiM1P7fLgZM3R
         oCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693089800; x=1693694600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDu1HpNfTx5GoTSAa2/QnPJW5tTxovljP1p0crf9eR0=;
        b=VwpdRD8ORXh0llhIbRBXBWM66GQHtISoCKd6YfN48oWwM9KYctT+FSzE4yfaDkkoe9
         2Ioh3Pg/8yPd27ybh1VMTxkHEQ5SrvQxaSTHeZZ+BSbDabUWRRjCe/0ScpIx2nTnM9NW
         Bxmv7FnSgZpkDotrvr5pz1xxw4eMPMp3GoTYI+dpJSqsONwcJRNCo+Zf66bqXHBQHUzZ
         E53ETOnrYMx75Uudr68QO5tlO4T73KI99UbySsZQwwYtIDipk+CYbbSGGspqpruqRsL5
         4IAvNZqrQCbgKfvXrzs0PRB9YuwR7m/jdHmC+1ebTvbdzy8N0wj+c4jca7rh5wrS4bMU
         hojQ==
X-Gm-Message-State: AOJu0YxS8rElu9ZdUz3/6CfNcOI+U+xmr0Q+ZjSPLBdQ7dq8BtV1cO/x
	jCKDYEb8g2E/gmYeQb5mz190TP+PChQ+aZjfFKQ=
X-Google-Smtp-Source: AGHT+IHx5S5wiSXf3Y1ArlHcKg6moa0UJPiG26TOT2Pc6mtydtuXok/JOQ/1tij5ud1ldmE5E2Lp8ggm0eUm3WTmL2g=
X-Received: by 2002:a19:c512:0:b0:4ff:8dea:9749 with SMTP id
 w18-20020a19c512000000b004ff8dea9749mr14036231lfe.41.1693089799809; Sat, 26
 Aug 2023 15:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com> <CAP01T75MjLeu01FJjxcEF3O1f+4=MiP3St_2M5fmTW9RqkGPnw@mail.gmail.com>
 <87lee2enow.fsf@oracle.com> <f7c404d8-41b5-a48d-f156-5556b38f384e@linux.dev>
 <CAP01T757oTUPuRaxiaNZh2E5FtLdWiYybZy453LUYEE7RmY63Q@mail.gmail.com>
 <CAADnVQLnNgpjsHMBUhHBhwdUNdqoCEEtxv-mSKS==48XNpMZog@mail.gmail.com> <CAEf4BzbFcO7x4oXYVhJ95C0fFuP6uxec4JbokPdq_5RQMyxurA@mail.gmail.com>
In-Reply-To: <CAEf4BzbFcO7x4oXYVhJ95C0fFuP6uxec4JbokPdq_5RQMyxurA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 27 Aug 2023 04:12:41 +0530
Message-ID: <CAP01T763x=ctTKT9pTdM2J2THm=ZaGJoh_J-icB0MK2jYY_xfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/14] Exceptions - 1/2
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 26 Aug 2023 at 00:25, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Tue, Aug 22, 2023 at 4:06=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Aug 22, 2023 at 3:54=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > >
> > > I suppose we could switch to the ' if (!(LHS <op> RHS)) bpf_throw(); =
'
> > > sequence in C, force volatile load for LHS and __builtin_constant_p
> > > for RHS to get the same behavior. Emitting these redundant checks is
> > > definitely a bit weird just to emit BTF.
> >
> > I guess we can try
> > #define bpf_assert(LHS, OP, RHS) if (!(LHS OP RHS)) bpf_throw();
> > with barrier_var(LHS) and __builtin_constant_p(RHS) and
> > keep things completely in C,
> > but there is no guarantee that the compiler will not convert =3D=3D to =
!=3D,
> > swap lhs and rhs, etc.
> > Maybe we can have both asm and C style macros, then recommend C to star=
t
> > and switch to asm if things are dodgy.
> > Feels like dangerous ambiguity.
>
> This seems similar to the issue I had with
> __attribute__((cleanup(some_kfunc)))) not emitting BTF info for that
> some_kfunc? See bpf_for_each(), seems like just adding
> `(void)bpf_iter_##type##_destroy` makes Clang emit BTF info.
>
> It would be nice to have this fixed for cleanup() attribute and asm,
> of course. But this is a simple work around.

Good to know, this is cleaner than my solution. But I am planning to
switch to the direct C approach, so it should not be needed anymore.

