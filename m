Return-Path: <bpf+bounces-49686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEEAA1BB93
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 18:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D763AD896
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 17:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31E51D5CEB;
	Fri, 24 Jan 2025 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Miz7r8dl"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CD319A288
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740329; cv=none; b=AqKimS+nFl9PEL0fe1/ZCPFK1woIF03uODmcUNDjYfMTq3RTNU03F1HA5N7H/S2uWp3qD6Kt3WcNyG6m2sNjOmATBoWTrZeifX+18MWU+6m7kj+8KH44N9NLfQ7WPD/LSoGAsCtTKYuq6QZQTq/Ss4chYlAgJSB8PzlQleOKmWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740329; c=relaxed/simple;
	bh=6J9QsPeVGeoMhpEEY5aNdZQpbGvVQPazROy23/F7t5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEC/Hn+iD0fCx8xsp0syoF4J9XbsQxBcm8SlJ917la1VubVVwMEbkHTSDId7mZEq5iaIVyeTSPy1BY3mEdPAHKP3vofrCZDpb7DwKt+tiBv2KoK+7j+QAe2blci4Zu/dLZM0CzYy5rse5Or1FQwG7GXsT/D/+Me/zGScaopHSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Miz7r8dl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737740326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4R6JS0XZMazFw1xp1NS7WAjF2TrTme+GriKOz3p+f3M=;
	b=Miz7r8dlQyvH8FDRTnNeSEWSSzZRh7DiZYLWJtTmFPNx6gvv7LGFMHIU+5PoM77le1t9Vj
	Pd26gVukRzotfux1+cCHuf+e+Boj6jA4rRGlDfIMoOn5kR3ZH/+OmuPw4cxfNP9ZgclTyH
	lgsAOVdvRDGaW1JENGWfaF6i4wFNr9A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-WC7H8ziHMEm-WLZgTtcy1A-1; Fri,
 24 Jan 2025 12:38:44 -0500
X-MC-Unique: WC7H8ziHMEm-WLZgTtcy1A-1
X-Mimecast-MFC-AGG-ID: WC7H8ziHMEm-WLZgTtcy1A
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B047B19560B8;
	Fri, 24 Jan 2025 17:38:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.72])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3AAD31800348;
	Fri, 24 Jan 2025 17:38:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 24 Jan 2025 18:38:15 +0100 (CET)
Date: Fri, 24 Jan 2025 18:38:07 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Liao Chang <liaochang1@huawei.com>, mhiramat@kernel.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, andrii.nakryiko@gmail.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v5 1/2] uprobes: Remove redundant spinlock in
 uprobe_deny_signal()
Message-ID: <20250124173807.GA2542@redhat.com>
References: <20250124093826.2123675-1-liaochang1@huawei.com>
 <20250124093826.2123675-2-liaochang1@huawei.com>
 <20250124102702.6ff0ccc5@gandalf.local.home>
 <20250124172435.GB13891@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124172435.GB13891@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 01/24, Oleg Nesterov wrote:
>
> But I still think this patch is fine. The current task is going to execute
> a single insn which can't enter the kernel and/or return to the userspace
                      ^^^^^^^^^^^^^^^^^^^^^^
I mean't, it can't do syscall, sorry for the possible confusion.

Oleg.


