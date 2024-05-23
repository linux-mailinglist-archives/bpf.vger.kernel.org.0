Return-Path: <bpf+bounces-30366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95658CCB72
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 06:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E050B20F06
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 04:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF72412B15A;
	Thu, 23 May 2024 04:39:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4034437C;
	Thu, 23 May 2024 04:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716439150; cv=none; b=sM2qy5TApKrTLwL9Y5EI6ztOsPirc0ZJ6PEvu6+NhPRUVzhErhr8XWoBdcQYzjtGn5xjTozWwB9ezh17yuaOFrgBuOFjLRE7EKiKngjAgPpgr+0Ug2kQwVWHyzbzehKKPPF6yz1iyn3VEOuPnFoe7LxpVQ1H7/I/sRmjVzd859o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716439150; c=relaxed/simple;
	bh=ZgEDoaEgLaLqW3nAPYF9qKxB7KP0ycksaFQhIz4kCuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrpuob/zBxgUC7/Pz7W9ZKOntVnhmrTDlT/lIJf+y0owkwLx/kJp0I2IHd+t9KKNoeay/52DebYYFfYvIN6ed/Iy5bGwfI33qcba27nnYHFs1NuZowAo/dksahomnfX4lp6qGG3XuPjux7W64acXos93tqUspYmPRv1qAd4brek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2343983a12.2;
        Wed, 22 May 2024 21:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716439148; x=1717043948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rv4Spa7J+1d8S/LcjXFnrbLk7mSgRjPXbAy53MafDq0=;
        b=PijBheWgTpXB0tcNZbUo7NXqW0ayFtWVEDwp7L8Xp8YIjR6IQexNKW+tFJjkjilDp5
         E6i2TUN7P241R9nbUcxJ1UinDodPX4M8HERvsGH6nFuzvDinStbKygjcUApdFv9LCfks
         C3gcRTfkjFo2S5/Vx5N2A3uQWHmM6E9RRHp/dFO0ibBetV1rD4orJ95t0VdwdcCLrONr
         ax9j2onu039KGCLrJTlxpO+XT/DgLHBtx8tsWN8TlUg10M6qBPyvWnJvCC+/4c8vtuDH
         qh0TFVHS4CRYU6DjZg58XR7LXDTZdC0N0ea54nWczlFbwJg5ucAWkvvpnsEFLGq7f2O5
         p9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUCYBYgxIQOJvV5VnDXBkdinSrs5u0tajn6U1b/LmfKV+mRTPUKWEozUsjJiTfWTYhW3Q3tQ1X4NeCUqCE5jvlfHq7Yxc1szM06Dih/pvE/dS0S9JMVLRKjDoCQuq3FJTUCpmJDc7OGFCzad/g8PG8eYSNKK7/r1bJ7bSR0Hyc4f882yQ==
X-Gm-Message-State: AOJu0YzvSnXaG5M0ajeOxSu/GpMwd/i4SrRxyjiSL5AXUvCoI5HYMkHf
	f4+yVNRkSFEKnXqjFahvJH3Wjc+xPi6BF+ngWWq93Be99/TtKpFvijtaZPzr2MRXQilI7SpAY3P
	ig5ZulBhTkgwZm89K+KchqH+0BLk=
X-Google-Smtp-Source: AGHT+IGyxu4zpQIYFBOUiL3hGmai4PHmO6FSFeTJvn1XdtLU4H0XYTlVFI9f7RgGjY6eS1D0s0Rq7N6aZ6h3GDv7rec=
X-Received: by 2002:a05:6a20:9683:b0:1a3:8e1d:16b8 with SMTP id
 adf61e73a8af0-1b1f87e0455mr3572608637.28.1716439148483; Wed, 22 May 2024
 21:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521010439.321264-1-irogers@google.com>
In-Reply-To: <20240521010439.321264-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 22 May 2024 21:38:57 -0700
Message-ID: <CAM9d7cibAi-Xnr5HTCT6HB0sat=w5qicDrr+pcMuUF0OfNQRPQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Use BPF filters for a "perf top -u" workaround
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Changbin Du <changbin.du@huawei.com>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 6:04=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
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
>  tools/perf/util/bpf-filter.c                 | 33 ++++++----
>  tools/perf/util/bpf-filter.h                 |  5 +-
>  tools/perf/util/bpf-filter.l                 | 66 ++++++++++----------
>  tools/perf/util/bpf-filter.y                 |  7 ++-
>  tools/perf/util/bpf_skel/sample-filter.h     | 61 +++++++++++++++++-
>  tools/perf/util/bpf_skel/sample_filter.bpf.c | 54 +++++++++++-----
>  9 files changed, 171 insertions(+), 70 deletions(-)
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

