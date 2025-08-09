Return-Path: <bpf+bounces-65291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A47B1F1EF
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 04:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1EF56152B
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 02:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D63F275112;
	Sat,  9 Aug 2025 02:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6xWengS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BA3C2FB;
	Sat,  9 Aug 2025 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754706248; cv=none; b=q23kk4nsOivSt7R1B4wP/72GWcEbsYuEhXlKp2vR4xg8BrPey19VRWDWB8GzXCElNOIkjG3sfAZmb29FMvNj7oITxMX45LjddwnA+JYsnnsziA5tMYcH08mD53D/5Y50lzPES2qg/IwpB+zqm0+ElxrCf1wxk/OLsYg5tLr/aqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754706248; c=relaxed/simple;
	bh=oG/gs0IIq/R05gYX+mXbeKSOc+H5ut11vppSDkHojUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQewh029EUE9J2a/9+n917Q3/KtEyGUvsfepy9S7Raf7YfV2S2c5QRWIXxwUGWVHWWhKtbLELIWtvhxWbNel7QRYLX0Q3w2VMqUq/M+u+oTr9olXybc+RGwSFDddr6chmxFpIvy0aT3Ta6r76iCltHPSY8CiDENWa8vFuVYra1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6xWengS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A696C4CEED;
	Sat,  9 Aug 2025 02:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754706247;
	bh=oG/gs0IIq/R05gYX+mXbeKSOc+H5ut11vppSDkHojUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6xWengSOLiD7r74p7CJMMKTHCqElz6amQ5SN59+PDUpxHAMC3CJINWjDQZHmiIfL
	 QOY/81Yy5eA2e1LBhSC+Ks9bb8678Ce0ZuvvB+gPAFRjJ17Hm1T9uR4zfarThtAbPz
	 MCttIFUaIJcciUAD4dpNjnZBRzGhcM4qdCBtfTP8Di1hTnlkZJmiIXs3200sOOYbam
	 Dqu5KsZZkAAnN+PSzBLIyG247b2AYFExjwJ4NAnw10EVRVrlarhI1GPDpsquGRbHUa
	 DXloZuLk/i52Aj9sibc+M03+pSTSdrt2WS/gTIzY7w0v4ve2OeJUj37znpPxkb7wtN
	 ReN1aFMpys5hg==
Date: Fri, 8 Aug 2025 22:24:05 -0400
From: Sasha Levin <sashal@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Donglin Peng <dolinux.peng@gmail.com>,
	Zheng Yejian <zhengyejian@huaweicloud.com>
Subject: Re: [PATCH v4 2/4] ftrace: Add support for function argument to
 graph tracer
Message-ID: <aJaxRVKverIjF4a6@lappy>
References: <20250227185804.639525399@goodmis.org>
 <20250227185822.810321199@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250227185822.810321199@goodmis.org>

Hi folks,

I've been trying to track down an issue that started appearing a while
back:

[   73.078526] ------------[ cut here ]------------
[   73.083194] WARNING: CPU: 2 PID: 4002 at kernel/trace/trace_functions_graph.c:991 print_graph_entry+0x579/0x590
[   73.093544] Modules linked in: x86_pkg_temp_thermal fuse
[   73.098939] CPU: 2 UID: 0 PID: 4002 Comm: cat Tainted: G S                  6.16.0 #1 PREEMPT(voluntary)
[   73.108587] Tainted: [S]=CPU_OUT_OF_SPEC
[   73.112664] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS 2.7 12/07/2021
[   73.120126] RIP: 0010:print_graph_entry+0x579/0x590
[   73.125198] Code: 49 89 40 20 49 8b 46 08 49 89 40 28 49 8b 46 10 49 89 40 30 49 8b 46 18 49 89 40 38 49 8b 46 20 49 89 40 40 e9 27 fe ff ff 90 <0f> 0b 90 e9 e2 fe ff ff 90 0f 0b 90 e9 8e fc ff ff e8 91 d8 10 01
[   73.144001] RSP: 0018:ffffa6af02d37c58 EFLAGS: 00010282
[   73.149369] RAX: ffffc6aeffd986f0 RBX: ffff9d70c83b0000 RCX: 00000000fefefefe
[   73.156621] RDX: ffffffffbb374080 RSI: 0000000000000001 RDI: ffffffffbaf773ea
[   73.163839] RBP: ffffa6af02d37cf0 R08: ffff9d70c1790cc0 R09: 0000000000000020
[   73.171023] R10: 0000000000000000 R11: 0000000000000004 R12: ffff9d70c83b2090
[   73.178216] R13: 0000000000000003 R14: ffff9d70c83b0000 R15: ffff9d70c1790cc0
[   73.185412] FS:  00007fd8c6872740(0000) GS:ffff9d72741a9000(0000) knlGS:0000000000000000
[   73.193584] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   73.199391] CR2: 00007ffedaf50fbc CR3: 00000001049f4006 CR4: 00000000003726f0
[   73.206570] Call Trace:
[   73.209086]  <TASK>
[   73.211313]  ? trace_event_raw_event_preemptirq_template+0x66/0xc0
[   73.217573]  ? __pfx_put_cpu_partial+0x10/0x10
[   73.222093]  ? __pfx_put_cpu_partial+0x10/0x10
[   73.226635]  print_graph_function_flags+0x27c/0x530
[   73.231607]  ? peek_next_entry+0x9d/0xb0
[   73.235618]  print_graph_function+0x13/0x20
[   73.239895]  print_trace_line+0xbb/0x530
[   73.243909]  tracing_read_pipe+0x1d6/0x380
[   73.248121]  vfs_read+0xbb/0x380
[   73.251495]  ? vfs_read+0x9/0x380
[   73.254929]  ksys_read+0x7b/0xf0
[   73.258258]  __x64_sys_read+0x1d/0x30
[   73.261995]  x64_sys_call+0x1ada/0x20d0
[   73.265936]  do_syscall_64+0xb2/0x2b0
[   73.269694]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   73.274818] RIP: 0033:0x7fd8c6904687
[   73.278491] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[   73.297320] RSP: 002b:00007ffe8bb08e60 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
[   73.304974] RAX: ffffffffffffffda RBX: 00007fd8c6872740 RCX: 00007fd8c6904687
[   73.312185] RDX: 0000000000040000 RSI: 00007fd8c6831000 RDI: 0000000000000003
[   73.319369] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
[   73.326588] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fd8c6831000
[   73.333801] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000040000
[   73.341050]  </TASK>
[   73.343324] ---[ end trace 0000000000000000 ]---
[   73.804718] ------------[ cut here ]------------
[   73.809372] WARNING: CPU: 1 PID: 4002 at kernel/trace/trace_functions_graph.c:933 print_graph_entry+0x582/0x590
[   73.819492] Modules linked in: x86_pkg_temp_thermal fuse
[   73.824888] CPU: 1 UID: 0 PID: 4002 Comm: cat Tainted: G S      W           6.16.0 #1 PREEMPT(voluntary)
[   73.834477] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[   73.839314] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS 2.7 12/07/2021
[   73.846739] RIP: 0010:print_graph_entry+0x582/0x590
[   73.851662] Code: 89 40 28 49 8b 46 10 49 89 40 30 49 8b 46 18 49 89 40 38 49 8b 46 20 49 89 40 40 e9 27 fe ff ff 90 0f 0b 90 e9 e2 fe ff ff 90 <0f> 0b 90 e9 8e fc ff ff e8 91 d8 10 01 90 90 90 90 90 90 90 90 90
[   73.870458] RSP: 0018:ffffa6af02d37c58 EFLAGS: 00010282
[   73.875733] RAX: ffffc6aeffd186f0 RBX: ffff9d70c83b0000 RCX: 00000011792c5f40
[   73.882906] RDX: ffffffffbb374080 RSI: 00000000fefefefd RDI: 00000011792c5ff6
[   73.890079] RBP: ffffa6af02d37cf0 R08: ffff9d70c1790cc0 R09: 0000000000000020
[   73.897249] R10: 00000000fefefefe R11: 0000000000000004 R12: ffff9d70c83b2090
[   73.904424] R13: 0000000000000001 R14: ffff9d70c1790ce0 R15: ffff9d70c1790cc0
[   73.911609] FS:  00007fd8c6872740(0000) GS:ffff9d7274129000(0000) knlGS:0000000000000000
[   73.919740] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   73.925528] CR2: 0000559a316ca3c0 CR3: 00000001049f4003 CR4: 00000000003726f0
[   73.932705] Call Trace:
[   73.935200]  <TASK>
[   73.937350]  ? __legitimize_mnt+0x4/0xb0
[   73.941342]  print_graph_function_flags+0x27c/0x530
[   73.946269]  ? trace_hardirqs_on+0x2f/0x90
[   73.950401]  ? ring_buffer_empty_cpu+0x86/0xd0
[   73.954912]  print_graph_function+0x13/0x20
[   73.959149]  print_trace_line+0xbb/0x530
[   73.963135]  tracing_read_pipe+0x1d6/0x380
[   73.967291]  vfs_read+0xbb/0x380
[   73.970580]  ? vfs_read+0x9/0x380
[   73.973954]  ksys_read+0x7b/0xf0
[   73.977244]  __x64_sys_read+0x1d/0x30
[   73.980952]  x64_sys_call+0x1ada/0x20d0
[   73.984839]  do_syscall_64+0xb2/0x2b0
[   73.988558]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   73.993657] RIP: 0033:0x7fd8c6904687
[   73.997278] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[   74.016084] RSP: 002b:00007ffe8bb08e60 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
[   74.023743] RAX: ffffffffffffffda RBX: 00007fd8c6872740 RCX: 00007fd8c6904687
[   74.030920] RDX: 0000000000040000 RSI: 00007fd8c6831000 RDI: 0000000000000003
[   74.038101] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
[   74.045277] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fd8c6831000
[   74.052484] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000040000
[   74.059724]  </TASK>
[   74.061974] ---[ end trace 0000000000000000 ]---

This patch was within the window where the issue started happening, and
on inspection I found something suspicious (but couldn't verify since
I'm traveling).

On Thu, Feb 27, 2025 at 01:58:06PM -0500, Steven Rostedt wrote:
>diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
>index fbfb396905a6..77a8ba3bc1e3 100644
>--- a/kernel/trace/trace_entries.h
>+++ b/kernel/trace/trace_entries.h
>@@ -72,17 +72,18 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
> );
>
> /* Function call entry */
>-FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
>+FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
>
> 	TRACE_GRAPH_ENT,
>
> 	F_STRUCT(
> 		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
> 		__field_packed(	unsigned long,	graph_ent,	func		)
>-		__field_packed(	int,		graph_ent,	depth		)
>+		__field_packed(	unsigned long,	graph_ent,	depth		)
>+		__dynamic_array(unsigned long,	args				)

So we've added a dynamically sized array to the end of
ftrace_graph_ent_entry, but in struct fgraph_data, the saved entry is
defined as:

   struct fgraph_data {
       ...
       union {
           struct ftrace_graph_ent_entry ent;
           struct fgraph_retaddr_ent_entry rent;
       } ent;
       ...
   }

Which doesn't seem to have room for args?

The code in get_return_for_leaf() does:

   data->ent.ent = *curr;

This copies the struct, but curr points to a larger entry with args
data. The copy operation only copies sizeof(struct
ftrace_graph_ent_entry) bytes, which doesn't include the dynamic args
array.

And then later functions (like print_graph_entry()) would go ahead and
assume that iter->ent_size is sane and make a mess out of everything.

I can't test right now whether this actually fixes the issues or not,
but I wanted to bring this up as this looks somewhat odd and I'm not too
familiar with this code.

-- 
Thanks,
Sasha

