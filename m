Return-Path: <bpf+bounces-28382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA1B8B8EC1
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 19:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1F42837DC
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2C3179AA;
	Wed,  1 May 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGNZSerO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C114A81
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583154; cv=none; b=Q6HWn9Y8F9E4NWne0ZPcNfgri48mDxGHnBwFM8KnigyyJGr8UlGO/5hivINC0HxMm86+PMx6MPcoOFyW3fIkCJOZInt41Z9fHwDSMUuuE4OpDdZZaLJtrGHtBi+ChXK4jElMCegh6VHAZNBU6PS+S5jmFuxad3uWnoV8ZOqrWk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583154; c=relaxed/simple;
	bh=w488y0KjoRoM0wIfbWD5CrWhubEUi2Dko5psnZQ3xn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTXsPpnKTyJHtBOIK1lGD+RFMAlwr/j+aZrzimA8nS/+LNr9gY3BI65CXEjYnZ4A4kwqplbx8sbfiFkj8Ya3P2MfRfFI3fDfsFohd5VvNhzxpOVnWCOSAT3GsuE8fRCivlS+t41wFbfpM65F8EyWKvfIQ+08gODE+DNhzCT8DRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGNZSerO; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b37bc39decso181697a91.0
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714583153; x=1715187953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRW1VRs0YG+Yn80dISI+3W5L9h36VAX7lOD5uNIkTq0=;
        b=MGNZSerOEJIpK2kwbTMpNF0fUxxGWk2GHA9PeHh4OcRQTW9PPvNXLlD/7g0TwALWYQ
         k9nWkWnZID0W8P/s+ktrjHioQx800ZjK7cBWJwbs4oHNaB8e9oXKNJUSm7XTTgxS+OeH
         AhU5c0yJC5ze0J0kJ5bisMTWn683PD9DsmVuYOFfJ5/dI3mC4VRMznPEjB7Bkr1z9EX0
         Pvz56XY+g/kZrXfpoa2a2b49e/4uxv1V+pyvBRcwBYb2jdmo2Y0sFEAzWHmytz0VYpId
         l8GrMZo5FcF0KSdF7JtJAaGmFhrPuF8HKrQVDd2uD+1VD/KifQl2pxLvUBKwZCrnYRU8
         9PwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714583153; x=1715187953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRW1VRs0YG+Yn80dISI+3W5L9h36VAX7lOD5uNIkTq0=;
        b=pjKkGznEgh+2aYfL2pOOlc7t4vX8kiBPiOvqCeFgPvu86xtGn2Fqai+14RAVK0hKPX
         xishHKGoQwNZs/qeG89y3/jQvyrDTCbur4kvqOnNy7CK01DFrKCKCmbKIGJMZ9c8ZmmK
         6OU+OEDF5HWQeF+rTWqug8sL39H+Fd07jNIdKeIkA8cFgcxvw2fS1a8gsDng+kSr9N/M
         YAyRov3HQ/+1h2NMCtN1q+Nd539CrB0Xdlp7sphd9d4zjgDrNy7TOhyUPpNNKGNkc2BY
         Moj7Vt90hpYZ2u2l+TY2XgVuh/Sg9MmgAz/311ICxamGjsHeuwisq31oSnXHYwFIyFwI
         scEA==
X-Gm-Message-State: AOJu0YzBqqVDrSRPxXartb/V7m4ybBR2beC/Trc8JR+Q5N+krKaxpTAb
	ptoyDmrHVrl0uvUrAddrkFyEf4jehkUfTpMXzw093TsY1yKrEQAFYDgdM/vj7Di8zZoHwXlBrlv
	qen/6yoCu4MEa3mWyx5EwoJqdw7M=
X-Google-Smtp-Source: AGHT+IEns11fynvoLAVzxwIq1/t9o9IjnkBjJZT3nNnOVA1oU7V+m0l5I+no4G4ZZgwsoJqPU447CrKdbx6sDQrk4ik=
X-Received: by 2002:a17:90b:2e86:b0:2b1:74ad:e243 with SMTP id
 sn6-20020a17090b2e8600b002b174ade243mr2501506pjb.24.1714583152771; Wed, 01
 May 2024 10:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429213609.487820-1-thinker.li@gmail.com> <20240429213609.487820-7-thinker.li@gmail.com>
In-Reply-To: <20240429213609.487820-7-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 May 2024 10:05:40 -0700
Message-ID: <CAEf4BzYha=c8_JRMHBooYX-ny5aqmNUKc0now1OkqteXVOBRGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/6] selftests/bpf: test detaching struct_ops links.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com, 
	kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 2:36=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com>=
 wrote:
>
> Verify whether a user space program is informed through epoll with EPOLLH=
UP
> when a struct_ops object is detached or unregistered using the function
> bpf_struct_ops_kvalue_unreg() or BPF_LINK_DETACH.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  18 ++-
>  .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   1 +
>  .../bpf/prog_tests/test_struct_ops_module.c   | 104 ++++++++++++++++++
>  .../selftests/bpf/progs/struct_ops_module.c   |   7 ++
>  4 files changed, 126 insertions(+), 4 deletions(-)
>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tool=
s/testing/selftests/bpf/progs/struct_ops_module.c
> index 63b065dae002..7a697a7dd0ac 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c

this file is a bit overloaded with code for various subtests, it's
quite hard already to follow what's going on, I suggest adding a
separate .c file for this new subtest

> @@ -81,3 +81,10 @@ struct bpf_testmod_ops___incompatible testmod_incompat=
ible =3D {
>         .test_2 =3D (void *)test_2,
>         .data =3D 3,
>  };
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_do_unreg =3D {
> +       .test_1 =3D (void *)test_1,
> +       .test_2 =3D (void *)test_2,
> +       .do_unreg =3D true,
> +};
> --
> 2.34.1
>

