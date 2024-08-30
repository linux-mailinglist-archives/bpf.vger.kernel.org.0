Return-Path: <bpf+bounces-38559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4991996643D
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56F7B22C49
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D53E1B251C;
	Fri, 30 Aug 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLyHPuAl"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DE512F59C
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028397; cv=none; b=hRKpVxbvUSXuAlv6R2PYWWdWPZvGijHJWOGVkj7gTH6WHP21KhsZ9wI1f5o9aA+OWjMQlAjqM1GoK+feA6vxOBt+whCmblom3gK4S6ZWFbizSYHpdBFRMPrE3MgqSzHzgQpSmntWX5UhHwabjLeRHycSl9lhyE9fCgPurj1aDkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028397; c=relaxed/simple;
	bh=Cdrs9lyTXnUfkn8WkxXokR606qv5rn+vUk9l2phbnIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loydd6cXzCy/7c00+VL0/dXhJe3a1r1U+BUtSrUSjKeKabJ1OIKMIMEwarmMSoy3FWkAnRAMFfiKY3tByKzph0AqD6hlw9j5Q33V473xdiqwBTzJjikwKJKmzQkZxByhcW5eu80znMPndDUQ/cBrXuwVwrq8ozeei36ULyRZiUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLyHPuAl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725028394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cdrs9lyTXnUfkn8WkxXokR606qv5rn+vUk9l2phbnIM=;
	b=VLyHPuAlDTnAq2X7jpmYCSIbyccA6mV2Ob6+fUynwbORTLyy5NF38NBW8dZunDTKjaesfG
	E7rQ07AOaQegIH7PiLyJ2+5YT49DUKQYKNKOLKTfUcL0z0LJIxTwG1IX/ScO12nj+tFnf7
	g+30aTQJh/8rjD9Y3p1D4qCQaEXrZZU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-7oYBhr9PPP66Lp4ib6DiPA-1; Fri,
 30 Aug 2024 10:33:10 -0400
X-MC-Unique: 7oYBhr9PPP66Lp4ib6DiPA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EFCA1955D58;
	Fri, 30 Aug 2024 14:33:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.148])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6EFD819560AE;
	Fri, 30 Aug 2024 14:33:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 30 Aug 2024 16:32:58 +0200 (CEST)
Date: Fri, 30 Aug 2024 16:31:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 4/8] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <20240830143151.GC20163@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/30, Jiri Olsa wrote:
>
> with this change the probe will not get removed in the attached test,
> it'll get 2 hits, without this change just 1 hit

I don't understand the code in tools/...bpf../ at all, can't comment,

> but I'm not sure it's a big problem, because seems like that's not the
> intended way the removal should be used anyway, as explained by Oleg [1]

It seems that I confused you again ;)

No, I think you found a problem. UPROBE_HANDLER_REMOVE can be lost if
uc->filter == NULL of if it returns true. See another reply I sent a
minute ago.

I think the fix is simple, plus we need to cleanup this logic anyway,
I'll try to send some code on Monday.

Oleg.


