Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F56474AF5
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 19:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhLNSbu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 13:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhLNSbu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 13:31:50 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C5BC061574
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 10:31:50 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id f9so48507019ybq.10
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 10:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ws7xzKZOqZmv2orLhExPgZOrocSjPdhk287FjFIvEic=;
        b=kiUw31ugTLX9D0qp0N38XzSkRfftbPORNVNvM2lEvXNHygnl3tdtlXzEvgpCvgz4cl
         aOHHPBHJFRxEcYXpNqgYVRC0Q5aNVKl5funO374SWu6wn3KBeil0zRiiS3AmmtiwFqQF
         TuyvBNBS5MDNj1k5s8fTsL9vjYQssKKaoBQtD0hTtdHP/t3ae1WVJVfDfeKWZQ/t+Nb2
         Bt5uw4GfuKPGEWVAZat1xFA6P58ElTtnz8UCcAX71ZZE+kKibZ5PZAqiITqIsGPLT7r/
         Kg9SsGXR5qs8/HiAxgcuiTVOZz3R47zVRTFdT/EOJFyRx6FR5aYUsxYMuWNRztAXZTqx
         snDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ws7xzKZOqZmv2orLhExPgZOrocSjPdhk287FjFIvEic=;
        b=wOKYX9onutpM3w2Yc1G23tfSB9nQPwtFgycCLF3fQptU/xTcTsAtKCy8GUwv91iPSy
         b+/MFR/GWl/DUQsPYorAGbs9ArmnYRodGpCLB7H9npVYuX/yg1nHAjRsXZnH7naGisTc
         vQa7qC8wvOdvx87JDNKjj33LTFUbMNgc9OV/Ty8PNSxAcofspE/jxaPMQcHFZRLcunPD
         t20GwvJVNOyiNc+nip1T2EJX2VpZF10UkBu64Vl1ZsF9ACLmPL7zR8AU8PR+pVBgM6ir
         Z6SikdxWlHcwScO+QHh+95djfoXAqDNo3wqRhoYb0lML2MrOgmqNRORn6g+93Nx0Ne2g
         xC4Q==
X-Gm-Message-State: AOAM5327axqOIRnjfKNq3BYueeDIoSWvRABB0gwt9R4z1v39tKTNj3hz
        VkwC02WO7edCJgkE77xau6L24uHfa+h1rXmpMdE=
X-Google-Smtp-Source: ABdhPJy41bbFO7uR7YS8wU5uESpFDnINodPabvlAe6w21dpkYS7L4+mJTSxdBcXNaPYAKv5iniLggnaMAMtbYU1tI1M=
X-Received: by 2002:a25:2a89:: with SMTP id q131mr859094ybq.436.1639506709525;
 Tue, 14 Dec 2021 10:31:49 -0800 (PST)
MIME-Version: 1.0
References: <20211214004856.3785613-1-andrii@kernel.org> <20211214004856.3785613-2-andrii@kernel.org>
 <177504f5-c89a-a05e-8542-9c326d9a10c1@iogearbox.net> <CAEf4BzYRQcpd5meQ21oOBWdKdUnSM2VLF9oTV9kQrX8cmnk==Q@mail.gmail.com>
 <9656836e-f9ea-f1ff-80c2-f4aba51f0d8d@fb.com>
In-Reply-To: <9656836e-f9ea-f1ff-80c2-f4aba51f0d8d@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Dec 2021 10:31:38 -0800
Message-ID: <CAEf4BzbmBNRB0sWAxHpSaW6fYMbgrCDm9K=8XScYGa2PEpdsPA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] libbpf: auto-bump RLIMIT_MEMLOCK if
 kernel needs it for BPF
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 14, 2021 at 9:58 AM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 12/14/21 9:51 AM, Andrii Nakryiko wrote:
> > On Tue, Dec 14, 2021 at 7:09 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>
> >> On 12/14/21 1:48 AM, Andrii Nakryiko wrote:
> >>> The need to increase RLIMIT_MEMLOCK to do anything useful with BPF is
> >>> one of the first extremely frustrating gotchas that all new BPF users go
> >>> through and in some cases have to learn it a very hard way.
> >>>
> >>> Luckily, starting with upstream Linux kernel version 5.11, BPF subsystem
> >>> dropped the dependency on memlock and uses memcg-based memory accounting
> >>> instead. Unfortunately, detecting memcg-based BPF memory accounting is
> >>> far from trivial (as can be evidenced by this patch), so in practice
> >>> most BPF applications still do unconditional RLIMIT_MEMLOCK increase.
> >>>
> >>> As we move towards libbpf 1.0, it would be good to allow users to forget
> >>> about RLIMIT_MEMLOCK vs memcg and let libbpf do the sensible adjustment
> >>> automatically. This patch paves the way forward in this matter. Libbpf
> >>> will do feature detection of memcg-based accounting, and if detected,
> >>> will do nothing. But if the kernel is too old, just like BCC, libbpf
> >>> will automatically increase RLIMIT_MEMLOCK on behalf of user
> >>> application ([0]).
> >>>
> >>> As this is technically a breaking change, during the transition period
> >>> applications have to opt into libbpf 1.0 mode by setting
> >>> LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK bit when calling
> >>> libbpf_set_strict_mode().
> >>>
> >>> Libbpf allows to control the exact amount of set RLIMIT_MEMLOCK limit
> >>> with libbpf_set_memlock_rlim_max() API. Passing 0 will make libbpf do
> >>> nothing with RLIMIT_MEMLOCK. libbpf_set_memlock_rlim_max() has to be
> >>> called before the first bpf_prog_load(), bpf_btf_load(), or
> >>> bpf_object__load() call, otherwise it has no effect and will return
> >>> -EBUSY.
> >>>
> >>>     [0] Closes: https://github.com/libbpf/libbpf/issues/369
> >>>
> >>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >> [...]
> >>>
> >>> +/* Probe whether kernel switched from memlock-based (RLIMIT_MEMLOCK) to
> >>> + * memcg-based memory accounting for BPF maps and progs. This was done in [0].
> >>> + * We use the difference in reporting memlock value in BPF map's fdinfo before
> >>> + * and after [0] to detect whether memcg accounting is done for BPF subsystem
> >>> + * or not.
> >>> + *
> >>> + * Before the change, memlock value for ARRAY map would be calculated as:
> >>> + *
> >>> + *   memlock = sizeof(struct bpf_array) + round_up(value_size, 8) * max_entries;
> >>> + *   memlock = round_up(memlock, PAGE_SIZE);
> >>> + *
> >>> + *
> >>> + * After, memlock is approximated as:
> >>> + *
> >>> + *   memlock = round_up(key_size + value_size, 8) * max_entries;
> >>> + *   memlock = round_up(memlock, PAGE_SIZE);
> >>> + *
> >>> + * In this check we use the fact that sizeof(struct bpf_array) is about 300
> >>> + * bytes, so if we use value_size = (PAGE_SIZE - 100), before memcg
> >>> + * approximation memlock would be rounded up to 2 * PAGE_SIZE, while with
> >>> + * memcg approximation it will stay at single PAGE_SIZE (key_size is 4 for
> >>> + * array and doesn't make much difference given 100 byte decrement we use for
> >>> + * value_size).
> >>> + *
> >>> + *   [0] https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com/
> >>> + */
> >>> +int probe_memcg_account(void)
> >>> +{
> >>> +     const size_t map_create_attr_sz = offsetofend(union bpf_attr, map_extra);
> >>> +     long page_sz = sysconf(_SC_PAGESIZE), memlock_sz;
> >>> +     char buf[128];
> >>> +     union bpf_attr attr;
> >>> +     int map_fd;
> >>> +     FILE *f;
> >>> +
> >>> +     memset(&attr, 0, map_create_attr_sz);
> >>> +     attr.map_type = BPF_MAP_TYPE_ARRAY;
> >>> +     attr.key_size = 4;
> >>> +     attr.value_size = page_sz - 100;
> >>> +     attr.max_entries = 1;
> >>> +     map_fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, map_create_attr_sz);
> >>> +     if (map_fd < 0)
> >>> +             return -errno;
> >>> +
> >>> +     sprintf(buf, "/proc/self/fdinfo/%d", map_fd);
> >>> +     f = fopen(buf, "r");
> >>> +     while (f && !feof(f) && fgets(buf, sizeof(buf), f)) {
> >>> +             if (fscanf(f, "memlock: %ld\n", &memlock_sz) == 1) {
> >>> +                     fclose(f);
> >>> +                     close(map_fd);
> >>> +                     return memlock_sz == page_sz ? 1 : 0;
> >>> +             }
> >>> +     }
> >>> +
> >>> +     /* proc FS is disabled or we failed to parse fdinfo properly, assume
> >>> +      * we need setrlimit
> >>> +      */
> >>> +     if (f)
> >>> +             fclose(f);
> >>> +     close(map_fd);
> >>> +     return 0;
> >>> +}
> >>
> >> One other option which might be slightly more robust perhaps could be to probe
> >> for a BPF helper that has been added along with 5.11 kernel. As Toke noted earlier
> >> it might not work with ooo backports, but if its good with RHEL in this specific
> >> case, we should be covered for 99% of cases. Potentially, we could then still try
> >> to fallback to the above probing logic?
> >
> > Ok, I was originally thinking of probe bpf_sock_from_file() (which was
> > added after memcg change), but it's PITA. But I see that slightly
> > before that (but in the same 5.11 release) bpf_ktime_get_coarse_ns()
>
> Note that it had fixes after that, so in the kernel version where

You mean 5e0bc3082e2e ("bpf: Forbid bpf_ktime_get_coarse_ns and
bpf_timer_* in tracing progs"), right? This shouldn't matter if I use
BPF_PROG_TYPE_SOCKET_FILTER for probing.

fdinfo parsing approach has unnecessary dependency on PROCFS and is
more code (and very detailed knowledge of approximation and memlock
calculation formula). I like ktime_get_coarse_ns approach due to
minimal amount of code and no reliance on any other kernel config
besides CONFIG_BPF_SYSCALL.

But in the end I care about the overall feature, not a particular
implementation of the detection. Should I send
ktime_get_coarse_ns-based approach or we go with this one? I've
implemented and tested all three variants already, so no time savings
are expected either way.

> it appeared it may be detected slightly differently than in
> the newer kernels (depending on how far fixes were backported).
> imo I would stick with this array+fdinfo approach.
