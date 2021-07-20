Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B813D038B
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhGTUWx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Jul 2021 16:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbhGTUKk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Jul 2021 16:10:40 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D897BC061762
        for <bpf@vger.kernel.org>; Tue, 20 Jul 2021 13:51:16 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id h9so146971ljm.5
        for <bpf@vger.kernel.org>; Tue, 20 Jul 2021 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trI3O95tMLrQ1hA35O7MEJmWA2ZIKU3ZyO5WZRR4JaM=;
        b=h4Z616ADHaHVqylgvKi+8X3bwsT44sDHzTw81bjvPpI7IBmrlO4jR+OBFSeM1wYuTv
         kJOu8aNBWp9P2kADGQjxcsTEeQdahA3Ut/IhZLLGm2AMREZvFpBzWRy+kof8C/1MhQT+
         v59T5KNWADiG7wL55m3wxSqzVt+iKQDk1naE8p2OqHOv5M9GWr53PZDonlI+3Iq5eiHf
         DmSjqwt4sitarZ2DjUacoOo1vBnZ6HZ7h3cMl8oK/H93S8Izb9Oo4t7JG+3sd8D4BQlR
         qnJdZSfzbVRccavuPwZOSPy71y+uh6/YSR7hAaTpdcNsqu459onP/WExQHklCVCIZvA4
         mzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trI3O95tMLrQ1hA35O7MEJmWA2ZIKU3ZyO5WZRR4JaM=;
        b=cDENs9Zj/0mDYsnufMcqkfI247kDLSmO057/Y8Dz9w5N5q+/WIc1dxZv9sme1mkpaf
         zXsLiI+SOqr/UribB5UXMfuYzKPhWKhfnIjLO2sG2w4fZnyUMWG5IguqbIYzczaroGG2
         V75Rw5S/r8ed8s6pZV44ySz0OqzLXDB1bmlEhlgcmO/GgovTDUR+w3dgPXmuZtoJrnP0
         rMoEK7k1nWUeSk/qxLq5GfDxy13OLmDB8w35OBnvbggIjotwFLlV+8wjX78RaCfqa7No
         JuJjo8Jyn138XKfisXDpKwnvEh11IjRScYZ+AzNws9ez3EIDL2AdShM0GWHxC8dE3kKm
         R/3g==
X-Gm-Message-State: AOAM531JCii+8zY4VadwclUcj2KLD4O2twOtWUvtcNGeIyR1nKK5v9y8
        s1kN0HkJYjsVJhAWPBULGLFDL4g4tGew6kfdHe4=
X-Google-Smtp-Source: ABdhPJxJpl33NtfyIsuyDc3weihFSpu8/4Z4zibyHDLR+hl5NuIDOjo08ZZgkQeCxpbhr5KWGoy0sRCbzxXBBYM9Q7A=
X-Received: by 2002:a2e:390f:: with SMTP id g15mr27446251lja.44.1626814275222;
 Tue, 20 Jul 2021 13:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
 <20210514003623.28033-15-alexei.starovoitov@gmail.com> <CAEf4BzZpAVCJm41AiR_CPO7FcVcEbA-XWqq-YNb3dfLBp714ow@mail.gmail.com>
In-Reply-To: <CAEf4BzZpAVCJm41AiR_CPO7FcVcEbA-XWqq-YNb3dfLBp714ow@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 20 Jul 2021 13:51:03 -0700
Message-ID: <CAADnVQLvGYR9uFb5hbwpur3D7ZdyLbgv40p_TH=7+wpN6h4FjQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 14/21] libbpf: Generate loader program out of
 BPF ELF file.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 11, 2021 at 1:23 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 13, 2021 at 5:36 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > The BPF program loading process performed by libbpf is quite complex
> > and consists of the following steps:
> > "open" phase:
> > - parse elf file and remember relocations, sections
> > - collect externs and ksyms including their btf_ids in prog's BTF
> > - patch BTF datasec (since llvm couldn't do it)
> > - init maps (old style map_def, BTF based, global data map, kconfig map)
> > - collect relocations against progs and maps
> > "load" phase:
> > - probe kernel features
> > - load vmlinux BTF
> > - resolve externs (kconfig and ksym)
> > - load program BTF
> > - init struct_ops
> > - create maps
> > - apply CO-RE relocations
> > - patch ld_imm64 insns with src_reg=PSEUDO_MAP, PSEUDO_MAP_VALUE, PSEUDO_BTF_ID
> > - reposition subprograms and adjust call insns
> > - sanitize and load progs
> >
> > During this process libbpf does sys_bpf() calls to load BTF, create maps,
> > populate maps and finally load programs.
> > Instead of actually doing the syscalls generate a trace of what libbpf
> > would have done and represent it as the "loader program".
> > The "loader program" consists of single map with:
> > - union bpf_attr(s)
> > - BTF bytes
> > - map value bytes
> > - insns bytes
> > and single bpf program that passes bpf_attr(s) and data into bpf_sys_bpf() helper.
> > Executing such "loader program" via bpf_prog_test_run() command will
> > replay the sequence of syscalls that libbpf would have done which will result
> > the same maps created and programs loaded as specified in the elf file.
> > The "loader program" removes libelf and majority of libbpf dependency from
> > program loading process.
> >
> > kconfig, typeless ksym, struct_ops and CO-RE are not supported yet.
> >
> > The order of relocate_data and relocate_calls had to change, so that
> > bpf_gen__prog_load() can see all relocations for a given program with
> > correct insn_idx-es.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/Build              |   2 +-
> >  tools/lib/bpf/bpf_gen_internal.h |  40 ++
> >  tools/lib/bpf/gen_loader.c       | 689 +++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf.c           | 226 ++++++++--
> >  tools/lib/bpf/libbpf.h           |  12 +
> >  tools/lib/bpf/libbpf.map         |   1 +
> >  tools/lib/bpf/libbpf_internal.h  |   2 +
> >  tools/lib/bpf/skel_internal.h    | 123 ++++++
> >  8 files changed, 1060 insertions(+), 35 deletions(-)
> >  create mode 100644 tools/lib/bpf/bpf_gen_internal.h
> >  create mode 100644 tools/lib/bpf/gen_loader.c
> >  create mode 100644 tools/lib/bpf/skel_internal.h
> >
>
> [...]
>
> > +void bpf_gen__prog_load(struct bpf_gen *gen,
> > +                       struct bpf_prog_load_params *load_attr, int prog_idx)
> > +{
> > +       int attr_size = offsetofend(union bpf_attr, fd_array);
> > +       int prog_load_attr, license, insns, func_info, line_info;
> > +       union bpf_attr attr;
> > +
> > +       memset(&attr, 0, attr_size);
> > +       pr_debug("gen: prog_load: type %d insns_cnt %zd\n",
> > +                load_attr->prog_type, load_attr->insn_cnt);
> > +       /* add license string to blob of bytes */
> > +       license = add_data(gen, load_attr->license, strlen(load_attr->license) + 1);
> > +       /* add insns to blob of bytes */
> > +       insns = add_data(gen, load_attr->insns,
> > +                        load_attr->insn_cnt * sizeof(struct bpf_insn));
> > +
> > +       attr.prog_type = load_attr->prog_type;
> > +       attr.expected_attach_type = load_attr->expected_attach_type;
> > +       attr.attach_btf_id = load_attr->attach_btf_id;
> > +       attr.prog_ifindex = load_attr->prog_ifindex;
> > +       attr.kern_version = 0;
> > +       attr.insn_cnt = (__u32)load_attr->insn_cnt;
> > +       attr.prog_flags = load_attr->prog_flags;
> > +
> > +       attr.func_info_rec_size = load_attr->func_info_rec_size;
> > +       attr.func_info_cnt = load_attr->func_info_cnt;
> > +       func_info = add_data(gen, load_attr->func_info,
> > +                            attr.func_info_cnt * attr.func_info_rec_size);
> > +
> > +       attr.line_info_rec_size = load_attr->line_info_rec_size;
> > +       attr.line_info_cnt = load_attr->line_info_cnt;
> > +       line_info = add_data(gen, load_attr->line_info,
> > +                            attr.line_info_cnt * attr.line_info_rec_size);
> > +
>
> Hey Alexei,
>
> Coverity ([0] and [1]) is complaining that load_attr->func_info and
> load_attr->line_info can be NULL in some cases, which will lead to
> NULL deref. I'm not sure if we restrict gen_loader to be only used
> with BPF applications that have BTF embedded. If not, then it will
> cause a crash, so we need to protect against that. Please take a look.
>
>   [0] https://scan3.coverity.com/reports.htm#v40547/p11903/fileInstanceId=53874059&defectInstanceId=10901198&mergedDefectId=349034
>   [1] https://scan3.coverity.com/reports.htm#v40547/p11903/fileInstanceId=53874059&defectInstanceId=10901191&mergedDefectId=349033
>
> Not sure why we have two issues above, they both look identical, but
> for completeness I included both.

I cannot access these links.
Looking at the code the func_info can be NULL,
but in such case the line_info_cnt will be zero.
realloc_data_buf() will succeed as a nop and then there will be:
memcpy(gen->data_cur, NULL, 0);
which is ok to do. I double checked.
So this coverity issue looks like a false positive.
