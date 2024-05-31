Return-Path: <bpf+bounces-30998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AE68D5B48
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 09:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B111F231C6
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 07:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130C77D3EC;
	Fri, 31 May 2024 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bx6qcNW7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XXfotPbS"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496CA187569
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717139761; cv=none; b=hk0hanaqbdHunGhFBI2cxIVN96nuFfgvkOR1YQn1hOHyCkli3FXDT8f1Eg8fk5B2RhBiEZ36QQ1hCwSxdMcYGmLdjTq1rOj9YZOolRPSJQeBmWs9q4IntCACditGaLVuwi7SLYG5/GXW1Agpsu5TlmqtavxmQJYr/a3PhCMmYNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717139761; c=relaxed/simple;
	bh=IXBosl82uOQJBwqVi3otMrjCM2BWJDGFoFA3+BDXU6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3qSIGGZM1ixMVDh5OGVWL0/AMFJfctAdp4AXvAqANcqd4fzX2FwBMedzWWSoTmzh08VrwSwM+qxA0EONXTO1jkqiMmT6mXZguzoP1PH/q9gYop9DK072WeClkyZg+F2/Y8cW0vZrxZtbGA559sQkPUv7jggrs27BJRY+rPEezk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bx6qcNW7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XXfotPbS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 May 2024 09:15:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717139758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vXnpc3+gZnC/App0Kg7P27p6yn7PQr1jam5gCBe4D5k=;
	b=bx6qcNW7qbuRBJXUIChTyX1W5qwGSc7x7bX31ALMCHqwP8toU96AnvnB56pXIpU3tj4vKG
	OwMp7nHWPe6dVdOyQ9u72Dtjofmqnf3fLg/08TaEAp6qAFcpg85rkULXywu7wYrltoRJmA
	J0AI5IOgak6A38bn8BRs1uepBKuG6R9M/h1Jgc4y5VYUH2GMrJYn0hmJnQFux+4p/Fm86v
	cfMFoXLC1sk/XJUUu8IF/LkxjHEp9rAvkq6wEFeDt54WYbMokqSeCTiu8Qxcp3K4N9iIol
	NsVDd88rNzxAEv93T9Jiehr0ERH1xr5YOei63aTzlBzWJdlSnx5dECL1K9+nUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717139758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vXnpc3+gZnC/App0Kg7P27p6yn7PQr1jam5gCBe4D5k=;
	b=XXfotPbSF3+Xega9BMDQrGMMEsDgerRHs2g9AvwJOYaVFY4tbB9WnnJ5dTkpH51WlhsY38
	YKNb7mdh+0h25+AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] bpf: Use an UNUSED id for bpf_session_cookie without
 FPROBE
Message-ID: <20240531071557.MvfIqkn7@linutronix.de>
References: <20240529124412.VZAF98oL@linutronix.de>
 <CAADnVQKdAo-=DMMyLJaAR_CHBZq=W=LsYxk=Tna2G+tXLnfLqg@mail.gmail.com>
 <ZleDQSK4TgJLJDUl@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZleDQSK4TgJLJDUl@krava>

On 2024-05-29 21:34:25 [+0200], Jiri Olsa wrote:
> > > +#ifdef CONFIG_FPROBE
> > >  BTF_ID(func, bpf_session_cookie)
> > > +#else
> > > +BTF_ID_UNUSED
> > > +#endif
> > 
> > Instead of this fix..
> > Jiri,
> > maybe remove ifdef CONFIG_FPROBE hiding of this kfunc
> > in kernel/tace/bpf_trace.c ?
> > The less ifdef-s the better. imo
> 
> yes, that seems to work
>
> Sebastian, do you want to send it as v2 or should I post it?

Now that I look again, ifdef CONFIG_FPROBE isn't enough it requires
additionally CONFIG_UPROBE_EVENTS.
So the suggested snippet does not work if CONFIG_UPROBE_EVENTS is not
enabled.

> thanks,
> jirka

Sebastian

