Return-Path: <bpf+bounces-30895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821B78D4540
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 08:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 507D0B2193B
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 06:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6784414373A;
	Thu, 30 May 2024 06:04:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C8A7F;
	Thu, 30 May 2024 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717049050; cv=none; b=SKluSDmg4M2I6xJqfmlIW5IgqxQyF0mS0+hENK/5KZxlamwNWQB8JlrG1GnDWp/SKCoTLqczFoAZgpL6lSjZ6sEMsmxPahBzHEzGxCa4VTbGe7Um1tHaVlDEkhwzq3ihzJqgnkhpESFucYTf112b55hyNfBIzS/b3wNlUNFUyyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717049050; c=relaxed/simple;
	bh=URxu/tsa8bKNnf2t3ZCrJR7OioSdMvg9SOTtIE8dyKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQzvHlh9Qh6txY2B+Qk+CnE0B/6UQ9ODbGBDLIxuHGIWZz0hv/lm9cS060Qc94/FVvs1P9q9VaO6VsAU/gbAlzJ2pR4a9e4D71K9vnYp052fVauFsdfNr8KocPUEemvz4PKS8oYXAWe+iBWLWnmBZn3H/dqtnMfhd4oafL4r7Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-681ad26f277so437357a12.3;
        Wed, 29 May 2024 23:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717049048; x=1717653848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThHnNR/9j74Rarkk9nUgCXBgAgDJGiDv+klBudZG31w=;
        b=mCJrrsk51ik5y17Ul+z8hx7iE0O2cOH8rlDonYfHwSUa7N7P3RdE6bc/VV4r2qOOba
         G/lo+JyMV7xhwvXOIX22LtXe5SzqGKGzeiHjCRsFHbBzRTFWRAUPjM80JafDgrkTBmnP
         HGGTcrwPhTiw2dqle/S7Pg1iF9MaOFPerOzXqSP3ZS9VOYCCnB55Jtted/G3bayqVA7K
         FF8VBXVCfHxCDb8fupTjnN33jJUdzVeNklf9JsH3+GrRJzQbb6RyAYRGd1aQ04J80MEn
         VEIcyr+Oo2PNk9BZ4ma/IFITv4QFWDAoqwNQE5kjfp1UjRsfs/XpjPISgPopdvX7QAFR
         qRnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV03O3NztfQFoaOGWkqcntZATCnR13XNg9Tyqp51GlnAo9nUtMNx9BgxOVnSVPnDfk0Hkd9izEYm3mGyc4YkejXZxIJnS8JO3NOhsTjRLzEHIkyzB/Xx6aYqTwvjKJ4t/a3M8pJ/CUUqdJ/P0wmIX1025k9IcZirLk0kteiT5YGX60VkA==
X-Gm-Message-State: AOJu0YwtZm3ms3f7pDdoPVBOkxVim6S6SXM3FO2VALTNfCTVqTEsGLr9
	Jw7YZEEqxCD/CWDjUl6dPy9OEHTYm3PCkURAi+2z4sNOeAraag+uE5PwQu8bJSJEuWhgkgcmhzH
	CfyLgMtVrruUzlCowjdzJ22SC3ph/jA==
X-Google-Smtp-Source: AGHT+IFEIKu+ZoHL9gVO5CzC3c4Exr/ziXJi6rz2+DV0/AXVi19jEH2BUtVzDKswl0ykBodshY7JVpUaOP4dLYeb9G0=
X-Received: by 2002:a17:90a:f490:b0:2b1:782:8827 with SMTP id
 98e67ed59e1d1-2c1ab9f6d69mr1272467a91.20.1717049047939; Wed, 29 May 2024
 23:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524205227.244375-1-irogers@google.com>
In-Reply-To: <20240524205227.244375-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 29 May 2024 23:03:56 -0700
Message-ID: <CAM9d7ciL7G7YR4bFVO18sC4CRCm30G0WUdgp+txRnsG7CAYPHQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Use BPF filters for a "perf top -u" workaround
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Changbin Du <changbin.du@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 1:52=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Allow uid and gid to be terms in BPF filters by first breaking the
> connection between filter terms and PERF_SAMPLE_xx values. Calculate
> the uid and gid using the bpf_get_current_uid_gid helper, rather than
> from a value in the sample. Allow filters to be passed to perf top, this =
allows:
>
> $ perf top -e cycles:P --filter "uid =3D=3D $(id -u)"
>
> to work as a "perf top -u" workaround, as "perf top -u" usually fails
> due to processes/threads terminating between the /proc scan and the
> perf_event_open.
>
> v3. Move PERF_SAMPLE_xx asserts to sample_filter.bpf.c to avoid
>     conflicting definitions between vmlinux.h and perf_event.h as
>     reported by Namhyung.
> v2. Allow PERF_SAMPLE_xx to be computed from the PBF_TERM_xx value
>     using a shift as requested by Namhyung.
>
> Ian Rogers (3):
>   perf bpf filter: Give terms their own enum
>   perf bpf filter: Add uid and gid terms
>   perf top: Allow filters on events

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  tools/perf/Documentation/perf-record.txt     |  2 +-
>  tools/perf/Documentation/perf-top.txt        |  4 ++
>  tools/perf/builtin-top.c                     |  9 +++
>  tools/perf/util/bpf-filter.c                 | 33 +++++----
>  tools/perf/util/bpf-filter.h                 |  5 +-
>  tools/perf/util/bpf-filter.l                 | 66 +++++++++---------
>  tools/perf/util/bpf-filter.y                 |  7 +-
>  tools/perf/util/bpf_skel/sample-filter.h     | 40 ++++++++++-
>  tools/perf/util/bpf_skel/sample_filter.bpf.c | 73 +++++++++++++++-----
>  9 files changed, 169 insertions(+), 70 deletions(-)
>
> --
> 2.45.1.288.g0e0cd299f1-goog
>

