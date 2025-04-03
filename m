Return-Path: <bpf+bounces-55222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA5CA7A2D4
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 14:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D37F1896614
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 12:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCCC24C67F;
	Thu,  3 Apr 2025 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU1TSPi2"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E782066DB
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743683327; cv=none; b=nx3j2TSASvTkb/SJe1/tPrzm/U/jpIrH/j6ZmKOSNTOQo3muGTCeO5nNiat/c63V59LlnY25ArMwSppi5nSe1SuRxCFUQvkY3eQvlJ5PICQ/pe0nnQdU+XWu3SkRs48Ww6BGRxGoehjYVj4nDVMjxARuAdXuZRCq6cAl6KEKi6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743683327; c=relaxed/simple;
	bh=ELUcPUXOUkvzl1zye8wYAOKK9OCpZ0wfFvrzbkp0IBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5uAot+1BfAxuHNLF3aZMbi5ZBGDCz8Oc5tTBcbxZJIMD0rIt7CHSj6vyfD/dz2Waus51A+cwkwJ3AWphLti6M58lALXTrgxUFzuD1p7bEvNIHjyZkCNqO+x4Auhl1CmYOjmSwUukX67RcyMwzqH7nO5EMLDBwaVkWQuywYRjbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LU1TSPi2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743683324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELUcPUXOUkvzl1zye8wYAOKK9OCpZ0wfFvrzbkp0IBs=;
	b=LU1TSPi2aiCTXJKZKY+A4oBirsugk9ElJBfs8pMs4v4PL0Hp4WEeS0WtCUYz+g7VIS1vE9
	GDO4IviRfbGJT8/DM88DJk8wGkvr5PEPYLhMKaJG6ZASg1U48PkIlcVVb7pKsEtPeHZyKp
	JS0StQ+p+9j1YOszSjASZjln6JomZkw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-iuFU7Jo0NumtkN1C3UahXw-1; Thu,
 03 Apr 2025 08:28:38 -0400
X-MC-Unique: iuFU7Jo0NumtkN1C3UahXw-1
X-Mimecast-MFC-AGG-ID: iuFU7Jo0NumtkN1C3UahXw_1743683316
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D133195608A;
	Thu,  3 Apr 2025 12:28:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0FD921809B6C;
	Thu,  3 Apr 2025 12:28:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  3 Apr 2025 14:28:01 +0200 (CEST)
Date: Thu, 3 Apr 2025 14:27:56 +0200
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
Message-ID: <20250403122756.GB16254@redhat.com>
References: <20250401172225.06b01b22@gandalf.local.home>
 <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>
 <20250402103326.GD22091@redhat.com>
 <20250402105746.FMPvRBwL@linutronix.de>
 <20250402112308.GF22091@redhat.com>
 <20250402121315.UdZVK1JE@linutronix.de>
 <20250402121850.GI22091@redhat.com>
 <20250402122447.B3XIrQnG@linutronix.de>
 <20250402141245.GK22091@redhat.com>
 <20250403073728.c7kEmd8l@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403073728.c7kEmd8l@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 04/03, Sebastian Sewior wrote:
>
> On 2025-04-02 16:12:46 [+0200], Oleg Nesterov wrote:
> > >
> > > Yes. This would work for here just to skip the check because of all
> > > details that are hard to express. Therefore I suggested to use
> > > raw_write_seqcount_begin() instead of write_seqcount_begin() in
> > > 20250402122158.j_8VoHQ-@linutronix.de. Would that work?
> >
> > If this can work, then let me repeat: why can't we turn ->ri_seqcount
> > into a boolean?
>
> I just stumbled here due to the warning. Now that you ask the question,
> it is used a bool in the current construct. So yes, I also don't see
> why.

Well, Andrii has already explained why he decided to abuse seqcount_t,
to avoid the explicti barriers in this code... I won't argue.

So, just in case, I agree that your suggestion to use
raw_write_seqcount_begin/end should obviously fix the problem.

Oleg.


