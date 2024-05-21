Return-Path: <bpf+bounces-30117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA778CB062
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 16:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8FF1B26812
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 14:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301161304A9;
	Tue, 21 May 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eanynEOK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540C5130499
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301482; cv=none; b=SIKUfYliamFPiSSNuGhpoVpPMEmuTrD6oD5wcLtrxCkcoIhIbqRTENcfDcktj4CEeg4cMNrHqLTLK6tE5s5Jny41h/J0XxI0eYc8luxVCSAv4sPWX/dA9i1pvBZRGPHUKS3E8eY4EBRwHOMAfTs0oYIgq3k+2hGI7f8qAf36N0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301482; c=relaxed/simple;
	bh=ecwQ1WESfS0Bg99iSTlfh+kjjj2JtCaqcwh6YNrIDzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USKWs+MOkACdXcsc48WK5R8dNqYmFWiXTn/6hNcF+VX85TgZuToFYAlceYkWLSjhN5uUywJFL/dX6aXjkzMZkn9LW87GIey3ETauuX9x2eOV7lGmsz63tdTks+OIQzB6GEK0ppScBYrYOKZ1APpoTSrhyHrTQ6dr38nRIihNqq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eanynEOK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716301480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h51fvV2Q63ftj3Ef8Qq5geaM49/S6D9fR9Vo3faaDr8=;
	b=eanynEOKVXGlZdFcaukCyrNpMqUmBdturCvzYhH9Y8biNZxSroqk5bJR6B0F4xkx0vp17A
	aAgXoN+XZNsIhEmtAgm3qQgAIF/apWJHI/WHv6ncanZ+f1o0DDcafRdsXf/lC583SB/4LK
	Z8z+A7zTxFK99eDPolk2plVo6xQR15c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-guMog13wMtOg8Q3jV0IpxA-1; Tue, 21 May 2024 10:24:38 -0400
X-MC-Unique: guMog13wMtOg8Q3jV0IpxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08252101A551;
	Tue, 21 May 2024 14:24:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.64])
	by smtp.corp.redhat.com (Postfix) with SMTP id 4867E103A3AF;
	Tue, 21 May 2024 14:24:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 21 May 2024 16:23:11 +0200 (CEST)
Date: Tue, 21 May 2024 16:23:08 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org, jolsa@kernel.org,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] uprobes: prevent mutex_lock() under rcu_read_lock()
Message-ID: <20240521142308.GB19434@redhat.com>
References: <20240521053017.3708530-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521053017.3708530-1-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 05/20, Andrii Nakryiko wrote:
>
> Fixes: 1b8f85defbc8 ("uprobes: prepare uprobe args buffer lazily")
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/trace/trace_uprobe.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


