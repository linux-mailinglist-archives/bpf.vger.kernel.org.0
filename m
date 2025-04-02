Return-Path: <bpf+bounces-55145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEFCA78DF5
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 14:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BA73AEE14
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC17238176;
	Wed,  2 Apr 2025 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqS6DB5Q"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30BA232792
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595995; cv=none; b=JDBf8zXKdnONje6o8mso+AxZf/zDeeQJ+YLM4+c+camWuLGtcIsxLhhGwLjdiLzFv/l77yHQuIdBI5v/mOG2ZySbLRIEmkn9JeJinAiQNza6yBAD+UWVSZOVnrNvknb/vA3d8aNDYYaq8PYszDx3/OHpzZ5GcIrSQG/8r6hjv4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595995; c=relaxed/simple;
	bh=m7J6hgaWEfWJ/5Iiun4oGp+y3lQJE65+e0/JQTHCo88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Soshktdna6OECB47cd8J/daeeWruS24W+8aGsOMK5LciUWaLdcd8/gUJT1VJHlMXesthCLnltkqvOlThUxcbyYolOccvcOkWxmQofAqeaomN/pwGjMZgeeeYP5lqx/M0jrF2895+DjYdTbp0FO17GRKP8G3lsgl66v5wiHrqJKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqS6DB5Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743595992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7J6hgaWEfWJ/5Iiun4oGp+y3lQJE65+e0/JQTHCo88=;
	b=OqS6DB5QGuuZP+fx5qbJ/HeB9H6X7fmiyA/3lHwCmCJqvVFx9Zq1cIN+OkXZDWJO7ABo2D
	W64Tfv2SUMMKE1jX8JTl4aCwwK8Oqik75k+gbsrPSV84A5/vzZy1Qbr37oWvmGPlLEnFn7
	gg3CWioP6udqAQJVemgLORYw4LPNYoU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-RZKhpmmsPC-6LXpEKkbNoA-1; Wed,
 02 Apr 2025 08:13:09 -0400
X-MC-Unique: RZKhpmmsPC-6LXpEKkbNoA-1
X-Mimecast-MFC-AGG-ID: RZKhpmmsPC-6LXpEKkbNoA_1743595987
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96A1B195608F;
	Wed,  2 Apr 2025 12:13:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.147])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7EDE919560AD;
	Wed,  2 Apr 2025 12:13:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Apr 2025 14:12:32 +0200 (CEST)
Date: Wed, 2 Apr 2025 14:12:28 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Peter Ziljstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250402121228.GH22091@redhat.com>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250402091044.GB22091@redhat.com>
 <20250402105444.tW8UU7vO@linutronix.de>
 <20250402112007.GE22091@redhat.com>
 <20250402113142.GG22091@redhat.com>
 <20250402120649._gQHEtYM@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402120649._gQHEtYM@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 04/02, Sebastian Sewior wrote:
>
> On 2025-04-02 13:31:43 [+0200], Oleg Nesterov wrote:
> >
> > IOW.
> >
> > I understand that seqcount_t is not RT-friendly, but why exactly do
> > you think the patch above can make the things worse?
>
> We wouldn't notice such a case.

Sebastian, could you spell please?

What case we wouldn't notice?

With this patch write_seqcount_begin(seqcount_t) will notice that
seqprop_preemptible() is true and do preempt_disable() itself.

Oleg.


