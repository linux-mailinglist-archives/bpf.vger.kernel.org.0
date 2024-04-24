Return-Path: <bpf+bounces-27688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1A08B0DE7
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BCD1F22BF1
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF76815FA6B;
	Wed, 24 Apr 2024 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="feRz2wqM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C715F321
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971949; cv=none; b=b+nXeTVgnF98fVnqxFTJz2YvSBaKFpiK59Htwz6Ldvj6vKCoSsdC4tsmWYg1uqM9cf7Fhzmi/XPDF2l6BDsuKPJoS2jyNeyh9fAZsSXDvaXMvLUvxRNFh2SQcI8wyIFT6kBC7SIdIPbu9KkPTg03HmeHFt8rk7WQONGGVdgpKao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971949; c=relaxed/simple;
	bh=zo6CfEdwy0Z1jFqYaKi4gjp+7PfLdUHzWaLTgeGkHGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAY/c5lYchQIoquWwrd8WPOCAeYSzjEZnyDl4iiFLOGEDCLpYD4ktA9tRVxdnDEkhBCrYifjr2f9SrcgjdKtYKQ2xpdHUeRasNlPYMyZoTVU8CRlH1zruNpkCwTnCoFue5p0+ERU0iZhMp0ECnXIkBiTloJGN5v+e9cU1qh3F8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=feRz2wqM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-436ed871225so329831cf.1
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713971947; x=1714576747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16IfUr/aDIVyiGDdNYlmv/QESeSDyKp3ic+JdrAeLjo=;
        b=feRz2wqMghEcvfLAvXv1fx904ZD5M7NaI7j0/XiUAQ50ahuo7PkAqIGbzW05QTXNrL
         yeqUwFrPRT6WdDBIdokZfPwYVEUpMAZ3nQtuFxDoPhdk8HmMCAiDspUlPiXSvr1LDTu1
         eUoOhVVvjD533VovQkhcgnQ7O1HeduVuTlnpqoZ/zpsoF9bWpU3b7bEkE3IdOlIAERFe
         YRY0fPpfr2cpYMf+gN5IxTRnC++4FozqgFktvl62Ar7qqdkC9NExjxUo5MCLgP7hV9yk
         5YJfdCdKxIOkGJAKYXy1ohCfy6LfSDH7fod8XYDPyrlJooq+0aN/pgliaD0pKYJdRhrO
         vEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713971947; x=1714576747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16IfUr/aDIVyiGDdNYlmv/QESeSDyKp3ic+JdrAeLjo=;
        b=YDKGqy94GC2DBNXa8rpK5frZPPsrhWPO3+IT2pemHApwHSvhMJR+FhO3pvtXMNuf8b
         a8lQetPELtLqYz3GdwqvBy6Nd+jocoYjWeD2FNlDCR3AAcXB+s+zc0MeSWWJEbZQ+DXS
         DccOVI/uLGtwCOpvkRpHJcoYdMPx/E+DLsw1E0rYI+6VD9KmQ9Zp3JiyG5ZHq9LePAim
         kLDnWRT/pz1XbZ3NoC9/DDkIsAyd9/r8J13ooQZz6SXFR9xXf4CAOxd3IiXzZlQjGsiw
         yhBAZospMRQV9C6j6uvbhixzDhXlT9oWNkUEx/CKa3Js/5lCKYQjAA6mKn/raEfEvrsE
         0q6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3kW2olRJEHqvriSHeeYuyKKDVv2DozsqoaY3BfI38oNkIO0eKgKbgM3QsyW5WS9EGzuIOh8j7WYhXZv4HxkTLeZPn
X-Gm-Message-State: AOJu0YzkXLYtBWL+Hss69wToQLjTe35T6Zx46bAn73pgJnS1uXezGemi
	OEAs0k1sk1RcZHJ3wOyTFXbHWu3GS1Y56F8oZBDkqAD6VmfkTX4HS7VJLxD3VUvQBn0W0LS2LeC
	7I5hQ38bMEwJ7Z8DTlew6Rc7aESgJnD4hFpt6
X-Google-Smtp-Source: AGHT+IEFfX0IrtvdULyN66f10heNy91Xt+GeYOFUXi4nvaPeuN2PAOzDNm7Vw0JcnmVVNOeGCTZgBZtFwdAB2xtB2ts=
X-Received: by 2002:ac8:1286:0:b0:43a:2e2b:eec with SMTP id
 y6-20020ac81286000000b0043a2e2b0eecmr169202qti.2.1713971946704; Wed, 24 Apr
 2024 08:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com> <20240416061533.921723-14-irogers@google.com>
 <e8147f53-1930-44d8-abb8-fee460ec355f@linux.intel.com> <CAP-5=fVXv_gsoq5L08gaEJvU1E8xoihc3-L4taA+bPHyOJfgqw@mail.gmail.com>
 <7df3ff63-a421-42cc-bcaa-b0254ff6a0e8@linux.intel.com>
In-Reply-To: <7df3ff63-a421-42cc-bcaa-b0254ff6a0e8@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Apr 2024 08:18:52 -0700
Message-ID: <CAP-5=fUi8DPNrbp=978K92Mopa71ag1sukttX3KcztD2ac0ADg@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] perf parse-events: Improvements to modifier parsing
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 6:20=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-04-19 2:22 a.m., Ian Rogers wrote:
> >>> +             /* Simple modifiers copied to the evsel. */
> >>> +             if (mod.precise) {
> >>> +                     u8 precise =3D evsel->core.attr.precise_ip + mo=
d.precise;
> >>> +                     /*
> >>> +                      * precise ip:
> >>> +                      *
> >>> +                      *  0 - SAMPLE_IP can have arbitrary skid
> >>> +                      *  1 - SAMPLE_IP must have constant skid
> >>> +                      *  2 - SAMPLE_IP requested to have 0 skid
> >>> +                      *  3 - SAMPLE_IP must have 0 skid
> >>> +                      *
> >>> +                      *  See also PERF_RECORD_MISC_EXACT_IP
> >>> +                      */
> >>> +                     if (precise > 3) {
> >> The pmu_max_precise() should return the max precise the current kernel
> >> supports. It checks the /sys/devices/cpu/caps/max_precise.
> >>
> >> I think we should use that value rather than hard code it to 3.
> > I'll add an extra patch to do that. I'm a bit concerned it may break
> > event parsing on platforms not supporting max_precise of 3.
>
> The kernel already rejects the precise_ip > max_precise (using the same
> x86_pmu_max_precise()). It should be fine to apply the same logic in the
> tool.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/x86/events/core.c#n566
>
> Will the extra patch be sent separately?

Let's do it separately. I'm concerned about the behavior on AMD (and
possibly similar architectures) where certain events support precision
like cycles, as they detour to the IBS PMU, but not all events support
it. The max_precise should reflect that AMD's Zen core PMU does
support precision as a consequence of detouring to IBS, but maybe
things in sysfs aren't set up correctly.

Thanks,
Ian

> Thanks,
> Kan

