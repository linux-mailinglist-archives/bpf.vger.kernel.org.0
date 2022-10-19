Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE93604071
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 11:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiJSJ46 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 05:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbiJSJ43 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 05:56:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8805810A7FE;
        Wed, 19 Oct 2022 02:32:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n12so27936920wrp.10;
        Wed, 19 Oct 2022 02:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uRkokOnUGTB7YuuZ3HxvCL2EU7JYl74de/Mbu83cbuA=;
        b=RDX8T5T0XtX3o+g5YTuJgc/k6wZqjY06wjnbWG8cfKToMu2DIl3ujkjBGAufkRIMRH
         Hfsoocd9Ll60B8Lozu3PEVlzVVKSsIJ8WmLi228cYopOrpF9rfCJH9O/LuWrGuars7d9
         m4moV7UzxQ7GNjJZfvn7Et6EBW4MKtB2aQ+PaNos7BQR53D5MswBZj6iSK9AZc5FRBHK
         HKn+7JAlAfJG3mjgCV8Avjhrf0hTOhoU6WUkCQSBE1YfCYMm707DetMhBYvl1XRkPQ+B
         PXQRdYMRWb387QTMTHYtPFhFtvWobbE8wJqE7ZPkDMPZTFR7dWAF2CQZIgwf7YZvYtWx
         6a+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRkokOnUGTB7YuuZ3HxvCL2EU7JYl74de/Mbu83cbuA=;
        b=45832iBD20GI5ionXDhlbjniSDA8NQplSI6BFnj+Tr1FW6yaINnub+IpILTgSXtOuL
         SX3r0mCmOSa/I6YsWH24HW6xAb6q/UiJXzuMMudEthzUEhv9BmF5Oda3BPkIsMZCvGxK
         XXaW5FBj0VXf42VY3DVkPMRZngtkk+2ts/o5P+zGUe63Mhv3R2ZGPqPiFzYVxeBfTrmA
         5bx3PRGKGzXjbUL6aBC+pSRU0zgPLj1r/11bN4iAxYKhjHYEBdTBFfJd0+fBGw06Tfbm
         dNOPpnCHkd659xos+B2WVQ9mANcza6CqCZu3veujexeLvxrDfeZZ7n7V78KCqUHU0qmL
         BjpQ==
X-Gm-Message-State: ACrzQf2gWYsdTUATVeLE2JD8OdgRGoYJpY2CRPtfdsQjWgApBvwe1s4x
        6zKOYOfUtcD2xHe96T9OD54=
X-Google-Smtp-Source: AMsMyM6hY/mR6nXmoP38MIbO0/nm/YOio2x+b9h9je3MNNv/Dhv0OhDQqND0rZdCpyg+KQBiimsSdg==
X-Received: by 2002:a5d:54ce:0:b0:22e:2ecf:7c2a with SMTP id x14-20020a5d54ce000000b0022e2ecf7c2amr4371465wrv.181.1666171814580;
        Wed, 19 Oct 2022 02:30:14 -0700 (PDT)
Received: from krava ([83.240.63.167])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bc047000000b003b5054c6f87sm15647813wmc.21.2022.10.19.02.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 02:30:13 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 19 Oct 2022 11:30:11 +0200
To:     sdf@google.com
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Akihiro HARAI <jharai0815@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH] x86: Include asm/ptrace.h in syscall_wrapper header
Message-ID: <Y0/Do4l0bALGrD0p@krava>
References: <20221018122708.823792-1-jolsa@kernel.org>
 <Y07vGVPIf913gND8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07vGVPIf913gND8@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 11:23:21AM -0700, sdf@google.com wrote:
> On 10/18, Jiri Olsa wrote:
> > From: Jiri Olsa <olsajiri@gmail.com>
> 
> > With just the forward declaration of the 'struct pt_regs' in
> > syscall_wrapper.h, the syscall stub functions:
> 
> >    __[x64|ia32]_sys_*(struct pt_regs *regs)
> 
> > will have different definition of 'regs' argument in BTF data
> > based on which object file they are defined in.
> 
> > If the syscall's object includes 'struct pt_regs' definition,
> > the BTF argument data will point to 'struct pt_regs' record,
> > like:
> 
> >    [226] STRUCT 'pt_regs' size=168 vlen=21
> >           'r15' type_id=1 bits_offset=0
> >           'r14' type_id=1 bits_offset=64
> >           'r13' type_id=1 bits_offset=128
> >    ...
> 
> > If not, it will point to fwd declaration record:
> 
> >    [15439] FWD 'pt_regs' fwd_kind=struct
> 
> > and make bpf tracing program hooking on those functions unable
> > to access fields from 'struct pt_regs'.
> 
> Is the core issue here is that we can't / don't resolve FWD declarations
> at load time (or dedup time)? I'm assuming 'struct pt_regs' is still
> exposed somewhere in BTF via some other obj file, it's just those
> syscall definitions that have FWD decl?

yes, BTF is generated from dwarf debug info, so it's object based,
and in some objects the regs argument will point to full struct
definition and in some just to forward declaration

> 
> Applying this patch seems fine for now, but also seems fragile. Should
> we instead/also teach verifier/dedup/whatever to resolve those FWD
> declarations?

I'm not sure how hard it'd be to connect forward declarations
to definitions.. it'd need to be probably in dedup or verifier
as you suggest

and I think it'd need to be done just based on struct name search,
so I expect all sort of unexpected problems ;-) other than to be
sure you connect to proper struct

Andrii will have probably better idea if and where this is possible

jirka

> 
> > Including asm/ptrace.h directly in syscall_wrapper.h to make
> > sure all syscalls see 'struct pt_regs' definition and resulted
> > BTF for '__*_sys_*(struct pt_regs *regs)' functions point to
> > actual struct, not just forward declaration.
> 
> > Reported-by: Akihiro HARAI <jharai0815@gmail.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >   arch/x86/include/asm/syscall_wrapper.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> > diff --git a/arch/x86/include/asm/syscall_wrapper.h
> > b/arch/x86/include/asm/syscall_wrapper.h
> > index 59358d1bf880..fd2669b1cb2d 100644
> > --- a/arch/x86/include/asm/syscall_wrapper.h
> > +++ b/arch/x86/include/asm/syscall_wrapper.h
> > @@ -6,7 +6,7 @@
> >   #ifndef _ASM_X86_SYSCALL_WRAPPER_H
> >   #define _ASM_X86_SYSCALL_WRAPPER_H
> 
> > -struct pt_regs;
> > +#include <asm/ptrace.h>
> 
> >   extern long __x64_sys_ni_syscall(const struct pt_regs *regs);
> >   extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
> > --
> > 2.37.3
> 
