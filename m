Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7DE19185C
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 19:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgCXSBS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 14:01:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45513 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgCXSBS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 14:01:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id b9so7705528pls.12
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2020 11:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=p/25+VohAOX3oBgJFFKkPBRMfW/ssz0RSjZO0iulozc=;
        b=Q9VMbXjnSM/D/DUHkyvF+6SqZf1W+Duhih6q1dsNV3HaC4RlaR0DWVaf7YsYP9/mOv
         2cL4SU+7oFPyDM04T0cTFfZ7eIw9mjJPnOCHS2N2FWE5/dbxzIQQUlSBRlbXkn+yxl4x
         EU39xlrlA3DrdPy7fmHBdhXNlbglNI47yR4ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=p/25+VohAOX3oBgJFFKkPBRMfW/ssz0RSjZO0iulozc=;
        b=Ok80rBgZUlx87ewEWA4r3APIKUm3HM2PZOWApgHUpYO/0bxgf7Y4oZN/qkuGl411VT
         i+whmQfmNKJ14KWKXZOc1cAm7vTvESrMz8dcSZhf5Og84M8tKyIIiDxkJEJPPDwuq4DM
         xgg5DrPPAT9dsztzI/Ch9VW46h7muy5Qic6MvxxpbfjCY65wlbRjz2f/Us/0IwkvZZ84
         J9JtZJUVrcN/IC0KjOMbR1HyqC2YJi588Nav3dL3iBwPQEQA+koYfrgj2tcG0bfJ7FXa
         dNdSAp95GCz3BTKpkEL7yXo+wGlg/f9rf18YOD/0eJZ+r7xQbzyNLl1sWIaOgfSCoFnQ
         KwWQ==
X-Gm-Message-State: ANhLgQ3gEdE1e7mNVvAeg/TaqpRZVBimkoSL9bE+0UJkNxi+/nYKEJdO
        XYhOvPWz7JMA4Q7cBhKYpL+eLg==
X-Google-Smtp-Source: ADFU+vsTVSpx5CLwY0bxhvEYPObBTSclhii5ia2w8eYqh/j/yFvNBo23Tqj4NUvTguO7wnpuUTIkTw==
X-Received: by 2002:a17:902:7c0c:: with SMTP id x12mr24983110pll.196.1585072876326;
        Tue, 24 Mar 2020 11:01:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f127sm16731008pfa.9.2020.03.24.11.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:01:15 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:01:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v5 4/7] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <202003241100.279457EF@keescook>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-5-kpsingh@chromium.org>
 <CAEjxPJ4MukexdmAD=py0r7vkE6vnn6T1LVcybP_GSJYsAdRuxA@mail.gmail.com>
 <20200324145003.GA2685@chromium.org>
 <CAEjxPJ4YnCCeQUTK36Ao550AWProHrkrW1a6K5RKuKYcPcfhyA@mail.gmail.com>
 <d578d19f-1d3b-f60d-f803-2fcb46721a4a@schaufler-ca.com>
 <CAEjxPJ59wijpB=wa4ZhPyX_PRXrRAX2+PO6e8+f25wrb9xndRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ59wijpB=wa4ZhPyX_PRXrRAX2+PO6e8+f25wrb9xndRA@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 24, 2020 at 01:49:34PM -0400, Stephen Smalley wrote:
> On Tue, Mar 24, 2020 at 12:25 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 3/24/2020 7:58 AM, Stephen Smalley wrote:
> > > On Tue, Mar 24, 2020 at 10:50 AM KP Singh <kpsingh@chromium.org> wrote:
> > >> On 24-Mär 10:35, Stephen Smalley wrote:
> > >>> On Mon, Mar 23, 2020 at 12:46 PM KP Singh <kpsingh@chromium.org> wrote:
> > >>>> From: KP Singh <kpsingh@google.com>
> > >>>> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > >>>> index 530d137f7a84..2a8131b640b8 100644
> > >>>> --- a/kernel/bpf/bpf_lsm.c
> > >>>> +++ b/kernel/bpf/bpf_lsm.c
> > >>>> @@ -9,6 +9,9 @@
> > >>>>  #include <linux/btf.h>
> > >>>>  #include <linux/lsm_hooks.h>
> > >>>>  #include <linux/bpf_lsm.h>
> > >>>> +#include <linux/jump_label.h>
> > >>>> +#include <linux/kallsyms.h>
> > >>>> +#include <linux/bpf_verifier.h>
> > >>>>
> > >>>>  /* For every LSM hook  that allows attachment of BPF programs, declare a NOP
> > >>>>   * function where a BPF program can be attached as an fexit trampoline.
> > >>>> @@ -27,6 +30,32 @@ noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
> > >>>>  #include <linux/lsm_hook_names.h>
> > >>>>  #undef LSM_HOOK
> > >>>>
> > >>>> +#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
> > >>>> +
> > >>>> +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > >>>> +                       const struct bpf_prog *prog)
> > >>>> +{
> > >>>> +       /* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
> > >>>> +        */
> > >>>> +       if (!capable(CAP_MAC_ADMIN))
> > >>>> +               return -EPERM;
> > >>> I had asked before, and will ask again: please provide an explicit LSM
> > >>> hook for mediating whether one can make changes to the LSM hooks.
> > >>> Neither CAP_MAC_ADMIN nor CAP_SYS_ADMIN suffices to check this for SELinux.
> > >> What do you think about:
> > >>
> > >>   int security_check_mutable_hooks(void)
> > >>
> > >> Do you have any suggestions on the signature of this hook? Does this
> > >> hook need to be BPF specific?
> > > I'd do something like int security_bpf_prog_attach_security(const
> > > struct bpf_prog *prog) or similar.
> > > Then the security module can do a check based on the current task
> > > and/or the prog.  We already have some bpf-specific hooks.
> >
> > I *strongly* disagree with Stephen on this. KRSI and SELinux are peers.
> > Just as Yama policy is independent of SELinux policy so KRSI policy should
> > be independent of SELinux policy. I understand the argument that BDF programs
> > ought to be constrained by SELinux, but I don't think it's right. Further,
> > we've got unholy layering when security modules call security_ functions.
> > I'm not saying there is no case where it would be appropriate, but this is not
> > one of them.
> 
> I explained this previously.  The difference is that the BPF programs
> are loaded from a userspace
> process, not a kernel-resident module.  They already recognize there
> is a difference here or
> they wouldn't have the CAP_MAC_ADMIN check above in their patch.  The
> problem with that
> check is just that CAP_MAC_ADMIN doesn't necessarily mean fully
> privileged with respect to
> SELinux, which is why I want an explicit hook.  This gets a NAK from
> me until there is such a hook.

Doesn't the existing int (*bpf_prog)(struct bpf_prog *prog); cover
SELinux's need here? I.e. it can already examine that a hook is being
created for the LSM (since it has a distinct type, etc)?

-- 
Kees Cook
