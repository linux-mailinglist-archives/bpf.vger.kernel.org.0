Return-Path: <bpf+bounces-67289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69E0B4214C
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 15:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BA67C0EFA
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 13:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44529220F24;
	Wed,  3 Sep 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AveaWb2x"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF052FF643
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905847; cv=none; b=o2CnsXtN048PYTVAo4AFKG81WKRtW10oMBv5ol5mcEeAV/cjsR76cr3q3NbAGWpQ3kjGoBNfRJNHoNZJ9sP4okfyCFkE3DUpEwCqKHSa2RcG34xJz4ttbwHmnY744JMnPghHhs+Bh8wX7fe8nbTazg3IDVbcnYcDsaO9Ocldfu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905847; c=relaxed/simple;
	bh=jzIteg6avMtpEuBBHIFZYlXNRMKt8IW7AEhql563AnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1ubRD82FMnHbuWQ70V0iha04MXpY5bXMBKeFB7YlsMp3V1Ysb7WdiM+kwMSTk6BbW9RvK55KXgm0G7+4101/ZaJER5DPwrT6gX9uxx63v0TqzA/yM01c5CDB4cXU0HziY4uVFPtczkZAm5Ao8w839J9LE0V+kkG6Lf8QN/6J40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AveaWb2x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756905845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzIteg6avMtpEuBBHIFZYlXNRMKt8IW7AEhql563AnA=;
	b=AveaWb2xnlCQEGEfWARTfhVUhazHCABxUsI2lxJBb+ktt/JgFMcR2aXTxS0JmFVaIq67UZ
	cpNhZl7Oa/rxic1jr/ekfaS14ThF6kbL/KuR0BXLv+CcNxcq5dLEe2koXQky4N5Nsp7qqR
	SU+PuLnaIPFFGNUyHu+JKqhCukiinFI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-rYNH-XEqPi2Wy7BrFLnPAA-1; Wed,
 03 Sep 2025 09:24:01 -0400
X-MC-Unique: rYNH-XEqPi2Wy7BrFLnPAA-1
X-Mimecast-MFC-AGG-ID: rYNH-XEqPi2Wy7BrFLnPAA_1756905835
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DC6C180035C;
	Wed,  3 Sep 2025 13:23:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B313E1955F19;
	Wed,  3 Sep 2025 13:23:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Sep 2025 15:22:33 +0200 (CEST)
Date: Wed, 3 Sep 2025 15:22:27 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 03/11] perf: Add support to attach standard
 unique uprobe
Message-ID: <20250903132226.GE18799@redhat.com>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-4-jolsa@kernel.org>
 <20250903115912.GD18799@redhat.com>
 <aLg8lLgHdBhNeaOf@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLg8lLgHdBhNeaOf@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/03, Jiri Olsa wrote:
>
> On Wed, Sep 03, 2025 at 01:59:13PM +0200, Oleg Nesterov wrote:
> >
> > I am wondering why (with or without this change) perf_uprobe_init() needs
> > the additional arguments besides "event". It can look at event->attr.config
> > itself?
> >
> > Same for perf_kprobe_init()...
>
> I think that's because we define enum perf_probe_config together
> with PMU_FORMAT_ATTRs and code for attr->config parsing, which
> makes sense to me

Ah, and "enum perf_probe_config" is not exported...

Thanks, please forget then.

Oleg.


