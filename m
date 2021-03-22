Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14443448EB
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 16:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhCVPMK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 11:12:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231596AbhCVPLp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 11:11:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF9B561931;
        Mon, 22 Mar 2021 15:11:43 +0000 (UTC)
Date:   Mon, 22 Mar 2021 11:11:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v4 12/12] tracing: Show kretprobe unknown indicator
 only for kretprobe_trampoline
Message-ID: <20210322111142.748e90da@gandalf.local.home>
In-Reply-To: <161639532235.895304.18329540036405219298.stgit@devnote2>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
        <161639532235.895304.18329540036405219298.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 22 Mar 2021 15:42:02 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> ftrace shows "[unknown/kretprobe'd]" indicator all addresses in the
> kretprobe_trampoline, but the modified address by kretprobe should
> be only kretprobe_trampoline+0.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

