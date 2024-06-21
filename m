Return-Path: <bpf+bounces-32662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF54911740
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 02:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE901F23465
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 00:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F36A47;
	Fri, 21 Jun 2024 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3b5T7lz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54824394
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929567; cv=none; b=NI0l2/hak+eERENFd2pYkdQKZVcKztEJ513C6FmWHkl1teTlUlXzB7msLq9NhP8h++iyFpGJX6RcdQ0dQgWGucYHjL9AIxAew5dur2zPdnAZ64WIlh3asOBs6r3+gofpibyUOMcgF0kSx378O/++GFUOfGwwmmY19HZ5ojJhcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929567; c=relaxed/simple;
	bh=HlPVthQtALmVD2Jx6pFF2W/a2wGIpa/UF7GxjLLO1eU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZNQDkyKmduBMe0E3WuB21gPrwtSfsCqMvjOxDnY0APVo5qbdJNduy/h1kua33ePbnBmKcPOa7V4uiGvn1wJB3+WoJ/D8yY+OhRU7WGuCH/maDlJteJeN3UzuAYXnRMXUiiQjzzRaryziuTiDbVcjHdBv9fblEw3thN89RKhxTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3b5T7lz; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c2c6b27428so1161383a91.3
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 17:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718929565; x=1719534365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o27Dzgf4rpoKbx49OiT/b8IHaMhGMy+nSzgKnErVO1c=;
        b=j3b5T7lz+gDDaPuWvVno8RuEWYgy/E2lusoa0nYWGvTN9b1p4ssY8+GkkKJpFmCGdE
         tzdCWUuaSEVf5MnC/AzBtKMvAHJTHshMPo3wWbjKzN4eep6wj93H15HO82bMQnylt+tD
         YqsQyv/dNBB/R2QY3sOEnfa0W7rH6XFowEOUppVXIm9CIdlt11MjtE0oRnBzRb5LH0E/
         chTCMlv7KLARaugGeqHmFUa+/mP5NptiymRY0biagC6/WbiEoW7WlNJh5rxJA/bc6J4f
         qdTEMDRyjcEC+V/DH17aRzAVKufn7nK/U5wpY6+IQFWF9GNGPtVLBVU/HmfRb1CFrJjD
         jinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718929565; x=1719534365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o27Dzgf4rpoKbx49OiT/b8IHaMhGMy+nSzgKnErVO1c=;
        b=rXuR7xEO7KD69GdLWwHV7ZoRVJE685WXQenEvb5nTvZY4ZM5JEmo4MGEz300JROXkH
         dgHEOkRnOQ5o/MxdOV+InzW2lSIU88cjx2oCGjlVuSmJCKeUVcrSlIvIRZA4WzcdxuLx
         C7L0s3zxhjJKMapE/wxq0MJMZTaE39RJb5RIxVDAPK61r4Q2tXeFa7cwK46mnB427sv1
         954p4947Bnfe+Jarckzv9/zTT4VFwRsotJdROIkLBO/YP3fKsKeUS2lZlimtV4LKdNom
         qS982WXtaPnQP+R5tc9p3A/3ugvBIewcGHwEIpD05Z6Jq3kyKbP9dQf8dPZFQD/W3JaA
         wgJw==
X-Forwarded-Encrypted: i=1; AJvYcCWhqA4e6ZaVxavN6BlPrkVlA7jQeQqLnip4pxe5CUGq6XfYvFbxYO7JKzGkvDFaCXdx/rgc3FqiSuWI+HdV3dYtahUX
X-Gm-Message-State: AOJu0Yx2I2jUVIG5DL90iOyVx41Q2AFOtop1N0ylAG0KVyYirzUmlpM7
	t/q4Mg4S6V4+2Vbjeiw/gqQLtIVEc+24FCis6RGYzOLZ02obQ6DsDRKnezrwDkakkJRSidmgQ6Q
	G5RsooUBzbOR6j0mgMm/fP75vm/pVaQ==
X-Google-Smtp-Source: AGHT+IG9HOV9bfKR6jCaRTW6v93k914dMCKtGmpMl2bVG8wxQIzZ0Ls6+0C+jHPs20s1Jppu5xoz0DijiXzllnCCGS4=
X-Received: by 2002:a17:90a:ea92:b0:2c2:f8f5:a057 with SMTP id
 98e67ed59e1d1-2c7b5d6b712mr6686941a91.33.1718929565442; Thu, 20 Jun 2024
 17:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620213435.16336-1-daniel@iogearbox.net> <20240620213435.16336-2-daniel@iogearbox.net>
In-Reply-To: <20240620213435.16336-2-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Jun 2024 17:25:53 -0700
Message-ID: <CAEf4Bzbh0namfTo_edZFQZr2axRJDT+8Yv0JHyiU9mcV2pOAnw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add more ring buffer test coverage
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 2:34=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Add test coverage for reservations beyond the ring buffer size in order
> to validate that bpf_ringbuf_reserve() rejects the request with NULL, all
> other ring buffer tests keep passing as well:
>
>   # ./vmtest.sh -- ./test_progs -t ringbuf
>   [...]
>   ./test_progs -t ringbuf
>   [    1.165434] bpf_testmod: loading out-of-tree module taints kernel.
>   [    1.165825] bpf_testmod: module verification failed: signature and/o=
r required key missing - tainting kernel
>   [    1.284001] tsc: Refined TSC clocksource calibration: 3407.982 MHz
>   [    1.286871] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0=
x311fc34e357, max_idle_ns: 440795379773 ns
>   [    1.289555] clocksource: Switched to clocksource tsc
>   #274/1   ringbuf/ringbuf:OK
>   #274/2   ringbuf/ringbuf_n:OK
>   #274/3   ringbuf/ringbuf_map_key:OK
>   #274/4   ringbuf/ringbuf_write:OK
>   #274     ringbuf:OK
>   #275     ringbuf_multi:OK
>   [...]
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/testing/selftests/bpf/Makefile          |  2 +-
>  .../selftests/bpf/prog_tests/ringbuf.c        | 46 +++++++++++++++++++
>  .../selftests/bpf/progs/test_ringbuf_write.c  | 42 +++++++++++++++++
>  3 files changed, 89 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_write.=
c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index e0b3887b3d2d..dd49c1d23a60 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -457,7 +457,7 @@ LINKED_SKELS :=3D test_static_linked.skel.h linked_fu=
ncs.skel.h               \
>  LSKELS :=3D fentry_test.c fexit_test.c fexit_sleep.c atomics.c          =
 \
>         trace_printk.c trace_vprintk.c map_ptr_kern.c                   \
>         core_kern.c core_kern_overflow.c test_ringbuf.c                 \
> -       test_ringbuf_n.c test_ringbuf_map_key.c
> +       test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c
>
>  # Generate both light skeleton and libbpf skeleton for these
>  LSKELS_EXTRA :=3D test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.=
c \
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/tes=
ting/selftests/bpf/prog_tests/ringbuf.c
> index 4c6f42dae409..3eddd5e9c10b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> @@ -12,9 +12,11 @@
>  #include <sys/sysinfo.h>
>  #include <linux/perf_event.h>
>  #include <linux/ring_buffer.h>
> +
>  #include "test_ringbuf.lskel.h"
>  #include "test_ringbuf_n.lskel.h"
>  #include "test_ringbuf_map_key.lskel.h"
> +#include "test_ringbuf_write.lskel.h"
>
>  #define EDONE 7777
>
> @@ -84,6 +86,48 @@ static void *poll_thread(void *input)
>         return (void *)(long)ring_buffer__poll(ringbuf, timeout);
>  }
>
> +static void ringbuf_write_subtest(void)
> +{
> +       struct test_ringbuf_write_lskel *skel;
> +       int page_size =3D getpagesize();
> +       size_t *mmap_ptr;
> +       int err, rb_fd;
> +
> +       skel =3D test_ringbuf_write_lskel__open();
> +       if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
> +               return;
> +
> +       skel->maps.ringbuf.max_entries =3D 0x4000;
> +
> +       err =3D test_ringbuf_write_lskel__load(skel);
> +       if (CHECK(err !=3D 0, "skel_load", "skeleton load failed\n"))

here and above, let's not add CHECK(), let's stick to ASSERT_xxx()

> +               goto cleanup;
> +
> +       rb_fd =3D skel->maps.ringbuf.map_fd;
> +
> +       mmap_ptr =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SH=
ARED, rb_fd, 0);
> +       ASSERT_OK_PTR(mmap_ptr, "rw_cons_pos");
> +       *mmap_ptr =3D 0x3000;
> +
> +       skel->bss->pid =3D getpid();
> +
> +       ringbuf =3D ring_buffer__new(skel->maps.ringbuf.map_fd,
> +                                  process_sample, NULL, NULL);
> +       if (CHECK(!ringbuf, "ringbuf_create", "failed to create ringbuf\n=
"))
> +               goto cleanup;
> +
> +       err =3D test_ringbuf_write_lskel__attach(skel);
> +       if (CHECK(err, "skel_attach", "skeleton attachment failed: %d\n",=
 err))
> +               goto cleanup;
> +
> +       trigger_samples();
> +       ASSERT_GE(skel->bss->discarded, 1, "discarded");
> +       ASSERT_EQ(skel->bss->passed, 0, "passed");
> +cleanup:
> +       ring_buffer__free(ringbuf);
> +       test_ringbuf_write_lskel__destroy(skel);
> +}
> +
>  static void ringbuf_subtest(void)
>  {
>         const size_t rec_sz =3D BPF_RINGBUF_HDR_SZ + sizeof(struct sample=
);
> @@ -451,4 +495,6 @@ void test_ringbuf(void)
>                 ringbuf_n_subtest();
>         if (test__start_subtest("ringbuf_map_key"))
>                 ringbuf_map_key_subtest();
> +       if (test__start_subtest("ringbuf_write"))
> +               ringbuf_write_subtest();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_write.c b/too=
ls/testing/selftests/bpf/progs/test_ringbuf_write.c
> new file mode 100644
> index 000000000000..c6c67238a7c8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_RINGBUF);
> +} ringbuf SEC(".maps");
> +
> +long discarded, passed;
> +int pid;
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int test_ringbuf_write(void *ctx)
> +{
> +       int *foo, cur_pid =3D bpf_get_current_pid_tgid() >> 32;
> +       void *sample1, *sample2;
> +
> +       if (cur_pid !=3D pid)
> +               return 0;
> +
> +       sample1 =3D bpf_ringbuf_reserve(&ringbuf, 0x3000, 0);
> +       if (!sample1)
> +               return 0;
> +       /* first one can pass */
> +       sample2 =3D bpf_ringbuf_reserve(&ringbuf, 0x3000, 0);
> +       if (!sample2) {
> +               bpf_ringbuf_discard(sample1, 0);
> +               __sync_fetch_and_add(&discarded, 1);
> +               return 0;
> +       }
> +       /* second one must not */
> +       __sync_fetch_and_add(&passed, 1);
> +       foo =3D sample2 + 4084;
> +       *foo =3D 256;
> +       bpf_ringbuf_discard(sample1, 0);
> +       bpf_ringbuf_discard(sample2, 0);
> +       return 0;
> +}
> --
> 2.43.0
>
>

