Return-Path: <bpf+bounces-45386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1DD9D5051
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 17:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAFA283000
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65441A2632;
	Thu, 21 Nov 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi2Satx7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7521A01C6;
	Thu, 21 Nov 2024 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204947; cv=none; b=KK16fIBRD0y6mfouWzAgzxqgKsVKcEoA/A91jamp/3ZzJtMYbxUj80erD3u+91mh3tDiEWrySthKwUvg9KeKLK9MqHuxIRgUFVrcD5QjhZm3seT1blcduti9aEj8m6yW8VsLes/6bgP1xwg18t/7ascwEXAA9UScZirAejGtbkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204947; c=relaxed/simple;
	bh=2bW8Wv0hCk87GdvB9hjRyJK87S+fSBhpJJqQaQcaTA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/ivv1rmtzz6XfPBbeIUv/LLkAe6AyAKW5czDJ6JwmTNKB89fU7dZOnbQq1hO1XPu5cF7kWZ7oBqfILHtwEXZFWqCY3/OvWiZT1n2KRx9iRBEmDOGSXAHJUbvOYpV5T3zxi/NYmkT0sMIGtaU838dn2SHuIBFhqvRHnNGum5i1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fi2Satx7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso9303065e9.0;
        Thu, 21 Nov 2024 08:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732204944; x=1732809744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bW8Wv0hCk87GdvB9hjRyJK87S+fSBhpJJqQaQcaTA0=;
        b=fi2Satx71fHcOHxP/Z4Qctc4qfSyPk6Ksgx1AKbtoEaHVFqlmKCAtnz4GkPooxr4KK
         O6T5sv5mN3WKIp5fzSuUU5pWTdm4ht0pvA/9XkBB7vDYJFjk7ZCs/U3ruC011B2dIhk3
         tAuVW6kfh+in9f0YTjg/Y0s2i1LpimcRKWMOVSRqI6dYuc2N938xyy1Bsyx/28cbUR84
         ElYgQkyddUvTHIf5+9Oek2YU+JNy+rc7gPK+X9v4Vw7uBpCYBJCcjmzQ8WQknZu3QZ4Y
         dEcS9nnZv0LzzpXoT+npPmadFwzJVlFeJ393mmNqxJxXdFhbs4LZeuEWDllOY/U7e3sh
         BuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732204944; x=1732809744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bW8Wv0hCk87GdvB9hjRyJK87S+fSBhpJJqQaQcaTA0=;
        b=v2IO3cY8gl0CdSZJ7Z4Ci5UxWUCuMWCTdxLpokQqYPOzVN3m+YQKn5w6muIpEb/eNT
         MXS6SVH3q8PTiRi4H4Lzd2mYvWa9/zZMoQaopTQt9PyZgYQ0iQv1XTDPBUd2rlanBSrS
         jN06shim+HgVPcMD7kxU7y6Ig4LOm98bIfqgfCnNd6BJiEZ8JSOY5ROCRwgP2ts9tPp7
         vX99SfgRJr7NYEraYD7dHBk6RJIkmAWvJPS42LARyVx5Ha0iwqno4Ac6mWOOYLDKIqBd
         6inAPwP6+l2kfuoqJoB2woyblLKrYOQCYgNqwfUEXZ6yfrwITsBbCyW3jdLhLt8/ZVw+
         I5fw==
X-Forwarded-Encrypted: i=1; AJvYcCUiV+5Dn5hQdeqy9ciUmVOJ0GReSCwPZ0YnSkuInw0HVhh1pXIrW9av9y4M+CGeywar6TFOrmjhg5jVyC6G0mRQs69x@vger.kernel.org, AJvYcCWM20PyxxqPxN4UYc2a+PLY2vtpk+Pghkxw7Ugq6ZPNtk8LVH34iGZrhxD1Qq1aYLFU7CY=@vger.kernel.org, AJvYcCWjk+roe0INmdGPQLJfTQ91ms3VetvunpvueZImBLCTcofVa7qNtjYqipLNf4Lz89j2f2SOM+uCEHzWI4GX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9X2WeaenP5+2md6MzspHKr/TXmWYDfJZE33lWkg1hGBUtKSYI
	bRQc/uaFFQQ/zw3tKSU8o/CzM6O8rYMRmt+p+fzH4KHI2xmpbOmBJto8HNEOINPFhoe7T6FTs/7
	8pq1pyzeH5q/3+v2wYNIqhFdbmKA=
X-Gm-Gg: ASbGncsXj2pgS044bfQXE6Gn1xBIvIWWk4+VeTUSyROyIk9AJN4/DDYLQP0RRUiq1PH
	uVOyaMMCoJfUtgO6HaLM9RLku4TltZTLd8pbT5pcHhYOqLxs=
X-Google-Smtp-Source: AGHT+IEzLUcr65YGaS31uSTluNq/pGiJ7InzkK/WpGhyanTNFZTNaaWN8JKdvdZPmgqcD7EwB6Pdwid0PHW/Htt7yX8=
X-Received: by 2002:a05:6000:410c:b0:382:51ae:7569 with SMTP id
 ffacd0b85a97d-38254af697cmr3977360f8f.18.1732204943111; Thu, 21 Nov 2024
 08:02:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-1-jolsa@kernel.org> <20241105133405.2703607-6-jolsa@kernel.org>
 <20241105142327.GF10375@noisy.programming.kicks-ass.net> <ZypI3n-2wbS3_w5p@krava>
 <CAEf4BzZ4XgSOHz0T5nXPyd+keo=rQvH5jc0Jghw1db0a7qR9GQ@mail.gmail.com>
 <ZzkSKQSrbffwOFvd@krava> <CAEf4BzbSrtJWUZUcq-RouwwRxK1GOAwO++aSgjbyQf26cQMfow@mail.gmail.com>
 <20241119091348.GE11903@noisy.programming.kicks-ass.net> <CAEf4BzbhDE2B41pULQuTfx0f_-1fn5ugJEdPpweKWZVJetCxrQ@mail.gmail.com>
 <20241121115353.GJ24774@noisy.programming.kicks-ass.net>
In-Reply-To: <20241121115353.GJ24774@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Nov 2024 08:02:12 -0800
Message-ID: <CAADnVQJJ0WS=Y1EudjiFD8fn4zHCz6x1auaEEHaYHsP15Vks2Q@mail.gmail.com>
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe trampolines
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 4:17=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Nov 20, 2024 at 04:07:38PM -0800, Andrii Nakryiko wrote:
>
> > USDTs are meant to be "transparent" to the surrounding code and they
> > don't mark any clobbered registers. Technically it could be added, but
> > I'm not a fan of this.
>
> Sure. Anyway, another thing to consider is FRED, will all of this still
> matter once that lands? If FRED gets us INT3 performance close to what
> SYSCALL has, then all this work will go unused.

afaik not a single cpu in the datacenter supports FRED while
uprobe overhead is real.
imo it's worth improving performance today for existing cpus.
I suspect arm64 might benefit too. Even if arm hw does the same
amount of work for trap vs syscall the sw overhead of handling
trap is different.
I suspect that equation will apply to future FRED cpus too.

