Return-Path: <bpf+bounces-14602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2208E7E7056
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B710BB20C67
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 17:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A9322335;
	Thu,  9 Nov 2023 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuuozWgS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F0F225D5
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:33:09 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3402F93
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:33:08 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d242846194so193245566b.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 09:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699551186; x=1700155986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqxNgyCfquZgCRJyY7ejgrXVZ9a9CIwXzFKaNkDrgtU=;
        b=GuuozWgSYsfXFGE9oi92ss3S5IvLkT2lRO0RmaaIYGBBxRlahosjBkYaz1QuJ4KYGq
         yYRHUoHF9uyz41koUb5VZOmqAqIeEFswL+uIi+DEtapf/du0fRmsm+397rMY05oZBJWy
         JTNMO+tICbHlwCceSYP6sZ37ElVt2DQwJANRwI07hoADizCJR7gJSk8Bc+Y6ysbCphvM
         w5rsV67+fFyycvQrBrhmVPmRKpcjYvGMe+DT3OnbTbBnQnAuSugBKol11TEYH6aCOmS4
         i3+50CDpEEZTmtH2e6Hp5KY7JvPsqkZb05m8CmJdyxzgmFe4uyfbpOZYPKMKFGgVs8le
         2Y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699551186; x=1700155986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqxNgyCfquZgCRJyY7ejgrXVZ9a9CIwXzFKaNkDrgtU=;
        b=Cn9uTQ5R/GJujr4f5XNSkwYeJtnSR2DfOMPk4i4Jvft1cJlLocDRLBIXtmr6ouqiJE
         0cV09I+5wZmBhqJ7t+aNrfxEA2QjIBJ6lo2XENiyFbJm1PRTNy2n3fynYP1ooNz8CnIt
         ITRlYoICu+dB4mOHRyz2Z2miqvcYJvz0VgeqGPgk1UWtS7g/Tirc0wrR+UfyPUSeOrUe
         Fl8Ue+FrDegiN7OHy3jRmeebL+VhD+ewCs62FwDEesAk1ILrttggZKJmiqU0lSm03p/c
         T4Xow7lq1Y0ONeVUiN+FJNnG8CDciTywBnVRTeLexyxq3KqIb1k8LJxesANFKSSsxgnq
         x5PQ==
X-Gm-Message-State: AOJu0YyUc7MIgMTgIFRpA6At5LgOb3j7vbkvcJ/RKgPGHnXJEPW6Y1Y/
	cyYtfsQwgdpkB5j2QUj7Wq1u21OtUNKWHHonsIA=
X-Google-Smtp-Source: AGHT+IGMrrK0WeSdIv+Jf3amUwDIfP0O8XALkynylOAnyn8ffsPz1eJam9IO1yB2ZTfPihLVaV5gAhGsPkiMEaamw5s=
X-Received: by 2002:a17:906:6a25:b0:9c7:59d1:b2c6 with SMTP id
 qw37-20020a1709066a2500b009c759d1b2c6mr5127130ejc.11.1699551186316; Thu, 09
 Nov 2023 09:33:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-4-andrii@kernel.org>
 <71cc364752f383559c7d7a570001fd353f0ca8aa.camel@gmail.com>
In-Reply-To: <71cc364752f383559c7d7a570001fd353f0ca8aa.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 09:32:55 -0800
Message-ID: <CAEf4BzY1-mcN5Wjf4-FOKQvnom+0EV=a=cGxvBO9=rbCS0kzwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: enforce precision for r0 on callback return
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 7:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
> > > Given verifier checks actual value, r0 has to be precise, so we need =
to
> > > propagate precision properly.
> > >
> > > Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> I don't follow why this is necessary, could you please conjure
> an example showing that current behavior is not safe?
> This example could be used as a test case, as this change
> seems to not be covered by test cases.

We rely on callbacks to return specific value (0 or 1, for example),
and use or might use that in kernel code. So if we rely on the
specific value of a register, it has to be precise. Marking r0 as
precise will have implications on other registers from which r0 was
derived. This might have implications on state pruning and stuff. If
r0 and its ancestors are not precise, we might erroneously assume some
states are safe and prune them, even though they are not.

I'll see if I can come up with a simple and quick test. I can always
drop this change, it was a bit of a drive-by bug I noticed while
looking for other issues.

>
> > > ---
> > >  kernel/bpf/verifier.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index fbb779583d52..098ba0e1a6ff 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -9739,6 +9739,12 @@ static int prepare_func_exit(struct bpf_verifi=
er_env *env, int *insn_idx)
> > >                     verbose(env, "R0 not a scalar value\n");
> > >                     return -EACCES;
> > >             }
> > > +
> > > +           /* we are going to enforce precise value, mark r0 precise=
 */
> > > +           err =3D mark_chain_precision(env, BPF_REG_0);
> > > +           if (err)
> > > +                   return err;
> > > +
> > >             if (!tnum_in(range, r0->var_off)) {
> > >                     verbose_invalid_scalar(env, r0, &range, "callback=
 return", "R0");
> > >                     return -EINVAL;
>

