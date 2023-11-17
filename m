Return-Path: <bpf+bounces-15240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1667EF684
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 17:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0799A1C20A9C
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C185D3DB9F;
	Fri, 17 Nov 2023 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMnSAc4L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC7C194
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:46:51 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9e62f903e88so289799466b.2
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700239610; x=1700844410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofo03zOEO5zgHFobAdeht2+tEzXz1QbKvwz6+uQe7Ic=;
        b=aMnSAc4LeoqaRtcDkjywQ48ln/+Mb99Q2We5Pg9p5LK5VqGvw2H+cCRcmLsvfJNfHj
         mAr0QiJB0csckdGubipYMbN/FIUEoytj1fJIfj0Bu0PSiwXmiSU5QiEwRi8OhdGQ9XwU
         XjDDo4YL4qo4hoUMc14a+rJdHsilNcMH3X7DH8/dgs+0Kri7EYCxEx7mkqc8ztZbyfee
         PQWRhnlnWvztr1LOncwSGV5m7CyTob+UlPHsv/dZTNqQy3IcnM+imGpl25TYvm9eJp0G
         +X51rvtHmDwvigGwZM5rQk0pDZBqAWFfsOvEZBAfoSrDwWL0O3rF22+bX+epGYI2BGQh
         eB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239610; x=1700844410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofo03zOEO5zgHFobAdeht2+tEzXz1QbKvwz6+uQe7Ic=;
        b=KL1ybzJlcPgumZxHXSEKV/aDJo5KLkxhgozdZe1REvg7/AR5ywV9pvJjVowlIrpzaN
         tBw3DczqR/+EwSVpFJFic/JF46JNE+LWKuLbk1xeyb8+jX553WlKTb+DTAKREBw91qXM
         gf+qsSGE35tnR78xwzIFKCPTys6Zxq14fVQKP9lARAnGj220UJ3pV3AER59+yHZAveBq
         c5vt1+hbbfUQwvyn9RkPvHhhROYEGB/WO4qRLHFomOJsBSck3hPkhS3W/G6JpbPxI3p8
         M7jvTfIqUvpK1ccDa/71ndR+zMjutSE/9aj2AlMOdR9JsDKi5hJLQLb2QLDJgdAJTnpd
         /rng==
X-Gm-Message-State: AOJu0YzQD1rLx45nI2YPq1Gc/KFbf3uSBOVgcZKQlWqaFc3rTfRVXxg5
	B2WCNI3INXEUMlYO70jOzQ3uKPotiVWnHRXvrCVOhZ7L
X-Google-Smtp-Source: AGHT+IFV0/orF4u+gON3vMpMCD/zZ3eNxcXTQMfTBw5zP7lsE4gIOPacf4tidlRDTCZ+FZRyRphSbMckKBLZo+e5frs=
X-Received: by 2002:a17:906:855:b0:9ae:82b4:e309 with SMTP id
 f21-20020a170906085500b009ae82b4e309mr14794827ejd.0.1700239609644; Fri, 17
 Nov 2023 08:46:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-3-eddyz87@gmail.com>
In-Reply-To: <20231116021803.9982-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 11:46:38 -0500
Message-ID: <CAEf4BzYCMWHsp1oxzGY7omzwvkaLVhA0NfxecAy4Gz=_tf__ng@mail.gmail.com>
Subject: Re: [PATCH bpf 02/12] selftests/bpf: track string payload offset as
 scalar in strobemeta
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> This change prepares strobemeta for update in callbakcs verification

typo: callbacks

> logic. To allow bpf_loop() verification converge when multiple
> callback itreations are considered:

typo: iterations

> - track offset inside strobemeta_payload->payload directly as scalar
>   value;
> - at each iteration make sure that remaining
>   strobemeta_payload->payload capacity is sufficient for execution of
>   read_{map,str}_var functions;
> - make sure that offset is tracked as unbound scalar between
>   iterations, otherwise verifier won't be able infer that bpf_loop
>   callback reaches identical states.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../testing/selftests/bpf/progs/strobemeta.h  | 78 ++++++++++++-------
>  1 file changed, 48 insertions(+), 30 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

