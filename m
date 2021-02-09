Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC09315543
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 18:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhBIRjL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 12:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbhBIRhH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 12:37:07 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6418C06174A
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 09:36:52 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id p193so5245481yba.4
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 09:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FP+9v6CIJoX8rie5Mv8WzpUloJ56ZNGgXq/dhScy8Ac=;
        b=DIe0ruG+SDYae9hJ775r9FDhMygUcdGRwKXRok2X942TrANEOFPLGSf1nntZ0Ys/xK
         r2FF66c7Rm20mR/z5NaW70BYqG60Nb1eeN0TgvOTpYB7G6PGQ6+iDPu0wst5HCf4FTj1
         vUtYgxOPbHqL28k0BIdtXSi0hT0n3RSkkxixjP/AOlv2wl9zUuIi8iBHbk/br1Q8DEgp
         DvarbKhgxWRA5rermekho4rKQrIe1KSekuoafClJhVaEfkIkqQiHcelYMS90CrVQ7WMt
         7RoECmVpoxbRG2jbpxQsiQ10LjiVouzPhekggmNB7HQemsGMYiWowTjyGWGbgxpk/RTy
         QhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FP+9v6CIJoX8rie5Mv8WzpUloJ56ZNGgXq/dhScy8Ac=;
        b=azZhUc04LzujDermO0zittY9Z45vLu94LjK3opRamTyaj03L5LIWQKhS4jzP9CYc89
         cHoMDFwsrhChNIi7sMZivAtpY5PwwJz6CfHfOv9O8rJTDAgTQw1mfn1bHAlMLCo06pNw
         KT/WVr22fcEcs83zAJErrPHS6VQnnsad5W6kl/g/6WWPrb4nza4w3WKqkaUOrv8cpBYi
         mu0tyd1JTEp2bdlriLbm61GolfC9DIuhOTafMv+dvu1Yqv+YN2u/Ghcj5BnbOjHIdbBk
         swnmSWYGdvy4jjRgSBbrlzKbhW0nTtb3RidFkHSs08LvV4qDSxJY9nlZk8seTgQfHZkS
         SZdw==
X-Gm-Message-State: AOAM533zbFPMHB6WNeLaX+nJU3lUk6OfZFAwJGnji5/xnJEp15oxXzIT
        E/saKerRtv/O6T1pfHTXqRxH3JJy9la8ikmsLo4=
X-Google-Smtp-Source: ABdhPJzs7wDcivEMVwywlNvN7vk5iH1dNI5Tpj0Yjr6UXuAjDhCak67wSYjXsFinUF5bvnASs+yMlnBvvz49tsCxKWE=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr33876197ybd.230.1612892212173;
 Tue, 09 Feb 2021 09:36:52 -0800 (PST)
MIME-Version: 1.0
References: <20210204234827.1628857-1-yhs@fb.com> <20210204234835.1629656-1-yhs@fb.com>
 <CAEf4BzbQBCEarNeB+0B_QmgnNsaeVRxjNt0EC2N5og4Qc-U=Eg@mail.gmail.com> <ce335d12-e81e-e7b9-e54d-804a5f103932@fb.com>
In-Reply-To: <ce335d12-e81e-e7b9-e54d-804a5f103932@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Feb 2021 09:36:41 -0800
Message-ID: <CAEf4BzbvGuH+jWEtvBPW9U6_sNW5XkXP2_oQzk8J2WeupYgH2A@mail.gmail.com>
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

On Mon, Feb 8, 2021 at 10:46 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/8/21 10:34 AM, Andrii Nakryiko wrote:
> > On Thu, Feb 4, 2021 at 5:53 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> A test case is added for hashmap and percpu hashmap. The test
> >> also exercises nested bpf_for_each_map_elem() calls like
> >>      bpf_prog:
> >>        bpf_for_each_map_elem(func1)
> >>      func1:
> >>        bpf_for_each_map_elem(func2)
> >>      func2:
> >>
> >>    $ ./test_progs -n 44
> >>    #44/1 hash_map:OK
> >>    #44 for_each:OK
> >>    Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   .../selftests/bpf/prog_tests/for_each.c       |  91 ++++++++++++++++
> >>   .../bpf/progs/for_each_hash_map_elem.c        | 103 ++++++++++++++++++
> >>   2 files changed, 194 insertions(+)
> >>   create mode 100644 tools/testing/selftests/bpf/prog_tests/for_each.c
> >>   create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_map_elem.c
> >>
> >
> > [...]
> >
> >> +       num_cpus = bpf_num_possible_cpus();
> >> +       percpu_map_fd = bpf_map__fd(skel->maps.percpu_map);
> >> +       percpu_valbuf = malloc(sizeof(__u64) * num_cpus);
> >> +       if (CHECK_FAIL(!percpu_valbuf))
> >> +               goto out;
> >> +
> >> +       key = 1;
> >> +       for (i = 0; i < num_cpus; i++)
> >> +               percpu_valbuf[i] = i + 1;
> >> +       err = bpf_map_update_elem(percpu_map_fd, &key, percpu_valbuf, BPF_ANY);
> >> +       if (CHECK(err, "percpu_map_update", "map_update failed\n"))
> >> +               goto out;
> >> +
> >> +       do_dummy_read(skel->progs.dump_task);
> >
> > why use iter/task programs to trigger your test BPF code? This test
> > doesn't seem to rely on anything iter-specific, so it's much simpler
> > (and less code) to just use the typical sys_enter approach with
> > usleep(1) as a trigger function, no?
>
> I am aware of this. I did not change this in v1 mainly wanting to
> get some comments on API and verifier change etc. for v1.
> I will use bpf_prog_test_run() to call the program in v2.
>
> >
> >> +
> >> +       ASSERT_EQ(skel->bss->called, 1, "called");
> >> +       ASSERT_EQ(skel->bss->hashmap_output, 4, "output_val");
> >> +
> >> +       key = 1;
> >> +       err = bpf_map_lookup_elem(hashmap_fd, &key, &val);
> >> +       ASSERT_ERR(err, "hashmap_lookup");
> >> +
> >> +       ASSERT_EQ(skel->bss->percpu_called, 1, "percpu_called");
> >> +       CHECK_FAIL(skel->bss->cpu >= num_cpus);
> >
> > please don't use CHECK_FAIL: use CHECK or one of ASSERT_xxx variants
>
> We do not have ASSERT_GE, I may invent one.

Yeah, it has come up multiple times now. It would be great to have all
the inequality variants so that we can stop adding new CHECK()s which
has notoriously confusing semantics. Thanks!

>
> >
> >> +       ASSERT_EQ(skel->bss->percpu_key, 1, "percpu_key");
> >> +       ASSERT_EQ(skel->bss->percpu_val, skel->bss->cpu + 1, "percpu_val");
> >> +       ASSERT_EQ(skel->bss->percpu_output, 100, "percpu_output");
> >> +out:
> >> +       free(percpu_valbuf);
> >> +       for_each_hash_map_elem__destroy(skel);
> >> +}
> >> +
> >> +void test_for_each(void)
> >> +{
> >> +       if (test__start_subtest("hash_map"))
> >> +               test_hash_map();
> >> +}
> >
> > [...]
> >
> >> +
> >> +__u32 cpu = 0;
> >> +__u32 percpu_called = 0;
> >> +__u32 percpu_key = 0;
> >> +__u64 percpu_val = 0;
> >> +
> >> +static __u64
> >> +check_percpu_elem(struct bpf_map *map, __u32 *key, __u64 *val,
> >> +                 struct callback_ctx *data)
> >> +{
> >> +       percpu_called++;
> >> +       cpu = bpf_get_smp_processor_id();
> >
> > It's a bit counter-intuitive (at least I was confused initially) that
> > for a per-cpu array for_each() will iterate only current CPU's
> > elements. I think it's worthwhile to emphasize this in
> > bpf_for_each_map_elem() documentation (at least), and call out in
> > corresponding patches adding per-cpu array/hash iteration support.
>
> Right. Will emphasize this in uapi bpf.h and also comments in the code.
>
> >
> >> +       percpu_key = *key;
> >> +       percpu_val = *val;
> >> +
> >> +       bpf_for_each_map_elem(&hashmap, check_hash_elem, data, 0);
> >> +       return 0;
> >> +}
> >> +
> >
> > [...]
> >
