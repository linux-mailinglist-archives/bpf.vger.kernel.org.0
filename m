Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29236016FE
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 21:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJQTKp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 15:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJQTKn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 15:10:43 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D245918E29
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 12:10:41 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-132fb4fd495so14330648fac.12
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 12:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s0HtQQEU1KD07cnfV5sqhhl7NC1nD6JeKl8vlD6X5bc=;
        b=J5ckQwk5f17OF8pQt66AjQUgpx2SA9UelXEToqmgB+xmj7dg9P51ytv03oHrB8CyF5
         om0Q4KyUA14FQdFQpQ5+QiixeEV9pRRqN6t8OEr2bQHy+g43sDQwDNlQydb8ecf7aKok
         Mx4mSFKJN76E2vQop4KHqjsZG6lxMdK8ekteI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0HtQQEU1KD07cnfV5sqhhl7NC1nD6JeKl8vlD6X5bc=;
        b=iLAt7vbm3G0pBA/9dGJ7i7fejxdE8pIIFFHuCfcMjSePpEBDvnialVQUXc/SEQ4t1Z
         iXeb+ADt7m3RQ05XbpHu5tUq6ZqohAhIIvJvlzSnQPzA55UM1Z7wVkmwOl/daK5qdj6V
         VtMDQ5kLcN3cvbgEnHaou2mg+bo85iYGAMLHvJnsvt6jjxl49i4qT/BjYtbY1DtXmqAJ
         imzdqBljP5SumexFW4HTSl5om2wS/VI01IXapysPAY6uzBKXQ4ChwNRlMjD5WcDF5BJ7
         Muc6GHb1NRa+UAc6NArpy/wsvlAQkq0txGPUZr0lFYmcOaL7OpquFtsm3qvP051d6SM+
         1oeQ==
X-Gm-Message-State: ACrzQf1EsUSjT+zpuxDjP7Ou6oBx5P0riQhpG02B2aj7w+qegz+eMZ30
        SdVDGJW93fwLXTJznB33zgW4+YJBK5Uji9H3egsz1hkKa9r/jw==
X-Google-Smtp-Source: AMsMyM7+SdOqBsDFuP6CDB2suF4jvA2csSIGb3xEPcNuj632CabHd6uGTXp96mMnVQYSqA0jiNYZWNpB7FENzjBkqEM=
X-Received: by 2002:a17:90a:b903:b0:20d:a36b:6791 with SMTP id
 p3-20020a17090ab90300b0020da36b6791mr27474441pjr.26.1666033830692; Mon, 17
 Oct 2022 12:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220913162732.163631-1-xukuohai@huaweicloud.com>
 <f1e14934-dc54-9bf7-501a-89affdb7371e@iogearbox.net> <YzG51Jyd5zhvygtK@arm.com>
 <YzHk1zRf1Dp8YTEe@FVFF77S0Q05N> <970a25e4-9b79-9e0c-b338-ed1a934f2770@huawei.com>
 <YzR5WSLux4mmFIXg@FVFF77S0Q05N> <2cb606b4-aa8b-e259-cdfd-1bfc61fd7c44@huawei.com>
 <CABRcYmKPchvtkkgWhOJ6o3pHVqTWeenGawHfZ2ug8Akdh6NfnQ@mail.gmail.com>
 <7f34d333-3b2a-aea5-f411-d53be2c46eee@huawei.com> <20221005110707.55bd9354@gandalf.local.home>
 <CABRcYmJGY6fp0CtUBYN8BjEDN=r42BPLSBcrxqu491bTRmfm7g@mail.gmail.com>
 <20221005113019.18aeda76@gandalf.local.home> <CABRcYmL0bDkgYP3tSwhZYaGUSbsUR3Gq85QCRiUAdXt65czzmg@mail.gmail.com>
 <20221006122922.53802a5c@gandalf.local.home> <CABRcYm+d=xY9nBCJo-6JW_=F41g4X32QM9WOPChaOTfs6d6KCA@mail.gmail.com>
 <20221017144949.2b9dcdc5@gandalf.local.home>
In-Reply-To: <20221017144949.2b9dcdc5@gandalf.local.home>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 17 Oct 2022 21:10:19 +0200
Message-ID: <CABRcYmJ7bg+HKWG4cbXH=T6iiWXWKGZZy8rXRhAFNPNz507yHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Xu Kuohai <xukuohai@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Uhuh, apologies for my perf report formatting! I'll try to figure it
out for next time, meanwhile you can find it better formatted here
https://paste.debian.net/1257405/

On Mon, Oct 17, 2022 at 8:49 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 17 Oct 2022 19:55:06 +0200
> Florent Revest <revest@chromium.org> wrote:
>
> > Note that I can't really make sense of the perf report with indirect
> > calls. it always reports it spent 12% of the time in
> > rethook_trampoline_handler but I verified with both a WARN in that
> > function and a breakpoint with a debugger, this function does *not*
> > get called when running this "bench trig-fentry" benchmark. Also it
> > wouldn't make sense for fprobe_handler to call it so I'm quite
> > confused why perf would report this call and such a long time spent
> > there. Anyone know what I could be missing here ?
>
> The trace shows __bpf_prog_exit, which I'm guessing is tracing the end of
> the function. Right?

Actually no, this function is called to end the context of a BPF
program execution. Here it is called at the end of the fentry program
(so still before the traced function). I hope the pastebin helps
clarify this!

> In which case I believe it must call rethook_trampoline_handler:
>
>  -> fprobe_handler() /* Which could use some "unlikely()" to move disabled
>                         paths out of the hot path */
>
>        /* And also calls rethook_try_get () which does a cmpxchg! */
>
>         -> ret_hook()
>                 -> arch_rethook_prepare()
>                         Sets regs->lr = arch_rethook_trampoline
>
> On return of the function, it jumps to arch_rethook_trampoline()
>
>   -> arch_rethook_trampoline()
>         -> arch_rethook_trampoline_callback()
>                 -> rethook_trampoline_handler()

This is indeed what happens when an fexit program is also attached.
But when running "bench trig-fentry", only an fentry program is
attached so bpf_fprobe_entry returns a non-zero value and fprobe
doesn't call rethook_hook.

Also, in this situation arch_rethook_trampoline is called by the
traced function's return but in the perf report, iiuc, it shows up as
being called from fprobe_handler and that should never happen. I
wonder if this is some sort of stack unwinding artifact during the
perf record?

> So I do not know how it wouldn't trigger the WARNING or breakpoint if you
> added it there.

By the way, the WARNING does trigger if I also attach an fexit program
(then rethook_hook is called). But I made sure we skip the whole
rethook logic if no fexit program is attached so bench trig-fentry
should not go through rethook_trampoline_handler.
