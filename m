Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB38E206708
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 00:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbgFWWNm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 18:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387701AbgFWWNm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 18:13:42 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE6CC061573
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 15:13:40 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h23so171133qtr.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KC5W2hOsVWxyy2rFLbOiFSUF9PKgNUfQ2aTEE+kbX3U=;
        b=VAVpIE+zb054aaDbUgiP0cOWFxJlu1PERv7YJII+bWKn9KPPfRuF9jh8fprn+0RfVp
         UMXJRXLnrec1AcdfST4yTTEaJIaovc3Qzt6KCTAZF7TQEq2YZZFST3sGTH5UR6paViqX
         6wyRxM5bXCgioal8K4LW0SXoDu4rNwHjxvXND5nfIKdO+ksM33oIhFzx8tCNxD50uO0S
         lYGoJuvGrOEJoaTcEHCCX012yjsy5mKRuCsa82TQbfWoKEm+/9MVZmuOtNTnDimn24gH
         +xzX0IXosNqNgUcsVfk3QbgycBnzAgF5TKQQNbqz46CB3ZuUIw6+hMzWWbFAetp/VOdq
         FS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KC5W2hOsVWxyy2rFLbOiFSUF9PKgNUfQ2aTEE+kbX3U=;
        b=Jl0nNRqoul9+M1Gz16TWvx3gFxQxEBYay0ysvfn/NyYfOEjm12Gd1gBA4B7i5ZuxOp
         5+hFBzDQFIkk2xZsU7N7iGu8QMTDR1lEm1jwaU14HcLy49xdPv/R+RitEB4brIRhCK3u
         j/vGo1ph1OC177e6Nxyo1kQaB21r0Pbvba7Bq+lo8uPui1Sl9cToDwANCH3ZecuPh6hH
         wIbhFsYKqreeX+id62l/SmaFidq6uTSVSZNrh/ai8EOmK0mcMnFpM6GhUs1Iew3ZZV1w
         nBe7bC5Ov97S8wicgzcy4HDfdH8Yp0oZ9eY+24KZpsGMfV5vaQymZA34mbs4E1OdYnu6
         D5gw==
X-Gm-Message-State: AOAM532910L16KlEMHWvTarebPAEBQTaaM/czHLLQ5bQJEgi6rU0A4uJ
        civIJtFq/08K5XxyQMjzVPKtpF3lpJIrKh4E+WU=
X-Google-Smtp-Source: ABdhPJzdXLab1/u6IlRhmtV9SxxVRttQ1mbk0Mh34VIN8gcCmQIvU/GA65axaKhDBIJkPediS13OwkXSsSVN4FmWZxA=
X-Received: by 2002:ac8:5306:: with SMTP id t6mr148982qtn.59.1592950419687;
 Tue, 23 Jun 2020 15:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200621154428.pf6foowywrq3wxt2@matt-gen-laptop-p01>
 <20200622150128.hjwe3uak2sy7po22@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4BzZt-aAo-t-eV=r3SNfgJh3rfqS8EFufz32VYKX9zOfXMQ@mail.gmail.com>
 <20200622171902.4q3pypddgyyp5p5r@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4Bzb8U3SRQbxzLtTZihG3X=-OtQcYQApmJUhmuwqtXZaucg@mail.gmail.com>
 <20200623145429.zusbbebj52scumcr@matt-gen-desktop-p01.matt.pallissard.net>
 <8ffec8ff-664d-fd3e-12eb-49eac339b612@fb.com> <CAEf4BzbgQoi=NC6hM0j=49iGeexUEeuJFciMfipV+VDt+Luadg@mail.gmail.com>
 <20200623181105.luijy2q4vdzonlxk@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4Bza4OFEeW59HGPtHcE2_2+KoT9h8B=Qzah58FtBf3EFoQg@mail.gmail.com> <20200623220538.37epdt36y5yyihph@matt-gen-desktop-p01.matt.pallissard.net>
In-Reply-To: <20200623220538.37epdt36y5yyihph@matt-gen-desktop-p01.matt.pallissard.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Jun 2020 15:13:28 -0700
Message-ID: <CAEf4Bzbbjond4mzyaVKWWrGyT-dQ=xb+H00DGQMtHSzUpH5mMQ@mail.gmail.com>
Subject: Re: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
To:     Matt Pallissard <matt@pallissard.net>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 23, 2020 at 3:05 PM Matt Pallissard <matt@pallissard.net> wrote=
:
>
>
>
> On 2020-06-23T11:36:06 -0700, Andrii Nakryiko wrote:
> > On Tue, Jun 23, 2020 at 11:11 AM Matt Pallissard <matt@pallissard.net> =
wrote:
> > >
> > >
> > > On 2020-06-23T10:58:20 -0700, Andrii Nakryiko wrote:
> > > > On Tue, Jun 23, 2020 at 9:36 AM Yonghong Song <yhs@fb.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 6/23/20 7:54 AM, Matt Pallissard wrote:
> > > > > >
> > > > > > On 2020-06-22T15:09:57 -0700, Andrii Nakryiko wrote:
> > > > > >> On Mon, Jun 22, 2020 at 10:19 AM Matt Pallissard <matt@palliss=
ard.net> wrote:
> > > > > >>>
> > > > > >>> On 2020-06-22T09:20:03 -0700, Andrii Nakryiko wrote:
> > > > > >>>> On Mon, Jun 22, 2020 at 8:01 AM Matt Pallissard <matt@pallis=
sard.net> wrote:
> > > > > >>>>> On 2020-06-21T08:44:28 -0700, Matt Pallissard wrote:
> > > > > >>>>>> On 2020-06-20T20:29:43 -0700, Andrii Nakryiko wrote:
> > > > > >>>>>>> On Sat, Jun 20, 2020 at 1:07 PM Matt Pallissard <matt@pal=
lissard.net> wrote:
> > > > > >>>>>>>> On 2020-06-20T11:11:55 -0700, Yonghong Song wrote:
> > > > > >>>>>>>>> On 6/20/20 9:22 AM, Matt Pallissard wrote:
> > > > > >>>>>>>>>> New to bpf here.
> > > > > >>>>>>>>>>
> > > > > >>>>>>>>>> I'm trying to read values out of of mm_struct.  I have=
 code like this;
> > > > > >>>>>>>>>>
> > > > > >>>>>>>>>> unsigned long i[10] =3D {};
> > > > > >>>>>>>>>> struct task_struct *t;
> > > > > >>>>>>>>>> struct mm_rss_stat *rss;
> > > > > >>>>>>>>>>
> > > > > >>>>>>>>>> t =3D (struct task_struct *)bpf_get_current_task();
> > > > > >>>>>>>>>> BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
> > > > > >>>>>>>>>> BPF_CORE_READ_INTO(i, rss, count);
> > > > > >>>>>>>>>>
> > > > > >>>>>>>>>> However, all values in `i` appear to be 0 (i[MM_FILEPA=
GES], etc), as if no data gets copied.  I'm about 100% confident that this =
is caused by a glaring oversight on my part.
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> Maybe you want to check the return value of BPF_CORE_RE=
AD_INTO.
> > > > > >>>>>>>>> Underlying it is using bpf_probe_read and bpf_probe_rea=
d may fail e.g., due
> > > > > >>>>>>>>> to major fault.
> > > > > >>>>>>>>
> > > > > >>>>>>>> Doh, I should have known to check the return codes!  Yes=
, it was failing.  I knew I was overlooking something trivial.
> > > > > >>>>>>>>
> > > > > >>>>>>>
> > > > > >>>>>>> I wrote exactly such piece of code a while ago. Here's pa=
rt of it for
> > > > > >>>>>>> reference, I think it will be helpful:
> > > > > >>>>>>>
> > > > > >>>>>>>    struct task_struct *task =3D (struct task_struct *)bpf=
_get_current_task();
> > > > > >>>>>>>    const struct mm_struct *mm =3D BPF_CORE_READ(task, mm)=
;
> > > > > >>>>>>>
> > > > > >>>>>>>    if (mm) {
> > > > > >>>>>>>        u64 hiwater_rss =3D BPF_CORE_READ(mm, hiwater_rss)=
;
> > > > > >>>>>>>        u64 file_pages =3D BPF_CORE_READ(mm, rss_stat.coun=
t[MM_FILEPAGES].counter);
> > > > > >>>>>>>        u64 anon_pages =3D BPF_CORE_READ(mm, rss_stat.coun=
t[MM_ANONPAGES].counter);
> > > > > >>>>>>>        u64 shmem_pages =3D BPF_CORE_READ(mm,
> > > > > >>>>>>> rss_stat.count[MM_SHMEMPAGES].counter);
> > > > > >>>>>>>        u64 active_rss =3D file_pages + anon_pages + shmem=
_pages;
> > > > > >>>>>>>        /* ... */
> > > > > >>>>>>
> > > > > >>>>>> Thank you,
> > > > > >>>>>>
> > > > > >>>>>> After realizing that I was referencing the struct incorrec=
tly, I wound up with a similar block of code.  However, as I started testin=
g it against /proc/pid/smaps[,_rollup] I noticed that my numbers didn't mat=
ch up.  Always smaller.
> > > > > >>>>>>
> > > > > >>>>>> I took a quick glance at fs/proc/task_mmu.c.  I think I'll=
 have to walk some sort of accounting structure.
> > > > > >>>>>
> > > > > >>>>>
> > > > > >>>>> I started to take a hard look at fs/proc/task_mmu.c.  With =
all the locking, globals, and compile-time constants, I'm not sure that it'=
s even possible to correctly walk `vm_area_struct` in bpf.
> > > > > >>>>
> > > > > >>>> Yes, you can't take all those locks from BPF. But reading at=
omic
> > > > > >>>> counters from BPF should be no problem. You might get a slig=
htly out
> > > > > >>>> of sync readings, but whatever you are doing shouldn't expec=
t to have
> > > > > >>>> 100% correct values anyways, because they might change so fa=
st after
> > > > > >>>> you read them.
> > > > > >>>
> > > > > >>> That was my initial thought.  I didn't care to much about sta=
le data, my only real concern was walking vm_area_struct and having memory =
freed.  I wasn't sure if that could break the list underneath me.  Although=
, that shouldn't be too difficult to get to the bottom of.
> > > > > >>>
> > > > > >>
> > > > > >> Not sure about vm_area_struct (where is it in the example abov=
e?), but
> > > > > >> mm_struct won't go away, because current task won't go away, b=
ecause
> > > > > >> BPF program is running in the context of current. Similarly fo=
r
> > > > > >> bpf_iter, bpf_iter will actually take a refcnt on tast_struct.=
 So I
> > > > > >> think you don't have to worry about that.
> > > > > >
> > > > > > I didn't mention it explicitly in the example above.  But when =
I originally mentioned walking an accounting structure, as procfs does, it =
winds up being `mm_struct->mmap,vm_[next,prev]`, with mmap being a `vm_area=
_struct`.  But, it sounds like I should be abandoning that path and iterati=
ng over all the tasks.
> > > > > >
> > > > > >
> > > > > >>>>> If anyone has suggestions for getting memory numbers from a=
n entire process, not just a task/thread, I'd love to hear them.  If not, I=
'll pursue this on my own.
> > > > > >>>>
> > > > > >>>> For this, you'd need to iterate across many tasks and aggreg=
ate their
> > > > > >>>> results based on tasks's tgid. Check iter/task programs in s=
elftests
> > > > > >>>> (progs/bpf_iter_task.c, I think).
> > > > > >
> > > > > >
> > > > > > When I try to replicate some of the selftest task logic. I run =
into some errors when I call bpf_object__load.  `libbpf: task is not found =
in vmlinux BTF.`  I'll try matching the selftest code more closely and digg=
ing into that further.
> > > > >
> > > > > Somehow libbpf did not prepend `task` with `bpf_iter_` prefix. No=
t sure
> > > > > what is the exact issue. Yes, please mimic what selftests did.
> > > > >
> > > >
> > > > It's just an artifact of how libbpf logs error in such case. It did
> > > > search for "bpf_iter_task" type, though. But Matt probably doesn't
> > > > have a recent enough kernel or didn't build it with
> > > > CONFIG_DEBUG_INFO_BTF=3Dy and pahole 1.16+?
> > >
> > > That shouldn't be the case, I generated vmlinux.h from my currently r=
unning machine.
> > >
> > >
> > > I'm using an upstream kernel.
> > > > ~ uname -r
> > > > 5.7.2-arch1-1
> > >
> > > Which has the BTF debug info enabled.
> > > > ~ zgrep BTF=3D /proc/config.gz
> > > > CONFIG_DEBUG_INFO_BTF=3Dy
> > >
> > >
> > > I assume that it was built with the version of pahole that's in the u=
pstream repos.
> > > > ~ pacman -Ss pahole
> > > > extra/pahole 1.17-1 [installed]
> > >
> > >
> > > Unless I've came across some odd bug, I assume that I've implemented =
something incorrectly.
> > >
> >
> > Ok, can you show your code (BPF and user-space side) and libbpf debug l=
ogs then?
>
>
> Sure.  The userspace section in question is below.  I don't make it past =
`bpf_object__load`.  Same userspace code works fine for tracepoints.
>
>         struct bpf_program *prog;
>         struct bpf_object *obj;
>         char path[] =3D PT_BPF_OBJECT_DIR;
>         strcat(&path[strlen(path)], "/test.o");
>
>         libbpf_set_print(print_libbpf_log);
>
>         obj =3D bpf_object__open_file(path, NULL);
>         if (libbpf_get_error(obj))
>                 return 1;
>
>         if(!(prog =3D bpf_object__find_program_by_name(obj, "dump_task"))=
)
>                 goto cleanup;
>
>         if (bpf_object__load(obj))
>                 goto cleanup;
>
>
> I copied the kernel code, only slightly modifying the include statements
>
>         #define bpf_iter_meta bpf_iter_meta___not_used
>         #define bpf_iter__task bpf_iter__task___not_used
>         #include <vmlinux.h>
>         #undef bpf_iter_meta
>         #undef bpf_iter__task
>         #include <bpf_helpers.h>
>         #include <bpf_tracing.h>
>
>         struct bpf_iter_meta {
>                 struct seq_file *seq;
>                 __u64 session_id;
>                 __u64 seq_num;
>         } __attribute__((preserve_access_index));
>
>         struct bpf_iter__task {
>                 struct bpf_iter_meta *meta;
>                 struct task_struct *task;
>         } __attribute__((preserve_access_index));
>
>         SEC("iter/task")
>         int dump_task(struct bpf_iter__task *ctx)
>         {
>                 struct seq_file *seq =3D ctx->meta->seq;
>                 struct task_struct *task =3D ctx->task;
>
>                 if (task =3D=3D (void *)0) {
>                         BPF_SEQ_PRINTF(seq, "    =3D=3D=3D END =3D=3D=3D\=
n");
>                         return 0;
>                 }
>
>                 if (ctx->meta->seq_num =3D=3D 0)
>                         BPF_SEQ_PRINTF(seq, "    tgid      gid\n");
>
>                 BPF_SEQ_PRINTF(seq, "%8d %8d\n", task->tgid, task->pid);
>                 return 0;
>         }
>
>
> And here is the debug output
>
>
> libbpf: loading /tmp//usr/lib/pt/bpf/test.o
> libbpf: section(1) .strtab, size 277, link 0, flags 0, type=3D3
> libbpf: skip section(1) .strtab
> libbpf: section(2) .text, size 0, link 0, flags 6, type=3D1
> libbpf: skip section(2) .text
> libbpf: section(3) iter/task, size 320, link 0, flags 6, type=3D1
> libbpf: found program iter/task
> libbpf: section(4) .reliter/task, size 48, link 22, flags 0, type=3D9
> libbpf: section(5) .rodata, size 45, link 0, flags 2, type=3D1
> libbpf: section(6) license, size 4, link 0, flags 3, type=3D1
> libbpf: license of /tmp//usr/lib/pt/bpf/test.o is GPL
> libbpf: section(7) version, size 4, link 0, flags 3, type=3D1
> libbpf: kernel version of /tmp//usr/lib/pt/bpf/test.o is 5060b
> libbpf: section(8) .debug_str, size 135270, link 0, flags 30, type=3D1
> libbpf: skip section(8) .debug_str
> libbpf: section(9) .debug_loc, size 124, link 0, flags 0, type=3D1
> libbpf: skip section(9) .debug_loc
> libbpf: section(10) .debug_abbrev, size 857, link 0, flags 0, type=3D1
> libbpf: skip section(10) .debug_abbrev
> libbpf: section(11) .debug_info, size 224491, link 0, flags 0, type=3D1
> libbpf: skip section(11) .debug_info
> libbpf: section(12) .rel.debug_info, size 160, link 22, flags 0, type=3D9
> libbpf: skip relo .rel.debug_info(12) for section(11)
> libbpf: section(13) .BTF, size 25711, link 0, flags 0, type=3D1
> libbpf: section(14) .rel.BTF, size 80, link 22, flags 0, type=3D9
> libbpf: skip relo .rel.BTF(14) for section(13)
> libbpf: section(15) .BTF.ext, size 348, link 0, flags 0, type=3D1
> libbpf: section(16) .rel.BTF.ext, size 288, link 22, flags 0, type=3D9
> libbpf: skip relo .rel.BTF.ext(16) for section(15)
> libbpf: section(17) .debug_frame, size 40, link 0, flags 0, type=3D1
> libbpf: skip section(17) .debug_frame
> libbpf: section(18) .rel.debug_frame, size 16, link 22, flags 0, type=3D9
> libbpf: skip relo .rel.debug_frame(18) for section(17)
> libbpf: section(19) .debug_line, size 216, link 0, flags 0, type=3D1
> libbpf: skip section(19) .debug_line
> libbpf: section(20) .rel.debug_line, size 16, link 22, flags 0, type=3D9
> libbpf: skip relo .rel.debug_line(20) for section(19)
> libbpf: section(21) .llvm_addrsig, size 6, link 22, flags 80000000, type=
=3D1879002115
> libbpf: skip section(21) .llvm_addrsig
> libbpf: section(22) .symtab, size 312, link 1, flags 0, type=3D2
> libbpf: looking for externs among 13 symbols...
> libbpf: collected 0 externs total
> libbpf: map 'test.rodata' (global data): at sec_idx 5, offset 0, flags 48=
0.
> libbpf: map 0 is "test.rodata"
> libbpf: collecting relocating info for: 'iter/task'
> libbpf: relo for shdr 5, symb 9, value 0, type 3, bind 0, name 0 (''), in=
sn 7
> libbpf: found data map 0 (test.rodata, sec 5, off 0) for insn 7
> libbpf: relo for shdr 5, symb 9, value 0, type 3, bind 0, name 0 (''), in=
sn 17
> libbpf: found data map 0 (test.rodata, sec 5, off 0) for insn 17
> libbpf: relo for shdr 5, symb 9, value 0, type 3, bind 0, name 0 (''), in=
sn 33
> libbpf: found data map 0 (test.rodata, sec 5, off 0) for insn 33
> libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
> libbpf: map 'test.rodata': created successfully, fd=3D4
> libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
> libbpf: prog 'iter/task': performing 6 CO-RE offset relocs
> libbpf: prog 'iter/task': relo #0: kind 0, spec is [2] bpf_iter__task + 0=
:0 =3D> 0.0 @ &x[0].meta
> libbpf: prog 'iter/task': relo #0: no matching targets found for [2] bpf_=
iter__task + 0:0
> libbpf: prog 'iter/task': relo #0: substituting insn #0 w/ invalid insn
> libbpf: prog 'iter/task': relo #1: kind 0, spec is [8] bpf_iter_meta + 0:=
0 =3D> 0.0 @ &x[0].seq
> libbpf: prog 'iter/task': relo #1: no matching targets found for [8] bpf_=
iter_meta + 0:0
> libbpf: prog 'iter/task': relo #1: substituting insn #1 w/ invalid insn
> libbpf: prog 'iter/task': relo #2: kind 0, spec is [2] bpf_iter__task + 0=
:1 =3D> 8.0 @ &x[0].task
> libbpf: prog 'iter/task': relo #2: no matching targets found for [2] bpf_=
iter__task + 0:1
> libbpf: prog 'iter/task': relo #2: substituting insn #2 w/ invalid insn

see all these "substituting insn w/ invalid insn" messages? Your
kernel doesn't have bpf_iter__task struct in it.

You can confirm by running:

$ bpftool btf dump file /sys/kernel/btf/vmlinux | grep bpf_iter_

You said you have 5.7 kernel. Isn't bpf_iter available starting from 5.8?

> libbpf: prog 'iter/task': relo #3: kind 0, spec is [8] bpf_iter_meta + 0:=
2 =3D> 16.0 @ &x[0].seq_num
> libbpf: prog 'iter/task': relo #3: no matching targets found for [8] bpf_=
iter_meta + 0:2
> libbpf: prog 'iter/task': relo #3: substituting insn #12 w/ invalid insn
> libbpf: prog 'iter/task': relo #4: kind 0, spec is [12] task_struct + 0:7=
1 =3D> 1292.0 @ &x[0].tgid
> libbpf: [12] task_struct: found candidate [115] task_struct
> libbpf: prog 'iter/task': relo #4: matching candidate #0 task_struct agai=
nst spec [115] task_struct + 0:71 =3D> 1292.0 @ &x[0].tgid: 1
> libbpf: prog 'iter/task': relo #4: patched insn #22 (LDX/ST/STX) off 1292=
 -> 1292
> libbpf: prog 'iter/task': relo #5: kind 0, spec is [12] task_struct + 0:7=
0 =3D> 1288.0 @ &x[0].pid
> libbpf: prog 'iter/task': relo #5: matching candidate #0 task_struct agai=
nst spec [115] task_struct + 0:70 =3D> 1288.0 @ &x[0].pid: 1
> libbpf: prog 'iter/task': relo #5: patched insn #26 (LDX/ST/STX) off 1288=
 -> 1288
> libbpf: task is not found in vmlinux BTF
> libbpf: failed to load object '/tmp//usr/lib/pt/bpf/test.o'
> *** stack smashing detected ***: terminated  <-- I assume this is because=
 I'm not handling my errors and cleaning up properly
> Aborted (core dumped)
>
> > > > > > As an aside; is there any documentation for bpf_iter outside of=
 the selftests?
> > > > >
> > > > > Unfortunately, no. The commit messages of the original patch set =
might help.
> > > > > https://lore.kernel.org/bpf/20200507053916.1542319-1-yhs@fb.com/T=
/#mf973843af65fc51ac9b3e3673962cd3e87f705e8
