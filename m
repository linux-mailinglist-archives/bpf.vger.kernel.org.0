Return-Path: <bpf+bounces-66634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA844B379FC
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 07:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E941B28020
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 05:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A55A2DE1F0;
	Wed, 27 Aug 2025 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRSYhZpX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7451A28E7;
	Wed, 27 Aug 2025 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756273683; cv=none; b=EDuwdUafvlcAIYQjLAhHh28wHu6Zcl9sElfttdtWNox+th7A+vJVpUIGdSHnHC5Kx6tufagkt4zx3IS4FkoguM0/5DYOSSKjRQvuPRDoGMNp/Kp3+gbGtEFOIU3X/nBcYuGMKOrqgPcPL8zv9io09qPxYrT0tgNMA/Xe3bqfCO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756273683; c=relaxed/simple;
	bh=GzmKTtGKIfZZGH6TH/jszUd0cGgbKaGK8YsA1hHZb1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAlTFfJAVmwTAlQ75xizXM1WsEASJDuWDNzoBTvruzDKEW3bGJ2YYR0g8LChtxZgo33WSjbaxgutDGblOaa5JR7dZyCMK7UxpgjCPGO2nAiHRz0rMYIQMOxozoyKreIXE6ETL8Io2OHfvmaP+1MNIo1Yht3iW+GH6zE590aufnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRSYhZpX; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-71d608e34b4so51391727b3.3;
        Tue, 26 Aug 2025 22:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756273681; x=1756878481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7uF9JtjJ8XNaR2fn4Yge/aYYLRZsT+czQkmcDUbcNQ=;
        b=KRSYhZpXQ2Zpz3p4p+r/1hhQT/zHQmMfOnmCCgWzlQD9/QMm3CyscEFFNKlcInw/cH
         RmfJ4ZIrJL1nZoplLuB37JQ3Xsu1M+vl+81YUlm6FDpgolPHuk8KeDEW53WVedlJx+6k
         JKFmVb8klGB3KuwyS5gRLr+3KXw1xhEcrYDJ1qSRLb3xORMfvd0CJ3thbBdkqeVAd9XC
         d0RXSBjaBUcreH+neiP6vwOX9gAID901NTAvpk6K4VONd/9fCu4DikN+wTT07DH0ZgsF
         N2VUsmgjfl6aThG48MSvm6NWu0+4qKmfzy5c0me4pFXWRQi7CM8n/lMcH4mRC1O316RE
         GYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756273681; x=1756878481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7uF9JtjJ8XNaR2fn4Yge/aYYLRZsT+czQkmcDUbcNQ=;
        b=htv7EIZPW7khtnU4aIJLIZ6uXR3lXLY/wj5tibrdrQoGfiY2VZVmOFzmBxQQ2ljmqt
         OJW+Dd1HDnwXJz0Adko/vIG0la7j2xRUC86n4wX5WHPTS+ljr8Gn+2ePwlDeMKdEqijH
         O2Sqs8yV3fficECdZIOxUefYpRYGnPJCOphqGORcb1eiMioCDxjT+nc1EABcJOBZZniQ
         c5qvBsRyPVBO40ZBe2EW7a9i25X3p41kWnR26SHN6pN0i8PH6+P7UdwQXWdhu4wUBeEn
         kUyCFc6bg/0FRqV48yHEyFIIMSQaFwcOy4JfDaGd9ZKs2Ivj0qC4cmkSBppNLdAjvYjd
         6wPA==
X-Forwarded-Encrypted: i=1; AJvYcCX3rPHO+o/oqOk+VqArDR0GIN7h08BS+8VzYn8tDaoxIfsRDPS/2g4B3rZnM88LqzmK87k=@vger.kernel.org, AJvYcCXSjpwP1gaukqN/1dCkhkds/hAxUCaO0Tv+gmgOujfGlQnkXimS5aGFiSjNCnkj6AVsOyhCXeCOlypoiaou@vger.kernel.org
X-Gm-Message-State: AOJu0YxEtOXRNwt61dhWo87Xkf1p1T09d68EbSea4u+CZoF5zM874XVq
	ZVJcN5C5OKuMZ373jCkUjRDViN7+hjxbYPClONdo9v2sqHH4DEMcJId5aJlEoZs+oGma2r4YP/O
	eRojiL7sIdfnxJcUSn9+iu7N9RCTbZdU=
X-Gm-Gg: ASbGncvjQrjsj+fDMxA1DTAJyt3IzYpFczUb8WIim+COvXOwZSzxWkmShTDzHLX0ZB+
	ooYG2IOmeJ6A0Wy4u3RBemCWbE0ujrjOV8sWUJuYxsEse6RjZ1epa7qw9ErKERir+/E+GRHbaPq
	mNbXCWfaMzecmzyFjF8ZrmezIdXWEK3jPTxDU+S5TBd0ZBZjzfgcRcCDQt4/M+gxnk6syrel83R
	Y4QjeK8MdQ=
X-Google-Smtp-Source: AGHT+IF3YgGlv+JZQTO4rCIuMzkeGcZaTmy3/9WsREKziOK+3nyZ10vYsWXPK7HfkDQovlrEmkU9ODB2ujG6k0QqkxQ=
X-Received: by 2002:a05:690c:680c:b0:6ef:5097:5daa with SMTP id
 00721157ae682-71fdc3e0647mr184242747b3.34.1756273681346; Tue, 26 Aug 2025
 22:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821093807.49750-1-dongml2@chinatelecom.cn>
 <20250821093807.49750-3-dongml2@chinatelecom.cn> <CAADnVQL0oWnQM2AJh=yzNtRmH2Mx=B-hM2xsvgEx2uqLEBQ5Dw@mail.gmail.com>
In-Reply-To: <CAADnVQL0oWnQM2AJh=yzNtRmH2Mx=B-hM2xsvgEx2uqLEBQ5Dw@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 27 Aug 2025 13:47:50 +0800
X-Gm-Features: Ac12FXxVAGCqC8kO7laXHrqyg9NLNXjG8EmnlF9FGvji4Ol9mhbcIb_uqI19KF8
Message-ID: <CADxym3bo1DEtR+oFaN7F-cvFZ8yPgivxL69w35EETMKCGpmS0w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sched: make migrate_enable/migrate_disable inline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	tzimmermann@suse.de, simona.vetter@ffwll.ch, 
	Jani Nikula <jani.nikula@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 10:58=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 21, 2025 at 2:38=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > +
> > +#ifndef CREATE_MIGRATE_DISABLE
> > +static inline void migrate_disable(void)
> > +{
> > +       __migrate_disable();
> > +}
> > +
> > +static inline void migrate_enable(void)
> > +{
> > +       __migrate_enable();
> > +}
> > +#else /* CREATE_MIGRATE_DISABLE */
> > +extern void migrate_disable(void);
> > +extern void migrate_enable(void);
> > +#endif /* CREATE_MIGRATE_DISABLE */
>
> I think the explanation from the commit log is better to be
> copy pasted here as a comment, since the need for the macro
> is quite hard to understand.

Okay!

>
> > +
> > +#else /* MODULE */
> > +extern void migrate_disable(void);
> > +extern void migrate_enable(void);
> > +#endif /* MODULE */
> > +
>
> ...
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index be00629f0ba4..58164a69449d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7,6 +7,8 @@
> >   *  Copyright (C) 1991-2002  Linus Torvalds
> >   *  Copyright (C) 1998-2024  Ingo Molnar, Red Hat
> >   */
> > +#define CREATE_MIGRATE_DISABLE
> > +#include <linux/sched.h>
>
> Also how about calling it
> #define INSTANTIATE_EXPORTED_MIGRATE_DISABLE
>
> When I asked AI what "instantiate exported migrate_disable"
> means it guessed it nicely :)
> while "create migrate_disable" had a vague answer.

Okay, sounds nice!

