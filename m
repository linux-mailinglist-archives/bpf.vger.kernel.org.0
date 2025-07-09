Return-Path: <bpf+bounces-62835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A20BAFF3B1
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB373AAAF7
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 21:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1563823D2B6;
	Wed,  9 Jul 2025 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpegsM1t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D2522A7F9
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752095310; cv=none; b=rRAbUc/tmbemHw9KBz/mNttRWDjTYinpjBMaeqvqeKll3r+UKOUqCP6w+p+ecUW4C3sYuPegobZOtSJ7H4uyhI51aHzKVbG8EuKZUtjiJDGO0Gqm8RI1syMRDOga09aC+R77CICBn0eLCRRv+bEJMPz+qiiNvdL2IfjRwH5c+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752095310; c=relaxed/simple;
	bh=y2wXxMQF6d3k4vp+pey/vuvx54s2OwWXTIMqdzyX87I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRFX3InAadIelPU8viuxkau8Qif+cCaSp3O+b6HMtTHs4coRPDJXeNLA9PwX3aB4nqwagkey8gKeTfppvf4EpzEvTgaLh5O50a+fSXD423h75F7lB7ltw6QrBJynWrZn3pQAFzr6NB1buWX4rbDmO+csFJcB6IYgQ99YnefEIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EpegsM1t; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-884f22f9c90so141128241.0
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752095307; x=1752700107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2wXxMQF6d3k4vp+pey/vuvx54s2OwWXTIMqdzyX87I=;
        b=EpegsM1tJ9Sxuppd0N7nEcOClE62jaJVVTAdJ35RGbVkTX3kMGA4ExFV5ifYdt4WUq
         aQnK3Fm2BJtQnuOKifBJ+ndSfk8u1ANKA7WHDsBzZhVw8PrdhktIEdWBJiCBQbQrtSV4
         gFIGoVC19JbrNBDsi5hxKFFBhyLBaLUlB4NErcP6fw2FlMXWYB/aZubhqkskhyg8tW/o
         BaR4cFAD4D90gWX33iOlt4U2z75R1JBqOdOMUNgZoJoWz5SL2yelb/UsqtX3JSA8Brwy
         +hjzsDfjV6W9e2C5uS8/xzI4gtKdGyX+ZD7g5Ig0WlkjGKr0N2BOXfRsFN07yWvbZonC
         rz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752095307; x=1752700107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2wXxMQF6d3k4vp+pey/vuvx54s2OwWXTIMqdzyX87I=;
        b=aSKblrhX6LZBsTRXQKrM/rmKQQontndeAioXO07EWDafher5uXr8M3OGad82PaoM5Q
         f/pLmJ7bROAnnqKDXuofK9iFT4/N3gmEXVhdTyPO5+CcFFJI083ur91ZXiUxgTuGngxi
         HkYNpKDH77BejQabFTcvWwTeCMc6lpYdhHRJzQK4DYe6B7icjK+fNeaTHkNHcgWHcuId
         K5BMrQ1bOzmILD+XUlBWwIdV4tsJyCw0+QiMmXRaml0NwE4JTeS+ap1J/bwoCI6qnCUQ
         t2bvoS1HulcTpCMeUatYbeRlogr29IBgmUc7phPblo6ifwzheaFRco+HP/EgzIB1pCEM
         kppA==
X-Forwarded-Encrypted: i=1; AJvYcCU11fTzl8tQQ+cBK90GktMyXnj9My9YewIBBbsXFlwZevrV+znW9s3OlPGAyD88/pGDxKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymWHhdjuDowSVorxXVJIOA+IiV83+1GjLkOOsoWchULtqNDUGm
	f2h2SHJ9/c8FWnzdrozGOI+J+BpwJ1O0QHpKnL3/17x0bHsTQejGUXlQ29LLhxp6MPX7Ds0bKL/
	VkQsapCEKH+nrhcjLR2xpnexB1XMmLj5RjiiEZUD5
X-Gm-Gg: ASbGnctdJlXOBOaTQml/lxGhGeTsUiow/8xh0jt53J0PKXN6zUmVwaefEerz69hUaUg
	FKyMVAJTCDkrS9G1+AYY8/Ttmxsvzg2BU4ZZU0oXq6fMzYEPIH76Fcgz300oNNM+wYJU23l/IJH
	HNx/m9mR66zsVT2BUajHycz/MUbIfTgwtztK/wWbSzXf/CIH/+Wd8nK6lkFEsS+aHrxnpycgQR
X-Google-Smtp-Source: AGHT+IGdh8eN3h8HscGvSa6bfWmnnHbDwGqF3PtjSKvTxi2yQaiUYm6rNI3VTgW1g2j5SJyRzIJjOT1h1JH55zPabDE=
X-Received: by 2002:a05:6102:50a1:b0:4e5:59ce:4717 with SMTP id
 ada2fe7eead31-4f62df178aamr186458137.9.1752095306773; Wed, 09 Jul 2025
 14:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605233934.1881839-1-blakejones@google.com>
 <20250605233934.1881839-5-blakejones@google.com> <CAP-5=fVX_Qohsf=f=-fR8mYsTq4zitURit2=4BYyD5HPJHOT7Q@mail.gmail.com>
In-Reply-To: <CAP-5=fVX_Qohsf=f=-fR8mYsTq4zitURit2=4BYyD5HPJHOT7Q@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Wed, 9 Jul 2025 14:08:15 -0700
X-Gm-Features: Ac12FXxXtr8XizMgnbtY6unx5cS16grFsxMMxrKhZdDg1-CAlIRC0HFgaVUWbWw
Message-ID: <CAP_z_Cjuh9HJvcnsARaX-QUwDMbRPMDr9AtxbBxYUR_BTSzwCg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf: add test for PERF_RECORD_BPF_METADATA collection
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
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

On Wed, Jul 9, 2025 at 2:02=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
> > +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> > @@ -0,0 +1,76 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
>
> The 2nd line in a shell test script is taken to be the name of the test, =
so
> ```
> $ perf test list 108
> 108: SPDX-License-Identifier: GPL-2.0
> ```
>
> > +#
> > +# BPF metadata collection test.
>
> This should be on line 2 instead.

Oof, that sure wasn't on my radar. Should I do a followup patch, or is
it not worth bothering?

