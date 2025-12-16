Return-Path: <bpf+bounces-76790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F381CC57EA
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 00:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D47BC306EF5F
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 23:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EFE340A46;
	Tue, 16 Dec 2025 23:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7sTtqyd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600A340264
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765928124; cv=none; b=BtG6SgUvGw9DCNjeK0z6RksI/KwslsyR0EdlVvD5ZJIUYpKVvJleqEDc3X+C4F08K9BNleUjbru4RR9YgOR5wXxwa5+ycOcSA2Ku0im89xQqsgYDBJyZyBJ/RiHMquaSEnhfXc1sebo2XXeQxrGN0L3rzq3pvb4/SHNPI6yzYXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765928124; c=relaxed/simple;
	bh=W6vpDia4FoH9eh75+8sB+9wBjdzpiIlbSOmLaD0uumQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kcdz47pgdR2mu0tZqwV/WQRghAf8SfkK6oNDKMPUiIE0giFbMOzI0jLcMk3gOoX0YB0fgc0kUqmA4190ljTVTS/AVBXkN69XOPuAJtxHxPmSSUKQFzy+cVZp1Sz89NACmxYuyJGiGtEmRkqc4JEYBPauSZfY8BPaMSMRlpNdxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7sTtqyd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47a80d4a065so32169975e9.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 15:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765928120; x=1766532920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6vpDia4FoH9eh75+8sB+9wBjdzpiIlbSOmLaD0uumQ=;
        b=Z7sTtqydHZ0/s7Bob/8BFiNWtG0ibt/lgzTF8dyGU8EuqwT8pMASjcG7cD68lKN/M0
         XmZf9sKANvGvizBe56k+GxhdFamzo1tADj0aBvVPPP9ov26+8LlBGfnDNSmf1Mk1wkMT
         kQbgkcdGYy5yb19BpiVJW1MAjj364LvrzeZsN53Az+engGqlGevBWobvLCyk8OMsv+/g
         mIBdEfYka2xhInP+O41jxavxMTfMFrRFl9Y5kM2yBzsZQ0dJLlZfzYdvTvcFmj8vR5ZM
         qdSHFpcRWxOIL6NbyfiOB0jTdE5n/UVT4Xu6Jphy/ScoT5z3JIwqYORIyOMrmO84UE19
         s/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765928120; x=1766532920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W6vpDia4FoH9eh75+8sB+9wBjdzpiIlbSOmLaD0uumQ=;
        b=mRcz9j3sNx7UrWpYRMj4r7xaaeREyN2fbNEzWQLudBfUpKZyoUs5Sx1MbQ4YRQGoNt
         wHKRPevBGwZt37Un5Eq8UYMWuT0Zj60lYKr3LYV5777YfjANrkFNnhAfzZC2qVfiSSsj
         NG/UNXgpKVoFIUqi5Dcq0z/F9bxv5EMgoJYPY8l5+b18BH8wVnzmPGnwaiErfTFP/ckm
         MTQxhYHdCP+YS/S2eNAOTRx2cRKeR/S2oFFfmrszYs/Ut+YOWtUZAygZn7Ra+ntfGBhE
         t+RDlkC8U5u3CE+2ssiPvaL0a0KTro8i3WpsTQ/J6026FYIJqYcikm7VvSHtrGYxsjeY
         F2Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVTJ1oJgXhK/y5sWrP816hGVucOdzdektk01T09BW0zTJGEIv11RR8yKTmjBo/rWeof8Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwclTtkPC2omrvFPniKwJ2b9PxIuBEjY8SfX19DpPzEVktItAmt
	i+elMjc7Zn65ZQBbSRrDwxcwZlSWTRKSz5AKMbnDoyibsfmqo+3damn70mQyBCHtJrwe/KFBDuP
	YlJuSyD4dn4lNszhB3w7uYkIejzMz/bg=
X-Gm-Gg: AY/fxX7BD8ZPXAZnjJ23Zbnl+OqkKKmJoN8yvzdObCLDxXftNDRTSfSmL04Hb71rAi8
	cD3B0RuPapzH504mzJ7FUyFkqAeXBBLtiINiii7DmPYAwVfGypiTDRfrQQTMWFyrn1jN/CYQhJJ
	SoEykUzNKxdPEP5I1vRX/jwmd6D1hKONJ0NcYOb6ufoE8eN0tBTPx/caA28AffANFJ7wPuXnE11
	Zbm/3Sv5qTH9SCKBZcVrLFEbetIvq0HeYF4HEKNJONxavuSMzweQ+UGbPmbkzNSZPOlLuVkIVel
	RwKTO6Pa02AEV4PtW7pRhzULsnFRX9lVlVRcfTk=
X-Google-Smtp-Source: AGHT+IHjp/16v6iZgDNYj+IuMGgLFwmSZaVPm7qlrRq0sjVfy55a2ykH7/91v8vRe2lt6+UywAYHRqqvLP4Zs6KBqYo=
X-Received: by 2002:a05:6000:40cf:b0:42b:3246:1681 with SMTP id
 ffacd0b85a97d-42fb44a3ee7mr18325137f8f.18.1765928119945; Tue, 16 Dec 2025
 15:35:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112163148.100949-1-chen.dylane@linux.dev>
 <20251112163148.100949-3-chen.dylane@linux.dev> <c41372ad-1591-4f2b-a786-bc0e19f8425c@linux.dev>
 <7b82e322-eab7-4fc2-9de1-d10ad8251378@linux.dev> <42627219-fa33-441d-b8cb-eb48ab3230d6@linux.dev>
In-Reply-To: <42627219-fa33-441d-b8cb-eb48ab3230d6@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Dec 2025 15:35:08 -0800
X-Gm-Features: AQt7F2rJDT2luiBfMEOsoczK4qPy8i7YrtRrkYDQTvIlKjsIFHyghSnoN9z97qc
Message-ID: <CAADnVQ+pP2oJhMOWe1dLg4W_+bMU=amfzYGWKJ4yVNcq4KOvNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/2] bpf: Hold the perf callchain entry until
 used completely
To: Tao Chen <chen.dylane@linux.dev>
Cc: Yonghong Song <yonghong.song@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 1:34=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wro=
te:
>
> =E5=9C=A8 2025/11/26 17:29, Tao Chen =E5=86=99=E9=81=93:
> > =E5=9C=A8 2025/11/14 00:01, Yonghong Song =E5=86=99=E9=81=93:
> >>
> >>
> >> On 11/12/25 8:31 AM, Tao Chen wrote:
> >>> As Alexei noted, get_perf_callchain() return values may be reused
> >>> if a task is preempted after the BPF program enters migrate disable
> >>> mode. The perf_callchain_entres has a small stack of entries, and
> >>> we can reuse it as follows:
> >>>
> >>> 1. get the perf callchain entry
> >>> 2. BPF use...
> >>> 3. put the perf callchain entry
> >>>
> >>> And Peter suggested that get_recursion_context used with preemption
> >>> disabled, so we should disable preemption at BPF side.
> >>>
> >>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> >>
> >> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >>
> >
> > Hi eBPF maintainers,
> >
> > This patch appears to have missed the eBPF maintainers on the list,
> > please review it again, thanks.
> >
>
> ping...

pls resubmit and ask Peter to ack that your patches match what he suggested=
.

