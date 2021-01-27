Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47003065A1
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 22:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhA0VI1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 16:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhA0VI0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 16:08:26 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138F2C061573
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 13:07:46 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id s61so107194ybi.4
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 13:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYu1ZRYBPKGSolP8R2Pl/pPVRmztWvNeFCWKXWsZruk=;
        b=GQLclByrw6FVMifNV3N9gY/yFvs4C5ZihOzT1IY4Tkn4UJQVUJs7F7ZVdIsxBclaiW
         l5ZHXxRlb3tNLFtZzvQaxsKPlXyhqWEfJGmESJfCiqao2NgW0bB7r82su6drA6aYJQSF
         JXrexueM9Ay5G8pucJ+pzsU1JDiltWK01Ai3QUhJ8TxaZMXTV5VkfHE1piuwzAnxd0vR
         fLyGOS1ofKKPgxWDNkiIxXxbdKHc1dbMWIr7bBUheHYZw7Cbme/EDpw8k2gHFktaJl6u
         ULXP3dORbEHBgQDHGVCmDs00aq0VyIWBUSpjrDv34obgdjjDjar1d2hPhoLSHjEDuQDs
         Hnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYu1ZRYBPKGSolP8R2Pl/pPVRmztWvNeFCWKXWsZruk=;
        b=IrhuO4DJ2FWvqc93r0TOh5pU6rb5mWLoGCjsWX7WZv0bd8Zml/CErTgTbF58b+S7Sl
         VccUlHbAjchs5bnp2RcA0oZQeiLVT4EWf2dlOpPzg623kGdm/TnPEhwkEwUfYbPE2msd
         /TdEsK8Hzj/QQa4v4AWUfYZ1cnYkVaD2aRSYmafApW7UVuAfT9eOvEBFX3HaAyiOif6Z
         b8xNBVihTq998jLL/pPf+8CfC0A4Vv87JlnD5JEfAUqHZ+2upVHVux84memhsf9TkLY6
         2mZpHPF3oYYnTNrj8Yk6XIfx0KeIGDgeg2EhRYErlZxv42jljmqSxzxuf3w3i0GnxRP6
         0pMQ==
X-Gm-Message-State: AOAM533l2aVwg7o4KPSrM7HxqNYmxQwI/pPCujK1NH7th53rM4g2nd0g
        HkpzVx4dpSZENGQ22mHLPxw0kBrrM43RQhR0peo=
X-Google-Smtp-Source: ABdhPJyqU4lWC1v6rq3eIQBFljL1k6TAFntuMeX1+ONhjq9qf0VcmYr4rR2srMKEDlzFLbv2g1DatJ4zFN/knJGrbLs=
X-Received: by 2002:a25:9882:: with SMTP id l2mr18164758ybo.425.1611781664308;
 Wed, 27 Jan 2021 13:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20210126001219.845816-1-yhs@fb.com> <YA/dqup/752hHBI4@hirez.programming.kicks-ass.net>
 <66f46df5-8d47-8e4f-a6ab-ab794e57332d@fb.com>
In-Reply-To: <66f46df5-8d47-8e4f-a6ab-ab794e57332d@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Jan 2021 13:07:32 -0800
Message-ID: <CAEf4BzawfHoU4sxEPMmSHRKgR3jYQUQP6tbYD4fTY2AyxM1ebA@mail.gmail.com>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions properly
To:     Yonghong Song <yhs@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, x86@kernel.org,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 26, 2021 at 2:57 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/26/21 1:15 AM, Peter Zijlstra wrote:
> > On Mon, Jan 25, 2021 at 04:12:19PM -0800, Yonghong Song wrote:
> >> When the test is run normally after login prompt, cpu_feature_enabled(X86_FEATURE_SMAP)
> >> is true and bad_area_nosemaphore() is called and then fixup_exception() is called,
> >> where bpf specific handler is able to fixup the exception.
> >>
> >> But when the test is run at /sbin/init time, cpu_feature_enabled(X86_FEATURE_SMAP) is
> >> false, the control reaches
> >
> > That makes no sense, cpu features should be set in stone long before we
> > reach userspace.
>
> You are correct. Sorry for misleading description. The reason is I use
> two qemu script, one from my local environment and the other from ci
> test since they works respectively. I thought they should have roughly
> the same kernel setup, but apparently they are not.
>
> For my local qemu script, I have "-cpu host" option and with this,
> X86_FEATURE_SMAP is set up probably in function get_cpu_cap(), file
> arch/x86/kernel/cpu/common.c.
>
> For CI qemu script (in
> https://lore.kernel.org/bpf/20210123004445.299149-1-kpsingh@kernel.org/),
> the "-cpu kvm64" is the qemu argument. This cpu does not
> enable X86_FEATURE_SMAP, so we will see the kernel warning.
>
> Changing CI script to use "-cpu host" resolved the issue. I think "-cpu
> kvm64" may emulate old x86 cpus and ignore X86_FEATURE_SMAP.
>
> Do we have any x64 cpus which does not support X86_FEATURE_SMAP?

We don't control what CPUs are used in our CIs, which is why we didn't
use "-cpu host". Is there some other way to make necessary features be
available in qemu for this to work and not emit warnings?

But also, what will happen in this case on CPUs that really don't
support X86_FEATURE_SMAP? Should that be addressed instead?


>
> For CI, with "-cpu kvm64" is good as it can specify the number
> of cores with e.g. "-smp 4" regardless of underlying host # of cores.
> I think we could change CI to use "-cpu host" by ensuring the CI host
> having at least 4 cores.
>
> Thanks.
>
>
> >
> >> To fix the issue, before the above mmap_read_trylock(), we will check
> >> whether fault ip can be served by bpf exception handler or not, if
> >> yes, the exception will be fixed up and return.
> >
> >
> >
> >> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> >> index f1f1b5a0956a..e8182d30bf67 100644
> >> --- a/arch/x86/mm/fault.c
> >> +++ b/arch/x86/mm/fault.c
> >> @@ -1317,6 +1317,15 @@ void do_user_addr_fault(struct pt_regs *regs,
> >>              if (emulate_vsyscall(hw_error_code, regs, address))
> >>                      return;
> >>      }
> >> +
> >> +#ifdef CONFIG_BPF_JIT
> >> +    /*
> >> +     * Faults incurred by bpf program might need emulation, i.e.,
> >> +     * clearing the dest register.
> >> +     */
> >> +    if (fixup_bpf_exception(regs, X86_TRAP_PF, hw_error_code, address))
> >> +            return;
> >> +#endif
> >>   #endif
> >
> > NAK, this is broken. You're now disallowing faults that should've gone
> > through.
> >
