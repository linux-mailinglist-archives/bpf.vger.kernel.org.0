Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8C5474A16
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 18:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbhLNRvj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 12:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbhLNRvj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 12:51:39 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219ECC061574
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 09:51:39 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id q74so48159614ybq.11
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 09:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5kRrI9dsKHuD9lUbO6dcO4b66UiFqgVnI9oackQy4Io=;
        b=lww5kF57WHkSr00A1TZtZWWinTlYSpD+if7hIfxWxgMEb0wvtKaSIo1ZQRXn8mr3bh
         oSsv8OXQoOVjhuYeLaxH/3vDR0/y2x84uv8v3cbDTe8TZLyJoktMWOjllx10uOgfz3c9
         4Bc8ISogw+qP7mHYi3m8L0IGdgiTAM2b+cB9/sXvXjboc4PBZLXzYZuGcoov16OwoX8E
         xA2YEGHWlngR4bLp3GEeWpa90m2If9BRg4FwjgkxzmmUg8AADSovMUb3sowo3OT2Xyc+
         JR6biGvARmvdDi18eFdyGKJ/srP9/QSU3K9bKvqckmzV8NPoESDZZrTW2tibPKt5fo+C
         5bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kRrI9dsKHuD9lUbO6dcO4b66UiFqgVnI9oackQy4Io=;
        b=UdTNEr60oDqqN0z2Db7VdwP/duVP58QVVqzyrTkBLBQfSGM8tyBRliu6FZCHP2uaJo
         e+U7mjcav+cGf4kxqBKdxU1r+69PmZZHv++x6SaBvE5qeaRJwFdBqQ90hF+3KZBCz4fd
         vZS2ggfL4ayI/Cj2aNMylJzfDAMD66KOaE+sfKyzOJH08cup8nqqBnidBHp6gVlNVZGN
         pJjiHX2mG8tsZRVomFwA0WA/hdHUkvbRY16VEDLMhkhQScZH0EljiAdkQ+xcfM6M0D8k
         9lESxxar2T+Kee+6fjHyz1I2KZuufz2VXOnfK+T3s0NMCDXax2p5bNcBLqxC+ODMG8Ti
         7eKQ==
X-Gm-Message-State: AOAM530YdKBMGxq0IEGnqTY5jhNCnxjbue29ApNGkCaHpDvmF3RPL3hB
        PTX8mJ3n4Rq26TxQB8qTgnVNgnbMzkwufuoTI/s=
X-Google-Smtp-Source: ABdhPJyi8tCHEtWMtHcT5q3y7BvkpXDNe+N1UIQp1g5JBGEJt7QqSQj1wUUx+xLjv5M63g9tzetgMr4d/OHqairisiM=
X-Received: by 2002:a25:37cb:: with SMTP id e194mr476829yba.449.1639504298252;
 Tue, 14 Dec 2021 09:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20211214004856.3785613-1-andrii@kernel.org> <20211214004856.3785613-2-andrii@kernel.org>
 <177504f5-c89a-a05e-8542-9c326d9a10c1@iogearbox.net>
In-Reply-To: <177504f5-c89a-a05e-8542-9c326d9a10c1@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Dec 2021 09:51:27 -0800
Message-ID: <CAEf4BzYRQcpd5meQ21oOBWdKdUnSM2VLF9oTV9kQrX8cmnk==Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] libbpf: auto-bump RLIMIT_MEMLOCK if
 kernel needs it for BPF
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 14, 2021 at 7:09 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 12/14/21 1:48 AM, Andrii Nakryiko wrote:
> > The need to increase RLIMIT_MEMLOCK to do anything useful with BPF is
> > one of the first extremely frustrating gotchas that all new BPF users go
> > through and in some cases have to learn it a very hard way.
> >
> > Luckily, starting with upstream Linux kernel version 5.11, BPF subsystem
> > dropped the dependency on memlock and uses memcg-based memory accounting
> > instead. Unfortunately, detecting memcg-based BPF memory accounting is
> > far from trivial (as can be evidenced by this patch), so in practice
> > most BPF applications still do unconditional RLIMIT_MEMLOCK increase.
> >
> > As we move towards libbpf 1.0, it would be good to allow users to forget
> > about RLIMIT_MEMLOCK vs memcg and let libbpf do the sensible adjustment
> > automatically. This patch paves the way forward in this matter. Libbpf
> > will do feature detection of memcg-based accounting, and if detected,
> > will do nothing. But if the kernel is too old, just like BCC, libbpf
> > will automatically increase RLIMIT_MEMLOCK on behalf of user
> > application ([0]).
> >
> > As this is technically a breaking change, during the transition period
> > applications have to opt into libbpf 1.0 mode by setting
> > LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK bit when calling
> > libbpf_set_strict_mode().
> >
> > Libbpf allows to control the exact amount of set RLIMIT_MEMLOCK limit
> > with libbpf_set_memlock_rlim_max() API. Passing 0 will make libbpf do
> > nothing with RLIMIT_MEMLOCK. libbpf_set_memlock_rlim_max() has to be
> > called before the first bpf_prog_load(), bpf_btf_load(), or
> > bpf_object__load() call, otherwise it has no effect and will return
> > -EBUSY.
> >
> >    [0] Closes: https://github.com/libbpf/libbpf/issues/369
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> [...]
> >
> > +/* Probe whether kernel switched from memlock-based (RLIMIT_MEMLOCK) to
> > + * memcg-based memory accounting for BPF maps and progs. This was done in [0].
> > + * We use the difference in reporting memlock value in BPF map's fdinfo before
> > + * and after [0] to detect whether memcg accounting is done for BPF subsystem
> > + * or not.
> > + *
> > + * Before the change, memlock value for ARRAY map would be calculated as:
> > + *
> > + *   memlock = sizeof(struct bpf_array) + round_up(value_size, 8) * max_entries;
> > + *   memlock = round_up(memlock, PAGE_SIZE);
> > + *
> > + *
> > + * After, memlock is approximated as:
> > + *
> > + *   memlock = round_up(key_size + value_size, 8) * max_entries;
> > + *   memlock = round_up(memlock, PAGE_SIZE);
> > + *
> > + * In this check we use the fact that sizeof(struct bpf_array) is about 300
> > + * bytes, so if we use value_size = (PAGE_SIZE - 100), before memcg
> > + * approximation memlock would be rounded up to 2 * PAGE_SIZE, while with
> > + * memcg approximation it will stay at single PAGE_SIZE (key_size is 4 for
> > + * array and doesn't make much difference given 100 byte decrement we use for
> > + * value_size).
> > + *
> > + *   [0] https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com/
> > + */
> > +int probe_memcg_account(void)
> > +{
> > +     const size_t map_create_attr_sz = offsetofend(union bpf_attr, map_extra);
> > +     long page_sz = sysconf(_SC_PAGESIZE), memlock_sz;
> > +     char buf[128];
> > +     union bpf_attr attr;
> > +     int map_fd;
> > +     FILE *f;
> > +
> > +     memset(&attr, 0, map_create_attr_sz);
> > +     attr.map_type = BPF_MAP_TYPE_ARRAY;
> > +     attr.key_size = 4;
> > +     attr.value_size = page_sz - 100;
> > +     attr.max_entries = 1;
> > +     map_fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, map_create_attr_sz);
> > +     if (map_fd < 0)
> > +             return -errno;
> > +
> > +     sprintf(buf, "/proc/self/fdinfo/%d", map_fd);
> > +     f = fopen(buf, "r");
> > +     while (f && !feof(f) && fgets(buf, sizeof(buf), f)) {
> > +             if (fscanf(f, "memlock: %ld\n", &memlock_sz) == 1) {
> > +                     fclose(f);
> > +                     close(map_fd);
> > +                     return memlock_sz == page_sz ? 1 : 0;
> > +             }
> > +     }
> > +
> > +     /* proc FS is disabled or we failed to parse fdinfo properly, assume
> > +      * we need setrlimit
> > +      */
> > +     if (f)
> > +             fclose(f);
> > +     close(map_fd);
> > +     return 0;
> > +}
>
> One other option which might be slightly more robust perhaps could be to probe
> for a BPF helper that has been added along with 5.11 kernel. As Toke noted earlier
> it might not work with ooo backports, but if its good with RHEL in this specific
> case, we should be covered for 99% of cases. Potentially, we could then still try
> to fallback to the above probing logic?

Ok, I was originally thinking of probe bpf_sock_from_file() (which was
added after memcg change), but it's PITA. But I see that slightly
before that (but in the same 5.11 release) bpf_ktime_get_coarse_ns()
helper was added, which is the simplest helper to test for. Let me
test that instead and it should be very reliable (apart from the out
of order backports, but I personally can live with that, given that we
fall back to a safe setrlimit() default).

But I'm not going to do fallback, helper doesn't add any extra
dependencies and should be very reliable.

>
> Thanks,
> Daniel
