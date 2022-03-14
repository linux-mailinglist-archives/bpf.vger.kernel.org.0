Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297AC4D8E67
	for <lists+bpf@lfdr.de>; Mon, 14 Mar 2022 21:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245137AbiCNUpV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 16:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245120AbiCNUpU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 16:45:20 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A63E38BE0;
        Mon, 14 Mar 2022 13:44:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s42so16081344pfg.0;
        Mon, 14 Mar 2022 13:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SjnxbE8lZQqadUpE7R641a/N8kIbPtJjoIDhn73vJKs=;
        b=jJ12l8435niXaD/TcwpgZuueLErmLpXnMPknwdE6bfHSoVzG/ij7pOG+t0c2cEIs1L
         AlVEOicwdiSTYxhW1UhvSWxHrzdu7nPrqCIDY0vKnffnC67Jo74YvJX5FcoS+go8W7lf
         yPpJrr8DDcj5MRmc5Rih+KPRAXG35X4j1po2fwSWoCEOX0QrOqkl7h/I5JXhHaB63VLc
         mzFvtJmabIZ1HarDSFe72fovRdvd0E9saOKZiQkJrFq0fHtb7pJl7Ui0Yp87YRvrweWZ
         tSP7Ey/Ecj+OoKK+qR06kvzh1n+ez0MwyuNnQxolt8PXmBtEqHYlUOVGF6gIHFyM4Z3m
         A9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SjnxbE8lZQqadUpE7R641a/N8kIbPtJjoIDhn73vJKs=;
        b=F2HQBsq5vCrYmKuMsc/IHpThJBQ3+5fOxAsLlB4xmbmlg8Bt1WIMo706CWf0aLnWpv
         QIODwDKnpWodDQN5TzTfh/9hTeI8XpdBv61TD4nn9lvQmF5M48kolpWUCbyT9B5o6i/v
         pKEH+H10RaOgZIrzK6mtcgnie+EdvwdMveyRiqWy+P4gHzkoKTMPiRi/5S/bDeGwaPQF
         XHzdmYtrdQ94z46QzNqzyJjmrTHYfOMX/QhNLqUijbjNmWR5tcumtGNU2Dg3RDGjouOf
         9Y7GjLr+RJ///i/60o4tdPmAnmZCS9cjKXLDaMRLT7OHYivyH55Q1ONkHrWcvy7zmwou
         hIkA==
X-Gm-Message-State: AOAM533vmbXME7OQTNv8IgwUrxXaDVnRVgRe9I/v7QtZaqFx6mGDTHkf
        BHE+p9nfDatuvsnUtjBc01Y=
X-Google-Smtp-Source: ABdhPJwlDuF/nG7u16gbtCXhTvkxcLXzhFA1pFYowzXN38RqwjQ23vbelIF6AdDNbaoADxvnwg5F2g==
X-Received: by 2002:a62:ee08:0:b0:4f6:b522:ca with SMTP id e8-20020a62ee08000000b004f6b52200camr25507997pfi.48.1647290649472;
        Mon, 14 Mar 2022 13:44:09 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a030300b001c17851b6a1sm376177pje.28.2022.03.14.13.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 13:44:08 -0700 (PDT)
Date:   Tue, 15 Mar 2022 02:14:02 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <20220314204402.rpd5hqzzev4ugtdt@apollo>
References: <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
 <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 13, 2022 at 07:03:39AM IST, Alexei Starovoitov wrote:
> On Sat, Mar 12, 2022 at 7:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Mar 11, 2022 at 09:09:38AM -0800, Alexei Starovoitov wrote:
> > > On Fri, Mar 11, 2022 at 2:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Thu, Mar 10, 2022 at 05:29:11PM +0100, Peter Zijlstra wrote:
> > > >
> > > > > This seems to cure most of the rest. I'm still seeing one failure:
> > > > >
> > > > > libbpf: prog 'connect_v4_prog': BPF program load failed: Invalid argument
> > > > > libbpf: failed to load program 'connect_v4_prog'
> > > > > libbpf: failed to load object './connect4_prog.o'
> > > > > test_fexit_bpf2bpf_common:FAIL:tgt_prog_load unexpected error: -22 (errno 22)
> > > > > #48/4 fexit_bpf2bpf/func_replace_verify:FAIL
> > > >
> > > >
> > > > Hmm, with those two patches on I get:
> > > >
> > > > root@tigerlake:/usr/src/linux-2.6/tgl-build# ./test_progs -t fexit
> > > > #46 fentry_fexit:OK
> > > > #48 fexit_bpf2bpf:OK
> > > > #49 fexit_sleep:OK
> > > > #50 fexit_stress:OK
> > > > #51 fexit_test:OK
> > > > Summary: 5/9 PASSED, 0 SKIPPED, 0 FAILED
> > > >
> > > > On the tigerlake, I suppose I'm doing something wrong on the other
> > > > machine because there it's even failing on the pre-ibt kernel image.
> > > >
> > > > I'll go write up changelogs and stick these on.
> > >
> > > What is the latest branch I can use to test it?
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/ibt
> >
> > that also include bpf-next. Thanks!
>
> Looks better.
> During the build with gcc 8.5 I see:
>
> arch/x86/crypto/crc32c-intel.o: warning: objtool: file already has
> .ibt_endbr_seal, skipping
> arch/x86/crypto/crc32c-intel.o: warning: objtool: file already has
> .orc_unwind section, skipping
>   LD [M]  crypto/async_tx/async_xor.ko
>   LD [M]  crypto/authenc.ko
> make[3]: *** [../scripts/Makefile.modfinal:61:
> arch/x86/crypto/crc32c-intel.ko] Error 255
> make[3]: *** Waiting for unfinished jobs....
>
> but make clean cures it.
> I suspect it's some missing makefile dependency.
>
> and:
> vmlinux.o: warning: objtool: ksys_unshare()+0x626: unreachable instruction
> which stays even after make clean.
>
> The rcu "false positive" is still there that causes
> sporadic hangs during the boot.
>
> The test_progs shows:
> Summary: 228/1122 PASSED, 4 SKIPPED, 6 FAILED
> (when I remove one test)
>
> That test is actually crashing the kernel:
> ./test_progs -t mod_race
> [   39.202593] bpf_testmod: loading out-of-tree module taints kernel.
> [   39.303142] general protection fault, probably for non-canonical
> address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
> [   39.304610] KASAN: null-ptr-deref in range
> [0x0000000000000000-0x0000000000000007]
> [   39.305514] CPU: 9 PID: 1599 Comm: test_progs Tainted: G
> O      5.17.0-rc7-02525-g5dd5efb53cf1 #4
> [   39.306675] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [   39.308036] RIP: 0010:do_init_module+0x9/0x6f0
> [   39.308583] Code: fe ff ff e8 59 13 46 00 e9 7f fe ff ff e8 4f 13
> 46 00 e9 49 fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 e8 cb 8d eb 1e 48
> b8 00 00 <00> 00 00 fc ff df 41 57 49 89 ff 48 c7 c7 20 f6 5c 84 48 89
> fa 41
> [   39.310815] RSP: 0018:ffff88810f7e7aa0 EFLAGS: 00010282
> [   39.311450] RAX: dffffc0000000000 RBX: 0000000000000009 RCX: ffffffff81283b16
> [   39.312253] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffffa0224c00
> [   39.313031] RBP: ffff88810f7e7ac8 R08: 0000000000000000 R09: fffffbfff0b4d557
> [   39.313813] R10: ffffffff85a6aab7 R11: fffffbfff0b4d556 R12: ffff88811171f518
> [   39.314591] R13: dffffc0000000000 R14: ffffffffa0224c00 R15: ffff88810f7e7e50
> [   39.315374] FS:  00007f8e1b981700(0000) GS:ffff8881f6a80000(0000)
> knlGS:0000000000000000
> [   39.316293] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   39.316984] CR2: 00007fdf39350ff0 CR3: 000000011952e006 CR4: 00000000003706e0
> [   39.317860] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   39.318680] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   39.319467] Call Trace:
> [   39.319744]  <TASK>
> [   39.319982]  bpf_trampoline_6442471603_0+0x32/0x1000
> [   39.320537]  do_init_module+0x5/0x6f0
> [   39.320945]  load_module+0x77c0/0x9c00
> [   39.321376]  ? module_frob_arch_sections+0x20/0x20
> [   39.321892]  ? ima_post_read_file+0x161/0x180
> [   39.322392]  ? ima_read_file+0x140/0x140
> [   39.322827]  ? security_kernel_post_read_file+0x55/0xb0
> [   39.323406]  ? __x64_sys_fsconfig+0x630/0x630
> [   39.323889]  ? fput_many+0x1e/0x120
> [   39.324285]  ? __do_sys_finit_module+0xf3/0x150
> [   39.324822]  __do_sys_finit_module+0xf3/0x150
> [   39.325311]  ? __ia32_sys_init_module+0xb0/0xb0
> [   39.325826]  ? rcu_read_lock_held_common+0xe/0xa0
> [   39.326349]  ? rcu_read_lock_sched_held+0x5a/0xc0
> [   39.326869]  ? rcu_read_lock_bh_held+0xa0/0xa0
> [   39.327362]  ? file_open_root+0x1f0/0x1f0
> [   39.327812]  ? syscall_trace_enter.isra.17+0x184/0x250
> [   39.328411]  do_syscall_64+0x38/0x80
> [   39.328812]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> The test was designed to check whether the kernel bug is fixed.
> If not it would crash the kernel.
>
> Kumar,
> you've added that test.
> Could you please take a look at why it is crashing in Peter's tree?

The crash does not seem to be resurfacing the bug, AFAICT.

[ Note: I have no experience with trampoline code or IBT so what follows might
	be incorrect. ]

In case of fexit and fmod_ret, we call original function (but skip
X86_PATCH_SIZE bytes), with ENDBR we must also skip those 4 bytes, but in some
cases like bpf_fentry_test1, for which this test has fmod_ret prog, compiler
(gcc 11) emits endbr64, but not for do_init_module, for which we do fexit.

This means for do_init_module module, orig_call += X86_PATCH_SIZE +
ENDBR_INSN_SIZE would skip more bytes than needed to emit call to original
function, which explains why I was seeing crash in the middle of
'mov edx, 0x10' instruction.

The diff below fixes the problem for me, and allows the test to pass.

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b98e1c95bcc4..760c9a3c075f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2031,11 +2031,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i

        ip_off = stack_size;

-       if (flags & BPF_TRAMP_F_SKIP_FRAME)
+       if (flags & BPF_TRAMP_F_SKIP_FRAME) {
                /* skip patched call instruction and point orig_call to actual
                 * body of the kernel function.
                 */
-               orig_call += X86_PATCH_SIZE + ENDBR_INSN_SIZE;
+               if (is_endbr(*(u32 *)orig_call))
+                       orig_call += ENDBR_INSN_SIZE;
+               orig_call += X86_PATCH_SIZE;
+       }

        prog = image;

--
Kartikeya
