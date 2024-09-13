Return-Path: <bpf+bounces-39817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA663977CEC
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 12:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D274B26944
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 10:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57E11D7E46;
	Fri, 13 Sep 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiyTXIC3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B311D6C47
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222097; cv=none; b=kZDn2o5DE6QMoNeov428UfenoF+lvw4PXxJoUKU/k9ijQkzgV87+rkve7fU3+qjlADhKnVOyda6Nl6Gx8gYhRUKzXOlrN4jbOA8OTNV5AGdszxG8eQE0rVM7gljjCFo++Vcsw5H2cNAJNj6o/Bc1q944WUyAEc0JF8AolYWtx/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222097; c=relaxed/simple;
	bh=NJ5vLMS3p7bc1+ugEtX1p5ebV1ErxgxGh0V/uCJ1X+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNav5W6aTYvoyZWLx3brEaEAuLvMZAEsDyexPdhmIOnsQHPo84lygUi5CQQYejSjrJC6D6F97uiHloa8x2HdyOw24Yg6R22af9V1Cp2OW56DMCKR96WSbdaHt7tZnQwLESD1o4OSOgXjQdyYDn3VAyhyr0dAG9uKe5Ik9bj0OXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XiyTXIC3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726222094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hNIkurA652okgpZwfSLzJJZ0gdHyD3mAUwRUjJPJUt4=;
	b=XiyTXIC3hWyBUnLfn4eEYjhPNO/ouu2XoA1Zpu6W9frLyyhpSLJn9fVzwJm1v4+4dJm5pv
	V0CAaXZG2ZkE65PuKuib5QNmEKkOukHNIPN/ewo55dyCYbeUPlnZk5F9tUEkH0Yq7lseyk
	343olZJ34dtNIHGfeowrMDN0El9yXnA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-jPnU5WGbOTyGqUvSuRaPwg-1; Fri,
 13 Sep 2024 06:08:11 -0400
X-MC-Unique: jPnU5WGbOTyGqUvSuRaPwg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09E061955EA8;
	Fri, 13 Sep 2024 10:08:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A2E341956086;
	Fri, 13 Sep 2024 10:08:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 13 Sep 2024 12:07:57 +0200 (CEST)
Date: Fri, 13 Sep 2024 12:07:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/7] uprobe: Add support for session consumer
Message-ID: <20240913100749.GB19305@redhat.com>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-2-jolsa@kernel.org>
 <20240912162028.GD27648@redhat.com>
 <ZuP2YFruQDXTRi25@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuP2YFruQDXTRi25@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 09/13, Jiri Olsa wrote:
>
> On Thu, Sep 12, 2024 at 06:20:29PM +0200, Oleg Nesterov wrote:
> > > +
> > > +		if (rc == 0 && uc->ret_handler) {
> >
> > should we enter this block if uc->handler == NULL?
>
> yes, consumer can have just ret_handler defined

Sorry, I meant we do not need to push { cookie, id } into return_instance
if uc->handler == NULL.

And in fact I'd prefer (but won't insist) the new

	UPROBE_HANDLER_I_WANT_MY_COOKIE_PLEASE

return code to make this logic more explicit.

Oleg.


