Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 259D2195DFF
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 19:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgC0S7w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 14:59:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44509 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0S7w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 14:59:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id b72so4913460pfb.11
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 11:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=twjYcQrRYpiw9NudM5mQXAf1fpDRg8b0hwUBq6FdQjU=;
        b=BvMDA3FmKQtoeTxdP15PTNARGM9gHf3Feep8W5rjyaXMr3aZzhTYvlY1A9qlAuufld
         im3+AVd7vDsI993CjrFNXXH3bYLxcmYeWbrURE8nGUcT0SoEKHX1wEkT1TX26MUDgfM8
         1oR8E85XFrBCP7YHWhsudLUxOkUucgASTxyDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=twjYcQrRYpiw9NudM5mQXAf1fpDRg8b0hwUBq6FdQjU=;
        b=kMOG3CAIWCrMMwCUpJexBV+oSk3D7c0Wuprk/71SiCZC7PvdEJsfn0nOuRwxzu5HGX
         dM94YaWodk5NTBtl6OQQU/w+1vtEFDmwpAZOgd2vVGUK6RaUw4Bd0eSaQB9oiYATVSHG
         ec/FHdL58p8ARqEVBZkqzZme8QxWlIbX4lRC85AVCzOw9IWakna3qMkIalUTnqT6fAZP
         /R9kkJfQDMXc6hjfbU55q3BFvj2SACgNe0ZmIo7L2R72mOiQtos9wzXZaBaewdrPIj6L
         V/KcOVzZCQUJObdZD3Jp+tn1dfj2G1EDIoTASXIshnAJgozf8V45s6SHuMIrjg58yVB/
         zNoQ==
X-Gm-Message-State: ANhLgQ2qHaePXJarW4i6j1pU2LdYS5LAs5pvdw2lEikFo4hUzZs0lNxA
        RDRtPQof3Iu1GHTMC7nM2e/wiw==
X-Google-Smtp-Source: ADFU+vtMRQfs9N4AjysrflNX5zG9vzYD/JPSw15rRMFH/Mx2OQ8LyX9qs1/Ulvgri4xT39OWOujRNQ==
X-Received: by 2002:a63:c212:: with SMTP id b18mr722672pgd.92.1585335591118;
        Fri, 27 Mar 2020 11:59:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e26sm4679920pfj.61.2020.03.27.11.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 11:59:50 -0700 (PDT)
Date:   Fri, 27 Mar 2020 11:59:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        KP Singh <kpsingh@chromium.org>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <202003271143.71E0C591C1@keescook>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-5-kpsingh@chromium.org>
 <alpine.LRH.2.21.2003271119420.17089@namei.org>
 <2241c806-65c9-68f5-f822-9a245ecf7ba0@tycho.nsa.gov>
 <20200327124115.GA8318@chromium.org>
 <14ff822f-3ca5-7ebb-3df6-dd02249169d2@tycho.nsa.gov>
 <a3f6d9f8-6425-af28-d472-fad642439b69@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3f6d9f8-6425-af28-d472-fad642439b69@schaufler-ca.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 27, 2020 at 09:36:15AM -0700, Casey Schaufler wrote:
> On 3/27/2020 6:43 AM, Stephen Smalley wrote:
> > On 3/27/20 8:41 AM, KP Singh wrote:
> >> On 27-Mär 08:27, Stephen Smalley wrote:
> >>> On 3/26/20 8:24 PM, James Morris wrote:
> >>>> On Thu, 26 Mar 2020, KP Singh wrote:
> >>>>
> >>>>> +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >>>>> +            const struct bpf_prog *prog)
> >>>>> +{
> >>>>> +    /* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
> >>>>> +     */
> >>>>> +    if (!capable(CAP_MAC_ADMIN))
> >>>>> +        return -EPERM;
> >>>>> +
> >>>>
> >>>> Stephen, can you confirm that your concerns around this are resolved
> >>>> (IIRC, by SELinux implementing a bpf_prog callback) ?
> >>>
> >>> I guess the only residual concern I have is that CAP_MAC_ADMIN means
> >>> something different to SELinux (ability to get/set file security contexts
> >>> unknown to the currently loaded policy), so leaving the CAP_MAC_ADMIN check
> >>> here (versus calling a new security hook here and checking CAP_MAC_ADMIN in
> >>> the implementation of that hook for the modules that want that) conflates
> >>> two very different things.  Prior to this patch, there are no users of
> >>> CAP_MAC_ADMIN outside of individual security modules; it is only checked in
> >>> module-specific logic within apparmor, safesetid, selinux, and smack, so the
> >>> meaning was module-specific.
> >>
> >> As we had discussed, We do have a security hook as well:
> >>
> >> https://lore.kernel.org/bpf/20200324180652.GA11855@chromium.org/
> >>
> >> The bpf_prog hook which can check for BPF_PROG_TYPE_LSM and implement
> >> module specific logic for LSM programs. I thougt that was okay?
> >>
> >> Kees was in favor of keeping the CAP_MAC_ADMIN check here:
> >>
> >> https://lore.kernel.org/bpf/202003241133.16C02BE5B@keescook
> >>
> >> If you feel strongly and Kees agrees, we can remove the CAP_MAC_ADMIN
> >> check here, but given that we already have a security hook that meets
> >> the requirements, we probably don't need another one.
> >
> > I would favor removing the CAP_MAC_ADMIN check here, and implementing it in a bpf_prog hook for Smack and AppArmor if they want that.  SELinux would implement its own check in its existing bpf_prog hook.
> >
> The whole notion of one security module calling into another for permission
> to do something still gives me the heebee jeebees, but if more nimble minds
> than mine think this is a good idea I won't nack it.

Well, it's a hook into BPF prog creation, not the BPF LSM specifically,
so that's why I think it's general enough control without it being
directly weird. :)

As far as dropping CAP_MAC_ADMIN, yeah, that should be fine. Creating LSM
BPF programs already requires CAP_SYS_ADMIN, so for SELinux-less systems,
that's likely fine. If we need to change the BPF program creation access
control in the future we can revisit it then.

-- 
Kees Cook
