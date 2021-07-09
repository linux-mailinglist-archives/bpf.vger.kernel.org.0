Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADECC3C265E
	for <lists+bpf@lfdr.de>; Fri,  9 Jul 2021 16:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhGIO6T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Jul 2021 10:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231972AbhGIO6T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Jul 2021 10:58:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47D0661242;
        Fri,  9 Jul 2021 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625842536;
        bh=Q2WG2NG1T89ViRXSnVoTpzh42KcKP8D2yuxnM2NHFLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fBhhIzyyAoLntM8rT07BquH3igKKEvTX2kQj+DWRV+X4ADbvirwhloSDGtaFij3Ik
         n17gc+bDJLT826iPEC1EWuvqRvCH4uTMUj18U/KoZVMyraHebRg6vZE1E6ZsycgDxE
         RN9bo82HHDyppAnO5bYXlUmWHG0lKG6k8rCKSkJlVXyMHSLmjTsgqdLkIU5cHsOUfK
         O+fpPhhJ1l/y3pxcuOe/DreJxFv53TURXVuN91GnShGLXnBLhwtp5LfJ18rwDDSoSa
         SAP2UWPWvCRCqxEcolzKaWZGu4fCA2RLPRWf3M98wCU2DctHXgUbVGzyvTPo8CH30j
         QG9NG40CposHw==
Date:   Fri, 9 Jul 2021 23:55:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v8 10/13] x86/kprobes: Push a fake return address
 at kretprobe_trampoline
Message-Id: <20210709235531.527d5cbb59c5669eed885b32@kernel.org>
In-Reply-To: <YOLAFswnvyNReMmI@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
        <162400001661.506599.5153975410607447958.stgit@devnote2>
        <YOLAFswnvyNReMmI@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 5 Jul 2021 10:17:26 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > +	/* Replace fake return address with real one. */
> > +	*frame_pointer = kretprobe_trampoline_handler(regs, frame_pointer);
> > +	/*
> > +	 * Move flags to sp so that kretprobe_trapmoline can return
> > +	 * right after popf.
> 
> What is a trapmoline?

This means kretprobe_trampoline() code.

> 
> Also, in the x86 code we capitalize register and instruction names so that 
> they are more distinctive and easier to read in the flow of English text.

OK, let me update it.

Thank you,

> 
> Thanks,
> 
> 	Ingo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
