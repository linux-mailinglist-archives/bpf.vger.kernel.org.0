Return-Path: <bpf+bounces-2592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CFD730316
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 17:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A346C1C20D78
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 15:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18662101C1;
	Wed, 14 Jun 2023 15:12:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2ABDDB6
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 15:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65B8C433C8;
	Wed, 14 Jun 2023 15:12:13 +0000 (UTC)
Date: Wed, 14 Jun 2023 11:12:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Andrii Nakryiko <andrii@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jackie
 Liu <liu.yun@linux.dev>
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <20230614111212.4e33bfbc@gandalf.local.home>
In-Reply-To: <ZInLO4/xly/f+Zk3@krava>
References: <20230611130029.1202298-1-jolsa@kernel.org>
	<53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
	<20230611225407.3e9b8ad2@gandalf.local.home>
	<20230611225754.01350a50@gandalf.local.home>
	<d5ffd64c-65b7-e28c-b8ee-0d2ff9dcd78b@meta.com>
	<20230612110222.50c254f3@gandalf.local.home>
	<ZId/UL/iujOdgel+@krava>
	<ZInLO4/xly/f+Zk3@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jun 2023 16:14:19 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> FYI I did some perf meassurements and the speedup is not substantial :-\
> 
> looks like the symbols resolving to addresses we do in kernel for kprobe_multi
> link is more faster/cheaper than I thought 

The symbol lookup is supposed to be fast, but it's not "free", whereas this
is "free". I didn't expect a big speedup.

-- Steve


> 
> but still there is 'some' speedup and we will get rid of the extra
> /proc/kallsyms parsing, so I think it's still worth it to have the
> new file


