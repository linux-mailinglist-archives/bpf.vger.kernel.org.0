Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821783A4A17
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 22:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFKU0P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 16:26:15 -0400
Received: from mail-yb1-f176.google.com ([209.85.219.176]:34550 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFKU0P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 16:26:15 -0400
Received: by mail-yb1-f176.google.com with SMTP id c8so4300003ybq.1
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 13:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBrd2CWck8wFErZGavdqstErVyMd6Art7pTp/ZI8OkU=;
        b=nzBAmby1wdmqa8A5yJGjAsks82dMazpeP3hwByVWLriI/GOzEMK+XNxwGZlArR5Oza
         H8hL+gLjtW/qex7iBzOedspJssaPli2d7JLolK/Dw8mvjJ18tq84bp1jYjJdn+BLE14b
         Af6EmDnRwkO+v2lN5adqJGJUx+lsiUluqk69XPT3HuDYM5ayBzmy7paMxKNtu3OoiPRf
         TJbh0/wDpeHXd73GGsr/5NX0kv6iwWl0YLrd4+Wrna8v4ejVVzn80c22BVyknJW3Yb//
         KGrgs6KQFnOPC4KkrOaKYSXXACUsHPuOXqjrcOjoJFHGNaSPtQ8Od1KZ6uZYQ7dH5CTS
         s9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBrd2CWck8wFErZGavdqstErVyMd6Art7pTp/ZI8OkU=;
        b=PqIts4JrKhLtJnw0T+eM9irck09guc5ZJ0Q/gdGUFEkiRhtBLfW+R8tiSmqRJtLD2a
         ZjjAG43QiW6nvC5QzaTlKN1CsYhCJhkWbmPMppPgvU8qeF/9qxxjOokPUmNjCDxkc7Uz
         g8XUCfgsSiRR9Iy/pPSsxl0lnxSMWfxLJAiuPYwAQ2oIUy2WMrgZajh/GAnK4gr5Dt/t
         eRZE8VQiDf370XFT3tuKLr3RLa6I9rrCIINib2U3z3CUixFiW7F7almo0sbAqYUARKwe
         e6n1EJAVpIQvSFED+ontNZmBwOXOVs01g+Jszx0oHLzpbW86FebgHK6Jq/1H10qRwNXv
         fsEQ==
X-Gm-Message-State: AOAM533R2/Vu8ealKB25+9A5zTXkJXSNhKKXKeBZoHaReOTc7H6ci3po
        /SS5SmISLrdNYas9ZxY976UOCUiJitbczv4DiIE=
X-Google-Smtp-Source: ABdhPJz5xycyczK51cZbi0rr5G5YaYcmUqJW9AsqR6YLBx7REvHnsLlpwEQGhgN0tcGYseMGDl1o1lzByh+517TCRko=
X-Received: by 2002:a25:aa66:: with SMTP id s93mr8699491ybi.260.1623442991006;
 Fri, 11 Jun 2021 13:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com> <20210514003623.28033-15-alexei.starovoitov@gmail.com>
In-Reply-To: <20210514003623.28033-15-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Jun 2021 13:22:59 -0700
Message-ID: <CAEf4BzZpAVCJm41AiR_CPO7FcVcEbA-XWqq-YNb3dfLBp714ow@mail.gmail.com>
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

On Thu, May 13, 2021 at 5:36 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> The BPF program loading process performed by libbpf is quite complex
> and consists of the following steps:
> "open" phase:
> - parse elf file and remember relocations, sections
> - collect externs and ksyms including their btf_ids in prog's BTF
> - patch BTF datasec (since llvm couldn't do it)
> - init maps (old style map_def, BTF based, global data map, kconfig map)
> - collect relocations against progs and maps
> "load" phase:
> - probe kernel features
> - load vmlinux BTF
> - resolve externs (kconfig and ksym)
> - load program BTF
> - init struct_ops
> - create maps
> - apply CO-RE relocations
> - patch ld_imm64 insns with src_reg=PSEUDO_MAP, PSEUDO_MAP_VALUE, PSEUDO_BTF_ID
> - reposition subprograms and adjust call insns
> - sanitize and load progs
>
> During this process libbpf does sys_bpf() calls to load BTF, create maps,
> populate maps and finally load programs.
> Instead of actually doing the syscalls generate a trace of what libbpf
> would have done and represent it as the "loader program".
> The "loader program" consists of single map with:
> - union bpf_attr(s)
> - BTF bytes
> - map value bytes
> - insns bytes
> and single bpf program that passes bpf_attr(s) and data into bpf_sys_bpf() helper.
> Executing such "loader program" via bpf_prog_test_run() command will
> replay the sequence of syscalls that libbpf would have done which will result
> the same maps created and programs loaded as specified in the elf file.
> The "loader program" removes libelf and majority of libbpf dependency from
> program loading process.
>
> kconfig, typeless ksym, struct_ops and CO-RE are not supported yet.
>
> The order of relocate_data and relocate_calls had to change, so that
> bpf_gen__prog_load() can see all relocations for a given program with
> correct insn_idx-es.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/Build              |   2 +-
>  tools/lib/bpf/bpf_gen_internal.h |  40 ++
>  tools/lib/bpf/gen_loader.c       | 689 +++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c           | 226 ++++++++--
>  tools/lib/bpf/libbpf.h           |  12 +
>  tools/lib/bpf/libbpf.map         |   1 +
>  tools/lib/bpf/libbpf_internal.h  |   2 +
>  tools/lib/bpf/skel_internal.h    | 123 ++++++
>  8 files changed, 1060 insertions(+), 35 deletions(-)
>  create mode 100644 tools/lib/bpf/bpf_gen_internal.h
>  create mode 100644 tools/lib/bpf/gen_loader.c
>  create mode 100644 tools/lib/bpf/skel_internal.h
>

[...]

> +void bpf_gen__prog_load(struct bpf_gen *gen,
> +                       struct bpf_prog_load_params *load_attr, int prog_idx)
> +{
> +       int attr_size = offsetofend(union bpf_attr, fd_array);
> +       int prog_load_attr, license, insns, func_info, line_info;
> +       union bpf_attr attr;
> +
> +       memset(&attr, 0, attr_size);
> +       pr_debug("gen: prog_load: type %d insns_cnt %zd\n",
> +                load_attr->prog_type, load_attr->insn_cnt);
> +       /* add license string to blob of bytes */
> +       license = add_data(gen, load_attr->license, strlen(load_attr->license) + 1);
> +       /* add insns to blob of bytes */
> +       insns = add_data(gen, load_attr->insns,
> +                        load_attr->insn_cnt * sizeof(struct bpf_insn));
> +
> +       attr.prog_type = load_attr->prog_type;
> +       attr.expected_attach_type = load_attr->expected_attach_type;
> +       attr.attach_btf_id = load_attr->attach_btf_id;
> +       attr.prog_ifindex = load_attr->prog_ifindex;
> +       attr.kern_version = 0;
> +       attr.insn_cnt = (__u32)load_attr->insn_cnt;
> +       attr.prog_flags = load_attr->prog_flags;
> +
> +       attr.func_info_rec_size = load_attr->func_info_rec_size;
> +       attr.func_info_cnt = load_attr->func_info_cnt;
> +       func_info = add_data(gen, load_attr->func_info,
> +                            attr.func_info_cnt * attr.func_info_rec_size);
> +
> +       attr.line_info_rec_size = load_attr->line_info_rec_size;
> +       attr.line_info_cnt = load_attr->line_info_cnt;
> +       line_info = add_data(gen, load_attr->line_info,
> +                            attr.line_info_cnt * attr.line_info_rec_size);
> +

Hey Alexei,

Coverity ([0] and [1]) is complaining that load_attr->func_info and
load_attr->line_info can be NULL in some cases, which will lead to
NULL deref. I'm not sure if we restrict gen_loader to be only used
with BPF applications that have BTF embedded. If not, then it will
cause a crash, so we need to protect against that. Please take a look.

  [0] https://scan3.coverity.com/reports.htm#v40547/p11903/fileInstanceId=53874059&defectInstanceId=10901198&mergedDefectId=349034
  [1] https://scan3.coverity.com/reports.htm#v40547/p11903/fileInstanceId=53874059&defectInstanceId=10901191&mergedDefectId=349033

Not sure why we have two issues above, they both look identical, but
for completeness I included both.

> +       memcpy(attr.prog_name, load_attr->name,
> +              min((unsigned)strlen(load_attr->name), BPF_OBJ_NAME_LEN - 1));
> +       prog_load_attr = add_data(gen, &attr, attr_size);
> +
> +       /* populate union bpf_attr with a pointer to license */
> +       emit_rel_store(gen, attr_field(prog_load_attr, license), license);
> +

[...]
