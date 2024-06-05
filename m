Return-Path: <bpf+bounces-31465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286398FD80F
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 23:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261D31C242C3
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 21:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E10813A40B;
	Wed,  5 Jun 2024 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmoZjN/w"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8AC13CFBD
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621354; cv=none; b=VJTKjgK3UltP7MqGqktGrNsTVhsJgMEWz3hh9WFuQF1m7ZGIAzSgYpp6dv3Y1QcrQUHBAD6CNEDaM1UZSU+YSLtau5P0NZszhDFkjBTyHDtRNksD8fWdY/fucagHTM5tbIvpJg0zbhvpsy1/QiwNnmXjYM8REWI2sWqyb2udAz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621354; c=relaxed/simple;
	bh=CR6hmo3BYLol4OkDTrDKGhawRzyHwi1OkF6+XlGrv3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIf5gOniNcPwydAZ87DQdoEabQH/1ekPTkVP+baW8IpI6SX0+LiRR3MsepVAO0P3IOluEFm49KYBGDlgXrfFuQQsIzHukzCtGOtcqziYaIUFcutf47eFl1M+cg+j3uzJnodLLgz/iT2hA6Fh8qXWpCeExl+DrRQoCIgBYWFVkKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmoZjN/w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717621352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CR6hmo3BYLol4OkDTrDKGhawRzyHwi1OkF6+XlGrv3w=;
	b=GmoZjN/wbcHgTXUoVynoUZ5YTYXWuiP5juAa6a9eTt5NKrU4Df+NsPT1MMtuia0ZPlAq4g
	/D1BufrU3FJ2PQ3jBSxahf5MKwzG4U810XbwfkatQTFMNiBlR0tyg9BeQ5yDjaMBZQ7Qh4
	wbhBN8atnC3r9yiW+5O3bHruXjGOYbY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-UlRffepYNUy40V6cIxvZ3w-1; Wed,
 05 Jun 2024 17:02:23 -0400
X-MC-Unique: UlRffepYNUy40V6cIxvZ3w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAF671953955;
	Wed,  5 Jun 2024 21:02:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.62])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 80A511956055;
	Wed,  5 Jun 2024 21:02:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Jun 2024 23:00:52 +0200 (CEST)
Date: Wed, 5 Jun 2024 23:00:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [RFC bpf-next 01/10] uprobe: Add session callbacks to
 uprobe_consumer
Message-ID: <20240605210043.GB19139@redhat.com>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
 <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>
 <20240605175619.GH25006@redhat.com>
 <ZmDPQH2uiPYTA_df@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmDPQH2uiPYTA_df@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 06/05, Jiri Olsa wrote:
>
> > And the comment about the return value looks confusing too. I mean, the
> > logic doesn't differ from the ret-code from ->handler().
> >
> > "DO NOT install/execute the return uprobe" is not true if another
> > non-session-consumer returns 0.
>
> well they are meant to be exclusive, so there'd be no other non-session-consumer

OK. (but may be the changelog can explain more clearly why they can't
co-exist with the non-session-consumers).

But again, this doesn't differ from the the ret-code from the
non-session-consumer->handler().

If it returns 1 == UPROBE_HANDLER_REMOVE, then without other consumers
prepare_uretprobe() won't be called.

Oleg.


