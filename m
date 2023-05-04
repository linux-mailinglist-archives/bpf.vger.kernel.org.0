Return-Path: <bpf+bounces-34-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D2C6F7849
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 23:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE8D280F60
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 21:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD55CC148;
	Thu,  4 May 2023 21:39:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8E7C
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 21:39:58 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375A311D93
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 14:39:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc1612940so2040600a12.2
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 14:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683236395; x=1685828395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nE8MUOcNkGOxerHXAUKbnUW5ilLlY81MwLCs0ENA/8E=;
        b=i/uGfH9XRIiSjxIZBotXVe0fcvU+kxWHNZ7B9LED22yXjyeNqa7Ju1SCMGKainDibA
         AT5l7L5D2ewR7pDjkDA8XDI6xLZ1lqQl7Y2aIK8FyF0ce7IudZY2HANsb3GuH0sq/is4
         4llEHAVOV4/jeOS1fiVEfnD9tVHNzVtOFLUsOFf8UItat7Yz0yO3rsEm8qREbKuRCnqt
         JP41fKtT1MLx/JU0yaxIZqQZB5+Bcp1VCMK4N2C7uTORaVCKXk3w23GcTuq2P9mvG1pZ
         Iyzp5w1VVq8ju7LiSKYkXtnzdKfyhvxODq1NR2TCPx/1sPOGrQ0UOrUuBCr1y29Nk+0Z
         dOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683236395; x=1685828395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nE8MUOcNkGOxerHXAUKbnUW5ilLlY81MwLCs0ENA/8E=;
        b=Gz4folQT7BnsdYMAabkv8Thr05Zr8HdHwzYr3gN2JG+LNYQPQhT9OAdIlUlmNkaD74
         QKphImkFQGSVwEaypsEklpgvy5GlUyo9pFRQVX47eLrFphe9hBAxm1Tz8X0ybwOvbPhH
         6NKmmOY6G1d+wRk6guIFLxa+GMrk533qrPL22iJPVE00bLHlgd5DwjaWhdQlOA90GyYi
         nEc2YQZcsHqISZLmQP5gWzv03vzumJwwM+xBi4cTCqL+0gQQXXlwIeiCWAB4G5byb3xi
         VmDelp63PJqf7cIoGmShW24Q3F+DpgG7uGlNjaKloTICE3E8pHDoNzTWKyfScuoUNHWF
         rBPg==
X-Gm-Message-State: AC+VfDzv8VA4VUm/Ues0hiotlXf3aVa8d+9Fb4evIsZTMkyXwdY1zF32
	4JeJr/wt90Jb7Sr1R5u/ogYLRC88b26W5OQHO5c=
X-Google-Smtp-Source: ACHHUZ5OvUkWCO6QWw73t7vzMGNLFhl7BttyYgnfFMOBbqAhqP+ONnMzRRPsGJe7xAlQC2HPPBn3F3m97e2SbF3AM8Q=
X-Received: by 2002:a17:906:fe4b:b0:94e:ffab:296a with SMTP id
 wz11-20020a170906fe4b00b0094effab296amr170802ejb.73.1683236395544; Thu, 04
 May 2023 14:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230425234911.2113352-1-andrii@kernel.org> <20230425234911.2113352-7-andrii@kernel.org>
 <20230504160438.l7kkq6eexeudchrk@MacBook-Pro-6.local> <CAADnVQJz17WZ_z7VxJE=w89ad0LBuxu_72Xz4WZZnHoTx0V7PA@mail.gmail.com>
In-Reply-To: <CAADnVQJz17WZ_z7VxJE=w89ad0LBuxu_72Xz4WZZnHoTx0V7PA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 May 2023 14:39:43 -0700
Message-ID: <CAEf4Bzbbg0PwLzQ=k25j=XaFmQ7X72=OxNBG0rDtvr9OnKSB0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/10] bpf: fix propagate_precision() logic for
 inner frames
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Thu, May 4, 2023 at 9:28=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 4, 2023 at 9:04=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Apr 25, 2023 at 04:49:07PM -0700, Andrii Nakryiko wrote:
> > > +
> > > +     err =3D mark_chain_precision_batch(env, old->curframe);
> >
> > I think I'm sort-of starting to get it, but
> > above should be env->cur_state->curframe instead of old->curframe, no?
> > mark_chain_precision_batch will be using branch history of current fram=
e.
> > __mark_chain_precision() always operates on
> >   struct bpf_verifier_state *st =3D env->cur_state;
>
> wait. patch 5 made __mark_chain_precision() to ignore 'frame' argument.
> Why did you keep it in mark_chain_precision_batch() and pass it here?

Ok, few things here.

1. We don't ignore frame, bt_init(bt, frame) is what sets that for
backtrack_state. Currently we get it as input argument, but see below,
we can get it from the current state now.

2. old->curframe and cur_state->curframe should be the same because
two states are equivalent. I chose to pass old->curframe because
that's what existing for loop was using for iteration.

But you are right, it's a missed opportunity to simplify.
__mark_chain_precision() always works with env->cur_state and should
always start from its deepest frame, so I'll drop the frame argument
from __mark_chain_precision() completely and will be getting it from
cur_state. Good observation!

