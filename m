Return-Path: <bpf+bounces-19814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCED0831958
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 13:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DFC5B2592C
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6820424B3A;
	Thu, 18 Jan 2024 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3G7En7M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09BF241F6
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581789; cv=none; b=bGkcqgKc88wr3O05EPXxDrvT7y/SJU+GFDOTrZM4zOcE8n4AkO1rkVRKcG0iZfSMly8EE4KcSxmjVu7SOMF21ql+wDYRAeuTSBYmRe/KpRiNmhrpFeunngYK7ArD6Spf8SjW3g8kaLOKg7UyUM8vfuY2N/XcVoa1QWTnEnU4WLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581789; c=relaxed/simple;
	bh=B1Nf/vU/Se+9W0oRiRjq0J//P3cWBuYHw+HeArK2m2Q=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=IiGglRKNahPfCibUjBHJ1EUsS6c3QoW5GKVEWbL5pLY9SVDoPPaqYRLwpJbFnXnJhexZ8xBRftYEKof1U3xC/BC1pS5YyhyhjXK5WSNg6XJA0wwi7cxXHJr7nMPrktFRRAgfb59hq29M+BWbFBdiImsH9NH89Zht73dOdj+CdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3G7En7M; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68196a09e2eso1034816d6.3
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 04:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705581786; x=1706186586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxIVWgzDWtzaZFVx/bD8zY3/b6ddBsH8xyvi8dh8Bsk=;
        b=Z3G7En7MJKn/Q1CsLJwQXiCqs5/qloUS1ZLc/jtUV48e8lYhogDuzeiOadSoAelnbF
         fj9luhNT1THooMbK4I6wOxxtc3uLyXe/bmkDrJtSOCtm71AA1dhLko93P5ymFkbZMe5J
         Si2v2Q4VxPwtrI/gjv4I12C0hwGxSDU6mUMgGwqBohhbKNVkgATNowIl85F9iORVZ15L
         c8Yw6YmxDEZu3AZDIqXKz5ztmDfsaKrcqlPCnAU8yRj1yCSCxDwUsgAZilnLGvKWNzsk
         zwcJaSvfbBG8Golug+i3cEyzhbCtQSkjH4O5/LGB2FRBf95iLOMkKhXHjyyX/EhPgxIe
         tIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705581786; x=1706186586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxIVWgzDWtzaZFVx/bD8zY3/b6ddBsH8xyvi8dh8Bsk=;
        b=pBGk4efljZ/Rn/Q4LqbdoOKszK3xe3gvH/AbNsH3Jc7iZPhEDgl3WfsYPqUvAQ2HpQ
         qWlRz9ZbwG2l4N1gch2R7ZZMPNDekdfAl/SzhRS/PBWO1T54UsrphgrGI9ldck9O3VRm
         z1V7MAW7Rn/0V6OiUHHI5K94xr+PucByCevq8k/F0Nx0PtRldnZbbLJuF2DdaYJavJEL
         svQKM9WswNFpbwxPsx5CWiMft07Y8AAvtvx33ZQwrZI5gEE8r6jXdc8Ff36ahbPREcuo
         ufZ0bYOCaDmn5xZvOf0FDVxmCIT3sNeLEmz8t4L/8oD01CJM1wlnFg/Rf7BmPOTKuCng
         WMJg==
X-Gm-Message-State: AOJu0YzSOn/BirFLV8UEpm3DrZqeOYBHk2V58+c3EM8hw9jDhRwhzW4P
	ND8fs41rg7+06weQNXJGBogmIR4ZR3Wr+MlsQ0myc09amky+x5Jue7aS6xBKjHqgpf82Jr6NQS5
	JWMOUkRSNBSPvGPFWIFzkC/maAKs=
X-Google-Smtp-Source: AGHT+IGoLCYTaNal5NiBZeOsY0c+gkGTxGWspO2TcyWBdZXfPfkx6sjkNSjuGX5NdDu/+DpFM6fCQVIjov2nwxNT6c0=
X-Received: by 2002:a05:6214:1d09:b0:67a:b419:530f with SMTP id
 e9-20020a0562141d0900b0067ab419530fmr722382qvd.9.1705581786491; Thu, 18 Jan
 2024 04:43:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118095416.989152-1-jolsa@kernel.org>
In-Reply-To: <20240118095416.989152-1-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 18 Jan 2024 20:42:29 +0800
Message-ID: <CALOAHbD6B+xG=Cn1za8QKf5MvodM7xUDUxkuM7YT-0emhh2e1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] bpf: Add cookies retrieval for perf/kprobe
 multi links
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 5:54=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> this patchset adds support to retrieve cookies from existing tracing
> links that still did not support it plus changes to bpftool to display
> them. It's leftover we discussed some time ago [1].

Thanks for your work.

bpf cookie is also displayed in the pid_iter [0]. After we add support
for the cookie for other progs like kprobe_multi and uprobe_multi, I
think we should update this file as well.

[0]. tools/bpf/bpftool/skeleton/pid_iter.bpf.c

>
> thanks,
> jirka
>
>
> [1] https://lore.kernel.org/bpf/CALOAHbAZ6=3DA9j3VFCLoAC_WhgQKU7injMf06=
=3DcM2sU4Hi4Sx+Q@mail.gmail.com/
> ---
> Jiri Olsa (8):
>       bpf: Add cookie to perf_event bpf_link_info records
>       bpf: Store cookies in kprobe_multi bpf_link_info data
>       bpftool: Fix wrong free call in do_show_link
>       selftests/bpf: Add cookies check for kprobe_multi fill_link_info te=
st
>       selftests/bpf: Add cookies check for perf_event fill_link_info test
>       selftests/bpf: Add fill_link_info test for perf event
>       bpftool: Display cookie for perf event link probes
>       bpftool: Display cookie for kprobe multi link
>
>  include/uapi/linux/bpf.h                                |   5 +++++
>  kernel/bpf/syscall.c                                    |   4 ++++
>  kernel/trace/bpf_trace.c                                |  15 ++++++++++=
+++
>  tools/bpf/bpftool/link.c                                |  87 ++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++-------------
>  tools/include/uapi/linux/bpf.h                          |   5 +++++
>  tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 114 ++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----=
----------
>  tools/testing/selftests/bpf/progs/test_fill_link_info.c |   6 +++++
>  7 files changed, 204 insertions(+), 32 deletions(-)



--=20
Regards
Yafang

