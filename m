Return-Path: <bpf+bounces-38040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC5695E590
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 00:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12ADB1C20AE8
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 22:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794AC7407A;
	Sun, 25 Aug 2024 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTOOCamv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0FF47A6A
	for <bpf@vger.kernel.org>; Sun, 25 Aug 2024 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724625643; cv=none; b=N1lGNMNzrqRUab0SVrIZyLszgeb6JKhyvgalk7yubYMwV1cUix/QO1sP+6s8L/TqWF+Vk68iFzH9olesirObr6DA+NYUTJi21w30CCicPxKoM2yyBshwBF37ZJhGD/HwUUKyFem79gw0BcuEoK1ObztdBrZCj+O/ZIhmO+EnQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724625643; c=relaxed/simple;
	bh=E2b6S42am7FxdDCGzlzr8xGm8Shd9IcqwtlxU9KAQQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JC2+elolVUFuREkkvE419M/xovlysxokJluOx18Y9co01Ac5QHX74MzIFXU5tqfPKpKr2xRU1iUDgHomoWj2jveohIj7WI7bkByJHOA4OjS1Xo5+krnj4SrBumUWoI1GFO09V5qBaVCf/zWfvmdgbj4xw5LTAJm48ffjC3VLUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTOOCamv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724625640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XldHedHtO4bPQ+b6KANXtOgQ6JTZqedmNWOSSS/IrRY=;
	b=LTOOCamvvSFkWPiZ0xHTh8xTfpeQ2krGoGaEDEYZ4K43aj6ljpPUg3EMhGK31dWgNZ8iog
	V7Y74Ty9MATMteMWsWblPcqdNkbnf26nm4G2L2DBjGkGuK3PWRZ1qb7t6AGAwFw9MRZmq5
	EVKlHSX98jpnQGiJfvvcEw228RskoUQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-aL8pZNnGOpSWp99MLDxDhw-1; Sun,
 25 Aug 2024 18:40:34 -0400
X-MC-Unique: aL8pZNnGOpSWp99MLDxDhw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78E9E1956080;
	Sun, 25 Aug 2024 22:40:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 14FC91955DDD;
	Sun, 25 Aug 2024 22:40:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 26 Aug 2024 00:40:25 +0200 (CEST)
Date: Mon, 26 Aug 2024 00:40:18 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tianyi Liu <i.pear@outlook.com>
Cc: andrii.nakryiko@gmail.com, mhiramat@kernel.org, ajor@meta.com,
	albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, jolsa@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240825224018.GD3906@redhat.com>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825171417.GB3906@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/25, Oleg Nesterov wrote:
>
> At least I certainly disagree with "Fixes: c1ae5c75e103" ;)
>
> uretprobe_perf_func/etc was designed for perf, and afaics this code still
> works fine even if you run 2 perf-record's with -p PID1/PID2 at the same
> time.
>
> BPF hacks/hooks were added later, so perhaps this should be fixed in the
> bpf code, but I have no idea what bpftrace does...

And I can't install bpftrace on my old Fedora 23 working laptop ;) Yes, yes,
I know, I should upgrade it.

For the moment, please forget about ret-probes. Could you compile this program

	#define _GNU_SOURCE
	#include <unistd.h>
	#include <sched.h>
	#include <signal.h>

	int func(int i)
	{
		return i;
	}

	int test(void *arg)
	{
		int i;
		for (i = 0;; ++i) {
			sleep(1);
			func(i);
		}
		return 0;
	}

	int main(void)
	{
		static char stack[65536];

		clone(test, stack + sizeof(stack)/2, CLONE_VM|SIGCHLD, NULL);
		test(NULL);

		return 0;
	}

and then do something like

	$ ./test &
	$ bpftrace -p $! -e 'uprobe:./test:func { printf("%d\n", pid); }'

I hope that the syntax of the 2nd command is correct...

I _think_ that it will print 2 pids too.

But "perf-record -p" works as expected.

Oleg.


