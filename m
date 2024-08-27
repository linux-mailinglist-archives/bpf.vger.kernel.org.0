Return-Path: <bpf+bounces-38205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C9E961874
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 22:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C6A284256
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 20:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCEB1D31B7;
	Tue, 27 Aug 2024 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0MPL8kM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51A11D2F5E
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724790057; cv=none; b=pA4eg/qy0/P3zK2b7DrjXYuG5zk8/DmN4hBoKtGhj0JEwZ21Pa0GbNSodtxMxjB4GuDSQCNb+JsjKQZrviKkZWewp5QASaxuBB6ctsfRvPF58mRWcxJmea0kt/q93Rz/RRk/8ZZLef20MtwKdsCllM+oH44Pkd1N5w/J/ljxN+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724790057; c=relaxed/simple;
	bh=IX5si5EYKXFedDXsoUyvGe/yeYYqJdUrLOvLVmyvDNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7nKU/4nbPQQeg7jhxOBPWPWbTNrahLJOBZq1S4YdR6ynNnc0ytqg85SW3a6fVIUIi3Wcf9m5M0K4yugQa+ToHzYjjqnViysZMJsKoBDsKpKQtyed3AuRSnQrvUpXk91DfrQKP49E+qseIUNI/lXRYpqvF6mVTLZ8KX/BXmVV1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0MPL8kM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724790054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ4ec0yBpDF4MxHv3vBJcdH9alZpBI0OyqbZ01quyh4=;
	b=g0MPL8kMmPPxmSEFiTcJ7b/6kxzRBmLHfyyEEZ1LgpkhO5JfMvldD2vmWJ+c+fdAg2IXSb
	M35iIDQ5Rn3iGiKjSuZWeMFgDtE3D6r5UtojpGDl2BZVgmFQHfglxTsBpmnA1hqISqeNJO
	HFVFzLBWaVEY5gyW+Zvc+G0cp7blHf8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-78QKakd-PduViEfCbPaipw-1; Tue,
 27 Aug 2024 16:20:51 -0400
X-MC-Unique: 78QKakd-PduViEfCbPaipw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E610218DB7DB;
	Tue, 27 Aug 2024 20:19:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8AA03300019C;
	Tue, 27 Aug 2024 20:19:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 27 Aug 2024 22:19:32 +0200 (CEST)
Date: Tue, 27 Aug 2024 22:19:26 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tianyi Liu <i.pear@outlook.com>, andrii.nakryiko@gmail.com,
	mhiramat@kernel.org, ajor@meta.com, albancrequy@linux.microsoft.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240827201926.GA15197@redhat.com>
References: <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <ZsyHrhG9Q5BpZ1ae@krava>
 <20240826212552.GB30765@redhat.com>
 <Zsz7SPp71jPlH4MS@krava>
 <20240826222938.GC30765@redhat.com>
 <Zs3PdV6nqed1jWC2@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs3PdV6nqed1jWC2@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Sorry for another reply, I just noticed I missed one part of your email...

On 08/27, Jiri Olsa wrote:
>
>    ->     uretprobe-hit
>             handle_swbp
>               uprobe_handle_trampoline
>                 handle_uretprobe_chain
>                 {
>
>                   for_each_uprobe_consumer {
>
>                     // consumer for task 1019
>                     uretprobe_dispatcher
>                       uretprobe_perf_func
>                         -> runs bpf program
>
>                     // consumer for task 1018
>                     uretprobe_dispatcher
>                       uretprobe_perf_func
>                         -> runs bpf program
>
>                   }
>                 }
>
> and I think the same will happen for perf record in this case where instead of
> running the program we will execute perf_tp_event

Hmm. Really? In this case these 2 different consumers will have the different
trace_event_call's, so

	// consumer for task 1019
	uretprobe_dispatcher
	  uretprobe_perf_func
	    __uprobe_perf_func
	      perf_tp_event

won't store the event because this_cpu_ptr(call->perf_events) should be
hlist_empty() on this CPU, the perf_event for task 1019 wasn't scheduled in
on this CPU...

No?

Ok, looks like I'm totally confused ;)

Oleg.


