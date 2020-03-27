Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727411958F8
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 15:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgC0O3w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 10:29:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35926 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbgC0O3w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 10:29:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so11654125wrs.3
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7Zt6SLl1aTUxOOXGO0w2ygq6jqSkCyYzZ2HwaOn8m8A=;
        b=HvKrQXl6CnavrASXBIW6eNLJ0pJ/BUDaqpuU3EBwzRfnU5o76D8VAhzATHdkU41xAG
         fHvPOl0JHylpN138JC+O+5jQ4Odx8B95X6poKn732ENl1afDY6bt1Giguv37ox+n7qNg
         vBmt30/94c4E//F3K0wXfQQxV65O93+DoQJtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7Zt6SLl1aTUxOOXGO0w2ygq6jqSkCyYzZ2HwaOn8m8A=;
        b=Da+nGi9r670ApvHIhUK8l/0wZEsxHhXfBBEEohHKuwxB6B+yt/0a/B1NCzFwnXt3yB
         IdKlAlgrp5rYkjfllUJRN2dEO760b8JEt1+Dhgmg9wAjhizA4NXLL8dgKfGqb0SotOQw
         bAc4lSLt3ooJsSrRGvtgRGL3ppoyVEMEHk8gHTmDrxy8dpqGHT7Q1zjtxv9bOqXmgpfD
         d+As0rbb//XDpepNmFfeX++kw1lj1bDMGHEWt/ifb2iaWHPXuRvZ9ey4DLKIAMFq9D4a
         FHyiYr3TwG8zMXTo8Ul3X8oh6+LuTrTDm+cJQxU1MYsE5tAgPJkAuAUdq7sZrBF5ONYC
         +0LQ==
X-Gm-Message-State: ANhLgQ17b3oF9MxyQ1s7Gk4Mhwtrp72JjrcSM6fQWXbXGdZr3TG+AqKm
        SMZFl0F2zlcFbp1UAS09EQlMrg==
X-Google-Smtp-Source: ADFU+vtMVikTi8+QZsr8Smgd86ygktQImaDCLFpPwBryY7M3+OoqCtEIQj/OE5rvLyrjg6rHvmiCQg==
X-Received: by 2002:adf:a1d6:: with SMTP id v22mr15712097wrv.416.1585319390652;
        Fri, 27 Mar 2020 07:29:50 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id v8sm8867894wrp.84.2020.03.27.07.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 07:29:50 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 27 Mar 2020 15:29:43 +0100
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200327142943.GA23618@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-5-kpsingh@chromium.org>
 <alpine.LRH.2.21.2003271119420.17089@namei.org>
 <2241c806-65c9-68f5-f822-9a245ecf7ba0@tycho.nsa.gov>
 <20200327124115.GA8318@chromium.org>
 <14ff822f-3ca5-7ebb-3df6-dd02249169d2@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14ff822f-3ca5-7ebb-3df6-dd02249169d2@tycho.nsa.gov>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 27-Mär 09:43, Stephen Smalley wrote:
> On 3/27/20 8:41 AM, KP Singh wrote:
> > On 27-Mär 08:27, Stephen Smalley wrote:
> > > On 3/26/20 8:24 PM, James Morris wrote:
> > > > On Thu, 26 Mar 2020, KP Singh wrote:
> > > > 
> > > > > +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > > > > +			const struct bpf_prog *prog)
> > > > > +{
> > > > > +	/* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
> > > > > +	 */
> > > > > +	if (!capable(CAP_MAC_ADMIN))
> > > > > +		return -EPERM;
> > > > > +
> > > > 
> > > > Stephen, can you confirm that your concerns around this are resolved
> > > > (IIRC, by SELinux implementing a bpf_prog callback) ?
> > > 
> > > I guess the only residual concern I have is that CAP_MAC_ADMIN means
> > > something different to SELinux (ability to get/set file security contexts
> > > unknown to the currently loaded policy), so leaving the CAP_MAC_ADMIN check
> > > here (versus calling a new security hook here and checking CAP_MAC_ADMIN in
> > > the implementation of that hook for the modules that want that) conflates
> > > two very different things.  Prior to this patch, there are no users of
> > > CAP_MAC_ADMIN outside of individual security modules; it is only checked in
> > > module-specific logic within apparmor, safesetid, selinux, and smack, so the
> > > meaning was module-specific.
> > 
> > As we had discussed, We do have a security hook as well:
> > 
> > https://lore.kernel.org/bpf/20200324180652.GA11855@chromium.org/
> > 
> > The bpf_prog hook which can check for BPF_PROG_TYPE_LSM and implement
> > module specific logic for LSM programs. I thougt that was okay?
> > 
> > Kees was in favor of keeping the CAP_MAC_ADMIN check here:
> > 
> > https://lore.kernel.org/bpf/202003241133.16C02BE5B@keescook
> > 
> > If you feel strongly and Kees agrees, we can remove the CAP_MAC_ADMIN
> > check here, but given that we already have a security hook that meets
> > the requirements, we probably don't need another one.
> 
> I would favor removing the CAP_MAC_ADMIN check here, and implementing it in

Okay. For the scope of this series I will remove this check in the
next revision. If people feel strongly that we need it centrally
within the BPF infrastructure, we can do that as a separate patch and
discuss it there.

> a bpf_prog hook for Smack and AppArmor if they want that.  SELinux would
> implement its own check in its existing bpf_prog hook.

I think Smack and AppArmor can also use the same hook. Since we
already have a hook, I don't think anyone is blocked from
implementing policy logic for loading LSM BPF programs.

James/Kees does this sound okay?

- KP

> 
> 
> 
