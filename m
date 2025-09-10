Return-Path: <bpf+bounces-68061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0DFB523EC
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 23:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644BB464C55
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 21:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A83B311C1F;
	Wed, 10 Sep 2025 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4yZzaBp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53224C068
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757541499; cv=none; b=Wbke+To3qsMbXsS0oq+hrbQzy4duDMdX3uU40hOhjvqVnK4OLQYPXrCACg1xfvRwH8X5msYXyBsZtSeayc4x4IXF47lkrjB4KT2HyfGghuiQHh6Gg1fvSOT6rXr+yfAG0p0MUJ/YWT8D0ZPkqEGVIhu//mOjVJIpYRdfFyT/zNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757541499; c=relaxed/simple;
	bh=j7pl9XXhdsCQAwARPPrGx688mBvn56VXJjv7N3QOlEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EE9ZLZjIonPTSYfuk5/qQBGLiVhQO56PlgmGqdfmuCdYZEQoBgUGyktfbxebPr0dV90GECO/VKMp6rjLUKT9kAUOXHLGAZBIgbSSkJMNQ8mYj2aGuwpbNSqOTEF1C/ZHowgymT+xWXaK+/iCSkusNXNZiojaABLMVR6MdB057oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4yZzaBp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24b2d018f92so31885ad.1
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757541497; x=1758146297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNdDRzKVh+fbCQLnYIIu8p5ojZ83V5zU4hVRTP5bI5Y=;
        b=Y4yZzaBpOucQ71O6Dd6TdaXSX7RnV7VzhYexY89HZRhEweXy0ZZtPFNAGTabtjIwK7
         pr40abNSFuWmF7yzbpxzDl6gby3u/a3dc/y8FmGbJX5EmtOBp8y/A9nQPN0qASrwgkZw
         jilALEIT/BQlsgyO6zbpUOansF0I69p66XMX7keKXyqjFnrnxK0XiCUjuQDqkGuD08pu
         M/3DM7Xvn+wfBm5WfljPZLZoalu8bx02Y7v9V/fIp4Cr3h5I5M4olWDei3/EWOB3nLTQ
         uzfKPg6iz2OIgWVwiiVfSG+Pwq79/i0vZpb7bbGigBDkUPChijCDM51v0LLx/+zqf+qv
         92uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757541497; x=1758146297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNdDRzKVh+fbCQLnYIIu8p5ojZ83V5zU4hVRTP5bI5Y=;
        b=oqkge7MQx6qq+0lVaM9sd3UqttDSWyq7QA94nU/TkAJP4/Nu6l0CcSYSYm0GIAwuHh
         9pcfjcIpzTRBbabtih0X638KHUvwMf3el07b9A+7DZY8uNdh0i6vW+FUCTwS02grh2Io
         5sc2sDyklyH6lR8x+YLVbxA8Nv8s5YI6meWflQROls/eT9f7Ty2FMotLBxf0GN3iwdtz
         TfEUo5i12pIHCLATmJveBsO+YF4++tGXzrGucESI9vcDWju2j11vr90bd5YCwxVbnJXe
         V2x3Nvu+h3neslMOZpP4fPESC9rriq4zC973YRUPbccJ56lZOtpyFHjP0sDhGqunH9tZ
         Ppqg==
X-Forwarded-Encrypted: i=1; AJvYcCUa/CkdwTYcLWybRV+N2NDbfkC9WnzQ0J0U+ZXq3xQbZV3UyW+z2fYL1W+RaHJ8LZ1gWpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHzU1wdDQc4ymwbrjSy/9VhacAY1qa8Qrp8zIC9G3/rohwo7ju
	Cc2qzV7rz1z4SRXoNesuJEayjIFdnaho20J9i96RNI1Eylb8/89Rt4vyhBsQjyilqUvH4zLssIn
	DKBPv3b+AxaFwXys7mhemMPslD/l1P0pmINMDiMYI
X-Gm-Gg: ASbGncttWjHbggH5vQB5iJwcDaVk3SQqvtmbYIfJYDXXJ5X0LRaPp1IAE/IOPWmkoXG
	DwbBXQQ51r8lSLyAAbQCm07wDIo0CR4pNiiPfKqP2bU2VZwv3smKzwMvATkn7VDppdNrRItsACS
	yuN+4o+nBZJNb3caJ1HuIWUg38LmvZ0rdOSCh+3xXNh2eJJRW7ndmYGVT+ZGj3L8RVBZoy5Ph8n
	jn1kThsLf4vdEVVBD1ezxpET9BOVvE4O3/gn+h2+Xqy
X-Google-Smtp-Source: AGHT+IEH6cRYjS/H4UkebncduhV5SqeLugTSt+pUOgu5WRqiICr3JjsSOdXXMEsz+rjxO5AscA4visSN2D+r+MgsGDs=
X-Received: by 2002:a17:903:1a67:b0:249:2f1e:5d0c with SMTP id
 d9443c01a7336-25a7eafc3d9mr5940505ad.7.1757541497060; Wed, 10 Sep 2025
 14:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com> <aMHbIGRFeQlq9ABx@google.com>
In-Reply-To: <aMHbIGRFeQlq9ABx@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Sep 2025 14:58:05 -0700
X-Gm-Features: Ac12FXweAPm2rEaL-lypGqnYe4BTRKYfusZ0zI1g_R5qT3kAjhqD0e1kQf6qMoc
Message-ID: <CAP-5=fXN5oe7tLCnuBnoYKm68GhuMXP00AjszRyPc_XpDkacxQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Legacy hardware/cache events as json
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
> A nit.  Can we have one actual event and an alias of it?
>
> I think 'branch-instructions' will be the actual event and 'branches'
> will be the alias.  Then the description will be like
>
>   branch-instructions
>       [Retired branch instructions.  Unit: cpu_atom]
>   ...
>
>   branches
>       [This event is an alias of branch-instructions.]
>
> The same goes to 'cycles' and 'cpu-cycles'.

Similar 'cs' and 'context-switches' in
tools/perf/pmu-events/arch/common/common/software.json.

So there are a few different ways to do this:

1) In perf list detect two events have the same encoding and list them toge=
ther.
2) In the json have a new aliases list then either:
2.1) gets expanded in jevents.py as part of the build,
2.2) passes into the pmu-events.c and the C code is updated to use an
alias list associated with each event.

Option (1) will have something like quadratic complexity, but a fast
perf list isn't a particular goal I've heard of.
Option (2.2) will mean the existing binary searches for events will
become a binary search for an event and then linear searches through
the aliases. To make this not a slowdown we'd likely need more lookup
tables to avoid the linear searches.
Option (2.1) feels the most plausible. I was hoping the json and the
sysfs layout would kind of match, this would be true after the
jevents.py expands the aliases. This option is already kind of already
done in the legacy cache case as the
tools/perf/pmu-events/make_legacy_cache.py is making this. We'd still
need option (1) with this.

Anyway, I'm not sure these downsides are countered by a slightly
smaller hardware.json and software.json, or maybe we should just go
with option 1 if the perf list output is all you care about. Let me
know if you see a different way of making it happen. I don't think the
vendors will be particularly happy for their upstream formats to
change given other tools will rely on them.

Thanks,
Ian

