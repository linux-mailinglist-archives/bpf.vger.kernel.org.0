Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2B72009AB
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 15:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgFSNNu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 09:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731831AbgFSNNr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jun 2020 09:13:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DE6C0613EF
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 06:13:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so9634650wrs.11
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UFNoVkVHTZErq2JtCJe5vBxdIIAUeTxaBKUEdnLeKM=;
        b=SConi2qeGRAGuNLdtIm23QSPOAFACg3QXM3YdAQis7gAzJxIdD8+ZzQGF0ZlPVYDTC
         POzOonq9u7WSfC+X1tyMD1XD5xRMIHWzDEHPotqLvh5xhx8RtkbVW4xz3GgcfrL+2lhV
         SUOUIGLgG7MabFFIr8SMJA2QRHhUHwYY4qTd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UFNoVkVHTZErq2JtCJe5vBxdIIAUeTxaBKUEdnLeKM=;
        b=cRLcJYE8YyvCRKFePiGbHkAgFxApnDNFKbG7qwt6/KElU/jTxvIyhmlnSdM+E0Zt/J
         PLu8Spt+QSHJC5I3bi0TX+aZusN4LuTN3/QhZk8/ulyPvZRtV2kTZ3jEtCaqbhm7ZwQZ
         htQLPLSU8FYYYbdJba5kSwSsGipuhYElO0DAsNFhUYkdPALwhoYYfWsn6L3r+XejEKPh
         nOZUedQG/oMIDLAkBbggmE3YKic8Gn/ye5MYFraHDSYkzIu34RWp6U8xqoFtax2Vm2SV
         Yws2Pml+WY+2Cb4BQCu8AKAET1ZaCK78rFGddbY+LD+34yrdOJ/9YJ6nDePmqYLzWtIS
         4Euw==
X-Gm-Message-State: AOAM530+PCfvOsSku90jjoHwfqUSQ9istMR956B0mynrponiRfU4ObB1
        3jK7SEHz8thIUTk4aq02NY8fIXaqyODqY1DXe1y0Fg==
X-Google-Smtp-Source: ABdhPJwXqMeHG4k19RmjN1x/uYLq/BiSiI4EM1nMy3AVv6eLoy7FJH0ywzEFP6e55HlgtVBSrMacOTA3AQPzP/hcIzw=
X-Received: by 2002:adf:afc7:: with SMTP id y7mr4002099wrd.173.1592572424114;
 Fri, 19 Jun 2020 06:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200520125616.193765-1-kpsingh@chromium.org> <CAFqZXNsu8Vs86SKpdnej_=xnQqg=Hh132JqNe1Ybt-bHJB4NeQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsu8Vs86SKpdnej_=xnQqg=Hh132JqNe1Ybt-bHJB4NeQ@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 19 Jun 2020 15:13:32 +0200
Message-ID: <CACYkzJ5e_JOLS-gmNug6e4RJkSsv7sjMUfMWyfMCsQLSoxS8RQ@mail.gmail.com>
Subject: Re: [PATCH bpf] security: Fix hook iteration for secid_to_secctx
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Peter Zijlstra <peterz@infradead.org>, jpoimboe@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Fri, Jun 19, 2020 at 2:49 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, May 20, 2020 at 2:56 PM KP Singh <kpsingh@chromium.org> wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > secid_to_secctx is not stackable, and since the BPF LSM registers this
> > hook by default, the call_int_hook logic is not suitable which
> > "bails-on-fail" and casues issues when other LSMs register this hook and
> > eventually breaks Audit.
> >
> > In order to fix this, directly iterate over the security hooks instead
> > of using call_int_hook as suggested in:
> >
> > https: //lore.kernel.org/bpf/9d0eb6c6-803a-ff3a-5603-9ad6d9edfc00@schaufler-ca.com/#t
> >
> > Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> > Fixes: 625236ba3832 ("security: Fix the default value of secid_to_secctx hook"
> > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: KP Singh <kpsingh@google.com>
> [...]
>
> Sorry for being late to the party, but doesn't this (and the
> associated default return value patch) just paper over a bigger
> problem? What if I have only the BPF LSM enabled and I attach a BPF
> program to this hook that just returns 0? Doesn't that allow anything
> privileged enough to do this to force the kernel to try and send
> memory from uninitialized pointers to userspace and/or copy such
> memory around and/or free uninitialized pointers?
>
> Why on earth does the BPF LSM directly expose *all* of the hooks, even
> those that are not being used for any security decisions (and are
> "useful" in this context only for borking the kernel...)? Feel free to
> prove me wrong, but this lazy approach of "let's just take all the
> hooks as they are and stick BPF programs to them" doesn't seem like a

The plan was definitely to not hook everywhere but only call the hooks
that do have a BPF program registered. This was one of the versions
we proposed in the initial patches where the call to the BPF LSM was
guarded by a static key with it being enabled only when there's a
BPF program attached to the hook.

https://lore.kernel.org/bpf/20200220175250.10795-5-kpsingh@chromium.org/

However, this special-cased BPF in the LSM framework, and, was met
with opposition. Our plan is to still achieve this, but we want to do this
with DEFINE_STATIC_CALL patches:

https://lore.kernel.org/lkml/cover.1547073843.git.jpoimboe@redhat.com

Using these, only can we enable the call into the hook based on whether
a program is attached, we can also eliminate the indirect call overhead which
currently affects the "slow" way which was decided in the discussion:

https://lore.kernel.org/bpf/202002241136.C4F9F7DFF@keescook/

> good choice... IMHO you should either limit the set of hooks that can
> be attached to only those that aren't used to return back values via

I am not sure if limiting the hooks is required here once we have
the ability to call into BPF only when a program is attached. If the
the user provides a BPF program, deliberately returns 0 (or any
other value) then it is working as intended. Even if we limit this in the
bpf LSM, deliberate privileged users can still achieve this with
other means.

- KP

> pointers, or (if you really really need to do some state
> updates/logging in those hooks) use wrapper functions that will call
> the BPF progs via a simplified interface so that they cannot cause
> unsafe behavior.
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>
