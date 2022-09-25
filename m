Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A145E9642
	for <lists+bpf@lfdr.de>; Sun, 25 Sep 2022 23:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiIYV4C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Sep 2022 17:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIYV4A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Sep 2022 17:56:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7242613C;
        Sun, 25 Sep 2022 14:55:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e18so6730006edj.3;
        Sun, 25 Sep 2022 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Nq7MnhcvX99bKKf80P+sMU5/an01GxgPdCrj+THEd8g=;
        b=VvqYJYXgsLF7ULOw6t9V9+QnvXBOeIJxdQYZqa0GjB8tj/jcg0Mz9Ml0iGM7wW9ZSO
         9xjbbnYM0mxJoAQOB/DauXUJEbDCseh8avW7A68QVORhh1VrB9RprwIF5sXXzI4aeNTP
         yuZTJdtduyXKVK90K8m1jEs6cbZPje3ZDuKeyxlVbKZkgSHVgrv5KADgZjBtIQ0IP9+E
         TMIy1QXq/g5263WGDSfss98npfONbPBl/VA0nzQM2gb2FHqngkdUM/GEG5idA6j8r2eB
         wDoR9ey9dG++RuzigfPA+Bdd2KLfRnhnpbKskXDOv7narSUaG0X6+Hp0HWBT7RHPrcX3
         Z7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Nq7MnhcvX99bKKf80P+sMU5/an01GxgPdCrj+THEd8g=;
        b=hoMuNUM3jLn9DmOgBLp/dAO2ruqdYJIPCHDmIQJxnz+0D8S0XjQuBL002qRdSM3GVD
         fk10JigaRlcn4D9GiJ9XUXedDBzT0REiX9Tv6sJYmNY2D4uAGPXKk5dORhby8f/YNq3b
         QFKo79R6ABsqU1nym2b+fL7NCnpCv79RzKbtfUcHojPriU066WYUZieYddnt/wLiacwp
         mwC3LsmyZPswe0+JCKtC9lEaRD93Gvn0eZHu3K9/03Ym4IIKxF5WrUTL70Bv1VC0urX8
         eHI/8Yk9Hewy0B57j0LsvuqvEs6rg0qhq2QCwsPDBGbIidnZr7o/B6zKd5V89aykLX5x
         d1kQ==
X-Gm-Message-State: ACrzQf0lcAGfa5vjlKfBZV34ClpcL3u7ehD3KjkCs+scZ/SLGG7mV4ZB
        bFolA8CCgua91JarBThJAeEIpsc5GAAd19pJ7xk=
X-Google-Smtp-Source: AMsMyM5QTYJcKp1XqmsgafDf1EDpvbjs61jfb79OZ5M65Ybs+IkZrmY3iem/gU8LiyHCtk0nqCSJwvsaQQecxAoOokU=
X-Received: by 2002:a05:6402:54b:b0:457:3b62:306a with SMTP id
 i11-20020a056402054b00b004573b62306amr3366795edx.6.1664142957473; Sun, 25 Sep
 2022 14:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000076f3a305e97e9229@google.com> <a68d118d-ee03-399c-df02-82848e2197a2@intel.com>
In-Reply-To: <a68d118d-ee03-399c-df02-82848e2197a2@intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 25 Sep 2022 14:55:46 -0700
Message-ID: <CAADnVQ+SpNuUSRFte2Lm13QZiTXcWfn2eZw5Q+MP0SKwuJEXFg@mail.gmail.com>
Subject: Re: [syzbot] WARNING in __change_page_attr_set_clr
To:     Dave Hansen <dave.hansen@intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 25, 2022 at 9:44 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 9/25/22 04:18, syzbot wrote:
> > ------------[ cut here ]------------
> > CPA refuse W^X violation: 8000000000000163 -> 0000000000000163 range: 0xffffffffa0401000 - 0xffffffffa0401fff PFN 7d8d5
> > WARNING: CPU: 0 PID: 3607 at arch/x86/mm/pat/set_memory.c:600 verify_rwx arch/x86/mm/pat/set_memory.c:600 [inline]
> > WARNING: CPU: 0 PID: 3607 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr arch/x86/mm/pat/set_memory.c:1569 [inline]
> > WARNING: CPU: 0 PID: 3607 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr_set_clr+0x1f40/0x2020 arch/x86/mm/pat/set_memory.c:1691
> > Modules linked in:
>
> Yay, one of these that isn't due to wonky 32-bit kernels!
>
> This one looks to be naughty intentionally:
>
> > void *bpf_jit_alloc_exec_page(void)
> > {
> ...
> >         /* Keep image as writeable. The alternative is to keep flipping ro/rw
> >          * every time new program is attached or detached.
> >          */
> >         set_memory_x((long)image, 1);
> >         return image;
> > }
>
> For STRICT_KERNEL_RWX kernels, I think we would really rather that this
> code *did* flip ro/rw every time a new BPF program is attached or detached.

Steven Rostedt noticed that comment around the middle of August
and told you and Peter about it.
Then Peter added a WARN_ONCE in commit
https://lore.kernel.org/all/YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net/
to explicitly trigger that known issue.
Sure enough the fedora fails to boot on linux-next since then,
because systemd is loading bpf programs that use bpf trampoline.
The boot issue was was reported 3 days ago:
https://lore.kernel.org/bpf/c84cc27c1a5031a003039748c3c099732a718aec.camel@kernel.org/T/#u
Now we're trying to urgently address it with:
https://lore.kernel.org/bpf/20220923211837.3044723-1-song@kernel.org/

So instead of pinging us with your w^x concern you've decided
to fail hard in -next to force the issue and
now acting like this is something surprising to you?!

This is Code of Conduct "worthy" behavior demonstrated
by a newly elected member of the Technical Advisory Board.
Please consider resigning.
A TAB member should be better than this.

As far as this w^x issue...
we've communicated back in May 2022 (sorry I cannot find the link
to that discussion) that bpf_prog_pack is targeting to be used
by everything bpf. Currently by bpf progs only.
bpf trampoline and bpf dispatcher were next on the list.
But then folks expressed the desire to generalize bpf_prog_pack for
everything: bpf, modules and all other trampolines.
We've posted multiple revisions and kept pinging for feedback.
The last one on Aug 24:
https://lkml.org/lkml/2022/8/24/857
If/when the generic vmalloc_exec lands we can finally close
the issue for modules, bpf progs, and trampolines of all kinds.
Make them fast by using large pages and w^x compliant.

And, sorry, "flip ro/rw every time" is not a good idea from
security pov.
There is a much better solution that stalled on the code review.
In the meantime we'll land a quick fix to re-enable boot in -next
in the coming days.
