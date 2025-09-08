Return-Path: <bpf+bounces-67700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7BEB48C1D
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 13:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43B21B22DC6
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 11:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE21122A4DB;
	Mon,  8 Sep 2025 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGrw4w5h"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D52264C0
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330839; cv=none; b=CMsDPFSWvHiz0hoUM2KjaDyxcdtnw//aHhab0HRzVd3VasagfRkBJOKcVoEnfaUFp3sENUF5XaohB5cikuNal8RmODyZD6iauGz0aYazYF1J3Q5tASvJz/Rm3IHkPc4o1qwT+YdXo09Uf7I4n03YVRfXVTfguw8K8moYlLQM+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330839; c=relaxed/simple;
	bh=RR//94mPZG5vNioGDRbAJ4bcOodAMEvGvZIWfIfDl0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0Qf38eYjc4e80bNtQwh1k+Sb10genp2AxAHpqIDdKbIg+TWlULj5F0pIKmHHxCaMek9XjqTldgCBgSkpVTCMgi3xVbFTUR99ydcQk+dHtnph3FjlbmZy4RG+q+syw6+Q4kCFOYz2dt4ktmTvyrPoRceezaFbzfUD7JFV4mcKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGrw4w5h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757330836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IzG6xHUZe+gUPgC+juGd9gz+bkD6UX0YlA+R494FhJo=;
	b=HGrw4w5hn7umr8INo5/hd87nuS5G9hP0uDnJhqlnkmwEx/1CcJennw52TBXgB5QrXGji01
	brXMVE+sp1gFq85iA4Se1FGJFndOKse8U+kgccUKAHzjCne5rSI2bXqhlqCX6tJ8Uv2N5E
	3K/23tdRitzB+khNUylEuIt0FzuiDFA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-quJmHg-9Pdmg8_VkifqyKQ-1; Mon,
 08 Sep 2025 07:27:13 -0400
X-MC-Unique: quJmHg-9Pdmg8_VkifqyKQ-1
X-Mimecast-MFC-AGG-ID: quJmHg-9Pdmg8_VkifqyKQ_1757330830
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B4E4180045C;
	Mon,  8 Sep 2025 11:27:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 33E581955F24;
	Mon,  8 Sep 2025 11:27:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  8 Sep 2025 13:25:45 +0200 (CEST)
Date: Mon, 8 Sep 2025 13:25:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
	Alejandro Colomar <alx@kernel.org>
Subject: Re: [PATCH perf/core 1/3] uprobes/x86: Return error from uprobe
 syscall when not called from trampoline
Message-ID: <20250908112536.GA5489@redhat.com>
References: <20250905205731.1961288-1-jolsa@kernel.org>
 <20250905205731.1961288-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905205731.1961288-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/05, Jiri Olsa wrote:
>
> Currently uprobe syscall handles all errors with forcing SIGILL to current
> process. As suggested by Andrii it'd be helpful for uprobe syscall detection
> to return error value for the !in_uprobe_trampoline check.
>
> This way we could just call uprobe syscall and based on return value we will
> find out if the kernel has it.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 0a8c0a4a5423..845aeaf36b8d 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -810,7 +810,7 @@ SYSCALL_DEFINE0(uprobe)
>
>  	/* Allow execution only from uprobe trampolines. */
>  	if (!in_uprobe_trampoline(regs->ip))
> -		goto sigill;
> +		return -ENXIO;

I agree.

Acked-by: Oleg Nesterov <oleg@redhat.com>


