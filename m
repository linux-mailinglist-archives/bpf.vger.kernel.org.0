Return-Path: <bpf+bounces-32634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF49911255
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 21:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB6A286A74
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 19:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2621B9AD5;
	Thu, 20 Jun 2024 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V79QC533"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217FD3A1CD
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912433; cv=none; b=TgZ3IrquupUh/HjALnMO4rLyE6tzTvIqoDimErNm5q8Rz7lkuyDsm81GBLbWjL9yLzeAI0d3lC2R7mspDuxJ/FCrQaaeZVrC6rxCWUd6kbqAygA0mNELz5yc3xxkJM11Rd37k99GSzPSXKnI0Kqh5XA2kvx2+qCx6uUuP3P74/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912433; c=relaxed/simple;
	bh=u5zNNqjXlyw110nBNYIGAGabZlG/rsTKJ2r1fT5/TIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W01zOJQq2mtvxQslKDTbm0zIHpoWX0J1GUaOKAFX7dgWl2tyO4+AyWiYiVSfHHhwedR3AcZesdgnOXsyv7JfePQkmI0gARIntW5Ocy8R1gQokTY7IFZelLL37LWaAsWEfnNFds4+VbWEXbt8PV7To7JZt0OkTwmaM/X5w9TDRcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V79QC533; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718912431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u5zNNqjXlyw110nBNYIGAGabZlG/rsTKJ2r1fT5/TIk=;
	b=V79QC533IPKeDU0MID7ezY1FXh/OnIHuTnZfraYOpK3STUJIfH2XNnKfNXOIypdV2C/z7m
	nbCOgsgVvZibs/LCLqOpaiFPMRCmWxfzzeJiFBHsZiJ1Nqbsz/ioJ/VDLGhwbmq3A5E8G+
	LxFTXcQGlAyaI+AvXh6YD1MKVhUUdC0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-ZXWX-ZlGPveGNUBTWihMRg-1; Thu,
 20 Jun 2024 15:40:25 -0400
X-MC-Unique: ZXWX-ZlGPveGNUBTWihMRg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5384F19560AB;
	Thu, 20 Jun 2024 19:40:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 84A941955E74;
	Thu, 20 Jun 2024 19:40:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 20 Jun 2024 21:38:51 +0200 (CEST)
Date: Thu, 20 Jun 2024 21:38:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] uprobe: Do not use UPROBE_SWBP_INSN as static initializer
Message-ID: <20240620193846.GA7165@redhat.com>
References: <20240618194306.1577022-1-jolsa@kernel.org>
 <CAEf4BzbN4Li2iesQm28ZYEV2nXsLre8_qknmvkSy510EV7h=SA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbN4Li2iesQm28ZYEV2nXsLre8_qknmvkSy510EV7h=SA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 06/20, Andrii Nakryiko wrote:
>
> Can we instead ask loongarch folks to rewrite it to be a constant?
> Having this as a function call is both an inconvenience and potential
> performance problem (a minor one, but still). I would imagine it's not
> hard to hard-code an instruction as a constant here.

I was going to ask the same question when I saw the bug report ;)
The same for other users of larch_insn_gen_break().

But I can't understand what does it do, it calls emit_break() and
git grep -w emit_break finds nothing.

Oleg.


