Return-Path: <bpf+bounces-48397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A329A0791C
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 15:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA8E7A3344
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 14:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59CA21A438;
	Thu,  9 Jan 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GA+HHG1e"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085F14EC77
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432712; cv=none; b=EtuhNtX3zDcMfGXdBOapqXg2kg50+FCtp4jVapFoKded0VQmmqoQbNPFEmzfi29MiDz3zlAb2YwJB5OJz/KsNjdYw0NriK324qaNPeA/9s6EoU1O1S0+gxvA9SFc/wxtguXH3WreiZV2cDzN3DmS0fqUiQf6h6kihtPGtZMYUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432712; c=relaxed/simple;
	bh=toDOfdT/dLLxxneMaOhjxbgIjQyaRYqQq8Kg/40SKto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dib3MQacsxGfdXUxe+SlGOw1/BFFQCBdi2AOc0/hMnYzyGBO0YfuUXFhQN5fE82QSj3cD5niwP5Yg0VT1HByLDMrCx+FJEWyAHoxUlYMsIP2DPWaKotsP9hFrT/X8HWlygaITEyRVMkCLdq8+WxTV1gHhLJcd3tyCgCaW7/mzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GA+HHG1e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736432710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6TQ+MRlGX4zoVa4E9hEX0jIlbvnXvUvfeYr2R+u5ruo=;
	b=GA+HHG1eF964nkbEmGTbYRgEZEAyIhmpGG6owl4SMzA5olHxLsas+Bp0q2txZP9FUrXPF8
	DqGTrX54mpWJJueRykFew/EBdYq0i0z+W4CDQQNGWPfremz8QQWvLDDrpAyS0dke3oD9JM
	OnYdIgCMy7a1D8+xQ8P1D9gE1BfmCDo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-_xap2Xl0OAKARNgrQ8yOhg-1; Thu,
 09 Jan 2025 09:25:07 -0500
X-MC-Unique: _xap2Xl0OAKARNgrQ8yOhg-1
X-Mimecast-MFC-AGG-ID: _xap2Xl0OAKARNgrQ8yOhg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 483C619560B8;
	Thu,  9 Jan 2025 14:25:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.245])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 44721195E3D9;
	Thu,  9 Jan 2025 14:25:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  9 Jan 2025 15:24:40 +0100 (CET)
Date: Thu, 9 Jan 2025 15:24:35 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Max Makarov <maxpain@linux.com>, bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: Fix race in uprobe_free_utask
Message-ID: <20250109142434.GD26424@redhat.com>
References: <20250109141440.2692173-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109141440.2692173-1-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 01/09, Jiri Olsa wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1915,6 +1915,7 @@ void uprobe_free_utask(struct task_struct *t)
>  	if (!utask)
>  		return;
>
> +	t->utask = NULL;
>  	WARN_ON_ONCE(utask->active_uprobe || utask->xol_vaddr);
>
>  	timer_delete_sync(&utask->ri_timer);
> @@ -1924,7 +1925,6 @@ void uprobe_free_utask(struct task_struct *t)
>  		ri = free_ret_instance(ri, true /* cleanup_hprobe */);
>
>  	kfree(utask);
> -	t->utask = NULL;

Acked-by: Oleg Nesterov <oleg@redhat.com>


