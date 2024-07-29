Return-Path: <bpf+bounces-35903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF5493FBF9
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 19:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE5C1C2254C
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCC415ECF9;
	Mon, 29 Jul 2024 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdogiUql"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E25364A0;
	Mon, 29 Jul 2024 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272479; cv=none; b=hrDr+oF4jRaMd35OuICAZYUiPcdfIL8Xwl+83B9VIe/TOGzBof1QE0/Wer/tZrwhQhpmmIX1y7pOT+H+oWyBwwzggCrEyw/OTAv/1wJEgzGSCZus5Suem2mXemJ8AfkEZGNHRilXWCEsGXs51bxdwU4565Wt6XMWYwnyVRzHDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272479; c=relaxed/simple;
	bh=qDSKFsisGTo2TcreSFK6urZot9t+rg6BkL5ojzwAhaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEVSBGaOQoHH7AOLwPspgwe+pwyArGF25hA5gAur5iHD2vUpQyuTwW1AYD7IenLT7xqSFDgPg8v5gogR4Xcdr0AhbOmqgHQVlmuxMXvqZvLuLU9gDbj+2GuPZRZ7rBI5x/qP+G1mdCV6zaYOwmUFxxvynmxXUzZXE+aCdnSURsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdogiUql; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-75cda3719efso2043400a12.3;
        Mon, 29 Jul 2024 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722272478; x=1722877278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulwg8EYmfwLnMsG1oGOeX5RHdM/9qljFwXwWi6Iyz7s=;
        b=TdogiUqlG/H+dXaW3qh+kg/mwtSMT/atXJSGdIJkCH9f9esv1lapvx4JZAsvLWWBqD
         zMsSf4ik6DFRf0A/qGd3b7RvKnQgRPMWnvSEO/YzN7LY7s7g/0X3w1tVFnaGAioggNzq
         8OvB5nFrQsWj1XV5Sa69gBeV1ads1D/ij4TrV1EyUw4vZhCuK896pEUlE1khCHinyGLW
         lQV/wdy01VXYCFvCuSRLUeh5jdIni0xlwDENMKL3mDku19W4+PpQQFVzh80qkRA5FqIh
         5+5c1PKiyN+63AA7JkcuWebbPwK3SFC0Ye5R5SViru0d5E6DWEaiYwV6qm0Xuz3hxyPg
         uPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722272478; x=1722877278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulwg8EYmfwLnMsG1oGOeX5RHdM/9qljFwXwWi6Iyz7s=;
        b=unTdSV2xkHWNqcfX6a2XbBVrN8unw/h09uZLfpF0gK8CuBkRqBX8UHiZx9E/tl1GYG
         QiTwGLMoR5mtm1MLlyQABCTrEPm1oRFW+YxxqbApeawDRHeTVNl+SfhFNEy4auMxI3bi
         SnbPLtYSpC6TQdQWX4XzDkUSyrxAmCJPZav91xDGQ4PgzNY72w3dT+OH6YEAEuDm58F3
         0BDjDZsBt/CfMMZW5PLkT4pGIevj+FeonIYKaNgi15SN8prcaTwYqxyxTyAUde3eoGaH
         U07KORbu8u78d15gfJYjEj4o2IFrG6LehTJVpsBGgGXEp6nBL2tIjUmJQqEpWc9pUtfp
         ynRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX50TUxrX4NzgCoZ+Vm4dqKnwI5ZLo2+MYXse9W2SZ04rpEpBPsvjP98AQz9BE1WzWvH2sRHOeMzbRweDtPRHiIfn3zdWhLU5216q2+R6E0xGI2yycooi7TfyC78GQJ/jDMk0OBi9sd/OofTrywdUxuRoDZnYUpSm519NZhhC2ZTmVmMA==
X-Gm-Message-State: AOJu0YyPlXcYYjEa7c4t/ry+zyjGFINEwT8yLF0Ls9MINjnFzbxLTLBL
	6Dq2sldrJxw+PCITIhCB3BKPaCurhmzJVWLQtfBzPpJgDlSyQFO0V6a1FDEwuVOmqL5Q0m122ie
	j1huIpCQ8znW3DhWphJFIipBcU38=
X-Google-Smtp-Source: AGHT+IFTqEjDKZA+9G7QWRlUcQeCE5GeWrGYeRAQ8VWWBfJmrsxarmH2VdDAKOIuNe0W1o1bgIPLEdYbsZgB1Wn6iQg=
X-Received: by 2002:a17:90a:930f:b0:2c9:9f06:bb2f with SMTP id
 98e67ed59e1d1-2cf7e1a1d9amr6259304a91.6.1722272477624; Mon, 29 Jul 2024
 10:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com> <20240726-overflow_check_libperf-v2-2-7d154dcf6bea@rivosinc.com>
In-Reply-To: <20240726-overflow_check_libperf-v2-2-7d154dcf6bea@rivosinc.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Jul 2024 10:01:05 -0700
Message-ID: <CAEf4BzZ8MGa8Ywp_9ztJh6naywqtfrbeGWs4=izw-e-p4GGxcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] libbpf: Move opts code into dedicated header
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 9:46=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  tools/include/tools/opts.h      | 68 +++++++++++++++++++++++++++++++++++=
++++++
>  tools/lib/bpf/bpf.c             |  1 +
>  tools/lib/bpf/btf.c             |  1 +
>  tools/lib/bpf/btf_dump.c        |  1 +
>  tools/lib/bpf/libbpf.c          |  3 +-
>  tools/lib/bpf/libbpf_internal.h | 48 -----------------------------
>  tools/lib/bpf/linker.c          |  1 +
>  tools/lib/bpf/netlink.c         |  1 +
>  tools/lib/bpf/ringbuf.c         |  1 +
>  9 files changed, 76 insertions(+), 49 deletions(-)
>

Nope, sorry, I don't think I want to do this for libbpf. This will
just make Github synchronization trickier, and I don't really see a
point.

I'm totally fine with libperf making a copy of these helpers, though
(this is not complicated or tricky code). I also don't think it will
change much, so there is little risk of any sort of divergence.

[...]

