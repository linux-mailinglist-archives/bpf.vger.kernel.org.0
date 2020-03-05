Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 443E317A955
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 16:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCEPy0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 10:54:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41876 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgCEPy0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 10:54:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id v4so7641791wrs.8
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2020 07:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8r3r3JLBCoT+7BHX6G7TDShJ5a1/tz8dj9KPds9gTCo=;
        b=DEApbHTnS0agxpfhPaqw8/MbeQWWgxQiV8dMim1J2/cDkAgUz+6XYcVbU7CosnhTLk
         jBo/lHQ9zWrKOYL2BbSrzLmvYHQG1LRK6ppljf+IIBlhV7O4HdXRDC/SWiQ/SAPwDHfr
         /YNmZkOjupuCcvGVS5w+KPzUaHKJtNrvCe1PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8r3r3JLBCoT+7BHX6G7TDShJ5a1/tz8dj9KPds9gTCo=;
        b=IN6pxBhmra8tZQk6BqdZrIzIEcANlMoJipgtQGHbpDz6b4bJiXwpRZcBNq0GAn07hg
         CNXqr5U4Fo1FMEVnIbL5UA2V8dsFtfUbm7TeovO+Js0LTBW3+vWGwfqzxbx5lOGjacvd
         eg6lKfc9miJ6+OHkVgQ5gi4wv0Grhv1jfk6UAUu0asEQgDF5tMem9agEHlb/1HI4OB2p
         RtcX+YxLMCM3e5dZZhge7CjM9P0Otfia5U4xHkYvXKvmtO8HObzTl4GnO77ZgyN4LspH
         LLrt3Cdr8zf82bJYeNnmi61sCSa15b6AIt3aal/NCCed6Tu9qkTQseBC9x8XCFNqYARF
         xdeA==
X-Gm-Message-State: ANhLgQ241Tlj6+oMx7l4c64Gvhd/H2c1hh95oq2lrjCJP/qtnP3iBgg0
        2FjBZm4OeyOigD3ZEESl2kIzNw==
X-Google-Smtp-Source: ADFU+vuZnHlrjwtYGp90nAVDU7FR3teK5G/y9pKUhZxtjW/2S5agwnFL89xTRzG1s0R8AIPZj3It3A==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr10686408wrk.407.1583423663087;
        Thu, 05 Mar 2020 07:54:23 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id y8sm9685425wmj.22.2020.03.05.07.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:54:22 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 5 Mar 2020 16:54:21 +0100
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, casey@schaufler-ca.com
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Introduce BPF_MODIFY_RETURN
Message-ID: <20200305155421.GA209155@google.com>
References: <20200304191853.1529-1-kpsingh@chromium.org>
 <20200304191853.1529-4-kpsingh@chromium.org>
 <CAEjxPJ4+aW5JVC9QjJywjNUS=+cVJeaWwRHLwOssLsZyhX3siw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ4+aW5JVC9QjJywjNUS=+cVJeaWwRHLwOssLsZyhX3siw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05-Mar 08:51, Stephen Smalley wrote:
> On Wed, Mar 4, 2020 at 2:20 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > When multiple programs are attached, each program receives the return
> > value from the previous program on the stack and the last program
> > provides the return value to the attached function.
> >
> > The fmod_ret bpf programs are run after the fentry programs and before
> > the fexit programs. The original function is only called if all the
> > fmod_ret programs return 0 to avoid any unintended side-effects. The
> > success value, i.e. 0 is not currently configurable but can be made so
> > where user-space can specify it at load time.
> >
> > For example:
> >
> > int func_to_be_attached(int a, int b)
> > {  <--- do_fentry
> >
> > do_fmod_ret:
> >    <update ret by calling fmod_ret>
> >    if (ret != 0)
> >         goto do_fexit;
> >
> > original_function:
> >
> >     <side_effects_happen_here>
> >
> > }  <--- do_fexit
> >
> > The fmod_ret program attached to this function can be defined as:
> >
> > SEC("fmod_ret/func_to_be_attached")
> > int BPF_PROG(func_name, int a, int b, int ret)
> > {
> >         // This will skip the original function logic.
> >         return 1;
> > }
> >
> > The first fmod_ret program is passed 0 in its return argument.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> IIUC you've switched from a model where the BPF program would be
> invoked after the original function logic
> and the BPF program is skipped if the original function logic returns
> non-zero to a model where the BPF program is invoked first and
> the original function logic is skipped if the BPF program returns
> non-zero.  I'm not keen on that for userspace-loaded code attached

We do want to continue the KRSI series and the effort to implement a
proper BPF LSM. In the meantime, the tracing + error injection
solution helps us to:

  * Provide better debug capabilities.
  * And parallelize the effort to come up with the right helpers
    for our LSM work and work on sleepable BPF which is also essential
    for some of the helpers.

As you noted, in the KRSI v4 series, we mentioned that we would like
to have the user-space loaded BPF programs be unable to override the
decision made by the in-kernel logic/LSMs, but this got shot down:

   https://lore.kernel.org/bpf/00c216e1-bcfd-b7b1-5444-2a2dfa69190b@schaufler-ca.com

I would like to continue this discussion when we post the v5 series
for KRSI as to what the correct precedence order should be for the
BPF_PROG_TYPE_LSM and would appreciate if you also bring it up there.

> to LSM hooks; it means that userspace BPF programs can run even if
> SELinux would have denied access and SELinux hooks get
> skipped entirely if the BPF program returns an error.  I think Casey
> may have wrongly pointed you in this direction on the grounds
> it can already happen with the base DAC checking logic.  But that's

What we can do for this tracing/modify_ret series, is to remove
the special casing for "security_" functions in the BPF code and add
ALLOW_ERROR_INJECTION calls to the security hooks. This way, if
someone needs to disable the BPF programs being able to modify
security hooks, they can disable error injection. If that's okay, we
can send a patch.

- KP

> kernel DAC checking logic, not userspace-loaded code.
> And the existing checking on attachment is not sufficient for SELinux
> since CAP_MAC_ADMIN is not all powerful to SELinux.
> Be careful about designing your mechanisms around Smack because Smack
> is not the only LSM.
