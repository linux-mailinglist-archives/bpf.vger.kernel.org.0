Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92DC308C08
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 18:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhA2R7e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 12:59:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53532 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhA2R7c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 12:59:32 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1l5Y2k-0001zR-JJ
        for bpf@vger.kernel.org; Fri, 29 Jan 2021 17:58:50 +0000
Received: by mail-il1-f198.google.com with SMTP id s74so8049038ilb.20
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 09:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W7+v3EIXQwPpU91C+7QLiBi/RQzHX1PG0vPOAEJlptw=;
        b=fLt6MSc9RudGT0cCcDnAYzbBxOzVRj4s9itxMM34xlm9P9o4vE66+Zf4uDcMsI+iBG
         FmJVeO1GHYCNOyv1gD1ktvnuGKfJNIqdgtObg+VUP/2Xwq9hXl9rIIg+84sLPqm3UgxO
         re+sSgQfVH6/EWsjgidr691atZx8UJiraYsI/2de1ECQ7DnX0mvHlvKiNwdP7Yz7i6iw
         9P6uOJlMzOkucYxtdjrencJOaQ6QNEMi3Rk++QNjrciaFHtncTuOMoaC4biBQ6f0I+pK
         4CquuiT5KHsjsh6QyRkPXBYHLxZ3UeUFgjlqIOOgO+otZNe3fsJ9LHf64qwgE6h7/3JO
         TTsw==
X-Gm-Message-State: AOAM530fd8i41p4ZTuf4d3COovwsSt+ShdpmGIxJL4Q/mEzAZmfRsCue
        NQbh3cJrkL2YTqZGHm8F48l0cL2I6yiRBkzDf+P1/Ht+zQIyGVNFWrLVB6jOw5Cz3P6mvkMhNKN
        t7GF/foOjms4oF19MRXQCVfihmHdTkQ==
X-Received: by 2002:a92:49cf:: with SMTP id k76mr4145337ilg.52.1611943129685;
        Fri, 29 Jan 2021 09:58:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/Td61xl1vDf0n17YvYEAb79RziMkHiG3Nhi2YWFr8FADiwttrxNxSPk+FZxZNP89jEZBHig==
X-Received: by 2002:a92:49cf:: with SMTP id k76mr4145321ilg.52.1611943129486;
        Fri, 29 Jan 2021 09:58:49 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:8c40:72aa:4521:f281])
        by smtp.gmail.com with ESMTPSA id d13sm4386964ioy.26.2021.01.29.09.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:58:48 -0800 (PST)
Date:   Fri, 29 Jan 2021 11:58:47 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Nikolay Borisov <nborisov@suse.com>, x86@kernel.org,
        Masami Hiramatsu <masami.hiramatsu@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] x86: Disable CET instrumentation in the kernel
Message-ID: <YBRM181kNGBVKU4V@ubuntu-x1>
References: <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
 <20210128165014.xc77qtun6fl2qfun@treble>
 <20210128215219.6kct3h2eiustncws@treble>
 <20210129102105.GA27841@zn.tnic>
 <20210129151034.iba4eaa2fuxsipqa@treble>
 <20210129163048.GD27841@zn.tnic>
 <20210129164932.qt7hhmb7x4ehomfr@treble>
 <fd874f37-5842-93ab-6b6b-872f028f2583@suse.com>
 <20210129170331.akmpnaqlwtfy4y6o@treble>
 <20210129170755.GF27841@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210129170755.GF27841@zn.tnic>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 06:07:55PM +0100, Borislav Petkov wrote:
> On Fri, Jan 29, 2021 at 11:03:31AM -0600, Josh Poimboeuf wrote:
> > On Fri, Jan 29, 2021 at 06:54:08PM +0200, Nikolay Borisov wrote:
> > > 
> > > 
> > > On 29.01.21 г. 18:49 ч., Josh Poimboeuf wrote:
> > > > Agreed, stable is a good idea.   I think Nikolay saw it with GCC 9.
> > > 
> > > 
> > > Yes I did, with the default Ubuntu compiler as well as the default gcc-10 compiler: 
> > > 
> > > # gcc -v -Q -O2 --help=target | grep protection
> > > 
> > > gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04) 
> > > COLLECT_GCC_OPTIONS='-v' '-Q' '-O2' '--help=target' '-mtune=generic' '-march=x86-64'
> > >  /usr/lib/gcc/x86_64-linux-gnu/9/cc1 -v -imultiarch x86_64-linux-gnu help-dummy -dumpbase help-dummy -mtune=generic -march=x86-64 -auxbase help-dummy -O2 -version --help=target -fasynchronous-unwind-tables -fstack-protector-strong -Wformat -Wformat-security -fstack-clash-protection -fcf-protection -o /tmp/ccSecttk.s
> > > GNU C17 (Ubuntu 9.3.0-17ubuntu1~20.04) version 9.3.0 (x86_64-linux-gnu)
> > > 	compiled by GNU C version 9.3.0, GMP version 6.2.0, MPFR version 4.0.2, MPC version 1.1.0, isl version isl-0.22.1-GMP
> > > 
> > > 
> > > It has -fcf-protection turned on by default it seems. 
> > 
> > Yup, explains why I didn't see it:
> > 
> > gcc version 10.2.1 20201125 (Red Hat 10.2.1-9) (GCC)
> > COLLECT_GCC_OPTIONS='-v' '-Q' '-O2' '--help=target' '-mtune=generic' '-march=x86-64'
> >  /usr/libexec/gcc/x86_64-redhat-linux/10/cc1 -v help-dummy -dumpbase help-dummy -mtune=generic -march=x86-64 -auxbase help-dummy -O2 -version --help=target -o /tmp/cclBz55H.s
> 
> The fact that you triggered it with an Ubuntu gcc explains why the
> original patch adding that switch:
> 
> 29be86d7f9cb ("kbuild: add -fcf-protection=none when using retpoline flags")
> 
> came from a Canonical.
> 
> Adding the author to Cc for FYI.
> 
> Seth, you can find this thread starting here:
> 
> https://lkml.kernel.org/r/20210128215219.6kct3h2eiustncws@treble

Thanks for the heads up. This still works fine for our needs.

Acked-by: Seth Forshee <seth.forshee@canonical.com>
