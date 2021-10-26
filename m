Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E52443BACE
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 21:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhJZTcN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 15:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238731AbhJZTcN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 15:32:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B6C260F39;
        Tue, 26 Oct 2021 19:29:48 +0000 (UTC)
Date:   Tue, 26 Oct 2021 15:29:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jiri Olsa <jolsa@redhat.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 8/8] ftrace/samples: Add multi direct interface test
 module
Message-ID: <20211026152946.55a77e97@gandalf.local.home>
In-Reply-To: <20211026192309.GA2038767@roeck-us.net>
References: <20211008091336.33616-1-jolsa@kernel.org>
        <20211008091336.33616-9-jolsa@kernel.org>
        <20211026192309.GA2038767@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 26 Oct 2021 12:23:09 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Fri, Oct 08, 2021 at 11:13:36AM +0200, Jiri Olsa wrote:
> > Adding simple module that uses multi direct interface:
> > 
> >   register_ftrace_direct_multi
> >   unregister_ftrace_direct_multi
> > 
> > The init function registers trampoline for 2 functions,
> > and exit function unregisters them.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>  
> 
> Building s390:defconfig ... failed
> --------------
> Error log:
> <stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [-Wcpp]
> {standard input}: Assembler messages:
> {standard input}:11: Error: Unrecognized opcode: `pushq'
> {standard input}:12: Error: Unrecognized opcode: `movq'
> {standard input}:13: Error: Unrecognized opcode: `pushq'
> {standard input}:14: Error: Unrecognized opcode: `movq'
> {standard input}:15: Error: Unrecognized opcode: `call'
> {standard input}:16: Error: Unrecognized opcode: `popq'
> {standard input}:17: Error: Unrecognized opcode: `leave'
> {standard input}:18: Error: Unrecognized opcode: `ret'
> make[3]: *** [scripts/Makefile.build:288: samples/ftrace/ftrace-direct-multi.o] Error 1
> make[2]: *** [scripts/Makefile.build:571: samples/ftrace] Error 2
> make[1]: *** [Makefile:1993: samples] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:226: __sub-make] Error 2
> 
>

  https://lore.kernel.org/all/YXAqZ%2FEszRisunQw@osiris/

-- Steve
