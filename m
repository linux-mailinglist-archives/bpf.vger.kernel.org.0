Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACA86B4956
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 16:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjCJPLh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 10:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbjCJPLE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 10:11:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A3A1CBD2
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 07:03:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9571B82340
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CAAC4339C;
        Fri, 10 Mar 2023 15:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678460597;
        bh=QnVRXmtRORWIzVwnY/5i6uovxq4CV8G1SNyRr81zkdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VdMW5DLYxOsWJ7qHvhphtxJECoDti8kCzrm/wpdUw00HI0rF8uTChFLzMqg0i3S4x
         D7h0ItcugbGWM+Sya9s/DZSBPrIC7tp1z0x92LQoKttILnI6xGF+hY21asUfhvNovx
         z41X2alS/GruyPFL2L0TibRX/3nmax1oWVuH5UAKDxK9KwukzvQ/SH6YMVo6+wRw0i
         mBc1u6xaEdeHYzSerL53FLFbFmybzyaLayB6wJaV8zPqL0NbztIbf+gQ6kJ9ua9N8S
         /Rn8Rpu2Tjxpsc8edcemfz51Lyex8KuEHRuqJK2Et5crHuC/vQRXzHmZtfebz9058Q
         6p4yYr7w0SBwA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C68754049F; Fri, 10 Mar 2023 12:03:14 -0300 (-03)
Date:   Fri, 10 Mar 2023 12:03:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        bpf@vger.kernel.org
Subject: Re: [RFC dwarves] syscall functions in BTF
Message-ID: <ZAtGsuSO6Jx2ZLBy@kernel.org>
References: <ZAsBYpsBV0wvkhh0@krava>
 <faf34d4b-d7a3-2573-383b-2bd8db422734@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faf34d4b-d7a3-2573-383b-2bd8db422734@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Mar 10, 2023 at 12:43:31PM +0000, Alan Maguire escreveu:
> On 10/03/2023 10:07, Jiri Olsa wrote:
> > hi,
> > with latest pahole fixes we get rid of some syscall functions (with
> > __x64_sys_ prefix) and it seems to fall down to 2 cases:
> > 
> > - weak syscall functions generated in kernel/sys_ni.c prevent these syscalls
> >   to be generated in BTF. The reason is the __COND_SYSCALL macro uses
> >   '__unused' for regs argument:
> > 
> >         #define __COND_SYSCALL(abi, name)                                      \
> >                __weak long __##abi##_##name(const struct pt_regs *__unused);   \
> >                __weak long __##abi##_##name(const struct pt_regs *__unused)    \
> >                {                                                               \
> >                        return sys_ni_syscall();                                \
> >                }
> > 
> >   and having weak function with different argument name will rule out the
> >   syscall from BTF functions
> > 
> >   the patch below workarounds this by using the same argument name,
> >   but I guess the real fix would be to check the whole type not just
> >   the argument name.. or ignore weak function if there's non weak one
> > 
> >   I guess there will be more cases like this in kernel
> > 
> >
 
> Thanks for the report Jiri! I'm working on reusing the dwarves_fprintf.c
> code to use string comparisons of function prototypes (minus parameter names!)
> instead as a more robust comparison.  Hope to have something working soon..

Humm, that could be an option, a simple strcmp after snprintf'ing the
function prototype, but there is also the type__compare_members_types()
approach, used to order types in pahole, the same could be done for
function prototypes?

I.e. to compare a function prototype for functions with the same name we
would check its return value type, the number of arguments and then each
of the arguments, continuing to consider the names as an heuristic that
functions with all being so far equal having different argument names
may indicate different functions, but if there is no name in both
functions, look at its type instead, where we then would use
type__compare_members_types() for structs/unions?

- Arnaldo
  
> > - we also do not get any syscall with no arguments, because they are
> >   generated as aliases to __do_<syscall> function:
> > 
> >         $ nm ./vmlinux | grep _sys_fork
> >         ffffffff81174890 t __do_sys_fork
> >         ffffffff81174890 T __ia32_sys_fork
> >         ffffffff81174880 T __pfx___x64_sys_fork
> >         ffffffff81174890 T __x64_sys_fork
> > 
> >   with:
> >         #define __SYS_STUB0(abi, name)                                          \
> >                 long __##abi##_##name(const struct pt_regs *regs);              \
> >                 ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);                 \
> >                 long __##abi##_##name(const struct pt_regs *regs)               \
> >                         __alias(__do_##name);
> > 
> >   the problem seems to be that there's no DWARF data for aliased symbol,
> >   so pahole won't see any __x64_sys_fork record
> >   I'm not sure how to fix this one
> > 
> 
> Is this one a new issue, or did you just spot it when looking at the other case?
> 
> Thanks!
> 
> Alan
> 
> >   technically we can always connect to __do_sys_fork, but we'd need to
> >   have special cases for such syscalls.. would be great to have all with
> >   '__x64_sys_' prefix
> > 
> > 
> > thoughts?
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
> > index fd2669b1cb2d..e02dab630577 100644
> > --- a/arch/x86/include/asm/syscall_wrapper.h
> > +++ b/arch/x86/include/asm/syscall_wrapper.h
> > @@ -80,8 +80,8 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
> >  	}
> >  
> >  #define __COND_SYSCALL(abi, name)					\
> > -	__weak long __##abi##_##name(const struct pt_regs *__unused);	\
> > -	__weak long __##abi##_##name(const struct pt_regs *__unused)	\
> > +	__weak long __##abi##_##name(const struct pt_regs *regs);	\
> > +	__weak long __##abi##_##name(const struct pt_regs *regs)	\
> >  	{								\
> >  		return sys_ni_syscall();				\
> >  	}
> > 

-- 

- Arnaldo
