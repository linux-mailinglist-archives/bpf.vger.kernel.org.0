Return-Path: <bpf+bounces-66172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0911BB2F4D0
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 359147A2992
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 10:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01C52E9743;
	Thu, 21 Aug 2025 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP++ktQY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8988936CDE8
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770682; cv=none; b=usjwaTtscakmXARZXRjzbGdZmJkIZAv6uU8C0NGIpA25izzPTMMH9oMafyYUAF8Xy5GX9Y4RiIa5HS985w+lOWNR4c8seQxKEjPyrE9gxs+AShdRgAKnsQmL2TZ/0ipWls6qDRn4dlFFgt/+dkXXsV0a+HRP6S/fFXgH+B9YmYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770682; c=relaxed/simple;
	bh=eHtjpzeBUotBe9iJ5shsBWXjPiisjrMOZofLgwf8DmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrxC9fCiN8JILJPDdwu1AKi9KhzxON3Qb2jXn4mpqn5BcXKdaPmBjBBn4mZQjIq2ghTw9ocwLcW82lGmpqRhY/ypxkyXMoLLMaibEf9pRQM109F0cqfvh5lcmfNeOjqkkSoKIp/oFVEXDcy/QPRm+xYNaw7Nzco29OcbCj2GSNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hP++ktQY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1abf5466so5317965e9.0
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755770679; x=1756375479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qSqnNW5BPDmS3JUddq1Dx24H6xetXszPTWmtepLBsE=;
        b=hP++ktQYGMBOo6dtlc1czA0PTinjak+EBQW8pzuAuS4cs8IT94Kf2+1sDkwYjrqf1r
         xKOrACPoJ+/7tIjUbfB9n+Hv+YnvZZ6OQKYXlopxF5FC+r7HVoLXyop67zEDovQzhXS4
         JGGveA1N5NOXXPB7skptPB3r2GJtHEpK7lFjdxaMYdl0JIGSYn/7xek+cpU8qwmr7zhI
         MvjWJzCz3cXgzxpeiNav1W+Y7bDOzh4VSImDoUYA095dcqatsShSRHBq6pJ3Gl++kvv/
         5biImTLuZoITKrPVbSyNkcnKalEaNGDSzcbKq4h6tGnRsunSh/6E71mErw3ti4bUoH8I
         WiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755770679; x=1756375479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qSqnNW5BPDmS3JUddq1Dx24H6xetXszPTWmtepLBsE=;
        b=OcuEvM726G0QGeMTMLrAghrgkFe1egQA++tImAUeMoc+RuUWMnrwDp89ptvpWQ+ZzW
         YjT03PusoslMcELC01gjKAy0hobrdXn0FbtrZVy7QxlRFaSM+33nmJ4KaaAYe5A1kNC6
         aZvFF6yfVc512uWMJ7hZPO9Mt3A5n8xKSt96FM6Rf4TqSxGzv7chCC8ilHNUz2xMqT17
         XE9Tnu4cPzzDbtQRXYxBrvyRcU91abT1KUVhf9BJ/8pv6ZMBWdNVuatzMqshyZpYA2iG
         amIL4geslx9OfDGMIaDQ+10wzdadhUdz/fwk1eyb4PSYSIqDw0PCo4w+5l2RR5YRC4Qj
         GpEA==
X-Forwarded-Encrypted: i=1; AJvYcCWHTtAwjLfuCMtEYQdbXEzwxhK4xCOkndduciwDgEeXLRDtmLDzFi8ziHosrLZmSgeg7SE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvu9vUOUx6CqxBg/eYebPrt4YzrNFRS+fIVq5uSC34ySyvflsx
	vIZn1RVsmXmcOW6hscBlrolJwt6VGJXi2FbtkxZmclg1RVg8dqjmvHN7
X-Gm-Gg: ASbGncvTtwx04AH3VPoFowU9dut0Auqy5M4W2MnA9q03REEH/He2PLIF5oofuV6tgu7
	+LmfhE8YurXvqHfv3npWS+QotG3/GbVgMvGhBRMsUU0wE+f6X9vYiDqm+0QLTwxJf5QLv7Io+G1
	ULbIb3C4G+kkPtUwzbs/v3av9D+2vbX9T5dZmkd54WaIYR7kQXIg6J32FFiNZLxyX4JWPgC9s5U
	Oe9A/P86n3w4rIwyohs7WFwiXtVtDf6CafbsHL0KCYhoS5q2IOxt39skdgNsyTzHwOUrFqz58UF
	2FnaOQQ8hSRk9mtoqFst67etUbyl4Nx/osjLHMvlBEyPxM/hLZaUz7NhgSAB5o9uG1dQ3dWIM9t
	cHQcTXklCnUjIobx9IWO1OGqP+d+lci45bLjjBhW2kBdA6+zVnbsaE6BLOiPUbmjoAuuZY3TTyR
	VFmEjXUO4WS/P2j4wF706Q5Sg8Ke8dp/k=
X-Google-Smtp-Source: AGHT+IE+6GXkISYGbni+uaCAjkw1VzDWAcm9sJXxkCr8OoOVKD4QCrcDcbCgM7Qv9pG6Y3Wc4AVqDQ==
X-Received: by 2002:a05:600c:4f53:b0:458:d289:3e26 with SMTP id 5b1f17b1804b1-45b4d8de8b9mr15459915e9.2.1755770678710;
        Thu, 21 Aug 2025 03:04:38 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00765727e34656ae4a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7657:27e3:4656:ae4a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db387fdsm23361045e9.11.2025.08.21.03.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:04:38 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:04:36 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: syzbot ci <syzbot+ci59254af1cb47328a@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, shung-hsi.yu@suse.com,
	yonghong.song@linux.dev, syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: bpf: Use tnums for JEQ/JNE is_branch_taken logic
Message-ID: <aKbvNM0WDUy7v4DB@mail.gmail.com>
References: <ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com>
 <689eeec8.050a0220.e29e5.000f.GAE@google.com>
 <aKWytdZ8mRegBE0H@mail.gmail.com>
 <6d172613960339eff4b3a9261ef61a2c50f69dae.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d172613960339eff4b3a9261ef61a2c50f69dae.camel@gmail.com>

On Wed, Aug 20, 2025 at 12:37:46PM -0700, Eduard Zingerman wrote:
> On Wed, 2025-08-20 at 13:34 +0200, Paul Chaignon wrote:
> 
> [...]
> 
> > I have a patch to potentially fix this, but I'm still testing it and
> > would prefer to send it separately as it doesn't really relate to my
> > current patchset.
> 
> I'd like to bring this point again: this is a cat-and-mouse game.
> is_scalar_branch_taken() and regs_refine_cond_op() are essentially
> same operation and should be treated as such: produce register states
> for both branches and prune those that result in an impossible state.

I agree. I've been slowly convincing myself of the same :)
So far, the syzkaller invariant violation reports have been useful to
retrieve examples of where the two functions diverge and to deduce
improvements. But syzkaller now seems to be iterating between the same
three different cases of violations, so maybe it's time to look at a
more generic solution.

I assume you would call regs_refine_cond_op() then reg_bounds_sync()
and use the result in is_scalar_branch_taken()? Most of the impossible
states are only exposed once passed through reg_bounds_sync().

> There is nothing wrong with this logically and we haven't got a single
> real bug from the invariant violations check if I remember correctly.

That's correct. We also have pretty good coverage of this logic in
selftests and now it seems in syzkaller as well. Agni is also
continuously verifying reg_bounds_sync(). So I think the risk of relying
on regs_refine_cond_op() and reg_bounds_sync() in
is_scalar_branch_taken() would be low.

> 
> Comparing the two functions, it looks like tricky cases are BPF_JE/JNE
> and BPF_JSET/JSET|BPF_X. However, given that regs_refine_cond_op() is
> called for a false branch with opcode reversed it looks like there is
> no issues with these cases.
> 
> I'll give this a try.

I'd be happy to contribute selftests extracted from the syzkaller logs.
It's still hitting three different kinds of invariant violations: the
one reported here, the one addressed by my patch, and another one.

And I'm of course interested to run any patch through Cilium's CI to
check the complexity impact.

> 
> [...]

