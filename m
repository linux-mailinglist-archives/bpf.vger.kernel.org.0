Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3FE17B05E
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 22:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgCEVQu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 16:16:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54809 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgCEVQu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 16:16:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id i9so110772wml.4
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2020 13:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rFYE9qU6hfZLMjbuv+Lw+SiZtkHRJmxeQZgCYrPMhQA=;
        b=isUdIXzz1WywdtIB6ayzczG6D27adzp5OvZ+mwE5OAioulxSPjDaDutrYz88lS5//h
         8gDvO0A0RNZ+xrP4i3PSqfYZQizRnLpAk1S7jcK2ysbU7KL5FXPhBQSp6wMbgWrIKgnG
         as59ZuFJ+uo1o9AqL2xYldyROmTL5aIFXgVSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rFYE9qU6hfZLMjbuv+Lw+SiZtkHRJmxeQZgCYrPMhQA=;
        b=XfxAwNkLF+qZYjoT72xly3ZlbLOGfZlaydAVTU3fBj/3eU6bGbPShs2zspCx0ON4j5
         wgwuXWruaJz5bsn5eUx74pZvS0VE0hU91Bpiq65aw8AjKTUMX4MmDubftK2TwUv6j7w2
         m+shoJlGP3nBZXtzXcLJ4gu566eg4T+EE6j4O1VYOte7e2CxY43ziznypkdTLU1Ok19f
         W07tw679zlAGdRTOndjbwMZsrLmJgiKURnQXPHGIV+ZFxbm6SXh9PMzOPqqoWkEAxpxW
         ig0kDdxrNuQ7g3vxLh8lokhNgDz1YK7cEWMrev1sP2QXP/glxhRLZKjrg/zEZ7v84Cz2
         L95A==
X-Gm-Message-State: ANhLgQ0Bn4kV5YpHhfRF2MhZzkVXbhHMhqT9nDpbQbacsWMw9gly+TTr
        O9rQoemxMaUa8KknGoJ/1VaFWw==
X-Google-Smtp-Source: ADFU+vuwbPUqEfT9MYVYDIUGPBhYImhXKM8fUAOSLCzk+p4JfLVCw9oSKX/YzU7LYBOvnLdNGrs3gg==
X-Received: by 2002:a05:600c:218d:: with SMTP id e13mr686605wme.127.1583443006355;
        Thu, 05 Mar 2020 13:16:46 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id j5sm10577968wmi.33.2020.03.05.13.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 13:16:45 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 5 Mar 2020 22:16:43 +0100
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Introduce BPF_MODIFY_RETURN
Message-ID: <20200305211643.GA12094@chromium.org>
References: <20200304191853.1529-1-kpsingh@chromium.org>
 <20200304191853.1529-4-kpsingh@chromium.org>
 <CAEjxPJ4+aW5JVC9QjJywjNUS=+cVJeaWwRHLwOssLsZyhX3siw@mail.gmail.com>
 <20200305155421.GA209155@google.com>
 <CAEjxPJ5u7tsa_9-7Oq_Wi28mZD_aDC1tVWj5Tb8ud=bfEYsY9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ5u7tsa_9-7Oq_Wi28mZD_aDC1tVWj5Tb8ud=bfEYsY9Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05-Mär 14:43, Stephen Smalley wrote:
> On Thu, Mar 5, 2020 at 10:54 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > On 05-Mar 08:51, Stephen Smalley wrote:
> > > IIUC you've switched from a model where the BPF program would be
> > > invoked after the original function logic
> > > and the BPF program is skipped if the original function logic returns
> > > non-zero to a model where the BPF program is invoked first and
> > > the original function logic is skipped if the BPF program returns
> > > non-zero.  I'm not keen on that for userspace-loaded code attached
> >
> > We do want to continue the KRSI series and the effort to implement a
> > proper BPF LSM. In the meantime, the tracing + error injection
> > solution helps us to:
> >
> >   * Provide better debug capabilities.
> >   * And parallelize the effort to come up with the right helpers
> >     for our LSM work and work on sleepable BPF which is also essential
> >     for some of the helpers.
> >
> > As you noted, in the KRSI v4 series, we mentioned that we would like
> > to have the user-space loaded BPF programs be unable to override the
> > decision made by the in-kernel logic/LSMs, but this got shot down:
> >
> >    https://lore.kernel.org/bpf/00c216e1-bcfd-b7b1-5444-2a2dfa69190b@schaufler-ca.com
> >
> > I would like to continue this discussion when we post the v5 series
> > for KRSI as to what the correct precedence order should be for the
> > BPF_PROG_TYPE_LSM and would appreciate if you also bring it up there.
> 
> That's fine but I guess I don't see why you or anyone else would
> bother with introducing a BPF_PROG_TYPE_LSM
> if BPF_PROG_MODIFY_RETURN is accepted and is allowed to attach to the
> LSM hooks.  What's the benefit to you
> if you can achieve your goals directly with MODIFY_RETURN?

There is still value in being a proper LSM, as I had mentioned in KRSI
v3 that not all security_* wrappers simply call the attached hooks and
return their exit code.

It's also okay, taking into consideration Casey's objections and Kees'
suggestion, to be properly registered with the LSM framework (even if
it is with LSM_ORDER_LAST) and work towards improving some of the
performance bottle-necks in the framework. It would be a positive
outcome for all LSMs.

BPF_MODIFY_RETURN is just a first step which lays the foundation for
BPF_PROG_TYPE_LSM and facilitates us to build BPF infrastructure for
it.

- KP

> 
> > > to LSM hooks; it means that userspace BPF programs can run even if
> > > SELinux would have denied access and SELinux hooks get
> > > skipped entirely if the BPF program returns an error.  I think Casey
> > > may have wrongly pointed you in this direction on the grounds
> > > it can already happen with the base DAC checking logic.  But that's
> >
> > What we can do for this tracing/modify_ret series, is to remove
> > the special casing for "security_" functions in the BPF code and add
> > ALLOW_ERROR_INJECTION calls to the security hooks. This way, if
> > someone needs to disable the BPF programs being able to modify
> > security hooks, they can disable error injection. If that's okay, we
> > can send a patch.
> 
> Realistically distros tend to enable lots of developer-friendly
> options including error injection, and most users don't build their
> own kernels
> and distros won't support them when they do. So telling users they can
> just rebuild their kernel without error injection if they care about
> BPF programs being able to modify security hooks isn't really viable.
> The security modules need a way to veto it based on their policies.
> That's why I suggested a security hook here.
