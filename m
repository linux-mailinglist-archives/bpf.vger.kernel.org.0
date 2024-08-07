Return-Path: <bpf+bounces-36618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8467494B04F
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 21:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7EF1F23726
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A86A14386B;
	Wed,  7 Aug 2024 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2AG/jLs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411596F30E
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057892; cv=none; b=XUPrCJ3i5a0u7wnJuJJ3E5nOmlR59QrYteisMFSBbiOtzgogDS8ehLW0AnKiNy7vxXCSzMLq0+wppBjs/cuCuhcO1M9C9SfzDnirSA2RpYykTlFV06DO84qCs2rVIZ2DSZUuy8lLTjLLHEaFeHbrN76u2G10jsI/OZv404EVXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057892; c=relaxed/simple;
	bh=boXeYOgmsSI7jQLPP3rC9V5QHVs6M7/EC/tK6josOQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyE2/UPJ3GXcWxzqbsm30gdVLFBj4n+708mi8FXPFnaQOoglnu2TX+pPJ6HMrxmrZeAzNd2EI4dYEayAh7jtrcclGUTrb6CefIJsERoJpIIx6RfWTiQi7n2IPgZUYkOLbLUtpjUlAVVm5qkkzyd9lT0u/2RSRS7OHVTzFj1V7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2AG/jLs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723057888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pJygTm4A1Krh0SDaiBDWtmj5UAGZGfoNSdvtHXlv38I=;
	b=X2AG/jLseGLl5L7KSfpEMls19j2pWEB0K3t7Kxbhj0y1xMBgc+mcdd1j5pForhqN0fuUjb
	gEjK+jBuOHrKYxs1G4s4rlgM6F3uo2gfJaXfMm/jrOw8oIsgNbpz+newcTJYwQBORoPJp5
	P8vmv8H8mFkYodPqt7LwRFtpgaViy3c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-a8dQgaBMNuKkAzi5nzscvw-1; Wed,
 07 Aug 2024 15:11:24 -0400
X-MC-Unique: a8dQgaBMNuKkAzi5nzscvw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC2DE1944B2F;
	Wed,  7 Aug 2024 19:11:19 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.33.13])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A52319560A3;
	Wed,  7 Aug 2024 19:11:10 +0000 (UTC)
Date: Wed, 7 Aug 2024 15:11:08 -0400
From: Phil Auld <pauld@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 09/30] sched_ext: Implement BPF extensible scheduler class
Message-ID: <20240807191004.GB47824@pauld.westford.csb>
References: <20240618212056.2833381-1-tj@kernel.org>
 <20240618212056.2833381-10-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618212056.2833381-10-tj@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Tejun,

On Tue, Jun 18, 2024 at 11:17:24AM -1000 Tejun Heo wrote:
> Implement a new scheduler class sched_ext (SCX), which allows scheduling
> policies to be implemented as BPF programs to achieve the following:
> 

I looks like this is slated for v6.12 now?  That would be good. My initial
experimentation with scx has been positive.

I just picked one email, not completely randomly.

> - Both enable and disable paths are a bit complicated. The enable path
>   switches all tasks without blocking to avoid issues which can arise from
>   partially switched states (e.g. the switching task itself being starved).
>   The disable path can't trust the BPF scheduler at all, so it also has to
>   guarantee forward progress without blocking. See scx_ops_enable() and
>   scx_ops_disable_workfn().

I think, from a supportability point of view, there needs to be a pr_info, at least,
in each of these places, enable and disable, with the name of the scx scheduler. It
looks like there is at least a pr_error for when one gets ejected due to misbehavior.
But there needs to be a record of when such is loaded and unloaded.


Thoughts?


Cheers,
Phil




