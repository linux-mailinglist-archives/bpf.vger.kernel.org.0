Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00375649BE
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 22:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiGCUlB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 16:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGCUlA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 16:41:00 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB04E1150;
        Sun,  3 Jul 2022 13:40:59 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id w2-20020a056830110200b00616ce0dfcb2so6288666otq.1;
        Sun, 03 Jul 2022 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=vnMdHc9n06lEe86ZhIvCrTAOI1nFEwHvlgHZoZb6Zps=;
        b=Ncc5RY5GP0lkZ0q1Y3VIgAtdXoJlZhL4VHOYXZyDVZ2zyaP+eE25F5es7umKsKIejv
         pXW91Ig3PVyncOJmJinu/qdhpQORPTDaeTWGAIKdb4sySk8Q/fhk04WxUawtwZy9xxyG
         Me1A01MndoUPwaU/UowzCmtFTGvHrjluk/540Fa27rM1UIDeHY24fzY5LiHSli19hziy
         FYmAakP2uHo9A7FHaMgIPFu8u5KCfNgsgnEWN76banJiuPQqQyXeRnS9PgqW/CQCWoh6
         qNv9yWIefMMdF3jVNNj/cSPNZpLWc9cl7nUCdmMG2KaCxxp0g4VuNb3thCEZwUpkmYkP
         PPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=vnMdHc9n06lEe86ZhIvCrTAOI1nFEwHvlgHZoZb6Zps=;
        b=RlD/w6zz/5RIuAslNhFk7Ywy9ZHvJSINi5XvXVocsSovYk9slVYDQC18myQMdF6OQ6
         dW3uEyZEcEFM6KwUfhp3JTuNYAsJCRNVWWTDlNiBQR54EQkdX1nufCEtKSRWawZ3Jidq
         EXZhO+5C3BhlLOAjYASBzoErDkRVL9kGDVk+Zg8UGFggXregCXqFhVUJGmM9tv3IJdS2
         amYvNGcFRKtkmU1/owzm3FrMHDJzzHOdkmeGhdK1KGK3iFZEZiZFgPeTCXxVMxl0koEq
         1DrOsesABYkgJnpeHYgB7YoRlR5MmF4EuCl0rvyM2kBTFiKn034PYgqtkB7k2XXL6Ren
         fCVA==
X-Gm-Message-State: AJIora859gZXLGfIFZxnMVzROvWGQnnKHZ1O2FIuVRmLlI1MdOFdCzO3
        zuWWT67R/yl5XkwPLhFqf+IjV81c9m83ZpTT/MA=
X-Google-Smtp-Source: AGRyM1tqkbygJQELSpRQP1ufSQnbtjBaq8MVtGHbXMb4k8VpBRsRBP2Pl0YfxErKO81+fYNnqUY7OO7P4Ekzhq4sKqw=
X-Received: by 2002:a05:6830:1d5b:b0:616:de98:2556 with SMTP id
 p27-20020a0568301d5b00b00616de982556mr11847704oth.367.1656880859242; Sun, 03
 Jul 2022 13:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVVXq0Mh8=QuopF0tMZyZ0Tn8AiKEZoA3jfP47Q8B=x2A@mail.gmail.com>
 <CA+icZUW3VrDC8J4MnNb1H3nGYQggBwY4zOoaJkzSsNj7xKDvyQ@mail.gmail.com>
 <CA+icZUVcCMCGEaxytyJd_-Ur-Ey_gWyXx=tApo-SVUqbX_bhUA@mail.gmail.com>
 <CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com> <20220703165115.gox3hlwwdcnorcul@awork3.anarazel.de>
In-Reply-To: <20220703165115.gox3hlwwdcnorcul@awork3.anarazel.de>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 3 Jul 2022 22:40:22 +0200
Message-ID: <CA+icZUXCqzZgdSNyPwM+nmdTdPoZrQm2M=2DgOy7j_YHXQ1T6w@mail.gmail.com>
Subject: Re: [perf-tools] Build-error in tools/perf/util/annotate.c with LLVM-14
To:     Andres Freund <andres@anarazel.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 3, 2022 at 6:51 PM Andres Freund <andres@anarazel.de> wrote:
>
> Hi,
>
> On 2022-07-03 13:54:41 +0200, Sedat Dilek wrote:
> > Andres, you have some test-cases how you verified the built perf is OK?
>
> I ran an intentionally expensive workload, monitored it with bpftrace, then
> took a perf profile. Then annotated the bpf "function" and verified it looked
> the same before / after, using a perf built in a container (and thus
> compiling).
>
>
> Similar with bpftool, I dumped a jited program with a bpftool built with /
> without the patches (inside the container using nsenter for the version
> without the patches, so I could build it, using nsenter -t $pid -m -p) and
> compared both the json and non-json output before / after.
>
> V=4; nsenter -t 847325 -m -p /usr/src/linux/tools/bpf/bpftool/bpftool -j -d prog dump jited id 22 > /tmp/22.jit.json.$V; nsenter -t 847325 -m -p /usr/src/linux/tools/bpf/bpftool/bpftool -d prog dump jited id 22 > /tmp/22.jit.txt.$V
>
> and then diffed the results.
>
>
> bpf_jit_disasm was harder, because bpf_jit_enable = 2 is broken currently. So
> I gathered output in a VM from an older kernel, and used bpf_jit_disasm -f ...
> before / after the patches.
>

My test-case was to build a Linux v5.19-rc4 plus custom patches
including your v1 patchset.

Using my selfmade perf:

$ ~/bin/perf -vv
perf version 5.19.0-rc4
                dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
   dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
        syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
               libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
           debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
               libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
              libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
              libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
            libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
             libslang: [ on  ]  # HAVE_SLANG_SUPPORT
            libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
            libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
   libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                 zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                 lzma: [ on  ]  # HAVE_LZMA_SUPPORT
            get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                  bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                  aio: [ on  ]  # HAVE_AIO_SUPPORT
                 zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
              libpfm4: [ OFF ]  # HAVE_LIBPFM

make-line:

/home/dileks/bin/perf stat make V=1 -j4 LLVM=1 LLVM_IAS=1
PAHOLE=/opt/pahole/bin/pahole LOCALVERSION=-1-amd64-clang
14-lto KBUILD_BUILD_HOST=iniza KBUILD_BUILD_USER=sedat.dilek@gmail.com
KBUILD_BUILD_TIMESTAMP=2022-07-03 bindeb-pkg
KDEB_PKGVERSION=5.19.0~rc4-1~bookworm+dileks1

Performance counter stats for 'make V=1 -j4 LLVM=1 LLVM_IAS=1
PAHOLE=/opt/pahole/bin/pahole LOCALVERSION=-1-amd64-clang14-lto
KBUILD_BUILD_HOST=iniza KBUILD_BUILD_USER=sedat.dilek@gmail.com
KBUILD_BUILD_TIMESTAMP=2022-07-03 bindeb-pkg
KDEB_PKGVERSION=5.19.0~rc4-1~bookworm+dileks1':

      49180053.86 msec task-clock                #    3.371 CPUs
utilized
         11647016      context-switches          #  236.824 /sec
           341509      cpu-migrations            #    6.944 /sec
        341092829      page-faults               #    6.936 K/sec
   86858202428205      cycles                    #    1.766 GHz
   63272333662538      stalled-cycles-frontend   #   72.85% frontend
cycles idle
   45610931269521      stalled-cycles-backend    #   52.51% backend
cycles idle
   58841762567958      instructions              #    0.68  insn per
cycle
                                                 #    1.08  stalled
cycles per insn
   10469937534492      branches                  #  212.890 M/sec
     558492683589      branch-misses             #    5.33% of all
branches

  14587.639724247 seconds time elapsed

  45568.184531000 seconds user
   3656.227306000 seconds sys

Hmmm, it took a bit longer as usual.

But hey:

$ cat /proc/version
Linux version 5.19.0-rc4-1-amd64-clang14-lto
(sedat.dilek@gmail.com@iniza) (dileks clang version 14.0.5
(https://github.com/llvm/llvm-project.git
c12386ae247c0d46e1d513942e322e3a0510b126), LLD 14.0.5)
#1~bookworm+dileks1 SMP PREEMPT_DYNAMIC 2022-07-03

-Sedat-
