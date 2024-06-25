Return-Path: <bpf+bounces-33061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CBA916AE3
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 16:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39251C22ED2
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 14:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216AC16E879;
	Tue, 25 Jun 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/GWEYSZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB416D4C8
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326757; cv=none; b=m7oR08IjDzSvSw2SNEocYcE7m+mzfIJxjFaeJBk1I1qvBlWM4O/bgIMY1CSOQujWGX0Wa/UwexGVhF1uIg7Q30aHIz4Xt7hR03w+7Pdv+9nsTUZ1rR9HFINVFhAfVloJsBp5I7m8kddHKNrRPs6tDDWajo1VwS96vAA8Y5541QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326757; c=relaxed/simple;
	bh=fcUK0z11x4X/G/JqYJIrF976nUZSEtPwTuCSXYlRn4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wss0pt3VtqkXZRbj5oQAhKjfzFEhb/Xb/mG3xgCLY3V006gIBU8oe282txIHKI+WbYmkeJpcFq+SVavcby5wf9pmFAid2UCGNq0hLYpo4t6myyGAL6cEkCTJDXS3H1TxPx/GPCNOIebYqINoCfl8XBjOMCBTRkbLwrMGduURcmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/GWEYSZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719326754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LdWdE9aRa9ajaGrxs2vQdnhx3Rv5rWQKcF4xVyz2uo=;
	b=Z/GWEYSZEl0Up4D+ikriH9z9dI2NWdRYJR7VpREOdRIN1uONEan6FTG26Aeal5Nqgl6XOH
	YGb1hmu7Fy/hFer8TmiHmMgUvPy6QzmSAB9SZpTkNYZtX9RsMVvZu6qdySoYmHPc5u03os
	jxXHmBdXxhgIuSoEdWChuOzKGPXUlRU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-Soxs7XA_OfK6uYm0puIiJQ-1; Tue,
 25 Jun 2024 10:45:49 -0400
X-MC-Unique: Soxs7XA_OfK6uYm0puIiJQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D735519560B8;
	Tue, 25 Jun 2024 14:45:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.198])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3B82E1956087;
	Tue, 25 Jun 2024 14:45:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Jun 2024 16:44:14 +0200 (CEST)
Date: Tue, 25 Jun 2024 16:44:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH 04/12] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240625144409.GA21366@redhat.com>
References: <20240625002144.3485799-1-andrii@kernel.org>
 <20240625002144.3485799-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625002144.3485799-5-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Again, I'll try to read (at least this) patch later this week,
just one cosmetic nit for now...

On 06/24, Andrii Nakryiko wrote:
>
> + * UPROBE_REFCNT_GET constant is chosen such that it will *increment both*
> + * epoch and refcnt parts atomically with one atomic_add().
> + * UPROBE_REFCNT_PUT is chosen such that it will *decrement* refcnt part and
> + * *increment* epoch part.
> + */
> +#define UPROBE_REFCNT_GET ((1LL << 32) | 1LL)
> +#define UPROBE_REFCNT_PUT (0xffffffffLL)

How about

	#define UPROBE_REFCNT_GET ((1ULL << 32) + 1ULL)
	#define UPROBE_REFCNT_PUT ((1ULL << 32) - 1ULL)

? this makes them symmetrical and makes it clear why
atomic64_add(UPROBE_REFCNT_PUT) works as described in the comment.

Feel free to ignore if you don't like it.

Oleg.


