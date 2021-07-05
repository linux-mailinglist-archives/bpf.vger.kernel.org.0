Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669293BBC98
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 14:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhGEMGS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 08:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbhGEMGS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 08:06:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A68B860241;
        Mon,  5 Jul 2021 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625486621;
        bh=SjTdmsxCPlxVFlvZvH52SfXXPq9CdpmxbJ1E9QcX+fs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y3eFVJeLa8O2Yfy8Gp3KwhyukvAPXPZwNZcsY6YAijHoPLWls/zBsDSTWgukWEajS
         nJVGNHxMuVtvSWrI/MVO7/jbbC6XImJZ/LNG17ZXUIemHPQziCFzLMV2R8sCx6x+n3
         GK10H0854TeUAIULzi//RRV8lo7tdZ7x/xCoAyyZ8bfEghsXFgSmwnljbD3Kuwgs0P
         NBs6GWBo7ThEqJiEP6+YGNehbIhSS/WS1ZHC8LJKy8bpeMbgUOgAuZ+PNxMg3ecpiq
         NLXPr5jLlbc62a0bpHj/MuakB+GBnui128I0mZ7M7HmGIaBtTRKMXQ64e6R0oWCxPN
         YFB9TM6eZloGg==
Date:   Mon, 5 Jul 2021 21:03:36 +0900
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
Subject: Re: [PATCH -tip v8 02/13] kprobes: treewide: Replace
 arch_deref_entry_point() with dereference_symbol_descriptor()
Message-Id: <20210705210336.8428fbf0e65deb1e437374f4@kernel.org>
In-Reply-To: <YOK5OV0zdjvrsqju@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
        <162399994018.506599.10332627573727646767.stgit@devnote2>
        <YOK5OV0zdjvrsqju@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 5 Jul 2021 09:48:09 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Replace arch_deref_entry_point() with dereference_symbol_descriptor()
> > because those are doing same thing.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Tested-by: Andrii Nakryik <andrii@kernel.org>
> 
> A better changelog:
> 
>   ~15 years ago kprobes grew the 'arch_deref_entry_point()' __weak function:
> 
>     3d7e33825d87: ("jprobes: make jprobes a little safer for users")
> 
>   But this is just open-coded dereference_symbol_descriptor() in essence, and
>   its obscure nature was causing bugs.
> 
>   Just use the real thing.

OK. BTW, I couldn't find actual bugs from it. What about this?

"its obscure nature was causing problems in the past."

Thank you,

> 
> Thanks,
> 
> 	Ingo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
