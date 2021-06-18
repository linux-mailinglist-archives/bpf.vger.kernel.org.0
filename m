Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9723AC058
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 02:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhFRBAi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 21:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233025AbhFRBAh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 21:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623977908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x6XESlRwZkZX50qjXN9D68RoGStRZgZfV45IdoPLpzQ=;
        b=jIWH7HNmTlLPvSk9ybd2BODMljyNeV4HeMC6tnPn+8kwKNVb75c8xJEKdap5yl5BAAsrKP
        +1TDleTGGuLCMbO5/RPt5EQluQ0Wwe2HhwpWhRxG1owxwDSC8VE+wtXr212ok+xZSaCsyK
        13Rgrtt62xttWpYXk9Z3XVfXcST5kIs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-9FsxCogePxCzbEwrjsB1fg-1; Thu, 17 Jun 2021 20:58:27 -0400
X-MC-Unique: 9FsxCogePxCzbEwrjsB1fg-1
Received: by mail-qv1-f70.google.com with SMTP id bt11-20020ad455cb0000b0290258c7c1acd0so3978209qvb.5
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 17:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x6XESlRwZkZX50qjXN9D68RoGStRZgZfV45IdoPLpzQ=;
        b=KwXYBSfP0ZB4lrD7DAcf9xZ6N1HhTkMku2c/2TGC/SR0ZZj+frWKhmA13icPpJRYvg
         jIP7dX4BFldAAzrznglxr6OpeqjrR1wiSXajSCmuFsFrvyGgyQ3xfjEBZXpnVfMeqi6Z
         jpQ0Xt6KOfdajjkZVM2ko2HngX8gBJ7Hqn+7mvkyH7j28Sh6U1dEtTw9yiof2AFfJefP
         wNbGEOjrAy3lv5cwphGUs5CjmdLEU9/vR1D+5+oijthWXv+TvbrFL6+6LZkwqptb7w40
         ekYLP+BNy1c+fitx+wuptaOI2RkLZ56NWGiUEq+tCysSRtvMsL3UV9SeLcPMG7njiOAW
         D4Lg==
X-Gm-Message-State: AOAM530Ai4Wp+KuwOLK0/K+q9YPpoSmOS/+1qu998NjIJxheW2ce402q
        l5rSLlwcL+XNe+VJQMIR87cnH8D2UvWtwW/LoQ9xfZhtqcEhLBZtvjhZxBxs8elrziWasdwEPEy
        Nmy4suo2IvVs3
X-Received: by 2002:a37:9f51:: with SMTP id i78mr6732310qke.345.1623977907102;
        Thu, 17 Jun 2021 17:58:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzmodRqgHOgeN8BuYz6HtT1Dhg5Vx/ostQA3yQe9C/ntEm3yKkOnLu8we/tW5KmRA4OkPt6Q==
X-Received: by 2002:a37:9f51:: with SMTP id i78mr6732289qke.345.1623977906812;
        Thu, 17 Jun 2021 17:58:26 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id l23sm3860569qtp.28.2021.06.17.17.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:58:26 -0700 (PDT)
Date:   Thu, 17 Jun 2021 19:58:24 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v7 09/13] kprobes: Setup instruction pointer in
 __kretprobe_trampoline_handler
Message-ID: <20210618005824.557syjz7wyrrya2m@treble>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
 <162209762943.436794.874947392889792501.stgit@devnote2>
 <20210617043909.fgu2lhnkxflmy5mk@treble>
 <20210617044032.txng4enhiduacvt6@treble>
 <20210617234001.54cd2ff60410ff82a39a2020@kernel.org>
 <20210618000239.f95de17418beae6d84ce783d@kernel.org>
 <CAEf4Bzbob_M0aS-GUY5XaqePZr_prxUag3RLHtp=HY8Uu__10g@mail.gmail.com>
 <20210617182159.ka227nkmhe4yu2de@treble>
 <20210618085811.19f0a7b8c1e91d54483ba9f8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210618085811.19f0a7b8c1e91d54483ba9f8@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 18, 2021 at 08:58:11AM +0900, Masami Hiramatsu wrote:
> On Thu, 17 Jun 2021 13:21:59 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On Thu, Jun 17, 2021 at 10:45:41AM -0700, Andrii Nakryiko wrote:
> > > > > > > I know I suggested this patch, but I believe it would only be useful in
> > > > > > > combination with the use of UNWIND_HINT_REGS in SAVE_REGS_STRING.  But I
> > > > > > > think that would be tricky to pull off correctly.  Instead, we have
> > > > > > > UNWIND_HINT_FUNC, which is working fine.
> > > > > > >
> > > > > > > So I'd suggest dropping this patch, as the unwinder isn't actually
> > > > > > > reading regs->ip after all.
> > > > > >
> > > > > > ... and I guess this means patches 6-8 are no longer necessary.
> > > > >
> > > > > OK, I also confirmed that dropping those patche does not make any change
> > > > > on the stacktrace.
> > > > > Let me update the series without those.
> > > >
> > > > Oops, Andrii, can you also test the kernel without this patch?
> > > > (you don't need to drop patch 6-8)
> > > 
> > > Hi Masami,
> > > 
> > > Dropping this patch and leaving all the other in place breaks stack
> > > traces from kretprobes for BPF. I double checked with and without this
> > > patch. Without this patch we are back to having broken stack traces. I
> > > see either
> > > 
> > >   kretprobe_trampoline+0x0
> > > 
> > > or
> > > 
> > >   ftrace_trampoline+0xc8
> > >   kretprobe_trampoline+0x0
> 
> Thanks for confirmation.
> 
> > > 
> > > Is there any problem if you leave this patch as is?
> > 
> > Hm, I must be missing something then.  The patch is probably fine to
> > keep, we just may need to improve the commit log so that it makes sense
> > to me.
> 
> Yeah, I need to update the commit message so that this will help
> the stacktrace from kretprobe's pt_regs, which will be used in bpf. 

Yes, I presume it's because when bpf unwinds from the kretprobe regs,
the unwinder starts from regs->ip, which is otherwise undefined because
it's skipped by SAVE_REGS_STRING.

-- 
Josh

