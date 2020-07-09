Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0103B2197D7
	for <lists+bpf@lfdr.de>; Thu,  9 Jul 2020 07:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgGIFZP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jul 2020 01:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgGIFZP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jul 2020 01:25:15 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8461CC061A0B
        for <bpf@vger.kernel.org>; Wed,  8 Jul 2020 22:25:14 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dm12so437377qvb.9
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2020 22:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtXViVDmhQpSsmNLrFxMQguvHOspx8hEJmDnkF5dknM=;
        b=Xr+i/aFzmDUgeNasuAms4R1deOEiQbswaTIJhGsRzOGcoGJpw8NZBkxEOuUaMlAxu9
         DZ5pcyRWA8AeLhTcWvVbSc9Y5QgIwshQscbPiTyawZIPdTJPTVuUcYWXu8TesJmyrypC
         H9m0RDNOl96gm4EqXNO4IbgzMMscfiiv1ga6udn9BEIQp4LFJfTjHhPppdQThHtJ+nq3
         2LWnsuACen4MCon/d8Y1+5zcNPM0FaH7s8Nn/8MOiQqPYMCmJV3KDyxoKCS4s12MOLg8
         HBvdq5qhUlpeUNEkhEJ+Dmf7QJEHg26NGajejWe6SRQCNxrKJ6oqLzl6rkyB5GIeu7eq
         3liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtXViVDmhQpSsmNLrFxMQguvHOspx8hEJmDnkF5dknM=;
        b=Rz7Akx+sgQHyXZX1GGSutpsXBiaAHCIzwJ9/UxwYT5WqfByZU44VY0JAYuJ82Wb5e+
         wSECNx6XtxFo+mF7LjQMxWzhkSQVuKPPDqJtnmj7Ob70M8AOL8vnsbnPd0eYwUPQxgpL
         tJoqLsIZD8b5U2kfrQPfr9xKtSqlVn9PBkK+MS57WMoPIWknGVY/n3PXC33OVgDOIoaN
         8MeRrnsjUDX6rQONYAxtd7p5oSVE2hfbosjFYFzinY+5PyZErGmyW83Woibs7/9CKY01
         34JDxccEG+0G3xaXNHX3lY6oRwbSxuaT+9PpLSRZdpX1tIj7wbfAFfA+Tg7CF2/9k3M9
         Zbeg==
X-Gm-Message-State: AOAM532V2bSA8OygjDF/N6Csa1wuzdafq2sMtt3rOnXvzR6A6/he2fdS
        zSSZFUoUg1wOo6Gog8hk6/KPZceB1C1MLt/diq0=
X-Google-Smtp-Source: ABdhPJy6Zjw9HqsMSH2zLz2TDOgWfr/jB8c8ePT5ijFNWLwSeL7lpQc+fEcsllKHookq4CtFR15IpzFvcuVxzguFjgg=
X-Received: by 2002:a0c:9ae2:: with SMTP id k34mr59161016qvf.247.1594272313730;
 Wed, 08 Jul 2020 22:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594065127.git.zhuyifei@google.com> <cf91469d82c2b9954779e5e786c2fa852694e14e.1594065127.git.zhuyifei@google.com>
In-Reply-To: <cf91469d82c2b9954779e5e786c2fa852694e14e.1594065127.git.zhuyifei@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Jul 2020 22:25:02 -0700
Message-ID: <CAEf4BzaNuStoxHe6YQiAF3bo3uUi=rrfTp83Z1129W2+-QP6OA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: Add test for CGROUP_STORAGE
 map on multiple attaches
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>, YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 6, 2020 at 1:54 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>
> From: YiFei Zhu <zhuyifei@google.com>
>
> This test creates a parent cgroup, and a child of that cgroup.
> It attaches a cgroup_skb/egress program that simply counts packets,
> to a global variable (ARRAY map), and to a CGROUP_STORAGE map.
> The program is first attached to the parent cgroup only, then to
> parent and child.
>
> The test cases sends a message within the child cgroup, and because
> the program is inherited across parent / child cgroups, it will
> trigger the egress program for both the parent and child, if they
> exist. The program, when looking up a CGROUP_STORAGE map, uses the
> cgroup and attach type of the attachment parameters; therefore,
> both attaches uses different cgroup storages.
>
> We assert that all packet counts returns what we expects.
>
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>  .../bpf/prog_tests/cg_storage_multi.c         | 154 ++++++++++++++++++
>  .../bpf/progs/cg_storage_multi_egress_only.c  |  30 ++++
>  2 files changed, 184 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
>  create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c
>

[...]

> +
> +static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
> +                          __u32 expected)
> +{
> +       struct bpf_cgroup_storage_key key = {0};
> +       __u32 value;
> +       int map_fd;
> +
> +       map_fd = bpf_map__fd(map);
> +
> +       key.cgroup_inode_id = get_cgroup_id(cgroup_path);
> +       key.attach_type = BPF_CGROUP_INET_EGRESS;
> +       if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value) < 0))

please don't use CHECK_FAIL, use CHECK instead

> +               return true;
> +       if (CHECK_FAIL(value != expected))
> +               return true;
> +
> +       return false;
> +}
> +

[...]

> +
> +static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
> +{
> +       struct cg_storage_multi_egress_only *obj;
> +       int err;
> +
> +       if (!test__start_subtest("egress_only"))
> +               return;

subtest check should be done in test_cg_storage_multi, otherwise it's
not even clear that this test has subtests

> +
> +       obj = cg_storage_multi_egress_only__open_and_load();
> +       if (CHECK_FAIL(!obj))
> +               return;
> +
> +       /* Attach to parent cgroup, trigger packet from child.
> +        * Assert that there is only one run and in that run the storage is
> +        * parent cgroup's storage.
> +        * Also assert that child cgroup's storage does not exist
> +        */
> +       err = bpf_prog_attach(bpf_program__fd(obj->progs.egress),
> +                             parent_cgroup_fd,
> +                             BPF_CGROUP_INET_EGRESS, BPF_F_ALLOW_MULTI);

please use bpf_program__attach_cgroup() instead

> +       if (CHECK_FAIL(err))
> +               goto close_bpf_object;
> +       err = connect_send(CHILD_CGROUP);
> +       if (CHECK_FAIL(err))
> +               goto close_bpf_object;
> +       if (CHECK_FAIL(obj->bss->invocations != 1))
> +               goto close_bpf_object;
> +       if (CHECK_FAIL(assert_storage(obj->maps.cgroup_storage,
> +                                     PARENT_CGROUP, 1)))
> +               goto close_bpf_object;
> +       if (CHECK_FAIL(assert_storage_noexist(obj->maps.cgroup_storage,
> +                                             CHILD_CGROUP)))
> +               goto close_bpf_object;
> +
> +       /* Attach to parent and child cgroup, trigger packet from child.
> +        * Assert that there are two additional runs, one that run with parent
> +        * cgroup's storage and one with child cgroup's storage.
> +        */
> +       err = bpf_prog_attach(bpf_program__fd(obj->progs.egress),
> +                             child_cgroup_fd,
> +                             BPF_CGROUP_INET_EGRESS, BPF_F_ALLOW_MULTI);

Here as well.

[...]
