Return-Path: <bpf+bounces-19227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E882827A59
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 22:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51BE1F23C3B
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 21:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A10756457;
	Mon,  8 Jan 2024 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/hzpUoM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB7856443
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 21:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D29C433C7
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 21:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704750368;
	bh=L5GDSCI6j6iVMqBDZIzIJg9Yhoz5lRKqvhQwlE3F6GE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r/hzpUoMelaCeUkArHfi4QLT/cJWj9myglVbE8oM0/xJzSKfPAXYbaThpIBgF70G9
	 itR/EsrDg7UsSmqmV1Xzhq5XYfeZsJ/xyGojJBaUucZSBa9aEZhYuhopVS9dhbYVtX
	 LMG1+lY7Go2Z6DOmsHe8LImCOR0BqGAMRe/ZAbvgD+BR44UvSwPk4pmflsjDQU6I0U
	 FhJluhQlPgkqzzsrmaX9wgXxCMrGktpaosDXcgvkyqoUzfVMZbgazwqc1mQJdr1xjt
	 bgo8XkzREd257ysE/uagA7VIekjP7GRJ7vCDNg/xDX72lAaaICRmB//aLiKeJe2/F9
	 bOA0eUNSHUElQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso2302215e87.3
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 13:46:08 -0800 (PST)
X-Gm-Message-State: AOJu0YwYJ7mc9tELVGrNt3WjeWzPi30TliTbwzulUFppZbsdFbWnAvdL
	nTAXzzxUNgFQszHPUVHlfzkehKiRhxuzYJnWd+o=
X-Google-Smtp-Source: AGHT+IEtIONCvIHAZkc4PlKbW5+a/upRQB+Jg7RTpx9wbYoOSjZ+OmFl3B8vq1S5GTJdJgkuaVl5ojbkZqJ9KO1sjFs=
X-Received: by 2002:a05:6512:3119:b0:50e:778b:8b36 with SMTP id
 n25-20020a056512311900b0050e778b8b36mr1583923lfb.120.1704750366335; Mon, 08
 Jan 2024 13:46:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221141501.3588586-1-houtao@huaweicloud.com> <20231221141501.3588586-3-houtao@huaweicloud.com>
In-Reply-To: <20231221141501.3588586-3-houtao@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 8 Jan 2024 13:45:54 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5_9Tt6HLD_LFddS6egKK92WK6TWpz+X1mfi10FHzPskg@mail.gmail.com>
Message-ID: <CAPhsuW5_9Tt6HLD_LFddS6egKK92WK6TWpz+X1mfi10FHzPskg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add benchmark for bpf memory allocator
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 6:14=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
[...]
>
> The following is the test results conducted on a 8-CPU VM with 16GB memor=
y:
>
> $ for i in 1 4 8; do ./bench -w3 -d10 bpf_ma -p${i} -a; done |grep Summar=
y
> Summary: per-prod alloc 11.29 =C2=B1 0.14M/s free 33.76 =C2=B1 0.33M/s, t=
otal memory usage    0.01 =C2=B1 0.00MiB
> Summary: per-prod alloc  7.49 =C2=B1 0.12M/s free 34.42 =C2=B1 0.56M/s, t=
otal memory usage    0.03 =C2=B1 0.00MiB
> Summary: per-prod alloc  6.66 =C2=B1 0.08M/s free 34.27 =C2=B1 0.41M/s, t=
otal memory usage    0.06 =C2=B1 0.00MiB
>
> $ for i in 1 4 8; do ./bench -w3 -d10 bpf_ma -p${i} -a --percpu; done |gr=
ep Summary
> Summary: per-prod alloc 14.64 =C2=B1 0.60M/s free 36.94 =C2=B1 0.35M/s, t=
otal memory usage  188.02 =C2=B1 7.43MiB
> Summary: per-prod alloc 12.39 =C2=B1 1.32M/s free 36.40 =C2=B1 0.38M/s, t=
otal memory usage  808.90 =C2=B1 25.56MiB
> Summary: per-prod alloc 10.80 =C2=B1 0.17M/s free 35.45 =C2=B1 0.25M/s, t=
otal memory usage 2330.24 =C2=B1 480.56MiB

This is not likely related to this patch, but do we expect this much
memory usage?
I guess the 2.3GiB number is from bigger ALLOC_OBJ_SIZE and
ALLOC_BATCH_CNT? I am getting 0 MiB with this test on my VM.

>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |   2 +
>  tools/testing/selftests/bpf/bench.c           |   4 +
>  tools/testing/selftests/bpf/bench.h           |   7 +
>  .../selftests/bpf/benchs/bench_bpf_ma.c       | 273 ++++++++++++++++++
>  .../selftests/bpf/progs/bench_bpf_ma.c        | 222 ++++++++++++++

Maybe add a run_bench_bpf_ma.sh script in selftests/bpf/benchs?

>  5 files changed, 508 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_ma.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bench_bpf_ma.c
>
[...]
> diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftest=
s/bpf/bench.h
> index a6fcf111221f..206cf3de5df2 100644
> --- a/tools/testing/selftests/bpf/bench.h
> +++ b/tools/testing/selftests/bpf/bench.h
> @@ -53,6 +53,13 @@ struct bench_res {
>                         unsigned long gp_ct;
>                         unsigned int stime;
>                 } rcu;
> +               struct {
> +                       unsigned long alloc;
> +                       unsigned long free;

nit: maybe add _ct or _cnt postfix to match "rcu" above or the skel?

> +                       unsigned long alloc_ns;
> +                       unsigned long free_ns;
> +                       unsigned long mem_bytes;
> +               } ma;
>         };
>  };
>
[...]
> +
> +static void bpf_ma_validate(void)
> +{
> +}

Empty validate() function seems not necessary.

[...]

> +
> +static void bpf_ma_report_final(struct bench_res res[], int res_cnt)
> +{
> +       double mem_mean =3D 0.0, mem_stddev =3D 0.0;
> +       double alloc_mean =3D 0.0, alloc_stddev =3D 0.0;
> +       double free_mean =3D 0.0, free_stddev =3D 0.0;
> +       double alloc_ns =3D 0.0, free_ns =3D 0.0;
> +       int i;
> +
> +       for (i =3D 0; i < res_cnt; i++) {
> +               alloc_ns +=3D res[i].ma.alloc_ns;
> +               free_ns +=3D res[i].ma.free_ns;
> +       }
> +       for (i =3D 0; i < res_cnt; i++) {
> +               if (alloc_ns)
> +                       alloc_mean +=3D res[i].ma.alloc * 1000.0 / alloc_=
ns;
> +               if (free_ns)
> +                       free_mean +=3D res[i].ma.free * 1000.0 / free_ns;
> +               mem_mean +=3D res[i].ma.mem_bytes / 1048576.0 / (0.0 + re=
s_cnt);
> +       }
> +       if (res_cnt > 1) {
> +               for (i =3D 0; i < res_cnt; i++) {
> +                       double sample;
> +
> +                       sample =3D res[i].ma.alloc_ns ? res[i].ma.alloc *=
 1000.0 /
> +                                                     res[i].ma.alloc_ns =
: 0.0;
> +                       alloc_stddev +=3D (alloc_mean - sample) * (alloc_=
mean - sample) /
> +                                       (res_cnt - 1.0);
> +
> +                       sample =3D res[i].ma.free_ns ? res[i].ma.free * 1=
000.0 /
> +                                                    res[i].ma.free_ns : =
0.0;
> +                       free_stddev +=3D (free_mean - sample) * (free_mea=
n - sample) /
> +                                      (res_cnt - 1.0);
> +
> +                       sample =3D res[i].ma.mem_bytes / 1048576.0;
> +                       mem_stddev +=3D (mem_mean - sample) * (mem_mean -=
 sample) /
> +                                     (res_cnt - 1.0);
> +               }

nit: We can probably refactor common code for stddev calculation into
some helpers.

> +               alloc_stddev =3D sqrt(alloc_stddev);
> +               free_stddev =3D sqrt(free_stddev);
> +               mem_stddev =3D sqrt(mem_stddev);
> +       }
> +
> +       printf("Summary: per-prod alloc %7.2lf \u00B1 %3.2lfM/s free %7.2=
lf \u00B1 %3.2lfM/s, "
> +              "total memory usage %7.2lf \u00B1 %3.2lfMiB\n",
> +              alloc_mean, alloc_stddev, free_mean, free_stddev,
> +              mem_mean, mem_stddev);
> +}
> +
> +const struct bench bench_bpf_mem_alloc =3D {
> +       .name =3D "bpf_ma",
> +       .argp =3D &bench_bpf_mem_alloc_argp,
> +       .validate =3D bpf_ma_validate,
> +       .setup =3D bpf_ma_setup,
> +       .producer_thread =3D bpf_ma_producer,
> +       .measure =3D bpf_ma_measure,
> +       .report_progress =3D bpf_ma_report_progress,
> +       .report_final =3D bpf_ma_report_final,
> +};
> diff --git a/tools/testing/selftests/bpf/progs/bench_bpf_ma.c b/tools/tes=
ting/selftests/bpf/progs/bench_bpf_ma.c

[...]

> +
> +/* Return the number of allocated objects */
> +static __always_inline unsigned int batch_alloc(struct bpf_map *map)
> +{
> +       struct bin_data *old, *new;
> +       struct map_value *value;
> +       unsigned int i, key;
> +
> +       for (i =3D 0; i < ALLOC_BATCH_CNT; i++) {
> +               key =3D i;
> +               value =3D bpf_map_lookup_elem(map, &key);
> +               if (!value)
> +                       return i;
> +
> +               new =3D bpf_obj_new(typeof(*new));
> +               if (!new)
> +                       return i;
> +
> +               old =3D bpf_kptr_xchg(&value->data, new);
> +               if (old)
> +                       bpf_obj_drop(old);
> +       }
> +
> +       return ALLOC_BATCH_CNT;
> +}
> +
> +/* Return the number of freed objects */
> +static __always_inline unsigned int batch_free(struct bpf_map *map)
> +{
> +       struct map_value *value;
> +       unsigned int i, key;
> +       void *old;
> +
> +       for (i =3D 0; i < ALLOC_BATCH_CNT; i++) {
> +               key =3D i;
> +               value =3D bpf_map_lookup_elem(map, &key);
> +               if (!value)
> +                       return i;
> +
> +               old =3D bpf_kptr_xchg(&value->data, NULL);
> +               if (!old)
> +                       return i;
> +               bpf_obj_drop(old);
> +       }
> +
> +       return ALLOC_BATCH_CNT;
> +}
> +
> +/* Return the number of allocated objects */
> +static __always_inline unsigned int batch_percpu_alloc(struct bpf_map *m=
ap)
> +{
> +       struct percpu_bin_data *old, *new;
> +       struct percpu_map_value *value;
> +       unsigned int i, key;
> +
> +       for (i =3D 0; i < ALLOC_BATCH_CNT; i++) {
> +               key =3D i;
> +               value =3D bpf_map_lookup_elem(map, &key);
> +               if (!value)
> +                       return i;
> +
> +               new =3D bpf_percpu_obj_new(typeof(*new));
> +               if (!new)
> +                       return i;
> +
> +               old =3D bpf_kptr_xchg(&value->data, new);
> +               if (old)
> +                       bpf_percpu_obj_drop(old);
> +       }
> +
> +       return ALLOC_BATCH_CNT;
> +}
> +
> +/* Return the number of freed objects */
> +static __always_inline unsigned int batch_percpu_free(struct bpf_map *ma=
p)
> +{
> +       struct percpu_map_value *value;
> +       unsigned int i, key;
> +       void *old;
> +
> +       for (i =3D 0; i < ALLOC_BATCH_CNT; i++) {
> +               key =3D i;
> +               value =3D bpf_map_lookup_elem(map, &key);
> +               if (!value)
> +                       return i;
> +
> +               old =3D bpf_kptr_xchg(&value->data, NULL);
> +               if (!old)
> +                       return i;
> +               bpf_percpu_obj_drop(old);
> +       }
> +
> +       return ALLOC_BATCH_CNT;
> +}

nit: These four functions have quite duplicated code. We can probably
refactor them a bit.

> +
> +SEC("?fentry/" SYS_PREFIX "sys_getpgid")
> +int bench_batch_alloc_free(void *ctx)
> +{
> +       u64 start, delta;
> +       unsigned int cnt;
> +       void *map;

s/void */struct bpf_map */?

> +       int key;
> +
> +       key =3D bpf_get_smp_processor_id();
> +       map =3D bpf_map_lookup_elem((void *)&outer_array, &key);
> +       if (!map)
> +               return 0;
> +
> +       start =3D bpf_ktime_get_boot_ns();
> +       cnt =3D batch_alloc(map);
> +       delta =3D bpf_ktime_get_boot_ns() - start;
> +       __sync_fetch_and_add(&alloc_cnt, cnt);
> +       __sync_fetch_and_add(&alloc_ns, delta);
> +
> +       start =3D bpf_ktime_get_boot_ns();
> +       cnt =3D batch_free(map);
> +       delta =3D bpf_ktime_get_boot_ns() - start;
> +       __sync_fetch_and_add(&free_cnt, cnt);
> +       __sync_fetch_and_add(&free_ns, delta);
> +
> +       return 0;
> +}
> +
> +SEC("?fentry/" SYS_PREFIX "sys_getpgid")
> +int bench_batch_percpu_alloc_free(void *ctx)
> +{
> +       u64 start, delta;
> +       unsigned int cnt;
> +       void *map;

ditto

> +       int key;
> +
> +       key =3D bpf_get_smp_processor_id();
> +       map =3D bpf_map_lookup_elem((void *)&percpu_outer_array, &key);
> +       if (!map)
> +               return 0;
> +
> +       start =3D bpf_ktime_get_boot_ns();
> +       cnt =3D batch_percpu_alloc(map);
> +       delta =3D bpf_ktime_get_boot_ns() - start;
> +       __sync_fetch_and_add(&alloc_cnt, cnt);
> +       __sync_fetch_and_add(&alloc_ns, delta);
> +
> +       start =3D bpf_ktime_get_boot_ns();
> +       cnt =3D batch_percpu_free(map);
> +       delta =3D bpf_ktime_get_boot_ns() - start;
> +       __sync_fetch_and_add(&free_cnt, cnt);
> +       __sync_fetch_and_add(&free_ns, delta);
> +
> +       return 0;
> +}

nit: ditto duplicated code.

