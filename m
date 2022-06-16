Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3D354D623
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 02:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbiFPAdf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 20:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242913AbiFPAdT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 20:33:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B863DF84
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 17:33:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gl15so26313490ejb.4
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 17:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtp/ow82N40IBcryheZ/tPFakxx/LOx2k7PwZKoc/e0=;
        b=FLgPj815sRVR/uuuf7yTBhaqtFMkQkAMIxnZYsuaVBps+xfkjbU5FyEw5lxBmE2nYi
         Q26hx0pdZPGK/eOWDydDhMi21ZoHs+028rwdVAvTMLRWC0uNk7+mV0Dtk+wK3fF5ACEy
         NVVK6+4zaqomWnKwkGR8S2o4Vst7NTGGTXYCMgf09yvXRx7sjmBK76e0x58H8GQ7PtsL
         QUv5jDhdm0i1G7/ICRGeLlG30zjk9+0v16YvkhmncaMigXRn3xg9fGKQopQ51HmgOCCI
         KefsPex/kh4Rm2wIAxDaqDcbpJSGZjG3d1grpqkZWJoPza2ATUzI303g+KDojiTyyVw3
         jzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtp/ow82N40IBcryheZ/tPFakxx/LOx2k7PwZKoc/e0=;
        b=xDCsLK23dApeoa6J8FReJIpRcksckqZw2WbMGFSUNl1QV0LDdMjocjQeTernZ3n25X
         t+VSEaVUZ3q/vTZuwverz/dEBgOpx8i6I8qv9rtXpru2C6EABS8sIR1xiK7dFNQY33+c
         JFGalYNTjjhh0wLVsblVzbz+J1VQ63T7zuXyhVhGa8nBoHiSB2G2UzT3nuectXfLnDEV
         AWpBYOYVPKfzX6H37EiZIgG560R+1Pp3vjclxU2v9eOn4Tp2+JspJ3C6yPIuOoSHe6as
         R/ezsG9JTH+pM4Bl6hsvfHwYSaMy/xjoyYNOtYZLhi+nKPXxSucCs47Cm0tWDv9TkBlj
         05dw==
X-Gm-Message-State: AJIora8ACGXbsjjXlbiQBQDJQov9IBJyhyyC2n85ti9IXYohdDe1x+hO
        Qzny1XBns37Ktq9mq/qivbfRQi78gmoIRIH1kQMDfQdZrlc=
X-Google-Smtp-Source: AGRyM1vpK/yOE+e8g7S0yfcu5UGcsLQQe/zLyMav9tCqMFfeynnruC1eax6NEXO+dI8rh+vSYDwmEYQkVEjnlAQ7KXU=
X-Received: by 2002:a17:906:610:b0:715:79ac:7db9 with SMTP id
 s16-20020a170906061000b0071579ac7db9mr2224779ejb.226.1655339595900; Wed, 15
 Jun 2022 17:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220524055748.4064533-1-andrii@kernel.org> <20220612231147.b3210be6da6f81ce7272f12c@kernel.org>
In-Reply-To: <20220612231147.b3210be6da6f81ce7272f12c@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 15 Jun 2022 17:33:04 -0700
Message-ID: <CAEf4BzZdhPd92P4yyjq3bRPf0j9HwSUCi3i=a5LZKd1EfJ95fA@mail.gmail.com>
Subject: Re: [PATCH] BUG: demonstration of uprobe/uretprobe corrupted stack traces
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, rihams@fb.com,
        Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>
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

On Sun, Jun 12, 2022 at 7:11 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Andrii,
>
> Sorry for waiting.
>
> On Mon, 23 May 2022 22:57:48 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > Hi Masami,
> >
> > We've got reports about partially corrupt stack traces when being captured from
> > uretprobes. Trying the simplest repro seems to confirm that something is not
> > quite right here. I'll try to debug it a bit more this week, but I was hoping
> > for you to take a look as well, if you get a chance.
>
> Ah, uprobes/uretprobes will be handled by Oleg. But I'll try to explain it
> as far as I know. Oleg, please correct me if I'm wrong.
>
> >
> > Simple repro built on top of BPF selftests.
> >
> >   $ sudo ./test_progs -a uprobe_autoattach -v
> >   ...
> >   FN ADDR 0x55fde0 - 0x55fdef
> >   UPROBE SZ 40 (CNT 5)       URETPROBE SZ 40 (CNT 5)
> >   UPROBE 0x55fde0           URETPROBE 0x55ffd4
> >   UPROBE 0x584653           URETPROBE 0x584653
> >   UPROBE 0x585cc9           URETPROBE 0x585cc9
> >   UPROBE 0x7fa9a31eaca3     URETPROBE 0x7fa9a31eaca3
> >   UPROBE 0x5541f689495641d7 URETPROBE 0x5541f689495641d7
> >   ...
> >   #203     uprobe_autoattach:OK
> >   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> >
> > There seem to be two distinct problems.
> >
> > 1. Last two entries for both uprobe and uretprobe stacks are not user-space
> > addressed (0x7fa9a31eaca3) and the very last one doesn't even look like a valid
> > address (0x5541f689495641d7).
>
> Hmm, what user-space stack unwinder are you using? I guess it comes
> from the user-space stack unwinder routine.
>
> >
> > 2. Looking at first entry for UPROBE vs URETPROBE, you can see that uprobe
> > one's is correct and points exactly to the beginning of autoattach_trigger_func
> > (0x55fde0) as expected, but uretprobe entry (0x55ffd4) is way out of
> > autoattach_trigger_func (which is just 15 bytes long and ends at 0x55fdef).
> > Using addr2line it shows that it points to:
> >
> >   0x000000000055ffd4: test_uprobe_autoattach at /data/users/andriin/linux/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c:33
> >
> > Which is a valid function and location to which autoattach_trigger_func()
> > should return (see objdump snippet below), but from uretprobe I'd imagine that
> > we are going to get address within traced user function (that is 0x55fde0 -
> > 0x55fdef range), not the return address in a parent function.
>
> No, it is expected behavior. Since the "return probe" probes the function
> returning, the first entry of the stack address is the address where the
> function is returned (IOW, the IP address when the probe hit). Not the
> address of the return instruction. As long as it uses the stack to hook
> the return of the function, it's impossible in principle.
> (if it decodes the function to find the return instruction and replace it
> with a software breakpoint, it may be possible. But this will not work
> if the function does tail call etc.)
>
> >
> >      55ffc4:       89 83 3c 08 00 00       mov    %eax,0x83c(%rbx)
> >      55ffca:       8b 45 e8                mov    -0x18(%rbp),%eax
> >      55ffcd:       89 c7                   mov    %eax,%edi
> >      55ffcf:       e8 0c fe ff ff          call   55fde0 <autoattach_trigger_func>
> > -->  55ffd4:       89 45 a8                mov    %eax,-0x58(%rbp)
> >      55ffd7:       ba ef fd 55 00          mov    $0x55fdef,%edx
> >
> > Both issues above seem unexpected, can you please see if I have some wrong
> > assumptions here?
>
> So, #1 maybe we need to look into the stack unwinder (bpf_get_stack()?)
>  Does this happen if you unwind user-stack from kprobe event?
>  Oleg, would you know anything about this issue?
>

I suspect that this is due to no-frame-pointer libc, so I haven't dug deeper.

> And #2 is the expected behavior.
>

Ok, I see, thanks for confirming!

> Thank you,
>
> >
> > Thanks in advance for taking a look!
> >
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Riham Selim <rihams@fb.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/Makefile               |  3 ++-
> >  .../selftests/bpf/prog_tests/uprobe_autoattach.c   | 14 ++++++++++++++
> >  .../selftests/bpf/progs/test_uprobe_autoattach.c   | 11 +++++++++++
> >  3 files changed, 27 insertions(+), 1 deletion(-)
> >

[...]

>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
