Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75541E0E7
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 20:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353392AbhI3STr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 14:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353388AbhI3STq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 14:19:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D098C06176A;
        Thu, 30 Sep 2021 11:18:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so7402079pjc.3;
        Thu, 30 Sep 2021 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0dcJF6a5J2i4qY/SGIztVAuNG3UpRFiPiTeCiiLeXw=;
        b=K7KcDmoEGcmRy/ev728uCqbOciKfkFzSCtcpwRhwBSXjOOXO6C9yxp68gTf7fZXdrX
         pFU7uQFci1ftfymZhaG54CXV4f+9JZanZSpYyuB5XHz7/ZcEG+DYYOy8dME9qhxnYXgq
         dJuzqZPmGalsmFmTpl29rLA4F7ukQ3KsdwqgbIGtZ6XLMh7k+3Ik9RkkvBSAGTLd98hQ
         +wQbrHXcEYd23UwO4fq5x5f7DEfk8Ze5pRD3ZnICnbWxFkCKMKTqjr5PiAYDENnC/1Sg
         ycjM7x+uz70iK9+3rQ5JlrT3enSXmJOB7o1ZAYbsRkEwaFelo9f5BiKHaCNCwo2len4h
         pksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0dcJF6a5J2i4qY/SGIztVAuNG3UpRFiPiTeCiiLeXw=;
        b=uU5BDPyBnZDebRhYFmkzc/neMBrhMIA3vhaxEv7Z1h1f+INo9HTtzuZ731h9ZEx3sI
         aXmU+y36d4tRmAIgnoGsb9sQy63czqalu+PkdXSLBUpHbx/qSgCFNoqramdtiecCOjXC
         4bDpLC/aUV/QWm4IQzLEIVlYSR4X7Pb9FgJEUP6z3iSDTegEi2rtKzbqNE1/ruZG/+PJ
         4kf3aVYGC/b9BCcNCxDCGrs5msg85pVenqdzovYu90wNe/Mo2rxKFRvze2OzX2AN1FsT
         rxcR8QUtpojpIWtWOaBgLusFgGDqPjvhFUidw7hdQSaM+edJjxFKnTDrBYA++iLfE8kf
         Y3mQ==
X-Gm-Message-State: AOAM533YQNmWex+Txsq7vBslJvBOTDz3hWP0UhyGE9bl4ezPjxTiBg+J
        TtQuhUbUJ7iVO1xBApMOtHEPuFam9eT77gDYjpykpvKz
X-Google-Smtp-Source: ABdhPJxC+hXxl9QBdPlY95tL8Mi61q4aBvm5ltbF6eOcGtgP+eJO2ujnk2r9nPH4D5QCN7Ls2L94LSSni/JO8cOdiJs=
X-Received: by 2002:a17:90a:19d2:: with SMTP id 18mr14611570pjj.122.1633025883579;
 Thu, 30 Sep 2021 11:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <163163030719.489837.2236069935502195491.stgit@devnote2> <20210929112408.35b0ffe06b372533455d890d@kernel.org>
In-Reply-To: <20210929112408.35b0ffe06b372533455d890d@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 30 Sep 2021 11:17:52 -0700
Message-ID: <CAADnVQ+0v601toAz7wWPy2gxNtiJNZy6UpLmw_Dg+0G8ByJS6A@mail.gmail.com>
Subject: Re: [PATCH -tip v11 00/27] kprobes: Fix stacktrace with kretprobes on x86
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <kernel-team@fb.com>, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Paul McKenney <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 7:24 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Ingo,
>
> Can you merge this series to -tip tree since if I understand correctly,
> all kprobes patches still should be merged via -tip tree.
> If you don't think so anymore, I would like to handle the kprobe related
> patches on my tree. Since many kprobes fixes/cleanups have not been
> merged these months, it seems unhealthy now.
>
> Thank you,

Linus,

please suggest how to move these patches forward.
We've been waiting for this fix for months now.

> On Tue, 14 Sep 2021 23:38:27 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > Hello,
> >
> > This is the 11th version of the series to fix the stacktrace with kretprobe on x86.
> >
> > The previous version is here;
> >
> >  https://lore.kernel.org/all/162756755600.301564.4957591913842010341.stgit@devnote2/
> >
> > This version is rebased on the latest tip/master branch and includes the kprobe cleanup
> > series[1][2]. No code change.
> >
> > [1] https://lore.kernel.org/bpf/162748615977.59465.13262421617578791515.stgit@devnote2/
> > [2] https://lore.kernel.org/linux-csky/20210727133426.2919710-1-punitagrawal@gmail.com/
> >
> >
> > With this series, unwinder can unwind stack correctly from ftrace as below;
