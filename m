Return-Path: <bpf+bounces-53780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F310A5B66A
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 03:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EAD18932C5
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 02:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13441E3DD0;
	Tue, 11 Mar 2025 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GaITvt0R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97B3FD1
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741658669; cv=none; b=s1JeUBs4fSVgAGbwS0KllwAL4V+/u4ZG30fg3RUo+AMjrHLt4BN4Iuo8McrMFHXm6z7LzZiWRBr3hQPPX+YknvF62pws/46dQcPuFTtZomcpEGS1popY9xAZIeBAgyu+42oyG37lkNc9ZH7HxtwpgI83WtDLjIYXsAXBrfj6YW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741658669; c=relaxed/simple;
	bh=U8k2+czNdjwNz0QYG6g6d2VL19jX1EmA4yIBVyR38Vs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p+Jmt/KXwDd6ccPoKI0J77FqE+bE1GxNty2xYUME8G5G8oOuLXDvUzoGARm9ZrhlT00R1TenqG6JfC0jHPL+4QQH+eqGh7+ug7YP+KOEngJaf1nVbYL/Ly951bD74Vvh8YDtCVTZg59K1fgmBw58Q4EJaLs8gwgEGV8/lJ3nfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GaITvt0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127A8C4CEEC;
	Tue, 11 Mar 2025 02:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741658668;
	bh=U8k2+czNdjwNz0QYG6g6d2VL19jX1EmA4yIBVyR38Vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GaITvt0Rown3AjtLBBDxmAvuo0S+miNC1uAxtia4nwtN6tjM7xs6mvcM4nUmCu1J8
	 cHcrlDWl6He/7M0MtpxBDCojkIOJpXDGXB+SSeLlTFPl3HxulgrdwgxzYW6qSPMkxM
	 JfRlbNwRUnhZ29gj8GkwJNTyshRRHCTOt1NiiTiI=
Date: Mon, 10 Mar 2025 19:04:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
 peterz@infradead.org, vbabka@suse.cz, bigeasy@linutronix.de,
 rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@suse.com, willy@infradead.org,
 tglx@linutronix.de, jannh@google.com, tj@kernel.org, linux-mm@kvack.org,
 kernel-team@fb.com
Subject: Re: [PATCH bpf-next v9 2/6] mm, bpf: Introduce try_alloc_pages()
 for opportunistic page allocation
Message-Id: <20250310190427.32ce3ba9adb3771198fe2a5c@linux-foundation.org>
In-Reply-To: <20250222024427.30294-3-alexei.starovoitov@gmail.com>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
	<20250222024427.30294-3-alexei.starovoitov@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 18:44:23 -0800 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Tracing BPF programs execute from tracepoints and kprobes where
> running context is unknown, but they need to request additional
> memory. The prior workarounds were using pre-allocated memory and
> BPF specific freelists to satisfy such allocation requests.

The "prior workarounds" sound entirely appropriate.  Because the
performance and maintainability of Linux's page allocator is about
1,000,040 times more important than relieving BPF of having to carry a
"workaround".

IOW, I don't see any way in which this patchset even remotely meets any
sane cost/benefit comparison.

Feel free to explain why I am wrong, in great detail?

