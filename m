Return-Path: <bpf+bounces-72350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB73C0F605
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 17:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF9E54E8957
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 16:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003193148A0;
	Mon, 27 Oct 2025 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmFyTw6A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695641E5B72
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582888; cv=none; b=lPno0Qu2x1esw/y3il/MiV3YP0XeBAmtQnJqeXArWdsg533P12R5HTI6yc0B7xKepaVMzalq+rlI6mHqFaW9xhIwD6o76sdaNl7viiVf7Xh686cc5blScHshYyEFT6dF5O/DjBQ51T/dQ0/Z7Yx2dHGN3rRB+YbROz4rjIoNH3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582888; c=relaxed/simple;
	bh=n5TEM1afolr0fvJZtAfC1qG7H/lr9VlwwwTcdaPzfRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlIb588jPsn45lMgpIxt8s8JHI3WX0tYA/xOhyVs5ulzihNcUpjr5blp3wKUKi1TFxuwCy/xpwLU4OMdXbuS7HyuGWN1AzgZ9HtmsQnv+D+Tu1LkkiH0b3TODz1j1F4LUkJzXrTFpLL6Q1c34Aa7Q8//HqL6SQ2LW7emsvINCAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmFyTw6A; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63d0692136bso5732499d50.1
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761582885; x=1762187685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nyWKGU091VIE4/s/XIlw2whglPJqy2Jcesh+HJLjU4=;
        b=OmFyTw6AsaS4VxLQ7QzNBderkSQFMeW+VUdnIteh/IxXJqNErZf8Q7KF6JiC8IgMo2
         XClWQsXDVmjB2iQU9WdQonfeXcB7PQ07udENkSy8LYqiuv6tJ86QPmOZj3PmBw+8JsRT
         tc40UnBZzJj0RfesbIsdv4F2BEi4YRhect44QUnZSF+joK0MrlH5h7MnH2i3YBJgRR6V
         hg5GKJi+BZQUPzEa4/C+MB/OEFkWG7xK6iqYRLvmcyc62xrBj2dLZ5sUCK4xmmImtu72
         GBL+5/7ASH8THmZi3oRiy2IJE2ICp9epx6W+gmB/dRceSvzYEfQkJuggqKJ9/lJnBir5
         eFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761582885; x=1762187685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nyWKGU091VIE4/s/XIlw2whglPJqy2Jcesh+HJLjU4=;
        b=WMJ6C/cphlTEiAzjof4OlL34FIeMotWl/8YF4B+MtzLfCHbOSI6iOcXx8ziug+wij5
         gZadJFGDAWuveBPjGFwA4Nco1FkLuCjk8L/h2OcV29A2QMHgyQ4HQZB3YZHRK3gDfHRt
         /6GMRaTrXHSH/3oe1hzSQD5dNwH33WlgUv609BQfaiL7P5gscPvKDWxKYeDSVjHjKh/B
         gilQeI4uCgVSvy0EL1P8YhiuZMm7bjhQ8DDk+jU0WYfgg2EizoF2Vp92J+r8VqBxxGdW
         lbGBEO/OMAtLW/ELHYm+ivkE7ZDUEUOJiX7y0OOwy4Fggu4XUoL/J1TLA4e679qcG0bP
         Yh3A==
X-Gm-Message-State: AOJu0YyB93O6QlmUU3IP1ZRmfObZvickO/sVVNgfobcJ3OLyOztf0qCl
	p7uVxRa2BBMWE0Ghinu1ZvdT6OgY0AE9mPWlqrhPUA/NPGSIj8iaQnjeojk7pMgIQLOZlOrrrr0
	3OwOH0ysGKZ9J4fMysNo6NHi7kqj/YEj/h6rP
X-Gm-Gg: ASbGncuSCkw8LJ+iPumKxs6H285AimXFZ3kiu6+23qRDDltgh6WctJA6JnEv5SAHz05
	Y/rpBy0G3olnrlvITpMz4TAgSdm0BsNwiiJQpeJB0a9kWVC10lerJaO+GP8ujABPjnW6AVad37T
	HRuEomwwmQm/F+tiY3G/0J6+KCjnrGbmpjx7MUR6QCWMim6upnSKpVRdOqC9Gc4TngWt3PNefIA
	W+RU7af3xJGTe5UpI56ywAnp/tAmzSWGEgQUoB/319yr3huuu6PIUcG9izh
X-Google-Smtp-Source: AGHT+IEh4YlQX4psHQhxloclmAiDeafwHZKvyYl+2SjsEySdI2EWeMnulzFvj5VKI7ep/5g5P/lLQwr/NDdnMiJCnHQ=
X-Received: by 2002:a53:bb51:0:b0:63f:2db0:9968 with SMTP id
 956f58d0204a3-63f6ba7c459mr382922d50.44.1761582885138; Mon, 27 Oct 2025
 09:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026154000.34151-1-leon.hwang@linux.dev> <20251026154000.34151-5-leon.hwang@linux.dev>
In-Reply-To: <20251026154000.34151-5-leon.hwang@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 27 Oct 2025 09:34:32 -0700
X-Gm-Features: AWmQ_bnMZlWvfUEnkUckZL1A05xlSxYdkEQi_S_1L9zXig7AURZggoQVtHsOKI4
Message-ID: <CAMB2axN6bsrMH6_qVz9eHY1HLp6SQmM-nOUEXUOOiibZFMzXMw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 4/4] selftests/bpf: Add tests to verify freeing the
 special fields when update hash and local storage maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	memxor@gmail.com, linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 8:42=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Add tests to verify that updating hash and local storage maps decrements
> refcount when BPF_KPTR_REF objects are involved.
>
> The tests perform the following steps:
>
> 1. Call update_elem() to insert an initial value.
> 2. Use bpf_refcount_acquire() to increment the refcount.
> 3. Store the node pointer in the map value.
> 4. Add the node to a linked list.
> 5. Probe-read the refcount and verify it is *2*.
> 6. Call update_elem() again to trigger refcount decrement.
> 7. Probe-read the refcount and verify it is *1*.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  .../bpf/prog_tests/refcounted_kptr.c          | 178 +++++++++++++++++-
>  .../selftests/bpf/progs/refcounted_kptr.c     | 160 ++++++++++++++++
>  2 files changed, 337 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/t=
ools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
> index d6bd5e16e6372..0a60330a1f4b3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
> @@ -3,7 +3,7 @@
>
>  #include <test_progs.h>
>  #include <network_helpers.h>
> -
> +#include "cgroup_helpers.h"
>  #include "refcounted_kptr.skel.h"
>  #include "refcounted_kptr_fail.skel.h"
>
> @@ -44,3 +44,179 @@ void test_refcounted_kptr_wrong_owner(void)
>         ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a2 retval"=
);
>         refcounted_kptr__destroy(skel);
>  }
> +
> +static void test_refcnt_leak(void *values, size_t values_sz, u64 flags, =
struct bpf_map *map,
> +                            struct bpf_program *prog_leak, struct bpf_pr=
ogram *prog_check)
> +{
> +       int ret, fd, key =3D 0;
> +       LIBBPF_OPTS(bpf_test_run_opts, opts,
> +                   .data_in =3D &pkt_v4,
> +                   .data_size_in =3D sizeof(pkt_v4),
> +                   .repeat =3D 1,
> +       );
> +
> +       ret =3D bpf_map__update_elem(map, &key, sizeof(key), values, valu=
es_sz, flags);
> +       if (!ASSERT_OK(ret, "bpf_map__update_elem init"))
> +               return;
> +
> +       fd =3D bpf_program__fd(prog_leak);
> +       ret =3D bpf_prog_test_run_opts(fd, &opts);
> +       if (!ASSERT_OK(ret, "test_run_opts"))
> +               return;
> +       if (!ASSERT_EQ(opts.retval, 2, "retval refcount"))
> +               return;
> +
> +       ret =3D bpf_map__update_elem(map, &key, sizeof(key), values, valu=
es_sz, flags);
> +       if (!ASSERT_OK(ret, "bpf_map__update_elem dec refcount"))
> +               return;
> +
> +       fd =3D bpf_program__fd(prog_check);
> +       ret =3D bpf_prog_test_run_opts(fd, &opts);
> +       ASSERT_OK(ret, "test_run_opts");
> +       ASSERT_EQ(opts.retval, 1, "retval");
> +}

Just use syscall BPF programs across different subtests, and you can
share this test_refcnt_leak() across subtests.

It also saves you some code setting up bpf_test_run_opts. You can just
call bpf_prog_test_run_opts(prog_fd, NULL) as you don't pass any input
from ctx.

> +
> +static void test_percpu_hash_refcount_leak(void)
> +{
> +       struct refcounted_kptr *skel;
> +       size_t values_sz;
> +       u64 *values;
> +       int cpu_nr;
> +
> +       cpu_nr =3D libbpf_num_possible_cpus();
> +       if (!ASSERT_GT(cpu_nr, 0, "libbpf_num_possible_cpus"))
> +               return;
> +
> +       values =3D calloc(cpu_nr, sizeof(u64));
> +       if (!ASSERT_OK_PTR(values, "calloc values"))
> +               return;
> +
> +       skel =3D refcounted_kptr__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load")) {
> +               free(values);
> +               return;
> +       }
> +
> +       values_sz =3D cpu_nr * sizeof(u64);
> +       memset(values, 0, values_sz);
> +
> +       test_refcnt_leak(values, values_sz, 0, skel->maps.pcpu_hash,
> +                        skel->progs.pcpu_hash_refcount_leak,
> +                        skel->progs.check_pcpu_hash_refcount);
> +
> +       refcounted_kptr__destroy(skel);
> +       free(values);
> +}
> +
> +struct lock_map_value {
> +       u64 kptr;
> +       struct bpf_spin_lock lock;
> +       int value;
> +};
> +
> +static void test_hash_lock_refcount_leak(void)
> +{
> +       struct lock_map_value value =3D {};
> +       struct refcounted_kptr *skel;
> +
> +       skel =3D refcounted_kptr__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load"))
> +               return;
> +
> +       test_refcnt_leak(&value, sizeof(value), BPF_F_LOCK, skel->maps.lo=
ck_hash,
> +                        skel->progs.hash_lock_refcount_leak,
> +                        skel->progs.check_hash_lock_refcount);
> +
> +       refcounted_kptr__destroy(skel);
> +}
> +
> +static void test_cgrp_storage_refcount_leak(u64 flags)
> +{
> +       int server_fd =3D -1, client_fd =3D -1;
> +       struct lock_map_value value =3D {};
> +       struct refcounted_kptr *skel;
> +       struct bpf_link *link;
> +       struct bpf_map *map;
> +       int cgroup, err;
> +
> +       cgroup =3D test__join_cgroup("/cg_refcount_leak");
> +       if (!ASSERT_GE(cgroup, 0, "test__join_cgroup"))
> +               return;
> +
> +       skel =3D refcounted_kptr__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load"))
> +               goto out;
> +
> +       link =3D bpf_program__attach_cgroup(skel->progs.cgroup_storage_re=
fcount_leak, cgroup);
> +       if (!ASSERT_OK_PTR(link, "bpf_program__attach_cgroup"))
> +               goto out;
> +       skel->links.cgroup_storage_refcount_leak =3D link;
> +
> +       server_fd =3D start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
> +       if (!ASSERT_GE(server_fd, 0, "start_server"))
> +               goto out;
> +
> +       client_fd =3D connect_to_fd(server_fd, 0);
> +       if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
> +               goto out;
> +
> +       map =3D skel->maps.cgrp_strg;
> +       err =3D bpf_map__lookup_elem(map, &cgroup, sizeof(cgroup), &value=
, sizeof(value), flags);
> +       if (!ASSERT_OK(err, "bpf_map__lookup_elem"))
> +               goto out;
> +
> +       ASSERT_EQ(value.value, 2, "refcount");
> +
> +       err =3D bpf_map__update_elem(map, &cgroup, sizeof(cgroup), &value=
, sizeof(value), flags);
> +       if (!ASSERT_OK(err, "bpf_map__update_elem"))
> +               goto out;
> +
> +       err =3D bpf_link__detach(skel->links.cgroup_storage_refcount_leak=
);
> +       if (!ASSERT_OK(err, "bpf_link__detach"))
> +               goto out;
> +
> +       link =3D bpf_program__attach(skel->progs.check_cgroup_storage_ref=
count);
> +       if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
> +               goto out;
> +       skel->links.check_cgroup_storage_refcount =3D link;
> +
> +       close(client_fd);
> +       client_fd =3D connect_to_fd(server_fd, 0);
> +       if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
> +               goto out;
> +
> +       err =3D bpf_map__lookup_elem(map, &cgroup, sizeof(cgroup), &value=
, sizeof(value), flags);
> +       if (!ASSERT_OK(err, "bpf_map__lookup_elem"))
> +               goto out;
> +
> +       ASSERT_EQ(value.value, 1, "refcount");
> +out:
> +       close(cgroup);
> +       refcounted_kptr__destroy(skel);
> +       if (client_fd >=3D 0)
> +               close(client_fd);
> +       if (server_fd >=3D 0)
> +               close(server_fd);
> +}

Then, you won't need to set up server, connection.... just to
read/write cgroup local storage. Just call test_refcnt_leak() that
runs the two BPF syscall programs for cgroup local storage.

> +
> +static void test_cgroup_storage_refcount_leak(void)
> +{
> +       test_cgrp_storage_refcount_leak(0);
> +}
> +
> +static void test_cgroup_storage_lock_refcount_leak(void)
> +{
> +       test_cgrp_storage_refcount_leak(BPF_F_LOCK);
> +}
> +
> +void test_kptr_refcount_leak(void)
> +{
> +       if (test__start_subtest("percpu_hash_refcount_leak"))
> +               test_percpu_hash_refcount_leak();
> +       if (test__start_subtest("hash_lock_refcount_leak"))
> +               test_hash_lock_refcount_leak();
> +       if (test__start_subtest("cgroup_storage_refcount_leak"))
> +               test_cgroup_storage_refcount_leak();
> +       if (test__start_subtest("cgroup_storage_lock_refcount_leak"))
> +               test_cgroup_storage_lock_refcount_leak();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/=
testing/selftests/bpf/progs/refcounted_kptr.c
> index 893a4fdb4b6e9..09efae9537c9b 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> @@ -7,6 +7,7 @@
>  #include <bpf/bpf_core_read.h>
>  #include "bpf_misc.h"
>  #include "bpf_experimental.h"
> +#include "bpf_tracing_net.h"
>
>  extern void bpf_rcu_read_lock(void) __ksym;
>  extern void bpf_rcu_read_unlock(void) __ksym;
> @@ -568,4 +569,163 @@ int BPF_PROG(rbtree_sleepable_rcu_no_explicit_rcu_l=
ock,
>         return 0;
>  }
>
> +private(leak) u64 ref;
> +
> +static u32 probe_read_refcount(void)
> +{
> +       u32 refcnt;
> +
> +       bpf_probe_read_kernel(&refcnt, sizeof(refcnt), (void *) ref);
> +       return refcnt;
> +}
> +
> +static int __insert_in_list(struct bpf_list_head *head, struct bpf_spin_=
lock *lock,
> +                           struct node_data __kptr **node)
> +{
> +       struct node_data *n, *m;
> +
> +       n =3D bpf_obj_new(typeof(*n));
> +       if (!n)
> +               return -1;
> +
> +       m =3D bpf_refcount_acquire(n);
> +       n =3D bpf_kptr_xchg(node, n);
> +       if (n) {
> +               bpf_obj_drop(n);
> +               bpf_obj_drop(m);
> +               return -2;
> +       }
> +
> +       bpf_spin_lock(lock);
> +       bpf_list_push_front(head, &m->l);
> +       ref =3D (u64)(void *) &m->ref;
> +       bpf_spin_unlock(lock);
> +       return probe_read_refcount();
> +}
> +
> +static void *__lookup_map(void *map)
> +{
> +       int key =3D 0;
> +
> +       return bpf_map_lookup_elem(map, &key);
> +}
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERCPU_HASH);
> +       __type(key, int);
> +       __type(value, struct map_value);
> +       __uint(max_entries, 1);
> +} pcpu_hash SEC(".maps");
> +
> +SEC("tc")
> +int pcpu_hash_refcount_leak(void *ctx)
> +{
> +       struct map_value *v;
> +
> +       v =3D __lookup_map(&pcpu_hash);
> +       if (!v)
> +               return 0;
> +
> +       return __insert_in_list(&head, &lock, &v->node);
> +}
> +
> +SEC("tc")
> +int check_pcpu_hash_refcount(void *ctx)
> +{
> +       return probe_read_refcount();
> +}
> +
> +struct lock_map_value {
> +       struct node_data __kptr *node;
> +       struct bpf_spin_lock lock;
> +       int value;
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __type(key, int);
> +       __type(value, struct lock_map_value);
> +       __uint(max_entries, 1);
> +} lock_hash SEC(".maps");
> +
> +SEC("tc")
> +int hash_lock_refcount_leak(void *ctx)
> +{
> +       struct lock_map_value *v;
> +
> +       v =3D __lookup_map(&lock_hash);
> +       if (!v)
> +               return 0;
> +
> +       bpf_spin_lock(&v->lock);
> +       v->value =3D 42;
> +       bpf_spin_unlock(&v->lock);
> +       return __insert_in_list(&head, &lock, &v->node);
> +}
> +
> +SEC("tc")
> +int check_hash_lock_refcount(void *ctx)
> +{
> +       return probe_read_refcount();
> +}
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> +       __type(key, int);
> +       __type(value, struct lock_map_value);
> +} cgrp_strg SEC(".maps");
> +
> +SEC("cgroup/connect6")
> +int cgroup_storage_refcount_leak(struct bpf_sock_addr *ctx)
> +{
> +       struct lock_map_value *v;
> +       struct tcp_sock *tsk;
> +       struct bpf_sock *sk;
> +       u32 refcnt;
> +
> +       if (ctx->family !=3D AF_INET6 || ctx->user_family !=3D AF_INET6)
> +               return 1;
> +
> +       sk =3D ctx->sk;
> +       if (!sk)
> +               return 1;
> +
> +       tsk =3D bpf_skc_to_tcp_sock(sk);
> +       if (!tsk)
> +               return 1;
> +
> +       v =3D bpf_cgrp_storage_get(&cgrp_strg, tsk->inet_conn.icsk_inet.s=
k.sk_cgrp_data.cgroup, 0,
> +                                BPF_LOCAL_STORAGE_GET_F_CREATE);
> +       if (!v)
> +               return 1;
> +
> +       refcnt =3D __insert_in_list(&head, &lock, &v->node);
> +       bpf_spin_lock(&v->lock);
> +       v->value =3D refcnt;
> +       bpf_spin_unlock(&v->lock);
> +       return 1;
> +}


And in syscall BPF program, you can simply get the cgroup through the
current task

SEC("syscall")
int syscall_prog(void *ctx)
{
        struct task_struct *task =3D bpf_get_current_task_btf();

        v =3D bpf_cgrp_storage_get(&cgrp_strg, task->cgroups->dfl_cgrp, 0,
                               BPF_LOCAL_STORAGE_GET_F_CREATE);
        ...
}

> +
> +SEC("fexit/inet_stream_connect")
> +int BPF_PROG(check_cgroup_storage_refcount, struct socket *sock, struct =
sockaddr *uaddr, int addr_len,
> +            int flags)
> +{
> +       struct lock_map_value *v;
> +       u32 refcnt;
> +
> +       if (uaddr->sa_family !=3D AF_INET6)
> +               return 0;
> +
> +       v =3D bpf_cgrp_storage_get(&cgrp_strg, sock->sk->sk_cgrp_data.cgr=
oup, 0, 0);
> +       if (!v)
> +               return 0;
> +
> +       refcnt =3D probe_read_refcount();
> +       bpf_spin_lock(&v->lock);
> +       v->value =3D refcnt;
> +       bpf_spin_unlock(&v->lock);
> +       return 0;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.51.0
>
>

