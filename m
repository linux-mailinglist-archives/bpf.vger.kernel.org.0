Return-Path: <bpf+bounces-1233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B640B7111B4
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 19:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75AB51C20EF0
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 17:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A247A1D2C9;
	Thu, 25 May 2023 17:11:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA141D2B8
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 17:11:29 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DF7189
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:11:27 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2af1ae3a21fso9073981fa.0
        for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685034685; x=1687626685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLELQcg3F2fdjP53A7X+R97NpI6q4Y88p/1FRkg41+w=;
        b=mtWxAU9XX5MzvfPjT/pOx1nnx/dV+WCLRlxQGGdVAE4JD0q+NYZu2cTLuPAJXCo30B
         pMSWsPwHMIUsXGtub7MMnK+vdU+tMDTQ6E7rWej/5um2aOhZUoNF5YZOzcEbv9jL6o+3
         eqrC97bm/7OLIiso3Iyrob5pVrbbx4wdk0/9zSH0h1lW8lnnF9fNZzMnz/EYLYQ292iA
         KyVZ2sUna9ibd4AB8NEIhnMHK1/iCljypHvUvm2wN5Nc8XLcWVts/27w9PrxUmHjiVWT
         QpMiZl/9iChNhJFCmhKAB0i+dyVR0lHEqFkZ9VN6RlNfaaGBPibjLgUHFToYZ6HJPHpV
         3oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685034685; x=1687626685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLELQcg3F2fdjP53A7X+R97NpI6q4Y88p/1FRkg41+w=;
        b=Xoq250BWXDCajw+33KSWCaReM0oH4gQYW326H5rM1jupCRezTVSXFRegJmS+ITsBh7
         IicCXtuyfVfgrK+fsVregpXNafm+9sBEmfGGfL8AdoQpcHFHwcpUKOJVzvhxd21JW8cd
         q12qzvTY3t8z73Z3gJFcXwtJwBEb9AVelJiTN1CsFmi+X2/j0+mHxWFqfvGbM7jOnoxw
         jaAWC+jzTc6zGtOeI8zX5Pf0zp/q+dL6DgyW95UHEXdcWt58GjACqoS3F4Dhf2FrOfNf
         6M7YBX7/+l5RadDf+ZlKThINimlC4+IZp1H8MiZ/hPoD0NLfGWj3Ekoi44pVNUAwJ3H4
         E8rA==
X-Gm-Message-State: AC+VfDwj3dfO7elypCgBza3t6pksdNM6juv4NaiUWUdAfBj56AmUfMPf
	GLUhX/El0ivZbzHTCIioixjY3MmNc8Bp3VMcaOe/m4QY
X-Google-Smtp-Source: ACHHUZ5vwdATJ7XP4L/oavxtYPt/LkOkzxT1HdvetLMb0fykXER9oHWDkQJ9iKNf8Z0Kh/0iMuy3mqG7Yn4D3CxMXJs=
X-Received: by 2002:a2e:b0d2:0:b0:2af:2786:2712 with SMTP id
 g18-20020a2eb0d2000000b002af27862712mr1353876ljl.25.1685034685032; Thu, 25
 May 2023 10:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230524225421.1587859-1-andrii@kernel.org> <20230524225421.1587859-3-andrii@kernel.org>
 <CAADnVQJ1UEDVH6L=CEjbAudgKmDbp26=-3AfU0sFA_j92Dhn7Q@mail.gmail.com> <CAEf4BzZNfj1M5NcmUEQLudH0DjiexaR9UZPQ_U+xvbtviXGtAA@mail.gmail.com>
In-Reply-To: <CAEf4BzZNfj1M5NcmUEQLudH0DjiexaR9UZPQ_U+xvbtviXGtAA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 May 2023 10:11:13 -0700
Message-ID: <CAADnVQK1cmkc3a287KT0-708wL150CO0V0MLtH6CJeF8HEbnhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: don't require CAP_SYS_ADMIN for getting NEXT_ID
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 25, 2023 at 10:05=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, May 24, 2023 at 8:23=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, May 24, 2023 at 3:55=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >
> > > Getting ID of map/prog/btf/link doesn't give any access to underlying
> > > BPF objects, so there is no point in requiring CAP_SYS_ADMIN for thes=
e
> > > commands.
> >
> > I don't think it's a good idea to allow unpriv to figure out
> > all prog/map/btf/link IDs.
> > Since unpriv is typically disabled it's not a security issue,
> > but rather a concern over abuse of IDR logic and potential
> > for exploits in *get_next_id() code.
> > At least CAP_BPF is needed.
>
> Ok, sounds good. I was just trying to minimize the number of commands
> that would need token_fd.
>
> BPF_MAP_FREEZE is the one I care about the most, if that one looks
> good, should we land that single patch?

Sure. Applied.

