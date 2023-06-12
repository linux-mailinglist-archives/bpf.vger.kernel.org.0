Return-Path: <bpf+bounces-2358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CB072B586
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 04:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676B728107E
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 02:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743721C06;
	Mon, 12 Jun 2023 02:54:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F23EC3
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 02:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD9DC4339B;
	Mon, 12 Jun 2023 02:54:08 +0000 (UTC)
Date: Sun, 11 Jun 2023 22:54:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yonghong Song <yhs@meta.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Andrii Nakryiko <andrii@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jackie
 Liu <liu.yun@linux.dev>
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <20230611225407.3e9b8ad2@gandalf.local.home>
In-Reply-To: <53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
References: <20230611130029.1202298-1-jolsa@kernel.org>
	<53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Jun 2023 17:22:29 -0700
Yonghong Song <yhs@meta.com> wrote:

> > Note displayed address is the patch-site address and can differ from
> > /proc/kallsyms address.  
> 
> Could you explain how these addresses will be used in kernel, esp.
> since these addresses are different from kallsyms addresses?

These are the addresses that will be patched by the ftrace infrastructure.
It's more efficient to use these addresses when setting a function filter
with ftrace_set_filter_ip(), as it doesn't need to call into the kallsyms
infrastructure to look to see if the passed in ip lands on a function. That
is, if rec->ip matches the ip, it uses it. If you look at ftrace_location()
(which is used to find the record to be patched), it first does a search of
these addresses. If it doesn't find it, it then has to call into kallsyms
to find the start and end of the function, and do another search into that
range.

> 
> Also, if there are multiple same static functions with
> different addresses, user space might need to check dwarf or
> proposed BTF_KIND_KFUNC (which encode kallsyms addresses)
> to find whether entry in available_filter_functions_addrs
> to be used. But addresses may not match. How this issue could
> be resolved?

Easy, you use the address between two other addresses in kallsyms. The
address is still in the function. The addresses in kallsyms is the starting
address, but there's cases that the patch location is not at the start.

-- Steve

