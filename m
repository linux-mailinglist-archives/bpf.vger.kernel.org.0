Return-Path: <bpf+bounces-48551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED32A09137
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 13:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E820F7A0657
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 12:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256A020D4F7;
	Fri, 10 Jan 2025 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=longjmp.de header.i=@longjmp.de header.b="byvtS6yo"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1689B20B21B;
	Fri, 10 Jan 2025 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513841; cv=none; b=npxzSknlbVwULs8mVIlyS+FJ2FeQTXgJ9ObLZ7I+eT4GuER1f3yqGF0Ef27L9Ho9KdDmQ0BuUWZ66Q8+C5qBMAZNjsNX8yScN62Fg0FnWdtUyirOFHyUwvg5gmzE0H2fZlrxdGMtGQ2FvkTryOQLJpI2DMvSvquJuetrKcf/E0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513841; c=relaxed/simple;
	bh=D1E3GfORtqKj6RGSe6oygnWxmoorH/XDT663uENGPC4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=I7McEUO2eDFMv2zkyZPzNhEUlQOd4LarcychHHmxUl35XcN90m8wdBIR1c5zAINZtjLOwMkULdftNfO71GvQym1AoO2hnpZHINFCg6wA0E+GYKQo6EIYjbH9qiJanVgJIi1ySt5p0EIaZdttSEy+mS+W8J2CX7PV8w3mmB8Qkck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=longjmp.de; spf=pass smtp.mailfrom=longjmp.de; dkim=pass (2048-bit key) header.d=longjmp.de header.i=@longjmp.de header.b=byvtS6yo; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=longjmp.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=longjmp.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YV1rh4z0Mz9v8T;
	Fri, 10 Jan 2025 13:57:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=longjmp.de; s=MBO0001;
	t=1736513828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwELQyozSQFtMztjtKtUbRMZJ5yFCqtLpCPNlaKjIiY=;
	b=byvtS6yoLwuuz6YdvnVkOCSM1/adU/IvXuq5sHxKINGt528u9Uiq7WYkVLL2xXR6d84Wm6
	dVGz6tI5eopTSq053z7oaGnFOgzUk1QCHFCd8+u5CWPGRTfSTVZQ8RxPuVtI7sph4k6bT5
	BBixJlHd0Y8y6M6RPr1vFopd0Ng9REIdRwGsXv4dxKvwHDzyAn1gKdwCQoatI8nmqiHHks
	QJnDi/Q6AhBLz+BptC/JoRn3ph74Z/LPR5mXDH57a0f1o7mOMTN4C/1DsNUsnkkyXP5tEz
	2KySf/MDyz3N/aB/ue/fpCELm+599VDlOZAStAoQVj2gXYAQvZeb06PVDCFg2w==
Date: Fri, 10 Jan 2025 13:57:06 +0100 (CET)
From: christoph.werle@longjmp.de
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1055201260.220373.1736513826115@office.mailbox.org>
In-Reply-To: <55b9484a-c7db-402b-94f8-fe0544a9739f@kernel.org>
References: <20250108220937.1470029-1-christoph.werle@longjmp.de>
 <55b9484a-c7db-402b-94f8-fe0544a9739f@kernel.org>
Subject: Re: [PATCH] bpftool: fix control flow graph segfault during edge
 creation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: 4YV1rh4z0Mz9v8T

Hello Quentin,

> Thanks for this! It looks OK, would you have a minimal reproducer by any
> chance?

here's a small example based on libbpf-bootstrap:

------------- reprex_edge_segfault.bpf.c
// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>

char LICENSE[] SEC("license") = "Dual BSD/GPL";

int __attribute__ ((noinline)) do_barf()
{
	bpf_printk("We're doomed\n");
	return 0;
}

SEC("tp/sched/sched_process_exec")
int handle__sched_process_exec(struct trace_event_raw_sched_process_exec *ctx)
{
    if (ctx->pid > 1000)
	    do_barf();

    return 0;
}

------------- reprex_edge_segfault.c
// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)

#include <unistd.h>
#include <bpf/libbpf.h>
#include <bpf/bpf.h>
#include "reprex_edge_segfault.skel.h"

int main(int argc, char **argv)
{
	struct reprex_edge_segfault_bpf *skel;
	int err=0;

	skel = reprex_edge_segfault_bpf__open();
	err = reprex_edge_segfault_bpf__load(skel);
	err = reprex_edge_segfault_bpf__attach(skel);

	while (true)
	    sleep(1);

	reprex_edge_segfault_bpf__destroy(skel);
	return -err;
}
--------------

Then just add reprex_edge_segfault to APPS variable in examples/c/Makefile.

Kind regards,
 Christoph

> Quentin Monnet <qmo@kernel.org> hat am 09.01.2025 19:19 CET geschrieben:
> 
>  
> On 08/01/2025 22:09, Christoph Werle wrote:
> > If the last instruction of a control flow graph building block is a
> > BPF_CALL, an incorrect edge with e->dst set to NULL is created and
> > results in a segfault during graph output.
> > 
> > Ensure that BPF_CALL as last instruction of a building block is handled
> > correctly and only generates a single edge unlike actual BPF_JUMP*
> > instructions.
> > 
> > Signed-off-by: Christoph Werle <christoph.werle@longjmp.de>
> 
> 
> Fixes: 0824611f9b38 ("tools: bpftool: partition basic-block for each function in the CFG")
> 
> 
> > ---
> >  tools/bpf/bpftool/cfg.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
> > index eec437cca2ea..e3785f9a697d 100644
> > --- a/tools/bpf/bpftool/cfg.c
> > +++ b/tools/bpf/bpftool/cfg.c
> > @@ -302,6 +302,7 @@ static bool func_add_bb_edges(struct func_node *func)
> >  
> >  		insn = bb->tail;
> >  		if (!is_jmp_insn(insn->code) ||
> > +		    BPF_OP(insn->code) == BPF_CALL ||
> >  		    BPF_OP(insn->code) == BPF_EXIT) {
> >  			e->dst = bb_next(bb);
> >  			e->flags |= EDGE_FLAG_FALLTHROUGH;
> 
> 
> Thanks for this! It looks OK, would you have a minimal reproducer by any
> chance?
> 
> Quentin

