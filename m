Return-Path: <bpf+bounces-51373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630A8A337E7
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 07:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A8E3A3491
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 06:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13673207A0C;
	Thu, 13 Feb 2025 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbohSlKP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8507182B4;
	Thu, 13 Feb 2025 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739427980; cv=none; b=RjQfhDOTpn7gke4X02PIM8aoIFKtaZGa3vjETXWATZvFoQwCUAnGlTwqa6e0a9InYzwD1+uQEt/OqpcD4a030oBj37g7CFo4CTWR2+qN0XxuQMUDDykQrfPcKitt+tdhxMmAtrwGqjexSo//hN3Jg1OQKxE3qmQjSwf4ByqGxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739427980; c=relaxed/simple;
	bh=3eKD/a6YssaZcnU7B/zEOqYou1bNGsBDyrImQted0Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOJ30mRvM0bGpC2rv9KZkuk7wIe6zpmEWJ7AdouozAW41hSIb1zPZNbnXUspQMVyqLy/itd1sdjMCcctYLolJ4tZxpts7rdJX/SxpyqkfJepuwFyXm1mAUWV6gYE8LsDPlsK36U/v4OfMAPhmqvSLHET3Ux5Qbd82Mh5c8ljhfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbohSlKP; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ab7cc0c1a37so99172466b.0;
        Wed, 12 Feb 2025 22:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739427977; x=1740032777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZREzq3IEp4MhIgLpCQw0VzNgzIUCNp3BPGLpVe9IMHg=;
        b=TbohSlKPpdYEoq/AomEZd3d/IBOD7koY02oJEADEHT1vt5Q6qIoccMLZcNCOdaNasT
         76lLvrcrECy5X1giN5GDaIWsaMz9Y0fTpfjZfMSfqrdPmvcifGkHrrFsdqR7qp6RfGkg
         XPJ1oMV2M43wa2/hZiewvyl/svDRL+kS+rFgu7pttB0esLKHNU1xq1qPAF/CF8CbiXdG
         Tt8GXggP9ULwrxlle2Cn7oJM+56VcO3nwe5zhBl6OQE9YZTkHpWJsIW3WFMGd75V3gws
         Cx7iofDw9Q6mJwit9IAgO6/taNbOSCDesoGppmw4BXsY8MPN0DOSz0g+UAR2eP4v0a+L
         uvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739427977; x=1740032777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZREzq3IEp4MhIgLpCQw0VzNgzIUCNp3BPGLpVe9IMHg=;
        b=ke4DSEArpKR2ZI1jE1vq9vq944ptgJV0fhkudLao7uDY1juB7nw6RwYtRellJou78i
         r/lPZ2MHlrZ/RCds4ISbPf5RTSTKHTf0yAqQxZWVeF3G/14GIDxI+jSE3taq9E4y9ICe
         NazKfc8KSKUC5MO/5I7/C940nsaQpq4PW/F6QzIU+t70eC7Sq9fvxKe1Fue+HwZ3fIIF
         C+sp1rw546IeWUsuLzhY4LFyvONXlLigMXsT9/o9A/vpw44qCiPvWScgznxkpwVbZVa2
         4Bw9ZC7Hk1TT+LQ3q9f+lRUlLXDQEPEXUXbjSIIe72nnhpwET3uQ1XOpPnz6I0nrYr77
         yEcg==
X-Forwarded-Encrypted: i=1; AJvYcCWQzzJu+gFQjmYJW1JUqK1iHp38OiOqcZeQF3F2Xq59WAsfiT8sI44r08ZTWnpj+ReYI3sZz+4HdEmKQLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya5jG9RPlgldvmgixHbZ99k2tUrxiCSX+SyxPsvTGn74mzcpPk
	/GtsI81UP+Q8Xt5jpBXGdpPe6TF5tsBvVoRF7o475C6nqk7ncqPVRTOcd9AqePADRleMQFYHqAG
	In403pKcYadc2boMn6VCBDYJLnuw=
X-Gm-Gg: ASbGncvCnr+NTFCtxJhcvtrtNqrYizAnHDabdrarN26YfAYbXOoN/n3bZD1U1YGLfGa
	jL9gtRG4xytlLMkx5NwimYZea1fxn6eXXYfgOMwJ60N0BVmgk1SoDPClLxYMUfko4BrqlSKz1FQ
	==
X-Google-Smtp-Source: AGHT+IHeb1K3PBZ3graH5b9Lm2ijGQ2AdV5iQKZp155aI3Aj4n2GlguI8ATXIyzS2yYccB1m7DwfPzkJTax0FB3l/cw=
X-Received: by 2002:a17:907:97c8:b0:ab7:e943:4c1 with SMTP id
 a640c23a62f3a-ab7f3370d9cmr601262766b.11.1739427977003; Wed, 12 Feb 2025
 22:26:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250206105435.2159977-27-memxor@gmail.com>
 <40cb834c2e034dc991a6b0c8140608dcd2e9e5fb.camel@gmail.com>
In-Reply-To: <40cb834c2e034dc991a6b0c8140608dcd2e9e5fb.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 13 Feb 2025 07:25:40 +0100
X-Gm-Features: AWEUYZnLf59qz2tS1fvIHgj3GabrMeOcjDCQIlhr1La0qsWXI2o04402F4THTm8
Message-ID: <CAP01T75UgmzoB=AiOzFz0jyrTAQ6F=r6rVPjjjhfX=Be9nc1uQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 26/26] selftests/bpf: Add tests for rqspinlock
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Feb 2025 at 01:14, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2025-02-06 at 02:54 -0800, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > +void test_res_spin_lock(void)
> > +{
> > +     if (test__start_subtest("res_spin_lock_success"))
> > +             test_res_spin_lock_success();
> > +     if (test__start_subtest("res_spin_lock_failure"))
> > +             test_res_spin_lock_failure();
> > +}
>
> Such organization makes it impossible to select sub-tests from
> res_spin_lock_failure using ./test_progs -t.
> I suggest doing something like below:
>
>         @@ -6,7 +6,7 @@
>          #include "res_spin_lock.skel.h"
>          #include "res_spin_lock_fail.skel.h"
>
>         -static void test_res_spin_lock_failure(void)
>         +void test_res_spin_lock_failure(void)
>          {
>                 RUN_TESTS(res_spin_lock_fail);
>          }
>         @@ -30,7 +30,7 @@ static void *spin_lock_thread(void *arg)
>                 pthread_exit(arg);
>          }
>
>         -static void test_res_spin_lock_success(void)
>         +void test_res_spin_lock_success(void)
>          {
>                 LIBBPF_OPTS(bpf_test_run_opts, topts,
>                         .data_in = &pkt_v4,
>         @@ -89,11 +89,3 @@ static void test_res_spin_lock_success(void)
>                 res_spin_lock__destroy(skel);
>                 return;
>          }
>         -
>         -void test_res_spin_lock(void)
>         -{
>         -       if (test__start_subtest("res_spin_lock_success"))
>         -               test_res_spin_lock_success();
>         -       if (test__start_subtest("res_spin_lock_failure"))
>         -               test_res_spin_lock_failure();
>         -}
>

Ack, will fix.

> [...]
>

