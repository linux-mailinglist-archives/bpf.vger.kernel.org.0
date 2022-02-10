Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FE44B18CA
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 23:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345226AbiBJWsd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 17:48:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242109AbiBJWsc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 17:48:32 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0288B6F
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 14:48:32 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id n5so5572513ilk.12
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 14:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gN3uyhBYhNBYnxHEDqr/rU4JCH4yxwE4bysb1m5eWzw=;
        b=lM92JG4It2aiJ3AMw1BLWgukIrWbgn8If6x8MBWjo9Q+LoIBSEsgnlwMCOxLiE+ded
         GOm3iXp337tJynsdjP6eXJIQlzh3zvlrlmB/Qt4p8+s9nUDOcROTg0/PyWOYUdIzyWTk
         cvxkDImLXzaYNq/gyFslSyO/4ZhE4j4nZXWzhoX0NofF9Tpy+wTc4h4aQ10n4sF+ZADb
         bRAyYNszQ4/zEQksD1k8pY0/4jX2Ez1j1bNyhiv2N04gAFd3MA809q7jVZbQQQPcnN2C
         GAKf0RdE8n3ATmgQRqDNkmFR7dXWaiwRlaCidkDt1S9uinTUu3s9NkPWZ31A/w+BWOZS
         1e3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gN3uyhBYhNBYnxHEDqr/rU4JCH4yxwE4bysb1m5eWzw=;
        b=Qhbi/rqjrBel72UXNC2TLZ+9aMP/jAsqxdzDpqju5QPkEsSmQ6s58feTnM53wVAqCQ
         U1ta8h2EUgo5AYqLojls5DTmVE6YAaoVmh1V1nX3vupBOD98xGoU7a6WgJZXtwrTYCua
         jf8RTyFHYuMdct68RtHYO4AZhpv6uRsRj3C3zPBDJtKXTJogrW8oUDODE9qty3PvZeJD
         6YutdCG1yLdqO0ExBs38cbxL7UlMfubp5iOX4Ap0ghHncv9onXxxJaqEvaj2jggcqJ3E
         oGYLJnvaivq+aTN56p6xFZAfh3lbaKw0s4+rz1KHeenBs8acUMjiGqhtGcm74q9cSAiP
         AHQQ==
X-Gm-Message-State: AOAM532ln77IvioqtEc7778TofGg6l+jmG/6AGhRNxIyKuvQqr8dS1jh
        o9291LliFRHJUrqPB3gW9pUmTwp59OcbrylBpcY=
X-Google-Smtp-Source: ABdhPJyeinOqPfdgYBS/2HmtTnxie4GO4JGRUyX3K4voCHGq5kKrtRUwJXO76sn6XJ+9B7A2g7j4D4TnGNBTb9dprVA=
X-Received: by 2002:a05:6e02:1a6c:: with SMTP id w12mr5132678ilv.305.1644533312253;
 Thu, 10 Feb 2022 14:48:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644453291.git.delyank@fb.com> <2d1f85c9-8f78-226b-90b6-f6805400eb9f@fb.com>
In-Reply-To: <2d1f85c9-8f78-226b-90b6-f6805400eb9f@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Feb 2022 14:48:21 -0800
Message-ID: <CAEf4BzbuwFM-p000i=DQ0HgfCLs=2-yw6CDwJW8p_m7fmzsZBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] Avoid typedef size mismatches in skeletons
To:     Yonghong Song <yhs@fb.com>
Cc:     Delyan Kratunov <delyank@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Thu, Feb 10, 2022 at 2:18 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/9/22 4:36 PM, Delyan Kratunov wrote:
> > As reported in [0], kernel and userspace can sometimes disagree
> > on the definition of a typedef (in particular, the size).
> > This leads to trouble when userspace maps the memory of a bpf program
> > and reads/writes to it assuming a different memory layout.
> >
> > This series resolves most int-like typedefs and rewrites them as
> > standard int16_t-like types. In particular, we don't touch
> > __u32-like types, char, and _Bool, as changing them changes cast
> > semantics and would break too many pre-existing programs. For example,
> > int8_t* is not convertible to char* because int8_t is explicitly signed.
>
> Build with clang (adding LLVM=1 to build kernel and selftests),
> several btf_dump subtests failed. Please take a look.
>
> btf_dump_data:PASS:find type id 0 nsec
> btf_dump_data:PASS:failed/unexpected type_sz 0 nsec
> btf_dump_data:FAIL:ensure expected/actual match unexpected ensure
> expected/actual match: actual '(int32_t)1234' != expected '(int)1234'
> btf_dump_data:PASS:find type id 0 nsec
> btf_dump_data:PASS:failed/unexpected type_sz 0 nsec
> btf_dump_data:PASS:ensure expected/actual match 0 nsec
> btf_dump_data:PASS:find type id 0 nsec
> btf_dump_data:PASS:failed/unexpected type_sz 0 nsec
> btf_dump_data:FAIL:ensure expected/actual match unexpected ensure
> expected/actual match: actual '(int32_t)1234' != expected '(int)1234'
> btf_dump_data:PASS:find type id 0 nsec
> btf_dump_data:PASS:failed/unexpected type_sz 0 nsec
> btf_dump_data:FAIL:ensure expected/actual match unexpected ensure
> expected/actual match: actual '(int32_t)0' != expected '(int)0'
> ...
> btf_dump_data:FAIL:ensure expected/actual match unexpected ensure
> expected/actual match: actual '(uint128_t)0xffffffffffffffff' !=
> expected '(unsigned __int128)0xffffffffffffffff'
> btf_dump_data:PASS:find type id 0 nsec
> btf_dump_data:PASS:failed/unexpected type_sz 0 nsec
> btf_dump_data:FAIL:ensure expected/actual match unexpected ensure
> expected/actual match: actual
> '(uint128_t)0xfffffffffffffffffffffffffffffffe' != expected '(unsigned
> __int128)0xfffffffffffffffffffffffffffff'
> test_btf_dump_int_data:FAIL:dump unsigned __int128 unexpected error: -14
> (errno 7)
> #20/9 btf_dump/btf_dump: int_data:FAIL
> ...
> btf_dump_data:FAIL:ensure expected/actual match unexpected ensure
> expected/actual match: actual '(uint64_t)1' != expected '(u64)1'
> btf_dump_data:PASS:find type id 0 nsec
> btf_dump_data:PASS:failed/unexpected type_sz 0 nsec
> btf_dump_data:FAIL:ensure expected/actual match unexpected ensure
> expected/actual match: actual '(uint64_t)0' != expected '(u64)0'
> btf_dump_data:PASS:find type id 0 nsec
> ...
> btf_dump_data:FAIL:ensure expected/actual match unexpected ensure
> expected/actual match: actual '(atomic_t){
>          .counter = (int32_t)0,
> }' != expected '(atomic_t){
>          .counter = (int)0,
> }'
> btf_dump_data:PASS:find type id 0 nsec
> btf_dump_data:PASS:failed to return -E2BIG 0 nsec
> btf_dump_data:PASS:ensure expected/actual match 0 nsec
> #20/12 btf_dump/btf_dump: typedef_data:FAIL
> ...
> test_btf_dump_struct_data:FAIL:file_operations unexpected
> file_operations: actual '(struct file_operations){
>          .owner = (struct module *)0xffffffffffffffff,
>          .llseek = (int64_t (*)(struct file *, int64_t,
> int32_t))0xfffffffffff' != expected '(struct file_operations){
>          .owner = (struct module *)0xffffffffffffffff,
>          .llseek = (loff_t (*)(struct file *, loff_t,
> int))0xffffffffffffffff,'
> ...
> ...
>

This is due to unconditional normalization in
btf_dump_emit_type_cast(), we shouldn't do it. So this will "autofix"
itself when we fix that issue.

> >
> >    [0]: https://github.com/iovisor/bcc/pull/3777
> >
> > Delyan Kratunov (3):
> >    libbpf: btf_dump can produce explicitly sized ints
> >    bpftool: skeleton uses explicitly sized ints
> >    selftests/bpf: add test case for userspace and bpf type size mismatch
> >
> >   tools/bpf/bpftool/gen.c                       |  3 +
> >   tools/lib/bpf/btf.h                           |  4 +-
> >   tools/lib/bpf/btf_dump.c                      | 80 ++++++++++++++++++-
> >   .../selftests/bpf/prog_tests/skeleton.c       | 22 +++--
> >   .../selftests/bpf/progs/test_skeleton.c       |  8 ++
> >   5 files changed, 107 insertions(+), 10 deletions(-)
> >
> > --
> > 2.34.1
