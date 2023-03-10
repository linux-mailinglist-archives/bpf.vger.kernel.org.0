Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B60E6B4A2F
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 16:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjCJPUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 10:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjCJPT0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 10:19:26 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C9C13F56C
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 07:10:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso3633871wms.5
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 07:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678460949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CF8ice3JvVbUuoONcaZEn272ZZcq+I9FazBjtU1ZU0U=;
        b=LQ2lgpQ+WLzNRYYeFNewY1Dx0lW3a9pay1ATBzyIWXwfrFr1uN9gIwqpL6QETXCjBd
         Omjfr0B6ly1+2msDFwP3/cgBzUxTedrkivF67kAosMTwEbcen6YKu3kok4ZyvYMLIY7f
         066UxNX+YQPgLs8dcA01aMJ3BYEZc+RP9MS5CpjOMavWjCr8OpJANTRt7lbsVa0XVNb7
         P+Z3CDGB9kDakdSxxQIUQ1uNutEnVleRTil4sx1kBPZHcWhE/VBw5Fm8dQODoRVmFq6v
         UD7tmtLJsSIjo2TAIM7S/aC97j84VWHQLW8T9G4RrPWWpXkImYlCLHZPmsOMXd1dZ50T
         jaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678460949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CF8ice3JvVbUuoONcaZEn272ZZcq+I9FazBjtU1ZU0U=;
        b=WC9ZEbugLEmwaqW6kR7aUCpiehTFB09XxFEQdAhJbhlIac6MU8NDCQX8BnSmltK5h6
         jIVs8RaoK4E5V6s7t9volz422oyZLFtEXX68KXRhuj5pS023RC+ZgfVxfym8x/DVD6mD
         b/9l+0kzqR8GR3wNjRyzF3ElEwGVBKBN2ySPMGv3EGIc1dRJKRcHMJOpqub27KQRS9Wx
         EAVddUk/M1cvZ+eSHZxx38I8n/OEnXRFTZ2M+VJmeEZxLhrBI7uNFLHRiq12vl9us3p+
         PlvVVq94uRkdhcW4Lm5J+biEhcMAki5sZfUt8TeAZ34dxidNA5HX3aqOEWc7+NoBWrUN
         Knng==
X-Gm-Message-State: AO0yUKUYV6QXTR/31SbAKwsYvPft32TqwLNz7kHEfXSil2eevFfqb6hV
        m1jhj365fiBj12eiRVh+/ORmsZ41cz25TQ==
X-Google-Smtp-Source: AK7set8IuaQdKCZ3RyJ5+slpUOEW2XaZILuiFdobU5CVABJilKlqBNvkvuCQbHXql5IOA+7cbrUYjg==
X-Received: by 2002:a05:600c:a41:b0:3eb:9822:f0 with SMTP id c1-20020a05600c0a4100b003eb982200f0mr2932598wmq.30.1678460948821;
        Fri, 10 Mar 2023 07:09:08 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id bg16-20020a05600c3c9000b003e9ded91c27sm289007wmb.4.2023.03.10.07.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 07:09:08 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 10 Mar 2023 16:09:06 +0100
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, acme@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        bpf@vger.kernel.org
Subject: Re: [RFC dwarves] syscall functions in BTF
Message-ID: <ZAtIEmbRSjol/XfK@krava>
References: <ZAsBYpsBV0wvkhh0@krava>
 <faf34d4b-d7a3-2573-383b-2bd8db422734@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faf34d4b-d7a3-2573-383b-2bd8db422734@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 10, 2023 at 12:43:31PM +0000, Alan Maguire wrote:
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
> 
> Thanks for the report Jiri! I'm working on reusing the dwarves_fprintf.c
> code to use string comparisons of function prototypes (minus parameter names!)
> instead as a more robust comparison.  Hope to have something working soon..

great, I saw the patchset, will check

>  
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

I was trying to attach to all syscalls and noticed some where missing,
it looks like the alias was used in this place for few years

thanks,
jirka
