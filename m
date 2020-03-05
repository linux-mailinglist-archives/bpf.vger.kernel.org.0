Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B09C17AC82
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 18:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgCERVL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 12:21:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36795 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgCERVK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 12:21:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id g12so2914597plo.3;
        Thu, 05 Mar 2020 09:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N0N64ckCOqKc6ZJK0qMwyg/Ulb95IE0OLYm4Irt4HYc=;
        b=q5In8rRR5y1BoKW12FK5C/a2p+hq/qxV3kRp3nGR64MvPMni5V0e8jQ8JpOBzgxx1O
         csDdockVi0QpV/jYm7UwOehUxp9iqgpUHqureOBeNrQODecMWFGFpmJZQ37E1hQ57GoJ
         WOqAnAoMOz51ARLYGg17SsB/IBrJ0Fa87ssJNs6OgBmbDdF5cl3MAnDuuu0ioc8II0rH
         yfnHFDEzhn5OvKcHf46QOKx9nR4McQI7dbj7ht1JEGlHI0AMXlDpEEtuLNzfVixnMB6g
         2vddGMidnAXZU8RKn+ywjF3ZfzosaWGjW+7ehDvS2q6OO6vjIA3ZGPsjqxHy93OxaCha
         bESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N0N64ckCOqKc6ZJK0qMwyg/Ulb95IE0OLYm4Irt4HYc=;
        b=NXeGsdfKb4x1Iy+sfz5R//jdtQpuqVfVdQ9g+aorxn1PjdxXFV8su58bRZ2UecFM2v
         Z0EBr+fxcH7nhamI9Y9AYHd+pJ4GnZWembtR/gpr/BD8BgY9GqaEL7KZgR30LGj3coFw
         EKYJ+12n3qN8Dx90f+6esDXhNkRWpCCMYBCRRSYFPs7RU8GVgeb5lcIb7GEOFkU/QavX
         HuWTzrVpduFnFq4/0PTeyByoewivPaStC60b5/AQP3eG6eie24BNoG7SUIKa633prg7i
         Nl7DVbp4i7i7FI3t6ZCGUD7OKtHgVwF+pI88frihw648wsqE7RXWxOaieeO48vUdcZeD
         szJQ==
X-Gm-Message-State: ANhLgQ2L6dyuH1vTbHdkSimcD4da8dbwWlrjtcaf2YbUbd9bMd/yCS6N
        kLa2F84/DYQexeaVUyY1+pQ=
X-Google-Smtp-Source: ADFU+vtUW6mCHYJ00vUXWecjWj9VK7jBQBpZHz6iJxYZf0iSdfevdG45412meQQxE170SObQvgTPYA==
X-Received: by 2002:a17:902:bd42:: with SMTP id b2mr9344237plx.34.1583428869489;
        Thu, 05 Mar 2020 09:21:09 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:f0e7])
        by smtp.gmail.com with ESMTPSA id s12sm9994271pgv.73.2020.03.05.09.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 09:21:08 -0800 (PST)
Date:   Thu, 5 Mar 2020 09:21:05 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Paul Moore <paul@paul-moore.com>, jmorris@namei.org
Subject: Re: [PATCH bpf-next v4 4/7] bpf: Attachment verification for
 BPF_MODIFY_RETURN
Message-ID: <20200305172103.uet5kf6uj5sudeie@ast-mbp>
References: <20200304191853.1529-1-kpsingh@chromium.org>
 <20200304191853.1529-5-kpsingh@chromium.org>
 <CAEjxPJ4G4sp5_zHXxhe+crafNGV-oZZZ2YYbbMb61BZx0F_ujw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ4G4sp5_zHXxhe+crafNGV-oZZZ2YYbbMb61BZx0F_ujw@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 05, 2020 at 08:43:11AM -0500, Stephen Smalley wrote:
> On Wed, Mar 4, 2020 at 2:20 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > - Allow BPF_MODIFY_RETURN attachment only to functions that are:
> >
> >     * Whitelisted for error injection by checking
> >       within_error_injection_list. Similar discussions happened for the
> >       bpf_override_return helper.
> >
> >     * security hooks, this is expected to be cleaned up with the LSM
> >       changes after the KRSI patches introduce the LSM_HOOK macro:
> >
> >         https://lore.kernel.org/bpf/20200220175250.10795-1-kpsingh@chromium.org/
> >
> > - The attachment is currently limited to functions that return an int.
> >   This can be extended later other types (e.g. PTR).
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Acked-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2460c8e6b5be..ae32517d4ccd 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -9800,6 +9801,33 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
> >
> >         return 0;
> >  }
> > +#define SECURITY_PREFIX "security_"
> > +
> > +static int check_attach_modify_return(struct bpf_verifier_env *env)
> > +{
> > +       struct bpf_prog *prog = env->prog;
> > +       unsigned long addr = (unsigned long) prog->aux->trampoline->func.addr;
> > +
> > +       if (within_error_injection_list(addr))
> > +               return 0;
> > +
> > +       /* This is expected to be cleaned up in the future with the KRSI effort
> > +        * introducing the LSM_HOOK macro for cleaning up lsm_hooks.h.
> > +        */
> > +       if (!strncmp(SECURITY_PREFIX, prog->aux->attach_func_name,
> > +                    sizeof(SECURITY_PREFIX) - 1)) {
> > +
> > +               if (!capable(CAP_MAC_ADMIN))
> > +                       return -EPERM;
> 
> CAP_MAC_ADMIN was originally introduced for Smack and is not
> all-powerful wrt SELinux, so this is not a sufficient check for
> SELinux.

I think you're misunderstanding the intent here.
This facility is just a faster version of kprobe based fault injection.
It doesn't care about LSM. Security is not a focus here.
It can fault inject in a lot of places in the kernel: syscalls,
kmalloc, page_alloc, fs internals, etc
I think above capable() check created this confusion and
we should remove it.
