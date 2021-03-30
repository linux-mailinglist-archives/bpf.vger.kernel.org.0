Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035F634E075
	for <lists+bpf@lfdr.de>; Tue, 30 Mar 2021 06:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhC3E6v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 00:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229501AbhC3E63 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Mar 2021 00:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617080308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8HXE+SRs1I1Gy1V62mRGhXG03GWa3sG5/VRWwRaeXI=;
        b=WxWftcqI3z2icKWpFZ4haweGfSaQy57jPQfnzzq+j6ix0YfYjLC9NHb+8SB06Ku0La3RzR
        ny7oAjlysPrtEu9/H/RwJr/Ic7SgW/ivYeMJvnruuRF3RC9dIywOS0uhAJDw0kYBQGVxLF
        ZsCAneggsyjzEPNJHzAaUF3zgL+/TBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-scz5m0e-P8GsRK6xx4D05Q-1; Tue, 30 Mar 2021 00:58:23 -0400
X-MC-Unique: scz5m0e-P8GsRK6xx4D05Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB33481622;
        Tue, 30 Mar 2021 04:58:21 +0000 (UTC)
Received: from treble (ovpn-112-70.rdu2.redhat.com [10.10.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9EE839A66;
        Tue, 30 Mar 2021 04:58:18 +0000 (UTC)
Date:   Mon, 29 Mar 2021 23:58:15 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH -tip v4 10/12] x86/kprobes: Push a fake return address at
 kretprobe_trampoline
Message-ID: <20210330045815.boogfo65is5yywnn@treble>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
 <161639530062.895304.16962383429668412873.stgit@devnote2>
 <20210323223007.GG4746@worktop.programming.kicks-ass.net>
 <20210324104058.7c06aaeb0408e24db6ba46f8@kernel.org>
 <20210326030503.7fa72da34e25ad35cf5ed3de@kernel.org>
 <20210326210349.22f6d34b229dd3a139a53686@kernel.org>
 <20210326102009.265f359c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210326102009.265f359c@gandalf.local.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 26, 2021 at 10:20:09AM -0400, Steven Rostedt wrote:
> On Fri, 26 Mar 2021 21:03:49 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > I confirmed this is not related to this series, but occurs when I build kernels with different
> > configs without cleanup.
> > 
> > Once I build kernel with CONFIG_UNWIND_GUESS=y (for testing), and after that,
> > I build kernel again with CONFIG_UNWIND_ORC=y (but without make clean), this
> > happened. In this case, I guess ORC data might be corrupted?
> > When I cleanup and rebuild, the stacktrace seems correct.
> 
> Hmm, that should be fixed. Seems like we are missing a dependency somewhere.

Thomas reported something similar: for example arch/x86/kernel/head_64.o
doesn't get rebuilt when changing unwinders.

  https://lkml.kernel.org/r/87tuqublrb.fsf@nanos.tec.linutronix.de

Masahiro, any idea how we can force a full tree rebuild when changing
the unwinder?

-- 
Josh

