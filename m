Return-Path: <bpf+bounces-38075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82E795F142
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 14:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93452280EAD
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 12:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D00216B385;
	Mon, 26 Aug 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhSctjop"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A2E13BACE
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675110; cv=none; b=TgFIAb2nMm7BnXGTCM4brHGm/0BOjY8CFyTKrrKYqi/029wlnWAgFQcEUMk8C3mec4FJyql/PTHOR+CM0nycBb6tNGBAQqZe4K23UhKWV9f5A7cfUx+PeJAb+uqKnIQjYLbb78IbiZ8DAvUIvcQINmVTz7tygtfor6wDtESj23E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675110; c=relaxed/simple;
	bh=jpDRH9dbAziLy0GYQaJhc+koCjZez7lfB5Y1aHhxtgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DH+PlLVEGsKDhZyqwOUMDU38DVSMn6lJ0gZiILn/TZpZMRX8wffB9qTO28Pidcay2beb8qNAxrknM3SICib/BDrdzfHE8VDNNc2C3ghtRTjQFlP3aPEC83JJs8sibJudbLRP7uavIC3DLGTQfAGjKH8bz3byDDhQTrPZbFkd4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhSctjop; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724675107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpDRH9dbAziLy0GYQaJhc+koCjZez7lfB5Y1aHhxtgg=;
	b=bhSctjop33dnhwWLzt4+SrumbwTANMzVrkL3bDom/9gm+2IQYORY8nGkJuxyRv6aYNy51p
	wPTzrADMqcCNgeDakluOlLvPvTxWlR6/FStAysM4tSzi5pw1gvsApbuRElXTTvOroqZCcA
	Zrfy2OpAte9thgUZA66vpGWJeGASZpM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-Q_-YKPSaM72EZkA1yHd_-w-1; Mon,
 26 Aug 2024 08:25:03 -0400
X-MC-Unique: Q_-YKPSaM72EZkA1yHd_-w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 570081955D4B;
	Mon, 26 Aug 2024 12:25:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D8A951955F45;
	Mon, 26 Aug 2024 12:24:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 26 Aug 2024 14:24:54 +0200 (CEST)
Date: Mon, 26 Aug 2024 14:24:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tianyi Liu <i.pear@outlook.com>, andrii.nakryiko@gmail.com,
	mhiramat@kernel.org, ajor@meta.com, albancrequy@linux.microsoft.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240826122448.GB21268@redhat.com>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826115752.GA21268@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/26, Oleg Nesterov wrote:
>
> Does bpftrace use bpf_uprobe_multi_link_attach/etc ? I guess not...

Given that the patch from Tianyi makes the difference, bpftrace should
trigger the "#ifdef CONFIG_BPF_EVENTS" code in __uprobe_perf_func(), and
bpf_prog_run_array_uprobe() should return zero, correct?

> Then which userspace tool uses this code? ;)

Yes ;)

Oleg.


