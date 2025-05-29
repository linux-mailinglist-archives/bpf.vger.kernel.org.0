Return-Path: <bpf+bounces-59225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 791BAAC7537
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 02:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5091C00D30
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 00:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF191AA7BF;
	Thu, 29 May 2025 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V8SAI7VF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145F119259F
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748480326; cv=none; b=c30Equf3ndjTzZRNXC5p77+I57zvu0YxPK0yo1BRU6s8Rrlo0aCZW8dlJyrdlmOYMFuiRnY+Wz0mLs5OTdlcuqo6fflOyeAQAx5J4VZsmP67cOnWJln8vmaDCsKjQ0qWWnNuXsURP2O4mr1R6vvMzesijRxPS3+HgiMEV6IrcgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748480326; c=relaxed/simple;
	bh=3LJcOgM16Q1j+9Th1SFZvDmY147GM4KkX2rAr1YfKhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKHu9H0ocet4LExlSML5qv1kgYFkXK2RAMVRzRiDo1ExSnX6n+aNv2XEFUv89Uelk6HMR7LuPmOpdFtiFYb1ruV0ZJWYVUm3A3MyVCJZtWtCBW8a+mOKDKo8+AyzS02kE6hApFc/fm9T+JIc+hIjuFm3LWNctV0BN58BW6xyr/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V8SAI7VF; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-87e049bb3e4so172639241.0
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 17:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748480324; x=1749085124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LJcOgM16Q1j+9Th1SFZvDmY147GM4KkX2rAr1YfKhQ=;
        b=V8SAI7VFlPtkPbyc1dL1gjfXp12iNxY/O7nkWcdeSjTl/YcfVPiLQpk9HH1R1gB/lS
         Wkbf6qRz1mKeF9Ddi8zlrJYonyniXGkF72XVGahic1jKgOtMGVN+pOD6OpfxEJ3sssDE
         1x48JlAdlty5tUZm0WeBJvGiZAkxYVmxuY9ZrnUQRtbVfSU7rZbnqJQUcEYQ3toZA4Fl
         S711KAzkr+GfJTlcbDTzhAETuRin8N1BV53/sSrAHqR0WlmB9bpfcb2pQgByJ2MXQyik
         Xp1/07GlEGJ18BMp6lzx+Yn8RWSmmc2HUI8Eko/50s7M74snfEUrFegh+STKT869tRqh
         3DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748480324; x=1749085124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LJcOgM16Q1j+9Th1SFZvDmY147GM4KkX2rAr1YfKhQ=;
        b=IAD2bFTIfqDcOBwIy37ug38iK28Y9mGo9p+xUXlnLL1y9tVhJEzmQOYE4PionkCmN1
         CFQNuZjJ7w/EOUgzO74lLywUhYydkVJRRMGHnwskMLsmp64vPwKsKwd88xD7IYNdIlEz
         thiXjzZyJrFVCkF4xMAxGknDjtFKQMxnY2w5nKfnFRmdOq1SVzSXDJEPIr3hizwwkGsx
         agdoMffuJxkMOC/6PHL0aDjym2hRAACuNAjzHQwBHXaAvULD6vuNpwcjsQHflhB7j+Mk
         1y/DpXrc3qQJfoDiZ89KlpSwlLPAG/BwNuaLTXAXTUftSpGUrF7mI3kPUn4bsbfkwhMm
         Mauw==
X-Forwarded-Encrypted: i=1; AJvYcCUtYiVWFQjOraFcA7ex7eSWKHiUUfK31FQTnDLBjgh8KZPOhLPzT766+4YDZgS9Q+VNehc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGN/XlesCIaOB5kMEVdgW675cp5nO0DZiLk1b1CJnhVla15o/2
	pR2MU94z86cULcKzxvP6PZkBtNaLWZuhBz20I2C10uaflSj8NQM0NfkeXGo7vxGo0zzYqLB3BBX
	aUnQYWu7pkHs6+rJ0GChIXr3cgALh0AXBSpDXTNH4
X-Gm-Gg: ASbGncvU23BCsvSF2Ob4FcBcAd/1EJLWdeoeFEu8Y5NDSqCO+HByFnPPuzIErQrKea/
	5YBmW31P2o5FaOa1ymbQxrzJh1DSOZaxwRYO5XDbo2qygjor89M9mvSruShyvM4gD/Zvtu9Kyd2
	8S2wt7++lOe7OxrHcQ6ngxuWuVKFHPLn6OVd6SNiHfFy8=
X-Google-Smtp-Source: AGHT+IGwx4Uty5er2IzIySgycdil2fOJygTTHKMBF3mM9M6iD5H+JXzX07+IWyvy/kC9EeuCYaOM6quQ4vt7XbW+weA=
X-Received: by 2002:a05:6102:2927:b0:4e5:a309:85da with SMTP id
 ada2fe7eead31-4e5a3098731mr3876448137.7.1748480323519; Wed, 28 May 2025
 17:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-2-blakejones@google.com> <aC9iF4_eASPkPxXd@x1> <CAP_z_Cg_vH1+BAm87U4gYQ0hDRGtHkkYb2DHtTRSd_QNvg3ZLQ@mail.gmail.com>
In-Reply-To: <CAP_z_Cg_vH1+BAm87U4gYQ0hDRGtHkkYb2DHtTRSd_QNvg3ZLQ@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Wed, 28 May 2025 17:58:32 -0700
X-Gm-Features: AX0GCFusfVzOe8iNeRt_7LeEPUEcrg67_QANaTma6IA3CsaAZ6gVZ8V4ecXjgtQ
Message-ID: <CAP_z_ChErhmooT5rhyXH8L-Ltkz3xdJ7PG20UKDpn9usMUgqTA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf: add support for printing BTF character arrays
 as strings
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
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

Hi Arnaldo,

On Thu, May 22, 2025 at 11:19=E2=80=AFAM Blake Jones <blakejones@google.com=
> wrote:
> On Thu, May 22, 2025 at 1:42=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > I'll test this but unsure if this part should go thru the perf tool
> > tree, perhaps should go, together with some test case, via the libbpf
> > tree?
>
> Thanks for taking a look at this. I'd appreciate your guidance here - I
> sent it here because the other two patches in my patch set depend on this
> one.

Do you think this can be merged through the perf tree, or should I separate
this patch and send it though the BPF tree first?

