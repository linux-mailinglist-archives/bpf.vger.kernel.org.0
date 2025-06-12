Return-Path: <bpf+bounces-60419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC6BAD6492
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 02:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B433AC713
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 00:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2F435977;
	Thu, 12 Jun 2025 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AnG9Eito"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F81E487
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 00:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749688763; cv=none; b=UKapUr7nCFpDpsv7LijGuFtHA7flurWbazlkxwFgLLIBHXFFubOfoChVBEOP8tsqXhfvfeyxfNPjvYVx8K0dRbi+D6NrCnzJqNy7VFUz96jh+ggRWcca+TQ6ZdnSpq3/18umJaNVh6fVNsphlr7IWHmIyIUGhaetzD/i1JjmXLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749688763; c=relaxed/simple;
	bh=1/YtnVp2w5cLp0fXiP/AkynA4GjML3bPzu3yfR14Y34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8auiEHtwx0R3fN24F0kuy15Rp4uwLtSoYCmpW4FvvnBsDvAx7KaQbtMlWU4xauw5tlSvDmGgrp5flIKCIXAitXUln2l2VAx8+Iu7Ny3nQfb77RYBx2lblZp2GyE5kSwOA8JodMZTxlApFckBa5JSDahtSJFD2C6Dn+hmRE1wFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AnG9Eito; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e7c23a0c46so120734137.1
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 17:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749688760; x=1750293560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MijS6fKI8avgozeUh7V7g+wjXCdFSSFspwam+Jh7L04=;
        b=AnG9EitoIjCACvlxjPoy7H/3x22cSvo+/Tu4hMhTJCOPYGAhirEnle10JkT/BHEXJc
         9ZL4vufBbE4zVP5ThJIyg8pjEbVa9roiLzwael+phWD3wMQIgctGYLnUX04kdwxZB6rh
         8KtpXjqtN/hw1YSaz0tVIZh5EzGAuRd59bBTw8HGsRUxwNcqLEygtA076T988oiUfMvj
         8JI6U15UazpbG9/kjDpIQbf8zdh56Zo4i9i0XbWZOpU/rF5ZFyPPyAjOYai6Wgi09U/H
         rG8w7ejZ24qM+pi3gw8OmYttKZiM+DUpNfJyWdw/lfKA9wW0gyAttKPqi91bEZY1lfO4
         WQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749688760; x=1750293560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MijS6fKI8avgozeUh7V7g+wjXCdFSSFspwam+Jh7L04=;
        b=hKuxiAL6zoORsOGVPI9V6KI+JK0xju+j0kzy9es/FkUiq1fMtx3JyL85yVdo04O/Zv
         yoOTNDPd7CV+zLY24USOumzeSdyU6FOoxccDipelYOUr6fkwmPZNZqua/UeF9aIyXYyu
         jnMqHnPe6U8wxq4esyTGyUVDC++nxh1SVvf/ZpXXpc8OPU5kzINtaL7A9pA4XP669Laj
         W8/Iell8HbVBl8QRnzsn2zsk2QWA+gJd2MMUvsk+fpSUYOL/Q8OFp681/9FnZ24uUA44
         lgNm1+RJ+nkDcV2NMQN94opAoopu2LWlK0gB8wRpDhxew8MrRyvqPImbO5rNa7/bLkSx
         W9pw==
X-Forwarded-Encrypted: i=1; AJvYcCVWq1Y4AOHuEqSG3kvVlIR91nvbgHJlcpH+gmFxaI15mqjG8Ja0dwbIYFtP5H8/aRB4MgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrizFc3WhYIuTiZiZIqLPYDhb+HR7itQTbwTkJ3ZahMMyZfnFf
	0DtIykgj8HMNMcCDEOcEMPesN7BgfKvOeFVDyEqlrquEQn51pyHw+DrkeKoLqmW5iniik1GVoFm
	HpIpybVTLeU/ECysCtwK3GSp3PQCVw9wGw02Hf15e
X-Gm-Gg: ASbGncvlpIxvgHG+q4jnPub3US0c5U7OBL+rQY9UWrop2bhpFXXxAmudAJ1Giudlmgg
	TwUuDAHFJY1ALV+EVeDFGfON92t61ZpTpjE1Oe1Qc98nquXkBvXW7XMxnQHyJBSDYYoYMl/lduD
	+Z4mGEGFiUG65y/kDil5znhfzL2uIwiZlM5FN0QR7Lksw=
X-Google-Smtp-Source: AGHT+IGJyR0TkHrxu2ca510smf27CLRnlR33XS+KipMFozqKN/NJ2jtkGZyOWX8gVxAfHrBxFp4dlDR5VA1QBQu8htA=
X-Received: by 2002:a05:6102:510e:b0:4e5:acea:2dec with SMTP id
 ada2fe7eead31-4e7ccb90176mr2182302137.7.1749688760064; Wed, 11 Jun 2025
 17:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606215246.2419387-1-blakejones@google.com> <aEnLBgCTuuZjeakP@google.com>
In-Reply-To: <aEnLBgCTuuZjeakP@google.com>
From: Blake Jones <blakejones@google.com>
Date: Wed, 11 Jun 2025 17:39:09 -0700
X-Gm-Features: AX0GCFtvh8DDYNH81d0g8swylgEtR-w4SutaqGqiWCk_py3r2whgK08XDdIBGYk
Message-ID: <CAP_z_Ci2HtnSX8h51Lg=XcW_-5OryGb3PAH7MJjWg60Bjpdpng@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] perf: generate events for BPF metadata
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
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

Hi Namhyung,

On Wed, Jun 11, 2025 at 11:29=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> I tried to process your patches but it failed to build like below:
> [...]
> Please run 'make build-test' and send v4.

Very sorry about that. I've fixed the two issues you noticed, as well as
one additional one where I was using the wrong include path to check for
the presence of the libbpf-strings feature.

I'm trying to test my fixes using "make build-test", but it's proving a bit
of a challenge. I installed libgtk-4-dev, binutils-dev, and libopencsd-dev
to fix build problems as they came up; I also installed libtraceevent-dev,
but somehow it still wasn't detected by the build process and so I had to
use NO_LIBTRACEEVENT=3D1.

Even after installing these libraries, I'm still hitting errors when doing
"make build-test" on a copy of the perf source *without* my changes:

    In file included from util/disasm_bpf.c:18:
    .../tools/include/tools/dis-asm-compat.h:10:6:
        error: redeclaration of 'enum disassembler_style'
       10 | enum disassembler_style {DISASSEMBLER_STYLE_NOT_EMPTY};
          |      ^~~~~~~~~~~~~~~~~~
    In file included from util/disasm_bpf.c:15:
    /usr/include/dis-asm.h:53:6: note: originally defined here
       53 | enum disassembler_style
          |      ^~~~~~~~~~~~~~~~~~

I noticed that tools/perf/BUILD_TEST_FEATURE_DUMP has
"feature-disassembler-four-args=3D0" and "feature-disassembler-init-styled=
=3D0"
as of when this failed, which seems to be upstream of the observed failure
(the version of binutils-dev that I installed seems to have newer-style
versions of these interfaces).

Is there anything written up about how to set up a machine so that
"make build-test" works reliably?

Thanks.

Blake

