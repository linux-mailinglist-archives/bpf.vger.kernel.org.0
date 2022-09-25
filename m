Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46455E96E4
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 01:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiIYXVh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Sep 2022 19:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiIYXVf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Sep 2022 19:21:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8146D2982C;
        Sun, 25 Sep 2022 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=VoMnbl/yC4fSqlCopgwm/mqk4gIbOdlbbIcobHH1MtA=; b=xGL0aD11N9pHmMy8pRruqzl71G
        fuT4BeLghdRGsbgxfFNtgPKgw1MSOn6acIDZ4eMfWSWUuj8uhRBT/6X8wCgAReXLOnyjx3pv1LZCs
        sN8kAiidG/EcKRv9V6IP9ZS1JgUYYxFeyPZc5wkaRm0+1CK9qhx5fC7MHOYBvuX9lAZdSqfYEGxSi
        mIADaiZILR8P95o62DGJyEcSB27POeLq/QX9ef1FuOpj3UPoHavQOAYgFZr+OEA84qFAktEYA0Bhs
        asfsUwlnF+vtN6xmgkCxmKdqL5Y6W8uhoma1X4N5wAXdstaEkBeN86Ar5vh00H3ecDaAT4IVTxxqh
        ZoJqY65Q==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocavt-000BGy-3B; Sun, 25 Sep 2022 23:21:09 +0000
Message-ID: <fce2a20f-4fe3-2fca-5666-0f804ed220c6@infradead.org>
Date:   Sun, 25 Sep 2022 16:21:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [syzbot] WARNING in __change_page_attr_set_clr
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        tech-board@lists.linuxfoundation.org,
        Song Liu <songliubraving@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Cc:     Borislav Petkov <bp@alien8.de>, brijesh.singh@amd.com,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, jane.chu@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, seanjc@google.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>
References: <00000000000076f3a305e97e9229@google.com>
 <a68d118d-ee03-399c-df02-82848e2197a2@intel.com>
 <CAADnVQ+SpNuUSRFte2Lm13QZiTXcWfn2eZw5Q+MP0SKwuJEXFg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAADnVQ+SpNuUSRFte2Lm13QZiTXcWfn2eZw5Q+MP0SKwuJEXFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/25/22 14:55, Alexei Starovoitov wrote:
> On Sun, Sep 25, 2022 at 9:44 AM Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> On 9/25/22 04:18, syzbot wrote:
>>> ------------[ cut here ]------------
>>> CPA refuse W^X violation: 8000000000000163 -> 0000000000000163 range: 0xffffffffa0401000 - 0xffffffffa0401fff PFN 7d8d5
>>> WARNING: CPU: 0 PID: 3607 at arch/x86/mm/pat/set_memory.c:600 verify_rwx arch/x86/mm/pat/set_memory.c:600 [inline]
>>> WARNING: CPU: 0 PID: 3607 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr arch/x86/mm/pat/set_memory.c:1569 [inline]
>>> WARNING: CPU: 0 PID: 3607 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr_set_clr+0x1f40/0x2020 arch/x86/mm/pat/set_memory.c:1691
>>> Modules linked in:
>>
>> Yay, one of these that isn't due to wonky 32-bit kernels!
>>
>> This one looks to be naughty intentionally:
>>
>>> void *bpf_jit_alloc_exec_page(void)
>>> {
>> ...
>>>         /* Keep image as writeable. The alternative is to keep flipping ro/rw
>>>          * every time new program is attached or detached.
>>>          */
>>>         set_memory_x((long)image, 1);
>>>         return image;
>>> }
>>
>> For STRICT_KERNEL_RWX kernels, I think we would really rather that this
>> code *did* flip ro/rw every time a new BPF program is attached or detached.
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
> by a newly elected member of the Technical Advisory Board.
> Please consider resigning.
> A TAB member should be better than this.

If it is (and I don't see it), just file a complaint.
Don't try to be the enforcer.

-- 
~Randy
