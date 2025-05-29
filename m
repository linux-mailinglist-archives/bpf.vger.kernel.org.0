Return-Path: <bpf+bounces-59336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3246AC8578
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 01:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD1216C11D
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 23:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A803257458;
	Thu, 29 May 2025 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5B1HEW0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3122512C3
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562612; cv=none; b=b6bq7bkc3KQvlZVhhNTiN3qg4dtWfGUBFETnKGCJfxVRoo1fp38yrYxoAVWihazbx1CK3TDTfCPqNDdxVJhMY+B4DSWaR65n63G8AXkeduKrbItLsGHFuHcYa+IbDaJa3lA7xQ8bgfxDayPfNWPfUpt+KCaqExaBacSxZxDU09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562612; c=relaxed/simple;
	bh=/jQS5XQrcSTiYiRSc/N6qNicSbjEH5tvMkYg0lH6Wq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZo+8c/ZFZCXT/3nurcNrsr/q6IRwXQYiUnaGYMrSe7A+XPA1E6fp8M2U8CwNcCD638QamEraK1EB9z8mETnMWGUuw1P1RCGvinSj7damWhDAxnH6oF+rMxMia80RLrbaKj8a5pDvnKdCYNJNFgDB/p/vaxOrHwTAu0aK2KsJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5B1HEW0; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e45ece38cdso1504495137.0
        for <bpf@vger.kernel.org>; Thu, 29 May 2025 16:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748562609; x=1749167409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jQS5XQrcSTiYiRSc/N6qNicSbjEH5tvMkYg0lH6Wq0=;
        b=G5B1HEW02erwdwrVBnU0j7QU3YNmjD8SJE4Infef6tDUNcPJ6erziSn3dZmvYwYa+l
         Tyraw2OR3WkLv3sJ2l3U/c7F0J6QzNYFWG6vtuASlCuS7CU4QyPTb7s+BhHZIbO92BUI
         i+iN9/NIdGZp3ig2wV5W7yfwoq0gFF4HVfQJCTwkXyapaDWBsen+oNK/N4TtT9nAQHyw
         /Lji2GaUwutmzguW/idrIQZG2kavcs7L28AadE35+tHjwYXuk7cFvAxPykZw8Pp44NXi
         EJv60MaSzjchHE7/m8tqCVoPoWARXuPz46coEj6wKnLxSZZwBdEFxf9RQhXWRcWHFGnn
         KKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562609; x=1749167409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jQS5XQrcSTiYiRSc/N6qNicSbjEH5tvMkYg0lH6Wq0=;
        b=pk6D7xBpKQl+tu1X3/TEif56/RAHb/hTML2yAMyaQYzk5QRIRqv9bOUFtkuzNjJG6i
         ycgB4JFGkxZIuAuoCfzC8d3wuGg2UCMly/q1y7dopgNdPOf3C/QvavrjpQjQ04YPiPLp
         gtjnLRMEnrLVUKooGmfNL8gfwbeWcq4PgNIwkgzFz4nw5DYtP9/708OZat3ne75qKKWB
         Q0sU7wIp6tLv9ColX/jPmAoEzU9n/PGukwi0iqYGawBddhFquRwiRKvNCbbjB4t0TXt7
         zd9CSvaNJ1U9/ydy2OSbtv/zq0+6XBRpv7f2OcLr2Zu/wKmDSzk4WRg2uQmjp+lTaCvT
         Varw==
X-Forwarded-Encrypted: i=1; AJvYcCW9JXte/uGC+MOlaGSIF+FazL7sgZE4H8EmuBlZAoJjaK7Lo4uWM394gscBZNvgFSFN/ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywte0p3iBWomuvUNtpGgSFGzgyyWjnWnsAg6Om6yvW23JvZTSZx
	A/gR2uK9VHFbkEkRnCW9Vxo+LTxoJ2FbkQcSXW/phUvwwiMTWJwU66FnjNT21BmXs8zng8fLE9k
	ehCyZcSllQaTfgZuaZWkDZL0JmgKwFrNQosx9pksn
X-Gm-Gg: ASbGnctZxMDBOPcvFQeGfmiHU7wrg6NxuRJVfcYjTlELUaiqq+OiAZ8RgAsH/gKmj7g
	FoZxRFr0kkVcluSO7ga+kuuqP/fNZnO1qNBRuyUhsPhMlLrDC2bxOxljFtVxZhnqaJX9PCrzK3S
	enbZIk0lefqOSpoF8CJh9D6m7xYt801OdwRW4d9qPkcUY=
X-Google-Smtp-Source: AGHT+IFt/ivTuvmPFrz20YmtJKKBjvwFbf5WtZzjBqYQF95rJUwlQrpq5rDMJHRKZAZ1A/zY+qqyl8WgCXnFzYIz3Uc=
X-Received: by 2002:a05:6102:f9d:b0:4df:e510:242e with SMTP id
 ada2fe7eead31-4e5ac0bc0e6mr7200256137.5.1748562608979; Thu, 29 May 2025
 16:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-4-blakejones@google.com> <CAP-5=fWZG-N8ZzRh6h1qRuEgFbxTCyEwGu1sZZy+YmnSeGgSSw@mail.gmail.com>
 <CAP_z_Ch2SKwVcSV7ffV1Lbp=6TuKLyofSs1gpfBPMf6mV9-wHA@mail.gmail.com> <CAP-5=fXkfVb4gwuSXr_yZMj8ctPr8LHs-Js7g9hP46dhkU_kQQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXkfVb4gwuSXr_yZMj8ctPr8LHs-Js7g9hP46dhkU_kQQ@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Thu, 29 May 2025 16:49:57 -0700
X-Gm-Features: AX0GCFtrqvEMNdjlMwMgn5_lFeqF78T2xXt27TWAAtlEFWOjsQdw1dn9gHfduLI
Message-ID: <CAP_z_Ci4X=GRJwKyUMUmypO-xvjuRUR-UPce5hzE_vPf2g_RLQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf: collect BPF metadata from new programs, and
 display the new event
To: Ian Rogers <irogers@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
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

On Thu, May 29, 2025 at 4:27=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
> It should be okay as you can compare the string against that reported
> by `perf version`. On my build in `/tmp/perf`:
> ```
> $ /tmp/perf/perf version
> perf version 6.15.rc7.gb9ac06abfde9
> $ cat /tmp/perf/PERF-VERSION-FILE
> #define PERF_VERSION "6.15.rc7.gb9ac06abfde9"
> ```

Oh, nice! I'll switch the test to use that instead.

Blake

