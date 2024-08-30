Return-Path: <bpf+bounces-38552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045A7966190
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 14:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877B91F28262
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7B01A2863;
	Fri, 30 Aug 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcqUwAv2"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E15A17ADF8
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020646; cv=none; b=i57ZwZPqE+njEg+IzQu6NQXW7KM6GS7/p4GPyP1bpmNZI5KPYiL63TpQGD5F6d71Ku29btQC0KYyUu3KTPWJ3SUp1Lf1n48G8H29uIgnqtu2XWnz8cAPet4vH4+tKSbdDZdm5y41egoxFAEOhwBSG3u63csECSuEx43Xuch0kFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020646; c=relaxed/simple;
	bh=cTGvbv08K/sWtnBpqDdI7n4W/OX+sZYzLx3z4jVh5go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gmy6i+E5AgXH520gvv5E/dhyWwcgCYHNGwQwsuPoQ9O5oNT7znKhwlnSaauFMbt5dxsEc2vEcs/6wmLn2+OnBhypLqMQl0oOrGW2lgJRugIaHshaUcB8IL3WT/S5vQNyAMVlMMKJ+MLA7doIqDe3VibqgZrrVv8PaZa9VZiHV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcqUwAv2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725020644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d608LoyObFpK/i0hzP74kClO+W039KnkxuFIsRVX6OI=;
	b=HcqUwAv2fyKunwL9f98oTiLrTX2sXrx0i+De0ZC3hjTRQi3z7Cm03EMJ1PIx+L0s2CHT9X
	MvngNTYisEeFMu6xPqD8pKimqphy1n05CZ3WUnz7Dr3P6SvfjckFMn8gQhVCAY1iabxvEi
	7ILzjvjuNK9rfSXcbDZucHz4exT45u4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-sgxod5vcNbuVZEl3GZkecw-1; Fri,
 30 Aug 2024 08:24:00 -0400
X-MC-Unique: sgxod5vcNbuVZEl3GZkecw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 874981955BED;
	Fri, 30 Aug 2024 12:23:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.148])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EBAB71955F6B;
	Fri, 30 Aug 2024 12:23:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 30 Aug 2024 14:23:50 +0200 (CEST)
Date: Fri, 30 Aug 2024 14:23:44 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tianyi Liu <i.pear@outlook.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Jordan Rome <linux@jordanrome.com>,
	ajor@meta.com
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, flaniel@linux.microsoft.com,
	albancrequy@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240830122344.GA28086@redhat.com>
References: <ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240830101209.GA24733@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830101209.GA24733@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/30, Oleg Nesterov wrote:
>
> 	- This patch won't fix all problems because uprobe_perf_filter()
> 	  filters by mm, not by pid. The changelog/patch assumes that it
> 	  is a "PID filter", but it is not.
>
>	  See https://lore.kernel.org/linux-trace-kernel/20240825224018.GD3906@redhat.com/

Let me provide another example.

spawn.c:

	#include <spawn.h>
	#include <unistd.h>

	int main(int argc, char *argv[])
	{
		int pid;
		sleep(3); // wait for bpftrace to start
		posix_spawn(&pid, argv[1], NULL, NULL, argv+1, NULL);
		for (;;)
			pause();
	}

Now,

	$ ./spawn /usr/bin/true &
	bpftrace -p $! -e 'uprobe:/usr/lib64/libc.so.6:sigprocmask { printf("%d\n", pid); }'
	[2] 212851
	Attaching 1 probe...
	212855
	^C
	$ ./spawn /xxxxxxxxxxxx &
	bpftrace -p $! -e 'uprobe:/usr/lib64/libc.so.6:_exit { printf("%d\n", pid); }'
	[3] 212860
	Attaching 1 probe...
	212865
	^C

This patch can't help in this case.

Oleg.


