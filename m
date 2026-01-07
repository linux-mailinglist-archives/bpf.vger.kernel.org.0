Return-Path: <bpf+bounces-78092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5510BCFE12E
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 14:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4668D3002516
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 13:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B163533B971;
	Wed,  7 Jan 2026 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZJip5cq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498733B6F6
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792302; cv=none; b=GifSliU4N/wVfV0cDPs0emjiXRLSNkHLy0nAWROZtakXQaT6LnWwV6HI4zgc4pdskJjSEUwiU68llCV16S7P6Rx4ettumG9L2Wr9ZSCgIm1oixv6Qh0dwmpEL5phK6MJXt8jrTd6kSmBMJuc7Hy94RM4GOAMh69pfzhwTXN0EXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792302; c=relaxed/simple;
	bh=yEqsB60VUUiSvZef4yR/lKFwaZig+oFC8NOOkXv0P8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+nyfGARG2yJTwQrScHr/O+PUOTtktXqpofDWvOCFSx39ZkgMkJpSkqR9MIuyXwmaXHx3Uh3TG3Qu3MAjhNIbvvDjNOpaHg3yECz9DHv0/oMqFXG5RcLqprrOxBb+MAjeBobfaJ8sOYpgsFB+XsEYH4cyWKF90blDiNcGgMhjLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZJip5cq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767792298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTXeW4ZAylqeo4C6/c+qkj78SBOOk3H0bhNujdt3nhA=;
	b=hZJip5cqgboqGgMr/pSyOjpJh1cNxZAMZsjhnTHeDEmJNH5YKKIPi5SH/tIfB0gQnRVGN8
	M6y+8E63i/m0n2Nz7t8GHUrxaDoC6j63oOsMVy0nafaGcmo783gpWsDUqxg/AB0FRQ260d
	Fj/9H6qQnxqDwUNlA33wdqChyb+rAoU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-zok6YRCQNFi_sp_IKN-hxg-1; Wed, 07 Jan 2026 08:24:57 -0500
X-MC-Unique: zok6YRCQNFi_sp_IKN-hxg-1
X-Mimecast-MFC-AGG-ID: zok6YRCQNFi_sp_IKN-hxg_1767792296
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-382f6aca49dso8997681fa.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 05:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767792296; x=1768397096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WTXeW4ZAylqeo4C6/c+qkj78SBOOk3H0bhNujdt3nhA=;
        b=eaRmeK5O9hRMSJTsKLbNS29vmEXVklrzehe+5buyOg3Bs7zk7Tc8bFg0skzfywzHc3
         Jl+JEA35kYnSUSCQLJFqcadKh58IeU1GAPcES9Z6U3fGyhnu5ni/K0b6ks0JwU9SZyBT
         qpvnjU+ZZMOw7ko7JX0ZoVoC+F05dZ9EDzDsHN5V7YHvgx+6oT8g5biTvYaOOapJOodK
         yillrzuuDUfuJKxh2lhekZblGSoiH1lIyqeyylSrvETx27tmoNk7OVlxtDLpH48TDPmt
         kX+KP41VWKvItc3nBBuSl5TlcfsWawm1Kit4pQG1SM8wiajhzzqLPykA8QZynYh6ZN6Q
         nvtA==
X-Forwarded-Encrypted: i=1; AJvYcCUCr1ZBF+3hTBvFnGWoOfktoZPnULhk2mH7p51T8EaIs3r+tZUP27bEqs44Kcd8JqH56VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0q8/t4BvACLG9zShyNLQ5VkK6PbYhPHW9rip2fZ+toQeT3DDc
	kaL0MnT8bOlOSIaSGKtyC+IKP0Hzj93tgcMn8iwHM7ohl1reLDJhimYofjUEfCww/IygAM19K1M
	OQulS0kDFrd7FoIe5xDhfnt/7TMvtAYG5dziWi9eEv/tVlSY6knzpXeE5QzldlFSwM5u7dRfshA
	tf4X9v+HAhYQNnUMmDRKPIWIfpUMnf
X-Gm-Gg: AY/fxX7krieYd9i+g5bF/0UYHuNLrl3Q40lWCVWUyj8aLQQAyCMFo+x1vmw3IuTJxUU
	6tGW59m3kfZ0ML/mdoT9+IY6e18Bj3zSexnNMHFc0ei3QBMqq4JJrI1e4NgJcC8bNYiPKMq6kON
	v/FT8YnDIGf/tYM7Cds0PhLdRUEXGJTE77VNleWcdwRajAraV5sMO4pmHwb2XERo5BgR+Q+yA3N
	fFZp3WPMrmSUZLUqo+ylSoPKwtSH+RtJkDgKiu3rWg5KntRbWlb60l/loy4VJ7ZvTEjBevhdsqa
	AMrwSOOLxANf
X-Received: by 2002:a05:651c:4cb:b0:37f:e645:9aaa with SMTP id 38308e7fff4ca-382ff68f5d0mr7278971fa.16.1767792295542;
        Wed, 07 Jan 2026 05:24:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyawBIep3Ik0XO0p0nY5zOT4BWCobPTD6vp/nnCBtidrWgs1APGZFenLumvjNgvAs21TAmCXukSA/QbA3PgoY=
X-Received: by 2002:a05:651c:4cb:b0:37f:e645:9aaa with SMTP id
 38308e7fff4ca-382ff68f5d0mr7278881fa.16.1767792295044; Wed, 07 Jan 2026
 05:24:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-16-wander@redhat.com>
 <20260106110519.40c97efe@gandalf.local.home>
In-Reply-To: <20260106110519.40c97efe@gandalf.local.home>
From: Wander Lairson Costa <wander@redhat.com>
Date: Wed, 7 Jan 2026 10:24:43 -0300
X-Gm-Features: AQt7F2pnk_lk_Dg3GLoifyjkvvfBEFoRWSzObyVIZ9HVC1Wwtre9bKph1GmQoxA
Message-ID: <CAAq0SUmW7mUP0iiHMJevR+T6BKHJiFoU4M8sCVjJSRMFnT2J_w@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] rtla: Make stop_tracing variable volatile
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 1:05=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue,  6 Jan 2026 08:49:51 -0300
> Wander Lairson Costa <wander@redhat.com> wrote:
>
> > Add the volatile qualifier to stop_tracing in both common.c and
> > common.h to ensure all accesses to this variable bypass compiler
> > optimizations and read directly from memory. This guarantees that
> > when the signal handler sets stop_tracing, the change is immediately
> > visible to the main program loop, preventing potential hangs or
> > delayed shutdown when termination signals are received.
>
> In the kernel, this is handled via the READ_ONCE() macro. Perhaps rtla
> should implement that too.
>

I considered that, but, in this use case, I saw no point because it
didn't bring any advantage and volatile was simpler.
Furthermore, as Crystal pointed out, using volatile for variables
shared with signals is a pretty standard practice.

> -- Steve
>


