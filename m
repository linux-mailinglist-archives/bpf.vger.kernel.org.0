Return-Path: <bpf+bounces-55171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB707A79385
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 18:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8D41892801
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 16:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434F9192B95;
	Wed,  2 Apr 2025 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCoeYsE9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DC4192B75
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743613111; cv=none; b=jOI4q3MtGvfiG4dtslFlZllbHkF/QCrK3u9f0/EuDGOxZ+IHQii+ObhdYwrC3dT0t8XtsPYIGdNLw9Vhddcc+h8boxiGqwB6A1RNBRVNsAmZnt9JCPu5xLFt9Yos4qAJtIEANTWQwkTXHbXpHpzyNyCHRBgEr05KW7upP0X1Hkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743613111; c=relaxed/simple;
	bh=O47k8Zz7R8rcTrtY8Tt6whxOuLcGsKRKWG6x1Vu5tMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gq/ivWfKCTQd2gtcZuTE5vhMQEA5TIZLjdwk3sGxs93Nu6/TKtUBh5djf0c6NO9rNyt51jgLDUV2P5opPmxWWNpzca0SivuCn8HKb51H2nZiTQQAeuZ7wi6hVGNn8dyV4L2XV56JExI7iL677tup11paIWc/u/49ST0Z1wgIawM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZCoeYsE9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743613108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O47k8Zz7R8rcTrtY8Tt6whxOuLcGsKRKWG6x1Vu5tMQ=;
	b=ZCoeYsE9tX5MNcG+NkAaQ7pVN55/1ZG295kmcyksmHwA+arxkOITG1DmCHla2o4en9iaRx
	THTzv0oa9s2HGmtGR43rvxS9KNTyzA+tt/I5hREcgeqaP8e2UQxbJlsjN9iwLYNsZUvXQP
	3/wby7tj+bkvDLoGzNphJTmyTJsp6Vc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-hWcsFLjRMd6vlOsfJQW1Pg-1; Wed,
 02 Apr 2025 12:58:25 -0400
X-MC-Unique: hWcsFLjRMd6vlOsfJQW1Pg-1
X-Mimecast-MFC-AGG-ID: hWcsFLjRMd6vlOsfJQW1Pg_1743613103
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8186019560BD;
	Wed,  2 Apr 2025 16:58:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.28])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7F97D195DF82;
	Wed,  2 Apr 2025 16:58:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Apr 2025 18:57:48 +0200 (CEST)
Date: Wed, 2 Apr 2025 18:57:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Ziljstra <peterz@infradead.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250402165705.GA32368@redhat.com>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250401172225.06b01b22@gandalf.local.home>
 <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>
 <20250402103326.GD22091@redhat.com>
 <CAEf4Bzb-61gDHhacpUQRJ86Fg_uiugk5MOGv8bshaxqQiABLHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb-61gDHhacpUQRJ86Fg_uiugk5MOGv8bshaxqQiABLHA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 04/02, Andrii Nakryiko wrote:
>
> On Wed, Apr 2, 2025 at 3:34 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > I have no idea if this logic is correct or not, but it seems that (apart
> > from the necessary barriers) we could use the utask->ri_timer_is_running
> > boolean instead with the same effect? Set/cleared in ri_timer(), checked
> > in free_ret_instance().
>
> "Apart from the necessary barriers" is exactly what I didn't want to
> deal with, tbh... Which is why I went with (ab)using seqcount lock.
>
> Other than that, yes, the reader logic is very simple and just wants
> to make sure that ri_timer (writer) couldn't have seen the
> return_instance we are about to immediately reuse (which would pose a
> problem).

Ah. This answers my question about the motivation to use seqcount_t,
thanks.

I am not going to question your decision, but perhaps this deserves a
comment, it is not immediately clear from reading this code...

Thanks!

Oleg.


