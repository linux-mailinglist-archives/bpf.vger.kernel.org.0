Return-Path: <bpf+bounces-71602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 320CBBF7E5F
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12E8400B59
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029DB13A3F7;
	Tue, 21 Oct 2025 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdbfwjWV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE6355815
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067715; cv=none; b=qXiY0nIjpYIWGko7DFdJuag3dpRyjVqHaKk82IlE/iEE+TO622UcwcvamygRHBkQpg1B7n5YklZZpuOUCvoGlDaorkOTf+FbTF/fAM0kj3MXTxeXM1rcPxJ46GZ8VHZVfFk1rrszIXgs+flA4TlGa1jes43CtJJP89rG79itwHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067715; c=relaxed/simple;
	bh=LgeXmUFyk3qaIqo0Rp774eDhtGk8Ghfak1JKFfApf4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2lG0HYh/a1Dr2W/pC2c9vOCnE5o3XRU3FOPgyvx8slPQYTmakbh79VY+b19zNfZ1HP+E/ISZNkX90XN9HoHIjioriz4K+Oal1Lz4Hud83eggOFV1P98Hf2K3kewXZYyu1UuYjtyy5x74yTI7QdXV2sorhtTLFpAAMa7xjXRsvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdbfwjWV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4711f156326so45498565e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761067712; x=1761672512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVHCV64PvtiReRqCpWYpH2m/B54XBvjNGhPUP38ZlYQ=;
        b=LdbfwjWV1/rW+erJxWyI9N15vGetIDsU3fA+YV+HltklPWb/WK4BZrRLplpkTxt3in
         uoyeWFTnf1P6DTgzkotmSmoJodXGCi+7ZCWjNNWqk7yUZxD8T3GOHQKV7ZfENVdqXSsy
         iyUmzAXshrw5SoEAUSg+1tC56MU7qcww1TpmSDKIIPA1nedCV+r1+7sDjpQMZw1sCtaX
         ZfrKHVWKv+m6CKRZzj5TBw9vgsZXsC+k/062iX7Tz3l27KT/iDT+w3ZKk1MYu1Bk6Dod
         ylSux0j/+xkfH2q1np0t4OQDHvIRc2NcU4WfzLe34A9zb0upJb3LzmHdB1rXwAx0L2p5
         hdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067712; x=1761672512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVHCV64PvtiReRqCpWYpH2m/B54XBvjNGhPUP38ZlYQ=;
        b=Xa+avg+sy1szVDEfbECygh0DXJBXdvUsLIxNcsShQ0FSxUCtzYSe9f4y7xwOASSGK8
         ZgNfidz0o4CjzgA9sizWqVp6uqfNdOOIeNEy7wbj15AANQ19qUspPud/1Y6G+l6Ee9Kb
         wqCQ99zHGBg/UirgMFFJHXKeMHH/0XxDYZvRvHrpD4KnV6DWaoZIAZUijUuvxyp7xTUF
         3HgduflTf78BdKUFti2TpOXDs4Ut8Yj4Oo8IX9XvUCOeZ6PMcEMWscJwmM5iVpmazYMe
         KSBtxunEfvxqu9qjyAQSzeUC6ubily6DI9O/Aax7WKK/y9oWBDqk0zhEWR87U0IkftGC
         S+6w==
X-Forwarded-Encrypted: i=1; AJvYcCVIH0/4Bd4CTv7MptqlUZWHCHtq24/RRnpsSBrgF9BZFmc+HRYRrrUVMDP7LPzYeYS2D0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YztDmS2YkF3bMMjUqSDeQSwRiIul56hahRGFy17hDhx4PvME11v
	pORywbz/ORO/khJpquIxcePpFpcx2mG35JdTU+NNJfZtGwReSidLlfq8jfP7pbGa7/kHQXKpz6P
	VXe/Z6CsDlZKAf4c6ZEA7aqu722CSOdo=
X-Gm-Gg: ASbGncsFgnPGUQyEggoljCj2fD9O3lB5FEHrR313ti8x8Sz3dLM1MQt4Tf4fxG/GiIS
	cUFsBfErW14DZ5rKbLIDWKY72E8Zdr3IToc4zO8UxViKLQCwLTuYpqDhntobVGSmYt/yeD0NuBl
	WLPbe3D4RHUEBc413+xeTv7VKTvnVhtdRw0zJOT/UrxRjV8wllCHat31wxm7ANQsUIjuq37AAqQ
	jKFzqdoFIsBkvgcPqaQ1L/ZxXRh4vbrpOe/zjxG0O7pXQnFBNVnnSA9YCqNmTr8gXVz1K/fDaWq
X-Google-Smtp-Source: AGHT+IHFn7gR7IuAx4widloDDlPnBPo9AwHt/0RV6fPlW05wXxkH+rY61gYgiE7K+aWrKofOe680pbjuspBOkxZnkh0=
X-Received: by 2002:a05:600c:1493:b0:471:1c48:7c5a with SMTP id
 5b1f17b1804b1-4711c487d74mr87072565e9.9.1761067712035; Tue, 21 Oct 2025
 10:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021160633.3046301-1-chen.dylane@linux.dev> <20251021160633.3046301-3-chen.dylane@linux.dev>
In-Reply-To: <20251021160633.3046301-3-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Oct 2025 10:28:18 -0700
X-Gm-Features: AS18NWBjnzTPARuhNgmAxCmDQioPAWs9SH3Yg-doGNGp6Bbr_qslNv97F3cxhhg
Message-ID: <CAADnVQJ2BrLy1FVEQmnN33ZqNZn0Nge1n6V89=p4NptjQNyHog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] bpf: Use per-cpu BPF callchain entry to
 save callchain
To: Tao Chen <chen.dylane@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 9:07=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. Drawing on the per-cpu design of bpf_bprintf_buffers,
> per-cpu BPF callchain entry is used here.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 98 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 73 insertions(+), 25 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 94e46b7f340..97028d39df1 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -31,6 +31,52 @@ struct bpf_stack_map {
>         struct stack_map_bucket *buckets[] __counted_by(n_buckets);
>  };
>
> +struct bpf_perf_callchain_entry {
> +       u64 nr;
> +       u64 ip[PERF_MAX_STACK_DEPTH];
> +};
> +
> +#define MAX_PERF_CALLCHAIN_PREEMPT 3
> +static DEFINE_PER_CPU(struct bpf_perf_callchain_entry[MAX_PERF_CALLCHAIN=
_PREEMPT],
> +                     bpf_perf_callchain_entries);
> +static DEFINE_PER_CPU(int, bpf_perf_callchain_preempt_cnt);

This is too much extra memory. Above adds 1k * 3 * num_cpus.
Let's reuse perf callchains.
Especially since they're controlled by perf_event_max_stack sysctl.
See Peter's suggestion in v3.
And for the future don't respin so quickly.

