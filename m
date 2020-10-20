Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A484287C19
	for <lists+bpf@lfdr.de>; Thu,  8 Oct 2020 21:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgJHTLL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Oct 2020 15:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJHTLK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Oct 2020 15:11:10 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767D5C0613D2
        for <bpf@vger.kernel.org>; Thu,  8 Oct 2020 12:11:10 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j22so2258334lfe.10
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2020 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZeXzjOdaCkTwbvps0NY2Rc+Rgu80s3Mqaz2r6rAtyo=;
        b=vOSc18OvhPf8PmPnv/oR8SMQqcn9rFjvo3e4b9S75dLmmJM4ru8wQ3AigjPtbLQinX
         eNmVPNu5VkLgilw125WYs3t+Ntic4Av0zvHcNHK3VccVEAXccj9ir1rnkQ8LD9sAP2cL
         nuprf4NMsbzQ9jYRRvq8B0QMfRTH9Os2OkRpJpgB4gjDCRjauWSdLrMW+LEBpFL73k7w
         KbR/YfzJvF7Igdan6sL2D0+xsYekG86pmncHxIuvHW1+GXa+fLqcvVZV6psFMWrgx7Rw
         c+qTUpaa3DsReRKrIvj/xC/oCGfx/sTOl5EYiIa0Z+LFo6d0ruZ6TorHAov2/bU60t8g
         Wetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZeXzjOdaCkTwbvps0NY2Rc+Rgu80s3Mqaz2r6rAtyo=;
        b=eFuBoUm80Z6TxJUH7nSq6gkLR2xd8WhQmEPTTCebnL+PvSTNMj6cdlNG+tNCheKmfO
         6h52UCiaJljek593krwicC3LWkJtbo740uLcwkdeWQpnrEYG5G12Ewh+za/xtLwpDvE8
         uEduJjJbbcm3CPNXNVZJrTILXCSotH4kUJVtw97E4JxLnUOhUC4quMOEYp+72ApjLEM3
         Gp6DXb82al9uSmoTwFJkK0mz1RDpjlj59NBjj8UttQl2+oGemvrYcwF40AXnts71w8n0
         zJb/eWyqAp108mgWyRO+e2jQ9T6x5SvvRR/RAB5M3FRkvaprrGKVXwvuQH2hEzWEbM0r
         WN0A==
X-Gm-Message-State: AOAM53314r0zf12S2a6MU1s2bCGTAA3NEq55d5rUs+ZLLaytrHhEY0QU
        BRdrKvVoUpN6S8lDUkACfOfzLDlIXGyKTvaLlZtUKQ==
X-Google-Smtp-Source: ABdhPJwpxyam+w0rhfzKcHaxjnNi9gqIO+T7iEEDq5MDErKiqB2qiPaPJFJuVkEQ/4jTSTaSfDkk/R1d2C/XJGjdZyE=
X-Received: by 2002:a19:4bc9:: with SMTP id y192mr2983115lfa.447.1602184268622;
 Thu, 08 Oct 2020 12:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201001042927.2147800-1-andrew@aj.id.au> <CA+XBgLXqbdj8whr289z0dHV4NLO_rq8rJKs14JNfbVO8oJUbWA@mail.gmail.com>
In-Reply-To: <CA+XBgLXqbdj8whr289z0dHV4NLO_rq8rJKs14JNfbVO8oJUbWA@mail.gmail.com>
From:   Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Date:   Thu, 8 Oct 2020 21:13:31 +0200
Message-ID: <CAOjtDRWcdk+Ra56EWuu-0KvheNux0qPb2kbj9xPYF3+2E-ym5g@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: kprobes: Avoid fortify_panic() when copying
 optprobe template
To:     Luka Oreskovic <luka.oreskovic@sartura.hr>
Cc:     Andrew Jeffery <andrew@aj.id.au>, bpf <bpf@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mhiramat@kernel.org, labbott@redhat.com, keescook@chromium.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

[Adding the bpf list on Cc]

On Thu, Oct 8, 2020 at 5:38 PM Luka Oreskovic <luka.oreskovic@sartura.hr> wrote:
>
> On Thu, Oct 1, 2020 at 6:30 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Setting both CONFIG_KPROBES=y and CONFIG_FORTIFY_SOURCE=y on ARM leads
> > to a panic in memcpy() when injecting a kprobe despite the fixes found
> > in commit e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with
> > FORTIFY_SOURCE") and commit 0ac569bf6a79 ("ARM: 8834/1: Fix: kprobes:
> > optimized kprobes illegal instruction").
> >
> > arch/arm/include/asm/kprobes.h effectively declares
> > the target type of the optprobe_template_entry assembly label as a u32
> > which leads memcpy()'s __builtin_object_size() call to determine that
> > the pointed-to object is of size four. However, the symbol is used as a handle
> > for the optimised probe assembly template that is at least 96 bytes in size.
> > The symbol's use despite its type blows up the memcpy() in ARM's
> > arch_prepare_optimized_kprobe() with a false-positive fortify_panic() when it
> > should instead copy the optimised probe template into place:
> >
> > ```
> > $ sudo perf probe -a aspeed_g6_pinctrl_probe
> > [  158.457252] detected buffer overflow in memcpy
> > [  158.458069] ------------[ cut here ]------------
> > [  158.458283] kernel BUG at lib/string.c:1153!
> > [  158.458436] Internal error: Oops - BUG: 0 [#1] SMP ARM
> > [  158.458768] Modules linked in:
> > [  158.459043] CPU: 1 PID: 99 Comm: perf Not tainted 5.9.0-rc7-00038-gc53ebf8167e9 #158
> > [  158.459296] Hardware name: Generic DT based system
> > [  158.459529] PC is at fortify_panic+0x18/0x20
> > [  158.459658] LR is at __irq_work_queue_local+0x3c/0x74
> > [  158.459831] pc : [<8047451c>]    lr : [<8020ecd4>]    psr: 60000013
> > [  158.460032] sp : be2d1d50  ip : be2d1c58  fp : be2d1d5c
> > [  158.460174] r10: 00000006  r9 : 00000000  r8 : 00000060
> > [  158.460348] r7 : 8011e434  r6 : b9e0b800  r5 : 7f000000  r4 : b9fe4f0c
> > [  158.460557] r3 : 80c04cc8  r2 : 00000000  r1 : be7c03cc  r0 : 00000022
> > [  158.460801] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > [  158.461037] Control: 10c5387d  Table: b9cd806a  DAC: 00000051
> > [  158.461251] Process perf (pid: 99, stack limit = 0x81c71a69)
> > [  158.461472] Stack: (0xbe2d1d50 to 0xbe2d2000)
> > [  158.461757] 1d40:                                     be2d1d84 be2d1d60 8011e724 80474510
> > [  158.462104] 1d60: b9e0b800 b9fe4f0c 00000000 b9fe4f14 80c8ec80 be235000 be2d1d9c be2d1d88
> > [  158.462436] 1d80: 801cee44 8011e57c b9fe4f0c 00000000 be2d1dc4 be2d1da0 801d0ad0 801cedec
> > [  158.462742] 1da0: 00000000 00000000 b9fe4f00 ffffffea 00000000 be235000 be2d1de4 be2d1dc8
> > [  158.463087] 1dc0: 80204604 801d0738 00000000 00000000 b9fe4004 ffffffea be2d1e94 be2d1de8
> > [  158.463428] 1de0: 80205434 80204570 00385c00 00000000 00000000 00000000 be2d1e14 be2d1e08
> > [  158.463880] 1e00: 802ba014 b9fe4f00 b9e718c0 b9fe4f84 b9e71ec8 be2d1e24 00000000 00385c00
> > [  158.464365] 1e20: 00000000 626f7270 00000065 802b905c be2d1e94 0000002e 00000000 802b9914
> > [  158.464829] 1e40: be2d1e84 be2d1e50 802b9914 8028ff78 804629d0 b9e71ec0 0000002e b9e71ec0
> > [  158.465141] 1e60: be2d1ea8 80c04cc8 00000cc0 b9e713c4 00000002 80205834 80205834 0000002e
> > [  158.465488] 1e80: be235000 be235000 be2d1ea4 be2d1e98 80205854 80204e94 be2d1ecc be2d1ea8
> > [  158.465806] 1ea0: 801ee4a0 80205840 00000002 80c04cc8 00000000 0000002e 0000002e 00000000
> > [  158.466110] 1ec0: be2d1f0c be2d1ed0 801ee5c8 801ee428 00000000 be2d0000 006b1fd0 00000051
> > [  158.466398] 1ee0: 00000000 b9eedf00 0000002e 80204410 006b1fd0 be2d1f60 00000000 00000004
> > [  158.466763] 1f00: be2d1f24 be2d1f10 8020442c 801ee4c4 80205834 802c613c be2d1f5c be2d1f28
> > [  158.467102] 1f20: 802c60ac 8020441c be2d1fac be2d1f38 8010c764 802e9888 be2d1f5c b9eedf00
> > [  158.467447] 1f40: b9eedf00 006b1fd0 0000002e 00000000 be2d1f94 be2d1f60 802c634c 802c5fec
> > [  158.467812] 1f60: 00000000 00000000 00000000 80c04cc8 006b1fd0 00000003 76f7a610 00000004
> > [  158.468155] 1f80: 80100284 be2d0000 be2d1fa4 be2d1f98 802c63ec 802c62e8 00000000 be2d1fa8
> > [  158.468508] 1fa0: 80100080 802c63e0 006b1fd0 00000003 00000003 006b1fd0 0000002e 00000000
> > [  158.468858] 1fc0: 006b1fd0 00000003 76f7a610 00000004 006b1fb0 0026d348 00000017 7ef2738c
> > [  158.469202] 1fe0: 76f3431c 7ef272d8 0014ec50 76f34338 60000010 00000003 00000000 00000000
> > [  158.469461] Backtrace:
> > [  158.469683] [<80474504>] (fortify_panic) from [<8011e724>] (arch_prepare_optimized_kprobe+0x1b4/0x1f8)
> > [  158.470021] [<8011e570>] (arch_prepare_optimized_kprobe) from [<801cee44>] (alloc_aggr_kprobe+0x64/0x70)
> > [  158.470287]  r9:be235000 r8:80c8ec80 r7:b9fe4f14 r6:00000000 r5:b9fe4f0c r4:b9e0b800
> > [  158.470478] [<801cede0>] (alloc_aggr_kprobe) from [<801d0ad0>] (register_kprobe+0x3a4/0x5a0)
> > [  158.470685]  r5:00000000 r4:b9fe4f0c
> > [  158.470790] [<801d072c>] (register_kprobe) from [<80204604>] (__register_trace_kprobe+0xa0/0xa4)
> > [  158.471001]  r9:be235000 r8:00000000 r7:ffffffea r6:b9fe4f00 r5:00000000 r4:00000000
> > [  158.471188] [<80204564>] (__register_trace_kprobe) from [<80205434>] (trace_kprobe_create+0x5ac/0x9ac)
> > [  158.471408]  r7:ffffffea r6:b9fe4004 r5:00000000 r4:00000000
> > [  158.471553] [<80204e88>] (trace_kprobe_create) from [<80205854>] (create_or_delete_trace_kprobe+0x20/0x3c)
> > [  158.471766]  r10:be235000 r9:be235000 r8:0000002e r7:80205834 r6:80205834 r5:00000002
> > [  158.471949]  r4:b9e713c4
> > [  158.472027] [<80205834>] (create_or_delete_trace_kprobe) from [<801ee4a0>] (trace_run_command+0x84/0x9c)
> > [  158.472255] [<801ee41c>] (trace_run_command) from [<801ee5c8>] (trace_parse_run_command+0x110/0x1f8)
> > [  158.472471]  r6:00000000 r5:0000002e r4:0000002e
> > [  158.472594] [<801ee4b8>] (trace_parse_run_command) from [<8020442c>] (probes_write+0x1c/0x28)
> > [  158.472800]  r10:00000004 r9:00000000 r8:be2d1f60 r7:006b1fd0 r6:80204410 r5:0000002e
> > [  158.472968]  r4:b9eedf00
> > [  158.473046] [<80204410>] (probes_write) from [<802c60ac>] (vfs_write+0xcc/0x1e8)
> > [  158.473226] [<802c5fe0>] (vfs_write) from [<802c634c>] (ksys_write+0x70/0xf8)
> > [  158.473400]  r8:00000000 r7:0000002e r6:006b1fd0 r5:b9eedf00 r4:b9eedf00
> > [  158.473567] [<802c62dc>] (ksys_write) from [<802c63ec>] (sys_write+0x18/0x1c)
> > [  158.473745]  r9:be2d0000 r8:80100284 r7:00000004 r6:76f7a610 r5:00000003 r4:006b1fd0
> > [  158.473932] [<802c63d4>] (sys_write) from [<80100080>] (ret_fast_syscall+0x0/0x54)
> > [  158.474126] Exception stack(0xbe2d1fa8 to 0xbe2d1ff0)
> > [  158.474305] 1fa0:                   006b1fd0 00000003 00000003 006b1fd0 0000002e 00000000
> > [  158.474573] 1fc0: 006b1fd0 00000003 76f7a610 00000004 006b1fb0 0026d348 00000017 7ef2738c
> > [  158.474811] 1fe0: 76f3431c 7ef272d8 0014ec50 76f34338
> > [  158.475171] Code: e24cb004 e1a01000 e59f0004 ebf40dd3 (e7f001f2)
> > [  158.475847] ---[ end trace 55a5b31c08a29f00 ]---
> > [  158.476088] Kernel panic - not syncing: Fatal exception
> > [  158.476375] CPU0: stopping
> > [  158.476709] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D           5.9.0-rc7-00038-gc53ebf8167e9 #158
> > [  158.477176] Hardware name: Generic DT based system
> > [  158.477411] Backtrace:
> > [  158.477604] [<8010dd28>] (dump_backtrace) from [<8010dfd4>] (show_stack+0x20/0x24)
> > [  158.477990]  r7:00000000 r6:60000193 r5:00000000 r4:80c2f634
> > [  158.478323] [<8010dfb4>] (show_stack) from [<8046390c>] (dump_stack+0xcc/0xe8)
> > [  158.478686] [<80463840>] (dump_stack) from [<80110750>] (handle_IPI+0x334/0x3a0)
> > [  158.479063]  r7:00000000 r6:00000004 r5:80b65cc8 r4:80c78278
> > [  158.479352] [<8011041c>] (handle_IPI) from [<801013f8>] (gic_handle_irq+0x88/0x94)
> > [  158.479757]  r10:10c5387d r9:80c01ed8 r8:00000000 r7:c0802000 r6:80c0537c r5:000003ff
> > [  158.480146]  r4:c080200c r3:fffffff4
> > [  158.480364] [<80101370>] (gic_handle_irq) from [<80100b6c>] (__irq_svc+0x6c/0x90)
> > [  158.480748] Exception stack(0x80c01ed8 to 0x80c01f20)
> > [  158.481031] 1ec0:                                                       000128bc 00000000
> > [  158.481499] 1ee0: be7b8174 8011d3a0 80c00000 00000000 80c04cec 80c04d28 80c5d7c2 80a026d4
> > [  158.482091] 1f00: 10c5387d 80c01f34 80c01f38 80c01f28 80109554 80109558 60000013 ffffffff
> > [  158.482621]  r9:80c00000 r8:80c5d7c2 r7:80c01f0c r6:ffffffff r5:60000013 r4:80109558
> > [  158.482983] [<80109518>] (arch_cpu_idle) from [<80818780>] (default_idle_call+0x38/0x120)
> > [  158.483360] [<80818748>] (default_idle_call) from [<801585a8>] (do_idle+0xd4/0x158)
> > [  158.483945]  r5:00000000 r4:80c00000
> > [  158.484237] [<801584d4>] (do_idle) from [<801588f4>] (cpu_startup_entry+0x28/0x2c)
> > [  158.484784]  r9:80c78000 r8:00000000 r7:80c78000 r6:80c78040 r5:80c04cc0 r4:000000d6
> > [  158.485328] [<801588cc>] (cpu_startup_entry) from [<80810a78>] (rest_init+0x9c/0xbc)
> > [  158.485930] [<808109dc>] (rest_init) from [<80b00ae4>] (arch_call_rest_init+0x18/0x1c)
> > [  158.486503]  r5:80c04cc0 r4:00000001
> > [  158.486857] [<80b00acc>] (arch_call_rest_init) from [<80b00fcc>] (start_kernel+0x46c/0x548)
> > [  158.487589] [<80b00b60>] (start_kernel) from [<00000000>] (0x0)
> > ```
> >
> > Fixes: e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE")
> > Fixes: 0ac569bf6a79 ("ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction")
> > Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
> > Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
>
> Tested-by: Luka Oreskovic <luka.oreskovic@sartura.hr>
>
> > v1 was sent some time back, in May:
> >
> > https://lore.kernel.org/linux-arm-kernel/20200517153959.293224-1-andrew@aj.id.au/
> >
> > I've taken the patch that Kees' suggested in the replies and tested it.
> > ---
> >  arch/arm/include/asm/kprobes.h    | 22 +++++++++++-----------
> >  arch/arm/probes/kprobes/opt-arm.c | 18 +++++++++---------
> >  2 files changed, 20 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
> > index 213607a1f45c..e26a278d301a 100644
> > --- a/arch/arm/include/asm/kprobes.h
> > +++ b/arch/arm/include/asm/kprobes.h
> > @@ -44,20 +44,20 @@ int kprobe_exceptions_notify(struct notifier_block *self,
> >                              unsigned long val, void *data);
> >
> >  /* optinsn template addresses */
> > -extern __visible kprobe_opcode_t optprobe_template_entry;
> > -extern __visible kprobe_opcode_t optprobe_template_val;
> > -extern __visible kprobe_opcode_t optprobe_template_call;
> > -extern __visible kprobe_opcode_t optprobe_template_end;
> > -extern __visible kprobe_opcode_t optprobe_template_sub_sp;
> > -extern __visible kprobe_opcode_t optprobe_template_add_sp;
> > -extern __visible kprobe_opcode_t optprobe_template_restore_begin;
> > -extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn;
> > -extern __visible kprobe_opcode_t optprobe_template_restore_end;
> > +extern __visible kprobe_opcode_t optprobe_template_entry[];
> > +extern __visible kprobe_opcode_t optprobe_template_val[];
> > +extern __visible kprobe_opcode_t optprobe_template_call[];
> > +extern __visible kprobe_opcode_t optprobe_template_end[];
> > +extern __visible kprobe_opcode_t optprobe_template_sub_sp[];
> > +extern __visible kprobe_opcode_t optprobe_template_add_sp[];
> > +extern __visible kprobe_opcode_t optprobe_template_restore_begin[];
> > +extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn[];
> > +extern __visible kprobe_opcode_t optprobe_template_restore_end[];
> >
> >  #define MAX_OPTIMIZED_LENGTH   4
> >  #define MAX_OPTINSN_SIZE                               \
> > -       ((unsigned long)&optprobe_template_end -        \
> > -        (unsigned long)&optprobe_template_entry)
> > +       ((unsigned long)optprobe_template_end - \
> > +        (unsigned long)optprobe_template_entry)
> >  #define RELATIVEJUMP_SIZE      4
> >
> >  struct arch_optimized_insn {
> > diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
> > index 7a449df0b359..c78180172120 100644
> > --- a/arch/arm/probes/kprobes/opt-arm.c
> > +++ b/arch/arm/probes/kprobes/opt-arm.c
> > @@ -85,21 +85,21 @@ asm (
> >                         "optprobe_template_end:\n");
> >
> >  #define TMPL_VAL_IDX \
> > -       ((unsigned long *)&optprobe_template_val - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_val - (unsigned long *)optprobe_template_entry)
> >  #define TMPL_CALL_IDX \
> > -       ((unsigned long *)&optprobe_template_call - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_call - (unsigned long *)optprobe_template_entry)
> >  #define TMPL_END_IDX \
> > -       ((unsigned long *)&optprobe_template_end - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_end - (unsigned long *)optprobe_template_entry)
> >  #define TMPL_ADD_SP \
> > -       ((unsigned long *)&optprobe_template_add_sp - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_add_sp - (unsigned long *)optprobe_template_entry)
> >  #define TMPL_SUB_SP \
> > -       ((unsigned long *)&optprobe_template_sub_sp - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_sub_sp - (unsigned long *)optprobe_template_entry)
> >  #define TMPL_RESTORE_BEGIN \
> > -       ((unsigned long *)&optprobe_template_restore_begin - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_restore_begin - (unsigned long *)optprobe_template_entry)
> >  #define TMPL_RESTORE_ORIGN_INSN \
> > -       ((unsigned long *)&optprobe_template_restore_orig_insn - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_restore_orig_insn - (unsigned long *)optprobe_template_entry)
> >  #define TMPL_RESTORE_END \
> > -       ((unsigned long *)&optprobe_template_restore_end - (unsigned long *)&optprobe_template_entry)
> > +       ((unsigned long *)optprobe_template_restore_end - (unsigned long *)optprobe_template_entry)
> >
> >  /*
> >   * ARM can always optimize an instruction when using ARM ISA, except
> > @@ -234,7 +234,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
> >         }
> >
> >         /* Copy arch-dep-instance from template. */
> > -       memcpy(code, (unsigned long *)&optprobe_template_entry,
> > +       memcpy(code, (unsigned long *)optprobe_template_entry,
> >                         TMPL_END_IDX * sizeof(kprobe_opcode_t));
> >
> >         /* Adjust buffer according to instruction. */
> > --
> > 2.25.1
> >

This patch might be of interest to the bpf mailing list.
Although it fixes a general issue with kprobes on ARM32, we originally
encountered it while testing various BPF programs that attached to
kprobe hooks, for example tcpconnect from BCC's libbpf-tools [0].
It caused a kernel panic or oops on our systems, and most of the BPF
kprobe programs that we tested were therefore unusable on ARM32
systems.
With the patch applied, the BPF programs are now working.

[0] https://github.com/iovisor/bcc/tree/master/libbpf-tools
