Return-Path: <bpf+bounces-40548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B8E989E88
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 11:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AA41F23684
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C735D188735;
	Mon, 30 Sep 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfU2bYbx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF934188733
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688908; cv=none; b=UgWioH0+g5DNHE6QsBdHkkNJJv+24B2Ap5J001xFhAjhawqd7qEhheyLLP0Oudg/0mwUhIIChXFvSBX01QAee1p4+TKBtGak4yhFGGxQd9efAsFV8L3aW/z6tday7JyLykAtY7TzL1RTGcyLk0FKQODcg/tsQVl/d8UbnnY1QSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688908; c=relaxed/simple;
	bh=yscA1gaN/DnJapmSgPfK3se0S5RkDHatRVMuYJgu550=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=so7Ct75DVi4Q/pS+AAKRJMbcJZ0HbM/CJ2nr14YrW9OIUJvmeo9XGoa1aPJHKAN17y6mlmEbXgVXD3vtJ6N2pbvzKJP5YUZs82LO/4lOMCVIpiJQkIXj5UmDZqPhDzcMqJazS/AKJVVYlfmLvIH5wUqQ3ozaLh0iYuEcmHlJLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YfU2bYbx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727688905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yscA1gaN/DnJapmSgPfK3se0S5RkDHatRVMuYJgu550=;
	b=YfU2bYbxoUk8xwZvsZeM7dp6qAY8+YLFpFxNeFxaMFF6eVdkGxndhRx7ojCH8YtdDdNFr3
	0qnLXROF1yScnKUwluDClDot/fteSP1HXLcyGjQx41gucl/P70lEYVALSxF7Tfbs550siY
	zIF498gn0+FIhBYaqdJ0fZuZtEuWTPA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-D2pozy5EOAazDhbGIcsn_g-1; Mon,
 30 Sep 2024 05:35:03 -0400
X-MC-Unique: D2pozy5EOAazDhbGIcsn_g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3F5318E68CC;
	Mon, 30 Sep 2024 09:35:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C827A3003E4D;
	Mon, 30 Sep 2024 09:34:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 30 Sep 2024 11:34:47 +0200 (CEST)
Date: Mon, 30 Sep 2024 11:34:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv5 bpf-next 01/13] uprobe: Add data pointer to consumer
 handlers
Message-ID: <20240930093440.GA18499@redhat.com>
References: <20240929205717.3813648-1-jolsa@kernel.org>
 <20240929205717.3813648-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929205717.3813648-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/29, Jiri Olsa wrote:
>
> Adding data pointer to both entry and exit consumer handlers and all
> its users. The functionality itself is coming in following change.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Oleg Nesterov <oleg@redhat.com>


