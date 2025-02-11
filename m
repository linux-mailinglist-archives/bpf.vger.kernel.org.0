Return-Path: <bpf+bounces-51182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BFEA316F3
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 21:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1642C1689D5
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 20:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B802D2641D7;
	Tue, 11 Feb 2025 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEstQYjH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A9262D28
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307346; cv=none; b=MbqyEKB2ZnfszS4+kbeLygBqEXKbo6/t/oFO5Q30/iNyigs611t2JxP9GKeMO4YaEDoPhhGm8iAWObC9ncsIznIVboRbgLfaVgq376Z9uQ1GrVif0bau3+3Tu8NKvqTJW1BOXvOVn5DsyaKiEsIYfkG40vRDtjClw1EBassSV8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307346; c=relaxed/simple;
	bh=QtDajoqY3IPudLjurAW/qcLgoIHW05gg+wzh6jqtToA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1s8XCPH1iv+1RN+4Offd6crvENea0YJSA1sIUX+2Fff+HnsFjVOs6rXpT9r1q5whVnGlqiFEXZUNH2vtBGO1e+vNjKVZ8yiWBhzjaHiPh+Pe+tYFvqirBut+/E0Ux2Y3cWt3VdRZFUgeW/KN6CF97zmg1R3y66sQjpFH4/Zz3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEstQYjH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f61b01630so2335285ad.1
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 12:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739307344; x=1739912144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7ceISHStURXddwiUIOlDJumhhBpIMHuYRxIMGUX8IQ=;
        b=ZEstQYjHB24Wr6ueAtQRI8933UehckLsLYRxB03Gpk0WiqKX8dQwYbzF5uV2N08i0j
         hr1bJnQTy8r4jxvtXqsIIiwMaNJK15W8RNTl6e/QgUtE+7pOfFXD32hCBz5uBLM5tovN
         3hWEp/BfYyhhmO2SKAlDeZvzhxvq5Mvy7uF9BvJ0UTj1dl7NEQ4hvRWFX6vVq/P+AMEu
         1a7hv0/A2hNwuOUYc2+XInkzXS1GqkG88SkcdDnq2NsIRYA0EkvNcBiLJomIdfsqQkcJ
         qFz48u04z9Hcu/cnCNhFEHB2qPFNNYhjt4/he1xvEH53j5oD9iTVnK26IjphTX687iQL
         cA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739307344; x=1739912144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7ceISHStURXddwiUIOlDJumhhBpIMHuYRxIMGUX8IQ=;
        b=IdJaPkStwTjGYT2snzSdZJPc38tN2bGHLRWYoxXdCG4mIX8dYGEZlzrq1oGGHXbUd9
         h3TBmcztvnCjP0zIyfc1SS4k1nOYD7BSowHXJ9PF540VFWiIrwM8Meo3QrnRVzd3ZiAh
         OgTn4+5P2QIOLxlZNMJ2pV58OmVivE5H9liV3Xkytak0yzioSRe+gQPtErZn2wB/6ZT9
         2oGOUmRD+NmjzRqiIGzNq8KIPlznN7F1NK2U2wTB5eofL5PP+PeOK803SF63YBQeM9fm
         TGCM4+3sdaD5oi+ust7ePu0/0H3dKyXR5k2zllzbtjB0eHAzY5TCgPSvTixo0a/gZPub
         FPIg==
X-Forwarded-Encrypted: i=1; AJvYcCXRmQDdFkAPr7saxPkUR1tXzleFb87lUBO8X6jK6xPFUcMeRr1/ojs7VmWZPwe/uW+644Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2As3/LWIqE8sT8sEvO15GGZCXoAThge4StzmL/OTzsFMfPtti
	MGTqcpg9ZV+pOXOT5qEuW0Si+ouYrMopfU4EETL38J/lHGn5KOzWSrtZr1Bt/3fFKyZvlfMT2xR
	NvleWcA+cFTWXBjZrS8ncQ/Mc7e8=
X-Gm-Gg: ASbGnctF2ReNmJROF5T+O/gwPEmrLA054nV34ZNI9Sq5X5DNaAqN79DPXcx/cbuKMCS
	CK0bERWdWtydKOLcpLP7SIJEnysUauq82dj7pXXivA8Bne9XBy+FSsJCrr+YOvT+OcqfxyjdlIX
	6fo1EH3MhI2piR
X-Google-Smtp-Source: AGHT+IFIJ6UOOoQ4H9wQohYr92BzqXhyHQtyLJ4/chGXLGOsmHgT2hQmtpf9hORZyPjZrG0d+KRSAeCy0nJ+l14RrF4=
X-Received: by 2002:a05:6a00:368f:b0:728:f21b:ce4c with SMTP id
 d2e1a72fcca58-7322bf28d3bmr986176b3a.5.1739307343897; Tue, 11 Feb 2025
 12:55:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210135129.719119-1-mykyta.yatsenko5@gmail.com>
 <20250210135129.719119-2-mykyta.yatsenko5@gmail.com> <CAEf4BzYVWSogUYk8pEPGs0N4eNb5fcXtmFMLkicokmqHPpbZCg@mail.gmail.com>
 <fba26c0939c3de14527774cd3d466b2f7ca33192.camel@gmail.com>
In-Reply-To: <fba26c0939c3de14527774cd3d466b2f7ca33192.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Feb 2025 12:55:32 -0800
X-Gm-Features: AWEUYZnXjml5DgptLYLX1tWpMM0gKcDx4miC18fruCBOyEq7o5nRKBP1YzPFF0c
Message-ID: <CAEf4BzY2CR1GO=23L7h+cTfzGyVNCp6r6iU7kU4QeJDRu0qxCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: implement setting global
 variables in veristat
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 5:44=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-02-10 at 17:13 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > > @@ -1334,17 +1634,6 @@ static int process_obj(const char *filename)
> > >
> > >         env.files_processed++;
> > >
> > > -       bpf_object__for_each_program(prog, obj) {
> > > -               prog_cnt++;
> > > -       }
> > > -
> > > -       if (prog_cnt =3D=3D 1) {
> > > -               prog =3D bpf_object__next_program(obj, NULL);
> > > -               bpf_program__set_autoload(prog, true);
> > > -               process_prog(filename, obj, prog);
> > > -               goto cleanup;
> > > -       }
> > > -
> >
> > I think this was an optimization to avoid a heavy-weight ELF parsing
> > twice, why would we want to remove it?..
> >
> > pw-bot: cr
>
> The v1 of this patch missed the case that globals have to be set in
> both cases, when prog_cnt =3D=3D 1 and prog_cnt !=3D 1. I remember making
> same mistake when debugging something unrelated. Hence I suggested
> removing this special case.
>

Yeah, it's a bit of a gotcha for sure, but especially for something
big like pyperf600 it does make a difference... I have a plan in mind
to speed this up with a bit more work on libbpf-side APIs
(bpf_object__prepare() API I mentioned in another thread a few days
ago), so we'll be able to get rid of this.

> > >         bpf_object__for_each_program(prog, obj) {
> > >                 const char *prog_name =3D bpf_program__name(prog);
> > >
>

