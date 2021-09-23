Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D6F415E8E
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbhIWMmU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 08:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240903AbhIWMmM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 08:42:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE87560FE6;
        Thu, 23 Sep 2021 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632400840;
        bh=UU4sXB4zbLyM1GRMWu1SbL6BcY8Hn0STOC/cYICSUQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ia8xUFwaws5ryhGcS+p8LWn+9qWUsQ3FdLW7+OdGJQ8OCpMzqM6cbPJh+xwS7WypX
         HYbyLN1A/EnbAA/g+kNM8mO4rK0snLCiMid2MHUnWpA44+m9D7/y2xqVRXB5EMP8mo
         65hg9IZr3+cmJfxFGGGykw/tJfnx5/rdxZEY9FxYLpyOO40lTonI77rLgxmwJzSBsV
         Vil8Yw8Zk22ncmBl9NKXGo3ybxIoXFmqWTEr6Gx1UF+bgeTNeoQtw7NdkiBhL5piuW
         EjwF8EmJWtCFk8B/Q5EOtrBRPbyuo1BMvKP3EObmUB/9Eg6e1409gFMSUXpOkFiWCt
         GYaGr4W0JZgdg==
Date:   Thu, 23 Sep 2021 21:40:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@redhat.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Sven Schnelle <svens@linux.ibm.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Series short description
Message-Id: <20210923214037.a65135f20c68b5fed5d6ac00@kernel.org>
In-Reply-To: <163240073510.33849.16299450051908678322.stgit@devnote2>
References: <163240073510.33849.16299450051908678322.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Oops, ignore this. I forgot to update subjects.

On Thu, 23 Sep 2021 21:38:55 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> Here I share my testing patch of the BTF for kprobe events.
> Currently this only allow user to specify '$$args' for
> tracing all arguments of the function. This is only
> avaialbe if
> - the probe point is on the function entry
> - the kernel is compiled with BTF (CONFIG_DEBUG_INFO_BTF)
> - the kernel is enables BPF (CONFIG_BPF_SYSCALL)
> 
> And Special thanks to Sven! Most of BTF handling part of
> this patch comes from his patch [1]
> 
> [1] https://stackframe.org/0001-ftrace-arg-hack.patch
> 
> What I thought while coding this were;
> - kernel/bpf/btf.c can be moved under lib/ so that
>   the other subsystems can reuse it, independent
>   from BPF. (Also, this should depends on CONFIG_DEBUG_INFO_BTF)
> - some more utility functions can be exposed.
>   e.g. I copied btf_type_int() from btf.c
> - If there are more comments for the BTF APIs, it will
>   be more useful...
> - Overall, the BTF is easy to understand for who
>   already understand DWARF. Great work!
> - I think I need 'ptr' and 'bool' types for fetcharg types.
> 
> Anyway, this is just for testing. I have to add some
> more cleanup, features and documentations, etc.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (1):
>       tracing/kprobe: Support $$args for function entry
> 
> 
>  kernel/trace/trace_kprobe.c |   60 ++++++++++++++++++++++++-
>  kernel/trace/trace_probe.c  |  105 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_probe.h  |    5 ++
>  3 files changed, 168 insertions(+), 2 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
