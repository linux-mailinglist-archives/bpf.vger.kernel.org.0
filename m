Return-Path: <bpf+bounces-36391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E473947C22
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 15:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0CB28565F
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CC842AA0;
	Mon,  5 Aug 2024 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aeqahg64"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B78381BE
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865476; cv=none; b=lnNYAaF5pluzES2B5SgJPflGUlqrgCExNq8Z7PA8cZm1KZAUgbqoedgCEkBSByEf/sP+A70+9wwyCEfU1q0MflIqk5ntP7a10LlahQsJlOBEa/s3agopdMTf5vRUDkzXKUpdVXmzCvfZnusRgP0gFo6Q7F6Nhz0ZT9D3KIAf8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865476; c=relaxed/simple;
	bh=PI66hrhlN5T6OU7VevTwzxYp0S1w1b9mYvo63Sk6qDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxW27+bKhSivmW2uvZtMw+4Q2DYBXEMUurMaYMiU4skbTJ8LtwgAHh0Num5z9r7QgM3WbH2MZ+g7/wXrBczLDs6oKCG1h/yMEgGiZIc8cWtMf+yK/ccvzyKapxC1iFxjzQ968lIs1LBerjME+MtX5ZhZyCYdwslQZu6P9ECXVA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aeqahg64; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722865473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=slMM8m9qTpPlMHtZj0YMq5nEN8sovoUKAlpfjXtwiuk=;
	b=Aeqahg64tm8cuuDGlhEkoy3vsjcaoA1g/q2gcwFcyxybiJt536VqjKPLMnEYWaIBs3JBTy
	wuFZVf37qKqjtrBtt+UUhlJsDK3tT8T70o107O1SxTpjYEVkUxkkfGekMpLac5Jg6FVfyb
	LvAqIrlg0uuFS3HJWFpfNsvoXJBOktE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-3hlHpkU-NV-uulNCy4HPeA-1; Mon,
 05 Aug 2024 09:44:27 -0400
X-MC-Unique: 3hlHpkU-NV-uulNCy4HPeA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 172DF1955BF7;
	Mon,  5 Aug 2024 13:44:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.34])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5CB0130001A6;
	Mon,  5 Aug 2024 13:44:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  5 Aug 2024 15:44:23 +0200 (CEST)
Date: Mon, 5 Aug 2024 15:44:18 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 2/8] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240805134418.GA11049@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731214256.3588718-3-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/31, Andrii Nakryiko wrote:
>
> @@ -732,11 +776,13 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>  	uprobe->ref_ctr_offset = ref_ctr_offset;
>  	init_rwsem(&uprobe->register_rwsem);
>  	init_rwsem(&uprobe->consumer_rwsem);
> +	RB_CLEAR_NODE(&uprobe->rb_node);

I guess RB_CLEAR_NODE() is not necessary?

> @@ -1286,15 +1296,19 @@ static void build_probe_list(struct inode *inode,
>  			u = rb_entry(t, struct uprobe, rb_node);
>  			if (u->inode != inode || u->offset < min)
>  				break;
> +			u = try_get_uprobe(u);
> +			if (!u) /* uprobe already went away, safe to ignore */
> +				continue;
>  			list_add(&u->pending_list, head);

cosmetic nit, feel to ignore, but to me

			if (try_get_uprobe(u))
				list_add(&u->pending_list, head);

looks more readable.

Other than the lack of kfree() in put_uprobe() and WARN() in _unregister()
the patch looks good to me.

Oleg.


