Return-Path: <bpf+bounces-44968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3539CF10E
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 17:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27CF292E5B
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 16:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5506B1D63DD;
	Fri, 15 Nov 2024 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esCQazO9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C1854769;
	Fri, 15 Nov 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686806; cv=none; b=bvX6iTepIg22KFRHqPA2HnZqbG2ftIY4HJx3sVtBSdLo+zMmU2pfxHHH7LoI6sR1aOmLLcWO+DwODvKTNf6+jpLlVMWR/C+V/YetBz30DDZQCLORTf+2XleByOJeb/gg9Xio5I1+O+fuJMr28VWJjRLiefIlMslsWVmsq1nOJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686806; c=relaxed/simple;
	bh=EsNqERJbfMO2VxTdlVjM+0sR+/5RK1oPK71ew8lDNWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+UOfbwhZUWvFPtLw0Sc3W9AjDfeCJauu+LOaC/Lep6IaY8Fx2iFaDn5927u/8Y72aHgilRVW4WYwZ1ohJPwhWLLu+fgPggSULJHKPKjeCXMoIzvRbAYZpL/44askG3kHhpqqktXs8fqBWb0IVC7RAGeMBLx7CpdPg3mtSRX+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esCQazO9; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2890f273296so959441fac.2;
        Fri, 15 Nov 2024 08:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731686804; x=1732291604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsNqERJbfMO2VxTdlVjM+0sR+/5RK1oPK71ew8lDNWI=;
        b=esCQazO9qBHeHClxLdSH4mSNux96LexlUo8Ux/2l5tuk0YVrBwIjiH29tu66Kdf59I
         uY6qvySgOG4F9c58pxwKz/2+23rZF70f/lFS5o/uv2ZNOW6vqPTTHpzP1QIsVVMtTBUV
         FCPw1btjZobDVjLLV/Z0hS3S74giqAu/Km2pBgmEokP/rsSSmLoUBos4J9jyaj0Hx+74
         l8eExohuUZpNUoqsAN7Dhdhxi1UE1WIfHdCL3WJD1fUFAfXF7BPU/Who6Akc5VtKE3yI
         dPxYQP1wVVCaIR7i+kRg5ZE54B+Q+QYm5Bt2C8t3+qT7fzAKTK0atWkZEm4O4Fw6/eGh
         tWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686804; x=1732291604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsNqERJbfMO2VxTdlVjM+0sR+/5RK1oPK71ew8lDNWI=;
        b=eAHS7hH40Rv/wFw4UmIxyz+DnezbtS9t36IzJArOb3zCza7otk9s3emgbA21nYsYbT
         oL9Y5SLlGAZtr04e3kZ/pz4j7sALOnPU0qLWZJNOTnBFMzK4gfVufOd8xh7uN08XI73b
         YMQ7S9vxjipw4P50lPayJltmQT8fL0He5+tXq6Szo5+2cVwvM882pwRWfDu3Bz6OZCus
         dTmQnjV0yC41FSuIbgjSerVcOIZwT8EXezYzoyFUqjOJJ/0Gtbsi21yB5l6eWjQB+FBh
         eaQwi8n2KBL0me9DHCGaED7mribcq9Y8UG7QeP0v4Cu0Gs2aeV2TPyVsbVuWJWy1FB44
         ytbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbkUj2XT2n36VkqL/P52oPPE6iWocifKuDuBDUZilypIWnfW7bdM0mT8l7uRtKtI03RQ0=@vger.kernel.org, AJvYcCW3eoYm4suAj+u2vSIgYzuOQXSBAfcVKX1sO9ZjAu2PjAAg22btMiijziLy0wRZIxWLcAus6NhA@vger.kernel.org
X-Gm-Message-State: AOJu0YxuqRkSkYvvjBoaNJbzhdsD6+lcKd2uSE2bPZonVW4KbxHdu0Bv
	hkBfSInEcfQcBG/G13iQnz+eVuNfo7/npZcSAcaQbNE57jj0hHa9qBh2g+MVQFsRVEkrfs6uDPI
	/8mEEAsUiYBkEf4/HWQaASu+PTxg=
X-Google-Smtp-Source: AGHT+IE7iPdHHG2+TXNIji3qpxgOZvPrKZ0z0tpBeB2Ajaqx6cf12RLlMbDwclOeuKC++7SBxrMateyDTLNwzzzRW8c=
X-Received: by 2002:a05:6870:d29d:b0:261:1f7d:cf70 with SMTP id
 586e51a60fabf-2962e2a0ce4mr2814256fac.36.1731686804318; Fri, 15 Nov 2024
 08:06:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114170721.3939099-1-ryantimwilson@gmail.com>
 <CAADnVQJ2V6JnDhvNuqRHEmBcK-6Aty9GRkdRCGEyxnWnRrAKcA@mail.gmail.com>
 <CA+Fy8Ub7b1SXByugjDo-D13H_12w0iWzQhO-rf=MMhSjby+maA@mail.gmail.com> <874j48rc13.fsf@toke.dk>
In-Reply-To: <874j48rc13.fsf@toke.dk>
From: Ryan Wilson <ryantimwilson@gmail.com>
Date: Fri, 15 Nov 2024 08:06:29 -0800
Message-ID: <CA+Fy8UaKWJ+8SoF_purtcOju-Xdt-m5qeUvg5keK3KGW9=ApQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, ryantimwilson@meta.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 3:07=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Hi Ryan
>
> I'll take a more detailed look at your patch later, but wanted to add
> a few smallish comment now, see below:
>
>
> Ryan Wilson <ryantimwilson@gmail.com> writes:
> > On Thu, Nov 14, 2024 at 4:52=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Thu, Nov 14, 2024 at 9:07=E2=80=AFAM Ryan Wilson <ryantimwilson@gma=
il.com> wrote:
> >> >
> >> > Currently, network devices only support a single XDP program. Howeve=
r,
> >> > there are use cases for multiple XDP programs per device. For exampl=
e,
> >> > at Meta, we have XDP programs for firewalls, DDOS and logging that m=
ust
> >> > all run in a specific order. To work around the lack of multi-progra=
m
> >> > support, a single daemon loads all programs and uses bpf_tail_call()
> >> > in a loop to jump to each program contained in a BPF map.
> >>
> >> The support for multiple XDP progs per netdev is long overdue.
> >> Thank you for working on this!
>
> +1 on this!
>
>
> [...]
>
> > Note for real drivers, we do not hit this code. This is how it works
> > for real drivers:
> > - When installing a BPF program on a driver, we call the driver's
> > ndo_bpf() callback function with command =3D XDP_QUERY_MPROG_SUPPORT. I=
f
> > this returns 0, then mprog is supported. Otherwise, mprog is not
> > supported.
>
> We already have feature flags for XDP, so why not just make mprog
> support a feature flag instead of the query thing? It probably should be
> anyway, so it can also be reported to userspace.

Oh wow can't believe I missed the feature flag API. Yes, I'll use this
in v2 instead. Thanks for the suggestion!

And if it's exposed to userspace, users no longer need to guess if
their driver supports mprog or not - although hopefully this is an
intermediary state and the mprog migration for all drivers will be
relatively quick and painless.

>
> >> I think it will remove this branch and XDP performance will remain
> >> the same ?
> >> Benchmarking on real NIC matters, of course.
> >
> > Good point. I will migrate a real driver and add XDP benchmarking
> > numbers to v2.
>
> Yes, please, looking forward to seeing benchmark numbers!
>
> -Toke
>

