Return-Path: <bpf+bounces-63494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 685CEB08092
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 00:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295661C25474
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 22:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3C72EE604;
	Wed, 16 Jul 2025 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS3T/g4J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427882EBDFA;
	Wed, 16 Jul 2025 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752705331; cv=none; b=dgd7dmQ0T4Y1QEFcf51rKxELZb5Ag3y+iNk7r7C3jiczO4p1WcjK6PMQ9jP+HshQ4238VZ1kioe1KG2t/ocAw+bcP/42i/PhYukhg7mH0Syf6823yqJGnyHjI/J7A58IYcPNjB8E1yAts16qq2GVEK/9O0BUSs1bvlQdJ6EdyO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752705331; c=relaxed/simple;
	bh=ihqtxvuaePCJRjrI9bbkZfzFFJPXV6Qw4RciPs7H96s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dA31S40Cd56HcqsScAtd1GB6uqjB73XoyH5f2Ii5P8le4dF9+le0yhOo2TCPtH0jyBJYC0t/a0qEisv17ahvCa1t4c2wCrBE2FZGjKqy7uR84c3L5+SQIifFQPA4USHC0bZvFQnatOxYeG5y/05xN+Ujfggy4JQHrw/+4XKTT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hS3T/g4J; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a510432236so182546f8f.0;
        Wed, 16 Jul 2025 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752705328; x=1753310128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0Gv5U7wRRygrTnfBDLqfpN5UAmpFYc/vfX7L8VHiBo=;
        b=hS3T/g4JmQjxvT1PEUQ15jhUhlYHvi92kCWUYclSvPmkSEFJ9J0NDKLFCZ5oBIOJqw
         QoMlf03qP6mpavckebp7YagGQt5edtI+TI64JpuR6bFnszUL9UTgXy2o8D4rA0fD+U1c
         i0sNb+lR7+RQ3vjxnaWFswL5iDvQtUlHtfWqU1E+uJ5K1ELMxpcMGL8hE+bNmhDZ1pA/
         5FjEvzh9MlMIhka+dPSvT5kcyObjIxc1bF7GiUjkfEwHsVQ60sq9GiJYHD4Vpl/JbEZ4
         cceU2qhxLHYDctK43+vmRL5iBtxr9GpAwQTnIT9b0Jfxs0gVhXSXDzyszwUZlblWBWPD
         8MWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752705328; x=1753310128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0Gv5U7wRRygrTnfBDLqfpN5UAmpFYc/vfX7L8VHiBo=;
        b=IecFG7vxaSy4ZuTQ0lgB8sCEcKwO2vlfvgCuw3hTsSjo/F8AD7zGr7grGshnsp+abC
         j/ct7sn7L30GATo56EPZYRR0kbthts1QiP4OueQSrm3ggk6LN1UGu04kK65USQeuFjT8
         16h6trBpCruWLcaxoRAkxe3q96BG79ce7QR3ZZCZN+2tRT4PqaElyGJ2246RyWJyuRF/
         PZ3w4tlrEMo+U4pr0OxGWEiqCUcj0XIFne5AlCZBbtNErdEowV3xruTcZ+iwCNvqxRpN
         qxDcqXUNtObn7y6/nkL4GX7NtFnZGnhNEOIQBJWRseDop5R6xs3D8ZTHWGxZ7yT/SC4Z
         vOzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc/N2E3+yd2+b7FIeDaSop1pAGlDM5nSi39yEPMUI9JLQCP/7VgcIZXbAtwcWFSKhurwE=@vger.kernel.org, AJvYcCUeEfsHToMoqgzJuKmu4vDK8sGb8uadYMDntFbMdEPHMO8CiNv6H57PTGReqiW1SuwGHePuqxKkzhwYf3nu@vger.kernel.org, AJvYcCXeAphOuJT6k+k296fjVsBfzgFIKi8HCpC1Ta7AYZOt2NsTeV/cEjhi2mZyP/gMjVg1qY9f1j7o@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/80gV9N3skWNr5SmDtxXFJasCDySq/0f60h71JB/22iu3Bp9A
	JamWKL0IlRnsDLmn8df4W8u+RKyB2LZgE9tzCgzdzgtxYRl2J5rZqaytLTrC4RaUDEKp0jTkNIi
	mm2vGdi8ERDbcPa7WtZ0gpOu0m6GVYx4=
X-Gm-Gg: ASbGnctsOdFqKsk5UJqdHYknGIHe5c1BIv8CPr2GDy/rITI7du2izUxtVv9/OYCWNSi
	Scwgd0rTexPjlsxP1FtrBB3nmnNKFOJD6wwXH8B0Z1K6Xtq4TKcXFmLPOPqFvWpFCVSs+3OS3gp
	9CAqqWvqzLdmEy4Z8l15g0WGXYUdLSa7lpiQ91c8kqarWoSQ6QtjYZN6+srwdVdYOWaCLpQ+uT/
	aRWTul4QkikcBHxizVeTUXDkVNgvP8YYeGX
X-Google-Smtp-Source: AGHT+IF7XQEr8HGwwkyBnAb+Y4ECHAMFV3Qv10+nR9BaY3GaCv58MOAbJHvyGxIy8lvQ0uXsBsolUyAIMTCtLTaN0gM=
X-Received: by 2002:a05:6000:41f8:b0:3a5:300d:ead0 with SMTP id
 ffacd0b85a97d-3b60e524366mr2951920f8f.43.1752705328329; Wed, 16 Jul 2025
 15:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-3-dongml2@chinatelecom.cn> <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
 <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev> <3bccb986-bea1-4df0-a4fe-1e668498d5d5@linux.dev>
 <CAADnVQ+Afov4E=9t=3M=zZmO9z4ZqT6imWD5xijDHshTf3J=RA@mail.gmail.com> <20250716182414.GI4105545@noisy.programming.kicks-ass.net>
In-Reply-To: <20250716182414.GI4105545@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Jul 2025 15:35:16 -0700
X-Gm-Features: Ac12FXzWH0rKesvtcO-Gzu9jDF0taBq-qfIHzwXYv8v7YQIN-XbBENDtEWKMI5Y
Message-ID: <CAADnVQ+5sEDKHdsJY5ZsfGDO_1SEhhQWHrt2SMBG5SYyQ+jt7w@mail.gmail.com>
Subject: Re: Inlining migrate_disable/enable. Was: [PATCH bpf-next v2 02/18]
 x86,bpf: add bpf_global_caller for global trampoline
To: Peter Zijlstra <peterz@infradead.org>
Cc: Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 11:24=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Wed, Jul 16, 2025 at 09:56:11AM -0700, Alexei Starovoitov wrote:
>
> > Maybe Peter has better ideas ?
>
> Is it possible to express runqueues::nr_pinned as an alias?
>
> extern unsigned int __attribute__((alias("runqueues.nr_pinned"))) this_nr=
_pinned;
>
> And use:
>
>         __this_cpu_inc(&this_nr_pinned);
>
>
> This syntax doesn't actually seem to work; but can we construct
> something like that?

Yeah. Iant is right. It's a string and not a pointer dereference.
It never worked.

Few options:

1.
 struct rq {
+#ifdef CONFIG_SMP
+       unsigned int            nr_pinned;
+#endif
        /* runqueue lock: */
        raw_spinlock_t          __lock;

@@ -1271,9 +1274,6 @@ struct rq {
        struct cpuidle_state    *idle_state;
 #endif

-#ifdef CONFIG_SMP
-       unsigned int            nr_pinned;
-#endif

but ugly...

2.
static unsigned int nr_pinned_offset __ro_after_init __used;
RUNTIME_CONST(nr_pinned_offset, nr_pinned_offset)

overkill for what's needed

3.
OFFSET(RQ_nr_pinned, rq, nr_pinned);
then
#include <generated/asm-offsets.h>

imo the best.


4.
Maybe we should extend clang/gcc to support attr(preserve_access_index)
on x86 and other architectures ;)
We rely heavily on it in bpf backend.
Then one can simply write:

struct rq___my {
  unsigned int nr_pinned;
} __attribute__((preserve_access_index));

struct rq___my *rq;

rq =3D this_rq();
rq->nr_pinned++;

and the compiler will do its magic of offset adjustment.
That's how BPF CORE works.

