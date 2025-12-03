Return-Path: <bpf+bounces-75993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23683CA1D7B
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 23:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D5853008F95
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 22:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C302E1C63;
	Wed,  3 Dec 2025 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMhfdX69"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671752EA46B
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801435; cv=none; b=dtkG9Q3uWWutzVtT9cJEJRV6DwobanOUO6KrmeJ5LoBJ44taWWSIZoPNxlGhqwSAzgk5IL6DUQ2j4ed0IkJW2tZlukzlhlz6agR0T8dI0+9LTwITNWq04HRPhj2o60vZKyI8j26T6cfV0Duft3vcJuPDLJCRIBNxkcQU+Uifp90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801435; c=relaxed/simple;
	bh=mPrnvOVSYgfETvZmZAt6+Az2NrActSlwSEDOpSB9Ghk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahwfn2oNkIljJzplkRl7hAcxUGUtZDg9Ro/Glw4XeRpKFPE9ZrcojaiqJEz5PFLWBgGcPH0UGWK00G08et8f2lcHhmj5viMAeIYLS+ITrUtOjhaIcMDyMubd8Vx/Ai6Ys1RxR6xBG9AA4eM7v5jw3wUZNqtddRSpOD/Lml/NaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMhfdX69; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63f96d5038dso208892d50.1
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 14:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764801427; x=1765406227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Cujta6JWz/WFXQf6Ok4rATck9vEnRI9aUBXhqN7AD0=;
        b=MMhfdX69YBKmWLjowFhfr61I45mERrHWddGeGYOmW267gBopIwIuf9oY9XM5sf/0oG
         yXrljxt9cn6LwuF0kuc5sGS2SKyOMGjJ0AcQu05UpFsxiOYum3zoYtQz+cLRShit3mZq
         5llSslWkURcUPqm0XVh3jVwhTZwqKMzs5AmMtTHkW2KF+8U+0GCXSMFPGQmOdOM7OECC
         f5tWA+IpFyMMRHy1JdOUQz5DsnzwexaR/medY0gjna1E1fo8uMorgHgPzHA3SbtXMYPk
         8IAz2D1fg6H1BL9FVcaoCSj5LbAD0kYpxA+RYc1acUtxQLVFNVShoUyYQ6dgiGOKujJd
         O8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764801427; x=1765406227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Cujta6JWz/WFXQf6Ok4rATck9vEnRI9aUBXhqN7AD0=;
        b=usJhPA8mRZ46oeJE3SVFkVQeeQIGy43WROSngK6CNvflwcYhl/RsrNB88HgkWH6Dh/
         N65hhRNgwkzU8AqCZoJJux94VfWq+BrYGoPtV5fbnrq5hSbb/5yxCGZN1nTDJTXlCe9H
         TpDb5bTBV/FusPqqXqYh4gSME0osruuDXCv8GpDLIrqobi+wzEkDHNepZ5vLfK+xj6Gq
         e47WGK1QoBzGFdJyIKaq6iwh8XYstUSMR7jsssdkBrtSYxpSjdHGmIvumqxSOqPrtBDI
         nxMfw9txjFiUf+BtWoyN8MVoL+BEeBQUI9XXaLuR5f+n2cOHpr9FCe8G3S82hX+I9U1v
         SxQQ==
X-Gm-Message-State: AOJu0Yzu5Oxhx6GbV5RgwmFt53HqhEE/3PBi/jnYlSLHp5mKIK1gz1qE
	0pdkqSjda7jo5Nq+4O5ik1WHKgAEiRG+x1AC/jZmiWpIEeU/ANf8SClrp4gM/al4ApUhm3gKjYU
	LNWPz3gft3TwmHgI0gEki9lM1/W5EB7OxdWZV
X-Gm-Gg: ASbGncsrEjsEmKzklGeNI4XUvY5mgDfv2yq98NjCOpXHz2W9DqURr8qP0FaZQ9Yb+Ni
	HoLAyvPSc95ei3NnWVaWWtYDqmTp2GqhmKCOR8bVpUHDagSzjVbzgbIKkRGykGNnic1vwxTq354
	Shrr2isasLYsPCS9LPbnROOq1xFxqXJMFfLR+wl9VStkC+sgEUz0svxzjl/DY2B4L8mow+duGLw
	lM4OzsGBs2BFfJV/+CAt5Vo0lqaUZUhTy/NaChgwXKr
X-Google-Smtp-Source: AGHT+IFFc1nllhfmnfUhFY59tJ+U4WdFg9GKuu+vi/sJ4u8FB/suIrK1lR+mA4dyT2ioln88bBY+duwPjErp2EcRb50=
X-Received: by 2002:a05:690c:4b89:b0:78a:6e1d:cc0f with SMTP id
 00721157ae682-78c0c1a525amr32233897b3.66.1764801426900; Wed, 03 Dec 2025
 14:37:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203195050.3215728-1-ameryhung@gmail.com> <20251203195050.3215728-2-ameryhung@gmail.com>
In-Reply-To: <20251203195050.3215728-2-ameryhung@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 3 Dec 2025 14:36:56 -0800
X-Gm-Features: AWmQ_bkV10kxmTOxGCI4F4zClXPrHa6QpHGWXjyjQ-ao5N2PrG36yBA-oL69M18
Message-ID: <CAMB2axMC+0ujccZNL+1H__iKgyt1ubFAPj2kZ4yVCWbT4W5_kQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test tail call when cgroup
 storage is used
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, eddyz87@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 11:50=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Make sure that if the owner of a program array map uses cgroup storage,
> (1) all callers must use cgroup storage and (2) the cgroup storage map
> used by all callers and callees must be the owner's cgroup storage map.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/tailcalls.c      | 119 ++++++++++++++++++
>  .../bpf/progs/tailcall_cgrp_storage.c         |  45 +++++++
>  .../progs/tailcall_cgrp_storage_no_storage.c  |  21 ++++
>  .../bpf/progs/tailcall_cgrp_storage_owner.c   |  33 +++++
>  4 files changed, 218 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_stora=
ge.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_stora=
ge_no_storage.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_stora=
ge_owner.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/t=
esting/selftests/bpf/prog_tests/tailcalls.c
> index 0ab36503c3b2..8ae4d101ed66 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> @@ -8,6 +8,9 @@
>  #include "tailcall_freplace.skel.h"
>  #include "tc_bpf2bpf.skel.h"
>  #include "tailcall_fail.skel.h"
> +#include "tailcall_cgrp_storage_owner.skel.h"
> +#include "tailcall_cgrp_storage_no_storage.skel.h"
> +#include "tailcall_cgrp_storage.skel.h"
>
>  /* test_tailcall_1 checks basic functionality by patching multiple locat=
ions
>   * in a single program for a single tail call slot with nop->jmp, jmp->n=
op
> @@ -1648,6 +1651,116 @@ static void test_tailcall_bpf2bpf_freplace(void)
>         tc_bpf2bpf__destroy(tc_skel);
>  }
>
> +/*
> + * test_tail_call_cgrp_storage checks that if the owner program of a pro=
gram
> + * array uses cgroup storage, other callers and callees must also use th=
e
> + * exact same cgroup storage.
> + */
> +static void test_tailcall_cgrp_storage(void)
> +{
> +       int err, prog_fd, prog_array_fd, storage_map_fd, key =3D 0;
> +       struct tailcall_cgrp_storage_owner *owner_skel;
> +       struct tailcall_cgrp_storage *skel;
> +
> +       /* Load owner_skel first to make sure it becomes the owner of pro=
g_array */
> +       owner_skel =3D tailcall_cgrp_storage_owner__open_and_load();
> +       if (!ASSERT_OK_PTR(owner_skel, "tailcall_cgrp_storage_owner__open=
_and_load"))
> +               return;
> +
> +       prog_array_fd =3D bpf_map__fd(owner_skel->maps.prog_array);
> +       storage_map_fd =3D bpf_map__fd(owner_skel->maps.storage_map);
> +
> +       skel =3D tailcall_cgrp_storage__open();
> +       if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage__open")) {
> +               tailcall_cgrp_storage_owner__destroy(owner_skel);
> +               return;
> +       }
> +
> +       err =3D bpf_map__reuse_fd(skel->maps.prog_array, prog_array_fd);
> +       ASSERT_OK(err, "bpf_map__reuse_fd(prog_array)");
> +
> +       err =3D bpf_map__reuse_fd(skel->maps.storage_map, storage_map_fd)=
;
> +       ASSERT_OK(err, "bpf_map__reuse_fd(storage_map)");
> +
> +       err =3D bpf_object__load(skel->obj);
> +       ASSERT_OK(err, "bpf_object__load");
> +
> +       prog_fd =3D bpf_program__fd(skel->progs.callee_prog);
> +
> +       err =3D bpf_map_update_elem(prog_array_fd, &key, &prog_fd, BPF_AN=
Y);
> +       ASSERT_OK(err, "bpf_map_update_elem(prog_array)");
> +
> +       tailcall_cgrp_storage__destroy(skel);
> +       tailcall_cgrp_storage_owner__destroy(owner_skel);
> +}
> +
> +/*
> + * test_tail_call_cgrp_storage_diff_storage checks that a program using =
tail call
> + * is rejected if it uses a cgroup storage different from the owner's.
> + */
> +static void test_tailcall_cgrp_storage_diff_storage(void)
> +{
> +       struct tailcall_cgrp_storage_owner *owner_skel;
> +       struct tailcall_cgrp_storage *skel;
> +       int err, prog_array_fd;
> +
> +       /* Load owner_skel first to make sure it becomes the owner of pro=
g_array */
> +       owner_skel =3D tailcall_cgrp_storage_owner__open_and_load();
> +       if (!ASSERT_OK_PTR(owner_skel, "tailcall_cgrp_storage_owner__open=
_and_load"))
> +               return;
> +
> +       prog_array_fd =3D bpf_map__fd(owner_skel->maps.prog_array);
> +
> +       skel =3D tailcall_cgrp_storage__open();
> +       if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage__open")) {
> +               tailcall_cgrp_storage_owner__destroy(owner_skel);
> +               return;
> +       }
> +
> +       err =3D bpf_map__reuse_fd(skel->maps.prog_array, prog_array_fd);
> +       ASSERT_OK(err, "bpf_map__reuse_fd(prog_array)");
> +
> +       err =3D bpf_object__load(skel->obj);
> +       ASSERT_ERR(err, "bpf_object__load");
> +
> +       tailcall_cgrp_storage__destroy(skel);
> +       tailcall_cgrp_storage_owner__destroy(owner_skel);
> +}
> +
> +/*
> + * test_tail_call_cgrp_storage_no_storage checks that a program using ta=
il call
> + * is rejected if it does not use cgroup storage while the owner does.
> + */
> +static void test_tailcall_cgrp_storage_no_storage(void)
> +{
> +       struct tailcall_cgrp_storage_owner *owner_skel;
> +       struct tailcall_cgrp_storage_no_storage *skel;
> +       int err, prog_array_fd, storage_map_fd;
> +
> +       /* Load owner_skel first to make sure it becomes the owner of pro=
g_array */
> +       owner_skel =3D tailcall_cgrp_storage_owner__open_and_load();
> +       if (!ASSERT_OK_PTR(owner_skel, "tailcall_cgrp_storage_owner__open=
_and_load"))
> +               return;
> +
> +       prog_array_fd =3D bpf_map__fd(owner_skel->maps.prog_array);
> +       storage_map_fd =3D bpf_map__fd(owner_skel->maps.storage_map);

CI reported warning of unused storage_map_fd. Will remove in the respin.

> +
> +       skel =3D tailcall_cgrp_storage_no_storage__open();
> +       if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage_no_storage__open"=
)) {
> +               tailcall_cgrp_storage_owner__destroy(owner_skel);
> +               return;
> +       }
> +
> +       err =3D bpf_map__reuse_fd(skel->maps.prog_array, prog_array_fd);
> +       ASSERT_OK(err, "bpf_map__reuse_fd(prog_array)");
> +
> +       err =3D bpf_object__load(skel->obj);
> +       ASSERT_ERR(err, "bpf_object__load");
> +
> +       tailcall_cgrp_storage_no_storage__destroy(skel);
> +       tailcall_cgrp_storage_owner__destroy(owner_skel);
> +}
> +
>  static void test_tailcall_failure()
>  {
>         RUN_TESTS(tailcall_fail);
> @@ -1705,6 +1818,12 @@ void test_tailcalls(void)
>                 test_tailcall_freplace();
>         if (test__start_subtest("tailcall_bpf2bpf_freplace"))
>                 test_tailcall_bpf2bpf_freplace();
> +       if (test__start_subtest("tailcall_cgrp_storage"))
> +               test_tailcall_cgrp_storage();
> +       if (test__start_subtest("tailcall_cgrp_storage_diff_storage"))
> +               test_tailcall_cgrp_storage_diff_storage();
> +       if (test__start_subtest("tailcall_cgrp_storage_no_storage"))
> +               test_tailcall_cgrp_storage_no_storage();
>         if (test__start_subtest("tailcall_failure"))
>                 test_tailcall_failure();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c b/=
tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
> new file mode 100644
> index 000000000000..e8356f95fb0a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
> +       __type(key, struct bpf_cgroup_storage_key);
> +       __type(value, __u64);
> +} storage_map SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> +       __uint(max_entries, 1);
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, sizeof(__u32));
> +} prog_array SEC(".maps");
> +
> +SEC("cgroup_skb/egress")
> +int caller_prog(struct __sk_buff *skb)
> +{
> +       __u64 *storage;
> +
> +       storage =3D bpf_get_local_storage(&storage_map, 0);
> +       if (storage)
> +               *storage =3D 1;
> +
> +       bpf_tail_call(skb, &prog_array, 0);
> +
> +       return 1;
> +}
> +
> +SEC("cgroup_skb/egress")
> +int callee_prog(struct __sk_buff *skb)
> +{
> +       __u64 *storage;
> +
> +       storage =3D bpf_get_local_storage(&storage_map, 0);
> +       if (storage)
> +               *storage =3D 1;
> +
> +       return 1;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_no_s=
torage.c b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_no_stora=
ge.c
> new file mode 100644
> index 000000000000..2f295e66d488
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_no_storage.=
c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> +       __uint(max_entries, 1);
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, sizeof(__u32));
> +} prog_array SEC(".maps");
> +
> +SEC("cgroup_skb/egress")
> +int caller_prog(struct __sk_buff *skb)
> +{
> +       bpf_tail_call(skb, &prog_array, 0);
> +
> +       return 1;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owne=
r.c b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c
> new file mode 100644
> index 000000000000..6ac195b800cf
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
> +       __type(key, struct bpf_cgroup_storage_key);
> +       __type(value, __u64);
> +} storage_map SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> +       __uint(max_entries, 1);
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, sizeof(__u32));
> +} prog_array SEC(".maps");
> +
> +SEC("cgroup_skb/egress")
> +int prog_array_owner(struct __sk_buff *skb)
> +{
> +       __u64 *storage;
> +
> +       storage =3D bpf_get_local_storage(&storage_map, 0);
> +       if (storage)
> +               *storage =3D 1;
> +
> +       bpf_tail_call(skb, &prog_array, 0);
> +
> +       return 1;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.47.3
>

