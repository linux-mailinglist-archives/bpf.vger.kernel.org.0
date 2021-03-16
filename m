Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61B433DE82
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 21:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhCPURA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 16:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230245AbhCPUQf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 16:16:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D587A64EBD;
        Tue, 16 Mar 2021 20:16:34 +0000 (UTC)
Date:   Tue, 16 Mar 2021 16:16:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        paulmck@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 bpf] ftrace: Fix modify_ftrace_direct.
Message-ID: <20210316161633.64abfbd5@gandalf.local.home>
In-Reply-To: <20210316195815.34714-1-alexei.starovoitov@gmail.com>
References: <20210316195815.34714-1-alexei.starovoitov@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 16 Mar 2021 12:58:15 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> From: Alexei Starovoitov <ast@kernel.org>
> 
> The following sequence of commands:
>   register_ftrace_direct(ip, addr1);
>   modify_ftrace_direct(ip, addr1, addr2);
>   unregister_ftrace_direct(ip, addr2);
> will cause the kernel to warn:
> [   30.179191] WARNING: CPU: 2 PID: 1961 at kernel/trace/ftrace.c:5223 unregister_ftrace_direct+0x130/0x150
> [   30.180556] CPU: 2 PID: 1961 Comm: test_progs    W  O      5.12.0-rc2-00378-g86bc10a0a711-dirty #3246
> [   30.182453] RIP: 0010:unregister_ftrace_direct+0x130/0x150
> 
> When modify_ftrace_direct() changes the addr from old to new it should update
> the addr stored in ftrace_direct_funcs. Otherwise the final
> unregister_ftrace_direct() won't find the address and will cause the splat.
> 
> Fixes: 0567d6809182 ("ftrace: Add modify_ftrace_direct()")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
