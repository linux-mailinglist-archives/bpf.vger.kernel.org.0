Return-Path: <bpf+bounces-38668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DBF9672CC
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 19:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A07A1F22598
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 17:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90177A15B;
	Sat, 31 Aug 2024 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1UWDMVm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5E282FC
	for <bpf@vger.kernel.org>; Sat, 31 Aug 2024 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725125172; cv=none; b=mIzLkivl0yCJHWqKsZpeGTyeC0aCL6HJcvPlyyKZniU+foR9fX2pyoTkvjZOjYT5o/K9ch5lRPUeUSFHHtyZK5P72GmrbN1EwCfU7W5HgGsHc2F/Qp6I8DeLgA4/XfjR4Tb7p0e2jybLcDF5fhhGCdpRadY9O9+a7pn/WgX/1HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725125172; c=relaxed/simple;
	bh=d7TEpslBaognOjT87UdwGdO0JX/BFiDLWGCl1qCtksc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vooq+FO4qDRt2wkkxHaKhhgRrB/pYFiFFiH3FOvRmeJdUcqg+aqRNqMFpmLRRiiduN4zv6WKieXWXuVLimoR7cnDZR7qbMnsUCyqOzU8EBNQUX7z9b+Sv6gg5ftwkvftTg6EOzCwLU/8xDp+dB6q0JrxABlDtfpkACqdHtGycVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1UWDMVm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725125168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JVfJiK+AAnah9BOiQ40UN9PtQCNI2NjuzPzjdt9OXUI=;
	b=F1UWDMVmxClex8pQy83jygqhHO4OQ7DRcHhHj66ui1Df0z7UueDfGGiizLrF3rANDMOCCE
	1y2JQKXs/FnvX+ZEGE3gx7wh7vyqv7Jn9EZJ/P4pydVF+/sOJhETs6H0uLCjpcx0zBGes8
	yFsUStFzS0As97xXlr/wHo2VdRGNwAY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-Nq0PdkgeNV2PWi72YA0zag-1; Sat,
 31 Aug 2024 13:26:02 -0400
X-MC-Unique: Nq0PdkgeNV2PWi72YA0zag-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FF661956080;
	Sat, 31 Aug 2024 17:25:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.49])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 29D041956048;
	Sat, 31 Aug 2024 17:25:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 31 Aug 2024 19:25:50 +0200 (CEST)
Date: Sat, 31 Aug 2024 19:25:44 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, willy@infradead.org, surenb@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 4/8] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <20240831172543.GB9683@redhat.com>
References: <20240829183741.3331213-1-andrii@kernel.org>
 <20240829183741.3331213-5-andrii@kernel.org>
 <ZtD_x9zxLjyhS37Z@krava>
 <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
 <ZtHM_C1NmDSKL0pi@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtHM_C1NmDSKL0pi@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/30, Jiri Olsa wrote:
>
> with this change the probe will not get removed in the attached test,
> it'll get 2 hits, without this change just 1 hit

Thanks again for pointing out the subtle change in behaviour, but could
you add more details for me? ;)

I was going to read the test below today, but no. As I said many times
I know nothing about bpf, I simply can't understand what this test-case
actually do in kernel-space.

According to git grep, the only in kernel user of UPROBE_HANDLER_REMOVE
is uprobe_perf_func(), but if it returns UPROBE_HANDLER_REMOVE then
consumer->filter == uprobe_perf_filter() should return false?

So could you explay how/why exactly this changes affects your test-case?


But perhaps it uses bpf_uprobe_multi_link_attach() and ->handler is
uprobe_multi_link_handler() ? But uprobe_prog_run() returns zero if
current->mm != link->task->mm.

OTOH, otherwise it returns the error code from bpf_prog_run() and this looks
confusing to me. I have no idea what prog->bpf_func(ctx, insnsi) can return
in this case, but note the WARN(rc & ~UPROBE_HANDLER_MASK) in handler_chain...

Hmm... looking at your test-case again,

> +SEC("uprobe.multi//proc/self/exe:uprobe_multi_func_1")
> +int uprobe(struct pt_regs *ctx)
> +{
> +	test++;
> +	return 1;
> +}

So may be this (compiled to ebpf) is what prog->bpf_func() actually executes?
If yes, everything is clear. And this "proves" that the patch makes the current
API less flexible, as I mentioned in my reply to Andrii.

If I got it right, I'd suggest to add a comment into this code to explain
that we return UPROBE_HANDLER_REMOVE after the 1st hit, for git-grep.

Oleg.


