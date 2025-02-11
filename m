Return-Path: <bpf+bounces-51189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B8EA318AF
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 23:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187C0188A552
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 22:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F89268FFA;
	Tue, 11 Feb 2025 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="faCHSE5A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08EB267715
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 22:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313429; cv=none; b=e4Rfu161/U3MyxqQDpfxtxYvmXMizU8VzjfCQNxplA5zkHO5RorEN05xb90bCqy7Edo106IHZdJQV5vlqe5YME3J9yTHnZu691U/wC+r/PvCco+RmeIKLIaSDDmXlSlueDW7jU4o7Mgud2WMmf+3UtG1JbwYZzP9q/JNZLDR3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313429; c=relaxed/simple;
	bh=q1sN3kNwFoYv6srTktzz9x4Q+lTtCQc0zhJJvewJyGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS82t6sim75e6MN1vt6dsQjLOglItgd7Z7GTDPnU1pxLjgGFM7lVfY+jmg4Add94qMDYFdtuVRve5v7N0ITs9iibuAVPooPnt4NQn8yPs+Mpsjfj73WkwEeH+Jbz2Bj2BRi6ljP/7nFwC4xP0JHerG9ZlW6Og58vLTExpwsRbo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=faCHSE5A; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa3fe04dd2so5847056a91.0
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 14:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739313427; x=1739918227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zqgo0vzIUKhLbJdiVtuoHIz5/r7b8o5h5B5NAwoEKTY=;
        b=faCHSE5A4Z3Dr+go34j0gmTWQHw/sNVarD1wLQstYyfPXs1B9Q1tsd3XOH7PNg/nVr
         3uTo6XvuEeSc8QpA8ZsAunYcDTtsI+BS1v8hjNUTXzr5W3ntKy+n/A6nkwNJzRzPvHBF
         0G+p2+12BYak4tp25+6QPjRVZ3eRDRVkKT6jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739313427; x=1739918227;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zqgo0vzIUKhLbJdiVtuoHIz5/r7b8o5h5B5NAwoEKTY=;
        b=DVNdQpGdrLWy7Qiwc8Acf8W65vJaZgYeO1eFbmEtb1+woek91xusI6nKkeSDvGcpND
         e66w73ozpgWtYYfyyi6d2A+I4qMlmmsx4skYeTqa6jBbOUEGjHtfz4oJs4g61o2T6y+k
         2ZuI2QdRR4MKYlIiRC85MQUHJziw3+/E1d8louGJ6c0KZeDdbLx/EGUyMTftzYHwzLSs
         js1Tm5pHzJA0UOTsag7wmJkTaifOwNzAjtVbZ8e1uJXZtEodGKVSt/tY6JpAIi5N1vmW
         JjWyIri7+JR3APZvaPDIgnS54FsTovxeOb5qpPZtJTa/29iH/yazjUW1eFUKcBvcxTYb
         W6Og==
X-Forwarded-Encrypted: i=1; AJvYcCXo0fsoSm3We8iQ7rXB+0Zd0af1qw7dHDr7TurhMxGenGlZe5xpZNs38QJqxwOeeZ5S3jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdKMncFta0M00ylfMmiIwN+OTc0lXDKSfCBDYMlIOJdW9G/LHP
	7vQ0J7guBh1ZKWpOmAd9tiSPVuRNKk1kUUPoMZTfKrzuK7r6jrc6GVHyAjPBETU=
X-Gm-Gg: ASbGncsa4/tgrqdi+DxTUWuprrdhvraKRbBuaiL6JbJ9eOrqJCK3v7XLz6SQPzI36Z3
	wF+B2Z/QlQ/Czy+Y3ss196cXavTBy+nPmNkkkfRZ3i2IDYa7SE4LwgwU/G5YDvAyDp5AnR2GlzF
	XMXbCxjgec45BnvBSWbUKaib40UryWRGUJLfgcV+IVBPbqx/EqYLP5MGH+Y3kFPS4oP78zCmffO
	PdHJWouXTsdqi32e7RK1ut3g0Yd182DI6GSWE3/oEpyF9sxYnmg0HHi0VVazYKbCETnUGTr5Fi9
	iPsziMksaHKFZQwxUm2wK7n4+tgzST1yxPmfWJt4NDWDwyGwV3PXDe2bqw==
X-Google-Smtp-Source: AGHT+IF2E+oD8rBAN01jy8O5/Q4OjPQUXJDe986T7YWkvAoRYx6xoB7ddaApRGSCt08+uRl+E8LH+Q==
X-Received: by 2002:a17:90b:1f82:b0:2ee:3cc1:793a with SMTP id 98e67ed59e1d1-2fbf5c6d3eamr1174780a91.29.1739313427133;
        Tue, 11 Feb 2025 14:37:07 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36560c94sm99647275ad.91.2025.02.11.14.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 14:37:06 -0800 (PST)
Date: Tue, 11 Feb 2025 14:37:03 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	horms@kernel.org, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v6 3/3] selftests: drv-net: Test queue xsk
 attribute
Message-ID: <Z6vRD0agypHWDGkG@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	horms@kernel.org, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
References: <20250210193903.16235-1-jdamato@fastly.com>
 <20250210193903.16235-4-jdamato@fastly.com>
 <13afab27-2066-4912-b8f6-15ee4846e802@redhat.com>
 <Z6uM1IDP9JgvGvev@LQ3V64L9R2>
 <Z6urp3d41nvBoSbG@LQ3V64L9R2>
 <Z6usZlrFJShn67su@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6usZlrFJShn67su@mini-arch>

On Tue, Feb 11, 2025 at 12:00:38PM -0800, Stanislav Fomichev wrote:
> On 02/11, Joe Damato wrote:
> > On Tue, Feb 11, 2025 at 09:45:56AM -0800, Joe Damato wrote:
> > > On Tue, Feb 11, 2025 at 12:09:50PM +0100, Paolo Abeni wrote:
> > > > On 2/10/25 8:38 PM, Joe Damato wrote:

[...]

> > > > 
> > > > This causes self-test failures:
> > > > 
> > > > https://netdev-3.bots.linux.dev/vmksft-net-drv/results/987742/4-queues-py/stdout
> > > > 
> > > > but I really haven't done any real investigation here.
> > > 
> > > I think it's because the test kernel in this case has
> > > CONFIG_XDP_SOCKETS undefined [1].
> > > 
> > > The error printed in the link you mentioned:
> > > 
> > >   socket creation failed: Address family not supported by protocol
> > > 
> > > is coming from the C program, which fails to create the AF_XDP
> > > socket.
> > > 
> > > I think the immediate reaction is to add more error checking to the
> > > python to make sure that the subprocess succeeded and if it failed,
> > > skip.
> > > 
> > > But, we may want it to fail for other error states instead of
> > > skipping? Not sure if there's general guidance on this, but my plan
> > > was to have the AF_XDP socket creation failure return a different
> > > error code (I dunno maybe -1?) and only skip the test in that case.
> > > 
> > > Will that work or is there a better way? I only want to skip if
> > > AF_XDP doesn't exist in the test kernel.
> > > 
> > > [1]: https://netdev-3.bots.linux.dev/vmksft-net-drv/results/987742/config
> > 
> > I'll give it a few more hours incase anyone has comments before I
> > resend, but I got something working (tested on kernels with and
> > without XDP sockets).
> > 
> > xdp_helper returns -1 if (errno == EAFNOSUPPORT). All other error
> > cases return 1.
> > 
> > Updated the python to do this:
> > 
> >   if xdp.returncode == 255:
> >       raise KsftSkipEx('AF_XDP unsupported')
> >   elif xdp.returncode > 0:
> >       raise KsftFailEx('unable to create AF_XDP socket')
> > 
> > Which seems to work on both types of kernels?
> > 
> > Happy to take feedback; will hold off on respinning for a bit just
> > incase there's a better way I don't know about.
> 
> Any reason not to enable CONFIG_XDP_SOCKETS on NIPA kernels? Seems a bit
> surprising that we run networking tests without XSKs enabled.

I can't comment on NIPA because I have no idea how it works. Maybe
there is a kernel with some options enabled and other kernels with
various options disabled?

I wonder if that's a separate issue though?

In other words: maybe writing the test as I've mentioned above so it
works regardless of whether CONFIG_XDP_SOCKETS is set or not is a
good idea just on its own?

I'm just not sure if there's some other pattern I should be
following other than what I proposed above. I'm hesitant to re-spin
until I get feedback on the proposed approach.

