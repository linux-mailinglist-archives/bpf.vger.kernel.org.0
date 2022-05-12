Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33AF5257FF
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 00:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359307AbiELWti (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 18:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359306AbiELWtg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 18:49:36 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFE12854A6;
        Thu, 12 May 2022 15:49:35 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id l15so4576064ilh.3;
        Thu, 12 May 2022 15:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENMBU/SUx1kqBZ6B9y2Wkt9q5CDmGboIAvjJKQ3EDI4=;
        b=H0+KRJrEuECxhYhCWCEsN5DAWeWL8NWdOVkEbaHLVpSHQp3sS22xrzI/WXnO0A+JsQ
         loP8PrEo4AGkc52ctJ+/GlVx1LmXHBC9cl8nKNbBNDexhQ6BgyeuAuOxAzLaRMqD1J61
         UrvdjI6ZsJWSEhG6gsEY8oksZwoLrCboFAld6quQzqUt8irYhVzNOrCH7vs0eIb/9LcH
         yqf6v4NW9UqTWA/8GMZ7jMbvzsSxNfaYt+YLAtVpxlQb8J5upJXdrN3b0nKKMNJ/cHwH
         3Z0oGays/jlRw2ok8jejDPdQ05rFXggmRWqssy78v+bb4zluuTtKFtTk0rRDf2Lt1Xjs
         +7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENMBU/SUx1kqBZ6B9y2Wkt9q5CDmGboIAvjJKQ3EDI4=;
        b=ZB8vOuYW+0rKhkjc4VFRW5xTs1gZBbvuQDdHOixkuUQ0a+JKbtnQS0W9o/o7TzT0yA
         zAbOqG4cN0PBdFs16V8uLiSlyp+Qy3/+mtm/K7E0gAFwZ8TUGLfN+8Q4pgVXz1QvF7K6
         FprYNM+QVktb8C4qbdXUE3OvUvX2aZGYHKXbyHZ5GHpgB+ZUgchZoFhfaG2UKxF7baUP
         cMZHwjNoWQjwzpOyL+PPiTalzbaQkVfCOibSibK/wiAha5rBijg6lDxYx0xkeu12Ewtu
         pyyRDpcpKFyEttl5KtiAg5WW4navBTpE2i9K4McTCHnTgLbDVJ8vmPT2PsSEJ9Ijq/b8
         KAXA==
X-Gm-Message-State: AOAM531Ed2gczKZzXAZNzDvXNPSOTTYUmm4slJHMpjSql27B9HlJ3IfK
        pRDMZRXQnHaIKFr0nfz1xrJfBEctKDgpDuKhzKUlkZmM
X-Google-Smtp-Source: ABdhPJwS/AyowFSoijOIGMBlQxWt2q/jZUJq4ZjmbEbbp172ZlWEOHPoRhu6a3FTwwtH09FRbihbTACMgsTAzFGhxoY=
X-Received: by 2002:a05:6e02:1d8d:b0:2cf:2112:2267 with SMTP id
 h13-20020a056e021d8d00b002cf21122267mr1126500ila.239.1652395774708; Thu, 12
 May 2022 15:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220511220243.525215-1-yhs@fb.com> <20220511220249.525908-1-yhs@fb.com>
 <CAEf4BzZgby0RDcXXwHtB+zxof3Gmgn+EUnbeEyYOshb7dfbzyA@mail.gmail.com> <366cdcf9-3f94-6ac0-aebb-ceda500ab89a@fb.com>
In-Reply-To: <366cdcf9-3f94-6ac0-aebb-ceda500ab89a@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 May 2022 15:49:23 -0700
Message-ID: <CAEf4Bzbf1uPqJ+BzQLtvS3ye=Xv1Gbo8n1uOkc8iZ3RDNDUhyg@mail.gmail.com>
Subject: Re: [PATCH dwarves 2/2] btf_encoder: Normalize array index type for
 parallel dwarf loading case
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 11, 2022 at 9:13 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 5/11/22 5:32 PM, Andrii Nakryiko wrote:
> > On Wed, May 11, 2022 at 3:02 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> With latest llvm15 built kernel (make -j LLVM=1), I hit the following
> >> error when build selftests (make -C tools/testing/selftests/bpf -j LLVM=1):
> >>    In file included from skeleton/pid_iter.bpf.c:3:
> >>    .../selftests/bpf/tools/build/bpftool/vmlinux.h:84050:9: error: unknown type name
> >>         '__builtin_va_list___2'; did you mean '__builtin_va_list'?
> >>    typedef __builtin_va_list___2 va_list___2;
> >>            ^~~~~~~~~~~~~~~~~~~~~
> >>            __builtin_va_list
> >>    note: '__builtin_va_list' declared here
> >>    In file included from skeleton/profiler.bpf.c:3:
> >>    .../selftests/bpf/tools/build/bpftool/vmlinux.h:84050:9: error: unknown type name
> >>         '__builtin_va_list__ _2'; did you mean '__builtin_va_list'?
> >>    typedef __builtin_va_list___2 va_list___2;
> >>            ^~~~~~~~~~~~~~~~~~~~~
> >>            __builtin_va_list
> >>    note: '__builtin_va_list' declared here
> >>
> >> The error can be easily explained with after-dedup vmlinux btf:
> >>    [21] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> >>    [2300] STRUCT '__va_list_tag' size=24 vlen=4
> >>          'gp_offset' type_id=2 bits_offset=0
> >>          'fp_offset' type_id=2 bits_offset=32
> >>          'overflow_arg_area' type_id=32 bits_offset=64
> >>          'reg_save_area' type_id=32 bits_offset=128
> >>    [2308] TYPEDEF 'va_list' type_id=2309
> >>    [2309] TYPEDEF '__builtin_va_list' type_id=2310
> >>    [2310] ARRAY '(anon)' type_id=2300 index_type_id=21 nr_elems=1
> >>
> >>    [5289] PTR '(anon)' type_id=2308
> >>    [158520] STRUCT 'warn_args' size=32 vlen=2
> >>          'fmt' type_id=14 bits_offset=0
> >>          'args' type_id=2308 bits_offset=64
> >>    [27299] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> >>    [34590] TYPEDEF '__builtin_va_list' type_id=34591
> >>    [34591] ARRAY '(anon)' type_id=2300 index_type_id=27299 nr_elems=1
> >>
> >> The typedef __builtin_va_list is a builtin type for the compiler.
> >> In the above case, two typedef __builtin_va_list are generated.
> >> The reason is due to different array index_type_id. This happened
> >> when pahole is running with more than one jobs when parsing dwarf
> >> and generating btfs.
> >>
> >> Function btf_encoder__encode_cu() is used to do btf encoding for
> >> each cu. The function will try to find an "int" type for the cu
> >> if it is available, otherwise, it will create a special type
> >> with name __ARRAY_SIZE_TYPE__. For example,
> >>    file1: yes 'int' type
> >>    file2: no 'int' type
> >>
> >> In serial mode, file1 is processed first, followed by file2.
> >> both will have 'int' type as the array index type since file2
> >> will inherit the index type from file1.
> >>
> >> In parallel mode though, arrays in file1 will have index type 'int',
> >> and arrays in file2 wil have index type '__ARRAY_SIZE_TYPE__'.
> >> This will prevent some legitimate dedup and may have generated
> >> vmlinux.h having compilation error.
> >>
> >
> > I think it is two separate problems.
> >
> > 1. Maybe instead of this generating __ARRAY_SIZE_TYPE__ we should
> > generate proper 'int' type?
>
> This should work. Will post v2 with this.
>
> >
> > 2. __builtin_va_list___2 shouldn't have happened, it's libbpf bug.
> > Libbpf handles __builtin_va_list specially (see
> > btf_dump_is_blacklisted()), so we need to fix libbpf to not get
> > confused if there are two __builtin_va_list copies in BTF.
>
> I checked code. the libbpf prevents generating
>     typedef <...> __builtin_va_list
> since __builtin_va_list is a builtin type.
>
> Here, due to __ARRAY_SIZE_TYPE__ problem, the following are generated
> in vmlinux.h.
>
> typedef __builtin_va_list va_list;
> typedef __builtin_va_list___2 va_list___2;
>
> since __builtin_va_list appears twice in the BTF.
> But due to the libbpf implementation to skip
>     typedef <...> __builtin_va_list
>
> We don't have __builtin_va_list___2 defined and this
> caused compilation error.
>
> Although we could workaround the issue in libbpf
> such that if the typedef is in the format of
>    typedef __builtin_va_list<...> <other_type>
> we should just emit
>    typedef __builtin_va_list <other_type>
>
> But fixing the issue in pahole is much better since
> we won't have va_list___2 any more.

Sounds good, let's do it in pahole, thanks!

>
> >
> >> This patch fixed the issue by normalizing all array_index types
> >> to be the first array_index type in the whole btf.
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   btf_encoder.c | 24 +++++++++++++++++++++---
> >>   btf_encoder.h |  2 +-
> >>   pahole.c      |  2 +-
> >>   3 files changed, 23 insertions(+), 5 deletions(-)
> >>
> >
> > [...]
