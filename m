Return-Path: <bpf+bounces-59031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56307AC5D29
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 00:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A201886269
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 22:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F72213E85;
	Tue, 27 May 2025 22:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOigM5Nw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD54224FD
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 22:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748385105; cv=none; b=tBOlXa+Yr5kAezAl9yCsVxgKtg2vClg76Ab/wrH8vvl7UL1ssEDGV+D4uw4IIiBXF/xg9k2BZRuG/No4Dnnhtfye2UYxewz0QvQSUFZNpj43iHaiD2gmNW24Lp3Jn8xTvSAf7DuGxSn6uLbkyV9jIrfd6pLO70BCpBGcD9CiNIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748385105; c=relaxed/simple;
	bh=CxJl4cUKSsgoiZiMz6gG2CehKypLS/DntlfQpsq4fDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/BmhK1hA7zVe6HqFeRFZ02AfIDbV1viMG9cRIcfVj56EfdIx0KKheKejCSWCRoEUV+RcoHGBL6MumhWSn9dH0k7mTsOcKX3AkI8ypMc5vZnImg2+8Bvu2/FK4E43blprxuYk9pGTkRbNh1h3SgzMKur4/3d8x6y21n4PkrwWY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOigM5Nw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b2d46760950so17070a12.3
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 15:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748385103; x=1748989903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJR3sWU2OSMafwUn62SfkoInRM7IIv4FRl5iEm1SF88=;
        b=SOigM5NwCieF/JuXZZscCD3Z3dMCNSNN21Pv5lFD9tfktgIm3DSsJRKIJ7R164O6o4
         L+9K9e1uElT/pYAXYSxk6SrEmwf9jOtL8FWXx8DXS8wdkutz26sS6gOMqY5QjPsxMNsB
         IuGo39jRYNaDq2kHx4SfACXXAGkPJF6zF6Zef0qk+BSw+4G6f7neIfl9yXiP4cK2hu4d
         7FkgAC0MAizLsApooVPa0Udfv15JZPfUMVBv+nHs6rZekAYN/8af3OHwkj0GekfMcrLC
         WRIBQyRlln+7j2VQivSxQsaE+hskOiv/gGoJjM2tZW44U5sFPUp7YBKlJiVWpu9Pzl7U
         vZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748385103; x=1748989903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJR3sWU2OSMafwUn62SfkoInRM7IIv4FRl5iEm1SF88=;
        b=honvv2YYMs5zXI8Yt6Qa/rOMlgjHLFpAs5sfHSeQENnP2SJE1i9i9L5tOSGKavi1aV
         qfkGUiASdgh1eKNF4d5NUY+8k7VAOe1TkmB97zrhAeZS7h+OsUTGIiISFeJewfG5PjnJ
         dENaz9XvikjMbiGjPfqmbNgt1t+czb55Xy1wem31KPwd2iFvzDnn7c3aeitXpRMqStqr
         E2j4cpBfgpehmtC8OwwusOKilYnfq7+Kroc4z1pGyWDX311R3E1GX5m0VyJ5unPAxHw3
         8g0GsAYUJ4999C0sRWngGKbGII9N63qqRx3HfgxDautT07zB31B2h4E2GrUdeoFZqcZI
         aJ+g==
X-Gm-Message-State: AOJu0YyL6XqyNebnloNgTrg/kOOqrbaeIwepe/Yt6P+ldgrPYKkww2Xv
	Hb8QXLfV/ggFljFVLu4SkIG0J+qaAipCvbSKaOxKvfItn5JnNTKNY6o2WbR2VASSQnXDKinmq0C
	ThHvExT1sOLXNKOlgPJh1IQoQv55e6oo=
X-Gm-Gg: ASbGncsQ/S7LTcSocEeY6NORXleI2QXw7gNAuc4PfAtY3/kCph3m9PbKf+aTuhw5qYe
	034Rn6PKnHF5EWgJC61zEGEtFEn3Q0A93+VjUMBwJbkVXIyECudTASRVob4X67iepIvdGr6N8lO
	/1zsCUOl4zbhlhrjkfDZKEYTUbkxEJKZGnoQASXymKVxs3+Qg/
X-Google-Smtp-Source: AGHT+IGFX9usl/qy3C3IijS76H4brybnDrNm3wV1k+65zmPKmviNbH9aFPBIeifr6fH7/aspnOqrIfBtJNmzXKIqTvA=
X-Received: by 2002:a17:90b:3e8c:b0:30e:9349:2d93 with SMTP id
 98e67ed59e1d1-31111d41d4fmr21710912a91.28.1748385102789; Tue, 27 May 2025
 15:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526162146.24429-1-leon.hwang@linux.dev>
In-Reply-To: <20250526162146.24429-1-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 May 2025 15:31:12 -0700
X-Gm-Features: AX0GCFv0f2K_xorHfN-nPqdQeqgZoGfJNnUY_gDd8dsEltafW3NKJaMb05-Kpvs
Message-ID: <CAEf4Bzb69wNAvLZ_55vzsZ0Co7u+g=JD85OkodWuYsG-uHBz_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Introduce global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 9:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> This patch set introduces global percpu data, similar to commit
> 6316f78306c1 ("Merge branch 'support-global-data'"), to reduce restrictio=
ns
> in C for BPF programs.
>
> With this enhancement, it becomes possible to define and use global percp=
u
> variables, like the DEFINE_PER_CPU() macro in the kernel[0].
>
> The section name for global peurcpu data is ".data..percpu". It cannot be
> named ".percpu" or ".percpudata" because defining a one-byte percpu
> variable (e.g., char run SEC(".data..percpu") =3D 0;) can trigger a crash
> with Clang 17[1]. The name ".data.percpu" is also avoided because some

Does this happen with newer Clangs? If not, I don't think a bug in
Clang 17 is reason enough for this weird '.data..percpu' naming
convention. I'd still very much prefer .percpu prefix. .data is used
for non-per-CPU data, we shouldn't share the prefix, if we can avoid
that.

pw-bot: cr


> users already use section names prefixed with ".data.percpu", such as in
> this example from test_global_map_resize.c:
>
> int percpu_arr[1] SEC(".data.percpu_arr");
>
> The idea stems from the bpfsnoop[2], which itself was inspired by
> retsnoop[3]. During testing of bpfsnoop on the v6.6 kernel, two LBR
> (Last Branch Record) entries were observed related to the
> bpf_get_smp_processor_id() helper.
>
> Since commit 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper=
"),
> the bpf_get_smp_processor_id() helper has been inlined on x86_64, reducin=
g
> the overhead and consequently minimizing these two LBR records.
>
> However, the introduction of global percpu data offers a more robust
> solution. By leveraging the percpu_array map and percpu instruction,
> global percpu data can be implemented intrinsically.
>
> This feature also facilitates sharing percpu information between tail
> callers and callees or between freplace callers and callees through a
> shared global percpu variable. Previously, this was achieved using a
> 1-entry percpu_array map, which this patch set aims to improve upon.
>
> Links:
> [0] https://github.com/torvalds/linux/blob/fbfd64d25c7af3b8695201ebc85efe=
90be28c5a3/include/linux/percpu-defs.h#L114
> [1] https://lore.kernel.org/bpf/fd1b3f58-c27f-403d-ad99-644b7d06ecb3@linu=
x.dev/
> [2] https://github.com/bpfsnoop/bpfsnoop
> [3] https://github.com/anakryiko/retsnoop
>
> Changes:
> v2 -> v3:
>   * Use ".data..percpu" as PERCPU_DATA_SEC.
>   * Address comment from Alexei:
>     * Add u8, array of ints and struct { .. } vars to selftest.
>
> v1 -> v2:
>   * Address comments from Andrii:
>     * Use LIBBPF_MAP_PERCPU and SEC_PERCPU.
>     * Reuse mmaped of libbpf's struct bpf_map for .percpu map data.
>     * Set .percpu struct pointer to NULL after loading skeleton.
>     * Make sure value size of .percpu map is __aligned(8).
>     * Use raw_tp and opts.cpu to test global percpu variables on all CPUs=
.
>   * Address comments from Alexei:
>     * Test non-zero offset of global percpu variable.
>     * Test case about BPF_PSEUDO_MAP_IDX_VALUE.
>
> rfc -> v1:
>   * Address comments from Andrii:
>     * Keep one image of global percpu variable for all CPUs.
>     * Reject non-ARRAY map in bpf_map_direct_read(), check_reg_const_str(=
),
>       and check_bpf_snprintf_call() in verifier.
>     * Split out libbpf changes from kernel-side changes.
>     * Use ".percpu" as PERCPU_DATA_SEC.
>     * Use enum libbpf_map_type to distinguish BSS, DATA, RODATA and
>       PERCPU_DATA.
>     * Avoid using errno for checking err from libbpf_num_possible_cpus().
>     * Use "map '%s': " prefix for error message.
>
> Leon Hwang (4):
>   bpf: Introduce global percpu data
>   bpf, libbpf: Support global percpu data
>   bpf, bpftool: Generate skeleton for global percpu data
>   selftests/bpf: Add cases to test global percpu data
>
>  kernel/bpf/arraymap.c                         |  41 +++-
>  kernel/bpf/verifier.c                         |  45 ++++
>  tools/bpf/bpftool/gen.c                       |  47 ++--
>  tools/lib/bpf/libbpf.c                        | 102 ++++++--
>  tools/lib/bpf/libbpf.h                        |   9 +
>  tools/lib/bpf/libbpf.map                      |   1 +
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  .../bpf/prog_tests/global_data_init.c         | 221 +++++++++++++++++-
>  .../bpf/progs/test_global_percpu_data.c       |  29 +++
>  9 files changed, 459 insertions(+), 38 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_=
data.c
>
> --
> 2.49.0
>

