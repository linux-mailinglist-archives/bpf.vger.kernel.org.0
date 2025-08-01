Return-Path: <bpf+bounces-64934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E11B188EA
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 23:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75BE62675E
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 21:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2301C21D018;
	Fri,  1 Aug 2025 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdDeQEjv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0B13A258;
	Fri,  1 Aug 2025 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084848; cv=none; b=obtrtocqN+5Wj62U7zX+Ad0P3fZByXPs5LjSH5h9DUsWhzcUlevw+WyFsS0eKxJi0l+ij+PcrhONP3WuaSASa4AGu011i1HSfVl8LEyZRyN3lnLofcxr/5OpPOXbAaoA2GTxAqiGo0o5QPZOUkHDCUSGE54lArQWDtKPAQaRnxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084848; c=relaxed/simple;
	bh=pmOc1yInp0jm2HP9w+y0SBHassLPgJmw/K9AK0ri7ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhIsy6+hg2HZ305wUmUJgbcqOKXMMNBMZ7c6hdtsA5Gd+0bMUJKP2Fx0ZtJAqtWlHkQ/YNvLY/fg3oSSfjFRMIu1+vfDieZUdjGcuVfSjnlILV3M2EBTOHozKVTE6dSmCOc1tTg4VMYK8YPmIN6c/edl2LZPr+uudUDw655J2xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdDeQEjv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-458b2d9dba5so4423845e9.1;
        Fri, 01 Aug 2025 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754084845; x=1754689645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fymPpsTAHfMDVeGAPx75xE0iUDtgGjWaOMrbMCNqck=;
        b=NdDeQEjv5MsDx3cUfBD9jn/bZenP9PETpT2efdAWHvsaUgNjXajYGDh7u+uctIl2fI
         NhQUvd3VBnGct9LlTDi4gSWx+uJPtybeb/epqsvtJx2p9EbbXx8vPYrq1EwaHhbx0cAK
         2MSguMIfoHPt4I4U02GSJr7u/b3ob5oraP5qosbu5jDwzGnv3B6YAjoKDPjSeKQ5XkG4
         dfJcTdNyC5hEgfJajwFqTl2cB5ex/nFFPpqxd/x8Er3Nizajyk/L9PJ75Pns1p16eIKY
         vrpXBQ5+NN5jrnDNB0YdysBB+Yq2eEn3jeD6iH9lSX5+/tdQdwGcRvCnOhGaKyDoxjbV
         owlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754084845; x=1754689645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fymPpsTAHfMDVeGAPx75xE0iUDtgGjWaOMrbMCNqck=;
        b=VzGe6XcRA18zq3EmCqpQTIFHc8Q9WhNcmUerGVQIw5Ob7TvDTB9hwCBs7/iK8lEBHm
         uuiVnQUq8wdSjTneqwzk0xSnQbI8XJtAzFgKtBovD0qX3A9zQrDBXwMUtVFlqJhAzMEq
         TPecFLMG084km0hZ39bOaHk8m2O3GqhNZWH6z2CU87wHWywb9Aaj45mxcnGDucrFurG5
         fk3bQKRcr2BC8dWpw0Fq4MshmwfHKwl8HJDV4tBFlDnP6zl12z/fBNQHHK7IoZD9ozZj
         B21hnrSHXJkTAS0gcLmg0LuvuYg82EE/lgwdn0bRIjbcsOI2L9PtnTrKElEeQks99JlB
         TvxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1/Oe5m3ut9iEwd65SfbFYAX7Fb8e7ksBg57jNamufySnLfJFvQA4SWAK9tNISzdpmhuk=@vger.kernel.org, AJvYcCUPMAluYiGbgQb6wQOQOzK5XhSvoBHKkxfkspjH7vxn4cWdL9aB4OcBBXmBINx49SLpEKxYUofjk45FwT+94Jd4@vger.kernel.org
X-Gm-Message-State: AOJu0YwVbEVgFzLxYXEiwfKJhYv64PEiDKk6nWNM3m7xo0WMrma60GsO
	N4RKCS+9iV1qqwyhimgl0CUAct78JU54ucCf5tVitBYqs9GAbke15u/W+/PLjyTjTZwhfEonplR
	jzO7VMk7MsYgvcPSCJSXjU4hhBX/wNjY=
X-Gm-Gg: ASbGncsBANSMbaBbmGuP7bCNrX8tBoV7XXaheo822JVJplFg0eCZUSsfXietlPiLwxO
	vfMQHLLyidiAbOG5wEyH+qs1iHxyptBS043O8g79gLv4dZVB8FYOIsRORWaYnuV7rMnUnUCvgTh
	TP9iW8prZfUIeE95VN0b5JU1nWWFbQzP0tVA5DvmrqCl2mba1POzHSiumCudD5sopFGgelYp01L
	9kfbt3JA8dqsqWFe+CvjIIw7ZQVGDufAn4y
X-Google-Smtp-Source: AGHT+IHJt34X29vm3794p+/SnmXZWtqLJ5wzSOPvB9+n9SqL2HGyn1GafZrqVRG9mwIQa6eTfNVCtSdw8IrttKivYlM=
X-Received: by 2002:a05:600c:4f56:b0:455:ed0f:e8ec with SMTP id
 5b1f17b1804b1-458b69ddf95mr6158685e9.9.1754084845053; Fri, 01 Aug 2025
 14:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
 <cc94316c30dd76fae4a75a664b61a2dbfe68e205.1754039605.git.paul.chaignon@gmail.com>
 <91bb735f-088e-4346-9b2c-874caf0bc1ce@linux.dev>
In-Reply-To: <91bb735f-088e-4346-9b2c-874caf0bc1ce@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Aug 2025 14:47:13 -0700
X-Gm-Features: Ac12FXxWkb_i8xQSI73hOIoX5bDpoeOewA0sUo20X1DZe9tuYo_5vYbdoIUSm6Y
Message-ID: <CAADnVQL-YTbqG1xrdbFBEqsoJWcCKGFnx0sCNSkKJKb9shnXEA@mail.gmail.com>
Subject: Re: [PATCH bpf 3/4] bpf: Improve ctx access verifier error message
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, netfilter-devel <netfilter-devel@vger.kernel.org>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Petar Penkov <ppenkov@google.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 9:31=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 8/1/25 2:49 AM, Paul Chaignon wrote:
> > We've already had two "error during ctx access conversion" warnings
> > triggered by syzkaller. Let's improve the error message by dumping the
> > cnt variable so that we can more easily differentiate between the
> > different error cases.
> >
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> >   kernel/bpf/verifier.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 399f03e62508..0806295945e4 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -21445,7 +21445,7 @@ static int convert_ctx_accesses(struct bpf_veri=
fier_env *env)
> >                                        &target_size);
> >               if (cnt =3D=3D 0 || cnt >=3D INSN_BUF_SIZE ||
> >                   (ctx_field_size && !target_size)) {
> > -                     verifier_bug(env, "error during ctx access conver=
sion");
> > +                     verifier_bug(env, "error during ctx access conver=
sion (%d)", cnt);
>
> For the above, users still will not know what '(%d)' mean. So if we want =
to

Right, but such verifier_bug reports are mainly for developers,
and we will know what it's about especially after redundant (1) is fixed.

> provide better verification measure, we should do
>         if (cnt =3D=3D 0 || cnt >=3D INSN_BUF_SIZE) {
>                 verifier_bug(env, "error during ctx access conversion (in=
sn cnt %d)", cnt);
>                 return -EFAULT;
>         } else if (ctx_field_size && !target_size) {
>                 verifier_bug(env, "error during ctx access conversion (ct=
x_field_size %d, target_size 0)", ctx_field_size);
>                 return -EFAULT;
>         }

It's nicer, but overkill. As Paul explained if cnt > 0 && < INSN_BUF_SIZE
it must be ctx_field_size/tager_size issue that
needs debugging anyway with a proper reproducer.
So making this particular debug output prettier won't help
analysis much.

>
> Another thing. The current log message is:
>         verifier bug: error during ctx access conversion (0)(1)
>
> The '(0)' corresponds to insn cnt. The same one is due to the following:

...

> Based on the above, the error message '(1)' is always there, esp. for ver=
ifier_bug(...) case?

Yeah. That's an issue with verifier_bug() indeed.
Let's fix it separately.

