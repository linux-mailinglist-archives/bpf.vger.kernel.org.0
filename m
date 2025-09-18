Return-Path: <bpf+bounces-68867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872EBB872AC
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 23:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4200A3B8911
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 21:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4AD2FB0B0;
	Thu, 18 Sep 2025 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v078hUY9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A62ED85D
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758231535; cv=none; b=XZ56MRIdtxfwAGGUomJ3IHw8h0FiomEfLNCqbcs6hyW3Cb5aIpK+pFVa3trinvdD+n9Jzh6cSzBhOrJ/H4cW4b9FB3R5XaaX2pmDZU3o8xlE6JF1yzG1fjcOKoaxxwBFast/boL8vgqNuiAYvoD1eJrjUGU1E9unDHl3/L6hcl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758231535; c=relaxed/simple;
	bh=mlY7FRbhytNYlxp/A30rSpN7iz0DKtsNb8dUg54WZYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CKSXoSU3Gik7OjkS13znCqGQpUYozA/ml7Yc5KHrI3svn6iDRfGZdLstlnlK//pm7I5gW4eitM1VflvJ0m7sP/A//k2I3TVYNg/ixgdRi8cB5AbEuJ0Ab2irrU1zx1sECYjyy0yl0sp9OtfvoQNjAf9kcsZIpNBfS/c+w9ksz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v078hUY9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2699ed6d473so81705ad.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 14:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758231533; x=1758836333; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uvt9I2KpXbXrhZ6LPBcVnobYbaFag8C7jpCt8sntWwQ=;
        b=v078hUY9duiEa8FFeoA1RRjhG+6sf1HZ2Jt7zw0bvx31GJaQrxyzwdRV1CEif1XVHS
         MgU+tKd86qazkSuxQiNHppnb8gTVtvrFAtRjdqN1TDRuUe4waKaO49hXIJlq1lPr/yRF
         KepV2jW04rK8m1MIRd/WM+vcRW/AODPAzK7YS+LTROoAMaRM9TtdLoD1Unghj3KNcB5S
         XATMRhtIhbmwQ0D3cGraBwd+VTdHTXVj8HKl1MNRHmFxXEtabevcJP3+MKYqJ8mDUkL1
         YdxC+DZRYrDXLsU0w2r0IhQfc0NfpjD+udPz+HJW8KiECpRAzlIO2LK299TjhREJgkc5
         3a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758231533; x=1758836333;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uvt9I2KpXbXrhZ6LPBcVnobYbaFag8C7jpCt8sntWwQ=;
        b=b5xeV/LWbjWU6jK0ZBmHeIop7IUNlrLPn0BgQfFl+FbbZhBpExT2os7aJ7DNvHyGB0
         trm4orXSZ1OOGSQxGzhc4JXit0Cjjd/SHt1QZpS2yV3vdRHtD2JqY7jdty1Vk/HvCf+7
         TntCG2K73AQVl+qXd0NBN7csavnHIeQti6dR/3rLKjkuod++dJiqxq3D2nTKspfRyxPG
         EkHcNCM90x+M/13jR8tqB6NnskNO0NKemR9C5t60GbaKmABJXGqpZx5Y4mN4ZZBkGNU3
         q9cy/NqTXDOoPxaQlpKTO2fAkcZrQrg+3pFoBszo6L35Pg+WF32o0WXRJY/VXut792uH
         s0gg==
X-Forwarded-Encrypted: i=1; AJvYcCUZJSJIXJIuvwGd2zxMpix6eHIgjdrU6huMFMTLIYEFVkJGhUKTDJ/eBfinfKtn4pqT+CU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4x4jIUhLeZwrQ09d3mM27qzrOg/GnH56yIjIjxOu73JmQVkLJ
	8fmcA3TZpAkm1PgbYkB2/C2N2/bB86JC7Ae8k8NU6SYWFY/lS9hqq0bEK4llyIOM2jFOKVl1vfF
	RXz7v+a3yRz8oYPSwDhWoHblD4LlIy2BIJwBgfuJ6
X-Gm-Gg: ASbGncuCxCEc70H32ZauwYKtfclB75GUlCs6ZSs0Mo1x6wBRMRr4wTqo3RlOe7Q3aGI
	ZJaFoINJ/5jJPZlWGtnrBQfpZXlohpH44dHCabZo7MIH4qa93enG8M5z433qwwENoiG1EIVHgsG
	fR4UEIHM9tDCAAC9CCYCq+pnMKbRopXfGXqMlLXDWZE8ntAE5qzjvQBHl5tw5mYeFhUW8r+QonN
	UgnEGfpdXlvdyVQ0FiVe3oIttF3iF6UZ8j853cX6gnJhxbw/QRePfbKL5qUziOSpeNqbOuDNA==
X-Google-Smtp-Source: AGHT+IEaM4g2Y8nKc/gcP9AcbrDAw1aDgaCeO1MRm5LbJRIzEkkSSQzEpma1EJld9tYPD/d5gUX67e9HULwVBWwB//U=
X-Received: by 2002:a17:902:e5cb:b0:24b:1741:1a4c with SMTP id
 d9443c01a7336-26800b2b62cmr12430905ad.0.1758231532766; Thu, 18 Sep 2025
 14:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830053549.1966520-1-irogers@google.com>
In-Reply-To: <20250830053549.1966520-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Sep 2025 14:38:39 -0700
X-Gm-Features: AS18NWCtNfjGCSBOwnkEpIjtbpn08E3tdUXPQtKV_R7nWrrdnAAsLsdiNocA4uU
Message-ID: <CAP-5=fUiSVg5QYBHKT2nM1JyaEqZ-mn2_YrTo+P92_GrwHTxgQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf bpf-filter: Fix opts declaration on older libbpfs
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Hao Ge <gehao@kylinos.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 10:35=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Building perf with LIBBPF_DYNAMIC (ie not the default static linking
> of libbpf with perf) is breaking as the libbpf isn't version 1.7 or
> newer, where dont_enable is added to bpf_perf_event_opts. To avoid
> this breakage add a compile time version check and don't declare the
> variable when not present.
>
> Fixes: 5e2ac8e8571d ("perf bpf-filter: Enable events manually")
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/util/bpf-filter.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index a0b11f35395f..92308c38fbb5 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -443,6 +443,10 @@ static int create_idx_hash(struct evsel *evsel, stru=
ct perf_bpf_filter_entry *en
>         return -1;
>  }
>
> +#define LIBBPF_CURRENT_VERSION_GEQ(major, minor)                       \
> +       (LIBBPF_MAJOR_VERSION > (major) ||                              \
> +        (LIBBPF_MAJOR_VERSION =3D=3D (major) && LIBBPF_MINOR_VERSION >=
=3D (minor)))
> +
>  int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  {
>         int i, x, y, fd, ret;
> @@ -451,8 +455,12 @@ int perf_bpf_filter__prepare(struct evsel *evsel, st=
ruct target *target)
>         struct bpf_link *link;
>         struct perf_bpf_filter_entry *entry;
>         bool needs_idx_hash =3D !target__has_cpu(target);
> +#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
>         DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts,
>                             .dont_enable =3D true);
> +#else
> +       DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
> +#endif
>
>         entry =3D calloc(MAX_FILTERS, sizeof(*entry));
>         if (entry =3D=3D NULL)
> --
> 2.51.0.318.gd7df087d1a-goog
>

