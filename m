Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29631785F0
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 23:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgCCWv2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 17:51:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44716 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgCCWv2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 17:51:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id n7so6486334wrt.11
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 14:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pMsUvjiwCOPF/dDyeOX60wF1NNKJdi7xivScA5hcfdI=;
        b=fTDiEPY2YGw4Lu1DTg0xD1e/rsCytBZOd9CmqrBJ7oF5LvzePImM+P5Xmpc8nq07ZR
         +Jo4oPrjRllpKyj97yUOIcTndvt46U59N2S0ByhdWTpRm95HrMvWUkf5BI7mwFi1pYZl
         Rq/XgI9uY9vSHvQJkZk0ZdexQjbN7kAPmuRvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pMsUvjiwCOPF/dDyeOX60wF1NNKJdi7xivScA5hcfdI=;
        b=Zen5WuZN6w3JeOYk8pulYsk8UWVJjWzgyqkt/4BWosnA5LbF/WwMj4QO6qDbVSv7wE
         QfznVRntked8env3zN2k2dk7hwwdaCC0haj3g4UvjjqVf1AQvB8fHAiLGGIoe9PK9il9
         cHFjzWex0454OplHT/QkiiCGSsq9SPbI9vklrnCvulULpZSPN+y3LrqNz4zu6GTgm80b
         c01IP7Yy9PHJQ5aViXgUieiAXIjfzPXJZx7HUF2qkKBG9Sh7y5jEdUbPPHfzs1NX4j40
         9y3xv6XtN0meR2iem6jtOpXjzSWgGMBR7ixiNffiEJNsCllqomF03DgkCkP1yOCTOz0J
         v6Cg==
X-Gm-Message-State: ANhLgQ1YeLLlwt3Gv2FR/KnqAhBIr9IZzy96vd8hXdWAXQTrRe4g4lHb
        /B6ftzbWbVQp4cFp0Sqh7h7eOA==
X-Google-Smtp-Source: ADFU+vvWhmf42Ofc2H+llUP4Ha6CmqXMoyyKxm+kUuJJLsXn9lBhtDh32fl+aRZ6YozMT4jpgYBPDw==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr283288wru.148.1583275886534;
        Tue, 03 Mar 2020 14:51:26 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id 133sm916008wmd.5.2020.03.03.14.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:51:26 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 3 Mar 2020 23:51:24 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next 3/7] bpf: Introduce BPF_MODIFY_RETURN
Message-ID: <20200303225124.GA12968@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
 <20200303140950.6355-4-kpsingh@chromium.org>
 <CAEf4BzZVV12WoHDnQSfOKpndr3qVLEAz8itMcdqnQq8Q4njc0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZVV12WoHDnQSfOKpndr3qVLEAz8itMcdqnQq8Q4njc0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03-Mär 14:37, Andrii Nakryiko wrote:
> On Tue, Mar 3, 2020 at 6:12 AM KP Singh <kpsingh@chromium.org> wrote:
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
> > BPF_PROG(func_name, int a, int b, int ret)
> 
> same as on cover letter, return type is missing

Fixed. Thanks!

> 
> > {
> >         // This will skip the original function logic.
> >         return 1;
> > }
> >
> > The first fmod_ret program is passed 0 in its return argument.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c    | 96 ++++++++++++++++++++++++++++++++--
> >  include/linux/bpf.h            |  1 +
> >  include/uapi/linux/bpf.h       |  1 +
> >  kernel/bpf/btf.c               |  3 +-
> >  kernel/bpf/syscall.c           |  1 +
> >  kernel/bpf/trampoline.c        |  5 +-
> >  kernel/bpf/verifier.c          |  1 +
> >  tools/include/uapi/linux/bpf.h |  1 +
> >  8 files changed, 103 insertions(+), 6 deletions(-)
> >
> 
> [...]
> 
> >
> > +       if (fmod_ret->nr_progs) {
> > +               branches = kcalloc(fmod_ret->nr_progs, sizeof(u8 *),
> > +                                  GFP_KERNEL);
> > +               if (!branches)
> > +                       return -ENOMEM;
> > +               if (invoke_bpf_mod_ret(m, &prog, fmod_ret, stack_size,
> > +                                      branches))
> 
> branches leaks here

Good catch, sloppy work here by me.

> 
> > +                       return -EINVAL;
> > +       }
> > +
> >         if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > -               if (fentry->nr_progs)
> > +               if (fentry->nr_progs || fmod_ret->nr_progs)
> >                         restore_regs(m, &prog, nr_args, stack_size);
> >
> >                 /* call original function */
> > @@ -1573,6 +1649,14 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
> 
> there is early return one line above here, you need to free branches
> in that case to not leak memory
> 
> So I guess it's better to do goto cleanup approach at this point?

yeah, agreed, updated to doing a cleanup at the end.

- KP

> 
> >                 emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
> >         }
> >
> > +       if (fmod_ret->nr_progs) {
> > +               align16_branch_target(&prog);
> > +               for (i = 0; i < fmod_ret->nr_progs; i++)
> > +                       emit_cond_near_jump(&branches[i], prog, branches[i],
> > +                                           X86_JNE);
> > +               kfree(branches);
> > +       }
> > +
> 
> [...]
