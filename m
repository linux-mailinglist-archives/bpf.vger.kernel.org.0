Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010762077EC
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 17:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404552AbgFXPvO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jun 2020 11:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404166AbgFXPvN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 11:51:13 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFBBC061573
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2020 08:51:12 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id o5so2658784iow.8
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2020 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pallissard.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eVbFvoCkr5enaX+MYrvyMmEIaulvuyLGfnVwhO+sE1M=;
        b=N8DWQGB8BeFlmsum8R8baQezQpjZe0/bW0KsTmz27CQ9TOn4bVVsb4TBV1e/Xz7Emt
         CwPE4ih/yihUU+qkD5Ap8LUxjlW+WzXYwkY/m4GiLbXrjH6Gsz7RshwRKpU+/Fpsjvit
         /iIQW3cSRYgts9DEQrek4NDChBp1TnxAduFZ6EsyA2lFS8YArduCJN38fqWZOV+k0fS/
         Zl/rs5pseEn2M6bjV+tm/VhjKwKccSUQXQZn45OmE+Sbbu1vtJUMzhnnYOvqOWPJ36Ha
         1pNj1y332Qg0x5FQZtI36dxRdYtkRzxQ55JCcowcZpj8AdEnmM3ehSoV2A2hnZ+NBhQK
         vsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eVbFvoCkr5enaX+MYrvyMmEIaulvuyLGfnVwhO+sE1M=;
        b=AMnrOUg/6Njf9NBRnORNwSsi5wJhbHpnY8ntZcK/EJ9O+jpFd1dnHfG0ISXTUc4YoP
         VIhh2ggENE+myjVmhT8U3Z0Gr6rlVreysLKMKAO9fQxAE8f++gqQvSODrQRhDXenXjmf
         KwXdhOgcEnFZ84upT0irrFaZwUPf7tZAjZiEEENDUD5g7ELIowevvx6bn58xAGo1Rv7Q
         BW3jd36EqlwwK8z9PUXvKB/oIBPWpNIAy54UeNekQ+DqgvcR3FAvDpzH4r36PTrB6ROR
         mRHaSc+tOfLF8mZkcuE9TXMNJSdQj+9Fo9PxLWNSy4/TaU9Kb84y65EcCvZLqopNNhoI
         +mDQ==
X-Gm-Message-State: AOAM5314X2i28rGM0T+7GkS5G+PWqvr1Hb9WPyyv0Bc+Wg9varnJ7G+Z
        8+YNHqSLURbVxy+EMgdiC5oPbw==
X-Google-Smtp-Source: ABdhPJx6MveHzEFRRL9n8N3f99sxgffAIpNYrSyigheirnUVFM2l+LWAsicAB5XFbhdRxF5qjSXdpg==
X-Received: by 2002:a05:6638:975:: with SMTP id o21mr28843013jaj.99.1593013871842;
        Wed, 24 Jun 2020 08:51:11 -0700 (PDT)
Received: from mail.matt.pallissard.net (223.91.188.35.bc.googleusercontent.com. [35.188.91.223])
        by smtp.gmail.com with ESMTPSA id e12sm11520549ili.68.2020.06.24.08.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:51:10 -0700 (PDT)
Date:   Wed, 24 Jun 2020 08:51:08 -0700
From:   Matt Pallissard <matt@pallissard.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Subject: Re: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
Message-ID: <20200624155108.rvk7zvmfjzqewl5i@matt-gen-desktop-p01.matt.pallissard.net>
References: <CAEf4BzZt-aAo-t-eV=r3SNfgJh3rfqS8EFufz32VYKX9zOfXMQ@mail.gmail.com>
 <20200622171902.4q3pypddgyyp5p5r@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4Bzb8U3SRQbxzLtTZihG3X=-OtQcYQApmJUhmuwqtXZaucg@mail.gmail.com>
 <20200623145429.zusbbebj52scumcr@matt-gen-desktop-p01.matt.pallissard.net>
 <8ffec8ff-664d-fd3e-12eb-49eac339b612@fb.com>
 <CAEf4BzbgQoi=NC6hM0j=49iGeexUEeuJFciMfipV+VDt+Luadg@mail.gmail.com>
 <20200623181105.luijy2q4vdzonlxk@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4Bza4OFEeW59HGPtHcE2_2+KoT9h8B=Qzah58FtBf3EFoQg@mail.gmail.com>
 <20200623220538.37epdt36y5yyihph@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4Bzbbjond4mzyaVKWWrGyT-dQ=xb+H00DGQMtHSzUpH5mMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbbjond4mzyaVKWWrGyT-dQ=xb+H00DGQMtHSzUpH5mMQ@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2020-06-23T15:13:28 -0700, Andrii Nakryiko wrote:
> On Tue, Jun 23, 2020 at 3:05 PM Matt Pallissard <matt@pallissard.net> wrote:
> >
> >
> >
> > On 2020-06-23T11:36:06 -0700, Andrii Nakryiko wrote:
> > > On Tue, Jun 23, 2020 at 11:11 AM Matt Pallissard <matt@pallissard.net> wrote:
> > > >
> > > >
> > > > On 2020-06-23T10:58:20 -0700, Andrii Nakryiko wrote:
> > > > > On Tue, Jun 23, 2020 at 9:36 AM Yonghong Song <yhs@fb.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On 6/23/20 7:54 AM, Matt Pallissard wrote:
> > > > > > >
> > > > > > > On 2020-06-22T15:09:57 -0700, Andrii Nakryiko wrote:
> > > > > > >> On Mon, Jun 22, 2020 at 10:19 AM Matt Pallissard <matt@pallissard.net> wrote:
> > > > > > >>>
> > > > > > >>> On 2020-06-22T09:20:03 -0700, Andrii Nakryiko wrote:
> > > > > > >>>> On Mon, Jun 22, 2020 at 8:01 AM Matt Pallissard <matt@pallissard.net> wrote:
> > > > > > >>>>> On 2020-06-21T08:44:28 -0700, Matt Pallissard wrote:
> > > > > > >>>>>> On 2020-06-20T20:29:43 -0700, Andrii Nakryiko wrote:
> > > > > > >>>>>>> On Sat, Jun 20, 2020 at 1:07 PM Matt Pallissard <matt@pallissard.net> wrote:
> > > > > > >>>>>>>> On 2020-06-20T11:11:55 -0700, Yonghong Song wrote:
> > > > > > >>>>>>>>> On 6/20/20 9:22 AM, Matt Pallissard wrote:
> > > > > > >>>>>>>>>> New to bpf here.
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> I'm trying to read values out of of mm_struct.  I have code like this;
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> unsigned long i[10] = {};
> > > > > > >>>>>>>>>> struct task_struct *t;
> > > > > > >>>>>>>>>> struct mm_rss_stat *rss;
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> t = (struct task_struct *)bpf_get_current_task();
> > > > > > >>>>>>>>>> BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
> > > > > > >>>>>>>>>> BPF_CORE_READ_INTO(i, rss, count);
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> However, all values in `i` appear to be 0 (i[MM_FILEPAGES], etc), as if no data gets copied.  I'm about 100% confident that this is caused by a glaring oversight on my part.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> Maybe you want to check the return value of BPF_CORE_READ_INTO.
> > > > > > >>>>>>>>> Underlying it is using bpf_probe_read and bpf_probe_read may fail e.g., due
> > > > > > >>>>>>>>> to major fault.
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> Doh, I should have known to check the return codes!  Yes, it was failing.  I knew I was overlooking something trivial.
> > > > > > >>>>>>>>
> > > > > > >>>>>>>
> > > > > > >>>>>>> I wrote exactly such piece of code a while ago. Here's part of it for
> > > > > > >>>>>>> reference, I think it will be helpful:
> > > > > > >>>>>>>
> > > > > > >>>>>>>    struct task_struct *task = (struct task_struct *)bpf_get_current_task();
> > > > > > >>>>>>>    const struct mm_struct *mm = BPF_CORE_READ(task, mm);
> > > > > > >>>>>>>
> > > > > > >>>>>>>    if (mm) {
> > > > > > >>>>>>>        u64 hiwater_rss = BPF_CORE_READ(mm, hiwater_rss);
> > > > > > >>>>>>>        u64 file_pages = BPF_CORE_READ(mm, rss_stat.count[MM_FILEPAGES].counter);
> > > > > > >>>>>>>        u64 anon_pages = BPF_CORE_READ(mm, rss_stat.count[MM_ANONPAGES].counter);
> > > > > > >>>>>>>        u64 shmem_pages = BPF_CORE_READ(mm,
> > > > > > >>>>>>> rss_stat.count[MM_SHMEMPAGES].counter);
> > > > > > >>>>>>>        u64 active_rss = file_pages + anon_pages + shmem_pages;
> > > > > > >>>>>>>        /* ... */
> > > > > > >>>>>>
> > > > > > >>>>>> Thank you,
> > > > > > >>>>>>
> > > > > > >>>>>> After realizing that I was referencing the struct incorrectly, I wound up with a similar block of code.  However, as I started testing it against /proc/pid/smaps[,_rollup] I noticed that my numbers didn't match up.  Always smaller.
> > > > > > >>>>>>
> > > > > > >>>>>> I took a quick glance at fs/proc/task_mmu.c.  I think I'll have to walk some sort of accounting structure.
> > > > > > >>>>>
> > > > > > >>>>>
> > > > > > >>>>> I started to take a hard look at fs/proc/task_mmu.c.  With all the locking, globals, and compile-time constants, I'm not sure that it's even possible to correctly walk `vm_area_struct` in bpf.
> > > > > > >>>>
> > > > > > >>>> Yes, you can't take all those locks from BPF. But reading atomic
> > > > > > >>>> counters from BPF should be no problem. You might get a slightly out
> > > > > > >>>> of sync readings, but whatever you are doing shouldn't expect to have
> > > > > > >>>> 100% correct values anyways, because they might change so fast after
> > > > > > >>>> you read them.
> > > > > > >>>
> > > > > > >>> That was my initial thought.  I didn't care to much about stale data, my only real concern was walking vm_area_struct and having memory freed.  I wasn't sure if that could break the list underneath me.  Although, that shouldn't be too difficult to get to the bottom of.
> > > > > > >>>
> > > > > > >>
> > > > > > >> Not sure about vm_area_struct (where is it in the example above?), but
> > > > > > >> mm_struct won't go away, because current task won't go away, because
> > > > > > >> BPF program is running in the context of current. Similarly for
> > > > > > >> bpf_iter, bpf_iter will actually take a refcnt on tast_struct. So I
> > > > > > >> think you don't have to worry about that.
> > > > > > >
> > > > > > > I didn't mention it explicitly in the example above.  But when I originally mentioned walking an accounting structure, as procfs does, it winds up being `mm_struct->mmap,vm_[next,prev]`, with mmap being a `vm_area_struct`.  But, it sounds like I should be abandoning that path and iterating over all the tasks.
> > > > > > >
> > > > > > >
> > > > > > >>>>> If anyone has suggestions for getting memory numbers from an entire process, not just a task/thread, I'd love to hear them.  If not, I'll pursue this on my own.
> > > > > > >>>>
> > > > > > >>>> For this, you'd need to iterate across many tasks and aggregate their
> > > > > > >>>> results based on tasks's tgid. Check iter/task programs in selftests
> > > > > > >>>> (progs/bpf_iter_task.c, I think).
> > > > > > >
> > > > > > >
> > > > > > > When I try to replicate some of the selftest task logic. I run into some errors when I call bpf_object__load.  `libbpf: task is not found in vmlinux BTF.`  I'll try matching the selftest code more closely and digging into that further.
> > > > > >
> > > > > > Somehow libbpf did not prepend `task` with `bpf_iter_` prefix. Not sure
> > > > > > what is the exact issue. Yes, please mimic what selftests did.
> > > > > >
> > > > >
> > > > > It's just an artifact of how libbpf logs error in such case. It did
> > > > > search for "bpf_iter_task" type, though. But Matt probably doesn't
> > > > > have a recent enough kernel or didn't build it with
> > > > > CONFIG_DEBUG_INFO_BTF=y and pahole 1.16+?
> > > >
> > > > That shouldn't be the case, I generated vmlinux.h from my currently running machine.
> > > >
> > > >
> > > > I'm using an upstream kernel.
> > > > > ~ uname -r
> > > > > 5.7.2-arch1-1
> > > >
> > > > Which has the BTF debug info enabled.
> > > > > ~ zgrep BTF= /proc/config.gz
> > > > > CONFIG_DEBUG_INFO_BTF=y
> > > >
> > > >
> > > > I assume that it was built with the version of pahole that's in the upstream repos.
> > > > > ~ pacman -Ss pahole
> > > > > extra/pahole 1.17-1 [installed]
> > > >
> > > >
> > > > Unless I've came across some odd bug, I assume that I've implemented something incorrectly.
> > > >
> > >
> > > Ok, can you show your code (BPF and user-space side) and libbpf debug logs then?
> >
> >
> > Sure.  The userspace section in question is below.  I don't make it past `bpf_object__load`.  Same userspace code works fine for tracepoints.
> >
> >         struct bpf_program *prog;
> >         struct bpf_object *obj;
> >         char path[] = PT_BPF_OBJECT_DIR;
> >         strcat(&path[strlen(path)], "/test.o");
> >
> >         libbpf_set_print(print_libbpf_log);
> >
> >         obj = bpf_object__open_file(path, NULL);
> >         if (libbpf_get_error(obj))
> >                 return 1;
> >
> >         if(!(prog = bpf_object__find_program_by_name(obj, "dump_task")))
> >                 goto cleanup;
> >
> >         if (bpf_object__load(obj))
> >                 goto cleanup;
> >
> >
> > I copied the kernel code, only slightly modifying the include statements
> >
> >         #define bpf_iter_meta bpf_iter_meta___not_used
> >         #define bpf_iter__task bpf_iter__task___not_used
> >         #include <vmlinux.h>
> >         #undef bpf_iter_meta
> >         #undef bpf_iter__task
> >         #include <bpf_helpers.h>
> >         #include <bpf_tracing.h>
> >
> >         struct bpf_iter_meta {
> >                 struct seq_file *seq;
> >                 __u64 session_id;
> >                 __u64 seq_num;
> >         } __attribute__((preserve_access_index));
> >
> >         struct bpf_iter__task {
> >                 struct bpf_iter_meta *meta;
> >                 struct task_struct *task;
> >         } __attribute__((preserve_access_index));
> >
> >         SEC("iter/task")
> >         int dump_task(struct bpf_iter__task *ctx)
> >         {
> >                 struct seq_file *seq = ctx->meta->seq;
> >                 struct task_struct *task = ctx->task;
> >
> >                 if (task == (void *)0) {
> >                         BPF_SEQ_PRINTF(seq, "    === END ===\n");
> >                         return 0;
> >                 }
> >
> >                 if (ctx->meta->seq_num == 0)
> >                         BPF_SEQ_PRINTF(seq, "    tgid      gid\n");
> >
> >                 BPF_SEQ_PRINTF(seq, "%8d %8d\n", task->tgid, task->pid);
> >                 return 0;
> >         }
> >
> >
> > And here is the debug output
> >
> >
> > libbpf: loading /tmp//usr/lib/pt/bpf/test.o
> > libbpf: section(1) .strtab, size 277, link 0, flags 0, type=3
> > libbpf: skip section(1) .strtab
> > libbpf: section(2) .text, size 0, link 0, flags 6, type=1
> > libbpf: skip section(2) .text
> > libbpf: section(3) iter/task, size 320, link 0, flags 6, type=1
> > libbpf: found program iter/task
> > libbpf: section(4) .reliter/task, size 48, link 22, flags 0, type=9
> > libbpf: section(5) .rodata, size 45, link 0, flags 2, type=1
> > libbpf: section(6) license, size 4, link 0, flags 3, type=1
> > libbpf: license of /tmp//usr/lib/pt/bpf/test.o is GPL
> > libbpf: section(7) version, size 4, link 0, flags 3, type=1
> > libbpf: kernel version of /tmp//usr/lib/pt/bpf/test.o is 5060b
> > libbpf: section(8) .debug_str, size 135270, link 0, flags 30, type=1
> > libbpf: skip section(8) .debug_str
> > libbpf: section(9) .debug_loc, size 124, link 0, flags 0, type=1
> > libbpf: skip section(9) .debug_loc
> > libbpf: section(10) .debug_abbrev, size 857, link 0, flags 0, type=1
> > libbpf: skip section(10) .debug_abbrev
> > libbpf: section(11) .debug_info, size 224491, link 0, flags 0, type=1
> > libbpf: skip section(11) .debug_info
> > libbpf: section(12) .rel.debug_info, size 160, link 22, flags 0, type=9
> > libbpf: skip relo .rel.debug_info(12) for section(11)
> > libbpf: section(13) .BTF, size 25711, link 0, flags 0, type=1
> > libbpf: section(14) .rel.BTF, size 80, link 22, flags 0, type=9
> > libbpf: skip relo .rel.BTF(14) for section(13)
> > libbpf: section(15) .BTF.ext, size 348, link 0, flags 0, type=1
> > libbpf: section(16) .rel.BTF.ext, size 288, link 22, flags 0, type=9
> > libbpf: skip relo .rel.BTF.ext(16) for section(15)
> > libbpf: section(17) .debug_frame, size 40, link 0, flags 0, type=1
> > libbpf: skip section(17) .debug_frame
> > libbpf: section(18) .rel.debug_frame, size 16, link 22, flags 0, type=9
> > libbpf: skip relo .rel.debug_frame(18) for section(17)
> > libbpf: section(19) .debug_line, size 216, link 0, flags 0, type=1
> > libbpf: skip section(19) .debug_line
> > libbpf: section(20) .rel.debug_line, size 16, link 22, flags 0, type=9
> > libbpf: skip relo .rel.debug_line(20) for section(19)
> > libbpf: section(21) .llvm_addrsig, size 6, link 22, flags 80000000, type=1879002115
> > libbpf: skip section(21) .llvm_addrsig
> > libbpf: section(22) .symtab, size 312, link 1, flags 0, type=2
> > libbpf: looking for externs among 13 symbols...
> > libbpf: collected 0 externs total
> > libbpf: map 'test.rodata' (global data): at sec_idx 5, offset 0, flags 480.
> > libbpf: map 0 is "test.rodata"
> > libbpf: collecting relocating info for: 'iter/task'
> > libbpf: relo for shdr 5, symb 9, value 0, type 3, bind 0, name 0 (''), insn 7
> > libbpf: found data map 0 (test.rodata, sec 5, off 0) for insn 7
> > libbpf: relo for shdr 5, symb 9, value 0, type 3, bind 0, name 0 (''), insn 17
> > libbpf: found data map 0 (test.rodata, sec 5, off 0) for insn 17
> > libbpf: relo for shdr 5, symb 9, value 0, type 3, bind 0, name 0 (''), insn 33
> > libbpf: found data map 0 (test.rodata, sec 5, off 0) for insn 33
> > libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
> > libbpf: map 'test.rodata': created successfully, fd=4
> > libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
> > libbpf: prog 'iter/task': performing 6 CO-RE offset relocs
> > libbpf: prog 'iter/task': relo #0: kind 0, spec is [2] bpf_iter__task + 0:0 => 0.0 @ &x[0].meta
> > libbpf: prog 'iter/task': relo #0: no matching targets found for [2] bpf_iter__task + 0:0
> > libbpf: prog 'iter/task': relo #0: substituting insn #0 w/ invalid insn
> > libbpf: prog 'iter/task': relo #1: kind 0, spec is [8] bpf_iter_meta + 0:0 => 0.0 @ &x[0].seq
> > libbpf: prog 'iter/task': relo #1: no matching targets found for [8] bpf_iter_meta + 0:0
> > libbpf: prog 'iter/task': relo #1: substituting insn #1 w/ invalid insn
> > libbpf: prog 'iter/task': relo #2: kind 0, spec is [2] bpf_iter__task + 0:1 => 8.0 @ &x[0].task
> > libbpf: prog 'iter/task': relo #2: no matching targets found for [2] bpf_iter__task + 0:1
> > libbpf: prog 'iter/task': relo #2: substituting insn #2 w/ invalid insn
> 
> see all these "substituting insn w/ invalid insn" messages? Your
> kernel doesn't have bpf_iter__task struct in it.
> 
> You can confirm by running:
> 
> $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep bpf_iter_
> 
> You said you have 5.7 kernel. Isn't bpf_iter available starting from 5.8?

Ah, this was it. I bumped to 8.5-rc2 and it loads now.  I figured out bpftool gen skeleton via the selftests in the process, I'm a fan.

100: tracing  name dump_task  tag 70ea8cf44dc2d3e4  gpl
        loaded_at 2020-06-24T07:23:37-0700  uid 0
        xlated 320B  jited 200B  memlock 4096B  map_ids 44
        btf_id 60

I don't have any output in /sys/kernel/tracing/trace_pipe yet, but I'm sure I can fumble through the selftests some more and figure that out.

Thanks again.  You two rock.


> > libbpf: prog 'iter/task': relo #3: kind 0, spec is [8] bpf_iter_meta + 0:2 => 16.0 @ &x[0].seq_num
> > libbpf: prog 'iter/task': relo #3: no matching targets found for [8] bpf_iter_meta + 0:2
> > libbpf: prog 'iter/task': relo #3: substituting insn #12 w/ invalid insn
> > libbpf: prog 'iter/task': relo #4: kind 0, spec is [12] task_struct + 0:71 => 1292.0 @ &x[0].tgid
> > libbpf: [12] task_struct: found candidate [115] task_struct
> > libbpf: prog 'iter/task': relo #4: matching candidate #0 task_struct against spec [115] task_struct + 0:71 => 1292.0 @ &x[0].tgid: 1
> > libbpf: prog 'iter/task': relo #4: patched insn #22 (LDX/ST/STX) off 1292 -> 1292
> > libbpf: prog 'iter/task': relo #5: kind 0, spec is [12] task_struct + 0:70 => 1288.0 @ &x[0].pid
> > libbpf: prog 'iter/task': relo #5: matching candidate #0 task_struct against spec [115] task_struct + 0:70 => 1288.0 @ &x[0].pid: 1
> > libbpf: prog 'iter/task': relo #5: patched insn #26 (LDX/ST/STX) off 1288 -> 1288
> > libbpf: task is not found in vmlinux BTF
> > libbpf: failed to load object '/tmp//usr/lib/pt/bpf/test.o'
> > *** stack smashing detected ***: terminated  <-- I assume this is because I'm not handling my errors and cleaning up properly
> > Aborted (core dumped)
> >
> > > > > > > As an aside; is there any documentation for bpf_iter outside of the selftests?
> > > > > >
> > > > > > Unfortunately, no. The commit messages of the original patch set might help.
> > > > > > https://lore.kernel.org/bpf/20200507053916.1542319-1-yhs@fb.com/T/#mf973843af65fc51ac9b3e3673962cd3e87f705e8
