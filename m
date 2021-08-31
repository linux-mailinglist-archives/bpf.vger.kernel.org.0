Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C613FC4E4
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 11:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbhHaJKi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 05:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240605AbhHaJKh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 05:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630400982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KqIomsJD8qkvJRmtf6AOcHNJotQV38aV9t/Y65DfWRs=;
        b=LxeTv/7ttnAXoIUrv1ZolVKo2n7VM5GwGdLLbSyK4qohl1T3uPogKI+XdYYnG/UjWcRKHX
        BG/Ee/tZDGyg3Wz92TpFWxOW7j1IO2yzUUp7UrxCJkwLPaDqE6un2HANXZRqBSFSbsik5H
        VjRUYjzyf+h45xCxcuI5Ds88+ti0jcg=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-Xu6P31anOpO7S9mdthZGAA-1; Tue, 31 Aug 2021 05:09:41 -0400
X-MC-Unique: Xu6P31anOpO7S9mdthZGAA-1
Received: by mail-yb1-f198.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso10158610ybq.10
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 02:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KqIomsJD8qkvJRmtf6AOcHNJotQV38aV9t/Y65DfWRs=;
        b=LbvvDG75Q/JMor9/YX8Otg1P4Q6+MUr6rlrpYt0Ken+frTLwXE4Zs7oPKOoApqEKZu
         rC1Rg1BAAOr3GFZOSXrMQkKlB7+UFuwrWY6S7ZbOzliIRrhYgK8e9f51Ed9ThBAbOORO
         E8bE4K8NecIz3/LN+FcHotiT8pchqLpNOcn7SltZJuklJwbJQeVj/MAfxhSj77H8UyuW
         KaIz2LNT4tJvJJisfJ9eRbL7OIoAKgfKHTlONQf5ob4eU5LfArw34l51P3tKUwuDvGRc
         G4X8SrMyB3jJL56mujvRYao+L+lqSO0FQQAN7hg1dt0Ellnp3JtQeNwB1bBWgVt2tqyp
         j8Vw==
X-Gm-Message-State: AOAM530xiAy8OHwk6q60UdrEf+Jkha0m5ytlMdBcmdhPntHptzZksZsV
        uuQ2WHjIlAoVUj16DYha9fEpXQToq9CDlsfykNOxXj6e1DZ7yGW9ADVLXRoZsH1/MrdfwKxO/g3
        VY5mwrN9fctr8bubNlzuzg61XmZYG
X-Received: by 2002:a25:1d08:: with SMTP id d8mr29534405ybd.377.1630400980464;
        Tue, 31 Aug 2021 02:09:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoUYVGjsHQ1mAV96NVBWIdFVB3TZpqWc7BWtvr/Mg648rQQ+7P7WYMOAhTFTS/Li+BMqOUSleNc4ReksuZGrg=
X-Received: by 2002:a25:1d08:: with SMTP id d8mr29534365ybd.377.1630400980209;
 Tue, 31 Aug 2021 02:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210616085118.1141101-1-omosnace@redhat.com> <CAPcyv4jvR8CT4rYODR5KUHNdiqMwQSwJZ+OkVf61kLT3JfjC_Q@mail.gmail.com>
In-Reply-To: <CAPcyv4jvR8CT4rYODR5KUHNdiqMwQSwJZ+OkVf61kLT3JfjC_Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 31 Aug 2021 11:09:29 +0200
Message-ID: <CAFqZXNtuH0329Xvcb415Kar-=o6wwrkFuiP8BZ_2OQhHLqkkAg@mail.gmail.com>
Subject: Re: [PATCH v3] lockdown,selinux: fix wrong subject in some SELinux
 lockdown checks
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        X86 ML <x86@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-cxl@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        linux-serial@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 19, 2021 at 12:18 AM Dan Williams <dan.j.williams@intel.com> wrote:
> On Wed, Jun 16, 2021 at 1:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Commit 59438b46471a ("security,lockdown,selinux: implement SELinux
> > lockdown") added an implementation of the locked_down LSM hook to
> > SELinux, with the aim to restrict which domains are allowed to perform
> > operations that would breach lockdown.
> >
> > However, in several places the security_locked_down() hook is called in
> > situations where the current task isn't doing any action that would
> > directly breach lockdown, leading to SELinux checks that are basically
> > bogus.
> >
> > To fix this, add an explicit struct cred pointer argument to
> > security_lockdown() and define NULL as a special value to pass instead
> > of current_cred() in such situations. LSMs that take the subject
> > credentials into account can then fall back to some default or ignore
> > such calls altogether. In the SELinux lockdown hook implementation, use
> > SECINITSID_KERNEL in case the cred argument is NULL.
> >
> > Most of the callers are updated to pass current_cred() as the cred
> > pointer, thus maintaining the same behavior. The following callers are
> > modified to pass NULL as the cred pointer instead:
> > 1. arch/powerpc/xmon/xmon.c
> >      Seems to be some interactive debugging facility. It appears that
> >      the lockdown hook is called from interrupt context here, so it
> >      should be more appropriate to request a global lockdown decision.
> > 2. fs/tracefs/inode.c:tracefs_create_file()
> >      Here the call is used to prevent creating new tracefs entries when
> >      the kernel is locked down. Assumes that locking down is one-way -
> >      i.e. if the hook returns non-zero once, it will never return zero
> >      again, thus no point in creating these files. Also, the hook is
> >      often called by a module's init function when it is loaded by
> >      userspace, where it doesn't make much sense to do a check against
> >      the current task's creds, since the task itself doesn't actually
> >      use the tracing functionality (i.e. doesn't breach lockdown), just
> >      indirectly makes some new tracepoints available to whoever is
> >      authorized to use them.
> > 3. net/xfrm/xfrm_user.c:copy_to_user_*()
> >      Here a cryptographic secret is redacted based on the value returned
> >      from the hook. There are two possible actions that may lead here:
> >      a) A netlink message XFRM_MSG_GETSA with NLM_F_DUMP set - here the
> >         task context is relevant, since the dumped data is sent back to
> >         the current task.
> >      b) When adding/deleting/updating an SA via XFRM_MSG_xxxSA, the
> >         dumped SA is broadcasted to tasks subscribed to XFRM events -
> >         here the current task context is not relevant as it doesn't
> >         represent the tasks that could potentially see the secret.
> >      It doesn't seem worth it to try to keep using the current task's
> >      context in the a) case, since the eventual data leak can be
> >      circumvented anyway via b), plus there is no way for the task to
> >      indicate that it doesn't care about the actual key value, so the
> >      check could generate a lot of "false alert" denials with SELinux.
> >      Thus, let's pass NULL instead of current_cred() here faute de
> >      mieux.
> >
> > Improvements-suggested-by: Casey Schaufler <casey@schaufler-ca.com>
> > Improvements-suggested-by: Paul Moore <paul@paul-moore.com>
> > Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> [..]
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 2acc6173da36..c1747b6555c7 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -568,7 +568,7 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
> >         if (!IS_ENABLED(CONFIG_CXL_MEM_RAW_COMMANDS))
> >                 return false;
> >
> > -       if (security_locked_down(LOCKDOWN_NONE))
> > +       if (security_locked_down(current_cred(), LOCKDOWN_NONE))
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
>
> ...however that usage looks wrong. The expectation is that if kernel
> integrity protections are enabled then raw command access should be
> disabled. So I think that should be equivalent to LOCKDOWN_PCI_ACCESS
> in terms of the command capabilities to filter.

Yes, the LOCKDOWN_NONE seems wrong here... but it's a pre-existing bug
and I didn't want to go down yet another rabbit hole trying to fix it.
I'll look at this again once this patch is settled - it may indeed be
as simple as replacing LOCKDOWN_NONE with LOCKDOWN_PCI_ACCESS.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

