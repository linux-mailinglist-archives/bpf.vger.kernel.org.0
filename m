Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D570200B27
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 16:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgFSORQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 10:17:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45379 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731756AbgFSORP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 10:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592576232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kLi8OmcpAn5G3kBd5W0qjMBKSdfFGH1S+Rf0efF4Xls=;
        b=frVI63bARf9TeKAOhsrqr955v0d+yR9q2uvHXAvWMmI/ljDQ0uHRN0s/s0HDOG8lM44yLt
        SWnJeEy+E9ZWJq5jZ++jCqqonUQ6kSET8Ucfp6SwBR0WQRhfBUNs4pAPnb11bK3n2OmO4h
        ArptbM6us1rGMMbVyKpE514lW6ycfHA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-3kbNSHnuOvyQCttiJVKbEQ-1; Fri, 19 Jun 2020 10:17:10 -0400
X-MC-Unique: 3kbNSHnuOvyQCttiJVKbEQ-1
Received: by mail-lf1-f69.google.com with SMTP id n17so3484846lfe.15
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 07:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLi8OmcpAn5G3kBd5W0qjMBKSdfFGH1S+Rf0efF4Xls=;
        b=Zbow3WbmIkBQlbtrnRbxReZ8Y5yOHEpISrW5KprGitBTzi87gNfFD/DFU9XrtOySCU
         TRMiAph4tGAPNwSQL6U75Tly+3NYA1VYPZjl2enlYYqXmgGhONjwgWC9o7Q+lBGHywu8
         xxNAMLPw/n8u30bUcap8qT8E39rld+ja5/zlXRNjaR3GAdGsu9Wu4Tw4iyVYi88PhZt0
         yze8wFpSNhd4GogIeZGi5CDJ5PPtcmKFpRRC1GjIB1YbJlle3epozPG9OUKvXHVDIqSV
         aSmURtTIagednrFKEAx38fTUyBYzFxAIfAy/lPCvxByefQL2kkGW58a/2Y3vfemSTFNu
         Zk0w==
X-Gm-Message-State: AOAM533WUfKznNr2EZfqtle3GMlGlqZgz2nraaFt9NfA/VVaffSi/rHs
        iIq5b1gH5XA+7/M50M/jBoPfRb3Rl4JyaMIINSOQbzU/YPd2cmyyPZzL2XB2jBTXqvMdPzUHTl3
        8z1zZV1w/rlJ4dyDRrGB0qDi7khr+
X-Received: by 2002:a05:651c:288:: with SMTP id b8mr2016196ljo.337.1592576227338;
        Fri, 19 Jun 2020 07:17:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBnUX8NJhTD9+Y6SBhotedimZLTfDoRHr3zkymH2rIJx1if7ROCyyryB7ZBKdteKrgkvdIe7XhrXsikvdoXds=
X-Received: by 2002:a05:651c:288:: with SMTP id b8mr2016174ljo.337.1592576226986;
 Fri, 19 Jun 2020 07:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200520125616.193765-1-kpsingh@chromium.org> <CAFqZXNsu8Vs86SKpdnej_=xnQqg=Hh132JqNe1Ybt-bHJB4NeQ@mail.gmail.com>
 <CACYkzJ5e_JOLS-gmNug6e4RJkSsv7sjMUfMWyfMCsQLSoxS8RQ@mail.gmail.com>
In-Reply-To: <CACYkzJ5e_JOLS-gmNug6e4RJkSsv7sjMUfMWyfMCsQLSoxS8RQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 19 Jun 2020 16:16:56 +0200
Message-ID: <CAFqZXNuqNP4OMQGNunyUyyKBc_0-e_P+ogha08V6UsTNCATfLA@mail.gmail.com>
Subject: Re: [PATCH bpf] security: Fix hook iteration for secid_to_secctx
To:     KP Singh <kpsingh@chromium.org>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 19, 2020 at 3:13 PM KP Singh <kpsingh@chromium.org> wrote:
> Hi,
>
> On Fri, Jun 19, 2020 at 2:49 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Wed, May 20, 2020 at 2:56 PM KP Singh <kpsingh@chromium.org> wrote:
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > secid_to_secctx is not stackable, and since the BPF LSM registers this
> > > hook by default, the call_int_hook logic is not suitable which
> > > "bails-on-fail" and casues issues when other LSMs register this hook and
> > > eventually breaks Audit.
> > >
> > > In order to fix this, directly iterate over the security hooks instead
> > > of using call_int_hook as suggested in:
> > >
> > > https: //lore.kernel.org/bpf/9d0eb6c6-803a-ff3a-5603-9ad6d9edfc00@schaufler-ca.com/#t
> > >
> > > Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> > > Fixes: 625236ba3832 ("security: Fix the default value of secid_to_secctx hook"
> > > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> > [...]
> >
> > Sorry for being late to the party, but doesn't this (and the
> > associated default return value patch) just paper over a bigger
> > problem? What if I have only the BPF LSM enabled and I attach a BPF
> > program to this hook that just returns 0? Doesn't that allow anything
> > privileged enough to do this to force the kernel to try and send
> > memory from uninitialized pointers to userspace and/or copy such
> > memory around and/or free uninitialized pointers?
> >
> > Why on earth does the BPF LSM directly expose *all* of the hooks, even
> > those that are not being used for any security decisions (and are
> > "useful" in this context only for borking the kernel...)? Feel free to
> > prove me wrong, but this lazy approach of "let's just take all the
> > hooks as they are and stick BPF programs to them" doesn't seem like a
>
> The plan was definitely to not hook everywhere but only call the hooks
> that do have a BPF program registered. This was one of the versions
> we proposed in the initial patches where the call to the BPF LSM was
> guarded by a static key with it being enabled only when there's a
> BPF program attached to the hook.
>
> https://lore.kernel.org/bpf/20200220175250.10795-5-kpsingh@chromium.org/
>
> However, this special-cased BPF in the LSM framework, and, was met
> with opposition. Our plan is to still achieve this, but we want to do this
> with DEFINE_STATIC_CALL patches:
>
> https://lore.kernel.org/lkml/cover.1547073843.git.jpoimboe@redhat.com
>
> Using these, only can we enable the call into the hook based on whether
> a program is attached, we can also eliminate the indirect call overhead which
> currently affects the "slow" way which was decided in the discussion:
>
> https://lore.kernel.org/bpf/202002241136.C4F9F7DFF@keescook/

Perhaps you are misunderstanding me... I don't have a problem with BPF
LSM registering callbacks for all the hooks. My point is about what
you can trigger once you attach programs to certain hooks. All the
above seem to be just optimizations/implementation details that do not
affect the problem I'm pointing to.

>
> > good choice... IMHO you should either limit the set of hooks that can
> > be attached to only those that aren't used to return back values via
>
> I am not sure if limiting the hooks is required here once we have
> the ability to call into BPF only when a program is attached. If the
> the user provides a BPF program, deliberately returns 0 (or any
> other value) then it is working as intended. Even if we limit this in the
> bpf LSM, deliberate privileged users can still achieve this with
> other means.

The point is that for this particular hook (secid_to_secctx) and a
couple others, the consequences of having control over the return
value are more serious than with other hooks. For most hooks, the
implementation usually just returns 0 (OK), -EACCESS (access denied)
or -E... (error) and the caller either continues as normal or handles
the error. But here if you return 0, you signal that you have
initialized the pointer and size to valid values. So suddenly the BPF
prog doesn't just control allow/deny decisions, but can now easily
trigger kernel panic. And when you look at the semantics of the hook,
you will realize that it doesn't really make sense to implement it via
BPF, since it can never populate the output values and the only
meaningful implementation would be to just return -EOPNOTSUPP.

Maybe I have it all wrong, but isn't the whole point of BPF programs
to provide a tight sandbox where you can only implement pure input ->
output functions + read/modify some internal state? Is it really
"working as intended" if you can crash the kernel by attaching a
simple BPF program to a certain hook? I mean yes, you can make the
system pretty much unusable already using the classic hooks by simply
returning -EACCESS for everything, but IMO that's quite different from
causing the kernel to do an invalid memory access.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

