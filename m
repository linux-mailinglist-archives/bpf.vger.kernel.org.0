Return-Path: <bpf+bounces-55731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF1BA85DD8
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 14:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FA34E2B2C
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 12:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A142367B4;
	Fri, 11 Apr 2025 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGYPuUUr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA7B2367A2
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375735; cv=none; b=l8mhDuurGCGVjNM9/oDykB3whR7wlczD0R7hBk3OdR/w2J6jyG8e0/zT+EOBWGIX5n6AaX1ZMC6/tMvKoxFISewc0WAJcvDr33rnHYuWyceb4k/UQsUFkiAdEffjX0jvGXG6wCZa1p/V13IB3VnWbPsLIWACVDFg9HmEYDQoyqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375735; c=relaxed/simple;
	bh=BcC98ws7X2rPc51yx5q6n6PNb7iZ49cCMtEKJk2Evo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqHHl8qW3D3drF6Il1MWxhBcul76pOx+yexq9SPXavcbJO2AQDqRaifUn4/eP15uKjEAoad83KzlnPlTwCwVFn6Fk9mDoM7RGBQQ/O7ROxdiAfKC6gj9jI5Jq8dvcH0+DAl42jLaZzJXVFCd29ylVc5jywScD4l9yrIUGWoN7lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGYPuUUr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744375732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TrutyA31aFwEpX5Hu60jTx9GaJXm6qHgLzII0vBWWqU=;
	b=GGYPuUUrQH4lsjF71N2p13MxMIDjTne51Er8ni1m+BZpi7VDF/g3y3Mt7s3hU8/gkqGe3Z
	XMshT/8OjTkW7TUzZza1rr4ZZs1E17MVBIveKSBZ3cggOXl0uwuqYyDBH+/sdk4Qop7si2
	oeRDU/NvEfTV/V92PMI6+xMBU3ein90=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-9lGNpQCmNfK6zLJmOCGtyA-1; Fri,
 11 Apr 2025 08:48:49 -0400
X-MC-Unique: 9lGNpQCmNfK6zLJmOCGtyA-1
X-Mimecast-MFC-AGG-ID: 9lGNpQCmNfK6zLJmOCGtyA_1744375727
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2E9F180025F;
	Fri, 11 Apr 2025 12:48:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.222])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 714E71956094;
	Fri, 11 Apr 2025 12:48:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 11 Apr 2025 14:48:11 +0200 (CEST)
Date: Fri, 11 Apr 2025 14:48:03 +0200
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
Subject: Re: [PATCHv2 perf/core 1/2] uprobes/x86: Add support to emulate nop
 instructions
Message-ID: <20250411124802.GE5322@redhat.com>
References: <20250411121756.567274-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411121756.567274-1-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 04/11, Jiri Olsa wrote:
>
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -840,6 +840,12 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
>  	insn_byte_t p;
>  	int i;
>
> +	/* x86_nops[i]; same as jmp with .offs = 0 */
> +	for (i = 1; i <= ASM_NOP_MAX; ++i) {
> +		if (!memcmp(insn->kaddr, x86_nops[i], i))
> +			goto setup;
> +	}

Acked-by: Oleg Nesterov <oleg@redhat.com>


