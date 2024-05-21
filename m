Return-Path: <bpf+bounces-30082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD1B8CA5FB
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 03:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9050281DE1
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EBBFC11;
	Tue, 21 May 2024 01:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O89gPZ2F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AD5848A;
	Tue, 21 May 2024 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716256364; cv=none; b=n2pj+Gj6SELDuEw24Gzp2d+iyEXty0Ivw9ioXc+0D5rbCRIvpFTmB2R7QVDYXYEdwOxcJBsbJwVxyomBvDJmoCYmeRmKDoMe1zZ+SZkVJJxIEuqFmi6h/AqovPTZ8nuhhH9zdVO0eWS2HYkt0C+wkX3iYJ/cVDXK6kYVXa1cOPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716256364; c=relaxed/simple;
	bh=ufxSg3xyf/Gj6U1EQfafcgtdoMatyKkEh7vkXarvHUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Od3qkjI2/PIomRm2a9VTeFZMNbFmVZO3vvqfpGNywWMSq1c+9HMKcK/RQ+tsnV8R9OCZPd2iqJurK5chJNbu4etr+p009QYuXVtMpOgsJIjpozNk0FpRJghN622SbghL8WLflmMkvvnxFpRjgyF8v+gJtWgViOJEWN1WBQ8qZbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O89gPZ2F; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-420298ff5b1so37073805e9.1;
        Mon, 20 May 2024 18:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716256361; x=1716861161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePtZldgSJpBB0VdXgkJqxbFpcqfbGSYwOlaG2fUCcJA=;
        b=O89gPZ2F3WyRYgxF0gTklyHiai03R/aQ0BXPAsCO0VRoNvd5hfFCLYTifs4h7V1w+y
         y33zX1kxgCgoUoI4lE0H8A4I0hJJvl8JnM2nt6ecw0hY0p5pS3qRxa9Tf8PQEg8+wHXX
         Am2CFuU5eKoqwvUWBeI/wpBzztL1PROLPZfeo1fLhWt64QNvzXpZuxo7nX9jf218hb1f
         v/ZAIENxn/qJgR1Xcda8z7G3C90BPbvLcJwBYGG4lt15gasL1QEZ+LWfrbBUg6ZDwT1T
         oICPkkAjZrU2T8a9yvB7+z1iEoyJohmUj0UT4Zisa12Vbtb5G1pcNpVrqQFcsEymbCXM
         Ou2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716256361; x=1716861161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePtZldgSJpBB0VdXgkJqxbFpcqfbGSYwOlaG2fUCcJA=;
        b=XHxTHCKPYwnk5kokG4ko2TNO6AkiJiWkIkncw3cPntUCOkRbNJFKlRtHujq7PpKqe4
         7t9b1ka/Cwu7CcpVJesNy/ITnpRAWDz+j3/RKin/ubwcPhulDin1trUdAmHg246PuCKo
         FMF//3MmKQAN8nBQ7feNdmg20GGmydLwWIoLM5sKyaVYZU1vFvlBphEgHTjjLntcYli2
         c9DG53L4YVgIVMAuFRI4ZFxqfq4KMKHbwEU8ix6V8xqgJVqQ70cItmvWJNs8laubEuHI
         Xm1bTwJBg4QtPM0MowDyikOXwt24QXJlm8qUASI64nSSBLGGPrIQWV/0rUQeG4IdkQrV
         fhOg==
X-Forwarded-Encrypted: i=1; AJvYcCXsXcCVYOnXtueJWynp6EP0KSxeyQnD3K6vCT8I1iFRVsS/zpoqX6po3jX2wl2QVk5hJsS3aD92/C3eRdfzGqldxDfTZmm/o1cORClJWYAMeIMYYF52yCKbSsSvfu/zkQocY/bPVMqOMP1+1rqC2smnnmvvYQO/tB9n
X-Gm-Message-State: AOJu0YzH7x9xeZdLtLWjkFeuZu2KYeu8CQpEh7Qeqe48GJnvoENDsyg2
	cAWbCIQPBWvvONCJphsCFtFf65sbVPGhnAo8ImvkEQfYuVjel8t+2qK2TBTtWOQA3bF7Fcq/iA2
	ptupmZiRYjh39pqUMMpP6DPP5o68=
X-Google-Smtp-Source: AGHT+IGOCjc2BLxw1M1H/c0jF9Rs0DN26uV8RPxMbaEyt4wz/O5ciNgzKHc3NGQiIN8S8JiiRNsVacuNxy3RYrqpfzE=
X-Received: by 2002:a05:600c:5601:b0:41a:adc3:f777 with SMTP id
 5b1f17b1804b1-41feaa38ec7mr304760275e9.16.1716256361431; Mon, 20 May 2024
 18:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <20240503182957.1042122-15-bigeasy@linutronix.de> <87y18mohhp.fsf@toke.dk>
 <CAADnVQJkiwaYXUo+LyKoV96VFFCFL0VY5Jgpuv_0oypksrnciA@mail.gmail.com>
 <20240507123636.cTnT7TvU@linutronix.de> <93062ce7-8dfa-48a9-a4ad-24c5a3993b41@kernel.org>
 <20240510162121.f-tvqcyf@linutronix.de> <87le4cd2ws.fsf@toke.dk> <20240515134326.14x755Wb@linutronix.de>
In-Reply-To: <20240515134326.14x755Wb@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 May 2024 18:52:30 -0700
Message-ID: <CAADnVQK53MOZiLnB-qnQG+ADWGcEMzT0Y0DDdxMKFz9t5n0U1A@mail.gmail.com>
Subject: Re: [PATCH net-next 14/15 v2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eric Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 6:43=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-05-14 13:54:43 [+0200], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -1504,6 +1505,8 @@ struct task_struct {
> > >     /* Used for BPF run context */
> > >     struct bpf_run_ctx              *bpf_ctx;
> > >  #endif
> > > +   /* Used by BPF for per-TASK xdp storage */
> > > +   struct bpf_net_context          *bpf_net_context;
> >
> > Okay, so if we are going the route of always putting this in 'current',
> > why not just embed the whole struct bpf_net_context inside task_struct,
> > instead of mucking about with the stack-allocated structures and
> > setting/clearing of pointers?
>
> The whole struct bpf_net_context has 112 bytes. task_struct has 12352
> bytes in my debug-config or 7296 bytes with defconfig on x86-64. Adding
> it unconditionally would grow task_struct by ~1% but it would make
> things way easier: The NULL case goes away, the assignment and cleanup
> goes away, the INIT_LIST_HEAD can be moved to fork(). If the size
> increase is not an issue then why not. Let me prepare=E2=80=A6

I think 112 bytes or whatever the size of bpf_net_context is a bit
too much to consume in task_struct.
Yes, it's big, but there are systems with 1m threads. 112Mbyte is not
that small.
bpf_net_ctx_set/get are not in critical path and get_ri will be
inlined without any conditionals, so performance should be the same.

