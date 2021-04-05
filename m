Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5ADE353C20
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 08:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhDEG5e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 02:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhDEG5d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Apr 2021 02:57:33 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADACC061756;
        Sun,  4 Apr 2021 23:57:28 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id v26so11093739iox.11;
        Sun, 04 Apr 2021 23:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=AZHjTjed6u2UeXoYIy7tUATVu3569TKkLAshxZkksoI=;
        b=igVAo6fnDCTJqwhA37hiBhfl4QnnL9lLQJmr6tUa1idULtAofbfQew/VU158PezfrZ
         uwrmsgfysCajWKmHaHq6f6mfr+8s2ZEK3nfYdEBZxgBI1JyPprm9O5qW/Nabe7zasYN+
         QBblSoompmBway4v45vEWWCQcV8PtrXbPChbg8Ss7SPHZIBmJkQqoHDmsscsu/CHP/te
         1G9hGbejpUGhI7Ph/hbNH5xbU0nSiD/BFxSrBnDFkA5emekkOhPEx6UFcCwXpQBMLCPM
         vKBCiAQxaeWYMz6HMqfEK9OmqWmGpYnyoL1cu1QcqgWuCp+ztbi4jirgr3K2Gl8+sux6
         GJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=AZHjTjed6u2UeXoYIy7tUATVu3569TKkLAshxZkksoI=;
        b=YQqApNZAkW3nA9Uvs4j6ngw1wgCh9gcxheUI7lFPqw1a4Vu9sgkG98Od8u6gry6Yjk
         Tf0gjJyt3v6IO838gBoVFC9cmbSdnFgAXDAcGm5vz+CLMcMDIqljdxivEoM4ClLsiA+E
         fhCYyIP9WroQyrfMFLRwH/K4w6+a+J/9bI88x/UO2zxv/i6FSPt83tVIy+1RQ/jmqNLu
         9BglgGrSqSJ/uVJiVB3/fBAqZItexrmVT0FIO2rCxr8lFZGwzcy28BNxRKzAbSLHoHVJ
         6gSWpGaL85qoXdZo3rkL94qhwHpwpuQyKvfBtbB1Ng2w1hDXtUY5jFqpiHs7Wp44fgvO
         XbpA==
X-Gm-Message-State: AOAM530fDpzuMOTQzw0KJ/RS2x3Hjmq+XJyLjkPz9r+oGaObRkvG4aLA
        u+Faq2JEtxPOM2HH7Bf1XwZMSu5mTlIoMohfPHY=
X-Google-Smtp-Source: ABdhPJzfiG69XaV250zUtNJdLxmmGZCs2pVuuAslb3sRFdQqRMhz2WBl+Lm8/VfH9vW7CiEY1KgXm1e+xcsFlShexpY=
X-Received: by 2002:a5d:9d13:: with SMTP id j19mr19131254ioj.110.1617605847757;
 Sun, 04 Apr 2021 23:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210403184158.2834387-1-yhs@fb.com> <CA+icZUWLf4W_1u_p4-Rx1OD7h_ydP4Xzv12tMA2HZqj9CCOH0Q@mail.gmail.com>
 <6c67f02a-3bc2-625a-3b05-7eb3533044bb@fb.com> <CA+icZUV4fw5GNXFnyOjvajkVFdPhkOrhr3rn5OrAKGujpSrmgQ@mail.gmail.com>
 <CA+icZUWh6YOkCKG72SndqUbQNwG+iottO4=cPyRRVjaHD2=0qw@mail.gmail.com>
 <f706e8b9-77ca-6341-db13-e2a74549576b@fb.com> <CA+icZUVb_J95Gk2Kf0i8waL6TDfJ2n9JrGbNK_dsN1n8HdcoXQ@mail.gmail.com>
 <CA+icZUVp3UTPUS-ZjCOnHbNXxaA7DN=4x_08jc8BExFe4Nf2ZQ@mail.gmail.com>
 <dfc28e40-5ce9-c6df-2e12-7840195ab570@fb.com> <CA+icZUVtzXNxuVtEUwfULa7nivV0VFfJznsRnSZtEh+V=C=RPg@mail.gmail.com>
In-Reply-To: <CA+icZUVtzXNxuVtEUwfULa7nivV0VFfJznsRnSZtEh+V=C=RPg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 5 Apr 2021 08:56:53 +0200
Message-ID: <CA+icZUX8RnBOA0Fg2a_rSYPSt4f65ggZ9HH66FB4dEztAcfzcQ@mail.gmail.com>
Subject: Re: [PATCH dwarves] dwarf_loader: handle DWARF5 DW_OP_addrx properly
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        David Blaikie <dblaikie@gmail.com>, kernel-team@fb.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 5, 2021 at 8:17 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Mon, Apr 5, 2021 at 4:31 AM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 4/4/21 5:20 PM, Sedat Dilek wrote:
> > > On Sun, Apr 4, 2021 at 7:25 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > [ ... ]
> > >>>> Yonghong Song as you described your build-environment and checking
> > >>>> requirements for clang-13 in bpf-next (see [1]), I am unsure if I want
> > >>>> to upgrade LLVM toolchain to v13-git and use bpf-next as the new
> > >>>> kernel base.
> > >>>> Lemme see if I get LLVM/Clang v13-git from Debian/experimental and/or
> > >>>> <apt.llvm.org>.
> > >>>
> > >>> If you want to run bpf-next, clang v13 definitely recommended.
> > >>> But I think if you use clang v13 to run linus linux, you may
> > >>> hit DWARF5 DW_OP_addrx as well. But unfortunately you will
> > >>> may hit a few selftest issues (e.g., BPF_TCP_CLOSE issue).
> > >>>
> > >>
> > >> OK, I started a fresh build with LLVM/Clang v13-git from <apt.llvm.org>...
> > >>
> > >> $ /usr/lib/llvm-13/bin/clang --version
> > >> Debian clang version
> > >> 13.0.0-++20210404092853+c4c511337247-1~exp1~20210404073605.3891
> > >> Target: x86_64-pc-linux-gnu
> > >> Thread model: posix
> > >> InstalledDir: /usr/lib/llvm-13/bin
> > >>
> > >> ...with latest bpf-next as new base.
> > >>
> > >> I applied your/this pahole patch "[PATCH dwarves] dwarf_loader: handle
> > >> DWARF5 DW_OP_addrx properly".
> > >>
> > >> Will report later...
> > >>
> > >
> > > Yupp, works.
> > >
> > > $ cat /proc/version
> > > Linux version 5.12.0-rc5-13-amd64-clang13-lto
> > > (sedat.dilek@gmail.com@iniza) (Debian clang version
> > > 13.0.0-++20210404092853+c4c511337247-1~exp1~20210404073605.3891, LLD
> > > 13.0.0) #13~bullseye+dileks1 SMP 2021-04-04
> > >
> > > MAKE="make V=1"
> > > MAKE_OPTS="LLVM=1 LLVM_IAS=1"
> > > MAKE_OPTS="$MAKE_OPTS PAHOLE=/opt/pahole/bin/pahole"
> > >
> > > $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/ 2>&1 | tee
> > > ../make-log_tools-testing-selftests-bpf_llvm-1-llvm_ias-1.txt
> > >
> > > dileks@iniza:~/src/linux-kernel/git/tools/testing/selftests/bpf$ sudo
> > > ./test_progs -n 55/2
> > > #55/2 subprog:OK
> > > #55 kfunc_call:OK
> > > Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > My linux-config and
> > > make-log_tools-testing-selftests-bpf_llvm-1_llvm_ias-1.txt.gz files
> > > are attached.
> > >
> > > Feel free to add my:
> > >
> > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v13-git (x86-64)
> >
> > Great! Thanks for the help to test the pahole/kernel patches.
> >
>
> Thank you Yonghong!
>
> I was able to do so with Linux v5.12-rc6 and some custom patches using
> LLVM/clang v12.0.0-rc4.
>
> Please see attachments.
>
> I applied this commit from bpf-next:
>
> commit 97a19caf1b1f6a9d4f620a9d51405a1973bd4641
> "bpf: net: Emit anonymous enum with BPF_TCP_CLOSE value explicitly"
>
> Link: https://git.kernel.org/bpf/bpf-next/c/97a19caf1b1f6a9d4f620a9d51405a1973bd4641
>
> Checking vmlinux.h:
>
> $ grep 'BPF_TCP_CLOSE ' tools/testing/selftests/bpf/tools/include/vmlinux.h
> 91929:  BPF_TCP_CLOSE = 7,
>
> Checking with test_progs:
>
> dileks@iniza:~/src/linux-kernel/git/tools/testing/selftests/bpf$ sudo
> ./test_progs -n 55/2
> #55/2 null_check:OK
> #55 ksyms_btf:OK
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Can we have this patch from bpf-next for Linus Git?
>

I am awfully sorry to have sent the make-log file uncompressed
(~1.1MiB) to the list.
Mea culpa.

- Sedat -
