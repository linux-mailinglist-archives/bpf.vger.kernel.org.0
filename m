Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4844D313DAB
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 19:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhBHSgv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 13:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbhBHSfc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 13:35:32 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BB5C061786
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 10:34:52 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id d184so4249476ybf.1
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 10:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sa27mrrJjei3H3uyHfhRVIh4qUPeq1og3hvaeYikH9s=;
        b=q2gV0sZQyOYR3Wdyq2K4MtzqzVhaOo5UAranguomtk0WGSOhsXdNA7fuJHkMXiAC3o
         QRdy2RMNI60XStqqbptliuGgn+1KHUkmqvOhmIzsZ0hRHsjF09P4AJ8C5QB3HXLrYCkG
         UwkkPIgr1ebAo+dbCYpl/uaySg7KaZg0OcVypbZ3N4VQ/JscUI59ssn+ggTTgQ7ClKpW
         MLPTlp+RiikiUKdEN1how8xUV00tNKoSmYHU5pv9Pbhs29BHpvsWb/jE7nYlwQJqatEJ
         xibrpjU/wP8gN6s6bFWcvYWSxruHj9KKibwgKBh4rFzCTX7aL9Xt6/RzkqqX65gVo/3c
         SyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sa27mrrJjei3H3uyHfhRVIh4qUPeq1og3hvaeYikH9s=;
        b=AgVn/uUvbJgFDd185eWDNxwRZj8S+M6URmU/NDXPZkKZnKQKn7lWbjo7387a8RM9QA
         qKgdlbmjya8mLmcl0SVxZo4jsp8F7V4zaAutXdAD7RGWEkpI0MAZdOhP5Lll5JoOZBp/
         Se81X0rSuCGonTnLy8psC62O1oaHYMQPMyel1oOXsgXje5THmt2dJY/YYlP9tu4wx/VD
         sPttMVN9Honkx8OIjKhUwAHrXDuSkqedFzfTly1rmXTmPSx9r+bXrRVHXiBts+4eAfqf
         x8l+hISUv78xk6krdo0XiiEmlwbO9V3GN1xzJ2mLiz4SKBTZ83X8BjVZyAWezQK7tx4O
         4fxA==
X-Gm-Message-State: AOAM532zu74h9xkJCY9v+5MxWQZV0BlqYsgag2eT7IAMq3Q0ACR5cXEG
        zX/LpBE1mZzElenoMCTHiCGCez1YRtvBaLaJh1rSlXIFZUo=
X-Google-Smtp-Source: ABdhPJxVkojlGqCsEL0pbkGBEK2Tw2O3DC3T0m3RtqaO6xxaQtjcqQIRx7jT4W9u1C/1j+qzeM16hlb5MX4BhhK8X+M=
X-Received: by 2002:a25:3805:: with SMTP id f5mr10502172yba.27.1612809292055;
 Mon, 08 Feb 2021 10:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20210204234827.1628857-1-yhs@fb.com> <20210204234835.1629656-1-yhs@fb.com>
In-Reply-To: <20210204234835.1629656-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 10:34:41 -0800
Message-ID: <CAEf4BzbQBCEarNeB+0B_QmgnNsaeVRxjNt0EC2N5og4Qc-U=Eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/8] selftests/bpf: add hashmap test for
 bpf_for_each_map_elem() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 4, 2021 at 5:53 PM Yonghong Song <yhs@fb.com> wrote:
>
> A test case is added for hashmap and percpu hashmap. The test
> also exercises nested bpf_for_each_map_elem() calls like
>     bpf_prog:
>       bpf_for_each_map_elem(func1)
>     func1:
>       bpf_for_each_map_elem(func2)
>     func2:
>
>   $ ./test_progs -n 44
>   #44/1 hash_map:OK
>   #44 for_each:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  .../selftests/bpf/prog_tests/for_each.c       |  91 ++++++++++++++++
>  .../bpf/progs/for_each_hash_map_elem.c        | 103 ++++++++++++++++++
>  2 files changed, 194 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/for_each.c
>  create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_map_elem.c
>

[...]

> +       num_cpus = bpf_num_possible_cpus();
> +       percpu_map_fd = bpf_map__fd(skel->maps.percpu_map);
> +       percpu_valbuf = malloc(sizeof(__u64) * num_cpus);
> +       if (CHECK_FAIL(!percpu_valbuf))
> +               goto out;
> +
> +       key = 1;
> +       for (i = 0; i < num_cpus; i++)
> +               percpu_valbuf[i] = i + 1;
> +       err = bpf_map_update_elem(percpu_map_fd, &key, percpu_valbuf, BPF_ANY);
> +       if (CHECK(err, "percpu_map_update", "map_update failed\n"))
> +               goto out;
> +
> +       do_dummy_read(skel->progs.dump_task);

why use iter/task programs to trigger your test BPF code? This test
doesn't seem to rely on anything iter-specific, so it's much simpler
(and less code) to just use the typical sys_enter approach with
usleep(1) as a trigger function, no?

> +
> +       ASSERT_EQ(skel->bss->called, 1, "called");
> +       ASSERT_EQ(skel->bss->hashmap_output, 4, "output_val");
> +
> +       key = 1;
> +       err = bpf_map_lookup_elem(hashmap_fd, &key, &val);
> +       ASSERT_ERR(err, "hashmap_lookup");
> +
> +       ASSERT_EQ(skel->bss->percpu_called, 1, "percpu_called");
> +       CHECK_FAIL(skel->bss->cpu >= num_cpus);

please don't use CHECK_FAIL: use CHECK or one of ASSERT_xxx variants

> +       ASSERT_EQ(skel->bss->percpu_key, 1, "percpu_key");
> +       ASSERT_EQ(skel->bss->percpu_val, skel->bss->cpu + 1, "percpu_val");
> +       ASSERT_EQ(skel->bss->percpu_output, 100, "percpu_output");
> +out:
> +       free(percpu_valbuf);
> +       for_each_hash_map_elem__destroy(skel);
> +}
> +
> +void test_for_each(void)
> +{
> +       if (test__start_subtest("hash_map"))
> +               test_hash_map();
> +}

[...]

> +
> +__u32 cpu = 0;
> +__u32 percpu_called = 0;
> +__u32 percpu_key = 0;
> +__u64 percpu_val = 0;
> +
> +static __u64
> +check_percpu_elem(struct bpf_map *map, __u32 *key, __u64 *val,
> +                 struct callback_ctx *data)
> +{
> +       percpu_called++;
> +       cpu = bpf_get_smp_processor_id();

It's a bit counter-intuitive (at least I was confused initially) that
for a per-cpu array for_each() will iterate only current CPU's
elements. I think it's worthwhile to emphasize this in
bpf_for_each_map_elem() documentation (at least), and call out in
corresponding patches adding per-cpu array/hash iteration support.

> +       percpu_key = *key;
> +       percpu_val = *val;
> +
> +       bpf_for_each_map_elem(&hashmap, check_hash_elem, data, 0);
> +       return 0;
> +}
> +

[...]
