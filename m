Return-Path: <bpf+bounces-36397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9E7947EDF
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 18:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6782F1F231D5
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8244615B552;
	Mon,  5 Aug 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/QhRMEW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DDF15B0FF
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873588; cv=none; b=bNWGHe0sWnwxaveakt5TrqeamitlHyQV1fJJDEGNDKrkvFJAdPttTzC2YdgBCPZbdogp2J1hb0FKZr93yl0D+xZ5/AQk0Mm5h0xDb+2uviCQtDcs5326LDxMB+fk7mx4K3H9eCJOekLRixqb+oKnWbbp0BhasmBC6N+BtMKd0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873588; c=relaxed/simple;
	bh=q73GkdMAUsuhmAurIE+4Rh4oA3WCaPz5k88nx2PWlUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NizR7bj6AosofaHsVBfDczKZrpApKxoQ721DuE2yFT1C8wSQZA0+gqyuvT6hL3RHhAsGrUPwrxXWQdR3eGoNLsREnm1stEQ6wIteoM+41q+s6fYRcMVMZiRU9d2V6iXbY4HjSI7LXqZUpPMVdzDARLJMSHwO3jyqfsFsB96l/ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/QhRMEW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722873585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5WoF7SpMgNw9Tt7F4AdxuqhGssiOGa0SxaZrKFwOpc=;
	b=X/QhRMEWp0vuvCII83THK21MUDy7uc7kxfLGfQts7KG5+E5MjoEAbP3wGO0nztqaERdPwt
	UPDqrbqcgx5Tjwxo6m306PRd2OQWlY2WBXBbCiWBiUP6ueVVxsVQWflCYA/NUWDONOZKEf
	KkVvr/473w7sAdS7KpD07nM4giDWrrg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-MA47QDb7PJSsHtxBMgmnig-1; Mon,
 05 Aug 2024 11:59:40 -0400
X-MC-Unique: MA47QDb7PJSsHtxBMgmnig-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A1B11955D52;
	Mon,  5 Aug 2024 15:59:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.34])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9BA311955D44;
	Mon,  5 Aug 2024 15:59:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  5 Aug 2024 17:59:36 +0200 (CEST)
Date: Mon, 5 Aug 2024 17:59:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 5/8] uprobes: travers uprobe's consumer list locklessly
 under SRCU protection
Message-ID: <20240805155931.GC11049@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-6-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731214256.3588718-6-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/31, Andrii Nakryiko wrote:
>
> @@ -1120,17 +1098,19 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  	int err;
>
>  	down_write(&uprobe->register_rwsem);
> -	if (WARN_ON(!consumer_del(uprobe, uc))) {
> -		err = -ENOENT;

OK, I agree, this should never happen.

But if you remove this check, then

>  int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool add)
>  {
>  	struct uprobe_consumer *con;
> -	int ret = -ENOENT;
> +	int ret = -ENOENT, srcu_idx;
>
>  	down_write(&uprobe->register_rwsem);
> -	for (con = uprobe->consumers; con && con != uc ; con = con->next)
> -		;
> -	if (con)
> -		ret = register_for_each_vma(uprobe, add ? uc : NULL);
> +
> +	srcu_idx = srcu_read_lock(&uprobes_srcu);
> +	list_for_each_entry_srcu(con, &uprobe->consumers, cons_node,
> +				 srcu_read_lock_held(&uprobes_srcu)) {
> +		if (con == uc) {
> +			ret = register_for_each_vma(uprobe, add ? uc : NULL);
> +			break;
> +		}
> +	}

we can probably remove the similar check above?

I mean, why do we need the list_for_each_entry_srcu() above? Is it possible
that uprobe_apply(uprobe, uc) is called when "uc" is not on the ->consumers
list?

At first glance I see no problems in this patch... but you know, my eyes are
already blurring, I'll continue tomorrow and read this patch again.

Oleg.


