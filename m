Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD88E9F2A
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2019 16:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfJ3PfZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Oct 2019 11:35:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39778 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfJ3PfZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Oct 2019 11:35:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id y3so3184934ljj.6;
        Wed, 30 Oct 2019 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/cUvxppfvco+q/svBW0l1eTrvr4r1OMCG7AkgiKpcQ=;
        b=tR6noo5CwOi34VQIokfGyMdP+tJf/ZPULHPz8KIcLua8ZoHBLlO50xCqeMHaAGvVQa
         48WC0IzF8IxRv33JMgEH6NVNXDntgXn7Qbh44b6Itm/zy8iGjwULy02N0bndCfuE2mWn
         J5Gwpff3AsiQbdxaPgA4+tL1vptqqQI4FjSr8FVKo2VUEXTe05i7hepKReBSN4ewi9tv
         zbaqlMUmmjqzytwjIcNNu6xS9h9lWk0Eaj0NjvRt2/CJPLu+0YZNb2skTCtzBUyPYFNU
         4LvGej/Mi9HNnkRrWKHopWrOtOHpFc32BVA/CVOOxGZuSTldPR3GNZh63N8HGJiB7fSn
         K3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/cUvxppfvco+q/svBW0l1eTrvr4r1OMCG7AkgiKpcQ=;
        b=a7G85NUd3PiSRYyz+PPHcvUPX8XFnp5xRv/fKEIFPBEaTClzadmxu2vw6e7wJlSfaK
         /8BhwdjhG8RA7hDngdBoUi4STefYxbch3zK4rJmsJLs4xeZ6oEv5WuQOtPXHy1xBXtEI
         abwQQXErdvqypLwf1Qm3puufAlGwyh+a96OxvcpKr7U2r0iaRZsMFfFvT03kSgua1Xvh
         VevTTT6xctaJi2Ji954Qu4UtotJisPEnCB1Z1wwJAjUP5vY3ybhGxC0ms4JoqrA6doG+
         6phCen7SOXVc3TYJoav2qwLi5ZgQHee6421/MgTQs5dfVf3P+wuxaSZZOqNGEr/VV8dr
         cvvQ==
X-Gm-Message-State: APjAAAUjf/oa0D64VtIqsqwlegW8iB8kED66rUkEAMUtLHn9uG3g28ro
        Pwo4rzKn2cNKW8d2T1AkQkTkogdQ0Cx+0w/J90Q=
X-Google-Smtp-Source: APXvYqxBvl31pTcQQnHQbXcbxQLKZEYYjr+em5rKZ5EtZ+2iT0oglxx0fEQ8/RXMOehSCT8SBwLe+R0VTmgUsFSdHMc=
X-Received: by 2002:a2e:2412:: with SMTP id k18mr217604ljk.243.1572449721198;
 Wed, 30 Oct 2019 08:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org> <20191028123124.ogkk5ogjlamvwc2s@box>
 <20191028130018.GA7192@rapoport-lnx> <20191028131623.zwuwguhm4v4s5imh@box>
 <20191028135521.GB4097@hirez.programming.kicks-ass.net> <0a35765f7412937c1775daa05177b20113760aee.camel@intel.com>
 <20191028210052.GM4643@worktop.programming.kicks-ass.net> <69c57f7fa9a1be145827673b37beff155a3adc3c.camel@intel.com>
 <20191030100418.GV4097@hirez.programming.kicks-ass.net>
In-Reply-To: <20191030100418.GV4097@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 30 Oct 2019 08:35:09 -0700
Message-ID: <CAADnVQ+3LeLWv-rpATyfAbdS1w9L=sCQFuyy=paCZVBUr0rK6Q@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user mappings
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "bp@alien8.de" <bp@alien8.de>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 30, 2019 at 3:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 29, 2019 at 05:27:43PM +0000, Edgecombe, Rick P wrote:
> > On Mon, 2019-10-28 at 22:00 +0100, Peter Zijlstra wrote:
>
> > > That should be limited to the module range. Random data maps could
> > > shatter the world.
> >
> > BPF has one vmalloc space allocation for the byte code and one for the module
> > space allocation for the JIT. Both get RO also set on the direct map alias of
> > the pages, and reset RW when freed.
>
> Argh, I didn't know they mapped the bytecode RO; why does it do that? It
> can throw out the bytecode once it's JIT'ed.

because of endless security "concerns" that some folks had.
Like what if something can exploit another bug in the kernel
and modify bytecode that was already verified
then interpreter will execute that modified bytecode.
Sort of similar reasoning why .text is read-only.
I think it's not a realistic attack, but I didn't bother to argue back then.
The mere presence of interpreter itself is a real security concern.
People that care about speculation attacks should
have CONFIG_BPF_JIT_ALWAYS_ON=y,
so modifying bytecode via another exploit will be pointless.
Getting rid of RO for bytecode will save a ton of memory too,
since we won't need to allocate full page for each small programs.
