Return-Path: <bpf+bounces-843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9847077CD
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 04:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966231C21039
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 02:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674B238C;
	Thu, 18 May 2023 02:08:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994827E
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 02:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5346C433EF;
	Thu, 18 May 2023 02:08:01 +0000 (UTC)
Date: Wed, 17 May 2023 22:08:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, David Vernet
 <void@manifault.com>, Linus Torvalds <torvalds@linux-foundation.org>, Dave
 Thaler <dthaler@microsoft.com>, Christian Brauner <brauner@kernel.org>,
 Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230517220800.3d4cbad2@gandalf.local.home>
In-Reply-To: <20230518011814.GA294@W11-BEAU-MD.localdomain>
References: <20230509130111.62d587f1@rorschach.local.home>
	<20230509163050.127d5123@rorschach.local.home>
	<20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
	<20230515192407.GA85@W11-BEAU-MD.localdomain>
	<20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
	<20230516212658.2f5cc2c6@gandalf.local.home>
	<20230517165028.GA71@W11-BEAU-MD.localdomain>
	<CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>
	<20230518001916.GB254@W11-BEAU-MD.localdomain>
	<CAADnVQJwK3p1QyYEvAn9B86M4nkX69kuUvx2W0Yqwy0e=RSPPg@mail.gmail.com>
	<20230518011814.GA294@W11-BEAU-MD.localdomain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 May 2023 18:18:14 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> We should tell folks to use a group and give access to the group like
> Steven said earlier.

Could we possibly add an "owner" attribute to the event. That is, the
creator of the event is the only one that can write to that event. Or at
least by the user that created it (not actually the process).

So if the user "rostedt" creates an event, only "rostedt" can write to or
delete the event.

Basically like how the /tmp directory works.

I think this would lock down the issue that Alexei is worried about.

Thoughts?

-- Steve

P.S. I'm about to leave on PTO and will be very late in my replies
starting now. (Unless I'm board at the airport, I may then reply).

-- Steve

