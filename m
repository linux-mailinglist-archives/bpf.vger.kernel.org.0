Return-Path: <bpf+bounces-55352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DB2A7C499
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 22:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDEDD7A8BF0
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 20:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E32F221F14;
	Fri,  4 Apr 2025 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpZrk2wO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A45219A70
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743797081; cv=none; b=dJvmbUrJTaCbSwW2YteJdixCf0ofUiqX+k3zr0Csn+wJ5SZEzcmvOwdCqcH1z5j2mOugfA4oYA7ztek18jlUXmzk4VnwnJ/ck9y8lSMx1kgLpN/RkYKPu9F2Iy5E6JkEI9Tg853MBz2ejps/JNXevYfSXqBujT6le/LlDEdkAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743797081; c=relaxed/simple;
	bh=IvhhTUIiW/q5zcRrtTNnMYdCLxAmDvUAWeXeyHuVrZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7ezSXF9nNDk4WfQWSZQVK2PeZAbUmghnKE1wstSRliK7xZ6gCOM0uiqihbJSvXqpf0xEzwunLO3O/gJNzv6VRP+xL9cx1C/eG8bc0hfnym4fAiq02zE1XfdCFCbEDnobHS27zFi6epaSxaQzKunIvBFCjmHQfyzXiqrb/4iJRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WpZrk2wO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743797079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IvhhTUIiW/q5zcRrtTNnMYdCLxAmDvUAWeXeyHuVrZk=;
	b=WpZrk2wOsraCuPF5qNVIask4xGXk+XgkEUOPZ+ID7Dxxa0kGW31tW65SqsP9Clw/fSgGBb
	Cm3XLW7LHdtHzTCp68m4nztV7FLcnlEUkK/5RxSJ00wE/+KC/t8bX1E20DZmV2aabuJ/Fx
	bNjo6/Aa/BpYYeSGmQQ13XRCnHWYjHI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-_AB5LUwCNciRrLpL4MbUMw-1; Fri,
 04 Apr 2025 16:04:34 -0400
X-MC-Unique: _AB5LUwCNciRrLpL4MbUMw-1
X-Mimecast-MFC-AGG-ID: _AB5LUwCNciRrLpL4MbUMw_1743797072
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 504C819560B8;
	Fri,  4 Apr 2025 20:04:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.144])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1B9D71809B74;
	Fri,  4 Apr 2025 20:04:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  4 Apr 2025 22:03:57 +0200 (CEST)
Date: Fri, 4 Apr 2025 22:03:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bigeasy@linutronix.de, ast@kernel.org
Subject: Re: [PATCH v2 tip/perf] uprobes: avoid false lockdep splat in uprobe
 timer callback
Message-ID: <20250404200351.GI3720@redhat.com>
References: <20250404194848.2109539-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404194848.2109539-1-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 04/04, Andrii Nakryiko wrote:
>
> Also, point out in the comments more explicitly why we use seqcount
> despite our reader side being rather simple and never retrying. We favor
> well-maintained kernel primitive in favor of open-coding our own memory
> barriers.
>
> Link: https://lore.kernel.org/bpf/CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com/
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Suggested-by: Sebastian Siewior <bigeasy@linutronix.de>
> Fixes: 8622e45b5da1 ("uprobes: Reuse return_instances between multiple uretprobes within task")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

LGTM. FWIW,

Acked-by: Oleg Nesterov <oleg@redhat.com>


