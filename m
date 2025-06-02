Return-Path: <bpf+bounces-59435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA6ACB5F2
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 17:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5742A1BC7665
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D81224240;
	Mon,  2 Jun 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q3ssEig6"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414B1223DEF
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876102; cv=none; b=L9b+Jg87eiAGRi2Ew0Aa7Mt2Vqnb6mhGXOgFfh7GnuPErBU59s+2lkxz4bIyuYugNJ/8GGcfNQCxiHNBdUVO1/giJEZz/z+tZVSRG6VOiAXYUSKa8cnjKPcRNL3F1g4PTOaUu3vk/vSnua3Wu01fjE3h7dZuzVivTAkLaFxTXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876102; c=relaxed/simple;
	bh=iQwc17TdMV/yfeIRfr5oNdWRm+g0Uk/Vj0XMS797H90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeDc6lOgGgbaYRWkXf7G+TJzFWlEWFPVx1tQIBU9KJlkEsQtm5NsAN85K79jNiAOWwtxM/SXSzFZsFIOYH8QVcuNB5hne9V6ouZ8fs5SaH8zNdEXe6abjG1RPIHCQ0rvi8dGARC/f6UdshXKn6PFvor0bOc47/voyPg5DxOsQro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q3ssEig6; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Jun 2025 07:54:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748876088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jK+toVOslS/uORtFWGgTjBsPyxhbHB/QR1GNGAJP37E=;
	b=Q3ssEig6oHBpk/690cvZLo0Dzc77n6f2C/I9kPbIl8w4qQmSjZku6OPYh/eKRTO6LuKFiX
	153BJ6V9Hp/ZqIZUv6sMWElPKjoRBHBCocgoDNoPRS99cY3pzh8QM/Qz6JoT1XLG4N6gY9
	VT1HfGdAK9HfjfGcaNhlZy5e4A19ack=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Harry Yoo <harry.yoo@oracle.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v4 0/5] memcg: nmi-safe kmem charging
Message-ID: <y2eqzgsplnp2fuvlhwk3hogffgjh3d2caohxuwa4dgt7ecznhx@m57r5xhglzyb>
References: <20250519063142.111219-1-shakeel.butt@linux.dev>
 <gqb34j7wrgetfuklvcjbdlcuteratvvnuow4ujs3dza22fdtwb@cobgv5fq6hb5>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gqb34j7wrgetfuklvcjbdlcuteratvvnuow4ujs3dza22fdtwb@cobgv5fq6hb5>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 02, 2025 at 04:45:31PM +0200, Michal Koutný wrote:
> Hello Shakeel.
> 
> On Sun, May 18, 2025 at 11:31:37PM -0700, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > Users can attached their BPF programs at arbitrary execution points in
> > the kernel and such BPF programs may run in nmi context. In addition,
> > these programs can trigger memcg charged kernel allocations in the nmi
> > context. However memcg charging infra for kernel memory is not equipped
> > to handle nmi context for all architectures.
> 
> How much memory does this refer to? Is it unbound (in particular for
> non-privileged eBPF)? Or is it rather negligible? (I assume the former
> to make the series worth it.)
> 

It depends on the BPF program and thus can be arbitrarily large. So,
irrespective of privileged or non-privileged BPF programs, they can
allocate large amount of memory to maintain monitoring or debugging (or
for some other use-case) information.

