Return-Path: <bpf+bounces-41811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B534B99B1FC
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 10:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7395E282836
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 08:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773151448F2;
	Sat, 12 Oct 2024 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWj5M9fB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E5C137742
	for <bpf@vger.kernel.org>; Sat, 12 Oct 2024 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728720519; cv=none; b=JuQk6TnUf9/TaRCZVyHMTclLljDiUDfu+INiKLt9YPb13/IbpaXOQXKoCVnL8NHZLuvCUzUgCw9+GzBEfkSozdoBiLs7ANGgsRkrdDACJjxhfE/aPB2zZumR/zE65J/zZ6awChwphhZN5s88QAHfJNns9WC+zxbpf3qljMkIHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728720519; c=relaxed/simple;
	bh=+662Nqn05brFni8K4FmaOmVPV12ZcVS2MPNDRPrZdLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kib9+hnMZR20dXCwhHlzzfsSITAeSStaJSLa8bLccAEeMREK0WuBmj+HsGTxwfJCA7ZwXFps+vpu6naWGtp6r+bev60UGS7ClyizQpkzHjP0pUPxX4NIBvg3G/r2WxAVjEj+OL8KOujomcQjsDV62ewcdd3zpFHm0KS8kzW+/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWj5M9fB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728720516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CPK9aJLtYxWcNZ87x/vwtTK8ResMtxOxLzaOKNA/rkQ=;
	b=YWj5M9fB7c6s9vBEAM489uwvbfHsa0jXuRXEqCeBV220417WK6GWGESyRKc+zr5xki5QMW
	8qeJdQby7aZheif4HUTFnUHqIiPI9rl5/RGEXR7o4JvB2JFPZoY7mUP7mGC/X49mMnr+96
	QOUAb+e1nlOmuv0plUSXbTy837222Gk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-XxzSXZg1NcShQ_uObO8D2g-1; Sat,
 12 Oct 2024 04:08:33 -0400
X-MC-Unique: XxzSXZg1NcShQ_uObO8D2g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1791119560A5;
	Sat, 12 Oct 2024 08:08:29 +0000 (UTC)
Received: from f39 (unknown [10.39.192.36])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8647B19560AA;
	Sat, 12 Oct 2024 08:08:20 +0000 (UTC)
Date: Sat, 12 Oct 2024 10:08:15 +0200
From: Eder Zulian <ezulian@redhat.com>
To: Sam James <sam@gentoo.org>
Cc: acme@redhat.com, andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
	song@kernel.org, vmalik@redhat.com, williams@redhat.com,
	yonghong.song@linux.dev,
	Michael =?iso-8859-1?Q?Wei=DF?= <michael.weiss@aisec.fraunhofer.de>
Subject: Re: [PATCH] tools/resolve_btfids: Fix 'variable' may be used
 uninitialized warnings
Message-ID: <Zwoub8GniNhTF1gu@f39>
References: <20241011200005.1422103-1-ezulian@redhat.com>
 <87frp2yn2y.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frp2yn2y.fsf@gentoo.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Sam, thank you for pointing it out.

On Sat, Oct 12, 2024 at 05:14:29AM +0100, Sam James wrote:
> The parse-options change was sent before as
> https://lore.kernel.org/all/20240731085217.94928-1-michael.weiss@aisec.fraunhofer.de/

Sorry, I missed Michael's patch.
My suggestion is to initialize 'o' to NULL instead. An illegal dereferencing
(if any) would then be evident.

> but seems to have fallen through the cracks.
> 
> 
Would it be better to revert this part and wait a bit for Michael's patch to
be merged, please let me know.

Thank you,
Eder


