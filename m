Return-Path: <bpf+bounces-39752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15627976ED7
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 18:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC392282694
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8261AE87F;
	Thu, 12 Sep 2024 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRoa5IHu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED1187340
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158970; cv=none; b=nd9FK9H7thPzgl1pzGVQiMnV0qw3QYufhVP5rFW/Fh9/wfJkke+D+tgpHkE5A3v978k1DXIL7HczKSmJp051q5nS8gJaw9RevJK0CERgXYopTNUP2o2pfFrnOlWQn/sC1d8nICNWcyU5wX5EMDGwIik5DdjHUy8ccv6SLE2Q5gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158970; c=relaxed/simple;
	bh=9WdMvPxLilxgseC3h6yRSRdb7LgZMdi1AkzFbJykkA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxyOwDOlNwxou+vGe6ZEMOF40AoblyViVeMDA4PKcsjdcj6z5WzRL5s9y2RAe+b/+dno/H3KhbMjSJkh5MB5FRqcshwYUOfKh0gd6cij3cewWiYdWWJpwMcS1lx8WRCRnm529brj+D7NnUZYtP/j5Mzg2B6rqssNuZOXlg8MV/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRoa5IHu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726158967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R8zmoeGBzSdTcK3eaUZ34iznt1NVZM3/FHPWNlfxcos=;
	b=SRoa5IHuVVcsscoOLHsDr0558TeNB3FzKVc/AUb2/oUM+CgAz/a3heSS3LnIWZTh/6bSyM
	frQb6jpHz3Eu+76ynP3CHMFa0vTRxWjKBdpULSzJ2B5o7gtGI04BQn0EIWlXxRCq5qa9jo
	SZYyar5euArPLbNyNn7F6ATou5FLcaM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-Of5IrvF_PMqt5PDeoSS-7w-1; Thu,
 12 Sep 2024 12:36:02 -0400
X-MC-Unique: Of5IrvF_PMqt5PDeoSS-7w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A23131955D4C;
	Thu, 12 Sep 2024 16:35:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.62])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7A76F19560AB;
	Thu, 12 Sep 2024 16:35:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 12 Sep 2024 18:35:47 +0200 (CEST)
Date: Thu, 12 Sep 2024 18:35:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
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
Message-ID: <20240912163539.GE27648@redhat.com>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909074554.2339984-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/09, Jiri Olsa wrote:
>
>  handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
>  {
> +	struct return_consumer *ric = NULL;
>  	struct uprobe *uprobe = ri->uprobe;
>  	struct uprobe_consumer *uc;
> -	int srcu_idx;
> +	int srcu_idx, iter = 0;
>
>  	srcu_idx = srcu_read_lock(&uprobes_srcu);
>  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
>  				 srcu_read_lock_held(&uprobes_srcu)) {
> +		/*
> +		 * If we don't find return consumer, it means uprobe consumer
> +		 * was added after we hit uprobe and return consumer did not
> +		 * get registered in which case we call the ret_handler only
> +		 * if it's not session consumer.
> +		 */
> +		ric = return_consumer_find(ri, &iter, uc->id);
> +		if (!ric && uc->session)
> +			continue;
>  		if (uc->ret_handler)
> -			uc->ret_handler(uc, ri->func, regs);
> +			uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);

So why do we need the new uc->session member and the uc->session above ?

If return_consumer_find() returns NULL, uc->ret_handler(..., NULL) can handle
this case itself?

Oleg.


