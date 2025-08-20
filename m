Return-Path: <bpf+bounces-66057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B807DB2D1FA
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 04:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC2A585701
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 02:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABC326057A;
	Wed, 20 Aug 2025 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF0G5qNJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01117FBAC;
	Wed, 20 Aug 2025 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657266; cv=none; b=YNXNSrPLqf1PHuqLpXLK296qSB14y8Wb39HoE91J6J8ODjlnPkkSyd6PbppfQGr/POFZ2O/f9yeNSw2PsxIDGiktUFL/4L4LjeoOaikgi9j6mQcZTeoiytuc68cmE5xWRWwHzsX2Kc8+E+fS1ZXGfo/MGwq3VNfiF9gM6eFr8do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657266; c=relaxed/simple;
	bh=C40iIuQKKe9JZhkYXU9PE+o7vHAU/PHNTf1JtgxJ6hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QM50biAtgeezFHYbC9akvzyOo7D0bCNCrXqt64YLHkPo3+ZkLPoTw9EpqIl7cLWorouA7VMG3U0dGxQOw9dQ6G/sPYDRQ/61dV1OxcxueLb5/dDsphh8CBVnpRzS6jWsZ0UYL4ZMjy4XAW4LCnyWhD9j96+BImymJHA7VPpM2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF0G5qNJ; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-71e6eb6494eso37958207b3.3;
        Tue, 19 Aug 2025 19:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755657263; x=1756262063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O+Vi9Pj3DACHxJMyQKxj44yEBD25gKvGbsKrHL2Xao=;
        b=fF0G5qNJcrw08IYJ9yFw+2848wia/1oy4ALukLQqfgGi8hAenwA7OO03BYYBDzu9DT
         l+7GN0fjwx6J0VH1xWsAsndX+neYN9q4R4fFtN9IC/XjzaT6KiF20Bgoii3KUyfTqvHS
         dd/NsCYweSEGMJMTC6goNBfeFHdvFGrpyJYMyfkdkxgCOaopJ5Q7u8xjLw+VayUZpTUX
         HoL+0yd3sGiDLoxnou0Ihn6svR6kuqqxmIt7demTsnpdhhporyrWhYCa29Vprm0MGvL0
         rL/Zkc6Wvrvoe7+n5fRXvwYLXuJLr4R++sk6J53C0iPgJSsQKazS/oqgP0+fNgXSFmf9
         MbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755657263; x=1756262063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/O+Vi9Pj3DACHxJMyQKxj44yEBD25gKvGbsKrHL2Xao=;
        b=dOKUBfQRs+l/N1Sx5lG/PDLU3S3gP+YG5IGPmS+TFHx4XLkMKejrNvb0HfwEORZyN4
         2y5zixGiCSFQhkcVqnh5NCvOtpaa/6sLQvRdBFap89/1/rSIJufM1+OifhHxUHlj+rla
         8aya6i2WduW5twceB+X22FX35tI9SV3qfUJZRBetO7Ul9MAvfDvGP03LkGGcX9Km1PY3
         8X6G/OnQSKwqvZ5iicZbTtH1IhwDdfALJfBmnxdbta4P+pJBd7ZZyJcReppFd0gTDsFE
         wYg9NxUIvYFfeoRUBWJv2WVXoTmq0OPNoJep6DpEc/KbEgw3Ou8qQP91B0eu4oeg+Umu
         fHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk0+RiAozk5EBnP4djUFHlqO+6h5IByajjOFpnkwvFg5mMHBMBxjsCPqXInFnhth1Txhl7gObqlURnL8zM@vger.kernel.org, AJvYcCXBRO47xOC34xDiqRTs3IiWfv5MK80mmzFHlJSPJ9kS9+6S9LckE+b+pl02UfWZoLLg/zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNPwbGYgdsipjHnSr0hC3R33xmHzko6K30BvbQvhxdrJtXTw1y
	OZ3gL0ybNCNXZN6R5rhQhTHVnAhGojuJcWI2zEFvOnGXCDr8duREJ+25U3zxGj+a6bl5cVJQU00
	bcE+uJu39FB6bFWl8ubDdenVUHCSrbkQ=
X-Gm-Gg: ASbGncutAlenz8FBU4L8ayI5gDebTn1BodbFIiJdGNeAo+L23qFYzyDGpiQEBlKWNcQ
	3zibrAGoUwCu7vTk7o+XsqdfQg3sOIQQinuGdMGGgZInpcE4n4zk3pHrENSKhJofDd2fPut5c7D
	0FZxYSWVZDJQ4J7TSaruD7tECYY68aua+yMJhqD3p1cf95AO+BkW/B8TBRhqatjcJ+21oFB0i3D
	iCpkVk=
X-Google-Smtp-Source: AGHT+IGZYiTWjxYhSjSPiaaMKiQp7ymBwE17bO70ijts3XfwHqcUWucdDfAdqCwhlNrikWJeMVGQHsvfqK2wvzHvV0s=
X-Received: by 2002:a05:690c:4:b0:71c:3fde:31b6 with SMTP id
 00721157ae682-71fb3222e1bmr16814237b3.34.1755657263455; Tue, 19 Aug 2025
 19:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819015832.11435-1-dongml2@chinatelecom.cn>
 <20250819015832.11435-3-dongml2@chinatelecom.cn> <20250819124008.GI4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250819124008.GI4067720@noisy.programming.kicks-ass.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 20 Aug 2025 10:34:12 +0800
X-Gm-Features: Ac12FXzeJifKg5LlkIVeR2FnDxbMmcLFl2bl8TWaM5KwTB3Amdhho41QamBj_Q4
Message-ID: <CADxym3Z1w0tseWGDPM00FRtL=5ckMioo51Yna1oACW72Haaxxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sched: make migrate_enable/migrate_disable inline
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	simona.vetter@ffwll.ch, tzimmermann@suse.de, jani.nikula@intel.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 8:40=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Aug 19, 2025 at 09:58:31AM +0800, Menglong Dong wrote:
>
> > The "struct rq" is not available in include/linux/sched.h, so we can't
> > access the "runqueues" with this_cpu_ptr(), as the compilation will fai=
l
> > in this_cpu_ptr() -> raw_cpu_ptr() -> __verify_pcpu_ptr():
> >   typeof((ptr) + 0)
> >
> > So we introduce the this_rq_raw() and access the runqueues with
> > arch_raw_cpu_ptr() directly.
>
> ^ That, wants to be a comment near here:
>
> > @@ -2312,4 +2315,78 @@ static __always_inline void alloc_tag_restore(st=
ruct alloc_tag *tag, struct allo
> >  #define alloc_tag_restore(_tag, _old)                do {} while (0)
> >  #endif
> >
> > +#ifndef COMPILE_OFFSETS
> > +
> > +extern void __migrate_enable(void);
> > +
> > +struct rq;
> > +DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> > +
> > +#ifdef CONFIG_SMP
> > +#define this_rq_raw() arch_raw_cpu_ptr(&runqueues)
> > +#else
> > +#define this_rq_raw() PERCPU_PTR(&runqueues)
> > +#endif
>
> Because that arch_ thing really is weird.

OK! I'll comment on this part.

>
> > +     (*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pinned))--;
> > +     (*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pinned))++;
>
> And since you did a macro anyway, why not fold that magic in there,
> instead of duplicating it?
>
> #define __this_rq_raw()  ((void *)arch_raw_cpu_ptr(&runqueues))
> #define this_rq_pinned() (*(unsigned int *)(__this_rq_raw() + RQ_nr_pinne=
d))
>
>         this_rq_pinned()--;
>         this_rq_pinned()++;
>
> is nicer, no?

Yeah, much better!

