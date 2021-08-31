Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56593FCD5B
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 21:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbhHaTAm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 15:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239537AbhHaTAk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Aug 2021 15:00:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21186C0617AE
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 11:59:44 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id me10so914785ejb.11
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 11:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4O58ZgiMsf0cCMtsvw/t7AJFM1T3tlDvm3uUGsU/to=;
        b=m/p6PQxMro/Ee7fR7WvozEwx71BnscpCpL2xs1XR6unVL7bfCWki5mm/DL8tzkxtlv
         IgmDAUJlZv7+KUUNuYAb3NRkVROzdUIxdGRwwrqEOUO0vD6Cu/HZq+bSFieTd9983AeD
         YktyhmMz20Tq1h8uROtJTQQFwlHuUy+Bds8+ZIoQqHDYDTRBZ7xIrXRop6SBBaMcqz3D
         KSsC4i4L46l25F26x2rXCk4fmowpOEt5kNPUpUjO3ZN5jtoqzJulRjdNVM64Yw8ZBWOt
         rXYGE77kjE3hfKV3j/NE4j8c0xfhsFszf/XJGAR6u3atTQlztdBXyq7sYYSIi6VfUO2y
         mhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4O58ZgiMsf0cCMtsvw/t7AJFM1T3tlDvm3uUGsU/to=;
        b=gbjqLjPWns5ZKHeGJOsoX7p1QHQtIJwILI1SJ3rZm++KiHFku3HjoDvXuKhejkRNbF
         XShdy0ZmdwcXkntSkv07mar+zIAL6htHTtDvUK3nQXEbgWUIpYb0cCK2YxKccPziB6Wp
         ZD5eBZf3kLv6h1t1lec9HyOH6P0VhkHc9r1EYChERkXd7T15so9znj5eytIv72JoDO9y
         l7+gV9OhYNNZj5pStto9wfSM3Zub8BOAMDoQRgcpt3sVzaOcCjXDJd+Ke/IY6dZ0sBsU
         SlBcdlE1WGYc74NAMp+B3yOE9ZBc2gpoxAy4zTv1E5pk8Bm43RJuFzol8tZ/t8YdkNUu
         4vyA==
X-Gm-Message-State: AOAM532PDb/zZ5Z+5TVOevMLTFN0IoY/DVz6dOcI93Fsuh6rBPvT5mPG
        sVbQwe+iUHpNiD5R8cVqmwvpooJAxffHJdfAR6iX
X-Google-Smtp-Source: ABdhPJynhzjWiT5WygcinC1v/vpSrVXtKhAajoj91Y8oOaAf641QOi9pajzp20JXEjTMXZ2nBzK8acBfiZKG6sYGsHg=
X-Received: by 2002:a17:906:2cd6:: with SMTP id r22mr31706715ejr.398.1630436382385;
 Tue, 31 Aug 2021 11:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210616085118.1141101-1-omosnace@redhat.com> <CAPcyv4jvR8CT4rYODR5KUHNdiqMwQSwJZ+OkVf61kLT3JfjC_Q@mail.gmail.com>
 <CAFqZXNtuH0329Xvcb415Kar-=o6wwrkFuiP8BZ_2OQhHLqkkAg@mail.gmail.com>
 <CAHC9VhTGECM2p+Q8n48aSdfJzY6XrpXQ5tcFurjWc4A3n8Qxjg@mail.gmail.com> <CAPcyv4i8YXo=xOL2vO67KLABQRDNAxzrzT=a1xtwtrts5pVPKw@mail.gmail.com>
In-Reply-To: <CAPcyv4i8YXo=xOL2vO67KLABQRDNAxzrzT=a1xtwtrts5pVPKw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 31 Aug 2021 14:59:31 -0400
Message-ID: <CAHC9VhReGcV=cngDMmAcEiS2NpkXZQ6b09go9m0omzxLdrUQXg@mail.gmail.com>
Subject: Re: [PATCH v3] lockdown,selinux: fix wrong subject in some SELinux
 lockdown checks
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
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

On Tue, Aug 31, 2021 at 2:58 PM Dan Williams <dan.j.williams@intel.com> wrote:
> On Tue, Aug 31, 2021 at 6:53 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Aug 31, 2021 at 5:09 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Sat, Jun 19, 2021 at 12:18 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > On Wed, Jun 16, 2021 at 1:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > ...
> >
> > > > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > > > index 2acc6173da36..c1747b6555c7 100644
> > > > > --- a/drivers/cxl/mem.c
> > > > > +++ b/drivers/cxl/mem.c
> > > > > @@ -568,7 +568,7 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
> > > > >         if (!IS_ENABLED(CONFIG_CXL_MEM_RAW_COMMANDS))
> > > > >                 return false;
> > > > >
> > > > > -       if (security_locked_down(LOCKDOWN_NONE))
> > > > > +       if (security_locked_down(current_cred(), LOCKDOWN_NONE))
> > > >
> > > > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > > >
> > > > ...however that usage looks wrong. The expectation is that if kernel
> > > > integrity protections are enabled then raw command access should be
> > > > disabled. So I think that should be equivalent to LOCKDOWN_PCI_ACCESS
> > > > in terms of the command capabilities to filter.
> > >
> > > Yes, the LOCKDOWN_NONE seems wrong here... but it's a pre-existing bug
> > > and I didn't want to go down yet another rabbit hole trying to fix it.
> > > I'll look at this again once this patch is settled - it may indeed be
> > > as simple as replacing LOCKDOWN_NONE with LOCKDOWN_PCI_ACCESS.
> >
> > At this point you should be well aware of my distaste for merging
> > patches that have known bugs in them.  Yes, this is a pre-existing
> > condition, but it seems well within the scope of this work to address
> > it as well.
> >
> > This isn't something that is going to get merged while the merge
> > window is open, so at the very least you've got almost two weeks to
> > sort this out - please do that.
>
> Yes, apologies, I should have sent the fix shortly after noticing the
> problem. I'll get the CXL bug fix out of the way so Ondrej can move
> this along.

Thanks Dan.

-- 
paul moore
www.paul-moore.com
