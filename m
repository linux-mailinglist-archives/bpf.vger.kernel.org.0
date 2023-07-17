Return-Path: <bpf+bounces-5131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE19D756AF3
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 19:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5B21C20A68
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0664ABA5D;
	Mon, 17 Jul 2023 17:47:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D4DBA3A
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 17:47:45 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F620191
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 10:47:44 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b73564e98dso71700051fa.3
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689616062; x=1692208062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXHuNKx8F0F2eR3CCsdvxLHSd5uasejSjtbl4SkgFU0=;
        b=QUaUrvDRyDIhvUGTTiH1WzOLcIwFJqN9hVTli9IiPCDTNp9RlNMgHPKPdnVCWsx8q+
         SBqfWD0bkeyHF+KaUg1/bIaKNZB3fmvlRotRzRCLnRf+CwMre1EJm3MBGtjOko+hBz7b
         KMRwPkAe6EyLqwRYx+pR/7cC/u6mJ/ZKrDHbQKlPFu4Qb+V7S04p6bXQO4nFaKLPZYE8
         Teo3ZtnfcAi6axVj6rtXzDi/x9gAgqS8QoPRPu5FNhMGFiI5JApK1eH/WRd1H/Hxrcsn
         gH1l2hTOTqnYJDYEaMMseAv2V26Ed0CUA7oqbVaFXHAb9peqyoNdbX1itilXqn3aWNo5
         9e2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689616062; x=1692208062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXHuNKx8F0F2eR3CCsdvxLHSd5uasejSjtbl4SkgFU0=;
        b=OskhFHTo7T4ZbiAbYy6ciXeh/u06oduloKuFFBjkfET0UZiKbG7BeeZ96HVsPw6LSZ
         jGsmtNXmn23gAEnZwFbo7x1lrmTDR+eH7ikQtptS8bflEoTHJ4K7vzUAsgXOlwLXakJy
         1f6NMDHLFF4gNGjlhNGNWzy2itePqVXMNA4tE/z+ci4bU8LdomEsdbheRfBNDUJFej8j
         Jp6BxctmC++pnCMjMW1CR3mRwe9tMXEJcDYoiYGNWNLZWay1ffZ0gvNOSMvV59RJi0fb
         fJo0dUMsRUeQR6s+iHeS3BjLyZu1ko4R55krRaFkH7+o6ZBc/31whBdLmDvhNSDZWFEM
         82Gw==
X-Gm-Message-State: ABy/qLY0AB8IYpIGm/sSHn6TreI3bM0u+U284k8/eCLQH71u8OfpMYzh
	5hRuWWdGEN4ftfkXOva0kTIrlxcZOhsWtBE8CCs=
X-Google-Smtp-Source: APBJJlHjQ9NHq9MomlPQnAFioc51/OjGQ/az0DnCair6gXT2hrNgjBKRZ732sMyqKf1tKE0mV1oh1MH2diappNJe15Q=
X-Received: by 2002:a2e:98ca:0:b0:2b9:48f1:b193 with SMTP id
 s10-20020a2e98ca000000b002b948f1b193mr944698ljj.46.1689616062233; Mon, 17 Jul
 2023 10:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713023232.1411523-1-memxor@gmail.com> <20230713023232.1411523-9-memxor@gmail.com>
 <20230714224750.27ufbap5guvkqayk@MacBook-Pro-8.local> <CAP01T77dBfMrBsQiEK7TY05oCXnD8zndBTPygb9_b+R0nL3n5A@mail.gmail.com>
In-Reply-To: <CAP01T77dBfMrBsQiEK7TY05oCXnD8zndBTPygb9_b+R0nL3n5A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Jul 2023 10:47:31 -0700
Message-ID: <CAADnVQKSGosH5SwLCxTmPNdbOE+OvtaAgX_xgZOLT4v-viFF9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 08/10] bpf: Introduce bpf_set_exception_callback
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 9:47=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, 15 Jul 2023 at 04:17, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jul 13, 2023 at 08:02:30AM +0530, Kumar Kartikeya Dwivedi wrote=
:
> > > By default, the subprog generated by the verifier to handle a thrown
> > > exception hardcodes a return value of 0. To allow user-defined logic
> > > and modification of the return value when an exception is thrown,
> > > introduce the bpf_set_exception_callback kfunc, which installs a
> > > callback as the default exception handler for the program.
> > >
> > > Compared to runtime kfuncs, this kfunc acts a built-in, i.e. it only
> > > takes semantic effect during verification, and is erased from the
> > > program at runtime.
> > >
> > > This kfunc can only be called once within a program, and always sets =
the
> > > global exception handler, regardless of whether it was invoked in all
> > > paths of the program or not. The kfunc is idempotent, and the default
> > > exception callback cannot be modified at runtime.
> > >
> > > Allowing modification of the callback for the current program executi=
on
> > > at runtime leads to issues when the programs begin to nest, as any
> > > per-CPU state maintaing this information will have to be saved and
> > > restored. We don't want it to stay in bpf_prog_aux as this takes a
> > > global effect for all programs. An alternative solution is spilling
> > > the callback pointer at a known location on the program stack on entr=
y,
> > > and then passing this location to bpf_throw as a parameter.
> > >
> > > However, since exceptions are geared more towards a use case where th=
ey
> > > are ideally never invoked, optimizing for this use case and adding to
> > > the complexity has diminishing returns.
> >
> > Right. No run-time changes pls.
> >
>
> +1
>
> > Instead of bpf_set_exception_callback() how about adding a
> > btf_tag("exception_handler") or better name
> > and check that such global func is a single func in a program and
> > it's argument is a single u64.
> >
>
> That does seem better. Also, a conditional bpf_set_exception_callback
> taking effect globally may be confusing for users.
> I will switch to the BTF tag.
>
> Any specific reason it has to be a global func and cannot have static lin=
kage?

The compiler will warn about the unused static function.
Even if we silence the warn somehow the verifier will not verify that
static unused subprog.

