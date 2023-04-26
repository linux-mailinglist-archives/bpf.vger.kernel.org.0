Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AB16EFAA9
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 21:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbjDZTKV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 15:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbjDZTKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 15:10:19 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D19F9009
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:10:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5083bd8e226so11607210a12.3
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682536211; x=1685128211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGAD6T1FsTHwhyo8AVPwV81omOQ+UiO/ojSlis48zxE=;
        b=Rcf0V8E3y6eFEjZKuGWl1vkYhQM7adcFVse/uu3Hz3UrgVSB3Br511UmsDhch32XnA
         +dO3IgnVKdBhhsUHynDys/YrSCr+u3fOEaEY/k2D2hnJazJ6OtHa2F9lqvIK4lbTXy0q
         b4yDa6z1EXszOYqc2GbixVpoW1Emn8Dir8mc4tMgf8j/x6D1iCZ5ZuuZg0ejHxRXQHk2
         2yaWXh1jnsSyPqVvIQ4FKflR+r/7XvMCBu/vyuFXHgMw86TIttuilb0jqb8FCXZ60+3M
         oaIKYY3LGEL3u7dllKfPOyEdZlXVVdfyjIIyDlcdhixGXu0oPFK5bpuS13uIGfTZOO14
         IzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682536211; x=1685128211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGAD6T1FsTHwhyo8AVPwV81omOQ+UiO/ojSlis48zxE=;
        b=AXqdJG3Aa8/kmMrjbVSaHnKonq8xbLlUm2uKQmdiVsVpukEhhMg+pMXne5Qxv7AIS8
         yd06xPjXKX+VDZjDlV2r2HsuN19vICD+TKyRTSLg49W3mnjPAsZbVLFF28eAiHlpw7AO
         DF7Q83Eueqs6SMlD/g029xaoWFaSN/GXxfr/X3QJtg3ogC8xtLRGFsAKMxp1cjW+Qs/j
         KXq+ewzyiZx2kaagHJF/oTyMp8A+66Y5BcGnQvVZ72oPHMYckPdWM2JLJPLmKtJ+KAmC
         ZTDGk0gDs0KZo7ySa4R7r2obQPfuC47cmOt+13kIzi6/3wuW+pDJ1ExYSg688hWgWdBi
         Ix/A==
X-Gm-Message-State: AAQBX9ckfiex/blyltWWgtuCdDgKuQurgss0CdjaHBD6a9Lt5BkKxRgA
        SbAK4TmI57WwmI3sergVHt0Y1NZ3S2Xe0bK4T5I=
X-Google-Smtp-Source: AKy350apNq7Zbv4K0oEI4LWFV8/Mz8TNdfuWe3XuFGPQs/hmmFyC8K2ytoNV2goU88hjARX2y9A9kkL/izXij8gNlUk=
X-Received: by 2002:aa7:c859:0:b0:505:745:a271 with SMTP id
 g25-20020aa7c859000000b005050745a271mr19773418edt.23.1682536211553; Wed, 26
 Apr 2023 12:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org>
In-Reply-To: <20230424160447.2005755-1-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 12:09:59 -0700
Message-ID: <CAEf4BzbCogCFVmr-C4XQNR4KF3_kj_yFeeTcevdmfm1veu-26w@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 00/20] bpf: Add multi uprobe link
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Viktor Malik <viktor.malik@gmail.com>,
        Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 24, 2023 at 9:04=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> this patchset is adding support to attach multiple uprobes and usdt probe=
s
> through new uprobe_multi link.
>
> The current uprobe is attached through the perf event and attaching many
> uprobes takes a lot of time because of that.
>
> The main reason is that we need to install perf event for each probed fun=
ction
> and profile shows perf event installation (perf_install_in_context) as cu=
lprit.
>
> The new uprobe_multi link just creates raw uprobes and attaches the bpf
> program to them without perf event being involved.
>
> In addition to being faster we also save file descriptors. For the curren=
t
> uprobe attach we use extra perf event fd for each probed function. The ne=
w
> link just need one fd that covers all the functions we are attaching to.

All of the above are good reasons and thanks for tackling multi-uprobe!

>
> By dropping perf we lose the ability to attach uprobe to specific pid.
> We can workaround that by having pid check directly in the bpf program,
> but we might need to check for another solution if that will turn out
> to be a problem.
>

I think this is a big deal, because it makes multi-uprobe not a
drop-in replacement for normal uprobes even for typical scenarios. It
might be why you couldn't do transparent use of uprobe.multi in USDT?

But I'm not sure why this is a problem? How does perf handle this?
Does it do runtime filtering or something more efficient that prevents
uprobe to be triggered for other PIDs in the first place? If it's the
former, then why can't we do the same simple check ourselves if pid
filter is specified?

I also see that uprobe_consumer has filter callback, not sure if it's
a better solution just for pid filtering, but might be another way to
do this?


Another aspect I wanted to discuss (and I don't know the right answer)
was whether we need to support separate binary path for each offset?
It would simplify (and trim down memory usage significantly) a bunch
of internals if we knew we are dealing with single inode for each
multi-uprobe link. I'm trying to think if it would be limiting in
practice to have to create link per each binary, and so far it seems
like usually user-space code will do symbol resolution per ELF file
anyways, so doesn't seem limiting to have single path + multiple
offsets/cookies within that file. For USDTs use case even ref_ctr is
probably the same, but I'd keep it 1:1 with offset and cookie anyways.
For uniformity and generality.

WDYT?

>
> Attaching current bpftrace to 1000 uprobes:
>
>   # BPFTRACE_MAX_PROBES=3D100000 perf stat -e cycles,instructions \
>     ./bpftrace -e 'uprobe:./uprobe_multi:uprobe_multi_func_* { }, i:ms:1 =
{ exit(); }'
>     ...
>
>      126,666,390,509      cycles
>       29,973,207,307      instructions                     #    0.24  ins=
n per cycle
>
>         85.284833554 seconds time elapsed
>
>
> Same bpftrace setup with uprobe_multi support:
>
>   # perf stat -e cycles,instructions \
>     ./bpftrace -e 'uprobe:./uprobe_multi:uprobe_multi_func_* { }, i:ms:1 =
{ exit(); }'
>     ...
>
>        6,818,470,649      cycles
>       13,275,510,122      instructions                     #    1.95  ins=
n per cycle
>
>          1.943269451 seconds time elapsed
>
>
> I'm sending this as RFC because of:
>   - I added/exported some new elf_* helper functions in libbpf,
>     and I'm not sure that's the best/right way of doing this

didn't get to that yet, sounds suspicious :)

>   - I'm not completely sure about the usdt integration in bpf_program__at=
tach_usdt,
>     I was trying to detect uprobe_multi kernel support first, but ended u=
p with
>     just new field for struct bpf_usdt_opts

haven't gotten to this yet as well, but it has to be auto-detectable,
not an option (at least I don't see why it wouldn't be, but let me get
to the patch)

>   - I plan to add more tests for usdt probes defined with refctr
>
>
> Also available at:
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   uprobe_multi
>
> There are PRs for tetragon [1] and bpftrace [2] support.
>
> thanks,
> jirka
>
>
> [1] https://github.com/cilium/tetragon/pull/936
> [2] https://github.com/olsajiri/bpftrace/tree/uprobe_multi
>
> Cc: Viktor Malik <viktor.malik@gmail.com>
> Cc: Daniel Xu <dxu@dxuuu.xyz>
> ---
> Jiri Olsa (20):
>       bpf: Add multi uprobe link
>       bpf: Add cookies support for uprobe_multi link
>       bpf: Add bpf_get_func_ip helper support for uprobe link
>       libbpf: Update uapi bpf.h tools header
>       libbpf: Add uprobe_multi attach type and link names
>       libbpf: Factor elf_for_each_symbol function
>       libbpf: Add elf_find_multi_func_offset function
>       libbpf: Add elf_find_patern_func_offset function
>       libbpf: Add bpf_link_create support for multi uprobes
>       libbpf: Add bpf_program__attach_uprobe_multi_opts function
>       libbpf: Add support for uprobe.multi/uprobe.multi program sections
>       libbpf: Add uprobe multi link support to bpf_program__attach_usdt
>       selftests/bpf: Add uprobe_multi skel test
>       selftests/bpf: Add uprobe_multi api test
>       selftests/bpf: Add uprobe_multi link test
>       selftests/bpf: Add uprobe_multi test program
>       selftests/bpf: Add uprobe_multi bench test
>       selftests/bpf: Add usdt_multi test program
>       selftests/bpf: Add usdt_multi bench test
>       selftests/bpf: Add uprobe_multi cookie test
>
>  include/linux/trace_events.h                               |   6 +
>  include/uapi/linux/bpf.h                                   |  15 +++
>  kernel/bpf/syscall.c                                       |  18 ++-
>  kernel/trace/bpf_trace.c                                   | 310 +++++++=
++++++++++++++++++++++++++++++++++++-
>  tools/include/uapi/linux/bpf.h                             |  15 +++
>  tools/lib/bpf/bpf.c                                        |  10 ++
>  tools/lib/bpf/bpf.h                                        |  10 +-
>  tools/lib/bpf/libbpf.c                                     | 653 +++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-=
----------
>  tools/lib/bpf/libbpf.h                                     |  43 ++++++
>  tools/lib/bpf/libbpf.map                                   |   3 +
>  tools/lib/bpf/libbpf_internal.h                            |   2 +-
>  tools/lib/bpf/usdt.c                                       | 127 +++++++=
++++++-----
>  tools/testing/selftests/bpf/Makefile                       |  10 ++
>  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c        |  78 +++++++=
++++
>  tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 286 +++++++=
+++++++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/uprobe_multi.c           |  72 +++++++=
++++
>  tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c      |  16 +++
>  tools/testing/selftests/bpf/uprobe_multi.c                 |  53 +++++++=
+
>  tools/testing/selftests/bpf/usdt_multi.c                   |  23 ++++
>  19 files changed, 1634 insertions(+), 116 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_multi_t=
est.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
>  create mode 100644 tools/testing/selftests/bpf/uprobe_multi.c
>  create mode 100644 tools/testing/selftests/bpf/usdt_multi.c
