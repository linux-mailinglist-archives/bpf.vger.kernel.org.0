Return-Path: <bpf+bounces-14123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D58B7E0A93
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB77B214D7
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 21:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C976B23745;
	Fri,  3 Nov 2023 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdM1utJc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDDD1D68E
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 21:07:22 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FC9D44
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 14:07:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9d224dca585so376433966b.1
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 14:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699045346; x=1699650146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzqudwtNeym/erjc8BuSDE0MREEoFygoxOGA+kSktyQ=;
        b=EdM1utJc7Vq6Fd/HcVe2eWNw1Koxrra6Ji8YLI8jLnP7gXgHxXI903vxUcvqm1utaP
         lOWsEYQYth75G5jn6VqgGkkt8p6jzbtD22irhE0kWG3efbUWC6NaI89gSGSeEhP14SJs
         uXAMRh2QCek+Ly6MWGBnh/ZE34i7YCRJfZpoxs2F8Bf9M3oupuDQ0dd+DIHZC/x2tIEJ
         9Nir9GQc2Qy2eSIN/9/b2qRezDJ79VSBa+gt4qEXYAC/meKmRnM/EDhx057NndUac5OG
         b9Ji/GQo4RYtmXVWFdg1Z8PSdd9J+83GRKFKMSv6omcX2Zle1lBx75fKyv8ZhZ2UE0/0
         GySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699045346; x=1699650146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzqudwtNeym/erjc8BuSDE0MREEoFygoxOGA+kSktyQ=;
        b=kk0N2Qzr3tjMvyw423WshU58SnR0FC1n/wrD6JvnS7suVFtIgCJR9y2oIuxmF84yqJ
         FXlmy7J7/zLbZ2NaLy2mO2a9fq640+lujvq9rvN7xVwA+TjxvEMWZaRjIeStwpIhEAlo
         zLQEwSSul2fW4a6XqU4r3Ka/vWxHFU1Lcq9S9lNI0rUB0WQesEHB+YA3W7oF9+HBnepT
         iTsUS17gykIaGVeoigvrHfwFcM1MqnD0OuLpFCoHCkrkgtLV6di2c7G4QvpQUWRPGKHL
         MwcIuYQTZHScI3shn651TJnR4+SHhW4UxU9obIZZ1jB+v6gcEkN80JUtcIsQi+MsQSF6
         Xv5Q==
X-Gm-Message-State: AOJu0YymjL1Ff5OpTe6ap/RJt6Nipa279+nRqARGqWQF6ZEHh2HMYWOU
	uRBMAYyOyIMWgJBHyg1H2NFqgx+rgJuMompQIpo=
X-Google-Smtp-Source: AGHT+IFcrGicaYoTFdEX3AfsRxNLB0eEr6KUcrw7l7B8HmFnCNb9XN4OU/t7tUV3tmL5l+X15dws/5J0mBvLjqMf50I=
X-Received: by 2002:a17:906:eece:b0:9c7:5a14:ecf2 with SMTP id
 wu14-20020a170906eece00b009c75a14ecf2mr8650447ejb.56.1699045345786; Fri, 03
 Nov 2023 14:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103000822.2509815-1-andrii@kernel.org> <20231103000822.2509815-3-andrii@kernel.org>
 <a8b287efb678249f0dff828a724385b36923144f.camel@gmail.com> <CAEf4BzZ_qAf2+9hiKo0bDx=_ayXZyMmz5QBUmyCYDrk97k__hg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ_qAf2+9hiKo0bDx=_ayXZyMmz5QBUmyCYDrk97k__hg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 14:02:14 -0700
Message-ID: <CAEf4BzaFKw_7wuOhi0wCY0_5LMji92hynQPWi4CH6Renjm9nqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/13] bpf: generalize is_scalar_branch_taken() logic
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 1:59=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 3, 2023 at 9:47=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Thu, 2023-11-02 at 17:08 -0700, Andrii Nakryiko wrote:
> > > Generalize is_branch_taken logic for SCALAR_VALUE register to handle
> > > cases when both registers are not constants. Previously supported
> > > <range> vs <scalar> cases are a natural subset of more generic <range=
>
> > > vs <range> set of cases.
> > >
> > > Generalized logic relies on straightforward segment intersection chec=
ks.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >
> > (With the same nitpick that '<' cases could be converted to '>' cases).
> >
>
> Ok.

Actually, this one is more annoying because of all the umin1/umin2/etc
initialization at the beginning. The conditions are very
straightforward, so I'm inclined to keep it as is for simplicity.

>
>
> > > ---
> > >  kernel/bpf/verifier.c | 103 ++++++++++++++++++++++++++--------------=
--
> > >  1 file changed, 63 insertions(+), 40 deletions(-)
> > >
>
> [...]

