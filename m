Return-Path: <bpf+bounces-31799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED5E9038C3
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 12:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65F11C23482
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BDB14F9F0;
	Tue, 11 Jun 2024 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx9203Qc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2217839E;
	Tue, 11 Jun 2024 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101377; cv=none; b=uNZox1+GXaPnl/ppFbq5ZZc6h/VVtHn1crn54c22JTRKP366FjWReg2yNkXpvoEB9FP/yYKJmjJNDXFAThF0jJmkq5Engs0f6gVFJghKrRjGT/X06SVWSHWWcd9X8w5QDyFHMXzBXsOUauGyG+cfZQEOUWNGlqbBPKlsxQo5gd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101377; c=relaxed/simple;
	bh=uTqag8H8+DSIQHo4vePjtcbm9DUJcpVlRYZVfpHfy60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3bjcsf8inExj+dxVI0582WKbJMfPZLB23mcM4Pqp8J2hq0B26xhr8IvyvMRDqmfa2mrVuWO+iq6nVa/Khl+mLzHUqwp33XJWwmqdHBgrNSOrhh5yt6+1AgIjCEgo6hf4DyAKh0/metl3VUZ7k5W4HmWkfsThzRJ81Mz5H/3eNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cx9203Qc; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62cecde1db9so33501067b3.2;
        Tue, 11 Jun 2024 03:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718101373; x=1718706173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEdzvGqDKTZt3HQPWkaBG0IeRHTfTUB+R8I8SjGIQxs=;
        b=Cx9203QcAcuMVHr6Plzf4kZT8NN5D6y+tr6xYDfoYsH1+FqUbBT6SMfYzTXS3TzAwB
         t0jhvA3SI18vtzAzNdgFRStGOiLGY1JfuUlS1Al4+tVVbShj6JnQDo8f1Fp6L0I4Kch3
         BBuDL7hZSpjrPqjCVp7B1VWFUNfZFr+b2iG72Heldwep2TuEovSH+HZT39VB5ilo4wMK
         vvJa2LY2NWIv/Bk8TVoWV4XbXImgm4qB+szVOev/PmJtm8bSIYH3YI8aJ5E7wLlmsfKV
         /JBfCI9+HbZfonbuG7GrC9FueZnzwKOneilkb6TL/cHTRqmoLYRbo9mybvQKJsM8nwU1
         3E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718101373; x=1718706173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEdzvGqDKTZt3HQPWkaBG0IeRHTfTUB+R8I8SjGIQxs=;
        b=YEkgAe5+8I3pGLw1II+sBaI794NMJeCEplYHr0TeHzcKwVdDLvixlVVXqofrmFsl1g
         oU2X74gAlZWY2mooisehYWrREdiQfhZ/+GMZREY/aTbPOYyE+Nb+Ebjh0pwOr46Xx7nn
         x7ZdMrqAwVYiK4DTMizpfQTx97SY/C2wv0TOHWwukKLKKvTHQ8qvl9Omri+tGTGTusS4
         Mt+aOQz4kvxjiBfDucZk0gdAJ+g7oUWThE3TkIv7TmC64OEO9JxKNgeDeI+1YJ0quK3M
         4NhdWOaFf72BeooNvdi4PCJSQbM1KqitEC9uPe99cOUC+Bxvb6JINJvU/kouDDCb9Y3H
         OmnA==
X-Forwarded-Encrypted: i=1; AJvYcCWhq1OW9K0kbKhcfOjJAfpeIE+sRJqxDjMuUmZDfpvU8C6e8F4pV+yvWbyXtP/yoDrk/xrjEljQpRt7aX3kDNxPCBNeLOBytfINNg66UvIXwpO3Euq6ubhN3924Rrs9KAJngPYrqbB00hqGxRGDbXxJ5z5tRyjux4YLuW+Cnx3lhuJJQk1J8Ebyc0ciCR6tSrJu40NQGQDnS61DVkiowlzBazEEIJHwWbUU0w==
X-Gm-Message-State: AOJu0Yx6v3oGciuPfLKSy2OnRmzatdWdO/Bn2PsTDHzKzBdt8EhGLS2V
	7XuqI+KR964oHDedRiedlTZPAZT8j7yvRBusyfmuVzwrBgDI79IG/GZJU8oC85eL+eisq03fekL
	KNLBPINJ6XN8IB9sLXBHT2MbAxKFgMusE3a3NQSv87X0=
X-Google-Smtp-Source: AGHT+IGLygQs9yEJCyFtr7oLEn8fqgHRoTaBxXDQlGYF+1bXvN0e51m7Qo9sEZyZ991rHr/MehHUylTSGtxlR9NwW9o=
X-Received: by 2002:a81:8315:0:b0:62c:e0fe:5dad with SMTP id
 00721157ae682-62d0be323a9mr54473127b3.36.1718101373130; Tue, 11 Jun 2024
 03:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172147.2779890-1-howardchu95@gmail.com> <CAP-5=fVW0coox1KFpoVTq5wf54yyppM0JgXNT5mLfLOCX_Jugg@mail.gmail.com>
In-Reply-To: <CAP-5=fVW0coox1KFpoVTq5wf54yyppM0JgXNT5mLfLOCX_Jugg@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 11 Jun 2024 18:22:42 +0800
Message-ID: <CAH0uvoj3diKJdkW2pTkwLrX_vqnEeTt6=1+eirVDexSAH7L3uA@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix syscall untraceable bug
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	mic@digikod.net, gnoack@google.com, brauner@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

Thanks for reviewing this patch.

On Tue, Jun 11, 2024 at 5:33=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sat, Jun 8, 2024 at 10:21=E2=80=AFAM Howard Chu <howardchu95@gmail.com=
> wrote:
> >
> > This is a bug found when implementing pretty-printing for the
> > landlock_add_rule system call, I decided to send this patch separately
> > because this is a serious bug that should be fixed fast.
> >
> > I wrote a test program to do landlock_add_rule syscall in a loop,
> > yet perf trace -e landlock_add_rule freezes, giving no output.
> >
> > This bug is introduced by the false understanding of the variable "key"
> > below:
> > ```
> > ```
> > The code above seems right at the beginning, but when looking at
> > syscalltbl.c, I found these lines:
> >
> > ```
> >
> > entries =3D tbl->syscalls.entries =3D malloc(sizeof(struct syscall) * n=
r_entries);
> > ...
> >
> > ```
> >
> > meaning the key is merely an index to traverse the syscall table,
> > instead of the actual syscall id for this particular syscall.
>
>
> Thanks Howard, I'm not following this. Doesn't it make sense to use
> the syscall number as its id?

Yes, it makes perfect sense to use the syscall number as its id. But here:

> > for (key =3D 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
> >         struct syscall *sc =3D trace__syscall_info(trace, NULL, key);
> >         ...
> > }

sctbl->syscalls.nr_entries is not the upper bound of those syscall
ids, it is how many syscalls that are native to the system, that we
collected. We collect them this way(in util/syscalltbl.c):

> > for (i =3D 0; i <=3D syscalltbl_native_max_id; ++i)
> >         if (syscalltbl_native[i])
> >                 ++nr_entries;

> > for (i =3D 0, j =3D 0; i <=3D syscalltbl_native_max_id; ++i) {
> >         if (syscalltbl_native[i]) {
> >                 entries[j].name =3D syscalltbl_native[i];
> >                 entries[j].id =3D i;
> >                 ++j;
> >         }
> > }

As shown above, we only collect syscalls that are native to the architectur=
e.

```
#if defined(__x86_64__)
#include <asm/syscalls_64.c>
const int syscalltbl_native_max_id =3D SYSCALLTBL_x86_64_MAX_ID;
static const char *const *syscalltbl_native =3D syscalltbl_x86_64;
```

So when collecting these entries of system calls, we neglect some of
the system calls that are not available on the system. How many system
calls are available? nr_entries of them are available.

But the real upper bound of the syscall id is syscalls.max_id.
```
tbl->syscalls.max_id =3D syscalltbl_native_max_id;
```

here is one example:

(think about s1 as syscall of id1, syscall s2 is not available on the syste=
m)

s1 s2 s3 s4 (max_id: 4)
s1 __ s3 s4 (nr_entries: 3)

If one uses nr_entries as the upper bound, we'll end up traversing
only the ids of s1, s2, s3 (of course, s2 doesn't exist so if you do
`perf trace -v` you will see the error message), and then we will lose
the precious and fully traceable s4.

What will happen is, in trace__init_syscalls_bpf_prog_array_maps(), if
you stop at nr_entries when traversing, you won't register bpf's
sys_enter program for some system calls, causing the bpf_tail_call to
fail. And if you fail, you fall through and return a 0, well, I have
to admit that I am still trying to understand this, but returning 0
means no sample, but if the bpf_tail_call succeeds,
syscall_unaugmented() is called, it returns a 1, and there will be
samples.

```
SEC("tp/raw_syscalls/sys_enter")
int syscall_unaugmented(struct syscall_enter_args *args)
{
return 1;
}
```

```
bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);

// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
return 0;
```

>
> >
> >
> > So if one uses key to do trace__syscall_info(trace, NULL, key), because
> > key only goes up to trace->sctbl->syscalls.nr_entries, for example, on
> > my X86_64 machine, this number is 373, it will end up neglecting all
> > the rest of the syscall, in my case, everything after `rseq`, because
> > the traversal will stop at 373, and `rseq` is the last syscall whose id
> > is lower than 373
> >
> > in tools/perf/arch/x86/include/generated/asm/syscalls_64.c:
> > ```
> >         ...
> >         [334] =3D "rseq",
> >         [424] =3D "pidfd_send_signal",
> >         ...
> > ```
> >
> > The reason why the key is scrambled but perf trace works well is that
> > key is used in trace__syscall_info(trace, NULL, key) to do
> > trace->syscalls.table[id], this makes sure that the struct syscall retu=
rned
> > actually has an id the same value as key, making the later bpf_prog
> > matching all correct.
>
>
> Could we create a test for this? We have tests that list all perf
> events and then running a perf command on them. It wouldn't be
> possible to guarantee output.

Sure, you can't guarantee the output because syscalls are architecture
and kernel version specific. I am running perf on kernel version
6.9.3, and my processor is X86_64. I tried to write the test script in
perl and shell script but failed, so here is a quick test in c if you
want to test it out. This is just doing 3 system calls though...

```
#define _GNU_SOURCE
#include <unistd.h>
#include <linux/landlock.h>
#include <sys/syscall.h>
#include <stdio.h>
#include <stdlib.h>

void ll()
{
syscall(SYS_landlock_add_rule, 0,
LANDLOCK_RULE_NET_PORT,
NULL, 0);
syscall(SYS_landlock_add_rule, 0,
LANDLOCK_RULE_PATH_BENEATH,
NULL, 0);
}

void opat2()
{
syscall(SYS_openat2, 114, "openat2 path", NULL, 0);
}

void faat2()
{
syscall(SYS_faccessat2, 0, "faccessat2 path", 0, 0);
}

int main()
{
printf("testing syscalls...");

while (1) {
ll();
opat2();
faat2();
sleep(1);
}

return 0;
}
```

Please save it as test.c, compile it with
```
gcc test.c -o test
```

Please compile the patched and original perf with BUILD_BPF_SKEL=3D1.
The behaviour of BUILD_BPF_SKEL=3D0 is correct.

Now please run it with this command below:
```
perf trace -e faccessat2,openat2,landlock_add_rule -- ./test
```

Or just run ./test, and open up a second shell, do `perf trace -e
faccessat2,openat2,landlock_add_rule` system wide, or do a `ps aux |
grep test` and specify -p <pid-of-the-test-program>

If I run the test program, trace it with the original perf, there is
not a single trace message on all of these three system calls. Because
in the syscall table on my machine:
```
[437] =3D "openat2",
[439] =3D "faccessat2",
[445] =3D "landlock_add_rule",
```
these system calls' ids are bigger than the syscalls.nr_entries(on my
machine, 373), they never got registered.

I'm not 100% sure that you will get the same output as mine, so please
tell me if there's any difference when testing. I'll write up a test
covering all system calls soon.

Here's another aspect of this, the simplest fix is just changing:

> > for (key =3D 0; key < trace->sctbl->syscalls.nr_entries; ++key) {

to

> > for (key =3D 0; key < trace->sctbl->syscalls.max_id; ++key) {

no problem.

But when you run `perf trace -e landlock_add_rule -v`, you get:
```
perf $ ./perf trace -e landlock_add_rule -v
Using CPUID GenuineIntel-6-3D-4
Problems reading syscall 134: 2 (No such file or directory)(uselib) informa=
tion
Problems reading syscall 156: 2 (No such file or directory)(_sysctl) inform=
ation
Problems reading syscall 174: 2 (No such file or
directory)(create_module) information
Problems reading syscall 177: 2 (No such file or
directory)(get_kernel_syms) information
Problems reading syscall 178: 2 (No such file or
directory)(query_module) information
Problems reading syscall 180: 2 (No such file or
directory)(nfsservctl) information
Problems reading syscall 181: 2 (No such file or directory)(getpmsg) inform=
ation
Problems reading syscall 182: 2 (No such file or directory)(putpmsg) inform=
ation
Problems reading syscall 183: 2 (No such file or
directory)(afs_syscall) information
Problems reading syscall 184: 2 (No such file or directory)(tuxcall) inform=
ation
Problems reading syscall 185: 2 (No such file or directory)(security)
information
Problems reading syscall 205: 2 (No such file or
directory)(set_thread_area) information
Problems reading syscall 211: 2 (No such file or
directory)(get_thread_area) information
Problems reading syscall 212: 2 (No such file or
directory)(lookup_dcookie) information
Problems reading syscall 214: 2 (No such file or
directory)(epoll_ctl_old) information
Problems reading syscall 215: 2 (No such file or
directory)(epoll_wait_old) information
Problems reading syscall 236: 2 (No such file or directory)(vserver) inform=
ation
Problems reading syscall 335: 17 (File exists) information
Problems reading syscall 336: 17 (File exists) information
Problems reading syscall 337: 17 (File exists) information
Problems reading syscall 338: 17 (File exists) information
Problems reading syscall 339: 17 (File exists) information
Problems reading syscall 340: 17 (File exists) information
Problems reading syscall 341: 17 (File exists) information
Problems reading syscall 342: 17 (File exists) information
Problems reading syscall 343: 17 (File exists) information
Problems reading syscall 344: 17 (File exists) information
Problems reading syscall 345: 17 (File exists) information
Problems reading syscall 346: 17 (File exists) information
Problems reading syscall 347: 17 (File exists) information
Problems reading syscall 348: 17 (File exists) information
Problems reading syscall 349: 17 (File exists) information
Problems reading syscall 350: 17 (File exists) information
Problems reading syscall 351: 17 (File exists) information
Problems reading syscall 352: 17 (File exists) information
Problems reading syscall 353: 17 (File exists) information
Problems reading syscall 354: 17 (File exists) information
Problems reading syscall 355: 17 (File exists) information
Problems reading syscall 356: 17 (File exists) information
Problems reading syscall 357: 17 (File exists) information
Problems reading syscall 358: 17 (File exists) information
Problems reading syscall 359: 17 (File exists) information
Problems reading syscall 360: 17 (File exists) information
Problems reading syscall 361: 17 (File exists) information
Problems reading syscall 362: 17 (File exists) information
Problems reading syscall 363: 17 (File exists) information
Problems reading syscall 364: 17 (File exists) information
Problems reading syscall 365: 17 (File exists) information
Problems reading syscall 366: 17 (File exists) information
Problems reading syscall 367: 17 (File exists) information
Problems reading syscall 368: 17 (File exists) information
Problems reading syscall 369: 17 (File exists) information
Problems reading syscall 370: 17 (File exists) information
Problems reading syscall 371: 17 (File exists) information
Problems reading syscall 372: 17 (File exists) information
event qualifier tracepoint filter: (common_pid !=3D 1115781) && (id =3D=3D =
445)
mmap size 528384B
```

The registration of syscall from 335 to 372 is totally unnecessary.

reminder:
```
[334] =3D "rseq",
[424] =3D "pidfd_send_signal",
```

For example, syscall of id 335 is not available on my X86_64 machine,
why even bother reading this syscall's info using
trace__syscall_info().

So with this patch, the verbose message will become:

```
perf $ ./perf trace -e landlock_add_rule -v
Using CPUID GenuineIntel-6-3D-4
vmlinux BTF loaded
Problems reading syscall 156: 2 (No such file or directory)(_sysctl) inform=
ation
Problems reading syscall 183: 2 (No such file or
directory)(afs_syscall) information
Problems reading syscall 174: 2 (No such file or
directory)(create_module) information
Problems reading syscall 214: 2 (No such file or
directory)(epoll_ctl_old) information
Problems reading syscall 215: 2 (No such file or
directory)(epoll_wait_old) information
Problems reading syscall 177: 2 (No such file or
directory)(get_kernel_syms) information
Problems reading syscall 211: 2 (No such file or
directory)(get_thread_area) information
Problems reading syscall 181: 2 (No such file or directory)(getpmsg) inform=
ation
Problems reading syscall 156: 22 (Invalid argument)(_sysctl) information
Problems reading syscall 183: 22 (Invalid argument)(afs_syscall) informatio=
n
Problems reading syscall 174: 22 (Invalid argument)(create_module) informat=
ion
Problems reading syscall 214: 22 (Invalid argument)(epoll_ctl_old) informat=
ion
Problems reading syscall 215: 22 (Invalid argument)(epoll_wait_old) informa=
tion
Problems reading syscall 177: 22 (Invalid argument)(get_kernel_syms) inform=
ation
Problems reading syscall 211: 22 (Invalid argument)(get_thread_area) inform=
ation
Problems reading syscall 181: 22 (Invalid argument)(getpmsg) information
Problems reading syscall 212: 2 (No such file or
directory)(lookup_dcookie) information
Problems reading syscall 180: 2 (No such file or
directory)(nfsservctl) information
Problems reading syscall 182: 2 (No such file or directory)(putpmsg) inform=
ation
Problems reading syscall 178: 2 (No such file or
directory)(query_module) information
Problems reading syscall 185: 2 (No such file or directory)(security)
information
Problems reading syscall 205: 2 (No such file or
directory)(set_thread_area) information
Problems reading syscall 184: 2 (No such file or directory)(tuxcall) inform=
ation
Problems reading syscall 134: 2 (No such file or directory)(uselib) informa=
tion
Problems reading syscall 236: 2 (No such file or directory)(vserver) inform=
ation
Problems reading syscall 212: 22 (Invalid argument)(lookup_dcookie) informa=
tion
Problems reading syscall 180: 22 (Invalid argument)(nfsservctl) information
Problems reading syscall 182: 22 (Invalid argument)(putpmsg) information
Problems reading syscall 178: 22 (Invalid argument)(query_module) informati=
on
Problems reading syscall 185: 22 (Invalid argument)(security) information
Problems reading syscall 205: 22 (Invalid argument)(set_thread_area) inform=
ation
Problems reading syscall 184: 22 (Invalid argument)(tuxcall) information
Problems reading syscall 134: 22 (Invalid argument)(uselib) information
Problems reading syscall 236: 22 (Invalid argument)(vserver) information
event qualifier tracepoint filter: (common_pid !=3D 1129314) && (id =3D=3D =
445)
mmap size 528384B
```

Now only when reading native syscalls' information, if there's a
problem, there is an error message.

I think the desired behavior in
trace__init_syscalls_bpf_prog_array_maps() is that, when a system call
is not augmentable, you assign syscall_unaugmented() to it(via bpf
prog array)

But what happens is, when tracing landlock_add_rule, this program
never runs. Because there is never a bpf program registration for
landlock_add_rule, the key never reaches that high. With this patch,
it does.

So in util/bpf_skel/augmented_raw_syscalls.bpf.c, bpf_tail_call()
falls through, bpf program returns 0, there will be no samples. But if
it successfully calls syscall_unaugmented() and returns 1, there will
be samples.

But then again, if you build perf with BUILD_BPF_SKEL=3D0, using no bpf
functionalities, everything is fine, but if you do want to use bpf
augmentation, you have to register the syscall, the key has to go up
to max_id, stopping at nr_entries is probably not what we want.

>
> >
> > After fixing this bug, I can do perf trace on 38 more syscalls, and
> > because more syscalls are visible, we get 8 more syscalls that can be
> > augmented.
> >
> > before:
> >
> > perf $ perf trace -vv --max-events=3D1 |& grep Reusing
> > Reusing "open" BPF sys_enter augmenter for "stat"
> > Reusing "open" BPF sys_enter augmenter for "lstat"
> > Reusing "open" BPF sys_enter augmenter for "access"
> > Reusing "connect" BPF sys_enter augmenter for "accept"
> > Reusing "sendto" BPF sys_enter augmenter for "recvfrom"
> > Reusing "connect" BPF sys_enter augmenter for "bind"
> > Reusing "connect" BPF sys_enter augmenter for "getsockname"
> > Reusing "connect" BPF sys_enter augmenter for "getpeername"
> > Reusing "open" BPF sys_enter augmenter for "execve"
> > Reusing "open" BPF sys_enter augmenter for "truncate"
> > Reusing "open" BPF sys_enter augmenter for "chdir"
> > Reusing "open" BPF sys_enter augmenter for "mkdir"
> > Reusing "open" BPF sys_enter augmenter for "rmdir"
> > Reusing "open" BPF sys_enter augmenter for "creat"
> > Reusing "open" BPF sys_enter augmenter for "link"
> > Reusing "open" BPF sys_enter augmenter for "unlink"
> > Reusing "open" BPF sys_enter augmenter for "symlink"
> > Reusing "open" BPF sys_enter augmenter for "readlink"
> > Reusing "open" BPF sys_enter augmenter for "chmod"
> > Reusing "open" BPF sys_enter augmenter for "chown"
> > Reusing "open" BPF sys_enter augmenter for "lchown"
> > Reusing "open" BPF sys_enter augmenter for "mknod"
> > Reusing "open" BPF sys_enter augmenter for "statfs"
> > Reusing "open" BPF sys_enter augmenter for "pivot_root"
> > Reusing "open" BPF sys_enter augmenter for "chroot"
> > Reusing "open" BPF sys_enter augmenter for "acct"
> > Reusing "open" BPF sys_enter augmenter for "swapon"
> > Reusing "open" BPF sys_enter augmenter for "swapoff"
> > Reusing "open" BPF sys_enter augmenter for "delete_module"
> > Reusing "open" BPF sys_enter augmenter for "setxattr"
> > Reusing "open" BPF sys_enter augmenter for "lsetxattr"
> > Reusing "openat" BPF sys_enter augmenter for "fsetxattr"
> > Reusing "open" BPF sys_enter augmenter for "getxattr"
> > Reusing "open" BPF sys_enter augmenter for "lgetxattr"
> > Reusing "openat" BPF sys_enter augmenter for "fgetxattr"
> > Reusing "open" BPF sys_enter augmenter for "listxattr"
> > Reusing "open" BPF sys_enter augmenter for "llistxattr"
> > Reusing "open" BPF sys_enter augmenter for "removexattr"
> > Reusing "open" BPF sys_enter augmenter for "lremovexattr"
> > Reusing "fsetxattr" BPF sys_enter augmenter for "fremovexattr"
> > Reusing "open" BPF sys_enter augmenter for "mq_open"
> > Reusing "open" BPF sys_enter augmenter for "mq_unlink"
> > Reusing "fsetxattr" BPF sys_enter augmenter for "add_key"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "request_key"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "inotify_add_watch"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "mkdirat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "mknodat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "fchownat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "futimesat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "newfstatat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "unlinkat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "linkat"
> > Reusing "open" BPF sys_enter augmenter for "symlinkat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "readlinkat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "fchmodat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "faccessat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "utimensat"
> > Reusing "connect" BPF sys_enter augmenter for "accept4"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "name_to_handle_at"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "renameat2"
> > Reusing "open" BPF sys_enter augmenter for "memfd_create"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "statx"
> >
> > after
> >
> > perf $ perf trace -vv --max-events=3D1 |& grep Reusing
> > Reusing "open" BPF sys_enter augmenter for "stat"
> > Reusing "open" BPF sys_enter augmenter for "lstat"
> > Reusing "open" BPF sys_enter augmenter for "access"
> > Reusing "connect" BPF sys_enter augmenter for "accept"
> > Reusing "sendto" BPF sys_enter augmenter for "recvfrom"
> > Reusing "connect" BPF sys_enter augmenter for "bind"
> > Reusing "connect" BPF sys_enter augmenter for "getsockname"
> > Reusing "connect" BPF sys_enter augmenter for "getpeername"
> > Reusing "open" BPF sys_enter augmenter for "execve"
> > Reusing "open" BPF sys_enter augmenter for "truncate"
> > Reusing "open" BPF sys_enter augmenter for "chdir"
> > Reusing "open" BPF sys_enter augmenter for "mkdir"
> > Reusing "open" BPF sys_enter augmenter for "rmdir"
> > Reusing "open" BPF sys_enter augmenter for "creat"
> > Reusing "open" BPF sys_enter augmenter for "link"
> > Reusing "open" BPF sys_enter augmenter for "unlink"
> > Reusing "open" BPF sys_enter augmenter for "symlink"
> > Reusing "open" BPF sys_enter augmenter for "readlink"
> > Reusing "open" BPF sys_enter augmenter for "chmod"
> > Reusing "open" BPF sys_enter augmenter for "chown"
> > Reusing "open" BPF sys_enter augmenter for "lchown"
> > Reusing "open" BPF sys_enter augmenter for "mknod"
> > Reusing "open" BPF sys_enter augmenter for "statfs"
> > Reusing "open" BPF sys_enter augmenter for "pivot_root"
> > Reusing "open" BPF sys_enter augmenter for "chroot"
> > Reusing "open" BPF sys_enter augmenter for "acct"
> > Reusing "open" BPF sys_enter augmenter for "swapon"
> > Reusing "open" BPF sys_enter augmenter for "swapoff"
> > Reusing "open" BPF sys_enter augmenter for "delete_module"
> > Reusing "open" BPF sys_enter augmenter for "setxattr"
> > Reusing "open" BPF sys_enter augmenter for "lsetxattr"
> > Reusing "openat" BPF sys_enter augmenter for "fsetxattr"
> > Reusing "open" BPF sys_enter augmenter for "getxattr"
> > Reusing "open" BPF sys_enter augmenter for "lgetxattr"
> > Reusing "openat" BPF sys_enter augmenter for "fgetxattr"
> > Reusing "open" BPF sys_enter augmenter for "listxattr"
> > Reusing "open" BPF sys_enter augmenter for "llistxattr"
> > Reusing "open" BPF sys_enter augmenter for "removexattr"
> > Reusing "open" BPF sys_enter augmenter for "lremovexattr"
> > Reusing "fsetxattr" BPF sys_enter augmenter for "fremovexattr"
> > Reusing "open" BPF sys_enter augmenter for "mq_open"
> > Reusing "open" BPF sys_enter augmenter for "mq_unlink"
> > Reusing "fsetxattr" BPF sys_enter augmenter for "add_key"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "request_key"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "inotify_add_watch"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "mkdirat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "mknodat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "fchownat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "futimesat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "newfstatat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "unlinkat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "linkat"
> > Reusing "open" BPF sys_enter augmenter for "symlinkat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "readlinkat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "fchmodat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "faccessat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "utimensat"
> > Reusing "connect" BPF sys_enter augmenter for "accept4"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "name_to_handle_at"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "renameat2"
> > Reusing "open" BPF sys_enter augmenter for "memfd_create"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "statx"
> >
> > TL;DR:
> >
> > These are the new syscalls that can be augmented
> > Reusing "openat" BPF sys_enter augmenter for "open_tree"
> > Reusing "openat" BPF sys_enter augmenter for "openat2"
> > Reusing "openat" BPF sys_enter augmenter for "mount_setattr"
> > Reusing "openat" BPF sys_enter augmenter for "move_mount"
> > Reusing "open" BPF sys_enter augmenter for "fsopen"
> > Reusing "openat" BPF sys_enter augmenter for "fspick"
> > Reusing "openat" BPF sys_enter augmenter for "faccessat2"
> > Reusing "openat" BPF sys_enter augmenter for "fchmodat2"
> >
> > as for the perf trace output:
> >
> > before
> >
> > perf $ perf trace -e faccessat2 --max-events=3D1
> > [no output]
> >
> > after
> >
> > perf $ ./perf trace -e faccessat2 --max-events=3D1
> >      0.000 ( 0.037 ms): waybar/958 faccessat2(dfd: 40, filename: "ueven=
t")                               =3D 0
> >
> > P.S. The reason why this bug was not found in the past five years is
> > probably because it only happens to the newer syscalls whose id is
> > greater, for instance, faccessat2 of id 439, which not a lot of people
> > care about when using perf trace.
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/builtin-trace.c   | 32 +++++++++++++++++++++-----------
> >  tools/perf/util/syscalltbl.c | 21 +++++++++------------
> >  tools/perf/util/syscalltbl.h |  5 +++++
> >  3 files changed, 35 insertions(+), 23 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index c42bc608954e..5cbe1748911d 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -3354,7 +3354,8 @@ static int trace__bpf_prog_sys_exit_fd(struct tra=
ce *trace, int id)
> >  static struct bpf_program *trace__find_usable_bpf_prog_entry(struct tr=
ace *trace, struct syscall *sc)
> >  {
> >         struct tep_format_field *field, *candidate_field;
> > -       int id;
> > +       struct __syscall *scs =3D trace->sctbl->syscalls.entries;
> > +       int id, _id;
> >
> >         /*
> >          * We're only interested in syscalls that have a pointer:
> > @@ -3368,10 +3369,13 @@ static struct bpf_program *trace__find_usable_b=
pf_prog_entry(struct trace *trace
> >
> >  try_to_find_pair:
> >         for (id =3D 0; id < trace->sctbl->syscalls.nr_entries; ++id) {
> > -               struct syscall *pair =3D trace__syscall_info(trace, NUL=
L, id);
> > +               struct syscall *pair;
> >                 struct bpf_program *pair_prog;
> >                 bool is_candidate =3D false;
> >
> > +               _id =3D scs[id].id;
> > +               pair =3D trace__syscall_info(trace, NULL, _id);
> > +
> >                 if (pair =3D=3D NULL || pair =3D=3D sc ||
> >                     pair->bpf_prog.sys_enter =3D=3D trace->skel->progs.=
syscall_unaugmented)
> >                         continue;
> > @@ -3456,23 +3460,26 @@ static int trace__init_syscalls_bpf_prog_array_=
maps(struct trace *trace)
> >  {
> >         int map_enter_fd =3D bpf_map__fd(trace->skel->maps.syscalls_sys=
_enter);
> >         int map_exit_fd  =3D bpf_map__fd(trace->skel->maps.syscalls_sys=
_exit);
> > -       int err =3D 0, key;
> > +       int err =3D 0, key, id;
> > +       struct __syscall *scs =3D trace->sctbl->syscalls.entries;
> >
> >         for (key =3D 0; key < trace->sctbl->syscalls.nr_entries; ++key)=
 {
> >                 int prog_fd;
> >
> > -               if (!trace__syscall_enabled(trace, key))
> > +               id =3D scs[key].id;
> > +
> > +               if (!trace__syscall_enabled(trace, id))
> >                         continue;
> >
> > -               trace__init_syscall_bpf_progs(trace, key);
> > +               trace__init_syscall_bpf_progs(trace, id);
> >
> >                 // It'll get at least the "!raw_syscalls:unaugmented"
> > -               prog_fd =3D trace__bpf_prog_sys_enter_fd(trace, key);
> > -               err =3D bpf_map_update_elem(map_enter_fd, &key, &prog_f=
d, BPF_ANY);
> > +               prog_fd =3D trace__bpf_prog_sys_enter_fd(trace, id);
> > +               err =3D bpf_map_update_elem(map_enter_fd, &id, &prog_fd=
, BPF_ANY);
> >                 if (err)
> >                         break;
> > -               prog_fd =3D trace__bpf_prog_sys_exit_fd(trace, key);
> > -               err =3D bpf_map_update_elem(map_exit_fd, &key, &prog_fd=
, BPF_ANY);
> > +               prog_fd =3D trace__bpf_prog_sys_exit_fd(trace, id);
> > +               err =3D bpf_map_update_elem(map_exit_fd, &id, &prog_fd,=
 BPF_ANY);
> >                 if (err)
> >                         break;
> >         }
> > @@ -3506,10 +3513,13 @@ static int trace__init_syscalls_bpf_prog_array_=
maps(struct trace *trace)
> >          * array tail call, then that one will be used.
> >          */
> >         for (key =3D 0; key < trace->sctbl->syscalls.nr_entries; ++key)=
 {
> > -               struct syscall *sc =3D trace__syscall_info(trace, NULL,=
 key);
> > +               struct syscall *sc;
> >                 struct bpf_program *pair_prog;
> >                 int prog_fd;
> >
> > +               id =3D scs[key].id;
> > +               sc =3D trace__syscall_info(trace, NULL, id);
> > +
> >                 if (sc =3D=3D NULL || sc->bpf_prog.sys_enter =3D=3D NUL=
L)
> >                         continue;
> >
> > @@ -3535,7 +3545,7 @@ static int trace__init_syscalls_bpf_prog_array_ma=
ps(struct trace *trace)
> >                  * with the fd for the program we're reusing:
> >                  */
> >                 prog_fd =3D bpf_program__fd(sc->bpf_prog.sys_enter);
> > -               err =3D bpf_map_update_elem(map_enter_fd, &key, &prog_f=
d, BPF_ANY);
> > +               err =3D bpf_map_update_elem(map_enter_fd, &id, &prog_fd=
, BPF_ANY);
> >                 if (err)
> >                         break;
> >         }
> > diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.=
c
> > index 63be7b58761d..16aa886c40f0 100644
> > --- a/tools/perf/util/syscalltbl.c
> > +++ b/tools/perf/util/syscalltbl.c
> > @@ -44,22 +44,17 @@ const int syscalltbl_native_max_id =3D SYSCALLTBL_L=
OONGARCH_MAX_ID;
> >  static const char *const *syscalltbl_native =3D syscalltbl_loongarch;
> >  #endif
> >
> > -struct syscall {
> > -       int id;
> > -       const char *name;
> > -};
> > -
> >  static int syscallcmpname(const void *vkey, const void *ventry)
> >  {
> >         const char *key =3D vkey;
> > -       const struct syscall *entry =3D ventry;
> > +       const struct __syscall *entry =3D ventry;
> >
> >         return strcmp(key, entry->name);
> >  }
> >
> >  static int syscallcmp(const void *va, const void *vb)
> >  {
> > -       const struct syscall *a =3D va, *b =3D vb;
> > +       const struct __syscall *a =3D va, *b =3D vb;
> >
> >         return strcmp(a->name, b->name);
> >  }
> > @@ -67,13 +62,14 @@ static int syscallcmp(const void *va, const void *v=
b)
> >  static int syscalltbl__init_native(struct syscalltbl *tbl)
> >  {
> >         int nr_entries =3D 0, i, j;
> > -       struct syscall *entries;
> > +       struct __syscall *entries;
> >
> >         for (i =3D 0; i <=3D syscalltbl_native_max_id; ++i)
> >                 if (syscalltbl_native[i])
> >                         ++nr_entries;
> >
> > -       entries =3D tbl->syscalls.entries =3D malloc(sizeof(struct sysc=
all) * nr_entries);
> > +       entries =3D tbl->syscalls.entries =3D malloc(sizeof(struct __sy=
scall) *
> > +                                                nr_entries);
> >         if (tbl->syscalls.entries =3D=3D NULL)
> >                 return -1;
> >
> > @@ -85,7 +81,8 @@ static int syscalltbl__init_native(struct syscalltbl =
*tbl)
> >                 }
> >         }
> >
> > -       qsort(tbl->syscalls.entries, nr_entries, sizeof(struct syscall)=
, syscallcmp);
> > +       qsort(tbl->syscalls.entries, nr_entries, sizeof(struct __syscal=
l),
> > +             syscallcmp);
> >         tbl->syscalls.nr_entries =3D nr_entries;
> >         tbl->syscalls.max_id     =3D syscalltbl_native_max_id;
> >         return 0;
> > @@ -116,7 +113,7 @@ const char *syscalltbl__name(const struct syscalltb=
l *tbl __maybe_unused, int id
> >
> >  int syscalltbl__id(struct syscalltbl *tbl, const char *name)
> >  {
> > -       struct syscall *sc =3D bsearch(name, tbl->syscalls.entries,
> > +       struct __syscall *sc =3D bsearch(name, tbl->syscalls.entries,
> >                                      tbl->syscalls.nr_entries, sizeof(*=
sc),
> >                                      syscallcmpname);
> >
> > @@ -126,7 +123,7 @@ int syscalltbl__id(struct syscalltbl *tbl, const ch=
ar *name)
> >  int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *=
syscall_glob, int *idx)
> >  {
> >         int i;
> > -       struct syscall *syscalls =3D tbl->syscalls.entries;
> > +       struct __syscall *syscalls =3D tbl->syscalls.entries;
> >
> >         for (i =3D *idx + 1; i < tbl->syscalls.nr_entries; ++i) {
> >                 if (strglobmatch(syscalls[i].name, syscall_glob)) {
> > diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.=
h
> > index a41d2ca9e4ae..6e93a0874c40 100644
> > --- a/tools/perf/util/syscalltbl.h
> > +++ b/tools/perf/util/syscalltbl.h
> > @@ -2,6 +2,11 @@
> >  #ifndef __PERF_SYSCALLTBL_H
> >  #define __PERF_SYSCALLTBL_H
> >
>
> It'd be  nice to document the struct with examples that explain the
> confusion that's happened and is fixed here.

You mean the "struct __syscall"? That's just me trying to expose the
already existed "struct syscall" it in syscalltbl.h(originally in
syscalltbl.c, so it's private), so that I can use it in
builtin-trace.c. It was originally named "struct syscall", but we
already had one "struct syscall" in builtin-trace.c, so I renamed it
to "struct __syscall". Please tell me if this is inappropriate.

Thanks,
Howard
>
> Thanks,
> Ian
>
> > +struct __syscall {
> > +       int id;
> > +       const char *name;
> > +};
> > +
> >  struct syscalltbl {
> >         int audit_machine;
> >         struct {
> > --
> > 2.45.2
> >

On Tue, Jun 11, 2024 at 5:33=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sat, Jun 8, 2024 at 10:21=E2=80=AFAM Howard Chu <howardchu95@gmail.com=
> wrote:
> >
> > This is a bug found when implementing pretty-printing for the
> > landlock_add_rule system call, I decided to send this patch separately
> > because this is a serious bug that should be fixed fast.
> >
> > I wrote a test program to do landlock_add_rule syscall in a loop,
> > yet perf trace -e landlock_add_rule freezes, giving no output.
> >
> > This bug is introduced by the false understanding of the variable "key"
> > below:
> > ```
> > for (key =3D 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
> >         struct syscall *sc =3D trace__syscall_info(trace, NULL, key);
> >         ...
> > }
> > ```
> > The code above seems right at the beginning, but when looking at
> > syscalltbl.c, I found these lines:
> >
> > ```
> > for (i =3D 0; i <=3D syscalltbl_native_max_id; ++i)
> >         if (syscalltbl_native[i])
> >                 ++nr_entries;
> >
> > entries =3D tbl->syscalls.entries =3D malloc(sizeof(struct syscall) * n=
r_entries);
> > ...
> >
> > for (i =3D 0, j =3D 0; i <=3D syscalltbl_native_max_id; ++i) {
> >         if (syscalltbl_native[i]) {
> >                 entries[j].name =3D syscalltbl_native[i];
> >                 entries[j].id =3D i;
> >                 ++j;
> >         }
> > }
> > ```
> >
> > meaning the key is merely an index to traverse the syscall table,
> > instead of the actual syscall id for this particular syscall.
>
>
> Thanks Howard, I'm not following this. Doesn't it make sense to use
> the syscall number as its id?
>
> >
> >
> > So if one uses key to do trace__syscall_info(trace, NULL, key), because
> > key only goes up to trace->sctbl->syscalls.nr_entries, for example, on
> > my X86_64 machine, this number is 373, it will end up neglecting all
> > the rest of the syscall, in my case, everything after `rseq`, because
> > the traversal will stop at 373, and `rseq` is the last syscall whose id
> > is lower than 373
> >
> > in tools/perf/arch/x86/include/generated/asm/syscalls_64.c:
> > ```
> >         ...
> >         [334] =3D "rseq",
> >         [424] =3D "pidfd_send_signal",
> >         ...
> > ```
> >
> > The reason why the key is scrambled but perf trace works well is that
> > key is used in trace__syscall_info(trace, NULL, key) to do
> > trace->syscalls.table[id], this makes sure that the struct syscall retu=
rned
> > actually has an id the same value as key, making the later bpf_prog
> > matching all correct.
>
>
> Could we create a test for this? We have tests that list all perf
> events and then running a perf command on them. It wouldn't be
> possible to guarantee output.
>
> >
> > After fixing this bug, I can do perf trace on 38 more syscalls, and
> > because more syscalls are visible, we get 8 more syscalls that can be
> > augmented.
> >
> > before:
> >
> > perf $ perf trace -vv --max-events=3D1 |& grep Reusing
> > Reusing "open" BPF sys_enter augmenter for "stat"
> > Reusing "open" BPF sys_enter augmenter for "lstat"
> > Reusing "open" BPF sys_enter augmenter for "access"
> > Reusing "connect" BPF sys_enter augmenter for "accept"
> > Reusing "sendto" BPF sys_enter augmenter for "recvfrom"
> > Reusing "connect" BPF sys_enter augmenter for "bind"
> > Reusing "connect" BPF sys_enter augmenter for "getsockname"
> > Reusing "connect" BPF sys_enter augmenter for "getpeername"
> > Reusing "open" BPF sys_enter augmenter for "execve"
> > Reusing "open" BPF sys_enter augmenter for "truncate"
> > Reusing "open" BPF sys_enter augmenter for "chdir"
> > Reusing "open" BPF sys_enter augmenter for "mkdir"
> > Reusing "open" BPF sys_enter augmenter for "rmdir"
> > Reusing "open" BPF sys_enter augmenter for "creat"
> > Reusing "open" BPF sys_enter augmenter for "link"
> > Reusing "open" BPF sys_enter augmenter for "unlink"
> > Reusing "open" BPF sys_enter augmenter for "symlink"
> > Reusing "open" BPF sys_enter augmenter for "readlink"
> > Reusing "open" BPF sys_enter augmenter for "chmod"
> > Reusing "open" BPF sys_enter augmenter for "chown"
> > Reusing "open" BPF sys_enter augmenter for "lchown"
> > Reusing "open" BPF sys_enter augmenter for "mknod"
> > Reusing "open" BPF sys_enter augmenter for "statfs"
> > Reusing "open" BPF sys_enter augmenter for "pivot_root"
> > Reusing "open" BPF sys_enter augmenter for "chroot"
> > Reusing "open" BPF sys_enter augmenter for "acct"
> > Reusing "open" BPF sys_enter augmenter for "swapon"
> > Reusing "open" BPF sys_enter augmenter for "swapoff"
> > Reusing "open" BPF sys_enter augmenter for "delete_module"
> > Reusing "open" BPF sys_enter augmenter for "setxattr"
> > Reusing "open" BPF sys_enter augmenter for "lsetxattr"
> > Reusing "openat" BPF sys_enter augmenter for "fsetxattr"
> > Reusing "open" BPF sys_enter augmenter for "getxattr"
> > Reusing "open" BPF sys_enter augmenter for "lgetxattr"
> > Reusing "openat" BPF sys_enter augmenter for "fgetxattr"
> > Reusing "open" BPF sys_enter augmenter for "listxattr"
> > Reusing "open" BPF sys_enter augmenter for "llistxattr"
> > Reusing "open" BPF sys_enter augmenter for "removexattr"
> > Reusing "open" BPF sys_enter augmenter for "lremovexattr"
> > Reusing "fsetxattr" BPF sys_enter augmenter for "fremovexattr"
> > Reusing "open" BPF sys_enter augmenter for "mq_open"
> > Reusing "open" BPF sys_enter augmenter for "mq_unlink"
> > Reusing "fsetxattr" BPF sys_enter augmenter for "add_key"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "request_key"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "inotify_add_watch"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "mkdirat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "mknodat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "fchownat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "futimesat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "newfstatat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "unlinkat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "linkat"
> > Reusing "open" BPF sys_enter augmenter for "symlinkat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "readlinkat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "fchmodat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "faccessat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "utimensat"
> > Reusing "connect" BPF sys_enter augmenter for "accept4"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "name_to_handle_at"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "renameat2"
> > Reusing "open" BPF sys_enter augmenter for "memfd_create"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "statx"
> >
> > after
> >
> > perf $ perf trace -vv --max-events=3D1 |& grep Reusing
> > Reusing "open" BPF sys_enter augmenter for "stat"
> > Reusing "open" BPF sys_enter augmenter for "lstat"
> > Reusing "open" BPF sys_enter augmenter for "access"
> > Reusing "connect" BPF sys_enter augmenter for "accept"
> > Reusing "sendto" BPF sys_enter augmenter for "recvfrom"
> > Reusing "connect" BPF sys_enter augmenter for "bind"
> > Reusing "connect" BPF sys_enter augmenter for "getsockname"
> > Reusing "connect" BPF sys_enter augmenter for "getpeername"
> > Reusing "open" BPF sys_enter augmenter for "execve"
> > Reusing "open" BPF sys_enter augmenter for "truncate"
> > Reusing "open" BPF sys_enter augmenter for "chdir"
> > Reusing "open" BPF sys_enter augmenter for "mkdir"
> > Reusing "open" BPF sys_enter augmenter for "rmdir"
> > Reusing "open" BPF sys_enter augmenter for "creat"
> > Reusing "open" BPF sys_enter augmenter for "link"
> > Reusing "open" BPF sys_enter augmenter for "unlink"
> > Reusing "open" BPF sys_enter augmenter for "symlink"
> > Reusing "open" BPF sys_enter augmenter for "readlink"
> > Reusing "open" BPF sys_enter augmenter for "chmod"
> > Reusing "open" BPF sys_enter augmenter for "chown"
> > Reusing "open" BPF sys_enter augmenter for "lchown"
> > Reusing "open" BPF sys_enter augmenter for "mknod"
> > Reusing "open" BPF sys_enter augmenter for "statfs"
> > Reusing "open" BPF sys_enter augmenter for "pivot_root"
> > Reusing "open" BPF sys_enter augmenter for "chroot"
> > Reusing "open" BPF sys_enter augmenter for "acct"
> > Reusing "open" BPF sys_enter augmenter for "swapon"
> > Reusing "open" BPF sys_enter augmenter for "swapoff"
> > Reusing "open" BPF sys_enter augmenter for "delete_module"
> > Reusing "open" BPF sys_enter augmenter for "setxattr"
> > Reusing "open" BPF sys_enter augmenter for "lsetxattr"
> > Reusing "openat" BPF sys_enter augmenter for "fsetxattr"
> > Reusing "open" BPF sys_enter augmenter for "getxattr"
> > Reusing "open" BPF sys_enter augmenter for "lgetxattr"
> > Reusing "openat" BPF sys_enter augmenter for "fgetxattr"
> > Reusing "open" BPF sys_enter augmenter for "listxattr"
> > Reusing "open" BPF sys_enter augmenter for "llistxattr"
> > Reusing "open" BPF sys_enter augmenter for "removexattr"
> > Reusing "open" BPF sys_enter augmenter for "lremovexattr"
> > Reusing "fsetxattr" BPF sys_enter augmenter for "fremovexattr"
> > Reusing "open" BPF sys_enter augmenter for "mq_open"
> > Reusing "open" BPF sys_enter augmenter for "mq_unlink"
> > Reusing "fsetxattr" BPF sys_enter augmenter for "add_key"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "request_key"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "inotify_add_watch"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "mkdirat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "mknodat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "fchownat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "futimesat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "newfstatat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "unlinkat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "linkat"
> > Reusing "open" BPF sys_enter augmenter for "symlinkat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "readlinkat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "fchmodat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "faccessat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "utimensat"
> > Reusing "connect" BPF sys_enter augmenter for "accept4"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "name_to_handle_at"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "renameat2"
> > Reusing "open" BPF sys_enter augmenter for "memfd_create"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
> > Reusing "fremovexattr" BPF sys_enter augmenter for "statx"
> >
> > TL;DR:
> >
> > These are the new syscalls that can be augmented
> > Reusing "openat" BPF sys_enter augmenter for "open_tree"
> > Reusing "openat" BPF sys_enter augmenter for "openat2"
> > Reusing "openat" BPF sys_enter augmenter for "mount_setattr"
> > Reusing "openat" BPF sys_enter augmenter for "move_mount"
> > Reusing "open" BPF sys_enter augmenter for "fsopen"
> > Reusing "openat" BPF sys_enter augmenter for "fspick"
> > Reusing "openat" BPF sys_enter augmenter for "faccessat2"
> > Reusing "openat" BPF sys_enter augmenter for "fchmodat2"
> >
> > as for the perf trace output:
> >
> > before
> >
> > perf $ perf trace -e faccessat2 --max-events=3D1
> > [no output]
> >
> > after
> >
> > perf $ ./perf trace -e faccessat2 --max-events=3D1
> >      0.000 ( 0.037 ms): waybar/958 faccessat2(dfd: 40, filename: "ueven=
t")                               =3D 0
> >
> > P.S. The reason why this bug was not found in the past five years is
> > probably because it only happens to the newer syscalls whose id is
> > greater, for instance, faccessat2 of id 439, which not a lot of people
> > care about when using perf trace.
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/builtin-trace.c   | 32 +++++++++++++++++++++-----------
> >  tools/perf/util/syscalltbl.c | 21 +++++++++------------
> >  tools/perf/util/syscalltbl.h |  5 +++++
> >  3 files changed, 35 insertions(+), 23 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index c42bc608954e..5cbe1748911d 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -3354,7 +3354,8 @@ static int trace__bpf_prog_sys_exit_fd(struct tra=
ce *trace, int id)
> >  static struct bpf_program *trace__find_usable_bpf_prog_entry(struct tr=
ace *trace, struct syscall *sc)
> >  {
> >         struct tep_format_field *field, *candidate_field;
> > -       int id;
> > +       struct __syscall *scs =3D trace->sctbl->syscalls.entries;
> > +       int id, _id;
> >
> >         /*
> >          * We're only interested in syscalls that have a pointer:
> > @@ -3368,10 +3369,13 @@ static struct bpf_program *trace__find_usable_b=
pf_prog_entry(struct trace *trace
> >
> >  try_to_find_pair:
> >         for (id =3D 0; id < trace->sctbl->syscalls.nr_entries; ++id) {
> > -               struct syscall *pair =3D trace__syscall_info(trace, NUL=
L, id);
> > +               struct syscall *pair;
> >                 struct bpf_program *pair_prog;
> >                 bool is_candidate =3D false;
> >
> > +               _id =3D scs[id].id;
> > +               pair =3D trace__syscall_info(trace, NULL, _id);
> > +
> >                 if (pair =3D=3D NULL || pair =3D=3D sc ||
> >                     pair->bpf_prog.sys_enter =3D=3D trace->skel->progs.=
syscall_unaugmented)
> >                         continue;
> > @@ -3456,23 +3460,26 @@ static int trace__init_syscalls_bpf_prog_array_=
maps(struct trace *trace)
> >  {
> >         int map_enter_fd =3D bpf_map__fd(trace->skel->maps.syscalls_sys=
_enter);
> >         int map_exit_fd  =3D bpf_map__fd(trace->skel->maps.syscalls_sys=
_exit);
> > -       int err =3D 0, key;
> > +       int err =3D 0, key, id;
> > +       struct __syscall *scs =3D trace->sctbl->syscalls.entries;
> >
> >         for (key =3D 0; key < trace->sctbl->syscalls.nr_entries; ++key)=
 {
> >                 int prog_fd;
> >
> > -               if (!trace__syscall_enabled(trace, key))
> > +               id =3D scs[key].id;
> > +
> > +               if (!trace__syscall_enabled(trace, id))
> >                         continue;
> >
> > -               trace__init_syscall_bpf_progs(trace, key);
> > +               trace__init_syscall_bpf_progs(trace, id);
> >
> >                 // It'll get at least the "!raw_syscalls:unaugmented"
> > -               prog_fd =3D trace__bpf_prog_sys_enter_fd(trace, key);
> > -               err =3D bpf_map_update_elem(map_enter_fd, &key, &prog_f=
d, BPF_ANY);
> > +               prog_fd =3D trace__bpf_prog_sys_enter_fd(trace, id);
> > +               err =3D bpf_map_update_elem(map_enter_fd, &id, &prog_fd=
, BPF_ANY);
> >                 if (err)
> >                         break;
> > -               prog_fd =3D trace__bpf_prog_sys_exit_fd(trace, key);
> > -               err =3D bpf_map_update_elem(map_exit_fd, &key, &prog_fd=
, BPF_ANY);
> > +               prog_fd =3D trace__bpf_prog_sys_exit_fd(trace, id);
> > +               err =3D bpf_map_update_elem(map_exit_fd, &id, &prog_fd,=
 BPF_ANY);
> >                 if (err)
> >                         break;
> >         }
> > @@ -3506,10 +3513,13 @@ static int trace__init_syscalls_bpf_prog_array_=
maps(struct trace *trace)
> >          * array tail call, then that one will be used.
> >          */
> >         for (key =3D 0; key < trace->sctbl->syscalls.nr_entries; ++key)=
 {
> > -               struct syscall *sc =3D trace__syscall_info(trace, NULL,=
 key);
> > +               struct syscall *sc;
> >                 struct bpf_program *pair_prog;
> >                 int prog_fd;
> >
> > +               id =3D scs[key].id;
> > +               sc =3D trace__syscall_info(trace, NULL, id);
> > +
> >                 if (sc =3D=3D NULL || sc->bpf_prog.sys_enter =3D=3D NUL=
L)
> >                         continue;
> >
> > @@ -3535,7 +3545,7 @@ static int trace__init_syscalls_bpf_prog_array_ma=
ps(struct trace *trace)
> >                  * with the fd for the program we're reusing:
> >                  */
> >                 prog_fd =3D bpf_program__fd(sc->bpf_prog.sys_enter);
> > -               err =3D bpf_map_update_elem(map_enter_fd, &key, &prog_f=
d, BPF_ANY);
> > +               err =3D bpf_map_update_elem(map_enter_fd, &id, &prog_fd=
, BPF_ANY);
> >                 if (err)
> >                         break;
> >         }
> > diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.=
c
> > index 63be7b58761d..16aa886c40f0 100644
> > --- a/tools/perf/util/syscalltbl.c
> > +++ b/tools/perf/util/syscalltbl.c
> > @@ -44,22 +44,17 @@ const int syscalltbl_native_max_id =3D SYSCALLTBL_L=
OONGARCH_MAX_ID;
> >  static const char *const *syscalltbl_native =3D syscalltbl_loongarch;
> >  #endif
> >
> > -struct syscall {
> > -       int id;
> > -       const char *name;
> > -};
> > -
> >  static int syscallcmpname(const void *vkey, const void *ventry)
> >  {
> >         const char *key =3D vkey;
> > -       const struct syscall *entry =3D ventry;
> > +       const struct __syscall *entry =3D ventry;
> >
> >         return strcmp(key, entry->name);
> >  }
> >
> >  static int syscallcmp(const void *va, const void *vb)
> >  {
> > -       const struct syscall *a =3D va, *b =3D vb;
> > +       const struct __syscall *a =3D va, *b =3D vb;
> >
> >         return strcmp(a->name, b->name);
> >  }
> > @@ -67,13 +62,14 @@ static int syscallcmp(const void *va, const void *v=
b)
> >  static int syscalltbl__init_native(struct syscalltbl *tbl)
> >  {
> >         int nr_entries =3D 0, i, j;
> > -       struct syscall *entries;
> > +       struct __syscall *entries;
> >
> >         for (i =3D 0; i <=3D syscalltbl_native_max_id; ++i)
> >                 if (syscalltbl_native[i])
> >                         ++nr_entries;
> >
> > -       entries =3D tbl->syscalls.entries =3D malloc(sizeof(struct sysc=
all) * nr_entries);
> > +       entries =3D tbl->syscalls.entries =3D malloc(sizeof(struct __sy=
scall) *
> > +                                                nr_entries);
> >         if (tbl->syscalls.entries =3D=3D NULL)
> >                 return -1;
> >
> > @@ -85,7 +81,8 @@ static int syscalltbl__init_native(struct syscalltbl =
*tbl)
> >                 }
> >         }
> >
> > -       qsort(tbl->syscalls.entries, nr_entries, sizeof(struct syscall)=
, syscallcmp);
> > +       qsort(tbl->syscalls.entries, nr_entries, sizeof(struct __syscal=
l),
> > +             syscallcmp);
> >         tbl->syscalls.nr_entries =3D nr_entries;
> >         tbl->syscalls.max_id     =3D syscalltbl_native_max_id;
> >         return 0;
> > @@ -116,7 +113,7 @@ const char *syscalltbl__name(const struct syscalltb=
l *tbl __maybe_unused, int id
> >
> >  int syscalltbl__id(struct syscalltbl *tbl, const char *name)
> >  {
> > -       struct syscall *sc =3D bsearch(name, tbl->syscalls.entries,
> > +       struct __syscall *sc =3D bsearch(name, tbl->syscalls.entries,
> >                                      tbl->syscalls.nr_entries, sizeof(*=
sc),
> >                                      syscallcmpname);
> >
> > @@ -126,7 +123,7 @@ int syscalltbl__id(struct syscalltbl *tbl, const ch=
ar *name)
> >  int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *=
syscall_glob, int *idx)
> >  {
> >         int i;
> > -       struct syscall *syscalls =3D tbl->syscalls.entries;
> > +       struct __syscall *syscalls =3D tbl->syscalls.entries;
> >
> >         for (i =3D *idx + 1; i < tbl->syscalls.nr_entries; ++i) {
> >                 if (strglobmatch(syscalls[i].name, syscall_glob)) {
> > diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.=
h
> > index a41d2ca9e4ae..6e93a0874c40 100644
> > --- a/tools/perf/util/syscalltbl.h
> > +++ b/tools/perf/util/syscalltbl.h
> > @@ -2,6 +2,11 @@
> >  #ifndef __PERF_SYSCALLTBL_H
> >  #define __PERF_SYSCALLTBL_H
> >
>
> It'd be  nice to document the struct with examples that explain the
> confusion that's happened and is fixed here.
>
> Thanks,
> Ian
>
> > +struct __syscall {
> > +       int id;
> > +       const char *name;
> > +};
> > +
> >  struct syscalltbl {
> >         int audit_machine;
> >         struct {
> > --
> > 2.45.2
> >

