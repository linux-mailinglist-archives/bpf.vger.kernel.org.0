Return-Path: <bpf+bounces-121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 697046F8573
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 17:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC22281058
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24200C2D7;
	Fri,  5 May 2023 15:20:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676D2BE7A
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 15:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE85C4339B;
	Fri,  5 May 2023 15:20:27 +0000 (UTC)
Date: Fri, 5 May 2023 11:20:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florent Revest <revest@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v9.1 11/11] Documentation: tracing/probes: Add fprobe
 event tracing document
Message-ID: <20230505112026.6a46bcec@gandalf.local.home>
In-Reply-To: <168299393654.3242086.4099482065080890890.stgit@mhiramat.roam.corp.google.com>
References: <168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com>
	<168299393654.3242086.4099482065080890890.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 May 2023 11:18:56 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> + # cat events/fprobes/myprobe/format
> + name: myprobe
> + ID: 1313
> + format:
> + 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> + 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> + 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> + 	field:int common_pid;	offset:4;	size:4;	signed:1;
> +
> + 	field:unsigned long __probe_ip;	offset:8;	size:8;	signed:0;
> + 	field:u64 count;	offset:16;	size:8;	signed:0;
> + 	field:u64 pos;	offset:24;	size:8;	signed:0;

git complained when I pulled this in because there above lines is:

<space><tab>field...

Where, the space should be removed.

-- Steve

> +
> + print fmt: "(%lx) count=%Lu pos=0x%Lx", REC->__probe_ip, REC->count, REC->pos

