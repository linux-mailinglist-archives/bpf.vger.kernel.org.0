Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81234D721D
	for <lists+bpf@lfdr.de>; Sun, 13 Mar 2022 02:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiCMBe6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Mar 2022 20:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiCMBe5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Mar 2022 20:34:57 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A778FC12DA;
        Sat, 12 Mar 2022 17:33:50 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t187so10722855pgb.1;
        Sat, 12 Mar 2022 17:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wfi4ctijibqWCWsXjRfkrJ7FMy5E8Dznl3LmIcb+xgo=;
        b=gY6XHp2kyOHeAUIH7oScmhWt8hGxT2vGiAC0af6f7VSKyAuEN/E+sQP5eQr/3yODyq
         f1qh+UqWwWZ4pQ1FLqI4petUNzmIN7MhRh05B542bz4NiKtBsSp/V0jEzkjLQEUqsl5D
         qVEvnNjWsfX11KksktgmAY6lrhnZPv+jw5ktmmXpjp3fsuHtRbMepMFt1jzyf2sXcykH
         ZflTUrVl7s1mTV92xApgdkU9H1Uvs4YDZhGPCYoeZvRCv/qOpW0K4pUUfo4hbwLXDX2j
         /LGBvV9sFfVyKmqz+oeLl5Z4FfFotHB/ErIsA0YMsrSSL6yJDiY4iyUuwF/35/W1br9O
         vixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfi4ctijibqWCWsXjRfkrJ7FMy5E8Dznl3LmIcb+xgo=;
        b=XavheADMKekXSHr2LSs2X6Rf3nKaGe+1/6t1cXv8Cm2EXGIkMsk9EckjlaJSVc2aiO
         rvJ0Wu6Lh75Hw56u+rWXHNz3hDM5chJt0dGcqFSRnmkkGy+28jERlK0v0Z53Lwi1HW0/
         Ol+iUyAl6HJAXld2QPFrxgA8PXDHeLwAjbL/azNkD0BNZdG8At8QXygFR/uADGjW/3d3
         uUb893L+8009tSC0yc9IRY/MKxD5RmMyBehwjFoW3BWrKg586h8KeSruNXPB6VvyPgHA
         Op/j39YiokEiyIuTFbNK8B82XnBeeHYRX4HJ6Or8cE8+rDAB7N939Z22TGvAthT26TU+
         cBeA==
X-Gm-Message-State: AOAM533MkyRONfJTAs+QxpDNdNUieTthpLx4Udc9hZB+jZDH/PyARiV5
        5+sDiJop8jAWBYszbsjlYfhZlvOExg2KwGUnPAg=
X-Google-Smtp-Source: ABdhPJyJg8Nl5h/vtWOxbyvW+VmgAqIBQeDDdrTBeAhx728iFqqdoIGetYtqOR88JIBPpduewibovwPucDYJH02wM+4=
X-Received: by 2002:a05:6a00:1146:b0:4c9:ede0:725a with SMTP id
 b6-20020a056a00114600b004c9ede0725amr17399430pfm.35.1647135230081; Sat, 12
 Mar 2022 17:33:50 -0800 (PST)
MIME-Version: 1.0
References: <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
 <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net> <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net> <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net> <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net> <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com> <20220312154407.GF28057@worktop.programming.kicks-ass.net>
In-Reply-To: <20220312154407.GF28057@worktop.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 12 Mar 2022 17:33:39 -0800
Message-ID: <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
To:     Peter Zijlstra <peterz@infradead.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     X86 ML <x86@kernel.org>, joao@overdrivepizza.com,
        hjl.tools@gmail.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>, alyssa.milburn@intel.com,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
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

On Sat, Mar 12, 2022 at 7:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Mar 11, 2022 at 09:09:38AM -0800, Alexei Starovoitov wrote:
> > On Fri, Mar 11, 2022 at 2:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Mar 10, 2022 at 05:29:11PM +0100, Peter Zijlstra wrote:
> > >
> > > > This seems to cure most of the rest. I'm still seeing one failure:
> > > >
> > > > libbpf: prog 'connect_v4_prog': BPF program load failed: Invalid argument
> > > > libbpf: failed to load program 'connect_v4_prog'
> > > > libbpf: failed to load object './connect4_prog.o'
> > > > test_fexit_bpf2bpf_common:FAIL:tgt_prog_load unexpected error: -22 (errno 22)
> > > > #48/4 fexit_bpf2bpf/func_replace_verify:FAIL
> > >
> > >
> > > Hmm, with those two patches on I get:
> > >
> > > root@tigerlake:/usr/src/linux-2.6/tgl-build# ./test_progs -t fexit
> > > #46 fentry_fexit:OK
> > > #48 fexit_bpf2bpf:OK
> > > #49 fexit_sleep:OK
> > > #50 fexit_stress:OK
> > > #51 fexit_test:OK
> > > Summary: 5/9 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > On the tigerlake, I suppose I'm doing something wrong on the other
> > > machine because there it's even failing on the pre-ibt kernel image.
> > >
> > > I'll go write up changelogs and stick these on.
> >
> > What is the latest branch I can use to test it?
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/ibt
>
> that also include bpf-next. Thanks!

Looks better.
During the build with gcc 8.5 I see:

arch/x86/crypto/crc32c-intel.o: warning: objtool: file already has
.ibt_endbr_seal, skipping
arch/x86/crypto/crc32c-intel.o: warning: objtool: file already has
.orc_unwind section, skipping
  LD [M]  crypto/async_tx/async_xor.ko
  LD [M]  crypto/authenc.ko
make[3]: *** [../scripts/Makefile.modfinal:61:
arch/x86/crypto/crc32c-intel.ko] Error 255
make[3]: *** Waiting for unfinished jobs....

but make clean cures it.
I suspect it's some missing makefile dependency.

and:
vmlinux.o: warning: objtool: ksys_unshare()+0x626: unreachable instruction
which stays even after make clean.

The rcu "false positive" is still there that causes
sporadic hangs during the boot.

The test_progs shows:
Summary: 228/1122 PASSED, 4 SKIPPED, 6 FAILED
(when I remove one test)

That test is actually crashing the kernel:
./test_progs -t mod_race
[   39.202593] bpf_testmod: loading out-of-tree module taints kernel.
[   39.303142] general protection fault, probably for non-canonical
address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
[   39.304610] KASAN: null-ptr-deref in range
[0x0000000000000000-0x0000000000000007]
[   39.305514] CPU: 9 PID: 1599 Comm: test_progs Tainted: G
O      5.17.0-rc7-02525-g5dd5efb53cf1 #4
[   39.306675] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[   39.308036] RIP: 0010:do_init_module+0x9/0x6f0
[   39.308583] Code: fe ff ff e8 59 13 46 00 e9 7f fe ff ff e8 4f 13
46 00 e9 49 fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 e8 cb 8d eb 1e 48
b8 00 00 <00> 00 00 fc ff df 41 57 49 89 ff 48 c7 c7 20 f6 5c 84 48 89
fa 41
[   39.310815] RSP: 0018:ffff88810f7e7aa0 EFLAGS: 00010282
[   39.311450] RAX: dffffc0000000000 RBX: 0000000000000009 RCX: ffffffff81283b16
[   39.312253] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffffa0224c00
[   39.313031] RBP: ffff88810f7e7ac8 R08: 0000000000000000 R09: fffffbfff0b4d557
[   39.313813] R10: ffffffff85a6aab7 R11: fffffbfff0b4d556 R12: ffff88811171f518
[   39.314591] R13: dffffc0000000000 R14: ffffffffa0224c00 R15: ffff88810f7e7e50
[   39.315374] FS:  00007f8e1b981700(0000) GS:ffff8881f6a80000(0000)
knlGS:0000000000000000
[   39.316293] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.316984] CR2: 00007fdf39350ff0 CR3: 000000011952e006 CR4: 00000000003706e0
[   39.317860] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   39.318680] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   39.319467] Call Trace:
[   39.319744]  <TASK>
[   39.319982]  bpf_trampoline_6442471603_0+0x32/0x1000
[   39.320537]  do_init_module+0x5/0x6f0
[   39.320945]  load_module+0x77c0/0x9c00
[   39.321376]  ? module_frob_arch_sections+0x20/0x20
[   39.321892]  ? ima_post_read_file+0x161/0x180
[   39.322392]  ? ima_read_file+0x140/0x140
[   39.322827]  ? security_kernel_post_read_file+0x55/0xb0
[   39.323406]  ? __x64_sys_fsconfig+0x630/0x630
[   39.323889]  ? fput_many+0x1e/0x120
[   39.324285]  ? __do_sys_finit_module+0xf3/0x150
[   39.324822]  __do_sys_finit_module+0xf3/0x150
[   39.325311]  ? __ia32_sys_init_module+0xb0/0xb0
[   39.325826]  ? rcu_read_lock_held_common+0xe/0xa0
[   39.326349]  ? rcu_read_lock_sched_held+0x5a/0xc0
[   39.326869]  ? rcu_read_lock_bh_held+0xa0/0xa0
[   39.327362]  ? file_open_root+0x1f0/0x1f0
[   39.327812]  ? syscall_trace_enter.isra.17+0x184/0x250
[   39.328411]  do_syscall_64+0x38/0x80
[   39.328812]  entry_SYSCALL_64_after_hwframe+0x44/0xae

The test was designed to check whether the kernel bug is fixed.
If not it would crash the kernel.

Kumar,
you've added that test.
Could you please take a look at why it is crashing in Peter's tree?
