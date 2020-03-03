Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18521785A6
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 23:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCCW2R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 17:28:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45063 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbgCCW2R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 17:28:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id v2so6418374wrp.12
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 14:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e4V+8aTWhdIlLEzf4Eox/9Ord8vKJnS3U23eYxJI4AQ=;
        b=KXqGqes3H3m8InAE8AGrElj7zAvDMD6xwXVFASzk6WwjuCdFaB4vMPGC2jaTP1ee28
         35OsUP23/42wx2xoQArttVKCiXPzhmAaFjJdOSCM1/+hSxiItYlTXPpd12zHHTVpnPQx
         /hKiRvHeqRGFZ/uA8E+RhYTTuO/5+L3wxwB6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e4V+8aTWhdIlLEzf4Eox/9Ord8vKJnS3U23eYxJI4AQ=;
        b=GRP6s8mtcT5VUxBeS9YkeX9wmzBk5o6W0Av6Ts8s8O14FT21Jqct9IN3IAjfkaCXtf
         pfQfafC+wRtdqz3OabFKFl6V0wLhPe1KbOZTvDlh0MoxdqNGDcvb/FXGh1tPacYlB5Wk
         QvZ5KzY/pvj/Su+z/FxQTxNl/4NuN7oO3T+U+G24YHbuodrOKnS32EKr9lvcD6W3J3yW
         vRGRWEC1sFpN4V+5QF6kpKizizfjyaLxK7JdyuVln1uAe0BCF4ItQ01tJriW1SxqlEoL
         kGdLAd896nWCFlesvZF5hrQSdPFSScnKM+9cFslTFbxMn3AVnk5sOm2Yigjy0RJrHqIZ
         lV+w==
X-Gm-Message-State: ANhLgQ0zdV8J1ia2bapxSowJQ0PmAoNBCfOodqmJmjml62kScAQDi0ap
        cijh5My3iK+qJKya0+MgLMunWQ==
X-Google-Smtp-Source: ADFU+vsO7rRWvBSAQDxjBwGmKgf0DoG0NPF8tyeTqymolzH6Fse1dadJP4xsklXMM6Et8L73vKrO0w==
X-Received: by 2002:a5d:608b:: with SMTP id w11mr198197wrt.366.1583274495670;
        Tue, 03 Mar 2020 14:28:15 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id n13sm773557wmd.21.2020.03.03.14.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:28:15 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 3 Mar 2020 23:28:12 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next 2/7] bpf: JIT helpers for fmod_ret progs
Message-ID: <20200303222812.GA5265@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
 <20200303140950.6355-3-kpsingh@chromium.org>
 <CAEf4BzZJ2E2rmyz7k4F7s=EXPbaAX7XncvUcHukX_FYDWeD7BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZJ2E2rmyz7k4F7s=EXPbaAX7XncvUcHukX_FYDWeD7BA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03-Mär 14:26, Andrii Nakryiko wrote:
> On Tue, Mar 3, 2020 at 6:13 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > * Split the invoke_bpf program to prepare for special handling of
> >   fmod_ret programs introduced in a subsequent patch.
> > * Move the definition of emit_cond_near_jump and emit_nops as they are
> >   needed for fmod_ret.
> > * Refactor branch target alignment into its own function
> >   align16_branch_target.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 158 ++++++++++++++++++++----------------
> >  1 file changed, 90 insertions(+), 68 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 15c7d28bc05c..475e354c2e88 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1361,35 +1361,100 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
> >                          -(stack_size - i * 8));
> >  }
> >
> 
> [...]
> 
> > +
> > +/* From Intel 64 and IA-32 Architectures Optimization
> > + * Reference Manual, 3.4.1.4 Code Alignment, Assembly/Compiler
> > + * Coding Rule 11: All branch targets should be 16-byte
> > + * aligned.
> > + */
> > +static void align16_branch_target(u8 **pprog)
> > +{
> > +       u8 *target, *prog = *pprog;
> > +
> > +       target = PTR_ALIGN(prog, 16);
> > +       if (target != prog)
> > +               emit_nops(&prog, target - prog);
> > +       if (target != prog)
> > +               pr_err("calcultion error\n");
> 
> this wasn't in the original code, do you feel like it's more important
> to check this and print error?
> 
> also typo: calculation error, but then it's a bit brief and
> uninformative message. So I don't know, maybe just drop it?

Ah, good catch! this is deinitely not intended to be here.
It's a debug artifact and needs to dropped indeed.

- KP

> 
> > +}
> > +
> > +static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
> > +{
> > +       u8 *prog = *pprog;
> > +       int cnt = 0;
> > +       s64 offset;
> > +
> > +       offset = func - (ip + 2 + 4);
> > +       if (!is_simm32(offset)) {
> > +               pr_err("Target %p is out of range\n", func);
> > +               return -EINVAL;
> > +       }
> > +       EMIT2_off32(0x0F, jmp_cond + 0x10, offset);
> > +       *pprog = prog;
> > +       return 0;
> > +}
> > +
> 
> [...]
