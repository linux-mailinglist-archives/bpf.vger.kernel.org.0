Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F950593207
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 17:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiHOPgL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 11:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiHOPgH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 11:36:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BD813D1D;
        Mon, 15 Aug 2022 08:36:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f22so10022054edc.7;
        Mon, 15 Aug 2022 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FKHASDkXl4bLy418ZA6s3npFBPp7+iCJrF69vP0vzUE=;
        b=GGpi0ap4Lo6vZPXfjFFxVlQOJyTAiLSpb8CM+ukdZ0Nii5pstZepWWb6I8QYIQ23QN
         GEkscnVOirAYIvugFqFxHRvjPQpkdcRuB7t8uSI46kIKD9cymo74iAXddUgiWStY0gcq
         0DwC8nr/f2Cs5v6CCkHMpF7/q55Uc6zXQVprN7pEtWmM5mZ9gmW5Dk7FEMDXLdO99buS
         C0D9K8ltHM+nYayVxOADiudOEwGIsZ3LQNVm0kGhCFiaXeDISr3BTX5bWLjoCkcNYhvQ
         WqRi2GE0qgT9NffPGy9JjuxwKewqqwxp/wHwZk++xk+5ZH1nq0UMzXbPU0ovd25HFMrM
         VDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FKHASDkXl4bLy418ZA6s3npFBPp7+iCJrF69vP0vzUE=;
        b=lrwPf7sD54y0k+2NtTpiu+iCTjpWaqoxLYItrX2vEEi7htlZOyF0hZ9s+qbYERnW8e
         U46RFDk7zBhVd2Y3u3UbdKupGVqzeyZs1dcB4BOA/VMfjH47l6zLKKlrUNk54LKMVCK2
         1vZd7e31tLR25hDWJm0n6Ah4men6rRY5uDDDlcx1oB+SWSKDwImgxWy6iwdoWMdEnV1R
         my6p9x4JgMT/igb78+ZN1ts3Oh/HwCuGhqduBCajHWBUHRXL0hLzlxfe+EQqh/MqUpSi
         2r9PkHM2JWCtDxtPAQDEq8mr0Q1B937aP1hJvlZ2dAAgwU2AsYxYPKG42w5wOI8C6oI5
         6Lfw==
X-Gm-Message-State: ACgBeo2rJHHbLoanNuMpaQbm1iQEIcgW3EhI6Oo4VU7ya1+59KgAM1qG
        8sPy/C1vYBW4YEwDtpIPXZMJRp2XkCc47b7QA7o=
X-Google-Smtp-Source: AA6agR7fcfRuPgfmPIqcGFYCTdMka4T4vGK+7ARbf+JZe1TmIp3usixCcFZulmjp8ERzCFsjjQfqFqvDL1aaG6QRSGs=
X-Received: by 2002:aa7:d60b:0:b0:43c:f7ab:3c8f with SMTP id
 c11-20020aa7d60b000000b0043cf7ab3c8fmr15030457edr.6.1660577764810; Mon, 15
 Aug 2022 08:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <YvbDlwJCTDWQ9uJj@krava> <20220813150252.5aa63650@rorschach.local.home>
 <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net> <YvoVgMzMuQbAEayk@krava>
 <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net> <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
 <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net> <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
 <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net> <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
 <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net>
In-Reply-To: <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 15 Aug 2022 08:35:53 -0700
Message-ID: <CAADnVQJuDS22o7fi9wPZx9siAWgu1grQXXB02KfasxZ-RPdRSw@mail.gmail.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

On Mon, Aug 15, 2022 at 8:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 15, 2022 at 08:17:42AM -0700, Alexei Starovoitov wrote:
> > It's hiding a fake function from ftrace, since it's not a function
> > and ftrace infra shouldn't show it tracing logs.
> > In other words it's a _notrace_ function with nop5.
>
> Then make it a notrace function with a nop5 in it. That isn't hard.

That's exactly what we're trying to do.
Jiri's patch is one way to achieve that.
What is your suggestion?
Move it from C to asm ?
Make it naked function with explicit inline asm?
What else?
