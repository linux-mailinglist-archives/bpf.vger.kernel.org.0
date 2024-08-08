Return-Path: <bpf+bounces-36684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA9C94BFC3
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 16:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB251F22030
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DB018E768;
	Thu,  8 Aug 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUvgXcnb"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9353F1EA90
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128032; cv=none; b=GW7GbaljcSs940UHndSD9SbAInri24r6oiaBoQw02pORTeauZbKlqcKdB0YU/SytKg1q6Z4MahL1ecgA/vmCm6iau8PSTW55iC9YdnWyMFA6/CHAnYzRH1iuNKINqGLDjnNpH1HFbA8kXWG2JFICdak5oec1SJKIKrCbFpsjThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128032; c=relaxed/simple;
	bh=IAcpC0yUr0S8fp2OMIDVu4XVdUAl5xhCver/7xE68Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmOdS8W44CQn1D3mBenQcYN/CSLiSq1mkd0lp/b/YOgeGkhdHGwg2lc9yLNT/9q6G1qFVeW5HCYan++usVsnTpij9HE/op+qhOSPRCEnKJwvuYNUIJN2fuvwzmXyY4z/jT+2RMPTLckXBRxrd8/U/qPGC0MNmmnuVBYykGh1xDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUvgXcnb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723128029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PygIMfTc4oYFST/M6dQiSfvy+yNiOOgfx4Q/j0leG9Y=;
	b=LUvgXcnbgvuHto7CZBuDc278idWIYBqXJjSd+tdh+PeXFhBC5YrndVIuksbXFF+6nWM8/H
	DAo3ukbyBOS5LbAbGuf1F41wePVCl5WMeCq7gqtPwD4LMiSn/3+22j/zwsTywnisBxmqp0
	STXfZM68CrOUk6Ra9WvmhleJGJN7m9U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-uSVS_D2lM7iUSJ3UDPmhMw-1; Thu,
 08 Aug 2024 10:40:22 -0400
X-MC-Unique: uSVS_D2lM7iUSJ3UDPmhMw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36E6619772DA;
	Thu,  8 Aug 2024 14:40:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 941551956052;
	Thu,  8 Aug 2024 14:40:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Aug 2024 16:40:18 +0200 (CEST)
Date: Thu, 8 Aug 2024 16:40:14 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v2 4/6] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <20240808144013.GG8020@redhat.com>
References: <20240808002118.918105-1-andrii@kernel.org>
 <20240808002118.918105-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808002118.918105-5-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/07, Andrii Nakryiko wrote:
>
> @@ -1127,18 +1105,30 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  	int err;
>  
>  	down_write(&uprobe->register_rwsem);
> -	if (WARN_ON(!consumer_del(uprobe, uc))) {
> -		err = -ENOENT;
> -	} else {
> -		err = register_for_each_vma(uprobe, NULL);
> -		/* TODO : cant unregister? schedule a worker thread */
> -		if (unlikely(err))
> -			uprobe_warn(current, "unregister, leaking uprobe");
> -	}
> +
> +	list_del_rcu(&uc->cons_node);
> +	err = register_for_each_vma(uprobe, NULL);
> +
>  	up_write(&uprobe->register_rwsem);
>  
> -	if (!err)
> -		put_uprobe(uprobe);
> +	/* TODO : cant unregister? schedule a worker thread */
> +	if (unlikely(err)) {
> +		uprobe_warn(current, "unregister, leaking uprobe");
> +		return;

Looks wrong... We can (should) skip put_uprobe(), but we can't avoid
synchronize_srcu().

The caller can free the consumer right after return. You even added
a fat comment below.

Yes, the problem will go away after you split it into nosync/sync, but
still.

Oleg.


