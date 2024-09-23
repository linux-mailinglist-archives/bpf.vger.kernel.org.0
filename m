Return-Path: <bpf+bounces-40191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342BB97E96F
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 12:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F0A28333B
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810ED1990D3;
	Mon, 23 Sep 2024 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhrt3YB3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B071198A30
	for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085983; cv=none; b=upVVt+9sg0lyLuOxqXj4v/VOorMT7aCy4rASz9eBou29Vx8P0ACVZ7+2SCfWx1iMgFFsdmx1X3uyaFop6TVEfoHHzKxsIdl0d06fe9NX4uVPD7yv6k3G7WP2scPGbgLeOkIf40/CSjvtbLahSws1LqJsT5vz4p/JDZP/pYvxyYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085983; c=relaxed/simple;
	bh=ffdTghOFx9Phzzc1FWGmgEO2YF5UBj0UtTzQ1iFJsbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktxAboimEEFnW/dbJ0YRBDOdu6SOFepWJBqQneFq+jK/pOc+dy929vWDdIqd9sXEKPG/ABaS0b2+YK3tKUWp279LfoJ2YZK2tgqHbIU6W+CrEj7Z8yLC6gW81KBo2bQ/hV/KAqHgAR0fXt0+VSMGiMm54qgVwXu/gt50ZRCOQfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhrt3YB3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727085980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dq8TPXh68jq07smKwqZDTyjG2zcMrGlhnVptGr1W454=;
	b=bhrt3YB3WdRgXZj5Pyq2tXUgMPXlle5pcXC4yM1Gt+jlGsKn6tYoxjk3CF+WsxMa8pLVgP
	c7R2R1wdZT+ahmHSJxV9Nm9m3Ojs0fWKA8ZXVub4YP70vlpIZNoNTCQChhLRdnAN664AUm
	U8I9gzGZSOE0Xvl7Vi5LPVaDS38vGsU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-h668ctPPOdamdY9T6s2B6Q-1; Mon,
 23 Sep 2024 06:06:18 -0400
X-MC-Unique: h668ctPPOdamdY9T6s2B6Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F735190DE2B;
	Mon, 23 Sep 2024 10:06:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9D1C630001A1;
	Mon, 23 Sep 2024 10:06:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 23 Sep 2024 12:06:01 +0200 (CEST)
Date: Mon, 23 Sep 2024 12:05:53 +0200
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
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 02/14] uprobe: Add support for session consumer
Message-ID: <20240923100552.GA20793@redhat.com>
References: <20240917085024.765883-1-jolsa@kernel.org>
 <20240917085024.765883-3-jolsa@kernel.org>
 <20240917120250.GA7752@redhat.com>
 <Zul7UCsftY_ZX6wT@krava>
 <20240922152722.GA12833@redhat.com>
 <ZvEhL114tyhLmfB1@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvEhL114tyhLmfB1@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/23, Jiri Olsa wrote:
>
> change below should do what you proposed originally

LGTM, just one nit below.

But I guess you need to do this on top of bpf/bpf.git, Andrii has already
applied your series.

And to remind, 02/14 must be fixed in any case unless I am totally confused,
handler_chain() can leak return_instance.

> also on top of that.. I discussed with Andrii the possibility of dropping
> the UPROBE_HANDLER_IWANTMYCOOKIE completely and setup cookie for any consumer
> that has both 'handler' and 'ret_handler' defined, wdyt?

Up to you. As I said from the very beginning I won't insist on _IWANTMYCOOKIE.

>  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
>  				 srcu_read_lock_held(&uprobes_srcu)) {
> +		ric = return_consumer_find(ri, &ric_idx, uc->id);
>  		if (uc->ret_handler)
> -			uc->ret_handler(uc, ri->func, regs);
> +			uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
>  	}
>  	srcu_read_unlock(&uprobes_srcu, srcu_idx);

return_consumer_find() makes no sense if !uc->ret_handler, can you move

		ric = return_consumer_find(ri, &ric_idx, uc->id);

into the "if (uc->ret_handler)" block?

Oleg.


