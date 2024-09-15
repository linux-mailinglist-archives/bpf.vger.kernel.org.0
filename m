Return-Path: <bpf+bounces-39941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AF8979750
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 16:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE09281E53
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 14:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E79425570;
	Sun, 15 Sep 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Itjvuiaa"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449A11C6F60
	for <bpf@vger.kernel.org>; Sun, 15 Sep 2024 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726411893; cv=none; b=fHV5TIzXQRs681rZw18jwacmgmFglQULtNL2/dlTR7dp8SGoDIhnLr5WMiVEGnA2KW2RCpxGjrtWfJeuH0oIvsWqbHhkLb2wHPb9bxAhQClJjird8G35NS9SnG02+gWbrt/VfjVsucfx7F4gb7+pYVKzVG33ANxvKj51QtqD2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726411893; c=relaxed/simple;
	bh=61IKgw2qC52n3a3nB/VwWwMfz6qOHu5wCuLz4bbJ358=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmJd7tEuXvzA4tCZEKBRK3EgCUO+Ek+7auSADX/sNzOXgA0ryrNDDHM87QSCrXLhJo3JkwyjJ0qaTIvR8Cy8njO/fVrpL5PnqSFhZIAx6DkJP76Oz5Py+E5pY+sz1ieq8byTxGWEuJI5u6riS36sqmXEyQhFoNm3TErpMzSAZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Itjvuiaa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726411891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=61IKgw2qC52n3a3nB/VwWwMfz6qOHu5wCuLz4bbJ358=;
	b=ItjvuiaarRQiBYBwOkTerKtBZDBz3NdnPN06gEMipUz5TWtPNzlE7v9ZH6WUk/rLPacdZH
	cegy5LCrdHLf39eeI8SRr3TbUiigiCPB83PzQrmhGYe5IfVF/2ppgYyB6/dV42OOxMBbYH
	GdNx5qZGDu1MQzh/UGJFyXLByIFMC/0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-e5BsbMkqM4CKMmvAv7HKxQ-1; Sun,
 15 Sep 2024 10:51:25 -0400
X-MC-Unique: e5BsbMkqM4CKMmvAv7HKxQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 807801955D44;
	Sun, 15 Sep 2024 14:51:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2A6051956086;
	Sun, 15 Sep 2024 14:51:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 15 Sep 2024 16:51:10 +0200 (CEST)
Date: Sun, 15 Sep 2024 16:51:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 3/3] uprobes: implement SRCU-protected lifetime for
 single-stepped uprobe
Message-ID: <20240915145105.GB27726@redhat.com>
References: <20240909224903.3498207-1-andrii@kernel.org>
 <20240909224903.3498207-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909224903.3498207-4-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 09/09, Andrii Nakryiko wrote:
>
> Similarly to how we SRCU-protect uprobe instance (and avoid refcounting
> it unnecessarily) when waiting for return probe hit, use hprobe approach
> to do the same with single-stepped uprobe. Same hprobe_* primitives are
> used. We also reuse ri_timer() callback to expire both pending
> single-step uprobe and return instances.

Well, I still think it would be better (and much simpler) to simply kill
utask->active_uprobe, iirc I even sent the RFC patch...

Oleg.


