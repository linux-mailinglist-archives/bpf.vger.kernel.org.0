Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466A03D03C3
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 23:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhGTUff (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Jul 2021 16:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbhGTU3x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Jul 2021 16:29:53 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B13C061574
        for <bpf@vger.kernel.org>; Tue, 20 Jul 2021 14:10:30 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id b13so420566ybk.4
        for <bpf@vger.kernel.org>; Tue, 20 Jul 2021 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hBULP2GV02+Y0NZ8o1F8UOb4Z/w7J1m2gElrxWzpJSw=;
        b=pFJc+7GEsFM02MU29lJSIUeMguLXZzchoCRkrpN7fW7ficHjXAHVPmFSnB5ciftQLD
         Hi7pSDK3zbP4RaEqVM0YFBGURX7wHDqoqQQif/xA6HjcCsEsUGXekfTA7UAfSv66KP2H
         7RbzoVQtIe/EKFmxapGSKikYYHiHqPpPIEZko8cAXw5jVPNHU6Kl1ygfCrvqLjxhINNm
         EtqVynxq6l2JID7CbQam/E9pp7BYvWi+wd/akNtJNobTq6jvMtbtQKLwehr5SINlT+8y
         MUpDLHcE6uHwyHghD+ItzQ6vdwkxmdOZYZau+pxfBlRTDMRt7uXESo+lvsTaDYSUyRV8
         47KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBULP2GV02+Y0NZ8o1F8UOb4Z/w7J1m2gElrxWzpJSw=;
        b=dHov126pSpzkmagfpZx/8LIVmrPn/E9nJvu/6TR9P+6VtPwxO9sX3wxHGPcEeXCX7V
         VbmGGhhoYqyW03TZPw8YoqJOfy3RsWtneJoUIiSm95UojA4kgtfxDrS6GZlkXmOXSp+q
         sbIazhQS/6WKrBPxQKabPkK0hEb1q4fuM85VU4Ary76pDtPE/5rEZGEFmmVsM6UsklcZ
         XFhnc/lVSuuvHqgLGBfCuaHlSMxuQBLfT8bWenifnhoE5zFwn0RDx+zVJy6sWZyOCn/G
         XT5Dll0FiRq8EjASnHq3w4l62W6RtYEPmSQ+Z3X+wEAkxndFyt8tOWuyL3cedZ+Ku3Z2
         C39A==
X-Gm-Message-State: AOAM533L9PZz8KXFwWWchcxekHTRBbImOq0GuWu5xN79vWpU9wVJzDTw
        WP2TWg2I1/KSPOSHbPagLZYl+f4hvDv/G1qKnGI=
X-Google-Smtp-Source: ABdhPJy7GRB4IljIgh0eiNU+4UgR4HgGdNyDgk+VZF5fp0vq7qrfAUmHwUbkgOsH5br+lJqL84/5pg63GHzaWqH+Ccs=
X-Received: by 2002:a25:b741:: with SMTP id e1mr41959145ybm.347.1626815429615;
 Tue, 20 Jul 2021 14:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
 <20210514003623.28033-15-alexei.starovoitov@gmail.com> <CAEf4BzZpAVCJm41AiR_CPO7FcVcEbA-XWqq-YNb3dfLBp714ow@mail.gmail.com>
 <CAADnVQLvGYR9uFb5hbwpur3D7ZdyLbgv40p_TH=7+wpN6h4FjQ@mail.gmail.com>
In-Reply-To: <CAADnVQLvGYR9uFb5hbwpur3D7ZdyLbgv40p_TH=7+wpN6h4FjQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Jul 2021 14:10:18 -0700
Message-ID: <CAEf4BzbRM5mViLK4iRW3RCJHGcChrpBMDrTyCptuCPjQC5KzOQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 14/21] libbpf: Generate loader program out of
 BPF ELF file.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 20, 2021 at 1:51 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 11, 2021 at 1:23 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, May 13, 2021 at 5:36 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > The BPF program loading process performed by libbpf is quite complex
> > > and consists of the following steps:
> > > "open" phase:
> > > - parse elf file and remember relocations, sections
> > > - collect externs and ksyms including their btf_ids in prog's BTF
> > > - patch BTF datasec (since llvm couldn't do it)
> > > - init maps (old style map_def, BTF based, global data map, kconfig map)
> > > - collect relocations against progs and maps
> > > "load" phase:
> > > - probe kernel features
> > > - load vmlinux BTF
> > > - resolve externs (kconfig and ksym)
> > > - load program BTF
> > > - init struct_ops
> > > - create maps
> > > - apply CO-RE relocations
> > > - patch ld_imm64 insns with src_reg=PSEUDO_MAP, PSEUDO_MAP_VALUE, PSEUDO_BTF_ID
> > > - reposition subprograms and adjust call insns
> > > - sanitize and load progs
> > >
> > > During this process libbpf does sys_bpf() calls to load BTF, create maps,
> > > populate maps and finally load programs.
> > > Instead of actually doing the syscalls generate a trace of what libbpf
> > > would have done and represent it as the "loader program".
> > > The "loader program" consists of single map with:
> > > - union bpf_attr(s)
> > > - BTF bytes
> > > - map value bytes
> > > - insns bytes
> > > and single bpf program that passes bpf_attr(s) and data into bpf_sys_bpf() helper.
> > > Executing such "loader program" via bpf_prog_test_run() command will
> > > replay the sequence of syscalls that libbpf would have done which will result
> > > the same maps created and programs loaded as specified in the elf file.
> > > The "loader program" removes libelf and majority of libbpf dependency from
> > > program loading process.
> > >
> > > kconfig, typeless ksym, struct_ops and CO-RE are not supported yet.
> > >
> > > The order of relocate_data and relocate_calls had to change, so that
> > > bpf_gen__prog_load() can see all relocations for a given program with
> > > correct insn_idx-es.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  tools/lib/bpf/Build              |   2 +-
> > >  tools/lib/bpf/bpf_gen_internal.h |  40 ++
> > >  tools/lib/bpf/gen_loader.c       | 689 +++++++++++++++++++++++++++++++
> > >  tools/lib/bpf/libbpf.c           | 226 ++++++++--
> > >  tools/lib/bpf/libbpf.h           |  12 +
> > >  tools/lib/bpf/libbpf.map         |   1 +
> > >  tools/lib/bpf/libbpf_internal.h  |   2 +
> > >  tools/lib/bpf/skel_internal.h    | 123 ++++++
> > >  8 files changed, 1060 insertions(+), 35 deletions(-)
> > >  create mode 100644 tools/lib/bpf/bpf_gen_internal.h
> > >  create mode 100644 tools/lib/bpf/gen_loader.c
> > >  create mode 100644 tools/lib/bpf/skel_internal.h
> > >
> >
> > [...]
> >
> > > +void bpf_gen__prog_load(struct bpf_gen *gen,
> > > +                       struct bpf_prog_load_params *load_attr, int prog_idx)
> > > +{
> > > +       int attr_size = offsetofend(union bpf_attr, fd_array);
> > > +       int prog_load_attr, license, insns, func_info, line_info;
> > > +       union bpf_attr attr;
> > > +
> > > +       memset(&attr, 0, attr_size);
> > > +       pr_debug("gen: prog_load: type %d insns_cnt %zd\n",
> > > +                load_attr->prog_type, load_attr->insn_cnt);
> > > +       /* add license string to blob of bytes */
> > > +       license = add_data(gen, load_attr->license, strlen(load_attr->license) + 1);
> > > +       /* add insns to blob of bytes */
> > > +       insns = add_data(gen, load_attr->insns,
> > > +                        load_attr->insn_cnt * sizeof(struct bpf_insn));
> > > +
> > > +       attr.prog_type = load_attr->prog_type;
> > > +       attr.expected_attach_type = load_attr->expected_attach_type;
> > > +       attr.attach_btf_id = load_attr->attach_btf_id;
> > > +       attr.prog_ifindex = load_attr->prog_ifindex;
> > > +       attr.kern_version = 0;
> > > +       attr.insn_cnt = (__u32)load_attr->insn_cnt;
> > > +       attr.prog_flags = load_attr->prog_flags;
> > > +
> > > +       attr.func_info_rec_size = load_attr->func_info_rec_size;
> > > +       attr.func_info_cnt = load_attr->func_info_cnt;
> > > +       func_info = add_data(gen, load_attr->func_info,
> > > +                            attr.func_info_cnt * attr.func_info_rec_size);
> > > +
> > > +       attr.line_info_rec_size = load_attr->line_info_rec_size;
> > > +       attr.line_info_cnt = load_attr->line_info_cnt;
> > > +       line_info = add_data(gen, load_attr->line_info,
> > > +                            attr.line_info_cnt * attr.line_info_rec_size);
> > > +
> >
> > Hey Alexei,
> >
> > Coverity ([0] and [1]) is complaining that load_attr->func_info and
> > load_attr->line_info can be NULL in some cases, which will lead to
> > NULL deref. I'm not sure if we restrict gen_loader to be only used
> > with BPF applications that have BTF embedded. If not, then it will
> > cause a crash, so we need to protect against that. Please take a look.
> >
> >   [0] https://scan3.coverity.com/reports.htm#v40547/p11903/fileInstanceId=53874059&defectInstanceId=10901198&mergedDefectId=349034
> >   [1] https://scan3.coverity.com/reports.htm#v40547/p11903/fileInstanceId=53874059&defectInstanceId=10901191&mergedDefectId=349033
> >
> > Not sure why we have two issues above, they both look identical, but
> > for completeness I included both.
>
> I cannot access these links.

Unfortunately Coverity doesn't allow access to those report for users
without account and not explicitly allowed for a given project :( I've
sent invitation to your gmail account, just in case.

> Looking at the code the func_info can be NULL,
> but in such case the line_info_cnt will be zero.
> realloc_data_buf() will succeed as a nop and then there will be:
> memcpy(gen->data_cur, NULL, 0);
> which is ok to do. I double checked.
> So this coverity issue looks like a false positive.

Yep, makes sense. Thanks for checking! I'll mark them as false positives.
