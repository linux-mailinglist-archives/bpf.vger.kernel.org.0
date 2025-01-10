Return-Path: <bpf+bounces-48564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55207A09498
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 16:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514A516B3B9
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B0721146C;
	Fri, 10 Jan 2025 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnDF2cFM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7C20DD79;
	Fri, 10 Jan 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736521384; cv=none; b=Blv9dCPVIUq2nzMI7LITaDCLkJtONB5MKGB/NBk0SU4qx8kMFx1fGeV4OeDSyapiclDhsWLciw9m+kKVEtJWSgYuAYBIaVQT2w2G2a8t+rUPURHfyZnKEyL2dBW1/w4OK6jIBrEPx7+ZUEvY/2Lent1UKwMoG1cvJ+wjTVlVEwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736521384; c=relaxed/simple;
	bh=ta4iWGL53BIH0C1gDNUplzL0kA6ovx8jE/bOv5C55jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2DXwgKtOr+dHBwUjBXiB4w2C0Wz3sKm/6Xv5mLWsT3WFY56ss5mep3HCzK4wvWPAtiQvNIc1EJHhgZkub5ELO0BPvcclEUldp5VGAI3MApW4K3uCzqZE7W6xNNGucUzvPALIoI3lmgTMbpbKhSF4uw8KwT5rh0f0T+mN0nNJYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnDF2cFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA7CC4CEE1;
	Fri, 10 Jan 2025 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736521384;
	bh=ta4iWGL53BIH0C1gDNUplzL0kA6ovx8jE/bOv5C55jk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PnDF2cFMD2DF+RtrwsUtsPCongV4/drhWTMopIfcsCmu3yse7LqD1vX1OrWkWNfwi
	 bLlTi93/cO0CWiys9XW82Vp7U858qyE9RDbv+h9ny0c9ohd+tlKTh7CmCMLsOt5Cmm
	 nrlx859z5VeHUnn77VPNCjZUgFbNNKxM8o5dL0kF+4z/ojKkS1hzONjZ0Ws1qoOv1x
	 ZirdoMNvJYePsAt8eKo0ZUohZC2hXZJzw7ycxXD3fRtNxqB6/iJO5awAGFGljsgXfO
	 Mjbmln6VsGi8FCdvnfFOaG3cKech2XSttZbn6tFd0573QyosYlStfCe3I/EZ4EDrft
	 M/oiap4fj9hPA==
Message-ID: <3073c48b-81c5-400a-8819-d816ffdc39fd@kernel.org>
Date: Fri, 10 Jan 2025 15:02:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: fix control flow graph segfault during edge
 creation
To: christoph.werle@longjmp.de, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250108220937.1470029-1-christoph.werle@longjmp.de>
 <55b9484a-c7db-402b-94f8-fe0544a9739f@kernel.org>
 <1055201260.220373.1736513826115@office.mailbox.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <1055201260.220373.1736513826115@office.mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-01-10 13:57 UTC+0100 ~ christoph.werle@longjmp.de
> Hello Quentin,
> 
>> Thanks for this! It looks OK, would you have a minimal reproducer by any
>> chance?
> 
> here's a small example based on libbpf-bootstrap:
> 
> ------------- reprex_edge_segfault.bpf.c
> // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> 
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> 
> char LICENSE[] SEC("license") = "Dual BSD/GPL";
> 
> int __attribute__ ((noinline)) do_barf()
> {
> 	bpf_printk("We're doomed\n");
> 	return 0;
> }
> 
> SEC("tp/sched/sched_process_exec")
> int handle__sched_process_exec(struct trace_event_raw_sched_process_exec *ctx)
> {
>     if (ctx->pid > 1000)
> 	    do_barf();
> 
>     return 0;
> }
> 
> ------------- reprex_edge_segfault.c
> // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> 
> #include <unistd.h>
> #include <bpf/libbpf.h>
> #include <bpf/bpf.h>
> #include "reprex_edge_segfault.skel.h"
> 
> int main(int argc, char **argv)
> {
> 	struct reprex_edge_segfault_bpf *skel;
> 	int err=0;
> 
> 	skel = reprex_edge_segfault_bpf__open();
> 	err = reprex_edge_segfault_bpf__load(skel);
> 	err = reprex_edge_segfault_bpf__attach(skel);
> 
> 	while (true)
> 	    sleep(1);
> 
> 	reprex_edge_segfault_bpf__destroy(skel);
> 	return -err;
> }
> --------------
> 
> Then just add reprex_edge_segfault to APPS variable in examples/c/Makefile.
> 
> Kind regards,
>  Christoph


Thanks a lot! I could successfully reproduce the issue and test your patch.

Tested-by: Quentin Monnet <qmo@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>

