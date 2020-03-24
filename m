Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0C61913BD
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 15:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgCXO5F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 10:57:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37563 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgCXO5E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 10:57:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id i12so17292381otp.4;
        Tue, 24 Mar 2020 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TXBnjDifQKdfM7kTTXCmgN+P2xxaBCRGAnS974vBCQE=;
        b=N9X36YP7/pr+5GUNPbcafUcjwhtGpWgcm4+Q0/mMc6EfB6ffCn0EJVOm1QXkyXAjFF
         3OmvUEPfVELgXnm1YFqmFBe+88cfqHkCnYeGcsTlKSzRZVs/+ZlryjU+btigyF+MB/Z1
         aeaGYTiXsTF0IXpFjcFSA3CWIhtAHQL7KSJwaznCQYzokxO1bofyU5RhnThAJpg1660U
         1DFcU6f6UtCmwf+zIH34wiwO+6rSeEoYyfowfY9PyUpYQFz03xfRf2lquZOZCaiaIDKf
         jTK7XsHgl20p2wRcu2X8+o5GgihIbktJEeNr1VWpFeelKxQgeZmrX+NelzmAL7bGK02u
         KgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TXBnjDifQKdfM7kTTXCmgN+P2xxaBCRGAnS974vBCQE=;
        b=GuhjUACO3Wi51xD+rJHFw5vDPQNoNytP5PWA4B7UoZlOHnf/do4en/6Q+ODoB+Y3vF
         iQHmDq92i7A6cAU/o8yWV2npVXzmcfXS0RhRUiXfk25IpllS0y0JhveLePPRUiNxwpQk
         x85zd/LCmWwKBYqR54ymPR852XHhmY/oGTCYKkg81NoVvrt1fh313u2Q7aYVQRS7j4AM
         ywMiimusUlOwKHDFmESfgoi/BT6HrG42MKO+TSdxg8Geir5ym5RXmMzeY5dGL/Y5nD7O
         lGK5dzxw38Nbcq1viZup3JQkHXv2/Wc+yU0T59DU+sCYs9HAl93hW6mtI0yu/ou0TpwQ
         w13Q==
X-Gm-Message-State: ANhLgQ3/yL0FGNpFfW0yGMqi6h9svmyW8EUoX+o0FkgRHtQxOKtjQKOI
        9fD7YiYtY5mn+8pQI8+v9qLhNmXl5dDxd67LWUM=
X-Google-Smtp-Source: ADFU+vvMJYpZPF2dKZFxIiIrls13Aj3amBsItxE2v2IYhDIJaBlSw/VDvVPiToinPeOYwx/4EdpXsgtJhVLKm8rZM0M=
X-Received: by 2002:a05:6830:1f39:: with SMTP id e25mr7273682oth.135.1585061823695;
 Tue, 24 Mar 2020 07:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200323164415.12943-1-kpsingh@chromium.org> <20200323164415.12943-5-kpsingh@chromium.org>
 <CAEjxPJ4MukexdmAD=py0r7vkE6vnn6T1LVcybP_GSJYsAdRuxA@mail.gmail.com> <20200324145003.GA2685@chromium.org>
In-Reply-To: <20200324145003.GA2685@chromium.org>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 24 Mar 2020 10:58:12 -0400
Message-ID: <CAEjxPJ4YnCCeQUTK36Ao550AWProHrkrW1a6K5RKuKYcPcfhyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/7] bpf: lsm: Implement attach, detach and execution
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 24, 2020 at 10:50 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On 24-M=C3=A4r 10:35, Stephen Smalley wrote:
> > On Mon, Mar 23, 2020 at 12:46 PM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > From: KP Singh <kpsingh@google.com>
> > > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > index 530d137f7a84..2a8131b640b8 100644
> > > --- a/kernel/bpf/bpf_lsm.c
> > > +++ b/kernel/bpf/bpf_lsm.c
> > > @@ -9,6 +9,9 @@
> > >  #include <linux/btf.h>
> > >  #include <linux/lsm_hooks.h>
> > >  #include <linux/bpf_lsm.h>
> > > +#include <linux/jump_label.h>
> > > +#include <linux/kallsyms.h>
> > > +#include <linux/bpf_verifier.h>
> > >
> > >  /* For every LSM hook  that allows attachment of BPF programs, decla=
re a NOP
> > >   * function where a BPF program can be attached as an fexit trampoli=
ne.
> > > @@ -27,6 +30,32 @@ noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {=
}
> > >  #include <linux/lsm_hook_names.h>
> > >  #undef LSM_HOOK
> > >
> > > +#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
> > > +
> > > +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > > +                       const struct bpf_prog *prog)
> > > +{
> > > +       /* Only CAP_MAC_ADMIN users are allowed to make changes to LS=
M hooks
> > > +        */
> > > +       if (!capable(CAP_MAC_ADMIN))
> > > +               return -EPERM;
> >
> > I had asked before, and will ask again: please provide an explicit LSM
> > hook for mediating whether one can make changes to the LSM hooks.
> > Neither CAP_MAC_ADMIN nor CAP_SYS_ADMIN suffices to check this for SELi=
nux.
>
> What do you think about:
>
>   int security_check_mutable_hooks(void)
>
> Do you have any suggestions on the signature of this hook? Does this
> hook need to be BPF specific?

I'd do something like int security_bpf_prog_attach_security(const
struct bpf_prog *prog) or similar.
Then the security module can do a check based on the current task
and/or the prog.  We already have some bpf-specific hooks.
