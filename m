Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F9059529D
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 08:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiHPGh6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 02:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiHPGhk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 02:37:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0747A16304F
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 20:27:13 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dc19so16623710ejb.12
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 20:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ci9V0ccH7yrdscDREP9JziE1sny4lsTm9XGKbaKxzsE=;
        b=AWAof5gHQz0xpGuyBT2QgdnmvwmRWHIEynw3oQgIJqIsK3CNb4xJe+gU0jPpvrttOa
         kGmfDHe6Ys8ooFwxLTe9OT5ZVuBJpWKB48FBGQ8kccCD8ZXayDGPy7Nk59wi5SeHBTy+
         zz5Mth61HPXpu3s5u+yxCHmE2seoKtOFqxLcnVFjb92Z/hOMiV00JRin2Mpij5FqOIJs
         SLSZ/Vm73qURJTy/AHcQck/U73yYonIYFqhry4bOJNo8kkoCyIqMn7374fC35ddP6Pyu
         ssh0jzHk4au1xfcVgQGz7S1V870FKncspYXg9NsjEqkWqXtkhNpxgE+Ghv9inzts6Tp0
         wiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ci9V0ccH7yrdscDREP9JziE1sny4lsTm9XGKbaKxzsE=;
        b=SrV+HTYbSzLV+6bUR5fblOlBPN08IVoD/cuhBvjdBmDII2NT+kkFBH8q41R5ZF2Fs6
         VPWCvN1ingkNGGEMssmvFothaha22hOTOpRJZhdhudD/jgBJBd5frbsgKPkWrh+lXgH+
         cy3yJlGLrnKBVWVorvZizfKC7BfDbvOkO/4EX+7bV7Sco80o+EVsbajlrHWlZkybi4Wp
         ukvWu/TLgQ1Bo/rMVHBm68tacgK/TrGdUn9jo1OQFyDN0I+Ime+gtiY/3Y469hff2sdt
         jBBFxpxLow2Zs+jEvULfkUOpA11rmVv/QGjH6eEtndhPSMcy+dBthtviNvOziG3o21bL
         E2LA==
X-Gm-Message-State: ACgBeo2qLfmvYqIr6la8NDAenihxjYZ+8wu7oLqBCV14VnDRQ8N9oaGG
        7a3KC/tp85nVLv+2iDZtMXIdHRAiQeE7uSDSEsE=
X-Google-Smtp-Source: AA6agR6OF0dOaiYdXXon1R3LWzSvArgxp5jMPL0Sb1Ke/3PqGV8ka5UrihCw47wUh00gu+K8FpGxSCync2Q6IENAL+w=
X-Received: by 2002:a17:907:3d90:b0:730:a937:fb04 with SMTP id
 he16-20020a1709073d9000b00730a937fb04mr12437332ejc.176.1660620431604; Mon, 15
 Aug 2022 20:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220811091526.172610-1-jolsa@kernel.org>
In-Reply-To: <20220811091526.172610-1-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Aug 2022 20:27:00 -0700
Message-ID: <CAEf4BzaKWQtwki8oDcp+rh8c-kMmZcc1ok+zs=GvMCndN8UnyA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 0/6] bpf: Fixes for CONFIG_X86_KERNEL_IBT
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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

On Thu, Aug 11, 2022 at 2:15 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> Martynas reported bpf_get_func_ip returning +4 address when
> CONFIG_X86_KERNEL_IBT option is enabled and I found there are
> some failing bpf tests when this option is enabled.
>
> The CONFIG_X86_KERNEL_IBT option adds endbr instruction at the
> function entry, so the idea is to 'fix' entry ip for kprobe_multi
> and trampoline probes, because they are placed on the function
> entry.
>
> v2 changes:
>   - change kprobes get_func_ip to return zero for kprobes
>     attached within the function body [Andrii]
>   - detect IBT config and properly test kprobe with offset
>     [Andrii]
>
> v1 changes:
>   - read previous instruction in kprobe_multi link handler
>     and adjust entry_ip for CONFIG_X86_KERNEL_IBT option
>   - split first patch into 2 separate changes
>   - update changelogs
>
> thanks,
> jirka
>
>
> ---
> Jiri Olsa (6):
>       kprobes: Add new KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag
>       ftrace: Keep the resolved addr in kallsyms_callback
>       bpf: Use given function address for trampoline ip arg
>       bpf: Adjust kprobe_multi entry_ip for CONFIG_X86_KERNEL_IBT
>       bpf: Return value in kprobe get_func_ip only for entry address
>       selftests/bpf: Fix get_func_ip offset test for CONFIG_X86_KERNEL_IBT
>
>  arch/x86/net/bpf_jit_comp.c                               |  9 ++++-----
>  include/linux/kprobes.h                                   |  1 +
>  kernel/kprobes.c                                          |  6 +++++-
>  kernel/trace/bpf_trace.c                                  | 15 ++++++++++++++-
>  kernel/trace/ftrace.c                                     |  3 +--
>  tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++-----------
>  tools/testing/selftests/bpf/progs/get_func_ip_test.c      | 22 ++++++++++------------
>  tools/testing/selftests/bpf/progs/kprobe_multi.c          |  4 +---
>  8 files changed, 87 insertions(+), 35 deletions(-)

Overall LGTM, please address Peter's questions and request for some
more comments and context. Few nits to simplify selftests further, but
looks great. Thanks!
