Return-Path: <bpf+bounces-39332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 649BC97200D
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 19:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BAC288ECF
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC0170A01;
	Mon,  9 Sep 2024 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8Fb4OXs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C151C28DCC;
	Mon,  9 Sep 2024 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901824; cv=none; b=EHLeemiiHEK5bi+PY5rgojkJNI6p6OBWItO7RmZQgzeh7Mx//4g2gJaZg27kGNRtiV01mreGvj9Kk6WJX0qDtsvdFK66VpkFYoqjTOUAXoGNU4GiNajYI6lC3BEb39WdupnIJrP83WtZgPfKi8g+rPRlzk0T03Fjw1mCsgpnwKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901824; c=relaxed/simple;
	bh=qKdYi20L8c3yuVMWrbqPAZ/XZ6RyXtp8jHo7w/aIqxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGg9IgmsnvDIz8zCIPZzSACjrDg4S9B2kcsDGqry4ipTbx1gzkwuDCQM3rS6h4p3O/1ROCXWB64kWFWdMThHQ9GBmeWXkjt1qtIiIfgdOS5eyTGSRpvD040eG1DiHH68rRIXnLCm+kHrbpagJKC6u4l/g38IvY+2yBz9v2SkM6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8Fb4OXs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2daaa9706a9so3544221a91.1;
        Mon, 09 Sep 2024 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725901822; x=1726506622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daNjFnuTcCmEpOoIZjhoH91whn7ag3w5EoRvU+yWxhg=;
        b=Q8Fb4OXsLuSmht5WFGD7XLgvbCIvOrc42EBmbvdjDu9/4ks3j4N7VxZzlwuGNB9rNt
         30TGAHovSGdKN2/Ct6W4dlIdejj8KLbSnp/iaXuAg/mjwA+UsOXGhkKawse8u0ocUKFj
         qHhNwubGCVu65Er0AGgqfYVCoSvveq4SKmw9J2l8ZR7i7OqpeLsWcSG2U+JQ9Q4RLdqA
         tc5nH83EwgigsCVNN/Ii/1J/TMPaeeHa8vRgoEqokiUkhE8AC0rSUKFe3WBPcmvYMFMF
         TBYggB1BAv7nCp+0nqkIGxWkqbEkga7tbmtqlycg2gMssCTBorNU469EBWlIYXHCXs3Y
         +O2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725901822; x=1726506622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daNjFnuTcCmEpOoIZjhoH91whn7ag3w5EoRvU+yWxhg=;
        b=OhAhfRYpt5r09eUmB/9pbjkuf0z95ODOsufIjMsKdsKxRUZ0vRdLpUqaqOo8m38zmx
         oEhaJZynmYLz6h/XNyukr+PsRbF6Uw9WCXoL8EBT5NR95X6VbH6ITZqAisY22ylN8LAw
         rZMXDkn/dUBB/EIk/4dTprS++gw0sPfnEBoOzunN8MGH2HiAayc213rBa1ks5CstHH2T
         f6b/0v/M0QY54nT5wtGPytYTx7yk2QXZcMuGcuxA3LeYxSyWXG6Fu/OyZ8wlDuTwDIb3
         V4qORdJ2GHW0eU6Y9CDZ3pG373CPSeVVB2rrsNYJGILlFN9pwEXqmH5LUKTTFVgMKWek
         Mlgg==
X-Forwarded-Encrypted: i=1; AJvYcCU6HeoBF09KyZWIsYASRaA1blntr2Z0vI3wMBcoOjLZDsNvMiEciDdrY3yxHlxG5ZtcYIrZVSywHh6Xl3UZ@vger.kernel.org, AJvYcCUVgQk72gardvm/YuLKq1sEyvJA/16boAlXwCA8RYxhztNYyD5ZKVI43WgyxOqDP3U8dUdpj8GEKzYqF9sBQ1QrMw==@vger.kernel.org, AJvYcCUhZsGTw/ry+NQQg1CgLpOsQulAuM6qE/5fa0N4Ku2yYMsl9dWeSpk3gqzxNmOv07B+IRSh08DE@vger.kernel.org, AJvYcCVrtcn/E0gBvvyOSR68sxX00l5H4Hqvw7skF5cxip7bITukPJ2AHrbOFILi7tGwCTgoZPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YysiM1ZYYyxmoJkwiWhiDaX3wchFF/mBOFFZEBm08FOy0IqcX4C
	vR9A63s21FfICO+Lb6xHAKLtPza6TyopaH+SO4g4U+fwQay8L9c0smWXRmXvYzHCygNu/NKZbMc
	NNjBGjzf4vmVqcBOdxULATzcpzCk=
X-Google-Smtp-Source: AGHT+IHkXfv32KdkJ4x1MewUfjbF8ld5lIdHroVrl/Ktu0a82EfNshwMxovWSljn73/6at59mD5SKScqAPjBVdNQp5w=
X-Received: by 2002:a17:90b:388b:b0:2cb:5112:740 with SMTP id
 98e67ed59e1d1-2dad50e87a8mr10745443a91.26.1725901821855; Mon, 09 Sep 2024
 10:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909155848.326640-1-kan.liang@linux.intel.com>
In-Reply-To: <20240909155848.326640-1-kan.liang@linux.intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 10:10:09 -0700
Message-ID: <CAEf4Bza+CTNW9G2Bv5vKG0YP_X-41T+D3N0Ly2p8G+SFX-MyRA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Allow to setup LBR for counting event for BPF
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 8:58=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The BPF subsystem may capture LBR data on a counting event. However, the
> current implementation assumes that LBR can/should only be used with
> sampling events.
>
> For instance, retsnoop tool ([0]) makes an extensive use of this
> functionality and sets up perf event as follows:
>
>         struct perf_event_attr attr;
>
>         memset(&attr, 0, sizeof(attr));
>         attr.size =3D sizeof(attr);
>         attr.type =3D PERF_TYPE_HARDWARE;
>         attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
>         attr.sample_type =3D PERF_SAMPLE_BRANCH_STACK;
>         attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_KERNEL;
>
> To limit the LBR for a sampling event is to avoid unnecessary branch
> stack setup for a counting event in the sample read. Because LBR is only
> read in the sampling event's overflow.
>
> Although in most cases LBR is used in sampling, there is no HW limit to
> bind LBR to the sampling mode. Allow an LBR setup for a counting event
> unless in the sample read mode.
>
> Fixes: 85846b27072d ("perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK fla=
g")
> Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Closes: https://lore.kernel.org/lkml/20240905180055.1221620-1-andrii@kern=
el.org/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/events/intel/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>

LGTM, thanks! Tested and verified that this fixes the issue:

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 605ed19043ed..2b5ff112d8d1 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3981,8 +3981,12 @@ static int intel_pmu_hw_config(struct perf_event *=
event)
>                         x86_pmu.pebs_aliases(event);
>         }
>
> -       if (needs_branch_stack(event) && is_sampling_event(event))
> -               event->hw.flags  |=3D PERF_X86_EVENT_NEEDS_BRANCH_STACK;
> +       if (needs_branch_stack(event)) {
> +               /* Avoid branch stack setup for counting events in SAMPLE=
 READ */
> +               if (is_sampling_event(event) ||
> +                   !(event->attr.sample_type & PERF_SAMPLE_READ))
> +                       event->hw.flags |=3D PERF_X86_EVENT_NEEDS_BRANCH_=
STACK;
> +       }
>
>         if (branch_sample_counters(event)) {
>                 struct perf_event *leader, *sibling;
> --
> 2.38.1
>

