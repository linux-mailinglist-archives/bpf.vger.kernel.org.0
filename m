Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5EE34BB2C
	for <lists+bpf@lfdr.de>; Sun, 28 Mar 2021 07:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhC1FDq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Mar 2021 01:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhC1FDQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Mar 2021 01:03:16 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B94DC061762
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 22:03:16 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id x189so10223709ybg.5
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 22:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyGIoOplvfBoVTOrbQuq9jHOoDMfbYc4NfcNs4jK2+c=;
        b=fIukJvgrK3vC1WdFU+tvEAswTB8TNfao/WsqsqNiwgnpyOgMNiUgxGUCc1q74tv6Kn
         mF5b2f0aUZWysCNzsMT6jIX/jxOOm0FcV990TWD1cSzZZKTg9pBG41JG4b3IRINXZ4EL
         WfwKzw0EJYkJZuNPEfm8oJKCvFz4fGBv6/ErO8SGLqwtqtmGGVLlsGLowCcMHTwNLFus
         9tNBi8tzGrUHLd3qsZgiM8F8dfTioxFfjAk7TBaVPdvMMPBBnE32gimz0c2gTxTtiKsV
         O6NDTRE/ooIRrvOFb+pJXDL+6AwGdVLVLOJTvqfS+G51DK4Yl2XtDBgTg8RG1v3dMS6q
         8Hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyGIoOplvfBoVTOrbQuq9jHOoDMfbYc4NfcNs4jK2+c=;
        b=NCOu2nOgO5+QFv1p4GGLrqq0A4nkRG0mxJL3hVPCeOB5uUSULPHwU/6Q0VjIDFEzB1
         d1NI1zmKDejvubmnxWuBOsFHyQwHAxcbML2/6+sazFhv9rEafT1i0zrjIBe/eTNCJUSJ
         J6SPt0gaaNFVsqdrmwRqrHM7dEKSh8wMavj+mUbdYcXEP9iwjYRFH2KwfTW0kWwuw1KQ
         GMq6G07UtaZGFyo90STutVB+mWZSfGUOIk49a6OsrgZfTJc2vNtdha6JGkWyI6DFPW+w
         UjEa85va/zUuZ0Hrmxcp6vz1k+xNg3G4nXr+FkqM6ZjyyivXCRyGFjO7KfzQ812E1p44
         dwaA==
X-Gm-Message-State: AOAM531pRCYT0ec10pEXhRc3SRvx/TCja7mDFrzf/ClRCVvRoDGPf5nj
        8v7F5RiduEOEZGsHEI44yTupP5iC0dcDq/HH+jk=
X-Google-Smtp-Source: ABdhPJxSm7EdnvkH7wHmWGVI0eHizwhi3LQrfQtYZBOCsLURXRLYM+aSYDEL/Pjf9Z8fmlDMklnfbakAfIcWW/44GJI=
X-Received: by 2002:a25:4982:: with SMTP id w124mr28894770yba.27.1616907795284;
 Sat, 27 Mar 2021 22:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
 <20210326122438.211242-1-yauheni.kaliuta@redhat.com> <20210326122438.211242-4-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210326122438.211242-4-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 27 Mar 2021 22:03:04 -0700
Message-ID: <CAEf4BzZowiRKeLGw7JikKuMs+dy-=OTMbUb3eFJCq03Br7P30g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] selftests/bpf: ringbuf, mmap: bump up page size to 64K
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 26, 2021 at 5:24 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Both ringbuf and mmap need PAGE_SIZE, but it's not available during
> bpf program compile time. 4K size was hardcoded (page shift 12 bits)
> which makes the tests fail on systems, configured for larger pages.
>
> Bump it up to 64K which at the first glance look reasonable at the
> moment for most of the systems.
>
> Use define to make it clear.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/ringbuf.c       |  9 +++++++--
>  tools/testing/selftests/bpf/progs/map_ptr_kern.c       |  9 +++++++--
>  tools/testing/selftests/bpf/progs/test_mmap.c          | 10 ++++++++--
>  tools/testing/selftests/bpf/progs/test_ringbuf.c       |  8 +++++++-
>  tools/testing/selftests/bpf/progs/test_ringbuf_multi.c |  7 ++++++-
>  5 files changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> index fddbc5db5d6a..9057654da957 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> @@ -15,6 +15,11 @@
>  #include "test_ringbuf.skel.h"
>
>  #define EDONE 7777
> +#ifdef PAGE_SIZE
> +#undef PAGE_SIZE
> +#endif
> +/* this is not actual page size, but the value used for ringbuf */
> +#define PAGE_SIZE 65536
>
>  static int duration = 0;
>
> @@ -110,9 +115,9 @@ void test_ringbuf(void)
>         CHECK(skel->bss->avail_data != 3 * rec_sz,
>               "err_avail_size", "exp %ld, got %ld\n",
>               3L * rec_sz, skel->bss->avail_data);
> -       CHECK(skel->bss->ring_size != 4096,
> +       CHECK(skel->bss->ring_size != PAGE_SIZE,
>               "err_ring_size", "exp %ld, got %ld\n",
> -             4096L, skel->bss->ring_size);
> +             (long)PAGE_SIZE, skel->bss->ring_size);
>         CHECK(skel->bss->cons_pos != 0,
>               "err_cons_pos", "exp %ld, got %ld\n",
>               0L, skel->bss->cons_pos);
> diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> index d8850bc6a9f1..c1460f27af78 100644
> --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> @@ -8,6 +8,11 @@
>  #define MAX_ENTRIES 8
>  #define HALF_ENTRIES (MAX_ENTRIES >> 1)
>
> +#ifndef PAGE_SIZE
> +/* use reasonable value for various configurations */
> +#define PAGE_SIZE 65536
> +#endif
> +
>  _Static_assert(MAX_ENTRIES < LOOP_BOUND, "MAX_ENTRIES must be < LOOP_BOUND");
>
>  enum bpf_map_type g_map_type = BPF_MAP_TYPE_UNSPEC;
> @@ -635,7 +640,7 @@ struct bpf_ringbuf_map {
>
>  struct {
>         __uint(type, BPF_MAP_TYPE_RINGBUF);
> -       __uint(max_entries, 1 << 12);
> +       __uint(max_entries, PAGE_SIZE);
>  } m_ringbuf SEC(".maps");
>
>  static inline int check_ringbuf(void)
> @@ -643,7 +648,7 @@ static inline int check_ringbuf(void)
>         struct bpf_ringbuf_map *ringbuf = (struct bpf_ringbuf_map *)&m_ringbuf;
>         struct bpf_map *map = (struct bpf_map *)&m_ringbuf;
>
> -       VERIFY(check(&ringbuf->map, map, 0, 0, 1 << 12));
> +       VERIFY(check(&ringbuf->map, map, 0, 0, PAGE_SIZE));
>
>         return 1;
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_mmap.c b/tools/testing/selftests/bpf/progs/test_mmap.c
> index 4eb42cff5fe9..c22fcfea0767 100644
> --- a/tools/testing/selftests/bpf/progs/test_mmap.c
> +++ b/tools/testing/selftests/bpf/progs/test_mmap.c
> @@ -5,11 +5,16 @@
>  #include <stdint.h>
>  #include <bpf/bpf_helpers.h>
>
> +#ifndef PAGE_SIZE
> +/* use reasonable value for various configurations */
> +#define PAGE_SIZE 65536
> +#endif
> +
>  char _license[] SEC("license") = "GPL";
>
>  struct {
>         __uint(type, BPF_MAP_TYPE_ARRAY);
> -       __uint(max_entries, 4096);
> +       __uint(max_entries, PAGE_SIZE);


so you can set map size at runtime before bpf_object__load (or
skeleton's load) with bpf_map__set_max_entries. That way you don't
have to do any assumptions. Just omit max_entries in BPF source code,
and always set it in userspace.

>         __uint(map_flags, BPF_F_MMAPABLE | BPF_F_RDONLY_PROG);
>         __type(key, __u32);
>         __type(value, char);
> @@ -17,7 +22,8 @@ struct {
>
>  struct {
>         __uint(type, BPF_MAP_TYPE_ARRAY);
> -       __uint(max_entries, 512 * 4); /* at least 4 pages of data */
> +       /* at least 4 pages of data */
> +       __uint(max_entries, 4 * (PAGE_SIZE / sizeof (__u64)));
>         __uint(map_flags, BPF_F_MMAPABLE);
>         __type(key, __u32);
>         __type(value, __u64);
> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf.c b/tools/testing/selftests/bpf/progs/test_ringbuf.c
> index 8ba9959b036b..6e645babdc18 100644
> --- a/tools/testing/selftests/bpf/progs/test_ringbuf.c
> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf.c
> @@ -4,6 +4,12 @@
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>
> +#ifndef PAGE_SIZE
> +/* use reasonable value for various configurations */
> +#define PAGE_SIZE 65536
> +#endif
> +
> +
>  char _license[] SEC("license") = "GPL";
>
>  struct sample {
> @@ -15,7 +21,7 @@ struct sample {
>
>  struct {
>         __uint(type, BPF_MAP_TYPE_RINGBUF);
> -       __uint(max_entries, 1 << 12);
> +       __uint(max_entries, PAGE_SIZE);
>  } ringbuf SEC(".maps");
>
>  /* inputs */
> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> index edf3b6953533..13bcf095e06c 100644
> --- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> @@ -4,6 +4,11 @@
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>
> +#ifndef PAGE_SIZE
> +/* use reasonable value for various configurations */
> +#define PAGE_SIZE 65536
> +#endif
> +
>  char _license[] SEC("license") = "GPL";
>
>  struct sample {
> @@ -15,7 +20,7 @@ struct sample {
>
>  struct ringbuf_map {
>         __uint(type, BPF_MAP_TYPE_RINGBUF);
> -       __uint(max_entries, 1 << 12);
> +       __uint(max_entries, PAGE_SIZE);
>  } ringbuf1 SEC(".maps"),
>    ringbuf2 SEC(".maps");
>
> --
> 2.29.2
>
