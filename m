Return-Path: <bpf+bounces-58746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B421AC132C
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 20:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBD417B250
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 18:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D970A17A2FF;
	Thu, 22 May 2025 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1MwTBHSm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07B318A6AD
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747938004; cv=none; b=QOhCewrH6MXmsUpXGkeNYJV7pg1HVhNVQvDm/872x2ZhfHW3d28zUaDFd6OASkvvdonmNaHtN0jlZ5LYXwq3INyPKfyskd0m6bqlC64xOWArmvrp3cTOef5g0zS+mmIkorKxBERxsjPvehFk4pM9cCkv6WCqcgJomCcN5vAaNTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747938004; c=relaxed/simple;
	bh=1X1PfimKgGxSYNptMRYntUWCk2oprV8ZT6Liq06yiX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKXQJ+BCpykOkZDUSmTLPmwhxhGX7YuSAfEGjyoYtIXrIw9tddrrBPZ+OXY02aLVFBbIECg86iCf6k1u0VhrRjC2slxLkGjPHd19wJZmtpNIaHAQjq0J0sPQcTThfnVN57NfVR0bIv+JRw0u9rFHqmLpajfJxjDd8rafINCQ860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1MwTBHSm; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-52eff44a661so862338e0c.3
        for <bpf@vger.kernel.org>; Thu, 22 May 2025 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747938002; x=1748542802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1X1PfimKgGxSYNptMRYntUWCk2oprV8ZT6Liq06yiX0=;
        b=1MwTBHSmIKT/HtCiz8l1tT03S5LkGkTlYbdLVX47ZodJMcNC0ime3oonsoXYjYKf8n
         zY4aZWfHtV3vsS5Fqhe9f9XwNDnSI82p1s9SdLkcTVpRV9hCck4ijQhUhl/35uZVbK9N
         oWmYDsKOzYUd0Yj3Q/M2ckNmrk0Y8rAAY3tMgoyHyvVae4/38NY2XbvNeyo99chdr7Ej
         E/jOmT+eGTCwF5tSIZaiZIcOq33/yMbQjJJtbWE8gI+b3dpwxrT+ADu4igc4M8RbpoBJ
         N+JRwLR8Cih44BUB0kHHJYHo+AQbf8uNMkX5HCymR/WmAzdbJ+f3n3r7AOUAHpuzgAxX
         G3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747938002; x=1748542802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1X1PfimKgGxSYNptMRYntUWCk2oprV8ZT6Liq06yiX0=;
        b=j3+e3P75Px+T7qcyFoXkz+OHbKPilSolSgd84iLWmGWgBI04rZMj1zXocqFidekIXg
         ASSp78d0u/Q/CZBf4Pu9uJoR49DGqkoIOKLRcDKhxc6BdHLhkz9ij7K+AiQxp79RThYf
         ZWtYHdVrjjRkoqynUuZVaHLzkMYYKiARFA6tzJGQaOoYaZydVXVcKYfbh7SFOK0hpG20
         KB/hwiTbxQXJuw637wzjqP0iIVXz/e2Ot9K23JMO15l3pNcD9Zg7tieZwaCr+NIbkDlC
         VZY56ifPQk6lac3i3sX7FzFesTgnvlNwBxc1SLn9gTvKrey3zaPSYDQ453NMIoRfUnPp
         Sphw==
X-Forwarded-Encrypted: i=1; AJvYcCVlHzcEEJhk76/V+AzORtkOqv1LWtjd+hG98ZIkXISKV05W2WUaYznD2pbP7S4kMZyynpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHEhBIQQnA62d6t9cqTnJ27FFO7V8UQyaElR2j4UhSs3hdBA82
	ICTZcCbXgx6a2xWu6LPjiatvbBOESObO39eWvZLDyTUH392Orv4B5JqwBKQzHpHe9QIH/FALwDs
	lOj1QCxFibPYV9erniLZy+MLU84gFt0E+p+1H7vCD
X-Gm-Gg: ASbGncvb0fySjuUsbJD0pxC9YxG4KqeGbR8/nH79iXp4kH//iJk+vtSvc9M608bKYbt
	loWaytlRzRMknG6ZZQ/6Q/UXDq7rE91WY7cS3mtj9BSVvmgj7PLcMansKZwMBIL11NTetR4XtIx
	hNc77eUWBEPCmjrHCw+Yi+LMtXYro+b++zMeuakghIx+KUTvoRB6AwRgF66cQQiVyQVtcsYrA4O
	kpy
X-Google-Smtp-Source: AGHT+IEfN+I/C5Ybrmxr1qWevAFLAFonO1e5hjzbuNX4xDEjbOi3PdSdxPRofPaqo9kuaUkHrj/UIsRxp8SKA7jZji0=
X-Received: by 2002:a05:6122:d19:b0:529:2644:8c with SMTP id
 71dfb90a1353d-52dbcdfccb7mr20392929e0c.8.1747938001548; Thu, 22 May 2025
 11:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-2-blakejones@google.com> <aC9iF4_eASPkPxXd@x1>
In-Reply-To: <aC9iF4_eASPkPxXd@x1>
From: Blake Jones <blakejones@google.com>
Date: Thu, 22 May 2025 14:19:49 -0400
X-Gm-Features: AX0GCFvCecoYWZVTumub_yv2z4rw1y06pQ1j8hvSuiCvYMyPM1bOhtN7H-YE9cM
Message-ID: <CAP_z_Cg_vH1+BAm87U4gYQ0hDRGtHkkYb2DHtTRSd_QNvg3ZLQ@mail.gmail.com>
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

On Thu, May 22, 2025 at 1:42=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> I'll test this but unsure if this part should go thru the perf tool
> tree, perhaps should go, together with some test case, via the libbpf
> tree?

Thanks for taking a look at this. I'd appreciate your guidance here - I
sent it here because the other two patches in my patch set depend on this
one.

Blake

