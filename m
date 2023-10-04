Return-Path: <bpf+bounces-11347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942607B7785
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 07:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A08BC1C20915
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 05:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BCA5672;
	Wed,  4 Oct 2023 05:40:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B11C15;
	Wed,  4 Oct 2023 05:40:48 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70294A7;
	Tue,  3 Oct 2023 22:40:46 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so1284370b3a.1;
        Tue, 03 Oct 2023 22:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696398046; x=1697002846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sxPSsTdItOhFW3wfJ8BpxEBHfTI/E9UO9SmffybOvI=;
        b=BVQD+oRo8Bl6HKM+IiSPbUQFBOPogmHnOM3gwP9YmxKzoFHEmqqioTAI5Y23UCcl4j
         GGPdPSqQGT7aODQOyESyScwodrMN8AdKh33U3R3ToNA39xFYzeUlC28l0mOVK6onMNxP
         Gvye38/BYBa0CXiaPlGxAF++dOEFOP9aDPfxiENUVxC9ejk/T/y1+Wj0ctQQ1BzVsp8J
         9jdNVYMk6SsSxREEQ62HW/BdmxpM6O7XXHVq6yUGP32fW4y9cXNFRUbBwujpclH599Vg
         iQjgIJ4vHIFhDTI254QBG8YSqq2yXI+IHnBGAeHfK73EYjs6DmKGUsALZVI1j5pJBWtR
         rg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696398046; x=1697002846;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7sxPSsTdItOhFW3wfJ8BpxEBHfTI/E9UO9SmffybOvI=;
        b=v0LJvZey5+hqyRO+6CwqfqkNK8J0Z/1MoJm8I/9euq+rzeKLFU/yJah0+ICZHHrH5+
         BKBbIf3ktM/6hAwXS9H8zdAGWQC/mXm+/wtLBDg5fzApyu2j5zr813w/LvEHa+4uTmmw
         NL3/y50vSL4BHP+tqKNmEetUumR2XpMWLiIM+piZUasxkmuimCWhxhRnjC5iF1hHmifp
         t+Xdkl8wkLagbrk/+clBjo/YhOIrCGSqteA+qyp9npKfehAVpXtBpgJSnL1lbNk36lvl
         +0aBy0JauYq5nvCZQT/0DKqrGm7FmA71b0ycEuzb/7woHkQp3GN9wecVM3XRC3Y5Rh9I
         lTVg==
X-Gm-Message-State: AOJu0YwGfoqnOMz55v4slQUQ6wDRVs1h53NgAvCPGXraLVmABw0G9MON
	wCNY8v0DHw8z9DVR+RL5MAM=
X-Google-Smtp-Source: AGHT+IHcaNH0YjVByl+ZAEBtRjoXIBdb2CyL8t4pmQ69R+3lj6gUKXkLasbD3/LcY1hkgOJPy7+qew==
X-Received: by 2002:a05:6a00:1a94:b0:68f:dfda:182a with SMTP id e20-20020a056a001a9400b0068fdfda182amr1483545pfv.26.1696398045801;
        Tue, 03 Oct 2023 22:40:45 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba00:f1b6:ede7:e209:917e])
        by smtp.gmail.com with ESMTPSA id q16-20020a62ae10000000b0069302c3c050sm2318612pff.218.2023.10.03.22.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 22:40:45 -0700 (PDT)
Date: Tue, 03 Oct 2023 22:40:43 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 bpf <bpf@vger.kernel.org>, 
 Networking <netdev@vger.kernel.org>, 
 "davidhwei@meta.com" <davidhwei@meta.com>
Message-ID: <651cfadbe3308_314bc2083f@john.notmuch>
In-Reply-To: <CAEf4BzaaCvMdKMA=N01Gm1uN2XB_5bcYDZF0oXZR=XyoDePfXg@mail.gmail.com>
References: <CAEf4BzYMAAhwscTWWTenvyr-PQ7E5tMg_iqXsPj_dyZEMVCrKg@mail.gmail.com>
 <64b4c5891096b_2b67208f@john.notmuch>
 <CAEf4Bzb2=p3nkaTctDcMAabzL41JjCkTso-aFrfv21z7Y0C48w@mail.gmail.com>
 <64ff278e16f06_2e8f2083a@john.notmuch>
 <CAEf4Bzb1fMy5beHKxCjvoeCqaYmQFvnjnMi9bgWoML0v27n3SQ@mail.gmail.com>
 <651ba0f13cb51_4fa3f20824@john.notmuch>
 <651ba39d55792_53e4920861@john.notmuch>
 <20231003054156.52816535@kernel.org>
 <CAEf4BzaaCvMdKMA=N01Gm1uN2XB_5bcYDZF0oXZR=XyoDePfXg@mail.gmail.com>
Subject: Re: Sockmap's parser/verdict programs and epoll notifications
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrii Nakryiko wrote:
> On Tue, Oct 3, 2023 at 5:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Mon, 02 Oct 2023 22:16:13 -0700 John Fastabend wrote:
> > > > This with the other piece we want from our side to allow running
> > > > verdict and sk_msg programs on sockets without having them in a
> > > > sockmap/sockhash it would seem like a better system to me. The
> > > > idea to drop the sockmap/sockhash is because we never remove prog=
s
> > > > once they are added and we add them from sockops side. The filter=

> > > > to socketes is almost always the port + metadata related to the
> > > > process or environment. This simplifies having to manage the
> > > > sockmap/sockhash and guess what size it should be. Sometimes we
> > > > overrun these maps and have to kill connections until we can
> > > > get more space.
> >
> > That's a step in the right direction for sure, but I still think that=

> > Google's auto-lowat is the best approach. We just need a hook that
> > looks at incoming data and sets rcvlowat appropriately. That's it.
> > TCP looks at rcvlowat in a number of places to make protocol decision=
s,
> > not just the wake-up. Plus Google will no longer have to carry their
> > OOT patch..
> =

> David can correct me, but when he tried the SO_RCVLOWAT approach to
> solving this problem, he saw no improvements (and it might have
> actually been a regression in terms of behavior). I'd say that this
> sounds a bit suspicious and we have plans to get back to SO_RCVLOWAT
> and try to understand the behavior a bit better.

Not sure how large your packets are but you might need to bump your
sk_rcvbuf size as well otherwise even if you set SO_RCVLOWAT you can
hit memory pressure which will wake up the application regardless
iirc.

> =

> I'll just say that the simpler the solution - the better. And if this
> rcvlowat hook gets us the ability to delay network notification to
> user-space until a full logical packet (where packet size is provided
> by BPF program without user space involvement) is assembled (up to
> some reasonable limits, of course), that would be great.

When we created the sockmap/sockhash maps and verdict progs, etc. one
of the goals was to avoid touching the TCP code paths as much as
possible. We also wanted to work on top of KTLS. Maybe you wouldn't
need it, but if you need to read a header across multiple skbs that
is hard without something to reconstruct them. Perhaps here you
could get away without needing this though.

I'll still fix the parser program and start working on simplifying
the verdict programs so they can run without maps and so on because
it helps other use cases. Maybe it will end up working for this
case or you find a simpler mechanism.=

