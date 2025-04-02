Return-Path: <bpf+bounces-55141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FC4A78CFF
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 13:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC743A771B
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 11:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B6B2376E9;
	Wed,  2 Apr 2025 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2sv+4NK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42612E3394
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743593038; cv=none; b=MCgg4kRvh1DlfXDBlVa8HmG1F5UhijhIj1x7Hfwr2HGsu+hrNaV7wCB4tdmW0ahJlNL1sgf5V04g6vJRzNw7aTCVN97hRLNAGG1TfwkoJ8U2nB30/vw09Y+hN1VRYO+DTZe9oPmx+jNKgajlGYGWlTL7Lx1cRBvtnyPqHj9N8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743593038; c=relaxed/simple;
	bh=/KWPVDjJCugQVxRyMdQMO4pqMQ/vWo7Ji66wG+/Klyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcdYu6qVvTjgCYBhnag+YfB9QBX7oGQDBZcrvylmsLufrf8d7Mo4D476o6SFEtoZ26ogF0L57OdiI7VohqsAk8lJKaqTdLx8ipgvkr0uUv7X+oL2BC13EcVj7yyzZt8nbWKsdJoqE/GG/hm43gpNbxlY1QRiFxCAXwI0VqnyjFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2sv+4NK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743593035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/KWPVDjJCugQVxRyMdQMO4pqMQ/vWo7Ji66wG+/Klyw=;
	b=W2sv+4NK6hTnCRMT+GnUwRukk1F5afkEPU9Dbqb35WDA2xVoH/Jqai1MeoWY7Yp1f7P6Uy
	pgs9qW7HCBxBXieqTJaNWgBfwcYnBhYDhrux7H9Uoe9oW/ohFfh+oCHEC2gq2sfwlZqgQh
	MYpYW8zgM39xOYYB5+kgjkP94OleQgs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-lfoNxvcOMzG1vRUDc15PVA-1; Wed,
 02 Apr 2025 07:23:50 -0400
X-MC-Unique: lfoNxvcOMzG1vRUDc15PVA-1
X-Mimecast-MFC-AGG-ID: lfoNxvcOMzG1vRUDc15PVA_1743593029
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1E02195608F;
	Wed,  2 Apr 2025 11:23:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.147])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6F962195609D;
	Wed,  2 Apr 2025 11:23:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Apr 2025 13:23:14 +0200 (CEST)
Date: Wed, 2 Apr 2025 13:23:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Ziljstra <peterz@infradead.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250402112308.GF22091@redhat.com>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250401172225.06b01b22@gandalf.local.home>
 <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>
 <20250402103326.GD22091@redhat.com>
 <20250402105746.FMPvRBwL@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402105746.FMPvRBwL@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 04/02, Sebastian Sewior wrote:
>
> On 2025-04-02 12:33:55 [+0200], Oleg Nesterov wrote:
> >
> > The "writer" ri_timer() can't race with itself, right?
>
> On PREEMPT_RT the timer could be preempted by a task with higher
> priority and invoke hprobe_expire() somewhere else.

This is clear, but ri_timer() still can not race with itself, no?

Oleg.


