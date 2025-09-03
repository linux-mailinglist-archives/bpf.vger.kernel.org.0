Return-Path: <bpf+bounces-67276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A92BB41E24
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8671BA7EEA
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 12:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6763D2E54AA;
	Wed,  3 Sep 2025 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Md1PbUhK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61D286435
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900855; cv=none; b=WHUXIGV1fnESrDbqCM/KnQkdVmwaEyuSdVpGcaF9veN7XBXS3uzX/NqZ5q051rqexWUD8WPxl77+PApADSG8nVEkcSkxlzszrAfj19LbC5Wtsj4hkwTsqBehGbJ8MFPoHlbU24VeI7dIw50GCfoyRFt0QuNcXbHJGOpvZTtR5lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900855; c=relaxed/simple;
	bh=+grVyZxAWtKNFWpbultXM2V6yd2mmR2F3jJF5AT5BFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUYmcEG08f5i2nHUP/WiAucZH8XkVABJwtZKWo1cmVIqEIDoDQJOQtNLw8unQTdqA/pF1IMccvdzVL92p6lGtu1LNMHm6C4qNwpMHAHW8jvVtha3eYa1HC9l2VBlgc0rq9em+/L9zwnZ/gdQ2bSb0Ism73bBwoCmxRImnyRDcQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Md1PbUhK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756900852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1nw6naDuPKKSADEwjZLNE9uKM8R6m9CFTff86lS75ms=;
	b=Md1PbUhKggE3Ro1rzklLofbAGUlhL2aXnVZlppR4C/6a0HQWa6vJZ3AIDJZjtrZl47pDJN
	0PQYmbQvRrzSHhkl6q6LcVpKm/PDgOinBT/zF1CobH7F4lq0KBa7U20KE8xyeyO/KVMzCT
	Tigl9Nzk/cPl3GiOheMOERwO0OVSMSs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5--AUOuqbjOgiGyYcAnxfZKQ-1; Wed,
 03 Sep 2025 08:00:48 -0400
X-MC-Unique: -AUOuqbjOgiGyYcAnxfZKQ-1
X-Mimecast-MFC-AGG-ID: -AUOuqbjOgiGyYcAnxfZKQ_1756900842
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B7461800291;
	Wed,  3 Sep 2025 12:00:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 446F31800446;
	Wed,  3 Sep 2025 12:00:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Sep 2025 13:59:19 +0200 (CEST)
Date: Wed, 3 Sep 2025 13:59:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
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
Message-ID: <20250903115912.GD18799@redhat.com>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-4-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902143504.1224726-4-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Slightly off-topic, but

On 09/02, Jiri Olsa wrote:
>
> @@ -11144,7 +11147,7 @@ static int perf_uprobe_event_init(struct perf_event *event)
>  {
>  	int err;
>  	unsigned long ref_ctr_offset;
> -	bool is_retprobe;
> +	bool is_retprobe, is_unique;
>  
>  	if (event->attr.type != perf_uprobe.type)
>  		return -ENOENT;
> @@ -11159,8 +11162,9 @@ static int perf_uprobe_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>  
>  	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
> +	is_unique = event->attr.config & PERF_PROBE_CONFIG_IS_UNIQUE;
>  	ref_ctr_offset = event->attr.config >> PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
> -	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe);
> +	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe, is_unique);

I am wondering why (with or without this change) perf_uprobe_init() needs
the additional arguments besides "event". It can look at event->attr.config
itself?

Same for perf_kprobe_init()...

Oleg.


