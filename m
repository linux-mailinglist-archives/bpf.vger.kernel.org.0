Return-Path: <bpf+bounces-36837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1E094DD2C
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 16:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88A6282490
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3034015FCE6;
	Sat, 10 Aug 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/xpQm8y"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538BC381C2
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723298432; cv=none; b=BAePEZtvdt0SHwe3rt7nE/TrcVRRiUqW3VKVB4AZVqIP86/iSVoJuVUDfO4tvam9bRK++l5UZIZuQRYKkD7R1QW3ko/u2VqQqWQ5UFQ4xQz+TFDjun7a6x5ec0Rd1OnP2t8tnV0ooOQ6GG8ACd/6HAgk/O1yJk/wFpRmIUl3dY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723298432; c=relaxed/simple;
	bh=Cj1Yx0PJFEYVxLn4UyvZAIGlvRL72QXzxSOUQM3nhDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXXqtZ+i2Qxi2xmxFaNOgKjiTH6LtjkSsC9fmkBXN5wC85QGDlY9c6U/bup68JXBYFVKEwxEVds81tWQ7lfBtfXqZN/P5WM1LImr2l9AXiUWNozLaRHqgk+9Uo7ECdcDUFS+0dLYBrh8UwRCis03sAUobHbsJv1/exLMluPfhdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/xpQm8y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723298430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=624V9XyG5KuMz5zJt7ndl3ScBb1+yoRWVwukoiM9UV8=;
	b=B/xpQm8yURLq2cpfxrgTDos6MW+FTvHm/StR77SKbZRvxTSRPB+I0BPuClTllFf2Pht/OI
	VcBASyPe/JszBgjWa3Vx6wCJYflo6leAlq8hpBgqPEsXIiFbIpWFELevFsjWlHkkcyYVFz
	Mgps5zhUsaSDaNTRGC3H//e/DG98iQU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-q4Qa9PKFOGqoKeri_5PBrQ-1; Sat,
 10 Aug 2024 10:00:25 -0400
X-MC-Unique: q4Qa9PKFOGqoKeri_5PBrQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 734B01956080;
	Sat, 10 Aug 2024 14:00:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.43])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 133F419373D7;
	Sat, 10 Aug 2024 14:00:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 10 Aug 2024 16:00:21 +0200 (CEST)
Date: Sat, 10 Aug 2024 16:00:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 7/8] uprobes: perform lockless SRCU-protected
 uprobes_tree lookup
Message-ID: <20240810140015.GA21800@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-8-andrii@kernel.org>
 <20240808134007.GE8020@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808134007.GE8020@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 08/08, Oleg Nesterov wrote:
>
> On 07/31, Andrii Nakryiko wrote:
> >
> >  static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
> > +static seqcount_rwlock_t uprobes_seqcount = SEQCNT_RWLOCK_ZERO(uprobes_seqcount, &uprobes_treelock);
>
> Just noticed... Why seqcount_rwlock_t?
>
> find_uprobe_rcu() doesn't use read_seqbegin_or_lock(),
> seqcount_t should work just fine.

Please ignore... I forgot that seqcount_t is not CONFIG_PREEMPT_RT-friendly.

Hmm. __seqprop_preemptible() returns 0, this doesn't look right... Nevermend.

Oleg.


