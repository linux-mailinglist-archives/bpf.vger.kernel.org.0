Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC92856A6
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 04:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgJGC3q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Oct 2020 22:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgJGC3o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Oct 2020 22:29:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DD1C0613D3
        for <bpf@vger.kernel.org>; Tue,  6 Oct 2020 19:29:42 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a3so702052ejy.11
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2020 19:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LpupRZdEhh5vY5loEpAd0eWQo9Le/90wlIX9LBWXr00=;
        b=QXvJhZCR0NTOSoKyVsoPSq2TVVQGEHVHuvfbu+AMAQnAZjaEA79qDlf/emiQ9fRIHu
         zkpjrVvHgGTjzQAqW/JvF3JRVPUdc6UFSMhXsqgBD3sdhopAMT7r8GyN0/Mwq0G41sM6
         hIqKCIVoUoJGjSP9iQki6IC7pnyLnsMBcdMabVIakRxl5NKatNOYb68YUSa272RiMjeM
         BXkwrf+X4FtfTF954cToAzfGG9Xy6fCCAlWiN6ppIUXonYobR75rdYhOQjITBld1v8yw
         Pf6BH+yh5mhJl2KUN1tfUglF0J3b6q2kpJ+gG6C27+W0JNAzNmmKZQX63E1B2JIPrXm6
         8Oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LpupRZdEhh5vY5loEpAd0eWQo9Le/90wlIX9LBWXr00=;
        b=G0Ey5kUJOhMbbKh5e/3LMmc3fEZVC4kqOvpmQMAbgaFGjHop5xCTdcBYJQbO1LGos+
         8JvD0MaEGUo8xCygVinm4IibWB9SZ9iox0kRiX+Riz3LDhRLlskMYGco9QY1BUp1F1vO
         BoSP5XzcvGUXs33ILuFCbDwYvjUDN7AoE6aNQXe/24f0m3qP5V0/2Xk35lYLPgmAiVNK
         eSTyDZVjSYqHhw/qDPZRhl6lrNqQUQ50tqdzTqLEEYwnNWXfhCHvHTTeTikE8osFPS8o
         rGfHZ8wPJtI68AqC+Cx3sBaPgPqSRAsPybv63YgV8jseH7PHhUFHtnmCLJhwdyC1kgQq
         eGFA==
X-Gm-Message-State: AOAM5320nbr4vREMi0tmrhKQmCuc3M9r21FX6aPAXS6wGvIBWWDbGWvF
        Y7l21kHgEfMKQH7QJu1XjwECd/50Kc9zYZnaIiGwTw==
X-Google-Smtp-Source: ABdhPJzNxfvv3xqviGQzrvSb6MzDmDTU2EI5A6QSNhguWmGEYd03GXboYqTdMkrPwWdTtdwM4/ZI4Xq/pbkcH39FxwE=
X-Received: by 2002:a17:906:915:: with SMTP id i21mr1013506ejd.113.1602037781423;
 Tue, 06 Oct 2020 19:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201007012313.2778426-1-haoluo@google.com> <20201007020401.wsbeli3dbz7fumal@ast-mbp>
In-Reply-To: <20201007020401.wsbeli3dbz7fumal@ast-mbp>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 6 Oct 2020 19:29:30 -0700
Message-ID: <CA+khW7jYqFzEYoL4jEr3UX1PWGtNc-7i1HXhFMLu4EZCj2xB8g@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Fix test_verifier after introducing resolve_pseudo_ldimm64
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ack. Sent one with just deletion.

Hao




On Tue, Oct 6, 2020 at 7:04 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 06, 2020 at 06:23:13PM -0700, Hao Luo wrote:
> > Commit 4976b718c355 ("bpf: Introduce pseudo_btf_id") switched
> > the order of check_subprogs() and resolve_pseudo_ldimm() in
> > the verifier. Now an empty prog expects to see the error "last
> > insn is not an the prog of a single invalid ldimm exit or jmp"
> > instead, because the check for subprogs comes first. It's now
> > pointless to validate that half of ldimm64 won't be the last
> > instruction.
> >
> > Tested:
> >  # ./test_verifier
> >  Summary: 1129 PASSED, 537 SKIPPED, 0 FAILED
> >  and the full set of bpf selftests.
> >
> > Fixes: 4976b718c355 ("bpf: Introduce pseudo_btf_id")
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> > Changelog in v2:
> >  - Remove the original test_verifier ld_imm64 test4
> >  - Updated commit message.
> >
> >  tools/testing/selftests/bpf/verifier/basic.c  |  2 +-
> >  .../testing/selftests/bpf/verifier/ld_imm64.c | 24 +++++++------------
> >  2 files changed, 9 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/verifier/basic.c b/tools/testing/selftests/bpf/verifier/basic.c
> > index b8d18642653a..de84f0d57082 100644
> > --- a/tools/testing/selftests/bpf/verifier/basic.c
> > +++ b/tools/testing/selftests/bpf/verifier/basic.c
> > @@ -2,7 +2,7 @@
> >       "empty prog",
> >       .insns = {
> >       },
> > -     .errstr = "unknown opcode 00",
> > +     .errstr = "last insn is not an exit or jmp",
> >       .result = REJECT,
> >  },
> >  {
> > diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/testing/selftests/bpf/verifier/ld_imm64.c
> > index 3856dba733e9..ed6a34991216 100644
> > --- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
> > +++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
> > @@ -54,21 +54,13 @@
> >       "test5 ld_imm64",
> >       .insns = {
> >       BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, 0, 0, 0),
> > -     },
> > -     .errstr = "invalid bpf_ld_imm64 insn",
> > -     .result = REJECT,
> > -},
> > -{
> > -     "test6 ld_imm64",
> > -     .insns = {
> > -     BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, 0, 0, 0),
> >       BPF_RAW_INSN(0, 0, 0, 0, 0),
> >       BPF_EXIT_INSN(),
> >       },
> >       .result = ACCEPT,
> >  },
> >  {
> > -     "test7 ld_imm64",
> > +     "test6 ld_imm64",
> >       .insns = {
> >       BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, 0, 0, 1),
> >       BPF_RAW_INSN(0, 0, 0, 0, 1),
> > @@ -78,7 +70,7 @@
> >       .retval = 1,
> >  },
> >  {
> > -     "test8 ld_imm64",
> > +     "test7 ld_imm64",
>
> imo that's too much churn to rename all of them.
> Just delete one.
