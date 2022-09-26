Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FF55EA954
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 16:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiIZO5T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 26 Sep 2022 10:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiIZO4j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 10:56:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C142857205;
        Mon, 26 Sep 2022 06:27:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23BE4CE115A;
        Mon, 26 Sep 2022 13:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A53C433D6;
        Mon, 26 Sep 2022 13:27:35 +0000 (UTC)
Date:   Mon, 26 Sep 2022 09:28:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        tech-board@lists.linuxfoundation.org,
        Song Liu <songliubraving@fb.com>,
        Kernel Team <Kernel-team@fb.com>, jane.chu@oracle.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, brijesh.singh@amd.com,
        "open list:BPF \(Safe dynamic programs and tools\)" 
        <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>, seanjc@google.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [Tech-board] [syzbot] WARNING in __change_page_attr_set_clr
Message-ID: <20220926092843.75a4b751@gandalf.local.home>
In-Reply-To: <CAADnVQ+SpNuUSRFte2Lm13QZiTXcWfn2eZw5Q+MP0SKwuJEXFg@mail.gmail.com>
References: <00000000000076f3a305e97e9229@google.com>
        <a68d118d-ee03-399c-df02-82848e2197a2@intel.com>
        <CAADnVQ+SpNuUSRFte2Lm13QZiTXcWfn2eZw5Q+MP0SKwuJEXFg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 25 Sep 2022 14:55:46 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Sun, Sep 25, 2022 at 9:44 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 9/25/22 04:18, syzbot wrote:  
> > > ------------[ cut here ]------------
> > > CPA refuse W^X violation: 8000000000000163 -> 0000000000000163 range: 0xffffffffa0401000 - 0xffffffffa0401fff PFN 7d8d5
> > > WARNING: CPU: 0 PID: 3607 at arch/x86/mm/pat/set_memory.c:600 verify_rwx arch/x86/mm/pat/set_memory.c:600 [inline]
> > > WARNING: CPU: 0 PID: 3607 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr arch/x86/mm/pat/set_memory.c:1569 [inline]
> > > WARNING: CPU: 0 PID: 3607 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr_set_clr+0x1f40/0x2020 arch/x86/mm/pat/set_memory.c:1691
> > > Modules linked in:  
> >
> > Yay, one of these that isn't due to wonky 32-bit kernels!
> >
> > This one looks to be naughty intentionally:
> >  
> > > void *bpf_jit_alloc_exec_page(void)
> > > {  
> > ...  
> > >         /* Keep image as writeable. The alternative is to keep flipping ro/rw
> > >          * every time new program is attached or detached.
> > >          */
> > >         set_memory_x((long)image, 1);
> > >         return image;
> > > }  
> >
> > For STRICT_KERNEL_RWX kernels, I think we would really rather that this
> > code *did* flip ro/rw every time a new BPF program is attached or detached.  
> 
> Steven Rostedt noticed that comment around the middle of August
> and told you and Peter about it.
> Then Peter added a WARN_ONCE in commit
> https://lore.kernel.org/all/YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net/
> to explicitly trigger that known issue.
> Sure enough the fedora fails to boot on linux-next since then,
> because systemd is loading bpf programs that use bpf trampoline.
> The boot issue was was reported 3 days ago:
> https://lore.kernel.org/bpf/c84cc27c1a5031a003039748c3c099732a718aec.camel@kernel.org/T/#u
> Now we're trying to urgently address it with:
> https://lore.kernel.org/bpf/20220923211837.3044723-1-song@kernel.org/
> 
> So instead of pinging us with your w^x concern you've decided
> to fail hard in -next to force the issue and
> now acting like this is something surprising to you?!
> 
> This is Code of Conduct "worthy" behavior demonstrated

Here's the link to the Code of Conduct:

https://www.kernel.org/doc/html/latest/process/code-of-conduct.html

Which states:

  Examples of behavior that contributes to creating a positive environment include:

    - Using welcoming and inclusive language
    - Being respectful of differing viewpoints and experiences
    - Gracefully accepting constructive criticism
    - Focusing on what is best for the community
    - Showing empathy towards other community members

  Examples of unacceptable behavior by participants include:

    - The use of sexualized language or imagery and unwelcome sexual attention or advances
    - Trolling, insulting/derogatory comments, and personal or political attacks
    - Public or private harassment
    - Publishing others’ private information, such as a physical or electronic address, without explicit permission
    - Other conduct which could reasonably be considered inappropriate in a professional setting

I do not see how Dave's response is a violation of any of the above.


> by a newly elected member of the Technical Advisory Board.
> Please consider resigning.

Asking someone to resign is a personal attack, and that can be construed as
a violation of the Code of Conduct.

> A TAB member should be better than this.
> 

Let's please keep this on a technical level, as there appears to be a fix
we all can agree on, and let's move forward on that.

Thanks,

-- Steve
