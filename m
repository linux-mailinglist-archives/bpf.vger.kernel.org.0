Return-Path: <bpf+bounces-15207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 239837EE797
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 20:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0602817CA
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 19:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE84482F1;
	Thu, 16 Nov 2023 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/K6oMBo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A66818D
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:37:54 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40859c466efso9145785e9.3
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700163472; x=1700768272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBsjS7KCvlfyiv3EWfyxDWNuEw7S7dO6CkvZtHBeiiw=;
        b=l/K6oMBo4rtuZ93dDiNzW0q6FvYqnd8KNvualHcajhU3TMrpF+YZYjYePRi19akFui
         PQvHSQ7xcXVU9pc4W2/ywYJ3uL7a81iNAsvWTE9RRDV3P6SgO7hLplM1PFBG+OBArf13
         cZJZbz2I7vqLCZ0SHYC0DonsEF+dUM6ZknHb7S0uQXKDRZBXoHqvbxY2CPOwJmT4aARU
         1Js2qnx4SZ8sClD3avd/CnUgnQEGE2j9liYIZmrtVDC/CuOIZJIvzXFKx5eVlzS1EPyB
         OO725g4iFxHdAphArd3MAypcgOZ412aNX0Zrh+9j1+YUYJzdaDdFkHrR8alqsfLaOFcM
         vmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163472; x=1700768272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBsjS7KCvlfyiv3EWfyxDWNuEw7S7dO6CkvZtHBeiiw=;
        b=Xd5/jxyV/9wFJWJy2qAyYT9k1+DYrx9ZUoDoPepddXMh7KJJIIJVR+pOMfW0fQOJKy
         6jugVumrJixbvHP/b+OpEhIeijwGkWpK43FLbthIQ3/qeQo+2bstqDKb+QB4uL5W9DC4
         n194JMBh9E84knaVdLgnpbqa2tlWtvgtJretO8uJ0NV7d0VpJF1XlqFqVP0Yq4fCF+bZ
         7LlsTW2CQADjQKxbMKisqcbALxuAjjmEHWCDB7DDZieYP/ynYohbGEXmPjIRsliv9hNw
         Y/GqSyTF+hTJBHd1mD7GcCUkBW0u0Yyr5hQlnVlTT2oOGB69oefh2XcsEl7GE6cTZWt+
         KUGA==
X-Gm-Message-State: AOJu0YzNqV41+BQ1cPAiPlC4IibFxWESlKUcusz7zJT7POMUS9weICq0
	Zq0SngLVcvK7vPRH0aBiZ52RjgMRkg7Q9ueozEo=
X-Google-Smtp-Source: AGHT+IFi0Rt2jOCzvipl85uH3G9Zh7JldeMliryRDqjnN0MA66QajQobnkQDYYrRDa+l1hyKGcTqhgNryigQOFVwugo=
X-Received: by 2002:a5d:47c8:0:b0:321:7093:53f5 with SMTP id
 o8-20020a5d47c8000000b00321709353f5mr15200687wrc.64.1700163472338; Thu, 16
 Nov 2023 11:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112010609.848406-1-andrii@kernel.org> <20231112010609.848406-5-andrii@kernel.org>
 <CAADnVQJZr3Za=oM9VeTeY0BGL6rymSHSsKqEWVSJmkRhSvcsHA@mail.gmail.com> <CAEf4BzYCDGKnUd6zJJV-aetUhSq_+QsBFZ6bxS+vvaxvmUDZ6A@mail.gmail.com>
In-Reply-To: <CAEf4BzYCDGKnUd6zJJV-aetUhSq_+QsBFZ6bxS+vvaxvmUDZ6A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 16 Nov 2023 11:37:40 -0800
Message-ID: <CAADnVQ+aLnXNHD93cwfN-P83T_poDSy-xYRWaOq3dVfzCY6g0g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/13] bpf: add register bounds sanity checks
 and sanitization
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 2:07=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 15, 2023 at 3:25=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Nov 11, 2023 at 5:06=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >
> > >
> > > By default, sanity violation will trigger a warning in verifier log a=
nd
> > > resetting register bounds to "unbounded" ones. But to aid development
> > > and debugging, BPF_F_TEST_SANITY_STRICT flag is added, which will
> > > trigger hard failure of verification with -EFAULT on register bounds
> > > violations. This allows selftests to catch such issues. veristat will
> > > also gain a CLI option to enable this behavior.
> > ...
> > > +       bool test_sanity_strict;        /* fail verification on sanit=
y violations */
> > ...
> > > +/* The verifier internal test flag. Behavior is undefined */
> > > +#define BPF_F_TEST_SANITY_STRICT       (1U << 7)
> >
> > Applied, but please follow up with a rename.
> >
> > The name of the flag here in uapi and in the "veristat --test-sanity"
> > will be a subject of bad jokes.
> > The flag is asking the verifier to test its own sanity?
> > Can the verifier go insane?
> > Let's call it TEST_RANGE_ACCOUNTING or something.
> > I'm guessing you didn't qualify it with 'range' to reuse it
> > in the future for other 'sanity' checks?
> > We can add another flag later.
> > Like BPF_F_TEST_STATE_FREQ is pretty specific and it's a good thing.
> > I think being specific like BPF_F_TEST_RANGE_TRACKING or
> > RANGE_ACCOUNTING is better long term.
>
> Sure, I like BPF_F_TEST_RANGE_TRACKING_STRICT. Or you want to drop the
> _STRICT suffix? We can also do something like
> BPF_F_TEST_REG_INVARIANTS_STRICT or something to keep it a bit more
> generic?

Both names sound fine. I prefer without _strict mainly because
I'm confused by its meaning. With _strict it sounds like the verifier
already testing range tracking, but not strict enough.
Whereas without the flag there is no enforcement at all.

