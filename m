Return-Path: <bpf+bounces-59564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4503EACCFDF
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 00:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BAE1896871
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 22:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E500253347;
	Tue,  3 Jun 2025 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKleiVnZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0341A3029
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989790; cv=none; b=T6iXrhUtOAIKJNzpSyyuXahN0mNBKEd0zjqPqxvHXa2B0/fGrCWy2N5bWO9PTV0dKMoJaBsVlb50SCzxWB6osmR1ixHlHW3n55lPe0MbD4CjfkH5jt0jXggzpy+Fk3uFt1TwbdUHNIJfJ/HuKRCGQE8ETulNA8XR0VMhD6XxZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989790; c=relaxed/simple;
	bh=obx6t0Iq9Fqb+Yk4q/piTYUchNh3FoDpcFQeglz4Wnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YheVO9pJypXZlXXS019rQK5/kP2RcgNe2tJy72hHRRGyr8p5c6qbPdFBH4Ds/226o+cKfdR+EaLqLlBwAfzmtsadvAJfAKn2ylYct6vwaINZoJK6rRNQl9AfsjAiAK7WKDRNdMgrdhUe6/VIfAi4BskspYm60Q38Z2NneHpfJv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKleiVnZ; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86fea8329cdso3816304241.1
        for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748989787; x=1749594587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKVaKjXJurHA9ZAekYKiRbyeQwPJnSI/h2fCa1bHxCw=;
        b=wKleiVnZE3cPUlNd8Zg272RbE+9K7dJO9gLl9/S4pfyQsf+mbEiqimU2eejlVQHnSv
         0ASGq+Qhm+CBWTjaoX2GDs2GmPur0wCpKO5BBfakRbU4w4v7DYJrDJsUWxdmtG33eeAl
         /AjBOH1tUzO/dvBZuOjd/6v1RLcyrDazPwo4ZkHeiIi4gJnbRHbkVtjxJJN0+dgAdi5F
         FNT885YYAyxD02AozzezOMk+lNu5uYAq19ri2Fzk1+ZvC5pqcEvTBTPBlWrIX36j254j
         jYZFqVFJzhT7rdN3IG7tMe0yTN8C7Eaw1oR566gtHaycqnlLHTkRWqpr+Kjchl6PO7F9
         25Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748989787; x=1749594587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKVaKjXJurHA9ZAekYKiRbyeQwPJnSI/h2fCa1bHxCw=;
        b=V7ftEawzREMna6qRI5+JN+BREoBIaqu7B4XeMCZYqeVl06z2/xl5h4Dubi3v396CU8
         nKQ7YvmSE/c7fDTTIlKNkNtiPoSNc608EXETjdDiojC2mtL5F85cHclHjEzOZd/EqhN1
         p+JGX84BfC3FDAOR1ZY8mqMHfDOoEJjQKZH5g4HkDPXBIYBzkMa/sYZmwBQdw0/sVVtC
         N4SiytULgsXhkhh9mqvcvQrQPqVLSDDM6sfS2QdE30N5APFULF819tK+atw4QsGKYYS8
         BmoBgHz9Y/Ifn8YgsBsJoKyg1Zd+QtXK5uP3Ew7au1qqVfzN+7uhiVR/gz3ZjojyNU9/
         Rt+g==
X-Forwarded-Encrypted: i=1; AJvYcCX49C29L9LJDz6gi7clSG6yXD0GFTdxpnigxRit4F1bvwlN7UVZo6GjvD0jp5BRryQFpTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoUPj3Frxd4hN2orTAf5vO40wcbRr8UXG59lPDEgDNQxuluxmw
	AGPxBmLUgb63WhNQ0e0h9dZ/jr7pp+dQzYQDMmuJiqUFJn36AuO91SX2dOoTvClAumL2LlZo3is
	2WPSD2JP9SrCxzpWWN9b5hwGHvvKOv7v+PB/In4mH
X-Gm-Gg: ASbGncvZdBW6QPgjecWhLe9fQ5z/C9ZIcKLGeKTlW7xjpocBWoAI5krJG9j433p+rQW
	Oxv8FzeX9VvUeOGHsM4c4VLX7X9XtX/ke7ohpm+kS7K7hKtx+vrG8iXJ7fkd/HxbaEXRwgothO/
	EBAls3XxODN7msBAJd8erZeBfr1oHsCg2/LCuLf7uzILygS8HXs5PigwR10RsTLJ0N0oLDA8XD2
	g==
X-Google-Smtp-Source: AGHT+IE1tHJ6ImcX1sMkuaqX3ipjnfleszUjJzXakmrAq8/3s08WHgfz64NjDqS1QJpEocJDC7pgBF/VLgAORoIVvEw=
X-Received: by 2002:a05:6102:1481:b0:4e2:91ce:8cad with SMTP id
 ada2fe7eead31-4e746f83a08mr252818137.24.1748989787010; Tue, 03 Jun 2025
 15:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-3-blakejones@google.com> <aD9Xxhwqpm8BDeKe@google.com>
 <CAP_z_Cj_8uTBGzaoFmi1f956dXi1qDnF4kqc49MSn0jDHYFfxg@mail.gmail.com>
 <aD9sxuFwwxwHGzNi@google.com> <CAP_z_Cg+mPpdzxg-d+VV5J9t7vTTNXQmKLdnfuNETm1H40OA+g@mail.gmail.com>
 <aD9yte49C_BM5oA9@google.com>
In-Reply-To: <aD9yte49C_BM5oA9@google.com>
From: Blake Jones <blakejones@google.com>
Date: Tue, 3 Jun 2025 15:29:35 -0700
X-Gm-Features: AX0GCFsJchr322pvzUFRGDLm7UM_vm0tFyi9bmhjl2ify06b_OVX6aiJN88-0Ck
Message-ID: <CAP_z_Cg0ZCfvEFpJpvhuRcUkjV_paCODw2J61D3YQMm7dg0aGg@mail.gmail.com>
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

On Tue, Jun 3, 2025 at 3:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
> > Hmmm. Is that documented and tested anywhere? Offhand it sounds like an
> > implementation detail that I wouldn't feel great about depending on -
> > certainly not without a strong guarantee that it wouldn't change.
>
> Good point.  Maybe BPF folks have some idea?
>
> Anyway the current code generates them together in a function.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/k=
ernel/events/core.c?h=3Dv6.15#n9825

It certainly does, yeah. But I don't want to have that become another
instance of https://www.hyrumslaw.com/.

> > Can you say more about why the duplicated records concern you?
>
> More data means more chance to lost something.  I don't expect this is
> gonna be a practical concern but in general we should pursue less data.

That makes sense. In this case, it will only show up for BPF programs that
define "bpf_metadata_" variables (which is already an opt-in action), and
the number of variables a given program defines is likely to be quite small=
.
So I think the cost of the marginal increase in data generated is outweighe=
d
by the usability and reliability benefits of being able to match these even=
ts
1:1 with the KSYMBOL events. If this proves to be a problem in practice,
it can be revisited.

Blake

