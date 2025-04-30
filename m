Return-Path: <bpf+bounces-57022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45943AA40B2
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 03:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2254E5B76
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 01:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81F813BC02;
	Wed, 30 Apr 2025 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncdz/RdK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB6278F39;
	Wed, 30 Apr 2025 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745977507; cv=none; b=qSH1z+yqEgCwvg12B2ge6/QoJehNPLgMs6ZJe9BzxqPRLciY97RtFVHVxOue9Qb4UMcs6YUGmc5qw4hJVsQC/+8ynRwUOJXRNsybFOCXsBV7GKUbaR1kikoCMbfYruEdmn/i3wV1IBs87KclHHb62DCOJSRy8qSIe5FFdNqLV8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745977507; c=relaxed/simple;
	bh=k0umfqcrL1QGMVN4QfOyBFk1VOZc/btWp3YrFqr/Wkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tit/vHZAcNDjNqhOX0tAbTxNosF/Pc98QNHuFUeuqCSt+7N8iFKD7Id1FS8Qv/qOy9GVKRD7uyuE5MhD7Y5/RGTNbj94qaxCP5+6qr+valsXoBsOIAKpsHuYvn5yCNmEbEHffBncKxhLQE7iX0kd0Ur4waqDXwoRKx+ien1XAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncdz/RdK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-391342fc0b5so4882984f8f.3;
        Tue, 29 Apr 2025 18:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745977503; x=1746582303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RxRxgVqGC67eXDqsgxyqsi6YJLAeLoONFQJpWWAtiM=;
        b=ncdz/RdKTwpl220lB4RjMN/NLcZsiUfrn1RjKLDvtzq/y7DyyLJ1Hx31dg3a4ULKl5
         bOoNnAlJ9Vyrhm65ReT9ynXITllP4C5/uATblL9O/8BGjqCcN4V/NCVi/ok3kthr5n1n
         3IBrJIqKmtZZuag+y22Y8acn1U/8NUMzDlx+dxuuJMSu3pmL70JInpIat0hw3qcUvoRA
         3+Fro42OsoOqWfi0nTIJiCKQ7Fz4lB0wsl2Vb6kdRNwT8s4QfCvI7UZlLbeZtOdQ9gYX
         DGy8JSS+XDLF9vSZ1U/A1FMrCu7gznsspWy6wOkclCblamNfLZ7EmNO9bmucO7sJM8Np
         2uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745977503; x=1746582303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RxRxgVqGC67eXDqsgxyqsi6YJLAeLoONFQJpWWAtiM=;
        b=tx6yhHXKmucZcGjqbAW7/xxEZQqM3j0gidgKrf3FcC/ajANEmPoOAqPBl4hND4X6xd
         9ofoPqMfZY7pdCxhoP8ZUexBLXlo0iWXWnD5A9qRx5T9NqJCAN4KcvJLTfWh/mBJ7Yli
         FP/Xp4Ld3vntsegb5lNvZzb5WB9ig/gLBKKzX/WPZsZ/vgkY/W5HE5fhIVerkbudSjNm
         vR1IZhklzul3mRuuhd2NcUh3sUAK/D+JU4yWCn8qeJukNLxml2bpEulPhHdG6pacjEnS
         MfcNTMof6rB7Xdu3yQ4VnB7grPAwpi1BmrcLHhSOtOclrCzCiNHVq52rkTHt0crCkogu
         pdug==
X-Forwarded-Encrypted: i=1; AJvYcCXdGVukP0zDDq1vziU+Qhi5+icIuJ1aiJzP7j1GoVy841Bo6LYDYuZlT6z6PLp1ZIKaFwVbtGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtpvc/YYOgrCR6w6oV9T6hwXfZv7M7jdd+O0Opw9uvFEVqISi6
	mtoimy38A5k6/Cl1qYKnvEfoKFTcLl1+JgL0JjfdAM46Qtv1NB0h662+8p5QVtbSp0EUa+v39ze
	/35iF5ZHgNBlgFgyovWnHqxlOCS4dhykO
X-Gm-Gg: ASbGnctJ8HeJBWn5oo2K14FkZFsTxx56C3rIT16k30rsImy7R5WTVDwUfVESpZL8VaV
	9t5SvkMQgSrnKFVU+J9YgsCoh+OmlDJZP+UqsumbqG7YMa5KaZ44kNof1pBIFwln1QolvzAs/GA
	2M+KZ9+eYj1I2+kDRDBTFIJmTjZzg+6znsvvE+6w==
X-Google-Smtp-Source: AGHT+IFCvZ2whLo7VIpRh6nzAJ4qKzdDBWv/hDi0hrQPDHGIRUsqOk9+cqRpQJ38O4i94tdebWt3vaPXMditDAtEddA=
X-Received: by 2002:a05:6000:40c9:b0:3a0:831c:e7e5 with SMTP id
 ffacd0b85a97d-3a08ff376cfmr425757f8f.20.1745977502851; Tue, 29 Apr 2025
 18:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425214039.2919818-1-ameryhung@gmail.com> <20250425214039.2919818-2-ameryhung@gmail.com>
In-Reply-To: <20250425214039.2919818-2-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 29 Apr 2025 18:44:50 -0700
X-Gm-Features: ATxdqUFju8TJm9p7AgBQsrrR_sFQrby9ZuScBeK2HyFJ0qEDD4UQ35yod-A4VhY
Message-ID: <CAADnVQKw0C+7bA+trc2DDfX823VZJovdp3Ndcg5yepdd-Y44og@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/2] selftests/bpf: Introduce task local data
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
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
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.c b/t=
ools/testing/selftests/bpf/prog_tests/task_local_data.c
> new file mode 100644
> index 000000000000..5a21514573d2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.c
> @@ -0,0 +1,159 @@
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <pthread.h>
> +
> +#include <bpf/bpf.h>
> +
> +#include "bpf_util.h"
> +#include "task_local_data.h"
> +#include "task_local_storage_helpers.h"
> +
> +#define PIDFD_THREAD       O_EXCL
> +
> +/* To find the start of udata for each thread, insert a dummy variable t=
o udata.

Pls use kernel comment style instead of networking.

> + * Contructors generated for every task local data will figured out the =
offset

constructors.

> + * from the beginning of udata to the dummy symbol. Then, every thread c=
an infer
> + * the start of udata by subtracting the offset from the address of dumm=
y.
> + */

Pls add the full algorithm involving udata_dummy here.
How it can be anywhere in the udata section...
then constructors will keep adjusting udata_start_dummy_off
and eventually km->off -=3D udata_start_dummy_off.
These steps are very tricky.
So big and detailed comments are necessary.

> +static __thread struct udata_dummy {} udata_dummy SEC("udata");
> +
> +static __thread bool task_local_data_thread_inited;
> +
> +struct task_local_data {
> +       void *udata_start;
> +       void *udata_end;
> +       int udata_start_dummy_off;
> +       struct meta_page *umetadata;
> +       int umetadata_cnt;
> +       bool umetadata_init;
> +       short udata_sizes[64];
> +       pthread_mutex_t lock;
> +} task_local_data =3D {
> +       .udata_start =3D (void *)-1UL,
> +       .lock =3D PTHREAD_MUTEX_INITIALIZER,
> +};
> +
> +static void tld_set_data_key_meta(int i, const char *key, short off)
> +{
> +       task_local_data.umetadata->meta[i].off =3D off;
> +       strncpy(task_local_data.umetadata->meta[i].key, key, TASK_LOCAL_D=
ATA_KEY_LEN);
> +}
> +
> +static struct key_meta *tld_get_data_key_meta(int i)
> +{
> +       return &task_local_data.umetadata->meta[i];
> +}
> +
> +static void tld_set_data_size(int i, int size)
> +{
> +       task_local_data.udata_sizes[i] =3D size;
> +}
> +
> +static int tld_get_data_size(int i)
> +{
> +       return task_local_data.udata_sizes[i];
> +}

The above 4 helpers are single use.
If nothing else is using them, open code them directly.
Otherwise it only makes it harder to understand the logic.

> +
> +void __bpf_tld_var_init(const char *key, void *var, int size)
> +{
> +       int i;
> +
> +       i =3D task_local_data.umetadata_cnt++;
> +
> +       if (!task_local_data.umetadata) {
> +               if (task_local_data.umetadata_cnt > 1)
> +                       return;
> +
> +               task_local_data.umetadata =3D aligned_alloc(PAGE_SIZE, PA=
GE_SIZE);
> +               if (!task_local_data.umetadata)
> +                       return;
> +       }
> +
> +       if (var < task_local_data.udata_start) {
> +               task_local_data.udata_start =3D var;
> +               task_local_data.udata_start_dummy_off =3D
> +                       (void *)&udata_dummy - task_local_data.udata_star=
t;
> +       }
> +
> +       if (var + size > task_local_data.udata_end)
> +               task_local_data.udata_end =3D var + size;
> +
> +       tld_set_data_key_meta(i, key, var - (void *)&udata_dummy);
> +       tld_set_data_size(i, size);
> +}
> +
> +int bpf_tld_thread_init(void)
> +{
> +       unsigned long udata_size, udata_start, udata_start_page, udata_en=
d_page;
> +       struct task_local_data_map_value map_val;
> +       int i, task_id, task_fd, map_fd, err;
> +
> +       if (!task_local_data.umetadata_cnt || task_local_data_thread_init=
ed)
> +               return 0;
> +
> +       if (task_local_data.umetadata_cnt && !task_local_data.umetadata)
> +               return -ENOMEM;
> +
> +       udata_start =3D (unsigned long)&udata_dummy + task_local_data.uda=
ta_start_dummy_off;
> +
> +       pthread_mutex_lock(&task_local_data.lock);

can we drop this?

If .c is part of .h just this line will drag -lpthread dependency.
I think it's an artifact on the selftest.
The selftest/library/application can have its own mutex to protect
or this function can use simple xchg() like exclusion
without mutexes.

> +       for (i =3D 0; i < task_local_data.umetadata_cnt; i++) {
> +               struct key_meta *km =3D tld_get_data_key_meta(i);
> +               int size =3D tld_get_data_size(i);
> +               int off;
> +
> +               if (!task_local_data.umetadata_init) {
> +                       /* Constructors save the offset from udata_dummy =
to each data
> +                        * Now as all ctors have run and the offset betwe=
en the start of
> +                        * udata and udata_dummy is known, adjust the off=
sets of data
> +                        * to be relative to the start of udata
> +                        */
> +                       km->off -=3D task_local_data.udata_start_dummy_of=
f;
> +
> +                       /* Data exceeding a page may not be able to be co=
vered by
> +                        * two udata UPTRs in every thread
> +                        */
> +                       if (km->off >=3D PAGE_SIZE)
> +                               return -EOPNOTSUPP;

returns without releasing the mutex...
One more reason to avoid it.

> +               }
> +
> +               /* A task local data should not span across two pages. */
> +               off =3D km->off + udata_start;
> +               if ((off & PAGE_MASK) !=3D ((off + size - 1) & PAGE_MASK)=
)
> +                       return -EOPNOTSUPP;
> +       }
> +       task_local_data.umetadata_init =3D true;
> +       pthread_mutex_unlock(&task_local_data.lock);
> +
> +       udata_size =3D task_local_data.udata_end - task_local_data.udata_=
start;
> +       udata_start_page =3D udata_start & PAGE_MASK;
> +       udata_end_page =3D (udata_start + udata_size) & PAGE_MASK;
> +
> +       /* The whole udata can span across two pages for a thread. Use tw=
o UPTRs
> +        * to cover the second page in case it happens.
> +        */
> +       map_val.udata_start =3D udata_start & ~PAGE_MASK;
> +       map_val.udata[0].page =3D (struct data_page *)(udata_start_page);
> +       map_val.udata[1].page =3D (udata_start_page =3D=3D udata_end_page=
) ? NULL :
> +               (struct data_page *)(udata_start_page + PAGE_SIZE);
> +
> +       /* umetadata is shared by all threads under the assumption that a=
ll
> +        * task local data are defined statically and linked together
> +        */
> +       map_val.umetadata =3D task_local_data.umetadata;
> +       map_val.umetadata_cnt =3D task_local_data.umetadata_cnt;
> +
> +       map_fd =3D bpf_obj_get(TASK_LOCAL_DATA_MAP_PIN_PATH);
> +       if (map_fd < 0)
> +               return -errno;
> +
> +       task_id =3D sys_gettid();
> +       task_fd =3D sys_pidfd_open(task_id, PIDFD_THREAD);
> +       err =3D bpf_map_update_elem(map_fd, &task_fd, &map_val, 0);
> +       if (err)
> +               return err;
> +
> +       task_local_data_thread_inited =3D true;
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/t=
ools/testing/selftests/bpf/prog_tests/task_local_data.h
> new file mode 100644
> index 000000000000..c928e8d2c0a6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> @@ -0,0 +1,58 @@
> +#ifndef __BPF_TASK_LOCAL_DATA_H__
> +#define __BPF_TASK_LOCAL_DATA_H__
> +
> +#include "task_local_data_common.h"
> +
> +#define SEC(name) __attribute__((section(name), used))
> +#define __aligned(x) __attribute__((aligned(x)))
> +
> +#define ROUND_UP_POWER_OF_TWO(x) (1UL << (sizeof(x) * 8 - __builtin_clzl=
(x - 1)))
> +
> +void __bpf_tld_var_init(const char *key, void *var, int size);

If possible, let's try to put everything into .h, so it's easier
to distribute. Otherwise extra .c becomes a headache.

> +
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

Hiding string obfuscates it too much.
This API doesn't have analogous APIs either in bpf or user space.
So let's make everything explicit.
In this case bpf_tld_key_type_var()-like should be the only api
to declare a variable.
I would call it bpf_tld_var().

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
> @@ -0,0 +1,181 @@
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#include "task_local_data_common.h"
> +
> +#define PAGE_IDX_MASK 0x8000
> +
> +/* Overview
> + *
> + * Task local data (TLD) allows sharing per-task information between use=
rs and
> + * bpf programs without explicit storage layout managenent. TLD APIs use=
 to
> + * string keys to access data. Internally, TLD shares user pages throguh=
 two
> + * UPTRs in a task local storage: udata and umetadata. Data are stored i=
n udata.
> + * Keys and the offsets of the corresponding data in udata are stored in=
 umetadata.
> + *
> + * Usage
> + *
> + * Users should initialize every task local data once for every new task=
 before
> + * using them with bpf_tld_init_var(). It should be done ideally in non-=
critical
> + * paths first (e.g., sched_ext_ops::init_task) as it compare key string=
s and
> + * cache the offsets of data.
> + *
> + * First, user should define struct task_local_data_offsets, which will =
be used
> + * to cache the offsets of task local data. Each member of the struct sh=
ould
> + * be a short integer with name same as the key name defined in the user=
 space.
> + * Another task local storage map will be created to save the offsets. F=
or example:
> + *
> + * struct task_local_data_offsets {
> + *     short priority;
> + *     short in_critical_section;
> + * };

The use of 'short' is unusual.
The kernel and bpf progs always use either u16 or s16.

> + *
> + * Task local data APIs take a pointer to bpf_task_local_data object as =
the first
> + * argument. The object should be declared as a stack variable and initi=
alized via
> + * bpf_tld_init(). Then, in a bpf program, to cache the offset for a key=
-value pair,
> + * call bpf_tld_init_var(). For example, in init_task program:
> + *
> + *     struct bpf_task_local_data tld;
> + *
> + *     err =3D bpf_tld_init(task, &tld);
> + *     if (err)
> + *         return 0;
> + *
> + *     bpf_tld_init_var(&tld, priority);
> + *     bpf_tld_init_var(&tld, in_critical_section);
> + *
> + * Subsequently and in other bpf programs, to lookup task local data, ca=
ll
> + * bpf_tld_lookup(). For example:
> + *
> + *     int *p;
> + *
> + *     p =3D bpf_tld_lookup(&tld, priority, sizeof(int));
> + *     if (p)
> + *         // do something depending on *p
> + */
> +
> +struct task_local_data_offsets;
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> +       __type(key, int);
> +       __type(value, struct task_local_data_map_value);
> +       __uint(pinning, LIBBPF_PIN_BY_NAME);
> +} task_local_data_map SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> +       __type(key, int);
> +       __type(value, struct task_local_data_offsets);
> +} task_local_data_off_map SEC(".maps");
> +
> +struct bpf_task_local_data {
> +       struct task_local_data_map_value *data_map;
> +       struct task_local_data_offsets *off_map;
> +};
> +
> +/**
> + * @brief bpf_tld_init() initializes a bpf_task_local_data object.
> + *
> + * @param task The task_struct of the target task
> + * @param tld A pointer to a bpf_task_local_data object to be initialize=
d
> + * @return -EINVAL if task KV store is not initialized by the user space=
 for this task;
> + * -ENOMEM if cached offset map creation fails. In both cases, users can=
 abort, or
> + * conitnue without calling task KV store APIs as if no key-value pairs =
are set.

continue

> + */
> +__attribute__((unused))
> +static int bpf_tld_init(struct task_struct *task, struct bpf_task_local_=
data *tld)
> +{
> +       tld->data_map =3D bpf_task_storage_get(&task_local_data_map, task=
, 0, 0);
> +       if (!tld->data_map)
> +               return -EINVAL;
> +
> +       tld->off_map =3D bpf_task_storage_get(&task_local_data_off_map, t=
ask, 0,
> +                                           BPF_LOCAL_STORAGE_GET_F_CREAT=
E);
> +       if (!tld->off_map)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +/**
> + * @brief bpf_tld_init_var() lookups the metadata with a key and caches =
the offset of
> + * the value corresponding to the key.
> + *
> + * @param tld A pointer to a valid bpf_task_local_data object initialize=
d by bpf_tld_init()
> + * @param key The key used to lookup the task KV store. Should be one of=
 the
> + * symbols defined in struct task_local_data_offsets, not a string
> + */
> +#define bpf_tld_init_var(tld, key)                                     \
> +       ({                                                              \
> +               (tld)->off_map->key =3D bpf_tld_fetch_off(tld, #key);    =
 \
> +       })
> +
> +__attribute__((unused))
> +static short bpf_tld_fetch_off(struct bpf_task_local_data *tld, const ch=
ar *key)
> +{
> +       int i, umetadata_off, umetadata_cnt, udata_start;
> +       void *umetadata, *key_i, *off_i;
> +       short off =3D 0;
> +
> +       if (!tld->data_map || !tld->data_map->umetadata)
> +               goto out;
> +
> +       udata_start =3D tld->data_map->udata_start;
> +       umetadata_cnt =3D tld->data_map->umetadata_cnt;
> +       umetadata =3D tld->data_map->umetadata->meta;
> +
> +       bpf_for(i, 0, umetadata_cnt) {
> +               umetadata_off =3D i * sizeof(struct key_meta);
> +               if (umetadata_off > PAGE_SIZE - sizeof(struct key_meta))
> +                       break;
> +
> +               key_i =3D umetadata + umetadata_off + offsetof(struct key=
_meta, key);
> +               off_i =3D umetadata + umetadata_off + offsetof(struct key=
_meta, off);
> +
> +               if (!bpf_strncmp(key_i, TASK_LOCAL_DATA_KEY_LEN, key)) {
> +                       off =3D *(short *)(off_i) + udata_start;
> +                       if (off >=3D PAGE_SIZE)
> +                               off =3D (off - PAGE_SIZE) | PAGE_IDX_MASK=
;
> +                       /* Shift cached offset by 1 so that 0 means not i=
nitialized */
> +                       off +=3D 1;
> +                       break;
> +               }
> +       }
> +out:
> +       return off;
> +}
> +
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
> diff --git a/tools/testing/selftests/bpf/task_local_data_common.h b/tools=
/testing/selftests/bpf/task_local_data_common.h
> new file mode 100644
> index 000000000000..2a0bb724c77c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/task_local_data_common.h
> @@ -0,0 +1,41 @@
> +#ifndef __BPF_TASK_KV_STORE_COMMON_H__
> +#define __BPF_TASK_KV_STORE_COMMON_H__
> +
> +#ifdef __BPF__
> +struct data_page *dummy_data_page;
> +struct meta_page *dummy_meta_page;
> +#else
> +#define __uptr
> +#endif
> +
> +
> +#define TASK_LOCAL_DATA_MAP_PIN_PATH "/sys/fs/bpf/task_local_data_map"
> +#define TASK_LOCAL_DATA_KEY_LEN 62
> +#define PAGE_SIZE 4096

We have
enum page_size_enum {
        __PAGE_SIZE =3D PAGE_SIZE
};
inside kernel/bpf/core.c

and bpf progs that include vmlinux.h can use it directly as __PAGE_SIZE.

Let's think through upfront how the whole thing works on
architectures with different page size.

> +#define PAGE_MASK (~(PAGE_SIZE - 1))
> +
> +struct data_page {
> +       char data[PAGE_SIZE];
> +};
> +
> +struct data_page_entry {
> +       struct data_page __uptr *page;
> +};
> +
> +struct key_meta {
> +       char key[TASK_LOCAL_DATA_KEY_LEN];
> +       short off;
> +};
> +
> +struct meta_page {
> +       struct key_meta meta[64];
> +};
> +
> +struct task_local_data_map_value {
> +       struct data_page_entry udata[2];
> +       struct meta_page __uptr *umetadata;
> +       short umetadata_cnt;
> +       short udata_start;
> +};
> +
> +#endif
> --
> 2.47.1
>

