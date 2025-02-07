Return-Path: <bpf+bounces-50799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80952A2CD0C
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 20:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3777A7A3F69
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 19:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1A2195FE5;
	Fri,  7 Feb 2025 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/vpbVTB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0220923C8CB
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957726; cv=none; b=YMo4cfikDNm2Pw/dVtrr9KPRibKm+xYI6FTVWVv9zVtOM7JNSTe+n+13ntIq1ouI48aNMKXD8gCPAlWuE3PegGNGm926scxxvGMMgnDmMv8arQB3fqomP299teNjRUHGQKHBrwfSuA8KpvWzpA3bZC5ATMhqWNThbllWgnqziMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957726; c=relaxed/simple;
	bh=BJ5lLRFOvNTulNImcJq7+FS7Ec9HsSngTA6h+9G9yxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXkE78h69cVXncmUOGy7JhvEjyvk5WlmfVEifsmk7ZfoFh9v7TAa9ky3UpkotXpS6sZmUjxSpjAL1viMQMk7C6RE9y9Vu7wjPhxi2joX+S9bZ49Kfjm44HLkY/mbvEQRih8Jylj8PY75EWc46LQfMjCS7xVQNudVBDSt/IUcrPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/vpbVTB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa2c456816so1369532a91.1
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 11:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738957724; x=1739562524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kb8Pmi1XA2CDlxVbSjrKqeQUu5L/teAkA/sUNwNJnpw=;
        b=V/vpbVTBU9PryDj3QFobp8Thklj+Jkwk0Nmr+5UTCBgEt71L7jGN0ynAWtCNeUSCHl
         yz8rixq81AUTP9h+BlXXaziNyFkzHhnnulvvO3KYTPNVCHy3cmTXasHXIp7KkmejkUb5
         AxpV7mrHESw+Cs/qDbfFaQoOmSMyOL11lBWIHqNcjL8uWZB1yFg96q8pM9Spgj1LsUCg
         VsyzRXQSuzvglUuMMga9F0rASRGXnnD0M/qMDDp284oAj7n+f4lsXSa0lXCPUjQdAyly
         yqEiiXKCvUfoIf4EgkncR55AhehkbpzDLW1Yc63fh1pOINXAVlZG/u1fcOK07IKIPp4D
         cPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738957724; x=1739562524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kb8Pmi1XA2CDlxVbSjrKqeQUu5L/teAkA/sUNwNJnpw=;
        b=aynngpSWIf7wuVJzxtEUf0KOLyVTiyx6ISqMewhP/pp7nbgZ8O645l5LzzK0n+Jwzy
         69i67dHbXjEZy4/WDgFwXUbaOkNZz9xtdKyF9XFJAkPFRsLZUu0sDauLx3h44XKpUNPL
         1UUvzSxdMwroN0Nm31CjxvxNoY5tqi2XhodzZfZu9exxq1wuw3RkufVrmlR1myxNxqCl
         sVLbnBw/0M6H12DwjB5/WUH+103zwhBlKjxvYv01RfhjBkoJMZTlJLmMBq66a641HTMe
         U1FiRZDIMswi04xrkVxomBbUO1RjB+dQvPEsj7ibKIC3wIPISMOcLVMUvZGPShJx5le4
         FrHw==
X-Gm-Message-State: AOJu0YwBtHN6Y954ALKYkkyPHKJj2R5lZl6ogkssAg7ZvOtXABbGthyF
	QYOuEnlsIeoI9ZgbvyedTrcXBSfANdfkkBinyWDAE3J4UHppZL6SuRaiyA5BQkfd+hPYl0IPEOn
	PHUnDsKUiYYtczc3tqWjnFOqNgK/AmuyH
X-Gm-Gg: ASbGnctKKCN8OZMy5iDHuaU3n9TZh0lO+Y+kjfgXimPRP5TEn52kH94Nw0rwNMCEUzm
	0EMMPyG/Uvq2/angTTcLk82ajAiLRM4MFwjxLYGQIsKwTJ/20oeXxe2aJDAgS/onixyOLQVoMIF
	YZSPMK13ww2fOt
X-Google-Smtp-Source: AGHT+IF9F2IZIGdFRimDbsMbHveKYa/69yl5PUTtIN8T1MGapeSswoEqj9uN1Rk+4d/3Ck+jpgPdfGjOID3JqVFRJCc=
X-Received: by 2002:a17:90b:4cd1:b0:2f9:d9fe:e72e with SMTP id
 98e67ed59e1d1-2fa24166e90mr7252434a91.16.1738957724115; Fri, 07 Feb 2025
 11:48:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127162158.84906-1-leon.hwang@linux.dev> <20250127162158.84906-5-leon.hwang@linux.dev>
 <CAEf4BzYXCQi4HMvegMmsx-ppxprwNVyKohJgka8gY_B+gMy+mQ@mail.gmail.com> <8e25e1e9-37a0-4d4c-8af9-c2d5e12af65f@linux.dev>
In-Reply-To: <8e25e1e9-37a0-4d4c-8af9-c2d5e12af65f@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 7 Feb 2025 11:48:32 -0800
X-Gm-Features: AWEUYZm9rsRL1r3G2StlH4uGoYkoPYnF0KOcpGxxPFmwC9pURlsI4onBWG31_o0
Message-ID: <CAEf4BzYeKcaYH8ZYpMo0XRyS4UYWaSZB5bMJ6FK0pUX1SUmgqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add a case to test global
 percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 2:00=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 6/2/25 08:09, Andrii Nakryiko wrote:
> > On Mon, Jan 27, 2025 at 8:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> If the arch, like s390x, does not support percpu insn, this case won't
> >> test global percpu data by checking -EOPNOTSUPP when load prog.
> >>
> >> The following APIs have been tested for global percpu data:
> >> 1. bpf_map__set_initial_value()
> >> 2. bpf_map__initial_value()
> >> 3. generated percpu struct pointer that points to internal map's data
> >> 4. bpf_map__lookup_elem() for global percpu data map
> >>
> >> cd tools/testing/selftests/bpf; ./test_progs -t global_percpu_data
> >> 124     global_percpu_data_init:OK
> >> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  .../bpf/prog_tests/global_data_init.c         | 89 ++++++++++++++++++=
-
> >>  .../bpf/progs/test_global_percpu_data.c       | 21 +++++
> >>  2 files changed, 109 insertions(+), 1 deletion(-)
> >>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_perc=
pu_data.c
> >>

[...]

> >> +void test_global_percpu_data_init(void)
> >> +{
> >> +       struct test_global_percpu_data *skel =3D NULL;
> >> +       u64 *percpu_data =3D NULL;
> >
> > there is that test_global_percpu_data__percpu type you are declaring
> > in the BPF skeleton, right? We should try using it here.
> >
>
> No. bpftool does not generate test_global_percpu_data__percpu. The
> struct for global variables is embedded into skeleton struct.
>
> Should we generate type for global variables?

we already have custom skeleton-specific type for .data, .rodata,
.bss, so we should provide one for .percpu as well, yes

>
> > And for that array access, we should make sure that it's __aligned(8),
> > so indexing by CPU index works correctly.
> >
>
> Ack.
>
> > Also, you define per-CPU variable as int, but here it is u64, what's
> > up with that?
> >
>
> Like __aligned(8), it's to make sure 8-bytes aligned. It's better to use
> __aligned(8).

It's hacky, and it won't work correctly on big-endian architectures.
But you shouldn't need that if we have a struct representing this
.percpu memory image. Just make sure that struct has 8 byte alignment
(from bpftool side during skeleton generation, probably).

[...]

> > at least one of BPF programs (don't remember which one, could be
> > raw_tp) supports specifying CPU index to run on, it would be nice to
> > loop over CPUs, triggering BPF program on each one and filling per-CPU
> > variable with current CPU index. Then we can check that all per-CPU
> > values have expected values.
> >
>
> Do you mean prog_tests/perf_buffer.c::trigger_on_cpu()?
>

No, look at `cpu` field of `struct bpf_test_run_opts`. We should have
a selftest using it, so you can work backwards from that.

> Your suggestion looks good to me. I'll do it.
>
> >
> >> +       ASSERT_OK(err, "update_percpu_data");
> >> +       ASSERT_EQ(topts.retval, 0, "update_percpu_data retval");
> >> +
> >> +       key =3D 0;
> >> +       err =3D bpf_map__lookup_elem(map, &key, sizeof(key), percpu_da=
ta,
> >> +                                  value_sz, 0);
> >> +       if (!ASSERT_OK(err, "bpf_map__lookup_elem"))
> >> +               goto out;
> >> +
>
> [...]
>
> Thanks,
> Leon
>
>

