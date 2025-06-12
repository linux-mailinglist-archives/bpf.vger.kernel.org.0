Return-Path: <bpf+bounces-60443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8781AD6736
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 07:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3483A7CAA
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 05:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1047E1E7C12;
	Thu, 12 Jun 2025 05:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3QyJY/qX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0701D7E57
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 05:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705600; cv=none; b=Cz8XUradXyIzGo3F+l2SVd8zoX4mbRcW9k4PEYuaAKnBknNDR219mjji3M1FWrT96eHPy79N7b5e2EX9QXTCfo3MGJ5tyozzq0xBevODV/2TAmdvvOBmSqrNZsgoUeQQniz1RVy0yb27JdvHulsr56+pPCczwUBwVSSE3nTF6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705600; c=relaxed/simple;
	bh=/P/DJBNjnkE1qjkQdZ+TBvKziziGjZZ0noq0dtdTInY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWwgDLAyYRP84D7qkHhCkC1bRGFCS1B4LtMQxFN2V33K1CENtsMyoI5t1rKuEnSyuKSf63t5jbQfbHScoofcRTotb/KR+99JujvCpFrtqrl/IXkwA7vVfQCGqR2UTUbIL5lKBU1b/YQOHsVnpP7ufyAD2cGJSFMRFDHmtuDuYLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3QyJY/qX; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ddc10f09easo104045ab.0
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 22:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749705598; x=1750310398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPdoN3ANegyWeQsOHYYrepeIprAZYiuTk2oe8aUOr7k=;
        b=3QyJY/qXBgE/3JI1FBWFZSMjw0HV6K0Po6G1v/Hgvink9N4Aoy374zYsIxEG4PIXaN
         t+R+iguaZq5hkUXQJxHhrRrXArpJYIDkP4rauhz8oAzOkBwb3StW2ZFEPdGclXa8rK3b
         yrMLJ+pSiR1z/8PNn+XDdEBDIHyAxNkcWDSJIS4kqvPeLuyh0hFjTm+SSX6RynJfSDZ5
         3FiX2qMUjbSbK6B/2X2ZOudeiCz9Ccsvm4k0tXYW/OSA/5lpefkYLNq89MhFfAa2c7BN
         9vbeyuBQope0mpZrmE163PPXi2mgrmMXSnpkorZLOUKB9DCyHUWFb2jD0NBqV8vYiD47
         pCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749705598; x=1750310398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPdoN3ANegyWeQsOHYYrepeIprAZYiuTk2oe8aUOr7k=;
        b=OqKqoDpEgzITnpJ0AKKZ63rMOMk8axRIk97XbDEk0rZ6bL8wMCauUZfm5cqI3n9l0l
         Bb1ccBcdtDrfyZ9gHhAFqhD23xLyqGJluB8ve3d8Vu+fvKWj9E/MSTDRdNDKg2wlWiJg
         wetGnF9/sNOygEUkW1iTFh2Fskf+gIugg097MIe5pPtrf2wbjltjpZ0PSGFGmuLAqlZc
         Jikq5qlioFFcsjGajSR23mNRb4cfs7ldz0l5Dcfu6GqL7vYrJqrmO994E6DlVqRa1uPm
         XWVdO8Hdh4yp/SSOiM3RUem1joUc26jQSFl0DGyiduPECb2iRA8BpypqbYVeIDfBCcHl
         +3+g==
X-Forwarded-Encrypted: i=1; AJvYcCXqtpu0NoJg9IzOv6lOo+wMquZ1IqGAruO6KmNkISSfiP5uv/6sNweKxroNXyY+rDDDZI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhoEno5CPAj7vGO1WuwqA4SS6CoZJtyALMesWgacwZe5iMZEpM
	9+9gr3FSyJNEIrbcBWUk7BEZnGUtqoJXgHlhG5eRhLoNPwP6rMxFrr8vbimxfGaVAXPKwU+BnKg
	xtz6otP9W6wZvU1jzeZInHfJ0vVU6tqYlmxs1HMyo
X-Gm-Gg: ASbGncvRvxK6BEkjWHydEMZ7yGMPPG5h+2shdTnbf+MS3/F0nKS7IadnllWVkvl0txP
	eACjil81sJD09OPu7STS+Ek0ZqcxOdNnhNrbgslaProYFQ2Lqp3eCyTh+DTKAImNZGuIgJgECTI
	UxyE1EOO3wPrYc/14W4kEP+rtPzYKyR9CAXR67BU7mNCZS
X-Google-Smtp-Source: AGHT+IE6oV9iOMyIcpwlHWNYge5b/BoungKrS8bwm6ti65Mcya/37bLaga6JzbosXVWRoP8lK6P3M/Ks+VBczEJ7PTA=
X-Received: by 2002:a05:6e02:1c2e:b0:3dc:a380:3ab2 with SMTP id
 e9e14a558f8ab-3ddfbf0ad0dmr1082915ab.21.1749705597948; Wed, 11 Jun 2025
 22:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606215246.2419387-1-blakejones@google.com>
 <aEnLBgCTuuZjeakP@google.com> <CAP_z_Ci2HtnSX8h51Lg=XcW_-5OryGb3PAH7MJjWg60Bjpdpng@mail.gmail.com>
In-Reply-To: <CAP_z_Ci2HtnSX8h51Lg=XcW_-5OryGb3PAH7MJjWg60Bjpdpng@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Jun 2025 22:19:44 -0700
X-Gm-Features: AX0GCFte5AogP3jzRMvEYvmxDFDHCWazF4ReJJeWZMJbQRTGtHjlNclFAxfsZPw
Message-ID: <CAP-5=fW1FhaDcG54OS=_65gxmehjDTR+1XqCPWMX-aw9reJHdA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] perf: generate events for BPF metadata
To: Blake Jones <blakejones@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 5:39=E2=80=AFPM Blake Jones <blakejones@google.com>=
 wrote:
>
> Hi Namhyung,
>
> On Wed, Jun 11, 2025 at 11:29=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > I tried to process your patches but it failed to build like below:
> > [...]
> > Please run 'make build-test' and send v4.
>
> Very sorry about that. I've fixed the two issues you noticed, as well as
> one additional one where I was using the wrong include path to check for
> the presence of the libbpf-strings feature.
>
> I'm trying to test my fixes using "make build-test", but it's proving a b=
it
> of a challenge. I installed libgtk-4-dev, binutils-dev, and libopencsd-de=
v
> to fix build problems as they came up; I also installed libtraceevent-dev=
,
> but somehow it still wasn't detected by the build process and so I had to
> use NO_LIBTRACEEVENT=3D1.
>
> Even after installing these libraries, I'm still hitting errors when doin=
g
> "make build-test" on a copy of the perf source *without* my changes:
>
>     In file included from util/disasm_bpf.c:18:
>     .../tools/include/tools/dis-asm-compat.h:10:6:
>         error: redeclaration of 'enum disassembler_style'
>        10 | enum disassembler_style {DISASSEMBLER_STYLE_NOT_EMPTY};
>           |      ^~~~~~~~~~~~~~~~~~
>     In file included from util/disasm_bpf.c:15:
>     /usr/include/dis-asm.h:53:6: note: originally defined here
>        53 | enum disassembler_style
>           |      ^~~~~~~~~~~~~~~~~~
>
> I noticed that tools/perf/BUILD_TEST_FEATURE_DUMP has
> "feature-disassembler-four-args=3D0" and "feature-disassembler-init-style=
d=3D0"
> as of when this failed, which seems to be upstream of the observed failur=
e
> (the version of binutils-dev that I installed seems to have newer-style
> versions of these interfaces).

Fwiw, binutils is GPLv3 and license incompatible with perf which is
largely GPLv2. This patch series deletes the code in perf using it and
migrates the BPF disassembly to using capstone or libLLVM:
https://lore.kernel.org/lkml/20250417230740.86048-1-irogers@google.com/
The series isn't merged into upstream Linux but is in:
https://github.com/googleprodkernel/linux-perf

Thanks,
Ian

> Is there anything written up about how to set up a machine so that
> "make build-test" works reliably?
>
> Thanks.
>
> Blake

