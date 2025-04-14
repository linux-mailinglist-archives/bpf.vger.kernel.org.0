Return-Path: <bpf+bounces-55859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6092A880E3
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 14:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9896E3B7283
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F70A2BEC3F;
	Mon, 14 Apr 2025 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpblULcw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BBC29C322
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635412; cv=none; b=jGkjJdrtICjV83lCjh6Ssmtuvfd4TzrCNUL+N66HyZimQWbgObEwU31cu0JgE2qk2KZiWKPWm83I6dUXoUVx+28RLmDeVcs2eucbCURifqp4rw9zKDN4YUzOur0FZAVUHwf31zxpGCpqnZf5l6JU7s0U30ouoyOO8ufcLPrcDeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635412; c=relaxed/simple;
	bh=4ndoZIQadw0fx/9dfIwynU9KS2mYw03hR5z3re/dctk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBvBZrUoOXZsSTI3fQJCNlumbeZ2uaq/zO6DERLP0veZ9KIuBsjYSzXcDAgS6LD3nYworO8WoMVcjB1jyepuYHmvVN+KwkjcA3GEyX+cC7KpTepqSSFL2Wr/ANMYKjYgJ1sqyYj2W5BsLtAHtcO1RtumxcfF3sew50Xp5HyKsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZpblULcw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744635407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VMtlMTzc9ePJmlezuKsazNNqLDwaXztNRY4ZPAIEu+4=;
	b=ZpblULcwlTwYtoeDNOeO+Xhm9yOx5P8MXKM/cFJF1FgorGZCXj4ukxUwlfaYVB0ugmmTI5
	kYbynpWFujQHQQLI8u1jur/XlmntSApw+qbJ7Yvsi0naaH9vnTUdbzb0SvbaPG72oRIMvh
	eg8dCi7BgE1TRPTKgvox0g7JoYgOPLw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-HHZHfESfMJSQqcHc6uG-SA-1; Mon,
 14 Apr 2025 08:56:43 -0400
X-MC-Unique: HHZHfESfMJSQqcHc6uG-SA-1
X-Mimecast-MFC-AGG-ID: HHZHfESfMJSQqcHc6uG-SA_1744635401
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 861591955DCC;
	Mon, 14 Apr 2025 12:56:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4B4CB180B487;
	Mon, 14 Apr 2025 12:56:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 14 Apr 2025 14:56:05 +0200 (CEST)
Date: Mon, 14 Apr 2025 14:55:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCHv3 perf/core 1/2] uprobes/x86: Add support to emulate nop
 instructions
Message-ID: <20250414125558.GC28345@redhat.com>
References: <20250414083647.1234007-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414083647.1234007-1-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/14, Jiri Olsa wrote:
>
> @@ -840,6 +840,11 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
>  	insn_byte_t p;
>  	int i;
>  
> +	/* x86_nops[insn->length]; same as jmp with .offs = 0 */
> +	if (insn->length <= ASM_NOP_MAX &&
> +	    !memcmp(insn->kaddr, x86_nops[insn->length], insn->length))
> +		goto setup;

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


