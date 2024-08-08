Return-Path: <bpf+bounces-36674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CEB94BABF
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 12:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0309C1F22A6A
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7209C189F5A;
	Thu,  8 Aug 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyEiuTHl"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ABC13AA31
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112439; cv=none; b=l7ALZaP8D1cRRWLy2pxtemZlssNiM7mEylBEnQnnlnzxU06DyY9nnTsLYOzTwIlVc85E9UhuwDFfNAJxz1LJxLI61IoKL9twNINnYDDZukXVdhwMUEBa7JU18S8EURT2HXODA6eK/tTpsniazaa1A0zNMUw6W8HAE1B/bSc0TEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112439; c=relaxed/simple;
	bh=XA6msLAalFDG53O7VycsxBNdgxojM6SoSZHKhFY5HAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWH96BslRta3TaiGjBSa/67GBUYMAdWOGz0gM89SaPMifTRRiS0uI7k34Ii2X//Oc7FG/ee2SXduRSfLL/HyVFjTCZ5s6iHhhRDRkEijkRMhPdlrKUPxS6fuhzT+5niCSB06DGiNMLo7nTyzscc8P5tRrLglsH7X171i7IjlLT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iyEiuTHl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723112436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kz5tvfbuJug1Gjwv0g51A2yt8RkgSDubr+mCOYre+M8=;
	b=iyEiuTHllyEmo8md25L6sWl9ZAHKuSopGVA0ioXfYP4L/1W5M0yadn81qv10GD4UP0c3h/
	VEMvg+E0QJy5Pjpwhz5a+2rZLcVfG2avts2/mLsjPphMqYSZL5CDfls9lgh1jb6S8+gnCg
	yvUk8xmLs6MZ736daQpTAkWGMypYeb0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-wU_2d9EXOpubd-dTS5uibw-1; Thu,
 08 Aug 2024 06:20:31 -0400
X-MC-Unique: wU_2d9EXOpubd-dTS5uibw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2D75195608B;
	Thu,  8 Aug 2024 10:20:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.189])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1BF951955F35;
	Thu,  8 Aug 2024 10:20:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Aug 2024 12:20:28 +0200 (CEST)
Date: Thu, 8 Aug 2024 12:20:23 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v2 2/6] uprobes: protected uprobe lifetime with SRCU
Message-ID: <20240808102022.GB8020@redhat.com>
References: <20240808002118.918105-1-andrii@kernel.org>
 <20240808002118.918105-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808002118.918105-3-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/07, Andrii Nakryiko wrote:
>
>  struct uprobe {
> -	struct rb_node		rb_node;	/* node in the rb tree */
> +	union {
> +		struct rb_node		rb_node;	/* node in the rb tree */
> +		struct rcu_head		rcu;		/* mutually exclusive with rb_node */

Andrii, I am sorry.

I suggested this in reply to 3/8 before I read
[PATCH 7/8] uprobes: perform lockless SRCU-protected uprobes_tree lookup

I have no idea if rb_erase() is rcu-safe or not, but this union certainly
doesn't look right if we use rb_find_rcu/etc.

Yes, this version doesn't include the SRCU-protected uprobes_tree changes,
but still...

Oleg.


