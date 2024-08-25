Return-Path: <bpf+bounces-38035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FA295E4B9
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 20:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 724F4B210B0
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 18:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B316BE1C;
	Sun, 25 Aug 2024 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HChwaDC+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03C8155757
	for <bpf@vger.kernel.org>; Sun, 25 Aug 2024 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724611424; cv=none; b=fR0yc7ojC/fNhy/0GiNREm2q6BRmsuVPKHuIdBqAycsE5tU47q7or2N0GnuqrD9TjsnOO231kdgZVW4O52J1CKhBi0rcz3u03xZGXvy3GvEBBPPsHyLo54JB4vwWO2NBsDQtEC3BZvrbCJnU4o6yGyOlXwLbu44hLh1Lx35HLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724611424; c=relaxed/simple;
	bh=tzjqxqSFdTG56HTSU+0Y5M+c2RbvZre9mhaXvz0CsmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJ3GD6Z3PZu6oMVa+T6YhPhfbgZ4mXkVjnJmbC4j+aICLrfEe/kUyjlN3+4Rn9N6NFbMF/f7Iuz05fNToQTJMCSYbWt5TD3yOjWK2Z2HB9Ulstu9Hu8rmWmj9poeQ12PoaQclSTOAL+LnOehOu6SP5wN/f7+t4NpvMyBNOHrPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HChwaDC+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724611421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tzjqxqSFdTG56HTSU+0Y5M+c2RbvZre9mhaXvz0CsmA=;
	b=HChwaDC+Lz9TPYqL+oPy+Gkp/R8qUhFIaQGtsilZ7pj73H4iDYaFlINCY8Xmdvp/aPpCtB
	xqLZB14n803XSl4h5YFlswgXgMkP7yUNk+xpEz267pKuJ/jLK7eNA398M3rhinuHnSM4TR
	D5Vjdd8OCoBzKt5LAbjXxBvtGBA7KRY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-kjFvbE3nOtm8IdSijvAT-w-1; Sun,
 25 Aug 2024 14:43:36 -0400
X-MC-Unique: kjFvbE3nOtm8IdSijvAT-w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 284001956080;
	Sun, 25 Aug 2024 18:43:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C018619560AE;
	Sun, 25 Aug 2024 18:43:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 25 Aug 2024 20:43:27 +0200 (CEST)
Date: Sun, 25 Aug 2024 20:43:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tianyi Liu <i.pear@outlook.com>
Cc: andrii.nakryiko@gmail.com, mhiramat@kernel.org, ajor@meta.com,
	albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, jolsa@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240825184321.GC3906@redhat.com>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825171417.GB3906@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/25, Oleg Nesterov wrote:
>
> At least I certainly disagree with "Fixes: c1ae5c75e103" ;)
>
> uretprobe_perf_func/etc was designed for perf, and afaics this code still
> works fine even if you run 2 perf-record's with -p PID1/PID2 at the same
> time.

Forgot to mention...

And note that in this case uprobe_perf_func()->uprobe_perf_filter() will
never return false, and this is correct.

Oleg.


