Return-Path: <bpf+bounces-2359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE0E72B58E
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 04:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC827281098
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 02:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F361C06;
	Mon, 12 Jun 2023 02:58:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B9EC3
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 02:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A66C433EF;
	Mon, 12 Jun 2023 02:57:56 +0000 (UTC)
Date: Sun, 11 Jun 2023 22:57:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yonghong Song <yhs@meta.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Andrii Nakryiko <andrii@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jackie
 Liu <liu.yun@linux.dev>
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <20230611225754.01350a50@gandalf.local.home>
In-Reply-To: <20230611225407.3e9b8ad2@gandalf.local.home>
References: <20230611130029.1202298-1-jolsa@kernel.org>
	<53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
	<20230611225407.3e9b8ad2@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Jun 2023 22:54:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Also, if there are multiple same static functions with
> > different addresses, user space might need to check dwarf or
> > proposed BTF_KIND_KFUNC (which encode kallsyms addresses)
> > to find whether entry in available_filter_functions_addrs
> > to be used. But addresses may not match. How this issue could
> > be resolved?  
> 
> Easy, you use the address between two other addresses in kallsyms. The
> address is still in the function. The addresses in kallsyms is the starting
> address, but there's cases that the patch location is not at the start.

Not to mention, you can still use the kallsyms address. If you did the work
to find it, then use it (it may not be as efficient as I mentioned before).
That's basically what is done today (so I am told), and this patch was to
create a file where you don't need to look up kallsyms when you know which
function to use. The functions are sorted by address, so if you know of a
unique function near the duplicate, you just find the duplicate that's near
the unique function name.

-- Steve

