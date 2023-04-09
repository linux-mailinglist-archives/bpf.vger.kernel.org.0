Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F8B6DBEC5
	for <lists+bpf@lfdr.de>; Sun,  9 Apr 2023 07:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjDIFcx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Apr 2023 01:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIFcw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Apr 2023 01:32:52 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A490A4EFD;
        Sat,  8 Apr 2023 22:32:50 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id bl15so1918021qtb.10;
        Sat, 08 Apr 2023 22:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681018369; x=1683610369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/loUi7ti8pVU3DBwVEkivFgAvOa2p4v5kqrybReGW4=;
        b=qgh7IWN+u4+FKjAGjYNDBJ5OgQksjXq2KPwnSdhm2mHnBjPa/PKRgdyFxP4GZu+r1B
         tpAGlFI7FHjYjUWu+8PACB7MtxXeFzaq44aw0qM9icepad9JwdCJLkJTLqBH3sltt7UP
         ntQ7T0QGu+6n75E1zBAaFkYnLH1zWkaPQxLo4ZKwboG6SvMfo+MngMb/Di27PQ4yUQXm
         eMzNyDoL8dGFnhfeJVwkFGUYWJMpb9+R+JLaFa5GS9uWf9bmcm+PSMUIPgihFEqNLccz
         xJR+T6ANL6SlJ63XDqy1ag2bhsnddDoStnVlCkQIAphrI7XiAAE2NiqRw3mxricyLEsU
         SUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681018369; x=1683610369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/loUi7ti8pVU3DBwVEkivFgAvOa2p4v5kqrybReGW4=;
        b=J9J7xFH0vJ29UHu67ITx717fr35/JzQ7GrQXvQyn22visCA1Bf1aM56xUoDA9HnHx6
         zWaTcZ8moXk+iB+XPMhf83eIqKZ3+PE93WsyT1Eo0yh5qvPaKfqs7UY91ruPK210hyLZ
         U3HlM67ogjr/62IDBQQquqMVaM2eG7GYd3O3MP4sKALqgNE3FEOh5tYuJpVC9USg8ZNy
         DHwG00aQwko21d2HQZ1vqMVRftCrqTowEkUFm4bWNSV15uoEqrCqWZM6iXbuL2Y0na2Z
         UuPpdWfErHpSxSWzRjNEqlROkHB6E0sTH3hzsdej/nTg8eyBm3aoKqWqjjyJjHDbuDPU
         tR3Q==
X-Gm-Message-State: AAQBX9efnTqNiytw144iCFqLah/bgA98H6B3Jb83P/TuotXoZ96VgTqI
        jG3dOuXlD2UsTd2WSNi5iArqGSxtVQlPZ/wzH3g=
X-Google-Smtp-Source: AKy350YpBiWxAGXnuVOasQHWmSGGOWaSkCuTvWRL3erY12Oxo/epOqhD7kDMCMsbX97GwKZk+WwEk7evspcj+VG0CsY=
X-Received: by 2002:a05:622a:1a12:b0:3d8:2cb6:d21d with SMTP id
 f18-20020a05622a1a1200b003d82cb6d21dmr2636904qtb.6.1681018369196; Sat, 08 Apr
 2023 22:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230321020103.13494-1-laoar.shao@gmail.com> <20230321101711.625d0ccb@gandalf.local.home>
 <CALOAHbAfQxAMQTwDHnMOLHDfz=Mo0gFwu9i3bS0emttUTodA4g@mail.gmail.com>
 <20230323083914.31f76c2b@gandalf.local.home> <CALOAHbDtM7KuiRn1n9EBYrSGqJmOYcY6voVRfF+QGN510W_OtQ@mail.gmail.com>
 <20230323230105.57c40232@rorschach.local.home>
In-Reply-To: <20230323230105.57c40232@rorschach.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 9 Apr 2023 13:32:12 +0800
Message-ID: <CALOAHbCZSY2XJpzJ+AxSrRLbMqyoJjcaXeof-xMLN8y+uB7PJg@mail.gmail.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 24, 2023 at 11:01=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Fri, 24 Mar 2023 10:51:49 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > On Thu, Mar 23, 2023 at 8:39=E2=80=AFPM Steven Rostedt <rostedt@goodmis=
.org> wrote:
> > >
> > > On Thu, 23 Mar 2023 13:59:34 +0800
> > > Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > > I have verified the latest linux-trace tree,
> > > >     git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace=
.git
> > > > trace/core
> > > >
> > > > The result of "uname -r" is ''6.3.0-rc3+".
> > > > This issue still exists, and after applying this patch it disappear=
s.
> > > > It can be reproduced with a simple bpf program as follows,
> > > >     SEC("kprobe.multi/preempt_count_sub")
> > > >     int fprobe_test()
> > > >     {
> > > >         return 0;
> > > >     }
> > >
> > > Still your patch is hiding a bug, not fixing one.
> > >
> > > Can you apply this patch and see if the bug goes away?
> > >
> >
> > I have verified that the bug goes away after applying this patch.
> > Thanks for the fix.
> >
>
> It's in tip:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=
=3Dx86/urgent&id=3Df87d28673b71b35b248231a2086f9404afbb7f28
>
> Hopefully it will make it to mainline soon.
>

Hi Steven,

When I was trying to attach fentry to preempt_count_{sub,add}, the
kernel just crashed. The crash info as follows,

[  867.843050] BUG: TASK stack guard page was hit at 0000000009d325cf
(stack is 0000000046a46a15..00000000537e7b28)
[  867.843064] stack guard page: 0000 [#1] PREEMPT SMP NOPTI
[  867.843067] CPU: 8 PID: 11009 Comm: trace Kdump: loaded Not tainted 6.2.=
0+ #4
[  867.843071] RIP: 0010:exc_int3+0x6/0xe0
[  867.843078] Code: e9 a6 fe ff ff e8 6a 3d 00 00 66 2e 0f 1f 84 00
00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 48 89
e5 41 55 <41> 54 49 89 fc e8 10 11 00 00 85 c0 75 31 4c 89 e7 41 f6 84
24 88
[  867.843080] RSP: 0018:ffffaaac44f1c000 EFLAGS: 00010093
[  867.843083] RAX: ffffaaac44f1c018 RBX: 0000000000000000 RCX: ffffffff98e=
0102d
[  867.843085] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffaaac44f=
1c018
[  867.843086] RBP: ffffaaac44f1c008 R08: 0000000000000000 R09: 00000000000=
00000
[  867.843087] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[  867.843089] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[  867.843092] FS:  00007f8af6fbe740(0000) GS:ffff96d77f800000(0000)
knlGS:0000000000000000
[  867.843094] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  867.843096] CR2: ffffaaac44f1bff8 CR3: 0000000105a9c002 CR4: 00000000007=
70ee0
[  867.843097] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  867.843098] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  867.843099] PKRU: 55555554
[  867.843100] Call Trace:
[  867.843101]  <TASK>
[  867.843104]  asm_exc_int3+0x3a/0x40
[  867.843108] RIP: 0010:preempt_count_sub+0x1/0xa0
[  867.843112] Code: c7 c7 40 06 ff 9a 48 89 e5 e8 8b c6 1d 00 5d c3
cc cc cc cc 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 cc <1f> 44 00 00 55 8b 0d 2c 60 f0 02 48 89 e5 85 c9 75 1b 65 8b
05 4e
[  867.843113] RSP: 0018:ffffaaac44f1c0f0 EFLAGS: 00000002
[  867.843115] RAX: 0000000000000001 RBX: ffff96d77f82c380 RCX: 00000000000=
00000
[  867.843116] RDX: 0000000000000000 RSI: ffffffff9947d6fd RDI: 00000000000=
00001
[  867.843117] RBP: ffffaaac44f1c108 R08: 0000000000000020 R09: 00000000000=
00000
[  867.843118] R10: 0000000000000000 R11: 0000000040000000 R12: ffff96c886c=
3c000
[  867.843119] R13: 0000000000000009 R14: ffff96c880050000 R15: ffff96c8800=
504b8
[  867.843128]  ? preempt_count_sub+0x1/0xa0
[  867.843131]  ? migrate_disable+0x77/0x90
[  867.843135]  __bpf_prog_enter_recur+0x17/0x90
[  867.843148]  bpf_trampoline_6442468108_0+0x2e/0x1000
[  867.843154]  ? preempt_count_sub+0x1/0xa0
[  867.843157]  preempt_count_sub+0x5/0xa0
[  867.843159]  ? migrate_enable+0xac/0xf0
[  867.843164]  __bpf_prog_exit_recur+0x2d/0x40
[  867.843168]  bpf_trampoline_6442468108_0+0x55/0x1000
...
[  867.843788]  preempt_count_sub+0x5/0xa0
[  867.843793]  ? migrate_enable+0xac/0xf0
[  867.843829]  __bpf_prog_exit_recur+0x2d/0x40
[  867.843837] BUG: IRQ stack guard page was hit at 0000000099bd8228
(stack is 00000000b23e2bc4..000000006d95af35)
[  867.843841] BUG: IRQ stack guard page was hit at 000000005ae07924
(stack is 00000000ffd69623..0000000014eb594c)
[  867.843843] BUG: IRQ stack guard page was hit at 00000000028320f0
(stack is 00000000034b6438..0000000078d1bcec)
[  867.843842]  bpf_trampoline_6442468108_0+0x55/0x1000
[  867.843845] BUG: IRQ stack guard page was hit at 00000000eb4e0327
(stack is 0000000051fdb66e..000000000b8aec75)
[  867.843868] BUG: IRQ stack guard page was hit at 00000000bc042b0f
(stack is 00000000c47a7d1a..00000000dbf95de4)
[  867.843879]  preempt_count_sub+0x5/0xa0
[  867.843883]  ? migrate_enable+0xac/0xf0
[  867.843884] BUG: IRQ stack guard page was hit at 0000000057cdfb36
(stack is 00000000891fe30a..00000000ec0deb36)
[  867.843885] BUG: IRQ stack guard page was hit at 00000000fe8f1d98
(stack is 000000001dd7c502..0000000012a36ba8)
[  867.843896] BUG: IRQ stack guard page was hit at 000000000142218d
(stack is 000000003183818c..00000000e07aa409)
[  867.843905]  __bpf_prog_exit_recur+0x2d/0x40
[  867.843908] BUG: IRQ stack guard page was hit at 00000000cb520206
(stack is 00000000c91ca3c1..000000009babc41a)
[  867.843916]  bpf_trampoline_6442468108_0+0x55/0x1000
[  867.843922] BUG: IRQ stack guard page was hit at 00000000f11fb13e
(stack is 000000001783e178..0000000081ea69f6)
[  867.843928] BUG: IRQ stack guard page was hit at 000000004595335f
(stack is 00000000fb0c1e0a..00000000709006eb)
[  867.843928] BUG: IRQ stack guard page was hit at 000000002e4f1f60
(stack is 0000000058872888..00000000a19cf709)
[  867.843935] BUG: IRQ stack guard page was hit at 000000008565ee1f
(stack is 000000001fb0ab41..000000005f350279)
[  867.843935] BUG: IRQ stack guard page was hit at 00000000f5b6f09c
(stack is 00000000c559990d..000000009d9c1743)
[  867.843936] BUG: IRQ stack guard page was hit at 000000007e7f0f94
(stack is 00000000fdf8aa59..000000007bc6ea3c)
[  867.843938]  preempt_count_sub+0x5/0xa0
[  867.843941] BUG: IRQ stack guard page was hit at 0000000059318181
(stack is 0000000090d665e0..000000003fd542c0)
[  867.843944]  ? migrate_enable+0xac/0xf0
[  867.843954] BUG: IRQ stack guard page was hit at 00000000ad5083b1
(stack is 00000000461d91de..000000007d780ece)
[  867.843957]  __bpf_prog_exit_recur+0x2d/0x40
[  867.843956] BUG: IRQ stack guard page was hit at 00000000d3cb4856
(stack is 000000003c68a653..0000000008d44434)
[  867.843958] BUG: IRQ stack guard page was hit at 00000000603028eb
(stack is 0000000004727704..00000000c9a13aea)
[  867.843962] BUG: IRQ stack guard page was hit at 000000002ec0341b
(stack is 000000005380b682..00000000ebf37ef3)
[  867.843962] BUG: IRQ stack guard page was hit at 00000000b1fdeb3b
(stack is 000000005165c122..000000009bb21a76)
[  867.843963]  bpf_trampoline_6442468108_0+0x55/0x1000
[  867.843965] BUG: IRQ stack guard page was hit at 00000000b346fffe
(stack is 00000000a66e8ebf..00000000dc1301b4)
[  867.843967] BUG: IRQ stack guard page was hit at 0000000091f94ea6
(stack is 0000000027387f08..00000000e26754af)
[  867.843970] BUG: IRQ stack guard page was hit at 000000003db0b944
(stack is 00000000461caa85..00000000ec9e1206)
[  867.843969] BUG: IRQ stack guard page was hit at 00000000805a1c05
(stack is 000000008babf572..0000000050ea07c6)
[  867.843971]  preempt_count_sub+0x5/0xa0
[  867.843971] BUG: IRQ stack guard page was hit at 00000000bc064bef
(stack is 000000000af91875..00000000199ce5b2)
[  867.843974]  ? migrate_enable+0xac/0xf0
[  867.843975] BUG: IRQ stack guard page was hit at 00000000ca074a82
(stack is 0000000044474ecd..00000000a7810d3e)
[  867.843976] BUG: IRQ stack guard page was hit at 00000000fa662e1f
(stack is 00000000664c1004..0000000058f78c52)
[  867.843975] BUG: IRQ stack guard page was hit at 000000003fb16f99
(stack is 00000000e1751c78..0000000068b06279)
[  867.843978] BUG: IRQ stack guard page was hit at 000000002e4315e3
(stack is 00000000daa8a157..00000000cfd7e703)
[  867.843979]  __bpf_prog_exit_recur+0x2d/0x40
[  867.843979] BUG: IRQ stack guard page was hit at 000000009404a418
(stack is 0000000029b3d6a5..00000000b47c3671)
[  867.843983]  bpf_trampoline_6442468108_0+0x55/0x1000
[  867.843990]  preempt_count_sub+0x5/0xa0
[  867.843992]  ? migrate_enable+0xac/0xf0
[  867.843997]  __bpf_prog_exit_recur+0x2d/0x40
...
[  867.845387]  bpf_trampoline_6442468108_0+0x55/0x1000
[  867.845394]  preempt_count_sub+0x5/0xa0
[  867.845396]  ? migrate_enable+0xac/0xf0
[  867.845401]  __bpf_prog_exit_recur+0x2d/0x40
[  867.845404]  bpf_trampoline_6442468108_0+0x55/0x1000
[  867.845411]  preempt_count_sub+0x5/0xa0
[  867.845413]  ? flush_tlb_mm_range+0x11b/0x190
[  867.845417]  ? __pfx_preempt_count_sub+0x10/0x10
[  867.845421]  __text_poke+0x2c0/0x460
[  867.845426]  ? __pfx_text_poke_memcpy+0x10/0x10
[  867.845431]  text_poke_bp_batch+0x8c/0x2d0
[  867.845434]  ? __static_call_text_end+0x96a68/0x1ca748
[  867.845440]  text_poke_finish+0x1f/0x40
[  867.845442]  ftrace_replace_code+0x1a1/0x1f0
[  867.845448]  ftrace_modify_all_code+0xc6/0x180
[  867.845454]  arch_ftrace_update_code+0x9/0x10
[  867.845456]  ftrace_startup+0xd7/0x190
[  867.845459]  ? 0xffffffffc0556000
[  867.845468]  register_ftrace_direct_multi+0x22e/0x250
[  867.845475]  ? 0xffffffffc0556000
[  867.845478]  bpf_trampoline_update+0x28a/0x4c0
[  867.845481]  ? __pfx_preempt_count_sub+0x10/0x10
[  867.845486]  __bpf_trampoline_link_prog+0xd3/0x1d0
[  867.845490]  bpf_trampoline_link_prog+0x2c/0x50
[  867.845494]  bpf_tracing_prog_attach+0x3ab/0x5d0
[  867.845498]  ? trace_hardirqs_off+0x10/0x20
[  867.845508]  link_create+0x11d/0x260
[  867.845510]  ? security_bpf+0x32/0x50
[  867.845518]  __sys_bpf+0x6e6/0xdb0
[  867.845530]  __x64_sys_bpf+0x1a/0x30
[  867.845532]  do_syscall_64+0x38/0x90
[  867.845536]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  867.845538] RIP: 0033:0x7f8af60f8e29
[  867.845542] Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 17 e0 2c 00 f7 d8 64 89
01 48
[  867.845543] RSP: 002b:00007ffcf51a64e8 EFLAGS: 00000246 ORIG_RAX:
0000000000000141
[  867.845546] RAX: ffffffffffffffda RBX: 00007ffcf51a65d0 RCX: 00007f8af60=
f8e29
[  867.845547] RDX: 0000000000000030 RSI: 00007ffcf51a6500 RDI: 00000000000=
0001c
[  867.845549] RBP: 0000000000000018 R08: 0000000000000020 R09: 00000000000=
00000
[  867.845550] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00006
[  867.845551] R13: 0000000000000006 R14: 0000000000922010 R15: 00000000000=
00000
[  867.845561]  </TASK>

The reason is that we will call migrate_disable before entering bpf prog
and call migrate_enable after bpf prog exits. In
migrate_disable, preempt_count_{add,sub} will be called, so the bpf prog
will end up with dead looping there. We can't avoid calling
preempt_count_{add,sub} in this procedure, so we have to hide them
from ftrace, then they can't be traced.

So I think we'd better fix it with below change,  what do you think ?

---
 kernel/sched/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index af017e0..b049a07 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5758,7 +5758,7 @@ static inline void preempt_latency_start(int val)
  }
 }

-void preempt_count_add(int val)
+void notrace preempt_count_add(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
  /*
@@ -5778,7 +5778,6 @@ void preempt_count_add(int val)
  preempt_latency_start(val);
 }
 EXPORT_SYMBOL(preempt_count_add);
-NOKPROBE_SYMBOL(preempt_count_add);

 /*
  * If the value passed in equals to the current preempt count
@@ -5790,7 +5789,7 @@ static inline void preempt_latency_stop(int val)
  trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 }

-void preempt_count_sub(int val)
+void notrace preempt_count_sub(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
  /*
@@ -5810,7 +5809,6 @@ void preempt_count_sub(int val)
  __preempt_count_sub(val);
 }
 EXPORT_SYMBOL(preempt_count_sub);
-NOKPROBE_SYMBOL(preempt_count_sub);

 #else
 static inline void preempt_latency_start(int val) { }
--=20


--=20
Regards
Yafang
