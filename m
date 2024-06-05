Return-Path: <bpf+bounces-31467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E88F8FD904
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 23:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1705286D89
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 21:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1937315FD1D;
	Wed,  5 Jun 2024 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzZ52kPj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F8F15F40C
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622735; cv=none; b=X6Fye0BUbOahDpx9/xU52Vlixc1tgIv8jlPPPZjmpp3jny1IQritxGLU/UqVsEyUJDtmHuWn+Rp/9dJcNOO58hkdK26hlhydSvSIjKusB1iCKY0igGNIayf0IrJhW7NrbZ2NNVRc4HCwSsqP8Oo0jAZhdGKmiQJLg5fozeEklyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622735; c=relaxed/simple;
	bh=vPUsNLtvA3c1wzJPrmq0xqsqKfT7lCp9zPJqLgYvZgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1JMQjA6qzzYr3xzshh1p1jJkt+qszqRFLrVj3zmbJdwYYczWhuyHnjf5vHGuyfcmugEoLdnyuiLOoOjrPwdzpT4pI9TTYgltUJkoPttw0WPuSw6dQOUPMPV6o/SMw59WHGuGrlHwUTCbm0r2Sfug1Jl3Vaw3Xfe6+IIXyHyFNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzZ52kPj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717622733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vPUsNLtvA3c1wzJPrmq0xqsqKfT7lCp9zPJqLgYvZgg=;
	b=VzZ52kPjd0bnfhNtU46an20MxrM46xIwoGkD1O9RNn3ZqnBmQo/Q/oDIAbqP6T008dqXpq
	Es9QJ+KbSqCYbVorHrDuMStGp3kx2d1n0IB1DKSYNGluaWUvgKhkoAXR+/lV4BRdnwFAA5
	kpXk3YhsSlqLnaRahlzs53GsBO782jQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-cJTSEEHmPlaMTdqrJfJyqQ-1; Wed, 05 Jun 2024 17:25:30 -0400
X-MC-Unique: cJTSEEHmPlaMTdqrJfJyqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9120A85A588;
	Wed,  5 Jun 2024 21:25:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.62])
	by smtp.corp.redhat.com (Postfix) with SMTP id 7534A2166AF9;
	Wed,  5 Jun 2024 21:25:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Jun 2024 23:24:00 +0200 (CEST)
Date: Wed, 5 Jun 2024 23:23:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20240605212354.GC19139@redhat.com>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
 <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>
 <20240605175619.GH25006@redhat.com>
 <CAEf4Bzbz3vi6ahkUu7yABV-QhkzNCF-ROcRjUpGjt0FRjfDuKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbz3vi6ahkUu7yABV-QhkzNCF-ROcRjUpGjt0FRjfDuKQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 06/05, Andrii Nakryiko wrote:
>
> WDYT? It's still fast, and it's simpler than the shadow stack idea, IMO.

Andrii. I am alredy sleeping, I'll try to read your email tomorrow.
Right now I can only say that everything is simpler than the shadow stack ;)

> P.S. Regardless, maybe we should change the order in which we insert
> consumers to uprobe? Right now uprobe consumer added later will be
> executed first, which, while not wrong, is counter-intuitive.

Agreed...

Even if currently this doesn't really matter, I guess it is supposed
that uc->handler() is "non-intrusive".

Oleg.


