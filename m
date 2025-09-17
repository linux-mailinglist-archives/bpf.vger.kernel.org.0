Return-Path: <bpf+bounces-68706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB0AB81CC5
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 22:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C197B70EA
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 20:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BECE2E6CD6;
	Wed, 17 Sep 2025 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6arFysZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537E2288D5
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141582; cv=none; b=gJUGtk31YHmWagPYIDGdwGZktd+7aKN0b4otkYU8NQi+rC6jNwr6I6/NxZS7S9soBRUxDnaHb/0+ESFel4rH/4XU6Bg3edx8CGODoLmqfFHetoRCzYwQJOn9DtnUHAE6IN0OhBDFOxU7hGWbk/5wJpBUa8MD0i8awSlmkc0oYv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141582; c=relaxed/simple;
	bh=QS7EDN2hyVYczke+XTorDZBFk8JUkzdgAlHMz5S5vbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ng1H/9gCcB4eFI+eJ8g/3KUwJLZKS1S7+MACrriSSz8NIvoeNwImqgwHugbp1AbbrF9Vf/RdNrZ4legPD7+04LnBkgPDSQhouT52bDe4QSbeyJMlPw8tY9Ps728GGP9X/q8F1DYScd90r0/f21LgYVAyuOV9FeUWC8Dj0En4ioo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6arFysZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-266fa7a0552so2285705ad.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758141580; x=1758746380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGEnmh5du0Pzq6Rdo2bcTmUhls2o/6YOwMX0nbfB/uI=;
        b=e6arFysZxHdNH582TIqYOwc5koU0ncQKpz7JlMvpDEsRXNzvne9JwKcL4ovbc562GA
         CGYymMmoFsA65FSIiPNlZtkSCiPxYgalHQ1YCogT395uRSPXnMbGtd+QA69LjvQB9VDw
         xPiPPHwG5y8JfZzuuRDokOv9lLp3BmR2UUgXau+UJnO2qZTeblkQLxClPbF4YFR7GxWH
         lxG33JUL1llSeGmJJD25ZVwU38RbVFqzgbB/+sTspE9VWfNUs5X/nSx4C763an6jb7Cz
         p7GY4MkWFY/Uege7QYNtnVN3nULSPVtznMrXE3O/RrR4cViN2YUQJqts0JBZkE5xRwQm
         wj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141580; x=1758746380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGEnmh5du0Pzq6Rdo2bcTmUhls2o/6YOwMX0nbfB/uI=;
        b=d8rxaTTXScLjOGZs80w5iujLML0l2WBpGSi4Zdq1j7sgLsFGv+3oxvkAOcZSQ/v44m
         LzSLQhzyftVYYwOiFQhcKBk8MyqusPqngoRPe32G4AtJ3tyrX29LPBaWcu/Qb/1Ej/Pj
         QO+FrqZiIKfUyqrWZKKoalDThYsAbUF3bBt3B4alTMF54jbcdjeU0vHsfyHlbROa9fXB
         SS5a/jDCj9aJVJlSOC/EeyAYCys5/qRhTyPL+n5ythE7UvWz2JILzqO68ZCOkmy+Jh6I
         AiG0NluyfvUKjv3MbX4PkHJedWfS+HorEP1ogwcv+hxC/VmmvahhYIfRSHjwVUyvQocx
         FvyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhryZvZei/sXN0eazP4Fhum7kZnvNdPGFF2kKWSr8pmiJBdb5mbSc22wkSSQBvyhDwaIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxPibei0VCpfZsfayiJCTgcmSSFUgjPrcmW5dIcfSlIj05nhLX
	HPx50x3t5fSS2z8QmHg4j3qSOjyY1pku5fU608tk7cRyMSnpeK7cUKG2dsd/M9p9qbFfiYWiYb6
	ZWvSgWmFYoEUdU2cK02IUlzkOPCf4buU=
X-Gm-Gg: ASbGnctou5LAa935hGycOmFz6JQ5tGN6Bf5ZRvGaG/BHakD3hDTyv2PP3IoiVrHMmMR
	GXEKk0llP99Pgznc/B9DspWNkONZfreJTSzBeiJtiPDfq+eaXLWwFaDTEqf3M4z8ez5urK4v2Ts
	Lz5HQzDeIfBaWEZq0BKp6gMP2Su0wotTixJY8nVKm7wWpJezVf4uUwmW4vDcSv/crVhc6UUSmVR
	lf7boQqWu1Rp57MopAhN4c=
X-Google-Smtp-Source: AGHT+IFCjBIo2LxFLHCk72jsv748T0MS5ckTGyI25wwKlTOVqXJtYjuiiRuy/eB6sCxepmMCfVOb2q7/usGIKFDHafk=
X-Received: by 2002:a17:902:ecd1:b0:265:3c3a:6117 with SMTP id
 d9443c01a7336-26813902e03mr34835355ad.41.1758141580272; Wed, 17 Sep 2025
 13:39:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124334.1783090-1-quic_ckantibh@quicinc.com>
In-Reply-To: <20250917124334.1783090-1-quic_ckantibh@quicinc.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Sep 2025 13:39:27 -0700
X-Gm-Features: AS18NWBXZ1nEHppxud1nVARiIukjsn7kY8G9VoaFK9LqDvO9oKmSoZ2g1n-IO-w
Message-ID: <CAEf4BzbM+mG5EYQKdp1r4mntP2bXTb-KgJWg4ir6zzrSRrQURA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: increase probe_name buffer size to avoid format-truncation
To: Sanjay Chitroda <quic_ckantibh@quicinc.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Sanjay Chitroda <sanjayembeddese@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 5:44=E2=80=AFAM Sanjay Chitroda
<quic_ckantibh@quicinc.com> wrote:
>
> This patch increases the size of the `probe_name` buffer in
> `probe_kern_syscall_wrapper()` from `MAX_EVENT_NAME_LEN` to
> `MAX_EVENT_NAME_LEN * 2`.
>
> The change addresses a build failure in perf builds caused by GCC's
> -Werror=3Dformat-truncation warning:
>
>   libbpf.c:11052:45: error: '%s' directive output may be truncated writin=
g up to 63 bytes into a region of size between 34 and 53 [-Werror=3Dformat-=
truncation]
>

We write into that buffer with snprintf() which will handle truncation
and leave properly zero terminated string. GCC being overly aggressive
with its warning? Or am I missing something?

pw-bot: cr


> The warning is triggered by a `snprintf()` call that formats a string
> using syscall names and other identifiers. In some cases, the buffer
> size is insufficient, leading to potential truncation.
>
> Debug builds pass because they do not treat warnings as errors, but
> perf builds fail due to `-Werror`.
>
> Increasing the buffer size ensures that the formatted string fits
> safely, resolving the issue without affecting functionality.
>
> Signed-off-by: Sanjay Chitroda <quic_ckantibh@quicinc.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8f5a81b672e1..9413e86476da 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11290,7 +11290,7 @@ int probe_kern_syscall_wrapper(int token_fd)
>
>                 return pfd >=3D 0 ? 1 : 0;
>         } else { /* legacy mode */
> -               char probe_name[MAX_EVENT_NAME_LEN];
> +               char probe_name[MAX_EVENT_NAME_LEN * 2];
>
>                 gen_probe_legacy_event_name(probe_name, sizeof(probe_name=
), syscall_name, 0);
>                 if (add_kprobe_event_legacy(probe_name, false, syscall_na=
me, 0) < 0)
> --
> 2.34.1
>

