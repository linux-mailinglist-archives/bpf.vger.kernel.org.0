Return-Path: <bpf+bounces-36681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB1494BE6C
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 15:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB9C1C25910
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 13:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275C713FD86;
	Thu,  8 Aug 2024 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAU08XHS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C318DF7D
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123062; cv=none; b=OaerGHVvBU+M/lfM76LV/zYemhO0MA4Wxtbj3+0APXvh66RJBOJ6UtaAsyTko6uM4CeJCItc4nwYpwwh7ZfMOG/lHDtGvueo59MRGQ0harZ/6ShVhi+/n200Tu2sYy5HByDEcGYB3idws0fYchtD4/p/0g4fzQ/G1cJSINeCqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123062; c=relaxed/simple;
	bh=t+LPtWnKwFmta+rcn4kHZtopq4a0rOzX4dLqMmte6o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9JQEWDhFXdJUemxdgjeGeINgS6VWhzu10DDmzwABm/CfLRMRUGit1IBbYu1/YT5hU09L4ytNw2w+AB+k8+TjzNSuetVkW+FXKH8ij0ga0iAwY+IU+qy/zmu9y0Il0qI5qxoLlcRhwCEJpXyCGt4UZ30uAC2YQiO29aaMJrou9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAU08XHS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723123060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XD7FvdIckarUhrXzB2SzlPRAVb193xDecLuQI6dSDYI=;
	b=XAU08XHS94un159PvAU0/MA3klG63Z7eWQFc8WEQuUMnsq6GuQZ8lykhkVALkjHxmW/GoU
	mr2/HR/Vv2GA7cnmMFclVdKjSvNTz6NpIdH1T5D5Am22hlOWpBDHWOXc3jJY8wHQja9sOA
	NkGeN9N5h20V7aemkMF6JL77d02zq78=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-2rSh06GzOoKOsVWkOzbomQ-1; Thu,
 08 Aug 2024 09:17:34 -0400
X-MC-Unique: 2rSh06GzOoKOsVWkOzbomQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF5811955D59;
	Thu,  8 Aug 2024 13:17:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.189])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 182F319560AA;
	Thu,  8 Aug 2024 13:17:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Aug 2024 15:17:30 +0200 (CEST)
Date: Thu, 8 Aug 2024 15:17:22 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org
Subject: Re: [PATCH] uprobes: Improve scalability by reducing the contention
 on siglock
Message-ID: <20240808131722.GD8020@redhat.com>
References: <20240801082407.1618451-1-liaochang1@huawei.com>
 <20240801140639.GE4038@redhat.com>
 <51a756b7-3c2f-9aeb-1418-b38b74108ee6@huawei.com>
 <20240802092406.GC12343@redhat.com>
 <0c69ef28-26d8-4b6e-fa78-2211a7b84eca@huawei.com>
 <20240806172529.GC20881@redhat.com>
 <20240807101746.GA27715@redhat.com>
 <3bb87fb4-c32e-0a35-0e93-5e1971fe8268@huawei.com>
 <20240808102837.GC8020@redhat.com>
 <ef7b6889-7e15-1ff3-c7a5-b3c6dabb13d4@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef7b6889-7e15-1ff3-c7a5-b3c6dabb13d4@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/08, Liao, Chang wrote:
>
>
> 在 2024/8/8 18:28, Oleg Nesterov 写道:
> > --- x/kernel/events/uprobes.c
> > +++ x/kernel/events/uprobes.c
> > @@ -2308,9 +2308,10 @@ static void handle_singlestep(struct upr
> >  	utask->state = UTASK_RUNNING;
> >  	xol_free_insn_slot(current);
> >
> > -	spin_lock_irq(&current->sighand->siglock);
> > -	recalc_sigpending(); /* see uprobe_deny_signal() */
> > -	spin_unlock_irq(&current->sighand->siglock);
> > +	if (utask->xxx) {
> > +		set_thread_flag(TIF_SIGPENDING);
> > +		utask->xxx = 0;
> > +	}
>
> Agree, if no more discussion about this flag, I will just send v2 today.

Please also resend the previous patch a 1/2, this one as 2/2.

Oleg.


