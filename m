Return-Path: <bpf+bounces-50665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD648A2A828
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 13:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A961887FAE
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 12:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FAA22CBFE;
	Thu,  6 Feb 2025 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afJId/se"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C9E1DF24B
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738844077; cv=none; b=SA9WuKVEEud7r9Ew8d9Qm5Ubsf2mVridxkaFgmhAEyMHN012u/VF9jF/jCmDkBr/hInhROQrBB3y5mOKMk07LSHcMpnnPGIgvHc2GfmOH4NQYRSqEw7/5flUMiRjC1fZfDrJTe6LP3/DOVE5PbpSHSSQ4rZovHj0LkBEWF01jVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738844077; c=relaxed/simple;
	bh=6h5AwGMys9zK2HA6vbkeEKA1Dxm9wGUl4TEy9CWAXBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pd459paWavfLXnnumZjKvviTyH5yF4E2mxkKghvYxexoxa/UGP/rbQOcC4rqwR6ekYphhb2qImQt+b3RPUrgmkkNudyrtxUD9GxGQqCNKYWq2IWrmymjhSClMvj12VQNG5SQodpueeDnZ/yn5u4VVtySRswagd+gY1+lFyIwLKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afJId/se; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3cfc79a8a95so2511005ab.2
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2025 04:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738844075; x=1739448875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLaKjVVjKg+Y4PfzliY95JkLoYcUNU6nP3q6CMT+aDA=;
        b=afJId/seXNZf502Z76qVMMrFtihGkbhD3ZEE53hCpMQizysa5hCD8mIaTJnE4G3OhU
         tzhGd/I3ik/1Rwr5/+SNhaINnCg7tnOhutqwZ4U+5ahzXQ3zkMuldZyM5QVBYZcPb1fj
         spBX3aMpzxhHbq10PZ3D/aZMCxR/TXTZEBwVty+xSoRhtUBvYzGLL3J1Sj/a6IdEKUKk
         kBOD+Gsh8zhcKiXcO3aHmyiQZiun5q01w6LUieGVn0GUXnIWwgFiZCcyqWyUzfDSfjpd
         VHSd9PPKW9GxLHOY6V360VJH0mEWJ8blGjAvHMtOfAeq7OXOYkif3UL+p1lTuomnKwcg
         MsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738844075; x=1739448875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLaKjVVjKg+Y4PfzliY95JkLoYcUNU6nP3q6CMT+aDA=;
        b=phQbQof6jzZDV8tpU6jBmiIDA7fPnATa6OaxuMTP/I06k2W1NTgRKTg6JatYRFvZ48
         WE9s0eISdJejFkdV1Wb6L0Py1V7J3+ehP+KqvnyKkdJAilrq1GgY+Lp6XAxJy+vlmBJ2
         2z9wqM0RHT2JjmX5To0uKgqrSIoghDPpJKzMoBJa/GhCdUiLhINB0I90FC78R3MM01LL
         BMurNCC9Y7OzAPjOMSkGK4SyXUmmaEHUubd1pqCnfDOvaS24rFWJeQ5StvaWVcU+E/dq
         n/Txy1IYpqsIppjp8L/di8Q40qDupkQI6C0TaHQhg2Z4eTk+auyJvaHsMGL8us+4V/Db
         J23A==
X-Forwarded-Encrypted: i=1; AJvYcCUDcMGvr2u0JY3ahgByk0cKNzHI5wYEkwwvVTlAdMvBk+WrJh9DlK5mr/lSWjQNfbMPbH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk5mHUo5iicghPF/xV9u5tPKBV4tRXg9vinvlzP1fqeclSrE1D
	XSBjxlY6SIUMqlSwrmnxk/S9M13hV2YWj6/u5Y+Ye6CNU8o9NXcH8IESiDYsgaAip37rETFJPLe
	uyKT8/9YTpOe2L3q2cPK0iJ36/h8=
X-Gm-Gg: ASbGncsOF6DR5RDQVYTwfEHYUew+AcbOUWjiN1QEENRvOIbqAoY5mGdwkP9QNQ8CPcg
	7BDWeiORmjqWF3yar15X2bYXWUck2RZ8b+sGr2vDYbbsHZ4BzdiEZta9p3B97zjaf9GFwWF+f
X-Google-Smtp-Source: AGHT+IHz3MShV1+cA2ZYB8jl+3vI1/uVEgyNAme0VNrC6VG+7CD2fkTp8DYa+KNiP4GNmiIUwXBZiVEQ34iM+SA4/1Y=
X-Received: by 2002:a05:6e02:1fe1:b0:3d0:4a82:3f40 with SMTP id
 e9e14a558f8ab-3d04f427d4fmr64939865ab.7.1738844075107; Thu, 06 Feb 2025
 04:14:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204023946.16031-1-kerneljasonxing@gmail.com>
 <81c94bf316ea2971f3454e32fdeae4061919458241f6f4c2c80cb0f20d06f144@mail.kernel.org>
 <CAL+tcoAUKArVkV_O2nv-D_K8qiRm6W3YkDe8=rUrGbxUxJmqmg@mail.gmail.com> <e937be5a-d0c9-4d80-9835-c5a2be0e6003@meta.com>
In-Reply-To: <e937be5a-d0c9-4d80-9835-c5a2be0e6003@meta.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 20:13:58 +0800
X-Gm-Features: AWEUYZlrmfRx-40rfCnqh2kDhREKnsUspG1eX-Kn2_4jVjq5FtNivSqmteI9SIE
Message-ID: <CAL+tcoCn0Gvk+KcaPv_f_yG83jwrb6mkVGsZzdL3EpdWVGbA3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/2] selftests: fix two small compilation errors
To: Daniel Xu <dlxu@meta.com>
Cc: "bot+bpf-ci@kernel.org" <bot+bpf-ci@kernel.org>, kernel-ci <kernel-ci@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 6:21=E2=80=AFPM Daniel Xu <dlxu@meta.com> wrote:
>
> Hi Jason,
>
> cc bpf@vger
>
> On 2/5/25 11:56 PM, Jason Xing wrote:
> > On Thu, Feb 6, 2025 at 5:28=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
> >> Dear patch submitter,
> >>
> >> CI has tested the following submission:
> >> Status:     FAILURE
> >> Name:       [bpf-next,v1,0/2] selftests: fix two small compilation err=
ors
> >> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?serie=
s=3D930276&state=3D*
> >> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/1316581=
6880
> >>
> >> Failed jobs:
> >> test_progs-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/=
runs/13165816880/job/36746357575
> > I'm afraid this has nothing to do with the series?
> > Traceback (most recent call last):
> > 5288 File "/tmp/work/_actions/libbpf/ci/v3/run-vmtest/print_test_summar=
y.py",
> > line 85, in <module>
> > 5289 json_summary =3D json.load(f)
> > 5290 ^^^^^^^^^^^^
> > 5291 File "/usr/lib/python3.12/json/__init__.py", line 293, in load
> > 5292 return loads(fp.read(),
> > 5293 ^^^^^^^^^^^^^^^^
> > 5294 File "/usr/lib/python3.12/json/__init__.py", line 346, in loads
> > 5295 return _default_decoder.decode(s)
> > 5296 ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 5297 File "/usr/lib/python3.12/json/decoder.py", line 337, in decode
> > 5298 obj, end =3D self.raw_decode(s, idx=3D_w(s, 0).end())
> > 5299 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 5300 File "/usr/lib/python3.12/json/decoder.py", line 355, in raw_decod=
e
> > 5301 raise JSONDecodeError("Expecting value", s, err.value) from None
> > 5302json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (cha=
r 0)
> > 5303Error: Process completed with exit code 2
> >
> > Am I missing something?
>
> If you expand the "test_progs" section right above that, you'll see:
>
>    Caught signal #11!
>    Stack trace:
>    ./test_progs(crash_handler+0x34)[0xaaaad4e05bfc]
>    linux-vdso.so.1(__kernel_rt_sigreturn+0x0)[0xffff85106850]
>    ./test_progs(+0x45874)[0xaaaad4a25874]
>    ./test_progs(htab_lookup_elem+0x3c)[0xaaaad4a258e4]
>    ./test_progs(+0x45b74)[0xaaaad4a25b74]
>    ./test_progs(+0x4646c)[0xaaaad4a2646c]
>    ./test_progs(test_arena_htab+0x48)[0xaaaad4a264f4]
>    ./test_progs(+0x426258)[0xaaaad4e06258]
>    ./test_progs(main+0x694)[0xaaaad4e080a0]
>    /lib/aarch64-linux-gnu/libc.so.6(+0x284c4)[0xffff84eb84c4]
> /lib/aarch64-linux-gnu/libc.so.6(__libc_start_main+0x98)[0xffff84eb8598]
>    ./test_progs(_start+0x30)[0xaaaad4a1faf0]
>    /tmp/work/_actions/libbpf/ci/v3/run-vmtest/run-bpf-selftests.sh: line
> 26:   101 Segmentation fault      ./${selftest} ${args} --json-summary
> "${json_file}"
>
> The infra couldn't parse the stack as json (rightly so).

Thanks for the reply. I'm surprised that this error is related to this
series, really? Could you point out why these two patches cause the
segfault please?

Thanks,
Jason

