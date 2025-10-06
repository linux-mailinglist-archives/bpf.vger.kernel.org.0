Return-Path: <bpf+bounces-70457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA02ABBFCB3
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 01:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4269D3B27B4
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 23:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA981F7098;
	Mon,  6 Oct 2025 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpZ9Q2Ta"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F262F4C9D
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759794602; cv=none; b=XvmFzUsJf8CDr3v31ZUPTd35MTwVCBT76Y6KyedwFs42VI8m30bilCACM1QNQwRCtFgtP3nM/qoEz8n3DRtrgeHw31Lki2XSnHulF1SFeWMzyVeF3CZAVaVPU40RFDaOwqA9ik0gJDR0C+fd4bOwHTQ6DKf0lMI59HM17lKFdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759794602; c=relaxed/simple;
	bh=Frg97Fq4uajIhGaYVhla9zidwRrXNykyXR1JjYyg+z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHnFJL20KoTlK6CcdkfxDzXrFFa4IGUhn6iyGw8rMvXNVBLfIkMAe52QssBrwGzHySuOnpGt/9zgrd452ylyRK+XEeEoaiCNLD0m6bxckgmYnjfWfGLfIceHdJoqVEtuCYILXMn6ZbfKCXLn71OodlXIOA4gpXV2Ld/OxEa5u6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpZ9Q2Ta; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so5267802a91.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 16:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759794600; x=1760399400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LysSrkhQe45MCj8ye/Y2ATwg0W7hZbcLrsbkMER/1+Q=;
        b=TpZ9Q2TaR5j4rXsqQZmqF5OpCQUadC72gun8CPoNmK/sRUT0GheTeRAlXGM2AGDzWN
         6Ctx8iCk94Qf7AXVhDkNDGSadSO5vUkb7tW8ayFv9n0umPR/+8NYcsdm/1WMGLOxWBVy
         akz27V7amEagT+DDI6jDcFez0Zexbl3xwMuLGf1SJYShox7qDySnw20y41uPpJO5ub2M
         iuf+J7z3bM/9DYrQaYxN9KXLhK+m7CYmCYyMW+N1Aefes4hHB8Y1OV/EnJv1UFSsAiE+
         R9tchmADqgSIGO+wI+S1m/nldElRSMsgAyi6m/vewAz8dHu7kydRCvX7hONq9dUO7fIJ
         oDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759794600; x=1760399400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LysSrkhQe45MCj8ye/Y2ATwg0W7hZbcLrsbkMER/1+Q=;
        b=BC6hP3wR7nd7M/augpNBDuF0AoZFEEnEgWrLQDYXB7x01uLv4Yy2ZoGbQW2/WLfIj2
         z9clTVCiLlfJMMCSc0R6Vz4osZPWMBoP0Jth6GJH6n6gu5Hz4OZRN0zdUte+Cko1Y+be
         IunIkAKM0u4rGc2UM879IaX08vakk3N6n/FliuPLs1ZSf5ap0bQG9hXgJWvyKgIXEu3C
         5BWCg4iVkF7AnXfm2NJ0UOvKcEuZMXIxeyGGxA/mCGFjpPXjT9x7llqrfw2J9eR49ewj
         6D6TRwlk/Y6eSi0y8O+boXuU6729bpZXIt69h/JhVPBawVxrCj1kF/kZDgQPXOq6tvuO
         ck7A==
X-Gm-Message-State: AOJu0YwbHyFKyal0KVNtMERqWd/ZZCwZqUSXpPs9QOsLM0XM803B4SdK
	dJXYplKc9f0/Dou+zHPz4kpPtX22IgLp9BxoUKvw+ZmwbskQOq/7vMdoe82uT0tW8+p2fKwA3iK
	CN4oFZ7nMIQgZ/Mp9ngsjqJLahBac46txcg==
X-Gm-Gg: ASbGncuHBQMQbWNoAtbqEn8OX0HgRyHQy5mJVRxHa1SmPVq3T8+winOM3C+vz6AXi5s
	BrOlZBBXCz2LFYIWCrCvyeTyfLZYsuPSrAlpT2XKP4cb7r5xaVJ5WybWs/SA9shv98dUisX594j
	uhmPdFAYNASWMAjPpAwk8Yf9fndu78fgLTW594n4T8KFtJzcLQihs4VpYKM/ZpyJCBhffT56637
	U2GdDjmcCCWTa+iChs5/HRd7DK+/cNNaqT8RFH6uDb/H4U=
X-Google-Smtp-Source: AGHT+IHddk3NahzssDmCYIDCmIWkT88Vz5USNyoDWt9SNS2aQWp8yr6yLPqIBRKm3nzsc5rxvNJMtSEUrJ8wVOCI0+w=
X-Received: by 2002:a17:90b:3e82:b0:32e:8c14:5d09 with SMTP id
 98e67ed59e1d1-339c2707bb2mr17314105a91.7.1759794600039; Mon, 06 Oct 2025
 16:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006200237.252611-1-mykyta.yatsenko5@gmail.com> <20251006200237.252611-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251006200237.252611-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Oct 2025 16:49:45 -0700
X-Gm-Features: AS18NWBdl5lfsK1x5NfpUviXYvwp8rwCY6V4b5ndsqNBnBN5OKQ3ZfL2L8Z8q04
Message-ID: <CAEf4BzZYT-FdZLX0QmbyRAxJZEN11V=Q7KxiEod=gmzUn4ionQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: add bpf_wq tests
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 1:02=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add bpf_wq selftests to verify:
>  * BPF program using non-constant offset of struct bpf_wq is rejected
>  * BPF program using map with no BTF for storing struct bpf_wq is
>  rejected
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/wq.c   | 48 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/wq_failures.c | 23 +++++++++
>  2 files changed, 71 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/=
selftests/bpf/prog_tests/wq.c
> index 99e438fe12ac..13c124fff365 100644
> --- a/tools/testing/selftests/bpf/prog_tests/wq.c
> +++ b/tools/testing/selftests/bpf/prog_tests/wq.c
> @@ -1,9 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2024 Benjamin Tissoires */
>  #include <test_progs.h>
> +#include <bpf/btf.h>
>  #include "wq.skel.h"
>  #include "wq_failures.skel.h"
>
> +static void test_failure_map_no_btf(void);
> +
>  void serial_test_wq(void)
>  {
>         struct wq *wq_skel =3D NULL;
> @@ -11,6 +14,9 @@ void serial_test_wq(void)
>
>         LIBBPF_OPTS(bpf_test_run_opts, topts);
>
> +       if (test__start_subtest("test_failure_map_no_btf"))
> +               test_failure_map_no_btf();
> +
>         RUN_TESTS(wq);
>
>         /* re-run the success test to check if the timer was actually exe=
cuted */
> @@ -38,3 +44,45 @@ void serial_test_failures_wq(void)
>  {
>         RUN_TESTS(wq_failures);
>  }
> +
> +static void test_failure_map_no_btf(void)
> +{
> +       char log[8192];
> +       struct btf *vmlinux_btf =3D libbpf_find_kernel_btf();
> +       int kfunc_id =3D btf__find_by_name_kind(vmlinux_btf, "bpf_wq_init=
", BTF_KIND_FUNC);
> +       int map_fd =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "map_no_btf", s=
izeof(__u32), sizeof(__u64),
> +                                   100, NULL);
> +       struct bpf_insn prog[] =3D {
> +               /* key =3D 42 on stack at [fp-4] */
> +               BPF_MOV64_IMM(BPF_REG_0, 42), /* r0 =3D 42 */
> +               BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *=
)(fp-4) =3D 42 */
> +
> +               /* r1 =3D &map (patched from map_fd), r2 =3D &key */
> +               BPF_LD_MAP_FD(BPF_REG_1, map_fd), /* r1 =3D map */
> +               BPF_MOV64_REG(BPF_REG_2, BPF_REG_10), /* r2 =3D fp */
> +               BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 =3D fp-4 (ke=
y addr) */
> +
> +               /* map_val =3D bpf_map_lookup_elem(map, &key) */
> +               BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem), /* r0 =3D map_va=
l or NULL */
> +
> +               /* if (!map_val) goto out; */
> +               BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4), /* if (r0 =3D=3D N=
ULL) skip next 4 insns */
> +
> +               /* wq =3D (void *)(map_val + 0);  -> use r0 as arg1 direc=
tly */
> +               BPF_MOV64_REG(BPF_REG_1, BPF_REG_0), /* r1 =3D wq (=3D va=
l ptr) */
> +
> +               /* bpf_wq_init(wq, &map, 0) */
> +               BPF_LD_MAP_FD(BPF_REG_2, map_fd), /* r2 =3D map */
> +               BPF_MOV64_IMM(BPF_REG_3, 0), /* r3 =3D flags (0) */
> +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL=
, 0,
> +                            kfunc_id), /* r0 =3D bpf_wq_init(wq, &map, 0=
) */
> +               BPF_EXIT_INSN(), /* return -3 */
> +       };

this looks painful...

You could have used bpf_map_create (like you do here) +
bpf_map__reuse_fd() to replace the original map to force no-BTF map.

And also, we can just add bpf_map__set_btf_{key,value}_type_id()
setters to complement getters. Libbpf allows to override and manually
set basically any property of a BPF map, so this fits that model just
fine.


> +       LIBBPF_OPTS(bpf_prog_load_opts, opts, .log_size =3D sizeof(log), =
.log_buf =3D log,
> +                   .log_level =3D 2);
> +       int r =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", pr=
og, ARRAY_SIZE(prog), &opts);
> +
> +       ASSERT_NEQ(r, 0, "prog load failed");
> +       ASSERT_HAS_SUBSTR(log, "map 'map_no_btf' has to have BTF in order=
 to use bpf_wq",
> +                         "log complains no map BTF");
> +}
> diff --git a/tools/testing/selftests/bpf/progs/wq_failures.c b/tools/test=
ing/selftests/bpf/progs/wq_failures.c
> index 4240211a1900..d06f6d40594a 100644
> --- a/tools/testing/selftests/bpf/progs/wq_failures.c
> +++ b/tools/testing/selftests/bpf/progs/wq_failures.c
> @@ -142,3 +142,26 @@ long test_wrong_wq_pointer_offset(void *ctx)
>
>         return -22;
>  }
> +
> +SEC("tc")
> +__log_level(2)
> +__failure
> +__msg(": (85) call bpf_wq_init#")
> +__msg("R1 doesn't have constant offset. bpf_wq has to be at the constant=
 offset")
> +long test_bad_wq_off(void *ctx)
> +{
> +       struct elem *val;
> +       struct bpf_wq *wq;
> +       int key =3D 42;
> +       u64 unknown;
> +
> +       val =3D bpf_map_lookup_elem(&array, &key);
> +       if (!val)
> +               return -2;
> +
> +       unknown =3D bpf_get_prandom_u32();
> +       wq =3D &val->w + unknown;
> +       if (bpf_wq_init(wq, &array, 0) !=3D 0)
> +               return -3;
> +       return 0;
> +}
> --
> 2.51.0
>

