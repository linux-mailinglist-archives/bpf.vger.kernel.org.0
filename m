Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410532AF9B3
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 21:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgKKU0f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 15:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgKKU0f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 15:26:35 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1900AC0613D1;
        Wed, 11 Nov 2020 12:26:35 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id s8so3081676yba.13;
        Wed, 11 Nov 2020 12:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tTbiZANR5C3y//qv4+KryGrh/bPXUrtPW6uq1kEGmn8=;
        b=siuQ4JNVtCGTTjPPJ8Ca4jG8uCD6Mfp6ezjo068VYSMZ25bz601JkK8bmq35tpYpPM
         tYcq8x0xjG2JxsuoPfJaF1A8CAEYd30B5SUlqf3eYqK8vGwcHz55sGopVgqFShNPKv3a
         Ov60H8u24mgBEuAb7LAU4gSYc5MdBqfptwpptaCE1Gb1U/PwLHEQDeR+FUxTfmVTOwSv
         NXuBglMCP3iwwJSheJfn6l3IFFVw9mmvzzaZCzMdnN7aSq18hz7DJ5YeKQ3TISU6saRN
         IEuDA3ePCzddbn7Xz3KIR/Prse4VBDHm+9l/ToF/bdN9duyeR4LkD+aTEJoA2VTvqpoU
         0OKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTbiZANR5C3y//qv4+KryGrh/bPXUrtPW6uq1kEGmn8=;
        b=kczk+WkbPJGx1oVp9hx2kjPf6lSWZiqCeO9LACwusafxCmMdEBtwAcFXN2dGeBMi3/
         BJmQwZq9R72gl4qxnrnScwrGwVkx5vEUCQUT4OAhEBnVv9XceAV3X/PTOmdK0N5UGhhx
         q0+PMyREFedfYnO4v4OyMmVa4R1eJo1iBNqowe2Rgc+IaglUFTT7269bgjX4a8acgk9h
         fV0kmylXhruQ+/2522IBog73M2bPg6iGgBS0Bb+PGGMzqiqOv6n2YDIdxfnN6uIjQ7VX
         cfvSZgn5FxF1ILpeZ2tKYsN8uWrr4uU0DNm3Of9ud245deQyZAl2y38l+Rcwvqlg46z5
         gkvA==
X-Gm-Message-State: AOAM531XzPOTZqlZmbi4TQ0b8pfw9Q72K5rabzTi9BdJH5mh7b/FWAtg
        otGivVhoSDQoBQGfAh+leFfKow8vyHTBSkgs5ac=
X-Google-Smtp-Source: ABdhPJxedZ6YjH+ZHfodI97cBtnRY/thQBZA91gR02kttRBkjAvgpKOGIi/xiWrNPnBJc9mLqu3oq8WGeH4CTci6B10=
X-Received: by 2002:a25:df8e:: with SMTP id w136mr9517966ybg.230.1605126394377;
 Wed, 11 Nov 2020 12:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20201106222512.52454-1-jolsa@kernel.org> <20201106222512.52454-4-jolsa@kernel.org>
 <CAEf4BzZqFos1N-cnyAc6nL-=fHFJYn1tf9vNUewfsmSUyK4rQQ@mail.gmail.com> <20201111201929.GB619201@krava>
In-Reply-To: <20201111201929.GB619201@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Nov 2020 12:26:23 -0800
Message-ID: <CAEf4BzZe1owmhqjGCjShYwf892hA0tzp0BEAZ2TR41aFx4eKUw@mail.gmail.com>
Subject: Re: [PATCH 3/3] btf_encoder: Change functions check due to broken dwarf
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 11, 2020 at 12:20 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Nov 11, 2020 at 11:59:20AM -0800, Andrii Nakryiko wrote:
>
> SNIP
>
> > > +       if (!fl->init_bpf_begin &&
> > > +           !strcmp("__init_bpf_preserve_type_begin", elf_sym__name(sym, btfe->symtab)))
> > > +               fl->init_bpf_begin = sym->st_value;
> > > +
> > > +       if (!fl->init_bpf_end &&
> > > +           !strcmp("__init_bpf_preserve_type_end", elf_sym__name(sym, btfe->symtab)))
> > > +               fl->init_bpf_end = sym->st_value;
> > > +}
> > > +
> > > +static int has_all_symbols(struct funcs_layout *fl)
> > > +{
> > > +       return fl->mcount_start && fl->mcount_stop &&
> > > +              fl->init_begin && fl->init_end &&
> > > +              fl->init_bpf_begin && fl->init_bpf_end;
> >
> > See below for what seems to be the root cause for the immediate problem.
> >
> > But me, Alexei and Daniel had a discussion offline, and we concluded
> > that this special bpf_preserve_init section is probably not the right
> > approach overall. We should roll back the bpf patch and instead adjust
> > pahole's approach. I think we should just drop the __init check and
> > include all the __init functions into BTF. There could be cases where
> > we'd need to attach BPF programs to __init functions (e.g., bpf_lsm
> > security cases), so having BTFs for those FUNCs are necessary as well.
> > Ftrace currently disallows that, but it's only because no user-space
> > application has a way to attach probes early enough. This might change
> > in the future, so there is no need to invent special mechanisms now
> > for bpf_iter function preservation. Let's just include all __init
> > functions in BTF. Can you please do that change and check how much
> > more functions we get in BTF? Thanks!
>
> sure, not problem to keep all init functions, will give you the count
>
> SNIP
>
> > >
> > > +static bool has_arg_names(struct cu *cu, struct ftype *ftype)
> > > +{
> > > +       struct parameter *param;
> > > +       const char *name;
> > > +
> > > +       ftype__for_each_parameter(ftype, param) {
> > > +               name = dwarves__active_loader->strings__ptr(cu, param->name);
> > > +               if (name == NULL)
> > > +                       return false;
> > > +       }
> > > +       return true;
> > > +}
> > > +
> >
> > I suspect (but haven't verified) that the problem is in this function.
> > If it happens that DWARF for a function has no arguments, then we'll
> > conclude it has all arg names. Don't know what's the best solution
> > here, but please double-check this.
> >
> > Specifically, two selftests are failing now. One of them:
> >
> > libbpf: load bpf program failed: Permission denied
> > libbpf: -- BEGIN DUMP LOG ---
> > libbpf:
> > arg#0 type is not a struct
> > Unrecognized arg#0 type PTR
> > ; int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
> > 0: (79) r6 = *(u64 *)(r1 +0)
> > func 'security_inode_getattr' doesn't have 1-th argument
> > invalid bpf_context access off=0 size=8
> > processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > peak_states 0 mark_read 0
> > libbpf: -- END LOG --
> > libbpf: failed to load program 'prog_stat'
> > libbpf: failed to load object 'test_d_path'
> > libbpf: failed to load BPF skeleton 'test_d_path': -4007
> > test_d_path:FAIL:setup d_path skeleton failed
> > #27 d_path:FAIL
> >
> > This is because in generated BTF security_inode_getattr has a
> > prototype void security_inode_getattr(void); And once we emit this
> > prototype, due to logic in should_generate_function() we won't attempt
> > to do it again, even for the prototype with the right arguments.
>
> hum it works for me :-\
>
>         #27 d_path:OK
>
> with:
>
>         [25962] FUNC_PROTO '(anon)' ret_type_id=17 vlen=1
>                 'path' type_id=729
>         [31327] FUNC 'security_inode_getattr' type_id=25962 linkage=static
>
>
> perhaps your gcc generates DWARF that breaks the way you described
> above, but I'd expect to see function with argument without name,
> not function without arguments at all
>
> what gcc version are you on?

10.2.0, built from sources

>
> when you dump debug information, do you see security_inode_getattr
> record with no arguments?

Yeah, I think so:

21158467- <1><2b7e168>: Abbrev Number: 93 (DW_TAG_subprogram)
21158468-    <2b7e169>   DW_AT_external    : 1
21158469-    <2b7e169>   DW_AT_declaration : 1

  ..  BTW, we should probably still ignore DW_AT_declaration: 1, if it's set.

21158470:    <2b7e169>   DW_AT_linkage_name: (indirect string, offset:
0x120a0a): security_inode_getattr
21158471:    <2b7e16d>   DW_AT_name        : (indirect string, offset:
0x120a0a): security_inode_getattr
21158472-    <2b7e171>   DW_AT_decl_file   : 141
21158473-    <2b7e172>   DW_AT_decl_line   : 346
21158474-    <2b7e174>   DW_AT_decl_column : 5

...

36920783- <1><4c3bc3c>: Abbrev Number: 26 (DW_TAG_subprogram)
36920784-    <4c3bc3d>   DW_AT_external    : 1
36920785:    <4c3bc3d>   DW_AT_name        : (indirect string, offset:
0x120a0a): security_inode_getattr
36920786-    <4c3bc41>   DW_AT_decl_file   : 1
36920787-    <4c3bc42>   DW_AT_decl_line   : 1275
36920788-    <4c3bc44>   DW_AT_decl_column : 5
36920789-    <4c3bc45>   DW_AT_prototyped  : 1
36920790-    <4c3bc45>   DW_AT_type        : <0x4c17ffc>
36920791-    <4c3bc49>   DW_AT_low_pc      : 0xffffffff817d9d70
36920792-    <4c3bc51>   DW_AT_high_pc     : 0x67
36920793-    <4c3bc59>   DW_AT_frame_base  : 1 byte block: 9c
(DW_OP_call_frame_cfa)
36920794-    <4c3bc5b>   DW_AT_GNU_all_call_sites: 1
36920795-    <4c3bc5b>   DW_AT_sibling     : <0x4c3be10>
36920796- <2><4c3bc5f>: Abbrev Number: 17 (DW_TAG_formal_parameter)
36920797-    <4c3bc60>   DW_AT_name        : (indirect string, offset:
0x137dc3): path
36920798-    <4c3bc64>   DW_AT_decl_file   : 1
36920799-    <4c3bc65>   DW_AT_decl_line   : 1275
36920800-    <4c3bc67>   DW_AT_decl_column : 47
36920801-    <4c3bc68>   DW_AT_type        : <0x4c22144>
36920802-    <4c3bc6c>   DW_AT_location    : 0x1b2122c (location list)
36920803-    <4c3bc70>   DW_AT_GNU_locviews: 0x1b21226


>
> thanks,
> jirka
>
