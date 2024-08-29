Return-Path: <bpf+bounces-38482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0D3965195
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 23:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B39FB22714
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA8818C015;
	Thu, 29 Aug 2024 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gb99zOJT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0912B18C004
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965985; cv=none; b=dgQArT26E0B/BoDRp37BKi8GgzoiR1mphetoKGBy77v4Yf5o33pAcjaS7rOZAgbn/WS40qhMX0BI+F+v09JZGronTE5eRTkPRueBGcklzg452au8eMsocjeEse/PDN+nT4UPDRxtCZgGW5FshJfnEfzQhZy2vo+TCU4XsGccO00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965985; c=relaxed/simple;
	bh=MqUh56zN7NJNdjmghT/euStrp6pZZ7zbmVkxBqupF34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajxaAOMRYjPjvBaX54zinqdE+dETSRPQDzcwjme+I4XP0oodATgBWt8uRgmBs+jPMzF7DB+J82jjd5KkOYLLxvCZ3MtiyddruIGVuch4E+e+vy7u11YJ3Af9anCEq96nUH932cGR3LU5PI5gvkVW4yDCpDxUF38q1ugd+ezFpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gb99zOJT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724965983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uV8YErksJWOCHNNkf7up1j+SAnFhOu+hNSyWOYIg8QY=;
	b=Gb99zOJTcOrYJuX2NNHeIbB8VqKYSzBhuzCnzz2so5iiqP0K19l9R/bX4gghDvqCCcqTK1
	IBJ8bF8LBQ7ETRXqV0o44XfIoDyriTGvw0Kb29pzUuTRyagGDBW30f+zOIFwI4fUtEnOOu
	OoEp4++Q54KLcLMhZ1w3QNtf7xkxZ7I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-SLQD5WZoNPqQH_1vwF2sEA-1; Thu,
 29 Aug 2024 17:12:57 -0400
X-MC-Unique: SLQD5WZoNPqQH_1vwF2sEA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E81C19560B0;
	Thu, 29 Aug 2024 21:12:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.20])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5F71F19560A3;
	Thu, 29 Aug 2024 21:12:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 29 Aug 2024 23:12:46 +0200 (CEST)
Date: Thu, 29 Aug 2024 23:12:41 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tianyi Liu <i.pear@outlook.com>, andrii.nakryiko@gmail.com,
	mhiramat@kernel.org, ajor@meta.com, albancrequy@linux.microsoft.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240829211241.GA19243@redhat.com>
References: <20240826115752.GA21268@redhat.com>
 <ZsyHrhG9Q5BpZ1ae@krava>
 <20240826212552.GB30765@redhat.com>
 <Zsz7SPp71jPlH4MS@krava>
 <20240826222938.GC30765@redhat.com>
 <Zs3PdV6nqed1jWC2@krava>
 <20240827201926.GA15197@redhat.com>
 <Zs8N-xP4jlPK2yjE@krava>
 <20240829152032.GA23996@redhat.com>
 <ZtDQEVN1-BAfWuMU@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtDQEVN1-BAfWuMU@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Ah. we certainly misunderstand each other.

On 08/29, Jiri Olsa wrote:
>
> On Thu, Aug 29, 2024 at 05:20:33PM +0200, Oleg Nesterov wrote:
>
> SNIP

SNIP

> right.. if the event is not added by perf_trace_add on this cpu
> it won't go pass this point, so no problem for perf

Yes, and this is what I tried to verify. In your previous email you said

	and I think the same will happen for perf record in this case where instead of
	running the program we will execute perf_tp_event

and I tried verify this can't happen. So no problem for perf ;)

> but the issue is with bpf program triggered earlier by return uprobe

Well, the issue with bpf program (with the bpf_prog_array_valid(call) code
in __uprobe_perf_func) was clear from the very beginning, no questions.

> and [1] patch seems to fix that

I'd say this patch fixes the symptoms, and it doesn't fix all the problems.
But I can't suggest anything better for bpf code, so I won't really argue.
However the changelog and even the subject is wrong.

> I sent out the bpf selftest that triggers the issue [2]

Thanks, I'll try take a look tomorrow.

Oleg.


