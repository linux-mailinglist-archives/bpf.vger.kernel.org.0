Return-Path: <bpf+bounces-57294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5102FAA7B68
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 23:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A341F4E044C
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 21:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669AC204588;
	Fri,  2 May 2025 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+3whUke"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216051F1513
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746221712; cv=none; b=E4ARxwnRHtixGpFQEevEo95c8iGVMYeOtWN575DgzKdoaxOUV787s8GQCdKAv50p38TQKzHCI8jlbqv7oFav5TkvM8P3R6LXa/LOWbR8lr5bF1oQwz9tXjV+axOOLL0y0lGumLxoCTvMeTODwBB1P1Vzj6HgUK2z/CBd0OD+XbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746221712; c=relaxed/simple;
	bh=VObZ0pV+lDx35uqkXsAsHXdSKGhIC0soMKo/MTJdQw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GW7WDxtArhZ9UwmTHdJYzVieYEac4CoF+oSYIBvPn/4g/FW//TA8GpFkiQ1s2GxTpzaz+0JTso2UnrKSmUooTjgsbOVvXDcynd4TtFrvUcMqO1YRu+64Pd4VoL4YO472by0kNrRHY5C5nWjwt2o3nnO6bjM8e/jfMzaQdqQVVJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+3whUke; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c30d9085aso1656798f8f.1
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 14:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746221709; x=1746826509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDCuSVE19VHPf3irciu/ZQZDdx1w2zfhcJcCZrk/Sl0=;
        b=c+3whUkelJ4Hb6vDgR+r2dOle8GL3GZ66mOcv6T+sxIJJ2eTeCeBkxDvx3jkvDRuvz
         HkAcnOTgmyqA9mofaXrJl6m3M+/npN7sgyatb2C9ZlwkPZkAp22eEwqW+Q990WP/ZLUo
         fGTFBbnLykb+2YjTqFM5+trp2SyY/5x7+9OYADH0pu1/XVIcAyhT32MQwuVlctZmcqtF
         yW511iSEHT7hg+48cxkjx/Ksp04qDrie01NUeESu386PUfwIlfZ1xRo2MokddtOb9FYO
         xWW1+vcHTLcnbAzha0g8TSGUFCPSSdcWFDNc6fdGmVHDVJkPkgI+XdM2nviJEavLmm1s
         G5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746221709; x=1746826509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDCuSVE19VHPf3irciu/ZQZDdx1w2zfhcJcCZrk/Sl0=;
        b=V0/M12JuknZ8K9yZlobujU1kfTBppgxAzh55Bz9GcflgFC/h6aqoHqxd9Z21iEMHGn
         hf2AQiOmO4bJs7ByNBhog7458sKxvjzexERWivV5mzj/WANR/npqX72CA6M7wApfi0Lu
         D6GF26yGzqU+Est79a2Z76tb7yZaGpbpaQHi2ZuXdKkURnTfmk2aeCD92XzWI58s7GoM
         DNu2oWW1Iow8nS/D7aY5bLjpIXI+FSA7eH5lesl17RCAw+MGkh4PtvMuhKji1nBLxyn9
         hXfbI+53n8yXiip4/kjm0AQ9G/7viqa2HtUbIPya5NRhfDbaXXLZ00f3aBtvgOaXXUzL
         DDHA==
X-Gm-Message-State: AOJu0Yy557lrzzaAs87Bw+jYPiYwEf171PSiGhFekwS6yCLavNqxmdSS
	6X0aDOL3UmTEfJM8FwAWN1Q7dnZ0RMl730gNYzbIRn8YLbiS36pLB5F3gZ6JBxxWamiG4LY9XWK
	BGrOlQ92hp3jM2oSY3kFcWK3v8iZ1AFc+
X-Gm-Gg: ASbGncvIQlITEI9x6TbjQmr92M0B9SXeGCvXqE1PmYWehD2QWRQwDju4Ft4EjXBGrm0
	Jbfzy5IxFHj2LgzrE32Ei4RWSn3WXO4bL+73DTJ9IcYzkYDclCLHoTdUSZueU9llngxrSaGKCTZ
	Z5FrlK2TQFFNZxjxifMDfX/yw50w/StYr+Brg41fBm1sWISu3b2siOmXhudGZN
X-Google-Smtp-Source: AGHT+IERrIwVUaOF//jHNT6q1M841AR+hKlvIx9A5l3rfZByix8O3XIbyEqNdep8mj/Q6MEj/DvmLOIYoiB3fywt9NM=
X-Received: by 2002:a05:6000:40da:b0:3a0:8330:3377 with SMTP id
 ffacd0b85a97d-3a099aea737mr3735120f8f.44.1746221709199; Fri, 02 May 2025
 14:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502190621.41549-1-mykyta.yatsenko5@gmail.com> <20250502190621.41549-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250502190621.41549-4-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 May 2025 14:34:58 -0700
X-Gm-Features: ATxdqUGp93Tl9vn4c1gmsxyoQ9VVBeA4l9OiDyqnAPTzFCj6ChCm7yBI0oW4SM0
Message-ID: <CAADnVQKLvOeN6sRctgna7BjU=3HeK+6Y1E-f1rmHEH7V8T00dw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: introduce tests for dynptr
 copy kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 12:06=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introduce selftests verifying newly-added dynptr copy kfuncs.
> Covering contiguous and non-contiguous memory backed dynptrs.
>
> Disable test_probe_read_user_str_dynptr that triggers bug in
> strncpy_from_user_nofault. Patch to fix the issue [1].
>
> [1] https://patchwork.kernel.org/project/linux-mm/patch/20250422131449.57=
177-1-mykyta.yatsenko5@gmail.com/
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST          |   1 +
>  .../testing/selftests/bpf/prog_tests/dynptr.c |  13 ++
>  .../selftests/bpf/progs/dynptr_success.c      | 201 ++++++++++++++++++
>  3 files changed, 215 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/DENYLIST b/tools/testing/selftes=
ts/bpf/DENYLIST
> index f748f2c33b22..1789a61d0a9b 100644
> --- a/tools/testing/selftests/bpf/DENYLIST
> +++ b/tools/testing/selftests/bpf/DENYLIST
> @@ -1,5 +1,6 @@
>  # TEMPORARY
>  # Alphabetical order
> +dynptr/test_probe_read_user_str_dynptr # disabled until https://patchwor=
k.kernel.org/project/linux-mm/patch/20250422131449.57177-1-mykyta.yatsenko5=
@gmail.com/ makes it into the bpf-next
>  get_stack_raw_tp    # spams with kernel warnings until next bpf -> bpf-n=
ext merge
>  stacktrace_build_id
>  stacktrace_build_id_nmi
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
> index e29cc16124c2..62e7ec775f24 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> @@ -33,10 +33,19 @@ static struct {
>         {"test_dynptr_skb_no_buff", SETUP_SKB_PROG},
>         {"test_dynptr_skb_strcmp", SETUP_SKB_PROG},
>         {"test_dynptr_skb_tp_btf", SETUP_SKB_PROG_TP},
> +       {"test_probe_read_user_dynptr", SETUP_XDP_PROG},
> +       {"test_probe_read_kernel_dynptr", SETUP_XDP_PROG},
> +       {"test_probe_read_user_str_dynptr", SETUP_XDP_PROG},
> +       {"test_probe_read_kernel_str_dynptr", SETUP_XDP_PROG},
> +       {"test_copy_from_user_dynptr", SETUP_SYSCALL_SLEEP},
> +       {"test_copy_from_user_str_dynptr", SETUP_SYSCALL_SLEEP},
> +       {"test_copy_from_user_task_dynptr", SETUP_SYSCALL_SLEEP},
> +       {"test_copy_from_user_task_str_dynptr", SETUP_SYSCALL_SLEEP},
>  };
>
>  static void verify_success(const char *prog_name, enum test_setup_type s=
etup_type)
>  {
> +       char user_data[384] =3D {[0 ... 382] =3D 'a', '\0'};
>         struct dynptr_success *skel;
>         struct bpf_program *prog;
>         struct bpf_link *link;
> @@ -58,6 +67,10 @@ static void verify_success(const char *prog_name, enum=
 test_setup_type setup_typ
>         if (!ASSERT_OK(err, "dynptr_success__load"))
>                 goto cleanup;
>
> +       skel->bss->user_ptr =3D user_data;
> +       skel->data->test_len[0] =3D sizeof(user_data);
> +       memcpy(skel->bss->expected_str, user_data, sizeof(user_data));
> +
>         switch (setup_type) {
>         case SETUP_SYSCALL_SLEEP:
>                 link =3D bpf_program__attach(prog);
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/t=
esting/selftests/bpf/progs/dynptr_success.c
> index e1fba28e4a86..753d35eb47d9 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -680,3 +680,204 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
>         bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
>         return XDP_DROP;
>  }
> +
> +void *user_ptr;
> +char expected_str[384]; /* Contains the copy of the data pointed by user=
_ptr */

what so magic about 384?

> +__u32 test_len[7] =3D {0/* placeholder */, 0, 1, 2, 255, 256, 257};
> +
> +typedef int (*bpf_read_dynptr_fn_t)(struct bpf_dynptr *dptr, u32 off,
> +                                   u32 size, const void *unsafe_ptr);
> +
> +static __always_inline void test_dynptr_probe(void *ptr, bpf_read_dynptr=
_fn_t bpf_read_dynptr_fn)

More __always_inline in the prog too?
Why?

> +{
> +       char buf[sizeof(expected_str)];
> +       struct bpf_dynptr ptr_buf;
> +       int i;
> +
> +       err =3D bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(buf), 0, &ptr=
_buf);
> +
> +       bpf_for(i, 0, ARRAY_SIZE(test_len)) {
> +               __u32 len =3D test_len[i];
> +
> +               err =3D err ?: bpf_read_dynptr_fn(&ptr_buf, 0, test_len[i=
], ptr);
> +               if (len > sizeof(buf))
> +                       break;
> +               err =3D err ?: bpf_dynptr_read(&buf, len, &ptr_buf, 0, 0)=
;
> +
> +               if (err || bpf_memcmp(expected_str, buf, len))
> +                       err =3D 1;
> +
> +               /* Reset buffer and dynptr */
> +               __builtin_memset(buf, 0, sizeof(buf));
> +               err =3D err ?: bpf_dynptr_write(&ptr_buf, 0, buf, len, 0)=
;
> +       }
> +       bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
> +}
> +
> +static __always_inline void test_dynptr_probe_str(void *ptr,
> +                                                 bpf_read_dynptr_fn_t bp=
f_read_dynptr_fn)
> +{
> +       char buf[sizeof(expected_str)];
> +       struct bpf_dynptr ptr_buf;
> +       __u32 cnt, i;
> +
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(buf), 0, &ptr_buf);
> +
> +       bpf_for(i, 0, ARRAY_SIZE(test_len)) {
> +               __u32 len =3D test_len[i];
> +
> +               cnt =3D bpf_read_dynptr_fn(&ptr_buf, 0, len, ptr);
> +               if (cnt !=3D len)
> +                       err =3D 1;
> +
> +               if (len > sizeof(buf))
> +                       continue;
> +               err =3D err ?: bpf_dynptr_read(&buf, len, &ptr_buf, 0, 0)=
;
> +               if (!len)
> +                       continue;
> +               if (err || bpf_memcmp(expected_str, buf, len - 1) || buf[=
len - 1] !=3D '\0')
> +                       err =3D 1;
> +       }
> +       bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
> +}
> +
> +static __always_inline void test_dynptr_probe_xdp(struct xdp_md *xdp, vo=
id *ptr,
> +                                                 bpf_read_dynptr_fn_t bp=
f_read_dynptr_fn)
> +{
> +       struct bpf_dynptr ptr_xdp;
> +       char buf[sizeof(expected_str)];
> +       __u32 off, i;
> +
> +       /* Set offset near the seam between buffers */
> +       off =3D 3500;

what is 3500 ?

