Return-Path: <bpf+bounces-75385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 901A2C820BB
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 19:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C99C4E79DD
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC093195FF;
	Mon, 24 Nov 2025 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxZDvEgv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30423315764
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007979; cv=none; b=OhNI0eLpKDAsseLb+qoE2vw/zwg0DshHlfknePRsD3mdgsq9NnzDTTJz5BRdsKUo/50G7DspZ0T5UG+EZtFw6Ra0XWPXuOMJUGw9E9Z5w8/WjdJVG7fe6qrdJ36ytTllQScdYcOxYEwB3JtoPmafmtl4B1RjE5kJPYxkSiOahTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007979; c=relaxed/simple;
	bh=5g5/iWn3yywlqRlYWAN4TF0WePP/0uXD2Y2Hmf4MdrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeutbirMvYc5tneZj4NoUXSoodFQA3wncRIlReM/NnY6NJzAI64BCMv/fD87DpTSynSEKl+5nfv4U6FivuWgoy2PKBhvXP8KNIwpxfvA2yk67/6ieF5qLl9x1zmNhmgTjst5ECa78tT8JzT8U2OFGdJB2ZqN79spfUfQd0O1bAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxZDvEgv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764007977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5TjrlExZGDwZBDl59ofAP8W7CKBj8tBArhg9v+rJyqM=;
	b=QxZDvEgvM8WeBiyNjnO1RzRrukqVgA8X+9Qyr1Pw8g3W54ESNDzJeeoShH7pwym0PQNIXe
	inUVBzPIZEU/avCJ08atvZM/J995AiMWpSwjc9HlJfgoyqKJWYI/Ts5pGXa9eb1dYDSM/d
	XU7FmdXs90b59ZSeK1oayLQLq1VmeBA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-dCiO9QzWPpK2l0k8K9W3oA-1; Mon,
 24 Nov 2025 13:12:51 -0500
X-MC-Unique: dCiO9QzWPpK2l0k8K9W3oA-1
X-Mimecast-MFC-AGG-ID: dCiO9QzWPpK2l0k8K9W3oA_1764007969
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7927319560B0;
	Mon, 24 Nov 2025 18:12:49 +0000 (UTC)
Received: from fedora (unknown [10.45.224.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2416218004A3;
	Mon, 24 Nov 2025 18:12:43 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 24 Nov 2025 19:12:49 +0100 (CET)
Date: Mon, 24 Nov 2025 19:12:42 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>
Subject: Re: [RFC PATCH 0/8] uprobe/x86: Add support to optimize prologue
Message-ID: <aSSgGu8X04XoYN8D@redhat.com>
References: <20251117124057.687384-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117124057.687384-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 11/17, Jiri Olsa wrote:
>
> This patchset adds support to optimize uprobe on top of instruction
> that could be emulated and also adds support to emulate particular
> versions of mov and sub instructions to cover some of the user space
> functions prologues, like:
>
>   pushq %rbp
>   movq  %rsp,%rbp
>   subq  $0xb0,%rsp

...

> There's an additional issue that single instruction replacement does
> not have and it's the possibility of the user space code to jump in the
> middle of those 5 bytes. I think it's unlikely to happen at the function
> prologue, but uprobe could be placed anywhere. I'm not sure how to
> mitigate this other than having some enable/disable switch or config
> option, which is unfortunate.

plus this breaks single-stepping... Although perhaps we don't really care.

Oleg.


