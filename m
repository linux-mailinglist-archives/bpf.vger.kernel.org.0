Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C938F664
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 01:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhEXXnr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 19:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhEXXm5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 19:42:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C64686140F;
        Mon, 24 May 2021 23:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621899687;
        bh=WpOkHh4kv1W74/DyvTIZCMl22CrsOB78gu+cKOhCpy0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XgTQfvYe7m5+60/PtvQHLaA/nbLL+nfM+Lz8hGJBFZ+LonNO9HbzYjtxkazadcYoy
         pHFQdH4uD+3CTKqLO4qYT8QUf7jwQ94APzqOmKEk0texuLqkcRR/PcSgnD/T5UAYkJ
         6v6dzo8gTHjxqW6ql3eGNMSJfTRZKb2hS+gLLmRMGQKBLV7+DN8YMHSFIBYnQKSnkb
         9aA8/VzEc8gcQAbZNmMQa0cb4OH7XuhnaFQ8HxkGd7FxE1M7hpfREJ0qZogTuvgdgs
         7OzzRTwP8K7qULp7xdxVHeVeyQ6OVzPLwFxYvwh3cX0iP4P4ZHITaT+/L2savTVzyR
         1YdNYNlcNsubg==
Date:   Tue, 25 May 2021 08:41:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, ast@kernel.org,
        bpf@vger.kernel.org, Daniel Xu <dxu@dxuuu.xyz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, kernel-team@fb.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        tglx@linutronix.de, X86 ML <x86@kernel.org>, yhs@fb.com
Subject: Re: [PATCH -tip v2 02/10] kprobes: treewide: Replace
 arch_deref_entry_point() with dereference_function_descriptor()
Message-Id: <20210525084122.983fce68c1b1d8f5e0e2ec9d@kernel.org>
In-Reply-To: <1621848345.yvip3z0wyn.naveen@linux.ibm.com>
References: <161553130371.1038734.7661319550287837734.stgit@devnote2>
        <161553132545.1038734.15042495470069054830.stgit@devnote2>
        <1621848345.yvip3z0wyn.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Naveen,

On Mon, 24 May 2021 14:56:50 +0530
"Naveen N. Rao" <naveen.n.rao@linux.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > Replace arch_deref_entry_point() with dereference_function_descriptor()
> > because those are doing same thing.
> 
> It's not quite the same -- you need dereference_symbol_descriptor().

Got it! dereference_function_descriptor() doesn't handle the symbols
in the modules.

Thank you!

> 
> 
> - Naveen
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
