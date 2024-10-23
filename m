Return-Path: <bpf+bounces-42917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B309ACFD4
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 18:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABAD282B49
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 16:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB18D1CACFE;
	Wed, 23 Oct 2024 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa5fpfMZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136144436E;
	Wed, 23 Oct 2024 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699986; cv=none; b=ByWKkEKWUPNxLX/UCIRKrWiA9igmpslQRGJp9zYxVZAXx9cULdk/jlxhtkvDac8Mmaa6Ah4CuJrSFu4rQ/LCJHCOLyadGAMwUfVBl6qVUuGvWbe4aNlzYMPTl+hf3Se8yXlbSc5vNCi6wYoU64LSLOce6bOhA/yjC7EBWkuYwDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699986; c=relaxed/simple;
	bh=AFgFNt+8OeWkOCTgkQh8SA98X8GAph+OmJkAmjxSJoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKOmugKakjQeokNkAejtVyTyAQQ7+F8BONYql88MEutdE3Rt48/jA/wLlbmwW2DwAeOa4aJEMEuvM3CByn9jVo5H3fywnJHiW6IKepXLKEnSborcQczUYABvG4b21f3N8/+BuXh5fZIEGoNdXLMcp/aMXNo5v+bB8xY3GUSqZwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa5fpfMZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e4fa3ea7cso9138b3a.0;
        Wed, 23 Oct 2024 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729699984; x=1730304784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2ycs6JHoyCuWJ0BEKn3U88NqppMzv6rUewZmxuVEAM=;
        b=Oa5fpfMZ7bzp8J3DEhLVYDnhGOk0wzdFXhneBhymBARVH7PHpHKQkHmeb3bFfyYJZD
         6QFEn+XBzR2hl2FAjQqzCJcVKaVr09f6kSvzetGDQBuXbnOkvA6GMcbBDQelHSY3wtXM
         EpCIvZD5daL8nMS+2fSVb7who77s50kcknZp+bxKGzpXCewnwWXZm3ci8C5hPbDbRBuo
         S8EA1e+l7xwWzduZRAD+AkXQcYLT6Vv6YsQBczfTJM594NowhxPv47VjDsmqhp1pYkSZ
         4ZQPpdriflxR3kEgtsIpH67plDyG7z7y1//lEyifsNjKAGeK1R5i5pE1laM611mq9GtK
         /y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729699984; x=1730304784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2ycs6JHoyCuWJ0BEKn3U88NqppMzv6rUewZmxuVEAM=;
        b=e1DfP5y/tQvVexYhWnuJ184mbSXmLfyMincmrVK3ZY/VqugydO4VPoU5ryMlT+Twc6
         cwjbW7pm3sTFLS2vSpIlcSQ/L7UxHbHooXpiw/8q8uKJrpM7c/Q4BlUkh8wIk1xoEo/5
         7Q+TQ7ACDgwe1fv6Sro/LDIcYBT/u7a/ifjS+34SrPdfQCb3A7RQ2FBSrsyIL0KVBbIv
         dSFwmOcRhjnXbgJ+Rrlt3U+XB+ziDQRQ/UTaiX0DEokJIyUSMMO9rWWejsrrHa8fTY8m
         RgwKFQtmuaDVCR/MaJ517rxdqXge6P5XSTGK0EuSJ9gLV9Mjur5JU/W6AZW/QcdnHGJx
         GidQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/8JkZY2kWBO2xWQYCE/lzD5sYipxYTDYOUwKzXdTMi/FLgJblQ5tb35pzA4jla6U0k8I=@vger.kernel.org, AJvYcCVkaFf4J0uAdwADH5QVWvPy7p2DETCP0bcnLJhLdG7gMeaDb0ku9qpJenFWYBKQG6e9o6BH/tznxwpdr22W@vger.kernel.org
X-Gm-Message-State: AOJu0YxWgUPTiqJL6x5yr7gv+SN/wK+q79LTBDKxhJuOkanpAIKVQgxK
	On1RDB1A1+HiDfS8Spr3vpSGwVucJwNECRC2ZR0tN7JSzQCVtZOguzTW5u2YnEyi0uCn+n74Vwe
	i7eXw6/pAoJPho1xlZxB8aLmPPAM=
X-Google-Smtp-Source: AGHT+IF7xamcbLcyGtG89x8B1Va0g1Gcg0AMDxFZ9/qA3l5VaYBylu+YtD13mmUUNMJU3Vynrf3usvd4cXD/uPB5oIg=
X-Received: by 2002:a05:6a00:194d:b0:71d:f7ea:89f6 with SMTP id
 d2e1a72fcca58-72030c6f2b2mr4162957b3a.18.1729699984271; Wed, 23 Oct 2024
 09:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023000928.957077-1-namhyung@kernel.org> <20241023000928.957077-4-namhyung@kernel.org>
In-Reply-To: <20241023000928.957077-4-namhyung@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 09:12:52 -0700
Message-ID: <CAEf4BzaoWnUdO0OrmztT1NK62eVzYhFsUiD_E-hY5=oY3E-VeA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] perf/core: Account dropped samples from BPF
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stephane Eranian <eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Kyle Huey <me@kylehuey.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 5:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Like in the software events, the BPF overflow handler can drop samples
> by returning 0.  Let's count the dropped samples here too.
>
> Acked-by: Kyle Huey <me@kylehuey.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Song Liu <song@kernel.org>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  kernel/events/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5d24597180dec167..b41c17a0bc19f7c2 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9831,8 +9831,10 @@ static int __perf_event_overflow(struct perf_event=
 *event,
>         ret =3D __perf_event_account_interrupt(event, throttle);
>
>         if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PERF_EV=
ENT &&
> -           !bpf_overflow_handler(event, data, regs))
> +           !bpf_overflow_handler(event, data, regs)) {
> +               atomic64_inc(&event->dropped_samples);

I don't see the full patch set (please cc relevant people and mailing
list on each patch in the patch set), but do we really want to pay the
price of atomic increment on what's the very typical situation of a
BPF program returning 0?

At least from a BPF perspective this is no "dropping sample", it's
just processing it in BPF and not paying the overhead of the perf
subsystem continuing processing it afterwards. So the dropping part is
also misleading, IMO.

>                 return ret;
> +       }
>
>         /*
>          * XXX event_limit might not quite work as expected on inherited
> --
> 2.47.0.105.g07ac214952-goog
>

