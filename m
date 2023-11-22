Return-Path: <bpf+bounces-15678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0DC7F4EA1
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 18:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F5E2813B9
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 17:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0425788B;
	Wed, 22 Nov 2023 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOfJTyBJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1C6BC
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 09:46:47 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c8769edd9fso757291fa.0
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 09:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700675206; x=1701280006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtpVViMgF2GbPpkDYmrFz/mZu4iLwZlMpIVwzkMUSDE=;
        b=KOfJTyBJt12b2YSzVZdGs0OAb0e9d5gsMK8yEdx+Dcc7+rCk/GLrU5KJz/94mlpa0y
         OIj4mNEDP6PQn23x1IVFmcc2LbvgOMcslXfuOfYlxDas8gVgApPXm0bPfAf9lU66ihIk
         3Z50+f8h1viV4qaaOxCITVTKbx+LlYnOat1L13tLspfX3aFm4e/uAiO30BSAWckrTuzI
         xuP+GS1X9r0wEcuQYl5+6lez43BR9atLgq2unlVREDhd/7tKo4O9BHBYlRU9Yd+mQXTr
         XZrHjKvMe9AYi0raarLEJTJssTDhLvb1tSAphgNIzThI/byxLozIkBz9iIvfF1Q5mgeH
         gr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700675206; x=1701280006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtpVViMgF2GbPpkDYmrFz/mZu4iLwZlMpIVwzkMUSDE=;
        b=PN934w//OY1hCDqG4bebrtoUyrQcF258Yf1m5hEjcXh6CWK5cc/+/Dw2c3Y1fi6y1n
         C2MTJN4942dAw8UgdkzQogh8h/x5+GZUifmF80y7M9ozGO+jeVXs9N/UyzZAoDdQZ2Dx
         moNp04cCuS+YaFZJ0/Vl3YCi33RH9kapFaBnLNFUO+Zbr1ZY9YfjrJ2aQ14M0LUNQe68
         jnzoG0vpZ8oWb7RWgWbqT6ZGxtmo4sB02UI9/MC3n6RZz5bnkZA4BYi2nWll0pDaZjfX
         RmMhVfrLAWc0rzML2GIKpBuoV+THGOPQ2jJS+yQa6vAc5cXg5/gFbkgQI8atMmGWHbQm
         sFZw==
X-Gm-Message-State: AOJu0Yw51CmPswiBLKZuwUKE95cY1VEbAa2VOp0wGLUne4hgJo/2iiSE
	JNLWUFKiuj8XpI/2+AIaezZxe3J0gGKrCkNzEwpEBTCD
X-Google-Smtp-Source: AGHT+IHlToWimUVJgEabQdX3mbLhh/P8Lj8rz67gz8B0cFx/rCdC0Vy6pmmscNRIg4CbWTuYfatGrhEX0AxNaY9c230=
X-Received: by 2002:a2e:8709:0:b0:2c6:e46e:9849 with SMTP id
 m9-20020a2e8709000000b002c6e46e9849mr2231457lji.15.1700675205531; Wed, 22 Nov
 2023 09:46:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122011656.1105943-1-andrii@kernel.org> <20231122011656.1105943-6-andrii@kernel.org>
 <4b12e29372014a46a399ee26870c306fa492319d.camel@gmail.com>
In-Reply-To: <4b12e29372014a46a399ee26870c306fa492319d.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 22 Nov 2023 09:46:34 -0800
Message-ID: <CAEf4BzbTCMAHYmsr4kKiyyxL63DhNZZQhp9RCAkxARG9T_6B1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/10] selftests/bpf: add selftest validating
 callback result is enforced
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 7:13=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-11-21 at 17:16 -0800, Andrii Nakryiko wrote:
> > BPF verifier expects callback subprogs to return values from specified
> > range (typically [0, 1]). This requires that r0 at exit is both precise
> > (because we rely on specific value range) and is marked as read
> > (otherwise state comparison will ignore such register as unimportant).
> >
> > Add a simple test that validates that all these conditions are enforced=
.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > +SEC("?raw_tp")
> > +__failure __log_level(2)
> > +__flag(BPF_F_TEST_STATE_FREQ)
>
> Nit: although it is redundant, but maybe also check precision log to
>      check that r0 is indeed marked precise?
>

sure, I'll add another expected msg, no problem

> > +__msg("from 10 to 12: frame1: R0=3Dscalar(umin=3D1001) R10=3Dfp0 cb")
> > +__msg("At callback return the register R0 has unknown scalar value sho=
uld have been in (0x0; 0x1)")
> > +__naked int callback_precise_return_fail(void)
>
> [...]
>
>

