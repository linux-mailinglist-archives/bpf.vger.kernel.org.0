Return-Path: <bpf+bounces-65079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9910B1B8C0
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 18:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7215F1741BC
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 16:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA88D291C2E;
	Tue,  5 Aug 2025 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2tYgUSG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B541D7E42;
	Tue,  5 Aug 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412374; cv=none; b=XcrXR5k/IsrySJkkYY+XdIvfLhzH/YQ/7RgfMEJWPG8PWCDBLspveWqVRfCKFBVIEihnRB3q2DVCWgmccRmU3ksgSsjNUd5ej7YR4fu12/Tb8t9YMflm1I+474+z1fbqQqpqlhGsFMlfXvnFdrDs+M5kFdw2O/6DIyhoj7Pm3B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412374; c=relaxed/simple;
	bh=fNTTGuH5T5VaIxBP9KBV3HekRT0QG76qVsdrpa372uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sv88yu6f6gfHJw83gZSHqAkbU+Ws/39VxE5v2yPhOku/Z/wBlm6U6yRFvKlukTal8Jc6ipisimDJOMHjGpVs8d6jNJqGjw6HUzl4s3+NrIgzu8D1Lnq78UZ5r3nMLUTfjSWrwpbyfhZJV+B8gHV5MERuRBqiqiWWG0dGJ208zhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2tYgUSG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b78bca0890so3562223f8f.3;
        Tue, 05 Aug 2025 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754412371; x=1755017171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nBulG5qCHAkDb7LW5g6YF7Sb3IVW8hX0sdSxf4gY50=;
        b=T2tYgUSGqCmFndAAa+X5fdZU9KpWw/gt/HwTcsF2MxHv7svn1Kjr7Kh6LVDwU9Cj9H
         WyMyu6ndhiPVsiR0y7/YKcydgi0YaY60bDtw9FiIfKDYVH6AO2+c96eRF44KejZ4jbvf
         yZ9RjIWqsPwD3H9Sk+KHTl9X/O9d4OJbljOdi0dG7ucVtEqbgxYGNe0ekL5YirR0S+if
         A7EIc698zb0/aDxXGnISX6R4SLTJYicz2q8CFJIaUR3ELtLOHYyXSbkC5ptw7vUssPPD
         xkof+68NwC7CNRjX7TTQZuoQHQHaVvVx+IBc14xzjWaSXTi9r9gsp1Tap3XiV0ko3zls
         QOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754412371; x=1755017171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nBulG5qCHAkDb7LW5g6YF7Sb3IVW8hX0sdSxf4gY50=;
        b=HjUagCK4FaLxnlciGbgBJFeypPy44jIXQgytG+5WRgJDd3x4iJ7awHjgINx5IcsHSs
         SwiwLk9+Pi9oa3PZCmMTazpW/FiLIy8M6OFgEa7NvG5ohOSRT6SDOPyjQeIpYL5C69OZ
         QWk0X7+HXHxraKvohpw4Z2YY0nwQpSVAenIpKwsjfsA5oWLYlmC3DwfTnvO3Yq1+trZh
         J1BNlVptR9M7Y4bdg+7CpXZh92W/VVqQzpkWH1ApxFmwMY8cpxIZfjOXpa3XubP2HFnS
         e0InhqjjPGRi2eKdaZOsmMPfWVLK9ObD6cs7UOCbl6EP2Mze97Mkea5twvjc5sUGAvFn
         pbbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2ni2OrRAFV34Z5jj0kYi2Op7Rk6O8IWMSqYKy6lwEdrszrxGSZdaaKhAvwEouhUKfvNRpB4WeupYDlbpK5ktWSw==@vger.kernel.org, AJvYcCV8Q9/vlYjI6W2TAD2tbAzmpn6JWZQ/xRiSfh9zb3VpfWuT0nR/UenEWm2rGxSpSgBVG/R3QZwH2KOZEw==@vger.kernel.org, AJvYcCV8mksTbN7yaEPIAFFWpxg2VumoKoBygThDa81Dkrm+Bafr5KqJNTpJCqocf2tiw5s61HZw9shAWUO+XtY+@vger.kernel.org, AJvYcCXCIVndV0baT6Ec0fqRVVMHGCEjjDfxDCtbKqJSSsBPeUchOzxUQ8VpqKX859oeGQxyMdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK3Heb0a+cjoVeZCRsLtZ+zbD+/M+9Ek0jZHFWarrpQA5tj/5b
	CjcTh9RjUHxHRhZWcIcjlJGOMbiRHwz5nPKkZD8gVx9JAKRb4g4Ggfe+wA8aEiqrNJ2gBbhgfDZ
	tiEKuj0eO+kiuFzGARnpj8n3iwokRHHU=
X-Gm-Gg: ASbGncsVoFJkfUB0ChSNKZ3dkybABKYuS+P9j+tD4gZbRA2FwXheN5sRnreojBgU2gS
	6Xsavy+zg2seuBkVl7oZ3JfuGtZs/Vd6nI3GyXY/rb1m9tZ40RhxLRcACuRufRWyu3fJwf49vYv
	5eAdaOkaK1aauPKAbP1a0xnGGH01lFRH0Cp+fE3+JsgxOWr7L28C+XQ4Ca1KdyD9N6O1GtvxbtB
	TEKwqBD1kZY6vxWxGd7v/s=
X-Google-Smtp-Source: AGHT+IEHBZHpSZZ9fMnfoWTdmXCT4Gyd63CyUYE+7sMFEg8BShowdEVzs5HiMqqQuB9t8VpRz40xmohsAkK+PKb2WSs=
X-Received: by 2002:a05:6000:24c1:b0:3b7:879c:c15c with SMTP id
 ffacd0b85a97d-3b8d94c3a7cmr10647934f8f.47.1754412370844; Tue, 05 Aug 2025
 09:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805130346.1225535-1-iii@linux.ibm.com> <20250805130346.1225535-2-iii@linux.ibm.com>
In-Reply-To: <20250805130346.1225535-2-iii@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Aug 2025 09:45:57 -0700
X-Gm-Features: Ac12FXwRkwxxqRdNGVey4ba_nroVfaek1lncQ_KQ5v8My-UNlDYiA8oKB8OykdQ
Message-ID: <CAADnVQ+6WuHrrAg1bQ+-6p1zZAWQVC_EGtt9ocv5aZE9=CxB5g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libbpf: Add the ability to suppress perf event enablement
To: Ilya Leoshkevich <iii@linux.ibm.com>, Eduard <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jiri Olsa <jolsa@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 6:04=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com>=
 wrote:
>
> Automatically enabling a perf event after attaching a BPF prog to it is
> not always desirable.
>
> Add a new no_ioctl_enable field to struct bpf_perf_event_opts. While
> introducing ioctl_enable instead would be nicer in that it would avoid
> a double negation in the implementation, it would make
> DECLARE_LIBBPF_OPTS() less efficient.
>
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Co-developed-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/libbpf.c | 13 ++++++++-----
>  tools/lib/bpf/libbpf.h |  4 +++-
>  2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fb4d92c5c339..414c566c4650 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10965,11 +10965,14 @@ struct bpf_link *bpf_program__attach_perf_event=
_opts(const struct bpf_program *p
>                 }
>                 link->link.fd =3D pfd;
>         }
> -       if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
> -               err =3D -errno;
> -               pr_warn("prog '%s': failed to enable perf_event FD %d: %s=
\n",
> -                       prog->name, pfd, errstr(err));
> -               goto err_out;
> +
> +       if (!OPTS_GET(opts, no_ioctl_enable, false)) {
> +               if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
> +                       err =3D -errno;
> +                       pr_warn("prog '%s': failed to enable perf_event F=
D %d: %s\n",
> +                               prog->name, pfd, errstr(err));
> +                       goto err_out;
> +               }
>         }
>
>         return &link->link;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index d1cf813a057b..2d3cc436cdbf 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -499,9 +499,11 @@ struct bpf_perf_event_opts {
>         __u64 bpf_cookie;
>         /* don't use BPF link when attach BPF program */
>         bool force_ioctl_attach;
> +       /* don't automatically enable the event */
> +       bool no_ioctl_enable;

The patch logic looks fine, but I feel the knob name is too
implementation oriented.
imo "dont_auto_enable" is more descriptive and easier
to reason about.

Let's wait for Eduard/Andrii reviews. This patch has to go
via bpf trees first while the latter via perf.

