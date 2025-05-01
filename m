Return-Path: <bpf+bounces-57150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04510AA64D4
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 22:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFE59A6DE7
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 20:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F0E2517BE;
	Thu,  1 May 2025 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM4pZNgC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A25020C01C;
	Thu,  1 May 2025 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746131950; cv=none; b=FPdqzOXxbGoVtQklUaNMiZNB3VruET564B+zy1RNGCGuov39nrHRlTnju7lUGtgWYLpaLV6ThWcY0IJLjFQZQ+otAxtqriX5QgSr7Z8u8ZyyCapFIQ7QGe6ImB25e8QnYZjejUbtfZQ3LG9jZIsm3cIc7WD08PsEqgrVNeSmcDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746131950; c=relaxed/simple;
	bh=FzwEqDCVvlbPwWXebjczOJvlWo3kYB4q1VgWg7JQywc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHZ7LhTIwrmEFfCCfalZ490BAxOnXlObYcqI13tz4/4jwa7Ly5RK+h8xxuQqBk0DzMO4LlxaDkaSQPj/i5omCa38zLgNzayDHhNZMTQHsrevSgvyq+nRDSw3KvYY+s2o7ab6SqCouGE+z30f65t5Xe2klYjBd3NRV7XqgxTQHl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YM4pZNgC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30863b48553so2525164a91.0;
        Thu, 01 May 2025 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746131948; x=1746736748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJVS3idZLRV49u/t4QlMhyjWlKBkg63RsOffp6qhcjE=;
        b=YM4pZNgCtDHqlScJ830oQze9ZX6vkRh0RFHOWmqsXLg5ZdAt+JsrebwQd9z6DCuaBh
         vEabjWUSieuSRW7LC4JrgLPf2v3vVFRCXZ3agVPWKayck9RdfTAewrFAXc16vavKPB4P
         7N8WfhUilqAv6D+o9VrcdJUCJSm7+o03Aq/q+7rQrAaiQIjsY8dqBJzH+aMCS2A7augo
         l12v0bfL0KVqCMPEC0DlUdOBqDcaXUJMoBvYlr80pGnwlFC6dW0kWo+9BcqbDyuelest
         /MqswxcI3civHbuNCClnOvOA3/ltPCUes12EyaO4borhgK7vY+xeU57+opHCKiJ4rfkY
         SzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746131948; x=1746736748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJVS3idZLRV49u/t4QlMhyjWlKBkg63RsOffp6qhcjE=;
        b=UYbuCuyrlgBKf8f9xb6gJEEiAns1dUJvxfdlyCPxcL962Nwz3QrHd71HM4Gusnq9oK
         m5KGaqEebwFvXsUU/akLKbkCjySvgfZGrdW0aFbHAsGheR1847rzQrUD3W3L1YrK2/Uh
         +NW/mPCIU2qxgC6+vgi/MdR+Ig4PoyrynPqR7oA4Bw1HCHEMErta+6S6nG6cDA1drNEA
         v141iXpcyyg3YKrpxXxsNRvuWi/uTxtYaZ2KKmrORoGgQ/5xy58qeTX3Somy8x0rxX7Y
         Bq8jD/8j5OGmekLp3prZTeeJfOtoZEVcC2XWQrnAdlYrvrNe1JU4rRIJO1FBSRAaNT0b
         mspA==
X-Forwarded-Encrypted: i=1; AJvYcCWsL8G/boafAZpa3k9NLkzXMM/y5TPe7Uq3EX/vrXNtigE/YUV4JssrAlT4lVxR8PxKJJwgMWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7XTuDu+Mvuggryv6vW1T6YpyxWzrFt5eHCbMvD1Hbn0LJTpzC
	0liNfE208pAppUR1YUOT7CgEHaHoKO18bqCVkDKKTX/+d9zhttCE6t9SJJOvYiwX6MB8mN3CUA4
	JE3Go0WAhJdA2mopMVeUZEeQUDuU=
X-Gm-Gg: ASbGnctyyj1WFUdfq1l78xbGutbECae+uxl2gZsuvp8XIoPkPvYnMwYboFdNzeevCEG
	JLD6OrxIbTrQXLA2l5p1sU9oUUguWVw0IVD3DS6J6xSybuWMLy9WITgXy6dqB6/7REgyPytxNtX
	9UUCUdRZivGd9K+KzOyWtUsuDEVYCRwyPKeEG/8g==
X-Google-Smtp-Source: AGHT+IFxuDr78XaNERoH6hYEosFjz9Xexd2AKnFwjurACdm/j6zWv9DiAFvhQjUY3vX6O+OP6ssbQm9uORrP0OgLiYQ=
X-Received: by 2002:a17:90b:5787:b0:2fa:6793:e860 with SMTP id
 98e67ed59e1d1-30a42a61722mr6166070a91.0.1746131947706; Thu, 01 May 2025
 13:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425214039.2919818-1-ameryhung@gmail.com> <20250425214039.2919818-2-ameryhung@gmail.com>
In-Reply-To: <20250425214039.2919818-2-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 May 2025 13:38:55 -0700
X-Gm-Features: ATxdqUErjQbf7HaDYUxedJ2SVgF0i-ryuzepF2ukLrap9nRDwza5tR36M_G_5vE
Message-ID: <CAEf4BzaFzSmLDOu=GQk=0p9NoDn2boVBSBRm4Ejh3BdVB6bmSQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/2] selftests/bpf: Introduce task local data
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 2:40=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Task local data provides simple and fast bpf and user space APIs to
> exchange per-task data through task local storage map. The user space
> first declares task local data using bpf_tld_type_key_var() or
> bpf_tld_type_var(). The data is a thread-specific variable which
> every thread has its own copy. Then, a bpf_tld_thread_init() needs to
> be called for every thread to share the data with bpf. Finally, users
> can directly read/write thread local data without bpf syscall.
>
> For bpf programs to see task local data, every data need to be
> initialized once for every new task using bpf_tld_init_var(). Then
> bpf programs can retrieve pointers to the data with bpf_tld_lookup().
>
> The core of task local storage implementation relies on UPTRs. They
> pin user pages to the kernel so that user space can share data with bpf
> programs without syscalls. Both data and the metadata used to access
> data are pinned via UPTRs.
>
> A limitation of UPTR makes the implementation of task local data
> less trivial than it sounds: memory pinned to UPTR cannot exceed a
> page and must not cross the page boundary. In addition, the data
> declaration uses __thread identifier and therefore does not have
> directly control over the memory allocation. Therefore, several
> tricks and checks are used to make it work.
>
> First, task local data declaration APIs place data in a custom "udata"
> section so that data from different compilation units will be contiguous
> in the memory and can be pinned using two UPTRs if they are smaller than
> one page.
>
> To avoid each data from spanning across two pages, they are each aligned
> to the smallest power of two larget than their sizes.
>
> As we don't control the memory allocation for data, we need to figure
> out the layout of user defined data. This is done by the data
> declaration API and bpf_tld_thread_init(). The data declaration API
> will insert constructors for all data, and they are used to find the
> size and offset of data as well as the beginning and end of the whole
> udata section. Then, bpf_tld_thread_init() performs a per-thread check
> to make sure no data will cross the page boundary as udata can start at
> different offset in a page.
>
> Note that for umetadata, we directly aligned_alloc() memory for it and
> assigned to the UPTR. This is only done once for every process as every
> tasks shares the same umetadata. The actual thread-specific data offset
> will be adjusted in the bpf program when calling bpf_tld_init_var().
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../bpf/prog_tests/task_local_data.c          | 159 +++++++++++++++
>  .../bpf/prog_tests/task_local_data.h          |  58 ++++++
>  .../selftests/bpf/progs/task_local_data.h     | 181 ++++++++++++++++++
>  .../selftests/bpf/task_local_data_common.h    |  41 ++++
>  4 files changed, 439 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_dat=
a.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_dat=
a.h
>  create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.h
>  create mode 100644 tools/testing/selftests/bpf/task_local_data_common.h
>

[...]

> +/**
> + * @brief bpf_tld_key_type_var() declares a task local data shared with =
bpf
> + * programs. The data will be a thread-specific variable which a user sp=
ace
> + * program can directly read/write, while bpf programs will need to look=
up
> + * with the string key.
> + *
> + * @param key The string key a task local data will be associated with. =
The
> + * string will be truncated if the length exceeds TASK_LOCAL_DATA_KEY_LE=
N
> + * @param type The type of the task local data
> + * @param var The name of the task local data
> + */
> +#define bpf_tld_key_type_var(key, type, var)                            =
       \
> +__thread type var SEC("udata") __aligned(ROUND_UP_POWER_OF_TWO(sizeof(ty=
pe))); \
> +                                                                        =
       \
> +__attribute__((constructor))                                            =
       \
> +void __bpf_tld_##var##_init(void)                                       =
       \
> +{                                                                       =
       \
> +       _Static_assert(sizeof(type) < PAGE_SIZE,                         =
       \
> +                      "data size must not exceed a page");              =
       \
> +       __bpf_tld_var_init(key, &var, sizeof(type));                     =
       \
> +}
> +
> +/**
> + * @brief bpf_tld_key_type_var() declares a task local data shared with =
bpf

declares -> defines, declaration would involve extern and no storage
allocated (it's only to reference something *defined* in another
compilation unit)

> + * programs. The data will be a thread-specific variable which a user sp=
ace
> + * program can directly read/write, while bpf programs will need to look=
up
> + * the data with the string key same as the variable name.
> + *
> + * @param type The type of the task local data
> + * @param var The name of the task local data as well as the name of the
> + * key. The key string will be truncated if the length exceeds
> + * TASK_LOCAL_DATA_KEY_LEN.
> + */
> +#define bpf_tld_type_var(type, var) \
> +       bpf_tld_key_type_var(#var, type, var)
> +
> +/**
> + * @brief bpf_tld_thread_init() initializes the task local data for the =
current
> + * thread. All data are undefined from a bpf program's point of view unt=
il
> + * bpf_tld_thread_init() is called.
> + *
> + * @return 0 on success; negative error number on failure
> + */
> +int bpf_tld_thread_init(void);
> +
> +#endif
> diff --git a/tools/testing/selftests/bpf/progs/task_local_data.h b/tools/=
testing/selftests/bpf/progs/task_local_data.h
> new file mode 100644
> index 000000000000..7358993ee634
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/task_local_data.h

given this is BPF-only header, I'd make it more explicit by using
.bpf.h suffix, just like libbpf's usdt.bpf.h

[...]

> +/**
> + * @brief bpf_tld_lookup() lookups the task KV store using the cached of=
fset
> + * corresponding to the key.
> + *
> + * @param tld A pointer to a valid bpf_task_local_data object initialize=
d by bpf_tld_init()
> + * @param key The key used to lookup the task KV store. Should be one of=
 the
> + * symbols defined in struct task_local_data_offsets, not a string
> + * @param size The size of the value. Must be a known constant value
> + * @return A pointer to the value corresponding to the key; NULL if the =
offset
> + * if not cached or the size is too big
> + */
> +#define bpf_tld_lookup(tld, key, size) __bpf_tld_lookup(tld, (tld)->off_=
map->key, size)
> +__attribute__((unused))
> +static void *__bpf_tld_lookup(struct bpf_task_local_data *tld, short cac=
hed_off, int size)

I'd probably use some opaque type for these offsets to discourage user
application to try to create them, instead of strictly using offsets
returned from API. So:

typedef struct { int off; } tld_off_t;

and then just use tld_off_t everywhere?


> +{
> +       short page_off, page_idx;
> +
> +       if (!cached_off--)
> +               return NULL;
> +
> +       page_off =3D cached_off & ~PAGE_IDX_MASK;
> +       page_idx =3D !!(cached_off & PAGE_IDX_MASK);
> +
> +       if (page_idx) {
> +               return (tld->data_map->udata[1].page && page_off < PAGE_S=
IZE - size) ?
> +                       (void *)tld->data_map->udata[1].page + page_off :=
 NULL;
> +       } else {
> +               return (tld->data_map->udata[0].page && page_off < PAGE_S=
IZE - size) ?
> +                       (void *)tld->data_map->udata[0].page + page_off :=
 NULL;
> +       }
> +}

[...]

