Return-Path: <bpf+bounces-39940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D06979749
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 16:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D691C20A63
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 14:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA781C7B6B;
	Sun, 15 Sep 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A63CBJTu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B723B1C6F6E
	for <bpf@vger.kernel.org>; Sun, 15 Sep 2024 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726411776; cv=none; b=IeXcJ5dxDI1/TigEXOF0ffNXif37+B2Nfd8WOQCXmWD+WoeOheZd5i9ECOfx96C5KOIDFGJksthEKx5Kn/B3AQQ0zSJlMZI1RW/SwxSCQv0Aw/gD+Bagw2lgnGZCVu32QI9E3DZREYd0lV6Nq1Wts14/I1gr2ZuYuwcqXaUtr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726411776; c=relaxed/simple;
	bh=sqVpq7WvWnmSd2FBUoOCS2aq1ILQha8H1RSMfI7mCK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evBklgXut+l66M7XGDDGRBf6lLS0f8WU2ex0flbrY21/CY8oT9JUk9NoIrv0umIogzeMv0qP3ZgLbnlXb9tCJr+ZS7hLiM51MoHGHCy+ju6V9agSDCVFj7MAjvwmUGTRbF3GIBw8a6TjiK4vW+EMi4mLA6hfE/6SKkh6Z5uLusE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A63CBJTu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726411773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vz7BVMbbODLF+2QjXXjcIGmDzTcyLOpiRfgDFCrlgg=;
	b=A63CBJTuYKwhCHtcUXlg/G9cBbrKkemAfzcTFnlNM8UXJIzI5AtsV5LHSDvIynVCPxzZwo
	WNxGblIB9wzpcA4Jk+HbHAKFUR41r2Ssgn7Otb6U7kX1SuCtd1IuXUha4ARlMI6dw8N3b2
	VtXVc0RFciUY/8Qb0ltyz193piMkMXk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-CEkhrFAGNzaLAUXrw77nRg-1; Sun,
 15 Sep 2024 10:49:30 -0400
X-MC-Unique: CEkhrFAGNzaLAUXrw77nRg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26E0D1956096;
	Sun, 15 Sep 2024 14:49:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AA34530001AB;
	Sun, 15 Sep 2024 14:49:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 15 Sep 2024 16:49:15 +0200 (CEST)
Date: Sun, 15 Sep 2024 16:49:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 1/3] uprobes: allow put_uprobe() from non-sleepable
 softirq context
Message-ID: <20240915144910.GA27726@redhat.com>
References: <20240909224903.3498207-1-andrii@kernel.org>
 <20240909224903.3498207-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909224903.3498207-2-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/09, Andrii Nakryiko wrote:
>
> Currently put_uprobe() might trigger mutex_lock()/mutex_unlock(), which
> makes it unsuitable to be called from more restricted context like softirq.
>
> Let's make put_uprobe() agnostic to the context in which it is called,
> and use work queue to defer the mutex-protected clean up steps.

...

> +static void uprobe_free_deferred(struct work_struct *work)
> +{
> +	struct uprobe *uprobe = container_of(work, struct uprobe, work);
> +
> +	/*
> +	 * If application munmap(exec_vma) before uprobe_unregister()
> +	 * gets called, we don't get a chance to remove uprobe from
> +	 * delayed_uprobe_list from remove_breakpoint(). Do it here.
> +	 */
> +	mutex_lock(&delayed_uprobe_lock);
> +	delayed_uprobe_remove(uprobe, NULL);
> +	mutex_unlock(&delayed_uprobe_lock);
> +
> +	kfree(uprobe);
> +}
> +
>  static void uprobe_free_rcu(struct rcu_head *rcu)
>  {
>  	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
>
> -	kfree(uprobe);
> +	INIT_WORK(&uprobe->work, uprobe_free_deferred);
> +	schedule_work(&uprobe->work);
>  }

This is still wrong afaics...

If put_uprobe() can be called from softirq (after the next patch), then
put_uprobe() and all other users of uprobes_treelock should use
write_lock_bh/read_lock_bh to avoid the deadlock.

To be honest... I simply can't force myself to even try to read 2/3 ;) I'll
try to do this later, but I am sure I will never like it, sorry.

Oleg.


