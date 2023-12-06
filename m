Return-Path: <bpf+bounces-16903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DAC80772E
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 18:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22348281D2C
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 17:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC59E6DD1C;
	Wed,  6 Dec 2023 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrixC6iL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93D018D
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 09:59:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54cdef4c913so2418442a12.1
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 09:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701885580; x=1702490380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25SzB/BpeoMoFkNczu4OzO1EXZlsdc6o3IRs+kOwkjU=;
        b=nrixC6iL4qtWsXm+ixA8o/+C0S5STxjqQs4dV1pq9ZEp5eNSb6CgqOyWlAFFhwmhmr
         xOwj+qHOsmX0bO0B4JerZzeEMKao2aoxqFsEWtZWmJmMKUjOSDBPmvJnX4m1LDEmyuvf
         AmZlgACPZhEay1TL2DFqxVk+TnMTwndX1lFYE4hTHi7c3/qW3iVXLsSeYwyDth4oP37g
         K+lRDL5kEBdQJp6PRC8Mar5umvGDyhiALu/m2ak05TOwn09frpk4YAfesJ5LNfsmsAdq
         jGm3OfXv934WCF2yPpnp1ZUBE1PkHo/Aa9oys5XUMy5s0gVvDDOWD09HfETH/TzuJyTr
         tmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701885580; x=1702490380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25SzB/BpeoMoFkNczu4OzO1EXZlsdc6o3IRs+kOwkjU=;
        b=RAy+WMWBQzD6l+vbGXBte0ib/uSlyioToIo0SpwZUUKMbGljsLDkqTz9CYGO+Tvwpd
         pf6rjyEWmBXtR8pqGeJ68WsghR8XOXAxr/xWK7zNvzRy6HOKWlQy5Ov9W7XM88CbsOqp
         BP4cJUYKmLtEW30/PEwh+ld57UQpptjodkR5anrFIYSBvSCMKxVvLwlG5WT74OIFmDFg
         VPjAel0jLQs9ESXFpvod0nvmY2Wjk7EnCfT1i5XGz84XdXNNeVZnW6thG0pADRpfGZwS
         qiusqyVRtOmKuI8f7SIHBoRmnldk5CxEl4mnUtbbbE5f8J4TkvAe0FZs8crybyVxZZc1
         2Iag==
X-Gm-Message-State: AOJu0Ywi7SnFsMKyrHx4oywtCRdngdKNjbDKS67EY5pZUDaWZHdOVZv1
	VmwwSrCB4cAz7z623z/oLiEqa/B49N527SNzOBE=
X-Google-Smtp-Source: AGHT+IFQxt9DjAz3PuTJOzP37qZCrjlZoiI3ahL6rmQkn9mzjC2m6t+oDSLlRkRDxhfY5qDzbOe3+TrF2fuOf95SsfY=
X-Received: by 2002:a17:906:c016:b0:a1d:ffaa:cf62 with SMTP id
 e22-20020a170906c01600b00a1dffaacf62mr971642ejz.0.1701885579968; Wed, 06 Dec
 2023 09:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204233931.49758-1-andrii@kernel.org> <20231204233931.49758-7-andrii@kernel.org>
 <97485a47e88f868da1ad6e42a3b19ad7216391e8.camel@gmail.com>
In-Reply-To: <97485a47e88f868da1ad6e42a3b19ad7216391e8.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Dec 2023 09:59:26 -0800
Message-ID: <CAEf4Bza0oz_qBXO6Xdh5KYAQsLYgCmvPhXeBUxFQOrFGAEudkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/13] bpf: remove unnecessary and (mostly)
 ignored BTF check for main program
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 3:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2023-12-04 at 15:39 -0800, Andrii Nakryiko wrote:
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 16d5550eda4d..642260d277ce 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -19899,18 +19899,6 @@ static int do_check_common(struct bpf_verifier=
_env *env, int subprog)
> >               /* 1st arg to a function */
> >               regs[BPF_REG_1].type =3D PTR_TO_CTX;
> >               mark_reg_known_zero(env, regs, BPF_REG_1);
> > -             ret =3D btf_check_subprog_arg_match(env, subprog, regs);
>
> Not sure if this is important or not. btf_check_subprog_arg_match()
> might have set 'func_info_aux[subprog].unreliable =3D true'.
> bpf_check_attach_target() checks this flag for subprograms that are
> being replaced, and seem to be ok accepting 'subprog =3D=3D 0'.
> This change makes it so .unreliable is never set for 'subprog =3D=3D 0'.
>

True, I missed this corner case. But I'm now wondering if it is
actually better to have a dedicated check just for entry program which
explicitly checks that we have one argument and it's a PTR_TO_CTX
(taking into account tags as well). btf_check_subprog_arg_match()
business is way too indirect and subtle, IMO.

I'll think a bit more and see what's the best way forward, thanks for
spotting this!

> [...]
>
>

