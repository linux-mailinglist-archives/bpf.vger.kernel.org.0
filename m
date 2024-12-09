Return-Path: <bpf+bounces-46416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537789E9D7B
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 18:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DE4161F66
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5871F2C33;
	Mon,  9 Dec 2024 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H15uL/Ju"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31311C5CB8;
	Mon,  9 Dec 2024 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766556; cv=none; b=ImfkA1zQlaj11fUzlnJ3dkfZbtO1x9ToopjXrHVuiCF53NVa8pymhvJOtxiwSBZyEuYhwgykcoEE95LUkR1JoSPpEbM6yagnMRRSPBvz1YgkiBNq2MAsk7d+Xxh8nQ87L4RCzuPCZ5WLrR/lTSk/NqNbc+AfsB2ThSSAb/EgdP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766556; c=relaxed/simple;
	bh=4YuvxkDx+/G2+aUC84wcLqNebJJLuZeEuLlObDhq52A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQcoGvybvki1utBKRrNUnxXzcsYJzogDDj8a0paVxmacQirALYUNDUtKf9WomrpCWr5ti4Bk+JNGYpUUJLPjm/YYowElXfjVbYnKyAled2ObrZ7TovW8SlHdLOxMNhbuy9CgUw//eTeKT2kT10CVYkknBGbHOHyqhiLXo/Xw6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H15uL/Ju; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215ac560292so46252025ad.2;
        Mon, 09 Dec 2024 09:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733766554; x=1734371354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZu1+urGVcud0ou0n5g4exjSVK3H5pW4MRBDK0t68Fg=;
        b=H15uL/JuUobZwrpAvKp0VwgeoS9xo9EOl0jle5qai6w4fII4NjIPDEa6jo8xCSX662
         jieb/srXdC4vNHtRtpe5d/ewt2BPWQR9Rn/C3+mWo5/N4TGxfvIsGQ2GgpEVquNyYmvE
         qAO70CAKlvIarlW7W8LEDJYQjDiUYAEtnDu6CQdHQiTEuBgwcY5PEDb+WLvIm5fKR4yB
         JiASLBwkBxJ8JjzBtFUhs4GM62tpBESCF27Sg8ct1+ert4cMYEQLZ0JGeHKHNNEFDOPG
         UUG62z4+NQeliBoiw0cv9h4jUgwoOPpDsrFzKfz0pLXTTCSouZ54ExRg9tWxQwuh1h0y
         g9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733766554; x=1734371354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZu1+urGVcud0ou0n5g4exjSVK3H5pW4MRBDK0t68Fg=;
        b=Q15krN+Srcm4F1+fPmM7SgWiZnIBMbXinkvszqJUTf62JGCpSjB+Yhq9dWY8NsNMvW
         WZp7IRsHWinFxHotVhfWUcjovPJF1SqEF5W6UzvEC+X1h0VE8Oh6/sSY3IZhUEoRVoGU
         aciHAoIEaVXE6DlFoDpvlXSDe94Bm+RvaIwkp7z67HfcmfpJqgp9Mh+hFTb+BvdWl5ii
         G7I/SoGJFEbzFz5NN4zqrADACOFcTDqwoeVfnJZnQY+lMWmAoG+rD82viOpUQTJeHF2G
         bdwH3kNsyMbPMYloCQ70fTwcxikPm90cggNJ6x/lQNYmUGi2aNBhEwo4iZDKSnwfQA+k
         dgcw==
X-Forwarded-Encrypted: i=1; AJvYcCWfJ9NBK6Z82PUWn8z30TgAo3ck1cFTUW3Y0kFY/bw9kxM99PYEUPl4FofpEw9NW9cl6N0=@vger.kernel.org, AJvYcCX7ywL4D5VkmEUGRaiSm7j5BSG3TjYuktgFjIKUHdDd/e8Cl9LEBI0bHMA/olKzDMNIDkskIPGgb7EalsUByciHLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrfxgzzGpWsIzLCz13wtQs5aEX+BHWoKc5QRIleI8F6oHFzIoC
	5jWDF8m4ZsYMt7ffw/mG1Yezl/kD4jiij5EA+sBCHbdDmTvkvC2XoB/qF2L9NhiMZJdvSFC3fCV
	JyF3S66Sj/i+aZXhAL5FV1d6sGKI=
X-Gm-Gg: ASbGncvMYJ3UITOf2Asja1+0yuXx7wnBWQc8z2heb/gop/VV64ijuOCuyO4Ocmbu2Si
	44+HEFPGoM0ZjG8VtGgFXjq/Il4Z6+FVBS/MR0VrZoetO+Vamuf8=
X-Google-Smtp-Source: AGHT+IGqM+ReE5VyKbANy3zDiiYzzNQAVE78b6BcN0Tun/D5xEEgTs6j32rJzdpGN4ynTfVrxkFN82gTE1xq56LedjM=
X-Received: by 2002:a17:902:ec92:b0:215:a172:5fb9 with SMTP id
 d9443c01a7336-2166a05562cmr20190715ad.48.1733766553869; Mon, 09 Dec 2024
 09:49:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023100131.3400274-1-jolsa@kernel.org> <CAEf4BzbZdaPaspRAVP7=UcfpFzR4qhksJTRiEwiZ9RDQtdg0bQ@mail.gmail.com>
 <Z1Mv3wjtonrX_ptM@krava> <CAEf4BzZ4nzqWcn9iNPhRY4dfhNWrMp+D8Gxs7eTBqie=g55o5Q@mail.gmail.com>
 <Z1OVRwKCZ-ciWlAy@krava>
In-Reply-To: <Z1OVRwKCZ-ciWlAy@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Dec 2024 09:49:01 -0800
Message-ID: <CAEf4BzbGnAAihFg8FYB-yKVLn4D6iHoL98r+PhiBEeJHRYT3sg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf,perf: Fix perf_event_detach_bpf_prog error handling
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Sean Young <sean@mess.org>, Peter Zijlstra <peterz@infradead.org>, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:22=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Fri, Dec 06, 2024 at 10:21:18AM -0800, Andrii Nakryiko wrote:
> > On Fri, Dec 6, 2024 at 9:09=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Wed, Oct 23, 2024 at 09:01:02AM -0700, Andrii Nakryiko wrote:
> > > > On Wed, Oct 23, 2024 at 3:01=E2=80=AFAM Jiri Olsa <jolsa@kernel.org=
> wrote:
> > > > >
> > > > > Peter reported that perf_event_detach_bpf_prog might skip to rele=
ase
> > > > > the bpf program for -ENOENT error from bpf_prog_array_copy.
> > > > >
> > > > > This can't happen because bpf program is stored in perf event and=
 is
> > > > > detached and released only when perf event is freed.
> > > > >
> > > > > Let's make it obvious and add WARN_ON_ONCE on the -ENOENT check a=
nd
> > > > > make sure the bpf program is released in any case.
> > > > >
> > > > > Cc: Sean Young <sean@mess.org>
> > > > > Fixes: 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return -E=
NOENT if exclude_prog not found")
> > > > > Closes: https://lore.kernel.org/lkml/20241022111638.GC16066@noisy=
.programming.kicks-ass.net/
> > > > > Reported-by: Peter Zijlstra <peterz@infradead.org>
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  kernel/trace/bpf_trace.c | 5 +++--
> > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > > > index 95b6b3b16bac..2c064ba7b0bd 100644
> > > > > --- a/kernel/trace/bpf_trace.c
> > > > > +++ b/kernel/trace/bpf_trace.c
> > > > > @@ -2216,8 +2216,8 @@ void perf_event_detach_bpf_prog(struct perf=
_event *event)
> > > > >
> > > > >         old_array =3D bpf_event_rcu_dereference(event->tp_event->=
prog_array);
> > > > >         ret =3D bpf_prog_array_copy(old_array, event->prog, NULL,=
 0, &new_array);
> > > > > -       if (ret =3D=3D -ENOENT)
> > > > > -               goto unlock;
> > > > > +       if (WARN_ON_ONCE(ret =3D=3D -ENOENT))
> > > > > +               goto put;
> > > > >         if (ret < 0) {
> > > > >                 bpf_prog_array_delete_safe(old_array, event->prog=
);
> > > >
> > > > seeing
> > > >
> > > > if (ret < 0)
> > > >     bpf_prog_array_delete_safe(old_array, event->prog);
> > > >
> > > > I think neither ret =3D=3D -ENOENT nor WARN_ON_ONCE is necessary,  =
tbh. So
> > > > now I feel like just dropping WARN_ON_ONCE() is better.
> > >
> > > hi,
> > > there's syzbot report [1] where we could end up with following
> > >
> > >   - create perf event and set bpf program to it
> > >   - clone process -> create inherited event
> > >   - exit -> release both events
> > >   - first perf_event_detach_bpf_prog call will release tp_event->prog=
_array
> > >     and second perf_event_detach_bpf_prog will crash because
> > >     tp_event->prog_array is NULL
> > >
> > > we can fix that quicly with change below, I guess we could add refcou=
nt
> > > to bpf_prog_array_item and allow one of the parent/inherited events t=
o
> > > work while the other is gone.. but that might be too much, will check
> > >
> > > jirka
> > >
> > >
> > > [1] https://lore.kernel.org/bpf/Z1MR6dCIKajNS6nU@krava/T/#m91dbf06882=
21ec7a7fc95e896a7ef9ff93b0b8ad
> > > ---
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index fe57dfbf2a86..d4b45543ebc2 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -2251,6 +2251,8 @@ void perf_event_detach_bpf_prog(struct perf_eve=
nt *event)
> > >                 goto unlock;
> > >
> > >         old_array =3D bpf_event_rcu_dereference(event->tp_event->prog=
_array);
> > > +       if (!old_array)
> > > +               goto put;
> >
> > How does this inherited event stuff work? You can have two separate
> > events sharing the same prog_array? What if we attach different
> > programs to each of those events, will both of them be called for
> > either of two events? That sounds broken, if that's true.
>
> so perf event with attr.inherit=3D1 attached on task will get inherited
> by child process.. the new child event shares the parent's bpf program
> and tp_event (hence prog_array) which is global for tracepoint
>
> AFAICS when child process exits the inherited event is destroyed and it
> removes related tp_event->prog_array, so the parent event won't trigger
> ever again, the test below shows that
>

Doesn't this sound broken? Either event inheritance has to copy
prog_array and make them completely independent. Or inherited event
shouldn't remove the parent's program. Or something else, but the way
it is right now seems wrong, no?

I'm not sure what's the most appropriate behavior that would match
overall perf_event inheritance, but we should probably think about
this and fix it, instead of patching up the symptom with that NULL
check, no?

>   test_tp_attach:FAIL:executed unexpected executed: actual 1 !=3D expecte=
d 2
>
> I'm not sure this is problem in practise, because nobody complained
> about that ;-)

That's... not really a distinction of what is a problem or not ;)

>
> libbpf does not set attr.inherit=3D1 and creates system wide perf event,
> so no problem there

you can use all this outside of libbpf and lead to wrong behavior, so
worth thinking about this and fixing, IMO

>
> jirka
>
>
> ---
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 66173ddb5a2d..2e96241b5030 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -12430,8 +12430,9 @@ static int perf_event_open_tracepoint(const char =
*tp_category,
>         attr.type =3D PERF_TYPE_TRACEPOINT;
>         attr.size =3D attr_sz;
>         attr.config =3D tp_id;
> +       attr.inherit =3D 1;
>
> -       pfd =3D syscall(__NR_perf_event_open, &attr, -1 /* pid */, 0 /* c=
pu */,
> +       pfd =3D syscall(__NR_perf_event_open, &attr, 0 /* pid */, 0 /* cp=
u */,
>                       -1 /* group_fd */, PERF_FLAG_FD_CLOEXEC);
>         if (pfd < 0) {
>                 err =3D -errno;
> diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach.c b/tools/t=
esting/selftests/bpf/prog_tests/tp_attach.c
> new file mode 100644
> index 000000000000..01bbf1d1ab52
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tp_attach.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "tp_attach.skel.h"
> +
> +void test_tp_attach(void)
> +{
> +       struct tp_attach *skel;
> +       int pid;
> +
> +       skel =3D tp_attach__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "tp_attach__open_and_load"))
> +               return;
> +
> +       skel->bss->pid =3D getpid();
> +
> +       if (!ASSERT_OK(tp_attach__attach(skel), "tp_attach__attach"))
> +               goto out;
> +
> +       getpid();
> +
> +       pid =3D fork();
> +       if (!ASSERT_GE(pid, 0, "fork"))
> +               goto out;
> +       if (pid =3D=3D 0)
> +               _exit(0);
> +       waitpid(pid, NULL, 0);
> +
> +       getpid();
> +
> +       ASSERT_EQ(skel->bss->executed, 2, "executed");
> +
> +out:
> +       tp_attach__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/tp_attach.c b/tools/testin=
g/selftests/bpf/progs/tp_attach.c
> new file mode 100644
> index 000000000000..d9450d2eac17
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tp_attach.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +int pid;
> +int executed;
> +
> +SEC("tp/syscalls/sys_enter_getpid")
> +int test(void *ctx)
> +{
> +       if (pid =3D=3D (bpf_get_current_pid_tgid() >> 32))
> +               executed++;
> +       return 0;
> +}

