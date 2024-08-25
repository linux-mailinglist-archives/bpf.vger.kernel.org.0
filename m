Return-Path: <bpf+bounces-38033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F096595E47C
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 19:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCCF7B21B8C
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 17:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA63C155324;
	Sun, 25 Aug 2024 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBVyrWyc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF39A15D1
	for <bpf@vger.kernel.org>; Sun, 25 Aug 2024 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724605280; cv=none; b=chRp4zw8NgndL5ryeDh6cLTd3UEkrqfNBhCz54n1lzCTSglCbEFT/69qIGWgZ6yGlgGb/WgCPcfoxsp7JGvU7T/DaibuBUncvt+eg5/oFPXaLG+rMlCodTXw6IuUM5akr4q0u9n1WJzZ1kYbVaDFf4P2H89WGtyHkyv9CFqOVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724605280; c=relaxed/simple;
	bh=Xv3hW5NO4nk6bd87Lk/aAw04TD8pzP4OdNhf51nvEuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oILA2LxqyjH8MhnsMuz6MiOgL7eVEKhaV+nZvLbzLGseux7p3z97AuA/rx1SG10OXFjSxVU6a/8yKDWM0TIbBMUfooj/NEcbzuiAhnV3R0vwdHP6MS1hx4oSj8SElTTZmTyBiYECpd5yUM0jv8+hJ/nGRbbH3cfTXKM3fIX2KcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBVyrWyc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724605277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xv3hW5NO4nk6bd87Lk/aAw04TD8pzP4OdNhf51nvEuE=;
	b=iBVyrWycpHLlN0eNWmOdp3CdpIZ/oCTvLBKUoeKVsTzV05hjbZGsUvPOs+S7S0WzLKjG2t
	lCdsp/Vg5XPTmsJ8YSEayR1dFNVXB9+HY+JFgGgoLA/fvYeMBQDB5MvFFVSJ+57zATl1Ow
	u670t0x1XRU+hk8tvn9Ijc/aoKONaHI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-RZttRMc6NfmQSYk1kgztGQ-1; Sun,
 25 Aug 2024 13:01:14 -0400
X-MC-Unique: RZttRMc6NfmQSYk1kgztGQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC7C71955BF7;
	Sun, 25 Aug 2024 17:01:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D2DCF1955DC8;
	Sun, 25 Aug 2024 17:01:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 25 Aug 2024 19:01:04 +0200 (CEST)
Date: Sun, 25 Aug 2024 19:00:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Jordan Rome <linux@jordanrome.com>, ajor@meta.com,
	Tianyi Liu <i.pear@outlook.com>, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, flaniel@linux.microsoft.com,
	albancrequy@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240825170057.GA3906@redhat.com>
References: <ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240824024439.a37c41bab87dbdf3d0486846@kernel.org>
 <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/23, Andrii Nakryiko wrote:
>
> This is a bit confusing, because even if the kernel-side uretprobe
> handler doesn't do the filtering by itself, uprobe subsystem shouldn't
> install breakpoints on processes which don't have uretprobe requested
> for (unless I'm missing something, of course).

Yes, but in this case uprobe_register/apply will install breakpoints
on both tasks, with PID1 and PID2.

> It still needs to be fixed

Agreed,

> like you do in your patch,

Not sure...

> more, we probably need a similar UPROBE_HANDLER_REMOVE handling in
> handle_uretprobe_chain() to clean up breakpoint for processes which
> don't have uretprobe attached anymore (but I think that's a separate
> follow up).

Probably yes... but yes, this is another issue.

Oleg.


