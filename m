Return-Path: <bpf+bounces-40411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E388988645
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 15:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B76F1C22D6F
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 13:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B341018BBA9;
	Fri, 27 Sep 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAZe3LEO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F9F1465A9
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727443722; cv=none; b=VsYM4a1G7yWmP2l0+u9l78vQ6N7Ty6kv7oxIOo1HejOGXKbPj7rkxXa5U8zuRTYI1j7EHob9koAjDQYydyS2BuQ6KOD5ox20zKT9Mfgda0wCvAToHLt9YVOea9jPmgXio5AXT40TBxKfGzhrwXfXnvHGLAxHhR0iJgPWY1AtVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727443722; c=relaxed/simple;
	bh=IVnsX4jhVLlaDvWc7soYu/rpRRvcGIWMo/TIvHnCS3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsLGJZ79eiFjsB9KV024M3OVGPCiVskHZVmLebkNkQT7KKCiJQueEKGejkNP8vkF6qguKQiJmGbl7L6FgzZ4QKh5aLK5zUmEdyMlikA6/RSSWInDCzxHb5457B4uYKfUcfPg2kOiDMxXI+QcC0lVY7qA82q1ee5Z/lvOaGzi/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAZe3LEO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cdb42b29dso312912f8f.0
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727443719; x=1728048519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWLur4gngi31SZ52xs10EX/PwHDcAZ6DuvrMLkkpeb8=;
        b=KAZe3LEO6DhX70RwxuP3f9ZmexVN6id0Pb7UOHEgLaLKxT4hE1jjAWg65qN7LjLews
         AriGSroH33jO5Vvv5TWjq+E/h/WUi+POR2m5Cmzeig7xlWcmKfcSAGDNRSQqY++UrhNJ
         FzddHqeRh/Xgd6d0vwdXfjQG3bx7UjZffdf6niZuILuN3UcW1buvxAM6lr0z62wjRWwi
         xzf+1dg+prpRsudmP8LXmPOWUYGw9bw6r0SrtkCcv21QEnyXq1eb9vvpRnir6bklEXYH
         yzv3B4BFjK153eNNUHanuMkkd6vq0Rsl4V3xAbrRuWzpCzWZXwE2nPnfUwE9DofAn8xN
         6leA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727443719; x=1728048519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWLur4gngi31SZ52xs10EX/PwHDcAZ6DuvrMLkkpeb8=;
        b=v25SJE4V1FwT/ONjpKMstt/eXA6IIPmvVV6sqPmoRyQ2ALGfGdDGZn0e6O9EexpR4i
         YP00FHdZn0m4KuFcVaZnaDOZI324igbaSRVmsynfKtLN1eWY4y3SV03d9P79/8eMNQyh
         55sigoI9lFSTUkZb+csdBe3bzU3NC9XovB5FW0iOAkvAmVfnmOPoAMrnKy8JqDJ0fdNo
         6daYc9mdRInYG/SUs3lzl/xWZ9DcAUP2TAYJCf+HI9b9OCd+bRhXdXyIMp+Z309NVhYg
         l43LrMJ3w2GASvKzMegCko+ObIhXsPMkwuEQ1SGV7RXwbaZArd/yRXUrYfNOnrh3zxQU
         VV+w==
X-Forwarded-Encrypted: i=1; AJvYcCXbCBwCqw0v+4c+FFKlWFYqEFCNgoICUey8iLintpjJlvF09f41+cel2LQt7euisJLm/Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVOa7Pj3nFrQ1EKMeLED99Xt0c7rXvfbhPQoX/W/q9egJCE7i
	aDWuM9cEJd2R3805Wh+jWhGuMeMhTI1c6pwZDNVe0zb2NH8sROb7HFVoFNDXKmtdOXeHcitjGQu
	8YkLHcRRT6Gvyxs/EjLKK/NCRC9skBTI7
X-Google-Smtp-Source: AGHT+IEsuSTL3tp+btsbUj4X/+nLOyxAXoMb5lLNd33L+cmux0JIwbjV66mgldQeYf/Mbo9SWXTzxlredKvFbxgYN9k=
X-Received: by 2002:a05:6000:b08:b0:371:8319:4dcc with SMTP id
 ffacd0b85a97d-37cd5a6bf2cmr2279937f8f.2.1727443718567; Fri, 27 Sep 2024
 06:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240921011712.83355-1-inwardvessel@gmail.com>
In-Reply-To: <20240921011712.83355-1-inwardvessel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Sep 2024 15:28:27 +0200
Message-ID: <CAADnVQ+MWYaVdY-hJcnyu_SBJdcoeLiD7qsTx2a0EdV3rqLikA@mail.gmail.com>
Subject: Re: [RFC bpf-next] libbpf: add resizable array helpers
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024 at 3:17=E2=80=AFAM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> Arrays in custom data sections can be resized via bpf_map__set_value().
> While working with these types of arrays in some sched_ext programs, ther=
e
> was some feedback that the manual operations involved could use helpers.
> The macros in the potential patch are intended to make resizing bpf array=
s
> easier.
>
> To illustrate, declaring an array that will be resized looks like this:
> __u32 my_map[1] SEC(".data.my_map");
>
> Instead, using a macro to help with the declaration:
> __u32 BPF_RESIZABLE_ARRAY(data, my_map);

I don't like hiding things in a macro.
SEC() isn't great, but that's what we got and users
used to it.

> To allow access to the post-resized array in the bpf program, this helper
> can be used which maintains verifier safety:
> u32 *val =3D (u32 *)ARRAY_ELEM_PTR(my_map, ctx->cpu, nr_cpus);

I don't like this one either.
We have bpf_cmp_likely/unlikely that can be used
to guard array access against the limit.

> Meanwhile in the userspace program, instead of doing:
> size_t sz =3D bpf_map__set_value_size(skel->maps.data_my_map, sizeof(skel=
->data_my_map->my_map[0]) * nr_cpus);
> skel->data_my_map =3D bpf_map__initial_value(skel->maps.data_my_map, &sz)=
;
>
> The resizing macro can be used:
> BPF_RESIZE_ARRAY(data, my_map, nr_cpus);

Open code of libbpf api is much more readable. Macros are not.



>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  include/uapi/linux/bpf.h    | 23 ++++++++++++++++++
>  tools/lib/bpf/bpf_helpers.h | 48 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e05b39e39c3f..92e93c9fc056 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7513,4 +7513,27 @@ struct bpf_iter_num {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +/*
> + * BPF_RESIZE_ARRAY - Convenience macro for resizing a BPF array
> + * @elfsec: the data section of the BPF program in which to the array ex=
ists
> + * @arr: the name of the array
> + * @n: the desired array element count
> + *
> + * For BPF arrays declared with RESIZABLE_ARRAY(), this macro performs t=
wo
> + * operations. It resizes the map which corresponds to the custom data
> + * section that contains the target array. As a side effect, the BTF inf=
o for
> + * the array is adjusted so that the array length is sized to cover the =
new
> + * data section size. The second operation is reassigning the skeleton p=
ointer
> + * for that custom data section so that it points to the newly memory ma=
pped
> + * region.
> + */
> +#define BPF_RESIZE_ARRAY(elfsec, arr, n)                                =
         \
> +       do {                                                             =
         \
> +               size_t __sz;                                             =
         \
> +               bpf_map__set_value_size(skel->maps.elfsec##_##arr,       =
         \
> +                               sizeof(skel->elfsec##_##arr->arr[0]) * (n=
));      \
> +               skel->elfsec##_##arr =3D                                 =
           \
> +                       bpf_map__initial_value(skel->maps.elfsec##_##arr,=
 &__sz); \
> +       } while (0)
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 305c62817dd3..b0d496b0f0d6 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -420,4 +420,52 @@ extern void bpf_iter_num_destroy(struct bpf_iter_num=
 *it) __weak __ksym;
>  )
>  #endif /* bpf_repeat */
>
> +/**
> + * RESIZABLE_ARRAY - Generates annotations for an array that may be resi=
zed
> + * @elfsec: the data section of the BPF program in which to place the ar=
ray
> + * @arr: the name of the array
> + *
> + * libbpf has an API for setting map value sizes. Since data sections (i=
.e.
> + * bss, data, rodata) themselves are maps, a data section can be resized=
. If
> + * a data section has an array as its last element, the BTF info for tha=
t
> + * array will be adjusted so that length of the array is extended to mee=
t the
> + * new length of the data section. This macro annotates an array to have=
 an
> + * element count of one with the assumption that this array can be resiz=
ed
> + * within the userspace program. It also annotates the section specifier=
 so
> + * this array exists in a custom sub data section which can be resized
> + * independently.
> + *
> + * See BPF_RESIZE_ARRAY() for the userspace convenience macro for resizi=
ng an
> + * array declared with BPF_RESIZABLE_ARRAY().
> + */
> +#define BPF_RESIZABLE_ARRAY(elfsec, arr) arr[1] SEC("."#elfsec"."#arr)
> +
> +/*
> + * BPF_ARRAY_ELEM_PTR - Obtain the verified pointer to an array element
> + * @arr: array to index into
> + * @i: array index
> + * @n: number of elements in array
> + *
> + * Similar to MEMBER_VPTR() but is intended for use with arrays where th=
e
> + * element count needs to be explicit.
> + * It can be used in cases where a global array is defined with an initi=
al
> + * size but is intended to be be resized before loading the BPF program.
> + * Without this version of the macro, MEMBER_VPTR() will use the compile=
 time
> + * size of the array to compute the max, which will result in rejection =
by
> + * the verifier.
> + */
> +#define BPF_ARRAY_ELEM_PTR(arr, i, n) (typeof(arr[i]) *)({       \
> +       u64 __base =3D (u64)arr;                                    \
> +       u64 __addr =3D (u64)&(arr[i]) - __base;                     \
> +       asm volatile (                                            \
> +               "if %0 <=3D %[max] goto +2\n"                       \
> +               "%0 =3D 0\n"                                        \
> +               "goto +1\n"                                       \
> +               "%0 +=3D %1\n"                                      \
> +               : "+r"(__addr)                                    \
> +               : "r"(__base),                                    \
> +                 [max]"r"(sizeof(arr[0]) * ((n) - 1)));  \
> +       __addr;                                           \
> +})
> +
>  #endif
> --
> 2.46.0
>

