Return-Path: <bpf+bounces-18379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BCA819FA8
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 14:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036DF1C23876
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D422576A;
	Wed, 20 Dec 2023 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ4thtR6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A092576F
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5533ca9cc00so5227709a12.2
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 05:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703078234; x=1703683034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G/alaEdekjEfTnJZiyWTdS1oE8V6HHp/FgVdnZYANGA=;
        b=DQ4thtR6P6sjW+rUSBxe3lCr4A2eZWvQl1P1A8ts3ikyXsYZxElbCdub6b9e7cwA64
         x6KKUHA0QavBOqLR8DyO72IRRkq+MLfjUl4q4aPQnNtenwxstS2moymoVuHSf0rEX3gT
         ddU6uDfhXRgoNhk3Nj4qw6+15lKXrsIY++l/U4JVVXfPUU8TcmVBynjR4rOSI5xjlacb
         BqLzhnqhpfdjbYoSJdp3VOfJiw5IARDwwRKN4K2mEJY6VcZf9+O/8oK1ANsl/moZ/3CM
         IjI2Eu3jngQnzB3NyD8BKFjr/+s3QAGOmXHcncXkMcRjD/fxagvWB2H9SWlTBpn+ZuHC
         womg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703078234; x=1703683034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/alaEdekjEfTnJZiyWTdS1oE8V6HHp/FgVdnZYANGA=;
        b=A9sOzGu4P2ufVhhfN3THBK9VNJ4gpGWohqDaJReKsv9XQcB4k22aINPyetII6Uxgsw
         i7UXN6siWKsZKfz2cSMRrvGKQkp6Ax8+xUgZLapGvu9RyctjZjkEUYk7uACN2fizoQ6b
         ZR7DWgNsxKbGFJ1ETIE6d0fjjj/zuhbO1ppnZFR5DNh2j1ofEqZwX1HgYO+XnvW1xpO3
         QiCbmIGQ4c0OJwUvowG3kh5Mc2hHX23gN15zpuzpprzVZOgRnNd136F02GVTJOW3Twba
         rUQ3qi+684bxq9esYcP7XVcJoLu6t3c35bfd6alXFk5ifiWfLbqkSNYW+t6irbFXxTb3
         W2VA==
X-Gm-Message-State: AOJu0YwUZlECbqdF5iBQf+4oE78ooV5yBjdyzwRMop+cKsKmaKN2xoar
	X6XgjjFG5nc04qBl1rTXK5A=
X-Google-Smtp-Source: AGHT+IHJr8DrALTUw7m4RpgFn5CpU0RzGKgJsZC0E7XnQp2zDfiFGYH83zQvbSGo4dZ/VPORybky6Q==
X-Received: by 2002:a50:bb28:0:b0:552:e43d:cc7c with SMTP id y37-20020a50bb28000000b00552e43dcc7cmr5057461ede.16.1703078234135;
        Wed, 20 Dec 2023 05:17:14 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id q29-20020a056402249d00b005528265bc41sm6394064eda.0.2023.12.20.05.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:17:13 -0800 (PST)
Date: Wed, 20 Dec 2023 14:13:29 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	asavkov@redhat.com
Subject: Re: [PATCH bpf-next v9 1/4] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <20231220131329.3m6ko2vgzpc3rbx3@erthalion.local>
References: <20231215200712.17222-1-9erthalion6@gmail.com>
 <20231215200712.17222-2-9erthalion6@gmail.com>
 <CAPhsuW4VJ-wS_Jh9VCMAvLtbd9djtDikApH4NYCo9+Jgqz8eLQ@mail.gmail.com>
 <ZX9KY-uouFF1Doz3@krava>
 <CAPhsuW4SfDEPy3sxTTr2VPYCW7ysM+ACUHwzuAcniy9-cgan5A@mail.gmail.com>
 <ZX_5AhpYjcX06feL@krava>
 <20231218201019.a25qr3scjcturpt4@erthalion.local>
 <20231220075543.vcuasod3zyx6uqgp@erthalion.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220075543.vcuasod3zyx6uqgp@erthalion.local>

> On Wed, Dec 20, 2023 at 08:55:43AM +0100, Dmitry Dolgov wrote:
> > On Mon, Dec 18, 2023 at 09:10:19PM +0100, Dmitry Dolgov wrote:
> > > > > I guess it's corner case that does not make much sense, but still it
> > > > > feels more natural to me to set it in attach time
> > > >
> > > > If we set attach_tracing_prog at attach time, the following will
> > > > succeed:
> > > >
> > > >   load (fentry1 -> kernel function)
> > > >   load (fentry2 -> fentry1)
> > > >   load (fentry3 -> fentry2)
> > > >   attach (fentry1)
> > > >   attach (fentry2)
> > > >   attach (fentry3)
> > > >
> > > > We can even make attach chain longer, as long as we load
> > > > the chain first. This is really confusing to me. So I think we should
> > > > set the flag at load() time.
> > > >
> > > > Does this make sense?
> > >
> > > yes, I did not consider this option.. makes sense
> >
> > Thanks for pointing out this case folks, haven't thought about this
> > either.
> >
> > Just for me to clarify explicitly, the reason why the case (loading a
> > chain and only then attaching every program) would work is that there is
> > no additional bpf_check_attach_target in bpf_tracing_prog_attach when
> > the trampoline is getting reused. I've tried to change this a little, it
> > seems to possible to prevent such situation, and still keep
> > attach_tracing_prog flag at attach time if there will be one more
> > bpf_check_attach_target.
> >
> > At the same time setting attach_tracing_prog flag at load time would be
> > probably less invasive, making it more preferable I guess. Will post the
> > new patch series with this change soon.
>
> Thinking about this more, it seems setting attach_tracing_prog flag at
> load time should be done not as a replacement (what I've assumed
> originally), but in addition to setting it at attach time. Otherwise,
> reattaching the same prog will lead to an inconsistency.

On the second thought, at the moment it's not allowed to change an
attachment target for a tracing prog. Which means the attach_tracing_prog
flag could be set for the whole lifetime of a tracing prog, from load
until release -- this way there is even no need to change
bpf_tracing_link_release, and the fist patch will become smaller.

