Return-Path: <bpf+bounces-58223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6EAAB747B
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 20:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51F38C1361
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 18:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D093D2874FE;
	Wed, 14 May 2025 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvBQYwN2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01841F5858;
	Wed, 14 May 2025 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747247827; cv=none; b=c30U55+63snB/OS1VnfqoVGGkI10vEtj4Zt+2h2VdfNvh25LqQI0Lj0/Tb4Pr6MocYi0blGwC5TYX1bfqMk2q+7g4mEvYBqgl8MuT4LBybn2UzRIBY3JIprbE/OCMpX9+rOWMnQYy9JTS9LvM/AHqRkaBLst27VcUIhf+Lhf4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747247827; c=relaxed/simple;
	bh=uimuqd5TYxgYSY4PXQAcWQjPjDgH0e6mrBnK4ICLVbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nR2F6+xXzwnQrLfM3DdeS7uR+uGaFNbaYx0DKu/6xusWBFz0zMF8FpT4JlfJ3s/MdX5UJzfDp7RK1LF13ZOYiZwOLuTE+/yw1kP0BZocCdgxC1HNngJhsGT722BT32x6Cc0m9o9gJX2YvoZPu08/m5GIHKCHSsAkiUqu5cUW5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvBQYwN2; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e78e53cc349so172099276.0;
        Wed, 14 May 2025 11:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747247825; x=1747852625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aoqhKHToZJNLInb2W9y02HMea5hmHPrr0YQL1zkaTk=;
        b=NvBQYwN26XOBGQA6TFhc+aR8VDM+2hHG3xeb2VIgAfbFg4KfIXOuHNKsJNIn4P1Vx5
         MwBB5zndflTCdzsXLCKktz8m/r4eVHDuIdX0FCnDnMt1RlHoYuZbjAwnK9GN25IWXiVh
         AXi95xr4UcULwIyVVfSD1F23ksL1SJlEqemDOA1YQrDE8FQbxc9cZ9BrUTQ/69wzF0nh
         UJughksKoj2hjYtwiU+1JTzuwK8mNZF0vudWjWafmfKnJT9x+AHAcuzy//TwGExqIwJZ
         CCyWgB0elx3QInnCdmxJok5MirEf8BVKIPbkrUj9NK+uBOacNL26O2bQGG/iUd7hU45l
         f4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747247825; x=1747852625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aoqhKHToZJNLInb2W9y02HMea5hmHPrr0YQL1zkaTk=;
        b=Z4uZvx5bNTgAKs+4uzovIATRxRP1HgbLo33+lDeeh4GVJcWf4W8igVN/w3pkGQbxGX
         AnGUUdNTB6Cp1CR4JB3Jz1BiCWYZXEEiZTidhQPYpxfMqy98VCBXcU3vosnzkdWKH0ml
         qJsTBURmAS/aP5nQOMQq/wEAdXgTNMmBVgAE0LdSvA+dbfyja8zKWHyWgZtotLTwl04E
         2XfTGpBZKnezuK6kyJb/HvbjXHeOp4LtXOSxUzxxG18o0Fy5iXCe9DO4ZhybrmEHfOH6
         kjjuUV7Ol8r6ENv+tJ+ZrbHxiVpFpl8j8FExq5er1CGanVW5gGMBHttr/UArw0FmuNWD
         JTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIKynQuRuBfulg4JLbuXwt0ONFVN5UE68J/RxWxUg7SuUwszsr3APxP4exPhKDgY3My01MkCPbfh1sYZx6@vger.kernel.org, AJvYcCWfsKZZ5ciWJGxRS72B6sJ9IWWm+ank8e6lyhCfb0A/Ix8tmqPO6nYhphl04M8U5m+4hkQ=@vger.kernel.org, AJvYcCWh1pwX4sr5x3v8WVKSSeolO/CEja/JA5EYzKp5ILDq0v06fM/gAEB6oo4b+Hy53lxdc4kiqvWewDHXfbu6KcvYTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZn+l8HLY1xkINl1gvSSlnLcCTE/pHLdOuUBcOAiY0GxRPM07I
	Vy7k2JYl3H3iLNmy+YT3+UpobJGwubz4OLOOIJvCOk8id7cO443dJGFtDHu2mk1aLSerPOxlJGw
	qVvzdI+6sxfPz3NaN5uMqZ2d05dQ=
X-Gm-Gg: ASbGncveSyBtAUzEL+/w11hCdYoLKVvuLxcxOK6/PjRIofRKc0vdg1SLRAZDSXVNgLr
	FgQhMmguF7bK+1ifzCqxt+aBWAQOG8hfAdm5VFXVxizGRQAXlWfetexmIFaRXnhbdINvgUsY5Bl
	vXXJGJnUjZn9H5BuMxNcWDncQCLypAeo4=
X-Google-Smtp-Source: AGHT+IE2/g9rnBObpRMcLm2xbMhUC+qCNsdW0PUpCcgGda6q10fg87NIM4Zc+3pGRZQejq6FLQGowhplH2qEUiYQ3yw=
X-Received: by 2002:a05:6902:220f:b0:e79:fa4:1439 with SMTP id
 3f1490d57ef6-e7b3d4b8f24mr5027511276.9.1747247824771; Wed, 14 May 2025
 11:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430060616.18576-1-namhyung@kernel.org>
In-Reply-To: <20250430060616.18576-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 14 May 2025 11:36:53 -0700
X-Gm-Features: AX0GCFvO-7e1w_qUUN99Igxc3EhqMZNNjrz7vvV6GJxlPrnHZBL0cq_wVOLY23E
Message-ID: <CAH0uvoi_-xSCuL9VfMNWCiqc3kir1FMBmoCG_-jDtMbOtFmY9A@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Split BPF skel code to util/trace_augment.c
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

It does not apply, probably because the cgroup patch is merged
beforehand. Can you please rebase it so others can test it? Otherwise,
this patch looks good to me.

And sorry about the delay and breaking the promise to review it within
two days...

On Tue, Apr 29, 2025 at 11:06=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> And make builtin-trace.c less conditional.  Dummy functions will be
> called when BUILD_BPF_SKEL=3D0 is used.  This makes the builtin-trace.c
> slightly smaller and simpler by removing the skeleton and its helpers.
>
> The conditional guard of trace__init_syscalls_bpf_prog_array_maps() is
> changed from the HAVE_BPF_SKEL to HAVE_LIBBPF_SUPPORT as it doesn't
> have a skeleton in the code directly.  And a dummy function is added so
> that it can be called unconditionally.  The function will succeed only
> if the both conditions are true.
>
> Do not include trace_augment.h from the BPF code and move the definition
> of TRACE_AUG_MAX_BUF to the BPF directly.
>
> Cc: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

