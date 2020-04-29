Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D3F1BDC62
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 14:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgD2MfM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Apr 2020 08:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgD2MfL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Apr 2020 08:35:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A7BC03C1AE
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 05:35:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v4so4817706wme.1
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 05:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9voC+7Ag0IZtM5E39FKqVej4Yp+1sY356RInyCMBnw=;
        b=mkODMHu7QUFmQUE6GLJwwSv9uyrNKmg42KeS1mNJA+HZujxBKmp/6RbBvKRSukcycg
         aooQLdd+FQYADfUUYSwXv0XLQrl4u4yzjQ/EdDizxMgLsEnbmttxc6mgkkrf0E1+6mcq
         7Nb1oqp92/bNtPx8YdNQZ6FvCC8pIzBCwzVtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9voC+7Ag0IZtM5E39FKqVej4Yp+1sY356RInyCMBnw=;
        b=neHQkG4e6vfsQ1gMcx4nwJztxgJtmORsBBd30pNePSwFEREAPDyqxHla6SbswRNw8/
         4HwqD1HIyMn5CjQnXjFyT1tB9ugtRsrQcsSujNsvlZS8LRJAqrfQj98EoN2uxG7ftcX8
         dQz2Mx+dho/Oc05lYNxp+x/siMgCDUjXboNygaCtQhEOGBMZ+h+iRBHpGqjKz8MW3VRg
         9FvboXzD1DYPtdQ47ZmLvJ0O4i4j6ZRjqckR9zFcBT+yQGoQyA/FUVGjgN5DvYaVXwd4
         ZBF2PlWInNhak9zDOxOKkcuEFNl7cIxdqgUQoiAcT+nzeiaLFvvBhHf5xU9D1qBtckSw
         CsdA==
X-Gm-Message-State: AGi0PuY4PXHQIvcN5dqg8ydV1xmhTktl9uDGKOdhsVmymxJ0r8C3rzbA
        jgtbS5g20zYWUMrhk8Ows5ZAr33NPvAoPRoAGzu6xA==
X-Google-Smtp-Source: APiQypKSCfwmXoEeutwbnB5ktUeTeYnld7bo1PHhugIhXjYAiW1cruH3+hXqlzwQjACjkP/BQXheUt7pbyyMP7RLhaI=
X-Received: by 2002:a7b:c390:: with SMTP id s16mr2974236wmj.14.1588163708568;
 Wed, 29 Apr 2020 05:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200329004356.27286-1-kpsingh@chromium.org> <0165887d-e9d0-c03e-18b9-72e74a0cbd59@linux.intel.com>
In-Reply-To: <0165887d-e9d0-c03e-18b9-72e74a0cbd59@linux.intel.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 29 Apr 2020 14:34:57 +0200
Message-ID: <CACYkzJ6XyHqr1W=LWV-5Z0txFBtvPCwRY-kczphy+pS7PEitqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 0/8] MAC and Audit policy using eBPF (KRSI)
To:     Mikko Ylinen <mikko.ylinen@linux.intel.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for reporting this! Can you share your Kconfig please?


On Wed, Apr 29, 2020 at 2:31 PM Mikko Ylinen
<mikko.ylinen@linux.intel.com> wrote:
>
> Hi,
>
> On 29/03/2020 02:43, KP Singh wrote:
> > # How does it work?
> >
> > The patchset introduces a new eBPF (https://docs.cilium.io/en/v1.6/bpf/)
> > program type BPF_PROG_TYPE_LSM which can only be attached to LSM hooks.
> > Loading and attachment of BPF programs requires CAP_SYS_ADMIN.
> >
> > The new LSM registers nop functions (bpf_lsm_<hook_name>) as LSM hook
> > callbacks. Their purpose is to provide a definite point where BPF
> > programs can be attached as BPF_TRAMP_MODIFY_RETURN trampoline programs
> > for hooks that return an int, and BPF_TRAMP_FEXIT trampoline programs
> > for void LSM hooks.
>
> I have two systems (a NUC and a qemu VM) that fail to boot if I enable
> the BPF LSM without enabling SELinux first. Anything I might be missing
> or are you able to trigger it too?
>
> For instance, the following additional cmdline args: "lsm.debug=1
> lsm="capability,apparmor,bpf" results in:
>
> [    1.251889] Call Trace:
> [    1.252344]  dump_stack+0x57/0x7a
> [    1.252951]  panic+0xe6/0x2a4
> [    1.253497]  ? printk+0x43/0x45
> [    1.254075]  mount_block_root+0x30c/0x31b
> [    1.254798]  mount_root+0x78/0x7b
> [    1.255417]  prepare_namespace+0x13a/0x16b
> [    1.256168]  kernel_init_freeable+0x210/0x222
> [    1.257021]  ? rest_init+0xa5/0xa5
> [    1.257639]  kernel_init+0x9/0xfb
> [    1.258074]  ret_from_fork+0x35/0x40
> [    1.258885] Kernel Offset: 0x11000000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [    1.264046] ---[ end Kernel panic - not syncing: VFS: Unable to mount
> root fs on unknown-block(253,3)
>
> Taking out "bpf" or adding "selinux" before it boots OK. I've tried
> with both 5.7-rc2 and -rc3.
>
> LSM logs:
>
> [    0.267219] LSM: Security Framework initializing
> [    0.267844] LSM: first ordering: capability (enabled)
> [    0.267870] LSM: cmdline ignored: capability
> [    0.268869] LSM: cmdline ordering: apparmor (enabled)
> [    0.269508] LSM: cmdline ordering: bpf (enabled)
> [    0.269869] LSM: cmdline disabled: selinux
> [    0.270377] LSM: cmdline disabled: integrity
> [    0.270869] LSM: exclusive chosen: apparmor
> [    0.271869] LSM: cred blob size     = 8
> [    0.272354] LSM: file blob size     = 24
> [    0.272869] LSM: inode blob size    = 0
> [    0.273362] LSM: ipc blob size      = 0
> [    0.273869] LSM: msg_msg blob size  = 0
> [    0.274352] LSM: task blob size     = 32
> [    0.274873] LSM: initializing capability
> [    0.275381] LSM: initializing apparmor
> [    0.275880] AppArmor: AppArmor initialized
> [    0.276437] LSM: initializing bpf
> [    0.276871] LSM support for eBPF active
>
> -- Regards, Mikko
