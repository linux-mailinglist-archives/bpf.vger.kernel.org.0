Return-Path: <bpf+bounces-59561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4148EACCF6C
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 23:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9853A1890F00
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 21:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217AF24BD00;
	Tue,  3 Jun 2025 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y8C34UnB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4BB23A562
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748987704; cv=none; b=T+RS7ibcj5KbuxVeuA35xEBqVSvEfox1FBvRQfc9NiHWEcQxXbVo6CLKw0Pin1BzzuwV89z/OL8fB0tCuqee2+DaRbshf7epGjgTYZx9OZP/BeBA3GdKQeWGZeKcMRYl0QiuspBqDTWSd3mUGW+Zp3vYy2n9umvGy1cJrAL2kLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748987704; c=relaxed/simple;
	bh=M2XddcoG9PvQvUc5qK5I74/V0vhQT/NdRMUW0iOYGxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ynm/5ztG/YlH93sPwXS0DPOQ+jdsO8QNVdXVDKDE1cXDBBGt88rmawM+EnDhQrEoQJxqc1wvxAlL+NqphBvA+aTipoTdjwSzpS5iZC6yxLawZlG+mJGyFFyC1MTRyL4KuBBRxsTt1KQMD7AtdmajVxStoE1yXWeYSAw6kzBwFiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y8C34UnB; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-87ded9c6eb4so232566241.0
        for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 14:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748987702; x=1749592502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9WTUUrdCRqQFAEsgXpM/vXRnyBSDopcd6mTa19SWV8=;
        b=y8C34UnB3Wp0ERqshL+RaWbzIH856q8aHDCyXMgC4m6vdnroEPNeuYGCnFUCwkmS4h
         LZupBjzJAaEIOHmlwtJwzchc1NCXkSVchFqgboO7VfLISOs3lsWjtPnhWv2/k4dFrupa
         +27DFUVoOZoVzBVCh+QdwdYe+bdQlivu8ZvJ8mzbfPEaArW8AtiJcYkeYQYJfw7YWXbA
         pKP4thvmozg0cMxy1NypxiV20adEUf11yjw010/7Qbuow93P5fShMUCIPZVdMdIPEHTU
         A0TSzGG9+plpsrnSuJ9hh24QtiG00U+LDJRjq+qBM3ubJdUwL2MmQ1bCbHMHyZ7UoSe9
         0snQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748987702; x=1749592502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9WTUUrdCRqQFAEsgXpM/vXRnyBSDopcd6mTa19SWV8=;
        b=qGbWep2VlupNOk+XBWuM8XW+nSMwX4NLBb0zFzQOG6FAEHIIdYyPZU4bOZdHuN3iBt
         EPPIl1xRNmETUjXHZScloH7wm2KSX6W4cbBY4n9flQ9vmSWCeKw6aoY7c8/4t4zAfjKE
         wzhK+orOo8QfE83dRDx+MHZRippnSWoTY+EVaK/ZzGCRwNm9CF8hQqPtzK7BpTz3GhWA
         geDlABwUpsULzEApnnaboh64GnqslDwKPZhT8YRre/0khqec8gIk4JSkpKcp8VF3pTJy
         /MHHChLS3U/quFdqWTQSOYakmz3R+EBmekS6hYo4DLOCDA1BuKEfmvwkvhvY1rembpez
         xxNA==
X-Forwarded-Encrypted: i=1; AJvYcCV6grV3pCgjiKs0ZmH/txFlbtEm3tr/ZWs9gYmwsZDJUnioNLfx9oiDNxYZE4e4sBI6mDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4HC18Mn7bHUvFIgVIYb1rtDJj2vo976tdy1dEu7H2RmC4cgcX
	d2CEnyPvybmHpictkFqRWeZbonM4HpWnHaUXUKM8oecVKzj1m5lNbBDJRBrJIzqLARmvBhzYXlM
	HZsDwwgIB3AmMiPX94xFgWnSBTBDIYWtF+G5zXWme
X-Gm-Gg: ASbGncvypYmeb91B8KA/e1Wcu36uHiMOLE6ntzwcN1pSJgjjemjRcqvGzZf2crbrFPo
	wIWEhRYFvvl95a7HWtwP82uZ4OHw43lLLcZ1NIhgzSHn4wwsU208U8xHlG9YAHQjXX5VnlELYFB
	TEqaBlSO0ee0uH3UxEXT84+iBiCGkUqTtQ8bxFiDNG5FbrLoC69TOibrNew9tdUQ54BxNCUqdSF
	w==
X-Google-Smtp-Source: AGHT+IFnXDOFHa3mhYH2gzN7+DXpty3pkVkRbYJUm2hF3Btkmzwc6QS/7cxkEtVQaRcLoGHKssgYk+Sf5Ohq9SaiIdU=
X-Received: by 2002:a05:6102:4585:b0:4e5:8d83:c50e with SMTP id
 ada2fe7eead31-4e73616269fmr3053464137.10.1748987701736; Tue, 03 Jun 2025
 14:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-3-blakejones@google.com> <aD9Xxhwqpm8BDeKe@google.com>
 <CAP_z_Cj_8uTBGzaoFmi1f956dXi1qDnF4kqc49MSn0jDHYFfxg@mail.gmail.com> <aD9sxuFwwxwHGzNi@google.com>
In-Reply-To: <aD9sxuFwwxwHGzNi@google.com>
From: Blake Jones <blakejones@google.com>
Date: Tue, 3 Jun 2025 14:54:50 -0700
X-Gm-Features: AX0GCFscGBoWh-HQp20CLzl7V2idOwD3hN6O2fQxMHUnyvVWw0sFKDosABnxZx0
Message-ID: <CAP_z_Cg+mPpdzxg-d+VV5J9t7vTTNXQmKLdnfuNETm1H40OA+g@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf: collect BPF metadata from existing BPF programs
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

On Tue, Jun 3, 2025 at 2:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
> > > IIUC the metadata is collected for each BPF program which may have
> > > multiple subprograms.  Then this patch creates multiple PERF_RECORD_
> > > BPF_METADATA for each subprogram, right?
> > >
> > > Can it be shared using the BPF program ID?
> >
> > In theory, yes, it could be shared. But I want to be able to correlate =
them
> > with the corresponding PERF_RECORD_KSYMBOL events, and KSYMBOL events f=
or
> > subprograms don't have the full-program ID, so I wouldn't be able to do=
 that.
>
> It's unfortunate that KSYMBOL doesn't have the program ID, but IIRC the
> following BPF_EVENT should have it.  I think it's safe to think KSYMBOLs
> belong to the BPF_EVENT when they are from the same thread.

Hmmm. Is that documented and tested anywhere? Offhand it sounds like an
implementation detail that I wouldn't feel great about depending on -
certainly not without a strong guarantee that it wouldn't change.

Can you say more about why the duplicated records concern you?

Blake

