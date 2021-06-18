Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC96B3AD4EF
	for <lists+bpf@lfdr.de>; Sat, 19 Jun 2021 00:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhFRWU1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 18:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhFRWUZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 18:20:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E191AC0617AD
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 15:18:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v12so5418561plo.10
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FE3ige4IUrzO4rZznPTG12clkaJsue7K7FUGlSBMAfs=;
        b=Yf/hd/nvGltzFs93oV+O815gndRr0N0A4GD+hlEjUljs8fR/r42/5waH+foBbKS7WR
         4ieWebjxoeI31qMYukpCCF4suivtuw0KIX1kY4xCHCyeA8Pd+qdR2kMIky/pA2j/9n1z
         T5UtTANEkuiNSh3GT2iBd2oGjOT4PXXJ8YxOU/uBtqj1IiaNYwuRoT9AQFd4bB3iGSod
         26qHtN9qmDpGolnh/MwXPQ8M2sR3UfA7xZml5iJWrbGghC/MI1rSVb3r8vzpAHp9WgHN
         rQlO7Wfj93/2gQ031V5AE3UWSmVQEAXyZXRDPtXzUcgRjadraLTfDfG3fXk5uJ+V0D/n
         TtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FE3ige4IUrzO4rZznPTG12clkaJsue7K7FUGlSBMAfs=;
        b=cL1TcLrp/ME32fY4JUhQ1KGfRi4giIP2eZ5tShSDBhTps3XMWwA0SjnkYrixd+I6eD
         oYCfCm3RMoprgC1btdsVP5EZyAj5AuKcgu33kVKVew6Mzk1ob8KoLdhmOD4pfEajM8CB
         Ukb/S85eLkJRxKoFRWVWMjmC7BM3Lwnw6FegrgY9c5+91dYTwV+3P+BAlV/FFztRfGK5
         DhoIZp2iLq4F14NdrfbN5aODw+EWiJ0VslpGVnEKR1gG6srS8bLE0wBLLzcFV3hHM2Dg
         2jup271Umpejbc6iEDdCnKLJWhlxNZvhYXm5UloryGcf08R+Julvm1hl5VDxV5CFYh/y
         YpUg==
X-Gm-Message-State: AOAM532o/1ZZAQGzg9x7sWy8pmS1yiUAQuy7m96S87lpUs7TCyaCz0cR
        agi8hZd07hJQxKLFfBZFn1kFNXXJSjHtQIE2MKCAAg==
X-Google-Smtp-Source: ABdhPJw3BE/jkA8KN4GViEwVomKCDOYCAzb4JhqF7GBtQ+4ny9zul9rQENwJ5XFkX0U2csBd6emTDpwOakbDlUjAcRc=
X-Received: by 2002:a17:90a:fc88:: with SMTP id ci8mr24404565pjb.13.1624054695229;
 Fri, 18 Jun 2021 15:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210616085118.1141101-1-omosnace@redhat.com>
In-Reply-To: <20210616085118.1141101-1-omosnace@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Jun 2021 15:18:04 -0700
Message-ID: <CAPcyv4jvR8CT4rYODR5KUHNdiqMwQSwJZ+OkVf61kLT3JfjC_Q@mail.gmail.com>
Subject: Re: [PATCH v3] lockdown,selinux: fix wrong subject in some SELinux
 lockdown checks
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        X86 ML <x86@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-cxl@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        linux-serial@vger.kernel.org, bpf@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 16, 2021 at 1:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Commit 59438b46471a ("security,lockdown,selinux: implement SELinux
> lockdown") added an implementation of the locked_down LSM hook to
> SELinux, with the aim to restrict which domains are allowed to perform
> operations that would breach lockdown.
>
> However, in several places the security_locked_down() hook is called in
> situations where the current task isn't doing any action that would
> directly breach lockdown, leading to SELinux checks that are basically
> bogus.
>
> To fix this, add an explicit struct cred pointer argument to
> security_lockdown() and define NULL as a special value to pass instead
> of current_cred() in such situations. LSMs that take the subject
> credentials into account can then fall back to some default or ignore
> such calls altogether. In the SELinux lockdown hook implementation, use
> SECINITSID_KERNEL in case the cred argument is NULL.
>
> Most of the callers are updated to pass current_cred() as the cred
> pointer, thus maintaining the same behavior. The following callers are
> modified to pass NULL as the cred pointer instead:
> 1. arch/powerpc/xmon/xmon.c
>      Seems to be some interactive debugging facility. It appears that
>      the lockdown hook is called from interrupt context here, so it
>      should be more appropriate to request a global lockdown decision.
> 2. fs/tracefs/inode.c:tracefs_create_file()
>      Here the call is used to prevent creating new tracefs entries when
>      the kernel is locked down. Assumes that locking down is one-way -
>      i.e. if the hook returns non-zero once, it will never return zero
>      again, thus no point in creating these files. Also, the hook is
>      often called by a module's init function when it is loaded by
>      userspace, where it doesn't make much sense to do a check against
>      the current task's creds, since the task itself doesn't actually
>      use the tracing functionality (i.e. doesn't breach lockdown), just
>      indirectly makes some new tracepoints available to whoever is
>      authorized to use them.
> 3. net/xfrm/xfrm_user.c:copy_to_user_*()
>      Here a cryptographic secret is redacted based on the value returned
>      from the hook. There are two possible actions that may lead here:
>      a) A netlink message XFRM_MSG_GETSA with NLM_F_DUMP set - here the
>         task context is relevant, since the dumped data is sent back to
>         the current task.
>      b) When adding/deleting/updating an SA via XFRM_MSG_xxxSA, the
>         dumped SA is broadcasted to tasks subscribed to XFRM events -
>         here the current task context is not relevant as it doesn't
>         represent the tasks that could potentially see the secret.
>      It doesn't seem worth it to try to keep using the current task's
>      context in the a) case, since the eventual data leak can be
>      circumvented anyway via b), plus there is no way for the task to
>      indicate that it doesn't care about the actual key value, so the
>      check could generate a lot of "false alert" denials with SELinux.
>      Thus, let's pass NULL instead of current_cred() here faute de
>      mieux.
>
> Improvements-suggested-by: Casey Schaufler <casey@schaufler-ca.com>
> Improvements-suggested-by: Paul Moore <paul@paul-moore.com>
> Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
[..]
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 2acc6173da36..c1747b6555c7 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -568,7 +568,7 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
>         if (!IS_ENABLED(CONFIG_CXL_MEM_RAW_COMMANDS))
>                 return false;
>
> -       if (security_locked_down(LOCKDOWN_NONE))
> +       if (security_locked_down(current_cred(), LOCKDOWN_NONE))

Acked-by: Dan Williams <dan.j.williams@intel.com>

...however that usage looks wrong. The expectation is that if kernel
integrity protections are enabled then raw command access should be
disabled. So I think that should be equivalent to LOCKDOWN_PCI_ACCESS
in terms of the command capabilities to filter.
