Return-Path: <bpf+bounces-689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA91705D4D
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 04:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB2828121F
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 02:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7871B11C94;
	Wed, 17 May 2023 02:29:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1199711C89
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 02:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277C9C433EF;
	Wed, 17 May 2023 02:29:22 +0000 (UTC)
Date: Tue, 16 May 2023 22:29:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, Masami Hiramatsu <mhiramat@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, David
 Vernet <void@manifault.com>, dthaler@microsoft.com, brauner@kernel.org,
 hch@infradead.org
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230516222919.79bba667@rorschach.local.home>
In-Reply-To: <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
	<CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
	<20230509130111.62d587f1@rorschach.local.home>
	<20230509163050.127d5123@rorschach.local.home>
	<20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
	<20230515192407.GA85@W11-BEAU-MD.localdomain>
	<20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
	<CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
	<CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 May 2023 18:46:29 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So don't even ask for other GUP functionality, much less the "remote"
> kind. Not going to happen. If you think you need access to remote
> process memory, you had better do it in process context, or you had
> better just think again.

So this code path is very much in user context (called directly by a
write system call). The issue that Alexei had was that it's also in an
rcu_read_lock() section.

I wonder if this all goes away if we switch to SRCU? That is, sleepable RCU.

-- Steve

