Return-Path: <bpf+bounces-47032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE839F2DF2
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 11:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F2B162CB8
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 10:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB22202C49;
	Mon, 16 Dec 2024 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9sllbTp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40422036FA
	for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344019; cv=none; b=YHVziTFic463z/L2YPHxJbgEgi5DjJaD++r0Hy4AkE7ml3zt9tIkjh4DDL4d9LRpSHdv7+yiBMT7t39/iGS5hcuV/ujrD93uN6yf9ATJCAPWQq2pkXNmF62rkeqWQm6gA+Y3Z93Q7VQ2KA3ry96/gfiMhPYFu1mvr5PLNmLD2mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344019; c=relaxed/simple;
	bh=MQK+wr+Xv+qZBf/YdEN80HGnJtSnQGXQbvv3yurqpYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ge5074CQN7URSsKH686aOJF2DnsK58l9mBBKRVeLN8vYts6mkKnGNixuH3dbzh17lyPIbVklj8SCalcmi0lkb4UO8n7AGMXpBN8fb3Zn76QqB4UII7r7dkj6+R8vUynlD/gV3M03tsUrWUA6OcEvqgCF9RhD/sBpPJJ1uJDc/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9sllbTp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734344016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQK+wr+Xv+qZBf/YdEN80HGnJtSnQGXQbvv3yurqpYU=;
	b=g9sllbTpOc5UwE+hFAXMq3F1C6YxXnxVJEpVCxNE0IZh9dr+dDMllhmhOB0rAVKpkCRmtJ
	kpuWzxaqjMouKhBKEYcrzo8Z+Itd2q9PzbxUX/lfqFQe89i0KpJfWOATtLIHCZQfPysrom
	u5EFLnxMlZWYuid6pQOobnz7hpdOluo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-QwhyTaoPMDuCud5HOOU3ZQ-1; Mon,
 16 Dec 2024 05:13:30 -0500
X-MC-Unique: QwhyTaoPMDuCud5HOOU3ZQ-1
X-Mimecast-MFC-AGG-ID: QwhyTaoPMDuCud5HOOU3ZQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 572D61955F45;
	Mon, 16 Dec 2024 10:13:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.224])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4E8191956088;
	Mon, 16 Dec 2024 10:13:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 16 Dec 2024 11:13:04 +0100 (CET)
Date: Mon, 16 Dec 2024 11:12:58 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Jiri Olsa' <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 08/13] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <20241216101258.GA374@redhat.com>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-9-jolsa@kernel.org>
 <1521ff93bc0649b0aade9cfc444929ca@AcuMS.aculab.com>
 <20241215141412.GA13580@redhat.com>
 <Z1_gFymfO3sAwhiY@krava>
 <c5fb22629d3f42798def5b63ce834801@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5fb22629d3f42798def5b63ce834801@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

David,

let me say first that my understanding of this magic is very limited,
please correct me.

On 12/16, David Laight wrote:
>
> It all depends on how hard __replace_page() tries to be atomic.
> The page has to change from one backed by the executable to a private
> one backed by swap - otherwise you can't write to it.

This is what uprobe_write_opcode() does,

> But the problems arise when the instruction prefetch unit has read
> part of the 5-byte instruction (it might even only read half a cache
> line at a time).
> I'm not sure how long the pipeline can sit in that state - but I
> can do a memory read of a PCIe address that takes ~3000 clocks.
> (And a misaligned AVX-512 read is probably eight 8-byte transfers.)
>
> So I think you need to force an interrupt while the PTE is invalid.
> And that need to be simultaneous on all cpu running that process.

__replace_page() does ptep_get_and_clear(old_pte) + flush_tlb_page().

That's not enough?

> Stopping the process using ptrace would do it.

Not an option :/

Oleg.


