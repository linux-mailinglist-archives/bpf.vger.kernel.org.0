Return-Path: <bpf+bounces-580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D19704020
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 23:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491C128135A
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 21:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E575819BDF;
	Mon, 15 May 2023 21:57:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6685FBF9
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 21:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5ED6C433D2;
	Mon, 15 May 2023 21:57:13 +0000 (UTC)
Date: Mon, 15 May 2023 17:57:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, David Vernet
 <void@manifault.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 dthaler@microsoft.com, brauner@kernel.org, hch@infradead.org
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230515175712.649aa5f6@gandalf.local.home>
In-Reply-To: <20230515192407.GA85@W11-BEAU-MD.localdomain>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
	<CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
	<20230509130111.62d587f1@rorschach.local.home>
	<20230509163050.127d5123@rorschach.local.home>
	<20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
	<20230515192407.GA85@W11-BEAU-MD.localdomain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 May 2023 12:24:07 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> > Beau,
> > please provide a detailed explanation of your use case and how bpf helps.
> >   
> 
> There are teams that have existing BPF programs that want to also pull
> in data from user processes in addition to the data they already collect
> from the kernel.
> 
> We are also seeing a trend of teams wanting to drop buffering approaches
> and move into non-buffered analysis of problems. An example is as soon
> as a fault happens in a user-process, they would like the ability to see
> what that thread has done, what the kernel did a bit before the error
> (or other processes that have swapped in, etc).
> 
> We also have needs to aggregate operation duration live, and as soon as
> they deviate, trigger corrective actions. BPF is ideal for us to use for
> aggregating data cheaply, comparing that to other kernel and user
> processes, and then making a decision quickly on how to mitigate or flag
> it. We are working with OpenTelemetry teams to make this work via
> certain exporters in various languages (C#/C++/Rust).

This is turning into a very productive discussion. Thank you Alexei and
Beau for this.

Beau,

Could you possibly also add (in a separate patch), a simple use case of a
BPF program that would be attached to some user event. Could be contrived.
Perhaps supply a patch to ls.c[1] that adds a user event to where it reads a
file type and the bpf program can do something special if the file belongs
to the user. OK, I'm just pulling crazy ideas out of thin air!

[1] https://github.com/coreutils/coreutils/blob/master/src/ls.c

Could copy the ls with the user event to the samples directory for user
events. It is GPL.

-- Steve

