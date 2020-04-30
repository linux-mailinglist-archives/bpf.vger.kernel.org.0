Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6C41BEE14
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 04:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgD3CK5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Apr 2020 22:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726282AbgD3CK5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Apr 2020 22:10:57 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8740C035494;
        Wed, 29 Apr 2020 19:10:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so1668342plr.0;
        Wed, 29 Apr 2020 19:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GkpqqWBkAF18ABKRbJQ+dSLIBUQRR8C6F1O4ytn6QLA=;
        b=nALKZQd5JdEZzhMZY1azIBYXEqMWEN+Z8n8gcIKHQu+t5irzmsh9jc+mLjismNnCco
         wbrFjN0Yo/7Bo59kXNkrXYHt6s/jdCnVtQiffa+rPADelcBxKP7GHG6OuQXvzACcezpV
         /RocMOj8GZDxF4clBk25kZgTJAyG7I0dIIySooFKQbis+hImdxbUT5bdKrffdo5u+jN5
         xuij5E+Z+iBrIeVsELM8EbILev+Y0AyBvcZnjviSozuJ93yfZpU53uLnbdzffUjkhvxZ
         olq6vTdh87UwB0ZIYC8lILuDVc5CPxb/GKcfFndY5FmQ/OTKikSgnJEBCt6xaRKzYU79
         Zy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GkpqqWBkAF18ABKRbJQ+dSLIBUQRR8C6F1O4ytn6QLA=;
        b=S1U1nF/qP2Fg9QrXFHG6ylH7uPG6txYV/RKphCAb8yrwN0HhHJ+ZfziAjs2aOD3+4+
         OiE7/GlM5Pnxvf11jdK93NJWI/6pr1oc8E7rsTn68rvrz/63eLulDpPItQ/BMD9L2Wzu
         5TkjNN5mvKmR9opZ/wE90cunYYSdSYkXeEgojLaeP9RfqJLo5U5dfsaja9oSmk9aFjb3
         uCJDEgiObO01hz4+nEG9qp1qBY2wmFJWjOfQk+7/Di4cndbIUKq8XaIF2eydW7pZ68Py
         QWmP+GIbs8Lw6TMDzkFhxJGkyy3u6+p0to9CLVhw1W9tfXkhHMK/XSBD7CbyZNFiIyIp
         WdGQ==
X-Gm-Message-State: AGi0PubiwPocUQZwlwlIRP0XF60Lx8zo4yNr1a5FgKvWLacq8izZmvW2
        msl3FU5JAE04lsXuGtdsQgRESJP4
X-Google-Smtp-Source: APiQypINusOnq9GsK6RxyiPgDguA0uFN2Q/0uuGGrULiXDbrq8XuLL3KmA+/TY7rk+BWWj3OKSlBag==
X-Received: by 2002:a17:90a:d14d:: with SMTP id t13mr285087pjw.175.1588212656117;
        Wed, 29 Apr 2020 19:10:56 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:39f2])
        by smtp.gmail.com with ESMTPSA id m6sm1984371pgm.67.2020.04.29.19.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 19:10:55 -0700 (PDT)
Date:   Wed, 29 Apr 2020 19:10:52 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, ast@kernel.org,
        peterz@infradead.org, rdunlap@infradead.org,
        Arnd Bergmann <arnd@arndb.de>, bpf@vger.kernel.org,
        daniel@iogearbox.net
Subject: Re: BPF vs objtool again
Message-ID: <20200430021052.k47qzm63kpcn32pg@ast-mbp.dhcp.thefacebook.com>
References: <30c3ca29ba037afcbd860a8672eef0021addf9fe.1563413318.git.jpoimboe@redhat.com>
 <tip-3193c0836f203a91bef96d88c64cccf0be090d9c@git.kernel.org>
 <20200429215159.eah6ksnxq6g5adpx@treble>
 <20200429234159.gid6ht74qqmlpuz7@ast-mbp.dhcp.thefacebook.com>
 <20200430001300.k3pgq2minrowstbs@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430001300.k3pgq2minrowstbs@treble>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 29, 2020 at 07:13:00PM -0500, Josh Poimboeuf wrote:
> On Wed, Apr 29, 2020 at 04:41:59PM -0700, Alexei Starovoitov wrote:
> > On Wed, Apr 29, 2020 at 04:51:59PM -0500, Josh Poimboeuf wrote:
> > > On Thu, Jul 18, 2019 at 12:14:08PM -0700, tip-bot for Josh Poimboeuf wrote:
> > > > Commit-ID:  3193c0836f203a91bef96d88c64cccf0be090d9c
> > > > Gitweb:     https://git.kernel.org/tip/3193c0836f203a91bef96d88c64cccf0be090d9c
> > > > Author:     Josh Poimboeuf <jpoimboe@redhat.com>
> > > > AuthorDate: Wed, 17 Jul 2019 20:36:45 -0500
> > > > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > > > CommitDate: Thu, 18 Jul 2019 21:01:06 +0200
> > > > 
> > > > bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()
> > > 
> > > For some reason, this
> > > 
> > >   __attribute__((optimize("-fno-gcse")))
> > > 
> > > is disabling frame pointers in ___bpf_prog_run().  If you compile with
> > > CONFIG_FRAME_POINTER it'll show something like:
> > > 
> > >   kernel/bpf/core.o: warning: objtool: ___bpf_prog_run.cold()+0x7: call without frame pointer save/setup
> > 
> > you mean it started to disable frame pointers from some version of gcc?
> > It wasn't doing this before, since objtool wasn't complaining, right?
> > Sounds like gcc bug?
> 
> I actually think this warning has been around for a while.  I just only
> recently looked at it.  I don't think anything changed in GCC, it's just
> that almost nobody uses CONFIG_FRAME_POINTER, so it wasn't really
> noticed.
> 
> > > Also, since GCC 9.1, the GCC docs say "The optimize attribute should be
> > > used for debugging purposes only. It is not suitable in production
> > > code."  That doesn't sound too promising.
> > > 
> > > So it seems like this commit should be reverted. But then we're back to
> > > objtool being broken again in the RETPOLINE=n case, which means no ORC
> > > coverage in this function.  (See above commit for the details)
> > > 
> > > Some ideas:
> > > 
> > > - Skip objtool checking of that func/file (at least for RETPOLINE=n) --
> > >   but then it won't have ORC coverage.
> > > 
> > > - Get rid of the "double goto" in ___bpf_prog_run(), which simplifies it
> > >   enough for objtool to understand -- but then the text explodes for
> > >   RETPOLINE=y.
> > 
> > How that will look like?
> > That could be the best option.
> 
> For example:
> 
> #define GOTO    ({ goto *jumptable[insn->code]; })
> 
> and then replace all 'goto select_insn' with 'GOTO;'
> 
> The problem is that with RETPOLINE=y, the function text size grows from
> 5k to 7k, because for each of the 160+ retpoline JMPs, GCC (stupidly)
> reloads the jump table register into a scratch register.

that would be a tiny change, right?
I'd rather go with that and gate it with 'ifdef CONFIG_FRAME_POINTER'
Like:
#ifndef CONFIG_FRAME_POINTER
#define CONT     ({ insn++; goto select_insn; })
#define CONT_JMP ({ insn++; goto select_insn; })
#else
#define CONT     ({ insn++; goto *jumptable[insn->code]; })
#define CONT_JMP ({ insn++; goto *jumptable[insn->code]; })
#endif

The reason this CONT and CONT_JMP macros are there because a combination
of different gcc versions together with different cpus make branch predictor
behave 'unpredictably'.

I've played with CONT and CONT_JMP either both doing direct goto or
indirect goto and observed quite different performance characteristics
from the interpreter.
What you see right now was the best tune I could get from a set of cpus
I had to play with and compilers. If I did the same tuning today the outcome
could have been different.
So I think it's totally fine to use above code. I think some cpus may actually
see performance gains with certain versions of gcc.
The retpoline text increase is unfortunate but when retpoline is on
other security knobs should be on too. In particular CONFIG_BPF_JIT_ALWAYS_ON
should be on as well. Which will remove interpreter from .text completely.
