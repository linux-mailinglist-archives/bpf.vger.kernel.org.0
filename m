Return-Path: <bpf+bounces-64959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 669C1B18DF6
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 12:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523951AA0A34
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 10:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D382220F25;
	Sat,  2 Aug 2025 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErExNi2l"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C239E1E98E6
	for <bpf@vger.kernel.org>; Sat,  2 Aug 2025 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754130953; cv=none; b=qOCjs6elLufHmqyVNvTZEnh/InDo9GWXYHTxU6siooBua7q/p0qpYkR+JMI8RBDy5cc6T6X//DOKzMd8qwuH6QWRP2w08fUy8Wff7mnEYySgpu8BezfVqH3oZonx4da476ovmc+aJv90upIvpVoonbi1sAVcpeTGNKr4xbbrtx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754130953; c=relaxed/simple;
	bh=1Uj13WzecZIDJ4INt1Rw447b+I7X9TTWD1JGhKjVzXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0zwX5ACHJzQoSri4uqEjlYgozZBOdowCU/NYq+ZhP+n3fjJPPVp7hpyBKihjG28yuvqJFNU9s8gS7hwoitGujGX/9hD2GXByR5scVatz8oq5iF68fHq9Vv8KorH1piDhoTEHmjpZu98KMbODxct/sFAl1c+YHN8A/y5l2VGCPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErExNi2l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754130950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDacmucnw23kEnOX8217Q3tfUEPnn76onGyj7DcVKiI=;
	b=ErExNi2lsT4s0d0+SFisyplFkGQe7PSdsnT3yakJo8qw7uER+E+O5/bUeHwIbqQ/7oPRLY
	/F9DnEMIUcgCpPIun+kJja5SeR7kK51eL+U1GA870GaZix+SAPMrSjBQzau3chs7HanJSC
	ng6VkxjW03CVL2Zo+WaeGLQ3pjRQ7x4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-QpngofaIPa6G3Qs7PgEIZA-1; Sat,
 02 Aug 2025 06:35:46 -0400
X-MC-Unique: QpngofaIPa6G3Qs7PgEIZA-1
X-Mimecast-MFC-AGG-ID: QpngofaIPa6G3Qs7PgEIZA_1754130944
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 643FB180045B;
	Sat,  2 Aug 2025 10:35:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.25])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 38D8719373D9;
	Sat,  2 Aug 2025 10:35:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  2 Aug 2025 12:34:33 +0200 (CEST)
Date: Sat, 2 Aug 2025 12:34:27 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC 1/4] uprobe: Do not emulate/sstep original instruction when
 ip is changed
Message-ID: <20250802103426.GC31711@redhat.com>
References: <20250801210238.2207429-1-jolsa@kernel.org>
 <20250801210238.2207429-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801210238.2207429-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/01, Jiri Olsa wrote:
>
> If uprobe handler changes instruction pointer we still execute single
> step) or emulate the original instruction and increment the (new) ip
> with its length.

Yes... but what if we there are multiple consumers? The 1st one changes
instruction_pointer, the next is unaware. Or it may change regs->ip too...

Oleg.

> This makes the new instruction pointer bogus and application will
> likely crash on illegal instruction execution.
> 
> If user decided to take execution elsewhere, it makes little sense
> to execute the original instruction, so let's skip it.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/events/uprobes.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4c965ba77f9f..dff5509cde67 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2742,6 +2742,9 @@ static void handle_swbp(struct pt_regs *regs)
>  
>  	handler_chain(uprobe, regs);
>  
> +	if (instruction_pointer(regs) != bp_vaddr)
> +		goto out;
> +
>  	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
>  		goto out;
>  
> -- 
> 2.50.1
> 


