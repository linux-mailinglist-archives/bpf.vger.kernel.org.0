Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D416C3C688B
	for <lists+bpf@lfdr.de>; Tue, 13 Jul 2021 04:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhGMChv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Jul 2021 22:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbhGMChs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Jul 2021 22:37:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26DAC06178A
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 19:34:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ga14so23582305ejc.6
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 19:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBPu6xYIBS0viB5UZS492p6zHqYEhcALtpbidr1sCrU=;
        b=hAqQVpiv52aQMiILfGaILA7UZ3Vb7hpAEZl5MSyT4Y9giLdF8ZWBqgareVlSQUHWpR
         ZUrim0on5dre3bqN5EGAiRzVWG6nVeaiF+s6JaGu2Q+54HjtAgU1AvqcqlU5GALyqPc8
         J59ZdfyvvWc0CNOaKSGrAuHZon7DtT9jG9x1ueo2PbGCXBvXV9LCEYmPz0NJvuwLKCb4
         e5swfb54jlYSJ49YcMdOKdIhN3CYIP2f7H6ObIehgsT00rpoEugEWTcwjWsk6Ijx/OB+
         sziXashjbhIgbQwAsqKXq8JHPkE9kbOMVO58+jj4MNa7U/Fp8vQxUrXCiR8DuABY3fmZ
         DToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBPu6xYIBS0viB5UZS492p6zHqYEhcALtpbidr1sCrU=;
        b=kuw64dxZYyFgYKaKEyaE9HdFwaqdMFVOKObHb3bDhLOGeQYVeNDTr5R87R10NlIlin
         alf/tDC++ziGXTspYLEYQloBnnFMFK/3hSDw6FR+VLq9V8jR+LqptyX0KAN4EZsCbsms
         aJp96MSMxuARxnV58HXqsMYZ5WdvQZRKQHhdzwZaUgbRLl8jpQ14wV8cCHMgFbZsI11F
         UoGRq/KErF1DTAkOihP+RvD4gjQr/+SxSKE6FxzEO+wtLPJ5r+bgiB9YJFIX8f4Bmx10
         L5pvRlpPEhxx35rBLs0NkogvfILh1lLGyRsV0ZT1cifF93zJOSTRXLbJWDRvkNeuvt76
         5E2w==
X-Gm-Message-State: AOAM532eJGSu3Siqc79QjIEBoWYN+ZcBg17ub0Lk8hYjAg4ZDMuh2MlK
        PhrWiFe63jLysvLUiu5ijXFpDsFGd5fgCMQmyCtZ
X-Google-Smtp-Source: ABdhPJyytdq/CE/wkitIkFTYSvvbb5T4D4KC4bniBQLIKEAC15BXF2YMkUTZuWQQktrfljWaz21U9sH3mGdCEuV7T/M=
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr2673354ejb.542.1626143695922;
 Mon, 12 Jul 2021 19:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210616085118.1141101-1-omosnace@redhat.com> <8735tdiyc1.ffs@nanos.tec.linutronix.de>
In-Reply-To: <8735tdiyc1.ffs@nanos.tec.linutronix.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Jul 2021 22:34:45 -0400
Message-ID: <CAHC9VhRAN4RS2c3cwpr=DQ_45MDqn2QV7nL4J3ZWXKfUNLcjdQ@mail.gmail.com>
Subject: Re: [PATCH v3] lockdown,selinux: fix wrong subject in some SELinux
 lockdown checks
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-acpi@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 19, 2021 at 1:00 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, Jun 16 2021 at 10:51, Ondrej Mosnacek wrote:
> > diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
> > index bda73cb7a044..c43a13241ae8 100644
> > --- a/arch/x86/mm/testmmiotrace.c
> > +++ b/arch/x86/mm/testmmiotrace.c
> > @@ -116,7 +116,7 @@ static void do_test_bulk_ioremapping(void)
> >  static int __init init(void)
> >  {
> >       unsigned long size = (read_far) ? (8 << 20) : (16 << 10);
> > -     int ret = security_locked_down(LOCKDOWN_MMIOTRACE);
> > +     int ret = security_locked_down(current_cred(), LOCKDOWN_MMIOTRACE);
>
> I have no real objection to those patches, but it strikes me odd that
> out of the 62 changed places 58 have 'current_cred()' and 4 have NULL as
> argument.
>
> I can't see why this would ever end up with anything else than
> current_cred() or NULL and NULL being the 'special' case. So why not
> having security_locked_down_no_cred() and make current_cred() implicit
> for security_locked_down() which avoids most of the churn and just makes
> the special cases special. I might be missing something though.

Unfortunately it is not uncommon for kernel subsystems to add, move,
or otherwise play around with LSM hooks without checking with the LSM
folks; generally this is okay, but there have been a few problems in
the past and I try to keep that in mind when we are introducing new
hooks or modifying existing ones.  If we have two LSM hooks for
roughly the same control point it has the potential to cause
confusion, e.g. do I use the "normal" or the "no_cred" version?  What
if I don't want to pass a credential, can I just use "no_cred"?  My
thinking with the single, always-pass-a-cred function is that callers
don't have to worry about choosing from multiple, similar hooks and
they know they need to pass a cred which hopefully gets them thinking
about what cred is appropriate.  It's not foolproof, but I believe the
single hook approach will be less prone to accidents ... or so I hope
:)

-- 
paul moore
www.paul-moore.com
