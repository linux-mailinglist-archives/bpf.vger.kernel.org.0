Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AD56F7220
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEDSuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 14:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDSuW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 14:50:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B56859FB;
        Thu,  4 May 2023 11:50:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so20236240a12.0;
        Thu, 04 May 2023 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683226220; x=1685818220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edJ8JLxHdVmfwm25SDvTJnz/EoID7nCi8CNvbRMsr/Y=;
        b=HxyUUBEfrNH5+wdQIphnaH4JkB8Qm+HXNhXQrIdD1YlKC6+E23iqMKXUzLeqX8RgaG
         3mcS8X3Iz+zi3sHXrz6RQcGMG1vVcUmKuw3s5jiC1eApSYToTo2qTU69u8Dg2D9hmzUl
         b0gXDCLDrzGP+tGLwiLKfgrvBMCseMU9vSvCNjW4j13iqN+x7P+fDfjVldVvuiZYV8bO
         Tv7t7v7PjJ1ergexjbbTaUPdTyBDAHCfBlkxfJlIDNXzqgCOM9nG6c6jaqH/tIprdi/D
         7C396sHI9PMxUtYD7vvRNgpBPlCLOKnJMY5G8h4Pzke3/IdF2U3Fshi2/xj8yeFmNu8y
         tcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683226220; x=1685818220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edJ8JLxHdVmfwm25SDvTJnz/EoID7nCi8CNvbRMsr/Y=;
        b=lwA7KiZTOiZ4rEQmTGmGAREwdmOE9ErP+qacwpr+VMhJI85Fw1abhSAu5zchN6qByY
         mWeMcL+sUrQgML0TFyRfDZ/T3RVGs68DWYRghKSfqO6+gGjWsFFFzOmH6EVhYqWXUGcO
         SiWbjM8Bit2ltw297mLlDrhRb6V5FDGdI0L8e4uWiQL9opNHKlOU3Pu3eYY/1G1ySonQ
         WbRhFjl6RR1S4FgmFLstqYjL4AxnldRPbBCZ1G2Bi0VCdRwSUVTAWENDZLQJzOUXJsZA
         YRmxzc1hoKqY0+66rWZerFYN+GmupQqn/68aJl+NhGxGqp3LUEC/AkCywWJlMgyrHdVY
         uWFw==
X-Gm-Message-State: AC+VfDzijT+kda8WjhDUf5D0EKmyNunx6C5rbS+dpq82gu/5U9oXh1Jq
        L2iI4WDWu/A2HQc1IrDpZLAZRfbBW+6IpmXP94M=
X-Google-Smtp-Source: ACHHUZ52x83gTQbqorZt8NGXn7JbLU/aP4toWSIImadejp+0ctw/o0wBBwgz0Lun7/jvdNMDfvSgB0zi9Fzvzd/kBzo=
X-Received: by 2002:a17:907:36c6:b0:94f:432f:243d with SMTP id
 bj6-20020a17090736c600b0094f432f243dmr6222943ejc.17.1683226219529; Thu, 04
 May 2023 11:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230503211801.897735-1-acme@kernel.org> <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org> <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org>
In-Reply-To: <ZFPw0scDq1eIzfHr@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 May 2023 11:50:07 -0700
Message-ID: <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
Subject: Re: BPF skels in perf .Re: [GIT PULL] perf tools changes for v6.4
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Song Liu <song@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 4, 2023 at 10:52=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, May 04, 2023 at 10:25:30AM -0700, Linus Torvalds escreveu:
> > On Thu, May 4, 2023 at 4:09=E2=80=AFAM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > > Does building runqslower works for you in this same environment where
> > > building perf failed?
>
> > I don't know, and I don't care. I've never used that thing, and I'm
> > not going to.
>
> > And it's irrelevant. Two wrongs do not make a right.
>
> > I'm going to ignore perf tools pulls going forward if this is the kind
> > of argument for garbage that you use.
>
> > Because a billion flies *can* be wrong.
>
> I pushed two reverts there that make this back into a
> opt-in/experimental feature till we fix the issue you reported:
>
> =E2=AC=A2[acme@toolbox perf-tools]$ git log --oneline -3
> e7b7a54767a71c67 (HEAD -> perf-tools, acme/perf-tools) Revert "perf build=
: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL"
> 6957bdf37a1e6eca Revert "perf build: Warn for BPF skeletons if endian mis=
matches"
> 1f85d016768ff19f (tag: perf-tools-for-v6.4-1-2023-05-03) perf test record=
+probe_libc_inet_pton: Fix call chain match on x86_64
> =E2=AC=A2[acme@toolbox perf-tools]$
>
> Its in:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-tools
>
> Using a vmlinux.h file built by bpftool from the BTF info, be it in a
> vmlinux file or in /sys/kernel/btf/vmlinux (a RAW BTF file) is used for
> building the BPF bytecode, using clang:
>
> =E2=AC=A2[acme@toolbox perf-tools]$ head tools/perf/util/bpf_skel/sample_=
filter.bpf.c
> // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> // Copyright (c) 2023 Google
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
> #include <bpf/bpf_core_read.h>
>
> #include "sample-filter.h"
>
> /* BPF map that will be filled by user space */
> =E2=AC=A2[acme@toolbox perf-tools]$
>
> So that it can access kernel types and store the type info for those
> types together with the BPF bytecode, as BTF info, and later use this
> and relocation records for libbpf to be able to adjust things when
> accessed data structures change in the kernel and needs adjustments
> based in both the kernel BTF info (/sys/kernel/btf/vmlinux) and the
> BPF bytecode being loaded (in its .BTF ELF section).
>
> Andrii, can you add some more information about the usage of vmlinux.h
> instead of using kernel headers?
>

I'll just say that vmlinux.h is not a hard requirement to build BPF
programs, it's more a convenience allowing easy access to definitions
of both UAPI and kernel-internal structures for tracing needs and
marking them relocatable using BPF CO-RE machinery. Lots of real-world
applications just check-in pregenerated vmlinux.h to avoid build-time
dependency on up-to-date host kernel and such.

If vmlinux.h generation and usage is causing issues, though, given
that perf's BPF programs don't seem to be using many different kernel
types, it might be a better option to just use UAPI headers for public
kernel type definitions, and just define CO-RE-relocatable minimal
definitions locally in perf's BPF code for the other types necessary.
E.g., if perf needs only pid and tgid from task_struct, this would
suffice:

struct task_struct {
    int pid;
    int tgid;
} __attribute__((preserve_access_index));

> - Arnaldo
