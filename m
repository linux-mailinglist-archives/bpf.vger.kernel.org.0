Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F143433EC
	for <lists+bpf@lfdr.de>; Sun, 21 Mar 2021 18:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhCURuq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Mar 2021 13:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230192AbhCURuf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Mar 2021 13:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616349029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZCALG3L0JmM8Q3lS7t1wLuuwG3XoyIZM7HAGt0XbjxI=;
        b=Q+SKfFv5HYdMzDUBiBdSAI8SQMqhrU8T4YEG27yQaZv54NQ4GzDjCj3rSVLSWpHpiaeCYH
        ZWoDVkj//1+4NDcVH7v1kvN9DOEVT0gl/SBJzmI7zdSkV5HgWbBqLqIbZCDAdRrVnd+QzR
        rdznyOKoSJ6QZZACdBJtd0jacNJOdAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-JCBb1hFzNDK6qtqsHuvQMw-1; Sun, 21 Mar 2021 13:50:25 -0400
X-MC-Unique: JCBb1hFzNDK6qtqsHuvQMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D2BD1007467;
        Sun, 21 Mar 2021 17:50:23 +0000 (UTC)
Received: from treble (ovpn-112-151.rdu2.redhat.com [10.10.112.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B88C119C79;
        Sun, 21 Mar 2021 17:50:07 +0000 (UTC)
Date:   Sun, 21 Mar 2021 12:50:04 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH -tip v3 05/11] x86/kprobes: Add UNWIND_HINT_FUNC on
 kretprobe_trampoline code
Message-ID: <20210321174855.oqqtvgb2xwyk4klf@treble>
References: <161615650355.306069.17260992641363840330.stgit@devnote2>
 <161615655969.306069.4545805781593088526.stgit@devnote2>
 <20210320211616.a976fc66d0c51e13d3121e2f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210320211616.a976fc66d0c51e13d3121e2f@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 20, 2021 at 09:16:16PM +0900, Masami Hiramatsu wrote:
> On Fri, 19 Mar 2021 21:22:39 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > 
> > Add UNWIND_HINT_FUNC on kretporbe_trampoline code so that ORC
> > information is generated on the kretprobe_trampoline correctly.
> > 
> 
> Test bot also found a new warning for this.
> 
> > >> arch/x86/kernel/kprobes/core.o: warning: objtool: kretprobe_trampoline()+0x25: call without frame pointer save/setup
> 
> With CONFIG_FRAME_POINTER=y.
> 
> Of course this can be fixed with additional "push %bp; mov %sp, %bp" before calling
> trampoline_handler. But actually we know that this function has a bit special
> stack frame too. 
> 
> Can I recover STACK_FRAME_NON_STANDARD(kretprobe_trampoline) when CONFIG_FRAME_POINTER=y ?

Yes, that's what I'd recommend.

-- 
Josh

