Return-Path: <bpf+bounces-17259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E27780AFAC
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 23:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D081C20A18
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 22:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F1B3986E;
	Fri,  8 Dec 2023 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSo/bUAH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F5E85
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 14:31:09 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54c846da5e9so2353962a12.3
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 14:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702074668; x=1702679468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMjepWcRkVZdNMRsH0BbdKIpcRsE79ezk6iTmv57JxI=;
        b=dSo/bUAHAADpGIU+eXta/W3Xq5irofzte4CY/qxKSAxcnuCEM3vOhXNfJV1/0kqWpX
         TMqw8G1wPt413I4RV0H+L8BcMuNOpQIZfnbDmhy+vM3O7yyOKqt8lqboELWQpoIv66bV
         9hQAWISl+W/ExeSc0epCsPB6hlfQv8WaFhWVowN0ZQqjnkjWAWMSdU5lm7+s/hjdqa5H
         bWKNVW/HrFPlcfn/L3h8sebVfJRIvxB37B/EQA0C+k4ZfEFHQovB6CH0bVWF6saS2m/S
         LUF0tFAlZdoTWSkvk3dvQRVyCDsWajgw/Jfa0DJVPhT4NYxLmUH0Y339K/SUL4KpvynZ
         Verw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702074668; x=1702679468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMjepWcRkVZdNMRsH0BbdKIpcRsE79ezk6iTmv57JxI=;
        b=qizsGpx5sxL44wTk+Tb9ropDMS7ebpi9XxxztZD5eQefIxLElervtP5tjYvYZEqeUi
         ALchXLc767xx2vrLPI1TVdUhq27B7koJwv6lQsaLMISy4vZDRU+CbsMyu75g3s71Bdc6
         wPHi5ACECBeFbbpVC5OJbyR08yeRGwrGFNmowcHbiA5ZyH2fgTIHvTm0xk0NUcqDYBxv
         1b0FdzXTynXoJYxGfPSZDvqOezVazyLQFPdyCoCa1vvuOWMtXVP5mmLMCKhZKL4KNEzX
         3rYyjAEDY00506tDZNgEf7kPvm5VFSE4sD+XP4YimSMEdX/p8yg//irGEWzqo48TCRn9
         6W5Q==
X-Gm-Message-State: AOJu0YzS03lzHKVJ7VXKRJhU3S2/4/lbnS4E1TGJA0e/8SQ1f4LXrOgK
	JHz/8E4hm7+AQJoyMXBnsaOZzEdLeTVEQPW9Dlw=
X-Google-Smtp-Source: AGHT+IH9QxRIW14wu9Qc/B8Cb3wf2CoWmqrFo/O3/TwBGt4EjhmFZ7VHTjYLpRoxeUvYt/dZkb5XRud4+hG731IWkV0=
X-Received: by 2002:a17:906:48:b0:a1f:706a:b802 with SMTP id
 8-20020a170906004800b00a1f706ab802mr340321ejg.1.1702074668222; Fri, 08 Dec
 2023 14:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208102355.2628918-1-houtao@huaweicloud.com> <20231208102355.2628918-8-houtao@huaweicloud.com>
In-Reply-To: <20231208102355.2628918-8-houtao@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Dec 2023 14:30:56 -0800
Message-ID: <CAEf4BzbS5DaarFp6LqwLLLPj=MjkOtQVFUBKganQjXpTgNe0gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: Wait for sleepable BPF program in maybe_wait_bpf_programs()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 2:23=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Since commit 638e4b825d52 ("bpf: Allows per-cpu maps and map-in-map in
> sleepable programs"), sleepable BPF program can use map-in-map, but
> maybe_wait_bpf_programs() doesn't consider it accordingly.
>
> So checking the value of sleepable_refcnt in maybe_wait_bpf_programs(),
> if the value is not zero, use synchronize_rcu_mult() to wait for both
> sleepable and non-sleepable BPF programs. But bpf syscall from syscall
> program is special, because the bpf syscall is called with
> rcu_read_lock_trace() being held, and there will be dead-lock if
> synchronize_rcu_mult() is used to wait for the exit of sleepable BPF
> program, so just skip the waiting of sleepable BPF program for bpf
> syscall which comes from syscall program.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/syscall.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index d2641e51a1a7..6b9d7990d95f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -35,6 +35,7 @@
>  #include <linux/rcupdate_trace.h>
>  #include <linux/memcontrol.h>
>  #include <linux/trace_events.h>
> +#include <linux/rcupdate_wait.h>
>
>  #include <net/netfilter/nf_bpf_link.h>
>  #include <net/netkit.h>
> @@ -140,15 +141,24 @@ static u32 bpf_map_value_size(const struct bpf_map =
*map)
>                 return  map->value_size;
>  }
>
> -static void maybe_wait_bpf_programs(struct bpf_map *map)
> +static void maybe_wait_bpf_programs(struct bpf_map *map, bool rcu_trace_=
lock_held)
>  {
> -       /* Wait for any running BPF programs to complete so that
> -        * userspace, when we return to it, knows that all programs
> -        * that could be running use the new map value.
> +       /* Wait for any running non-sleepable and sleepable BPF programs =
to
> +        * complete, so that userspace, when we return to it, knows that =
all
> +        * programs that could be running use the new map value. However
> +        * syscall program can also use bpf syscall to update or delete i=
nner
> +        * map in outer map, and it holds rcu_read_lock_trace() before do=
ing
> +        * the bpf syscall. If use synchronize_rcu_mult(call_rcu_tasks_tr=
ace)
> +        * to wait for the exit of running sleepable BPF programs, there =
will
> +        * be dead-lock, so skip the waiting for syscall program.
>          */
>         if (map->map_type =3D=3D BPF_MAP_TYPE_HASH_OF_MAPS ||
> -           map->map_type =3D=3D BPF_MAP_TYPE_ARRAY_OF_MAPS)
> -               synchronize_rcu();
> +           map->map_type =3D=3D BPF_MAP_TYPE_ARRAY_OF_MAPS) {
> +               if (atomic64_read(&map->sleepable_refcnt) && !rcu_trace_l=
ock_held)

why is this correct and non-racy without holding used_maps_mutex under
which this sleepable_refcnt is incremented?

> +                       synchronize_rcu_mult(call_rcu, call_rcu_tasks_tra=
ce);
> +               else
> +                       synchronize_rcu();
> +       }
>  }
>
>  static int bpf_map_update_value(struct bpf_map *map, struct file *map_fi=
le,
> @@ -1561,7 +1571,7 @@ static int map_update_elem(union bpf_attr *attr, bp=
fptr_t uattr)
>
>         err =3D bpf_map_update_value(map, f.file, key, value, attr->flags=
);
>         if (!err)
> -               maybe_wait_bpf_programs(map);
> +               maybe_wait_bpf_programs(map, bpfptr_is_kernel(uattr));
>
>         kvfree(value);
>  free_key:
> @@ -1618,7 +1628,7 @@ static int map_delete_elem(union bpf_attr *attr, bp=
fptr_t uattr)
>         rcu_read_unlock();
>         bpf_enable_instrumentation();
>         if (!err)
> -               maybe_wait_bpf_programs(map);
> +               maybe_wait_bpf_programs(map, bpfptr_is_kernel(uattr));
>  out:
>         kvfree(key);
>  err_put:
> @@ -4973,7 +4983,7 @@ static int bpf_map_do_batch(union bpf_attr *attr,
>  err_put:
>         if (has_write) {
>                 if (attr->batch.count)
> -                       maybe_wait_bpf_programs(map);
> +                       maybe_wait_bpf_programs(map, false);
>                 bpf_map_write_active_dec(map);
>         }
>         fdput(f);
> --
> 2.29.2
>

