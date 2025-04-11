Return-Path: <bpf+bounces-55757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB87A86412
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DB81B80B47
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3616227BAA;
	Fri, 11 Apr 2025 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeQLV6rX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF072253BC
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744391126; cv=none; b=AKioZQwGkIGZkQyDaaRzkZArg9ZGa2njgXaadbRvwiTws3p66YDM58FJgFjRRiPBwY8YGIVR2GcP3Fh4jmyvYq0XfX+f6P/6SuhSfrh5yQqT4erM5ZmvpwemHviSb0ymmo8kv5poate0qgrARV4v7z+o+FMhRNbXfo2qhLbjd2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744391126; c=relaxed/simple;
	bh=XFwzrG/jxILlu52UW5ELUFhfR0khU+mcnxEkPM6ZD5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifil2IXwekyuytc9P0KkQz+/HfERwxHCZD6Gm90d3fRiBW7diygIMgdxKXF+6zf52XhLUt2VmIVtiaVtoqLM3m+k5Ogjb3n+bw2I1QUj9L/Q6vXYf4tJ0lA8puo2GL4xLg2nrca5Dex1UB4j6WvTwysORsqGVmdQ6KSv7mFqTyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeQLV6rX; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb1eso3865510a12.0
        for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744391122; x=1744995922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJq/0FuQnd4sUTTMaysGbny7PSd15zSD4nZZVRNrKdQ=;
        b=MeQLV6rXzc2NIV9qH8Sxn3tyZL8upbs6MKTHtS3tikv39U/dGDdyOT9S+93hxXWKVe
         Lj5TQNi9jSynWg34OFZ3Nzhfzw5u5UZRbfMtVRtjlZgFfn7E1T4DcFk0AFvamtBewSKO
         pockwSLzCoJqsWXv5YbGLsYduWKZLJTM9A8Pk7fCscTvH6AniYNoikqhNgT8dMACVdrk
         nQaQihr+Q6gaFIrNFctaeMHzH0V/D8X8o3WOe1y8TTQpvWGTQBA1A+H4bJk/BrLiHg04
         vrRtlKpjPm6Ha7w6dCKDa8oFT+PvpYaWu1e4GTJg2+9DhVuEurD8KSJ1SRR2iI4UjdO0
         Vcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744391122; x=1744995922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJq/0FuQnd4sUTTMaysGbny7PSd15zSD4nZZVRNrKdQ=;
        b=Rq+8cdkkYa2lh68gTZcX2izXeLVdIVXhYTPgi3HQKdaeu/GQUWqPgsaH4p6Y/RURC2
         cxFYIW4yRth6Ufz8fgx5R4Wac7S57wVYq5CClkqDMxQcutkxlp4NbcyRjO1//ua9K+FA
         KDsxNWmUfNDzuiDu32UcJ7oLeSvLxfjZ0KAaaT2E6ylsMP7o8cMW8Ub7oaN6vlxBv8aQ
         B79P/9P0RdohRLXXD1GCrx5hE4h4o3sBz2nYKTmAJqHJCTZCdZ+RIAGOlrw/z9eQxhYu
         1ZbAUaDbzGZJ3vngzQnk+q+rOQeMwvXKno+o68R98gNHaOimoZDwDrO3uyQq/IO8r60H
         GeSQ==
X-Gm-Message-State: AOJu0Yw/QsN5Xix6W/A8ICW5Z+x2vLr1OHqia/OAsyeqfH9W2hoaZPPV
	L6xUnnWw//Jj37E/aKB4SBEpMr3MyZ72HbGEcgMgdKIuTnSqtsAIKsFHPN3FpNsKnw5FvV9Hqnu
	7a/H+aUOlrm+jIJL+KwkMEBTBm0fq/IJbWMg=
X-Gm-Gg: ASbGncsNAsida8BE1pRV3p35vyhGr84yg8+PlhmRIXxg2AaecDDYXO7oU3UXzq6LN6p
	BFLmLjspxVoD8459yhqL5AsOjE3T09IRE1dqqr40WqkGvxftGTVNvjzECS+LWANjnWjedJxjRL1
	PLJeepiKw0CSGNZK9AMsJnyMWYgPySaCzLIzPJcP3j/BViDF68mLk1PzaB
X-Google-Smtp-Source: AGHT+IFtYnKOYYzIviAsn/g5w1jiCJAmVcnzkcTQzVQs/luBrCE4dYGx67fGGw5pouSXWfC0n69krpuoWahNylmjgSc=
X-Received: by 2002:a05:6402:1ec9:b0:5ec:8aeb:812a with SMTP id
 4fb4d7f45d1cf-5f3637e58d1mr3872097a12.14.1744391121931; Fri, 11 Apr 2025
 10:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411101759.4061366-1-memxor@gmail.com>
In-Reply-To: <20250411101759.4061366-1-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 11 Apr 2025 19:04:45 +0200
X-Gm-Features: ATxdqUFny2RTRzXuqj3-zWgOdQqB5mCYzMAYuxZFrGQvvh6qVYwzStdHbeDgLEM
Message-ID: <CAP01T76CVtC=z=JYP+HFtVrfkrZjuiR20xLWtHkshGjoA77MwA@mail.gmail.com>
Subject: Re: [PATCH bpf v1] bpf: Convert ringbuf.c to rqspinlock
To: bpf@vger.kernel.org
Cc: syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Apr 2025 at 12:18, Kumar Kartikeya Dwivedi <memxor@gmail.com> wr=
ote:
>
> Convert the raw spinlock used by BPF ringbuf to rqspinlock. Currently,
> we have an open syzbot report of a potential deadlock. In addition, the
> ringbuf can fail to reserve spuriously under contention from NMI
> context.
>
> It is potentially attractive to enable unconstrained usage (incl. NMIs)
> while ensuring no deadlocks manifest at runtime, perform the conversion
> to rqspinlock to achieve this.
>
> This change was benchmarked for BPF ringbuf's multi-producer contention
> case on an Intel Sapphire Rapids server, with hyperthreading disabled
> and performance governor turned on. 5 warm up runs were done for each
> case before obtaining the results.
>
> Before (raw_spinlock_t):
>
> Ringbuf, multi-producer contention
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> rb-libbpf nr_prod 1  11.440 =C2=B1 0.019M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 2  2.706 =C2=B1 0.010M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 3  3.130 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 4  2.472 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 8  2.352 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 12 2.813 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 16 1.988 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 20 2.245 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 24 2.148 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 28 2.190 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 32 2.490 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 36 2.180 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 40 2.201 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 44 2.226 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 48 2.164 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 52 1.874 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
>
> After (rqspinlock_t):
>
> Ringbuf, multi-producer contention
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> rb-libbpf nr_prod 1  11.078 =C2=B1 0.019M/s (drops 0.000 =C2=B1 0.000M/s)=
 (-3.16%)
> rb-libbpf nr_prod 2  2.801 =C2=B1 0.014M/s (drops 0.000 =C2=B1 0.000M/s) =
(3.51%)
> rb-libbpf nr_prod 3  3.454 =C2=B1 0.005M/s (drops 0.000 =C2=B1 0.000M/s) =
(10.35%)
> rb-libbpf nr_prod 4  2.567 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s) =
(3.84%)
> rb-libbpf nr_prod 8  2.468 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s) =
(4.93%)
> rb-libbpf nr_prod 12 2.510 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s) =
(-10.77%)
> rb-libbpf nr_prod 16 2.075 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s) =
(4.38%)
> rb-libbpf nr_prod 20 2.640 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s) =
(17.59%)
> rb-libbpf nr_prod 24 2.092 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s) =
(-2.61%)
> rb-libbpf nr_prod 28 2.426 =C2=B1 0.005M/s (drops 0.000 =C2=B1 0.000M/s) =
(10.78%)
> rb-libbpf nr_prod 32 2.331 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s) =
(-6.39%)
> rb-libbpf nr_prod 36 2.306 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s) =
(5.78%)
> rb-libbpf nr_prod 40 2.178 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s) =
(-1.04%)
> rb-libbpf nr_prod 44 2.293 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s) =
(3.01%)
> rb-libbpf nr_prod 48 2.022 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s) =
(-6.56%)
> rb-libbpf nr_prod 52 1.809 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s) =
(-3.47%)
>
> There's a fair amount of noise in the benchmark, with numbers on reruns
> going up and down by 10%, so all changes are in the range of this
> disturbance, and we see no major regressions.
>
> Reported-by: syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000004aa700061379547e@google.c=
om
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

#syz test

