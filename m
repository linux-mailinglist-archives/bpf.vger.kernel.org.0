Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC86B598F8A
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 23:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345666AbiHRVdE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 17:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiHRVdA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 17:33:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754D41144;
        Thu, 18 Aug 2022 14:32:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x21so3461826edd.3;
        Thu, 18 Aug 2022 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=CiTL5HnekfjqUpmditrs+w9/F0W/1X/M0uXhus6DyhE=;
        b=EuWsiuCkZPpxHdW4bfvh26ZwaSPeY1B3LLlrCFCWUefmWz2549EmYh8qHUU/MdnOwm
         1WeLbk3FDKznDxP3hPxTuuHbSefbKPM8V74qIzNe+zX8gvrN3c9xZFtS4RMYgHMouc4h
         7y+Th11v8ztk2/yWTl9rSCQ5WimMFkpWj400xUziuREPZaykKVu9scjZjwkS5sj6dFZF
         DIBwmfvJRvI+SSI0hjWwPo95pu5w1prwmRpMPOM04mWIEg9xL/UXuKLUdY8dc7jrTlQA
         qjQ2i1cyDQN53TNThaRAOId7mXsQVMrKZKnqrb8eI3vzQMnoMxLd71CLdS1HvlIGMWBB
         2kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=CiTL5HnekfjqUpmditrs+w9/F0W/1X/M0uXhus6DyhE=;
        b=t7tPlkSxSx291jY0FthwzwatfzgYK//QNdWfivybtYNYiBB6wlZuV2V6QMDm6Qgw3K
         KgbaHqW5cfeMYGZ7Vm+GVAxkEBlv3Mq+JLnXuEFWNRCwUDVNrmhhwgOW2g1wHelE4ndb
         sFqV1QYY2bddoeCtrBtX4zH529F67m9CtfGG14Mn5I7Y0jKxXonFrdbg0Qpe9idmi7RS
         vhxnc0maPCMd1vxeNasflP+EdvmbD2AOa18WvR/84XzNRuocOjZiaqZVT4wWKovu37hA
         ALDwwc9qZuavNJkaplShWFweQC3MbZHLGGrmJztYJhawquMwfjWn3HjThpCprCylHjQQ
         9ZOQ==
X-Gm-Message-State: ACgBeo3xDyEUEKCLyc1Dm94fRCsZ9dSDWed5OvskWpKoSL0XIJW3ZVpo
        IsyNrZeB26/CzvKUSTwimxWtIxSHtrlZzA==
X-Google-Smtp-Source: AA6agR6vRrKUIoMBXHEi9PJO0ghurQ1aJLzbrIf4lPolUlKK3Wrzxy+60BmVGuu8pWIQT58GuI3lJg==
X-Received: by 2002:a05:6402:25c6:b0:43b:7797:d953 with SMTP id x6-20020a05640225c600b0043b7797d953mr3705988edb.254.1660858378054;
        Thu, 18 Aug 2022 14:32:58 -0700 (PDT)
Received: from krava ([83.240.63.36])
        by smtp.gmail.com with ESMTPSA id b2-20020a17090636c200b006fee7b5dff2sm1364138ejc.143.2022.08.18.14.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 14:32:57 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 18 Aug 2022 23:32:55 +0200
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <Yv6wB4El4iueJtwX@krava>
References: <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
 <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net>
 <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
 <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net>
 <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
 <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net>
 <YvppJ7TjMXD3cSdZ@worktop.programming.kicks-ass.net>
 <Yv6gm09CMdZ/HMr5@krava>
 <20220818165024.433f56fd@gandalf.local.home>
 <CAADnVQ+n=x=CuBk23UNnD9CHVXjrXLUofbockh-SWaLwH3H9fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+n=x=CuBk23UNnD9CHVXjrXLUofbockh-SWaLwH3H9fw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 18, 2022 at 02:00:21PM -0700, Alexei Starovoitov wrote:
> On Thu, Aug 18, 2022 at 1:50 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 18 Aug 2022 22:27:07 +0200
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > > ok, so the problem with __attribute__((patchable_function_entry(5))) is that
> > > it puts function address into __patchable_function_entries section, which is
> > > one of ftrace locations source:
> > >
> > >   #define MCOUNT_REC()    . = ALIGN(8);     \
> > >     __start_mcount_loc = .;                 \
> > >     KEEP(*(__mcount_loc))                   \
> > >     KEEP(*(__patchable_function_entries))   \
> > >     __stop_mcount_loc = .;                  \
> > >    ...
> > >
> > >
> > > it looks like __patchable_function_entries is used for other than x86 archs,
> > > so we perhaps we could have x86 specific MCOUNT_REC macro just with
> > > __mcount_loc section?
> >
> > So something like this:
> >
> > #ifdef CONFIG_X86
> > # define NON_MCOUNT_PATCHABLE KEEP(*(__patchable_function_entries))
> > # define MCOUNT_PATCHABLE
> > #else
> > # define NON_MCOUNT_PATCHABLE
> > # define MCOUNT_PATCHABLE  KEEP(*(__patchable_function_entries))
> > #endif
> >
> >   #define MCOUNT_REC()    . = ALIGN(8);     \
> >     __start_mcount_loc = .;                 \
> >     KEEP(*(__mcount_loc))                   \
> >     MCOUNT_PATCHABLE                        \
> >     __stop_mcount_loc = .;                  \
> >     NON_MCOUNT_PATCHABLE                    \
> >    ...
> >
> > ??
> 
> That's what more or less Peter's patch is doing:
> Here it is again for reference:
> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=8d075bdf11193f1d276bf19fa56b4b8dfe24df9e

ah nice, and discards the __patchable_function_entries section, great

jirka
