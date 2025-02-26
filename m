Return-Path: <bpf+bounces-52635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8CDA45D2F
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 12:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0047D3AA839
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9962221885A;
	Wed, 26 Feb 2025 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cakw7c84"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98F2185B1
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569454; cv=none; b=V1Se1/QShSBs2m2BgcqdwSMYF1edMsMvtNyqC3ukOyeCrLScelt69cS39aNV43uzdnM34BGMoZp45knRu5R+R4YbTv20M6A8IbUxAoIZrC99y89gElpgdePixQRfL9MXu+8t1pcVDauj64LmUbPBr8ywIroos8Kp3l9Kgy1KnRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569454; c=relaxed/simple;
	bh=FO6z9XAnbl99r5mAf5xNI8wGp7r/Mn9K4KKIHeLztyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYpy3WKpfRFhRspJGTqRLcTNRoP2nix2yshDizxbprF+V5hT3mk85WIZpGU4ZSJLNr13ls+kFH/P1XftqhuW+wdASLcd9c7FRzYZTjAL1uypfDIR3djt+nFS2dZifvk00gwNzmGeZBrbAV/zEHD7/g4+pFPREahpFQ/+TN4ku8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cakw7c84; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740569451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zMbwlR55IsYFkSNbcLoRNPldNYhmk+s65IhIsLBnOf8=;
	b=cakw7c84W21ZOtsafY1/wWft7hKiVvSkZIBoPYoB8XgElI5aqAN2hMIjBdSYR/ZtkVmxYi
	9aUScC+jHABFEXtslpVDihlO7Q/CS4nal54+ayYLTKLWnlWvFkLPhiK0q6WBKaFNhLEGSo
	8kL8I03IYZixYbbipXo1ZTipF2vUoNw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-6-MOq10sPNaHoK_XgBLyrA-1; Wed,
 26 Feb 2025 06:30:45 -0500
X-MC-Unique: 6-MOq10sPNaHoK_XgBLyrA-1
X-Mimecast-MFC-AGG-ID: 6-MOq10sPNaHoK_XgBLyrA_1740569444
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09A6818EB2C9;
	Wed, 26 Feb 2025 11:30:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8411C180087F;
	Wed, 26 Feb 2025 11:30:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Feb 2025 12:30:13 +0100 (CET)
Date: Wed, 26 Feb 2025 12:30:09 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	jolsa@kernel.org, kernel-team@meta.com,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH perf/core] uprobes: remove too strict lockdep_assert()
 condition in hprobe_expire()
Message-ID: <20250226113008.GA8995@redhat.com>
References: <20250225223214.2970740-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225223214.2970740-1-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/25, Andrii Nakryiko wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -762,10 +762,14 @@ static struct uprobe *hprobe_expire(struct hprobe *hprobe, bool get)
>  	enum hprobe_state hstate;
>
>  	/*
> -	 * return_instance's hprobe is protected by RCU.
> -	 * Underlying uprobe is itself protected from reuse by SRCU.
> +	 * Caller should guarantee that return_instance is not going to be
> +	 * freed from under us. This can be achieved either through holding
> +	 * rcu_read_lock() or by owning return_instance in the first place.
> +	 *
> +	 * Underlying uprobe is itself protected from reuse by SRCU, so ensure
> +	 * SRCU lock is held properly.
>  	 */
> -	lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&uretprobes_srcu));
> +	lockdep_assert(srcu_read_lock_held(&uretprobes_srcu));

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


