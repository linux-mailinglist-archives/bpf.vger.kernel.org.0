Return-Path: <bpf+bounces-28755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14CA8BD9CE
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 05:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E57A1F23347
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 03:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE20E3FBA2;
	Tue,  7 May 2024 03:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0UG18ir"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6405A93C
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715053365; cv=none; b=ahzQJD9OvNsIuKM252HpWIgB8TAEqmhuADw/TOuf+CZuQTmQc25Dbq33fLRbKfOdxjUCR5UT8qeZk7UfiQrvBLQWU5wcU/MdC7GxKz/pxPx2VSVilza/8lElDEPmVZC+W7PPU9juRbWuOyjsSgBblWuPHad6MTAhQwkuOCB9V1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715053365; c=relaxed/simple;
	bh=jryJTc7toY+M/Bs2xUtY3N+HVg9VI/viiBiu5SsN6jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpMRCN+qR9Lehl0Stn5bwtHjWlT7uyI380Xix6tsQxtLblP7u/zq8kk++vv5oKu2WCnIU82fmS+WyxKaI80z1rBP/Iz2FnDobkqn4NlmKmAyKn2te/nvEQJESAneA7mrYZwbS1R98VJenZu3YU2iYvkysNro5PNTHQlxlgKPXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0UG18ir; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-61eba9f9c5dso2153127a12.0
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 20:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715053363; x=1715658163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EU1SHjrKzQ9o28rRd+GfUpQeW0RaimKOb9nsfszMBs0=;
        b=O0UG18irYXRUkNEcenBsxfU4HzvbxwaLacBMyvtlb+kMSjdEmrXYEKxGbMY5/n/PvW
         69YkjU7bXuIif0sJ7jPiTBrUwDqDp/776hGZSD8/QlwyNd0BgbiZDO8od5RDMro5mCeT
         Q7gYOkuQ91E3SxHwyjheymoiZqQkuRifpOXZVWXi2VnZlFgkFQKffhDjpUce2qppTVIC
         0OBuF7taDBEoVIlwfwYeeVkL7oT+a8KfUD/uVkzWiRSUBB3NVv3ZYZan3wr97WAlU/8I
         qP/QkG9oB8HD8NcNhll+2T9bOj027YncPkc8wdxq/FvXe7O1LRlZedmQpNeiKcNVdESl
         7p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715053363; x=1715658163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EU1SHjrKzQ9o28rRd+GfUpQeW0RaimKOb9nsfszMBs0=;
        b=Y/d+9IlW49QlQxLyUOw3zDPWyZYpcQ4Bbo1IH4IDJCH1zo3w7xsfpjLgaWacCDu9Z3
         jdJelWjGS5Y3+SeTDSV6C0YvW8mutmAVvQazA7V2Nack0oVkk5bkut86fbJrh0LFI67a
         Z+5md+PtPoas1FijOdJkXlNFGieJTcvwPNowOgGtfz/hRTHZx/r7AXALUgDKHC9YVqK+
         9lBx28zJLmPoW3T8h8PvjCFEsK6JK5XQ6Zf5z8Q9XwbQfSPw/XHA4MgYgLKj3fXLf3Dx
         1+tQ5jdLOZS+Xa+tc2NjIcD5RehbegZOK2ZM4t7GGw/2J2VZcF0yR5Do6t0TVRPh7aJR
         5t2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKrVp2m3oZZurTBNfdMKXGBujIam/RUzFkz1OotyIrmVFAb1r92wojsshwa2MF8tX4MfTAwY0bAAet8aNSDbRuwcFd
X-Gm-Message-State: AOJu0YyO3/PmOTA39KpuBBKIK2K6hgyzHn+gek9dR+MUjha0sN5CVOfP
	gFTVtghDbIXHQ8qjF7Oue4XKZB5AUS5HBX3GneB5sKk3G+5vCvNA2V5DjfMIIftamIg9+UY1aGe
	nhYl1Co+tNFAppFFi/hMg2POetHEqmdGk
X-Google-Smtp-Source: AGHT+IFUO0GUQM9ng5dIGLphKpC93SqMjnDk5BFggmWXiExRz5CPjOmiaRf0ivgleeTecWeFwPwpKnIu07B0VItJVpA=
X-Received: by 2002:a05:6a20:5aa3:b0:1af:b311:6a70 with SMTP id
 kh35-20020a056a205aa300b001afb3116a70mr3732616pzb.27.1715053363059; Mon, 06
 May 2024 20:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506033353.28505-1-laoar.shao@gmail.com> <20240506033353.28505-3-laoar.shao@gmail.com>
In-Reply-To: <20240506033353.28505-3-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 May 2024 20:42:31 -0700
Message-ID: <CAEf4Bza0UnsAVuBH1J_nGN14gXg_Sa2QnJG7jjFjozcYzxx2dg@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 2/2] selftests/bpf: Add selftest for bits iter
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 8:35=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> Add test cases for the bits iter:
> - positive case
>   - bit mask smaller than 8 bytes
>   - a typical case of having 8-byte bit mask
>   - another typical case where bit mask is > 8 bytes
>   - the index of set bit
>
> - nagative cases
>   - bpf_iter_bits_destroy() is required after calling
>     bpf_iter_bits_new()
>   - bpf_iter_bits_destroy() can only destroy an initialized iter
>   - bpf_iter_bits_next() must use an initialized iter
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../selftests/bpf/progs/verifier_bits_iter.c  | 160 ++++++++++++++++++
>  2 files changed, 162 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_iter.=
c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index c4f9f306646e..7e04ecaaa20a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -84,6 +84,7 @@
>  #include "verifier_xadd.skel.h"
>  #include "verifier_xdp.skel.h"
>  #include "verifier_xdp_direct_packet_access.skel.h"
> +#include "verifier_bits_iter.skel.h"
>
>  #define MAX_ENTRIES 11
>
> @@ -198,6 +199,7 @@ void test_verifier_var_off(void)              { RUN(v=
erifier_var_off); }
>  void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
>  void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
>  void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_dir=
ect_packet_access); }
> +void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
>
>  static int init_test_val_map(struct bpf_object *obj, char *map_name)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/too=
ls/testing/selftests/bpf/progs/verifier_bits_iter.c
> new file mode 100644
> index 000000000000..2f7b62b25638
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#include "bpf_misc.h"
> +#include "task_kfunc_common.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__=
ign,
> +                     u32 nr_bits) __ksym __weak;
> +int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
> +void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak;
> +
> +SEC("iter.s/cgroup")
> +__description("bits iter without destroy")
> +__failure __msg("Unreleased reference")
> +int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, struct cgroup *cgrp=
)
> +{
> +       struct bpf_iter_bits it;
> +       struct task_struct *p;
> +
> +       p =3D bpf_task_from_pid(1);
> +       if (!p)
> +               return 1;
> +
> +       bpf_iter_bits_new(&it, p->cpus_ptr, 8192);
> +
> +       bpf_iter_bits_next(&it);
> +       bpf_task_release(p);
> +       return 0;
> +}
> +
> +SEC("iter/cgroup")
> +__description("bits iter with uninitialized iter in ->next()")
> +__failure __msg("expected an initialized iter_bits as arg #1")
> +int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup *cgr=
p)
> +{
> +       struct bpf_iter_bits *it =3D NULL;
> +
> +       bpf_iter_bits_next(it);
> +       return 0;
> +}
> +
> +SEC("iter/cgroup")
> +__description("bits iter with uninitialized iter in ->destroy()")
> +__failure __msg("expected an initialized iter_bits as arg #1")
> +int BPF_PROG(destroy_uninit, struct bpf_iter_meta *meta, struct cgroup *=
cgrp)
> +{
> +       struct bpf_iter_bits it =3D {};
> +
> +       bpf_iter_bits_destroy(&it);
> +       return 0;
> +}
> +
> +SEC("syscall")
> +__description("bits copy 32")
> +__success __retval(10)
> +int bits_copy32(void)
> +{
> +       /* 21 bits:             --------------------- */
> +       u32 data =3D 0b11111101111101111100001000100101U;

if you define this bit mask as an array of bytes, then you won't have
to handle big-endian in the tests at all


> +       int nr =3D 0, offset =3D 0;
> +       int *bit;
> +
> +#if defined(__TARGET_ARCH_s390)
> +       offset =3D sizeof(u32) - (21 + 7) / 8;
> +#endif
> +       bpf_for_each(bits, bit, ((char *)&data) + offset, 21)
> +               nr++;
> +       return nr;
> +}
> +
> +SEC("syscall")
> +__description("bits copy 64")
> +__success __retval(18)
> +int bits_copy64(void)
> +{
> +       /* 34 bits:         ~-------- */
> +       u64 data =3D 0xffffefdf0f0f0f0fUL;
> +       int nr =3D 0, offset =3D 0;
> +       int *bit;
> +
> +#if defined(__TARGET_ARCH_s390)
> +       offset =3D sizeof(u64) - (34 + 7) / 8;
> +#endif
> +
> +       bpf_for_each(bits, bit, ((char *)&data) + offset, 34)

see above about byte array, but if we define different (not as byte
array but long[]), it would be cleaner to have

#if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
u64 data =3D 0x......UL;
#else
u64 data =3D 0x......UL;
#endif

wherer we'd hard-code bit masks in proper endianness in one place and
then just do a clean `bpf_for_each(bits, bit, &data, <len>) {}` calls

> +               nr++;
> +       return nr;
> +}
> +
> +SEC("syscall")
> +__description("bits memalloc long-aligned")
> +__success __retval(32) /* 16 * 2 */
> +int bits_memalloc(void)
> +{
> +       char data[16];
> +       int nr =3D 0;
> +       int *bit;
> +
> +       __builtin_memset(&data, 0x48, sizeof(data));
> +       bpf_for_each(bits, bit, &data, sizeof(data) * 8)
> +               nr++;
> +       return nr;
> +}
> +
> +SEC("syscall")
> +__description("bits memalloc non-long-aligned")
> +__success __retval(85) /* 17 * 5*/
> +int bits_memalloc_non_aligned(void)
> +{
> +       char data[17];
> +       int nr =3D 0;
> +       int *bit;
> +
> +       __builtin_memset(&data, 0x1f, sizeof(data));
> +       bpf_for_each(bits, bit, &data, sizeof(data) * 8)
> +               nr++;
> +       return nr;
> +}
> +
> +SEC("syscall")
> +__description("bits memalloc non-aligned-bits")
> +__success __retval(27) /* 8 * 3 + 3 */
> +int bits_memalloc_non_aligned_bits(void)
> +{
> +       char data[16];
> +       int nr =3D 0;
> +       int *bit;
> +
> +       __builtin_memset(&data, 0x31, sizeof(data));
> +       /* Different with all other bytes */
> +       data[8] =3D 0xf7;
> +
> +       bpf_for_each(bits, bit, &data,  68)
> +               nr++;
> +       return nr;
> +}
> +
> +
> +SEC("syscall")
> +__description("bit index")
> +__success __retval(8)
> +int bit_index(void)
> +{
> +       u64 data =3D 0x100;
> +       int bit_idx =3D 0;
> +       int *bit;
> +
> +       bpf_for_each(bits, bit, &data, 64) {
> +               if (*bit =3D=3D 0)
> +                       continue;
> +               bit_idx =3D *bit;
> +       }
> +       return bit_idx;
> +}
> --
> 2.30.1 (Apple Git-130)
>

