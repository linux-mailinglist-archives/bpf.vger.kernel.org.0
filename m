Return-Path: <bpf+bounces-16248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B27FEC89
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 11:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C924B20F89
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 10:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8EB3B2A7;
	Thu, 30 Nov 2023 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ekx2Vemd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB03110C2
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 02:08:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54bb5ebbb35so704158a12.1
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 02:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701338933; x=1701943733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pU1Dt1yyginx2DG4N136TqohymuHJi+12Xjms/nuiLY=;
        b=Ekx2VemdmZp6eTTxlRsLU2vAJrKC8C/OFs0S8PIS53FGbYtQmm/ASKXPeXdv6MJ9uM
         c6AF8qo+sU73IIG6Hd2FkRC1aLV5Sqgq1KuqILrVFg9Tw6CYBv81+AKTkv/3yNLXQlJV
         vsrWLmWKt1KRMBHPskZkmgh6iNEH/028oTSze2s+igc+qP2eb0BNweGFQKmUuBV9Uv04
         8aETz4ghcShgrG5CrZ+DOFSn9lN9J7BstpZdOB55GX9Sx/UKQEw3HEoXdMZ7ZRckjq8M
         62BsKCOxEZVxMbAJx6XygKMQJQ5yVh5ANFGvzuVOykh2h97WnRXCN4I1QRSkjVyykOJP
         0gxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701338933; x=1701943733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pU1Dt1yyginx2DG4N136TqohymuHJi+12Xjms/nuiLY=;
        b=tpqCRESTqowUdnmFVn2l1n3osAVZ0iZkCUKcWH+nX8GbDljWpPy7XdaPddJM+YO/zp
         z2MyqvCvUNZZLeEDEWmZK7DBqNv6Tdn7NgHPgxElnYVgHcH8lZvXN28tHRBdc/yyLGYq
         gddJZMLKHeBixvLTgf2JwR20/s2ZbAfCsI6CqWVp4/UJiLUBXySAsy9rbysek7WUt394
         th8lawunAfRLw7TdONQAEUouFIvjQvXlTiKviWKlIyrhZR9UkaLV2i75hBX7QkPuuVb4
         vhvb4Y8xeSm5gAy4A6GcaD/jKjbhocIW8la5UuY+8CSpsYm+xKO8rr80G9jgcU40LKVJ
         6RPw==
X-Gm-Message-State: AOJu0YzIIRByDaq4txfvRsfqPN6RtaByU67qQjnp4Cutn0/UPiC9BVF4
	PjVelUk6WYtjP8jfYccdAITryHZ12JGsFQ==
X-Google-Smtp-Source: AGHT+IHpUGBNW5lgVlpjwbNAaeAraiY50dvIsawvGmWi7dIjUsAnE+x0JY+Of10FjKigZHt4vRX+qw==
X-Received: by 2002:a17:906:b20a:b0:9e6:4410:2993 with SMTP id p10-20020a170906b20a00b009e644102993mr11501793ejz.18.1701338933034;
        Thu, 30 Nov 2023 02:08:53 -0800 (PST)
Received: from ddolgov.remote.csb (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id my18-20020a1709065a5200b009f28db2b702sm497958ejc.209.2023.11.30.02.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 02:08:52 -0800 (PST)
Date: Thu, 30 Nov 2023 11:08:51 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
	dan.carpenter@linaro.org, olsajiri@gmail.com
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <20231130100851.fymwxhwevd3t5d7m@ddolgov.remote.csb>
References: <20231129195240.19091-1-9erthalion6@gmail.com>
 <20231129195240.19091-2-9erthalion6@gmail.com>
 <CAPhsuW6J+ZN7KQdxm+2=ZcGGkWohcQxeNS+nNjE5r0K-jdq=FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW6J+ZN7KQdxm+2=ZcGGkWohcQxeNS+nNjE5r0K-jdq=FQ@mail.gmail.com>

> On Wed, Nov 29, 2023 at 03:58:02PM -0800, Song Liu wrote:
> We discussed this in earlier version:
>
> "
> > If prog B attached to prog A, and prog C attached to prog B, then we
> > detach B. At this point, can we re-attach B to A?
>
> Nope, with the proposed changes it still wouldn't be possible to
> reattach B to A (if we're talking about tracing progs of course),
> because this time B is an attachment target on its own.
> "
>
> I think this can be problematic for some users. Basically, doing
> profiling on prog B can cause it to not work (cannot re-attach).

Sorry, I was probably not clear enough about this first time. Let me
elaborate:

* The patch affects only tracing programs (only they can reach the
  corresponding verifier change), so I assume in your example at least B
  and A are fentry/fexit.

* The patch is less restrictive than the current kernel implementation.
  Currently, no attach of a tracing program to another tracing program is
  possible, thus IIUC the case you describe (A, B: tracing, C -> B -> A,
  then re-attach B -> A) is not possible without the patch (the first B
  -> A is going to return a verifier error).

* I've also tried to reproduce this use case with the patch, and noticed
  that link_detach is not supported for tracing progs. Which means the
  re-attach part in (C -> B -> A) has to be done via unloading of prog B
  and C, then reattaching them one-by-one back. This is another
  limitation why the case above doesn't seem to be possible (attaching
  one-by-one back would of course work without any issues even with the
  patch).

Does it all make sense to you, or am I missing something about the
problem you describe?

> Given it is not possible to create a call circle, shall we remove
> this issue?

I was originally thinking about this when preparing the patch, even
independently of the question above, simply remove verifier limitation
for an impossible situation sounds interesting. I see the following
pros/cons:

* Just remove the verifier limitation on recursive attachment is of
  course easier.

* At the same time it makes the implementation less "defensive" against
  future changes.

* Tracking attachment depth & followers might be useful in some other
  contexts.

All in all I've decided that more elaborated approach is slightly
better. But if everyone in the community agrees that less
"defensiveness" is not an issue and verifier could be simply made less
restrictive, I'm fine with that. What do you think?

