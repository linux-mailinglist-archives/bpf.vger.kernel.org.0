Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE240191819
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 18:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgCXRsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 13:48:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38062 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgCXRsZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 13:48:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id t28so17897685ott.5;
        Tue, 24 Mar 2020 10:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mbs4aVDmRmC8J/4oqCxwDOIrrZvgADtwZ+k3MwNOOe4=;
        b=qOVK6Fm/WfSe2eoaOGOghnA2TYwPL/GqS8fesDDQy/usdsJ6vXGscsxOYUQ3t372pa
         m21MVUH8T6ehMTGaxy9ZwEwreiz3G5lKVn/UvBmnlcMvVG2j47ZflqvTQquplUMTkvaO
         scCLZHN+uwj1p57pNi2gX+WRX4/fIYwXsys1j81SHxQu++H78vRg6+WcjanHqKweYGxl
         fYkfStZWRciRAcgcrC89JOL4P9rlopDSrwjOttyKVcgDvaYauZl181ha48+DYQ5SFDSu
         pHpZL+GIL8+Svli8H2zCBXN6iHHIcMTKpoyDVFQhklqfwZ9z4fcMfunxFeDYXdOk5IHl
         ZkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mbs4aVDmRmC8J/4oqCxwDOIrrZvgADtwZ+k3MwNOOe4=;
        b=WAjoWzIOLlsKVXnGqNsb33eKMImC3mu3OBUbF/qoTiPK8gsZGx7A7FF1V+1FbtJOnG
         4fXykRYAgnEmppZG8AiKehbOCdJOV2fDWVSkfgMrRznbvoI/68IrwEZ9j4R3oOZRPJ4X
         wQrkf4QkLEz+ZaF3ooi9mbtwC3EBkq1wcbwn/ZIoLKLbYvE/SK0S5YWfOcLC5NRmLQ0t
         ByFV7VI2kK6PT/vruQ+GjATi1nvVLCyahP8SNmbrPnMLKkUX3lwUrvkXByeD2RD0AEM6
         8sgRNs/9N8DFf0C8li5OWAcw8REUue/oUEExFCbz5rmNp2BAdNxzA8gd4hy4FFHNQxiK
         OzIw==
X-Gm-Message-State: ANhLgQ3ov235jwaw7aQ1OUxRqkOuR3e2fn35OnjNNYEQjWYzoltOhAR2
        6wF96P6BORJgXncE81e8QPlyTeUqO0Zr6WiG/JE=
X-Google-Smtp-Source: ADFU+vtqWwX4PrG3i0s/E4kJl5NwCDhplDK0CbdgH63HXzbjqGc2T4gLWdm434mcJ+rI/tovsUOo/EKM2Xm3holDqEw=
X-Received: by 2002:a05:6830:1f39:: with SMTP id e25mr7931301oth.135.1585072104337;
 Tue, 24 Mar 2020 10:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200323164415.12943-1-kpsingh@chromium.org> <20200323164415.12943-5-kpsingh@chromium.org>
 <CAEjxPJ4MukexdmAD=py0r7vkE6vnn6T1LVcybP_GSJYsAdRuxA@mail.gmail.com>
 <20200324145003.GA2685@chromium.org> <CAEjxPJ4YnCCeQUTK36Ao550AWProHrkrW1a6K5RKuKYcPcfhyA@mail.gmail.com>
 <d578d19f-1d3b-f60d-f803-2fcb46721a4a@schaufler-ca.com>
In-Reply-To: <d578d19f-1d3b-f60d-f803-2fcb46721a4a@schaufler-ca.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 24 Mar 2020 13:49:34 -0400
Message-ID: <CAEjxPJ59wijpB=wa4ZhPyX_PRXrRAX2+PO6e8+f25wrb9xndRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/7] bpf: lsm: Implement attach, detach and execution
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org,
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

On Tue, Mar 24, 2020 at 12:25 PM Casey Schaufler <casey@schaufler-ca.com> w=
rote:
>
> On 3/24/2020 7:58 AM, Stephen Smalley wrote:
> > On Tue, Mar 24, 2020 at 10:50 AM KP Singh <kpsingh@chromium.org> wrote:
> >> On 24-M=C3=A4r 10:35, Stephen Smalley wrote:
> >>> On Mon, Mar 23, 2020 at 12:46 PM KP Singh <kpsingh@chromium.org> wrot=
e:
> >>>> From: KP Singh <kpsingh@google.com>
> >>>> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> >>>> index 530d137f7a84..2a8131b640b8 100644
> >>>> --- a/kernel/bpf/bpf_lsm.c
> >>>> +++ b/kernel/bpf/bpf_lsm.c
> >>>> @@ -9,6 +9,9 @@
> >>>>  #include <linux/btf.h>
> >>>>  #include <linux/lsm_hooks.h>
> >>>>  #include <linux/bpf_lsm.h>
> >>>> +#include <linux/jump_label.h>
> >>>> +#include <linux/kallsyms.h>
> >>>> +#include <linux/bpf_verifier.h>
> >>>>
> >>>>  /* For every LSM hook  that allows attachment of BPF programs, decl=
are a NOP
> >>>>   * function where a BPF program can be attached as an fexit trampol=
ine.
> >>>> @@ -27,6 +30,32 @@ noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) =
{}
> >>>>  #include <linux/lsm_hook_names.h>
> >>>>  #undef LSM_HOOK
> >>>>
> >>>> +#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
> >>>> +
> >>>> +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >>>> +                       const struct bpf_prog *prog)
> >>>> +{
> >>>> +       /* Only CAP_MAC_ADMIN users are allowed to make changes to L=
SM hooks
> >>>> +        */
> >>>> +       if (!capable(CAP_MAC_ADMIN))
> >>>> +               return -EPERM;
> >>> I had asked before, and will ask again: please provide an explicit LS=
M
> >>> hook for mediating whether one can make changes to the LSM hooks.
> >>> Neither CAP_MAC_ADMIN nor CAP_SYS_ADMIN suffices to check this for SE=
Linux.
> >> What do you think about:
> >>
> >>   int security_check_mutable_hooks(void)
> >>
> >> Do you have any suggestions on the signature of this hook? Does this
> >> hook need to be BPF specific?
> > I'd do something like int security_bpf_prog_attach_security(const
> > struct bpf_prog *prog) or similar.
> > Then the security module can do a check based on the current task
> > and/or the prog.  We already have some bpf-specific hooks.
>
> I *strongly* disagree with Stephen on this. KRSI and SELinux are peers.
> Just as Yama policy is independent of SELinux policy so KRSI policy shoul=
d
> be independent of SELinux policy. I understand the argument that BDF prog=
rams
> ought to be constrained by SELinux, but I don't think it's right. Further=
,
> we've got unholy layering when security modules call security_ functions.
> I'm not saying there is no case where it would be appropriate, but this i=
s not
> one of them.

I explained this previously.  The difference is that the BPF programs
are loaded from a userspace
process, not a kernel-resident module.  They already recognize there
is a difference here or
they wouldn't have the CAP_MAC_ADMIN check above in their patch.  The
problem with that
check is just that CAP_MAC_ADMIN doesn't necessarily mean fully
privileged with respect to
SELinux, which is why I want an explicit hook.  This gets a NAK from
me until there is such a hook.
