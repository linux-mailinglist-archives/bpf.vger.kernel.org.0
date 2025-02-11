Return-Path: <bpf+bounces-51176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586E2A31631
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 20:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE54116571C
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 19:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC38F265625;
	Tue, 11 Feb 2025 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wYsvPKyB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D31265617
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303853; cv=none; b=JZyp8bj7364lNfiObjp/5WkfyezAddPeNjQFz5cDWGcsqWdicJq1IhZRp5mMgT6NJ1LWl6j5nAf0XHilETmq+KjgfbPCh7fjW7M6EV/tko0JmdzjSoz5gpywqF0Uvp0G1qsx5uAsd5UN1bRmBFjxkPkVaNVim1dYEUC4997J658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303853; c=relaxed/simple;
	bh=4L1l3nbsQwxG4dhopMpRTZTo6TywqvNfWe0By30mxKA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwGui/mIQfgtnvMuJ6sfId49tMq7k3X8e1DZay/4rmuQZysG1FBA0D9W6POV1zShMvP/gZlOujd7CW8IJ0MkCqPrSZVNg4+SEQLbMpK73OOf6jB1iBd19wD2mYkDXXUaaw94/BcYzFw2Q9z6dwe9IgIJiOjLun9l8rgzWjkSKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wYsvPKyB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f7f03d856so57342975ad.1
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 11:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739303851; x=1739908651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LZz21PoK7ESpRyCP00gJn2627gqZOHRBJZHWL/EIwBo=;
        b=wYsvPKyBkoDXAYAkV39HQmlK8TOoSuLUE6ER8pM+sKGn78lxAmujZPT9cYAIlhtZDo
         o1z8M1XBvBIrRDEmndONT4C68fO8Xyl0V4BjRVs3xfyI0eLoxQfVNJX1yfmfNi8uzNMB
         Z7MptZhHeLUgnv0bJeXlV0/5rhe6vHGoFdBYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739303851; x=1739908651;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZz21PoK7ESpRyCP00gJn2627gqZOHRBJZHWL/EIwBo=;
        b=Ctuc6UVn9qpVquS24zm5OhrxqvACUQqDO6RC1efTjK/eMfVNSk6dzOpsF4J+zQpQTW
         GnTRwMdEAb3ndOlQfKgBbC6Lq5Ln5QkbLyGfiZfB9meRDoZWOZmx1449defkt1/KjgX3
         yRD0RuxQ4RUrjdIjD3V/d68zUzkaEZF5xLhKYE2g9las6b5if666oiiOGx60Dhz0v6WX
         H4HD1+/CEgrNNRchkM8VeEnVZzhHMAk+s7HGhYHrzwdA7Rc6e4jZiCKbjz5nd7IYP1d8
         k3LFrFn2Tf72xYbmO6I3Gx7wV/TTtgO/moNprYHjLbCb3u7my8HmgdyC84dzp8964lIQ
         a5Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUEqzqVyJT33YRvlBGnaEWG+KrCY3Rk4ktqhoVcD4xvNgnvom45Ovg0ZKTOOkh0pFzF0ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Syg1prAX9Wo8gLMsta3an4y2KjuGBEjjJcAS4FqjPMxSO1rz
	6nLZY3ZaeJb8oDAqYs+KhMbqjxHkng51x0SqezdiogvS9yTynrKNF7q6h9dsAMw=
X-Gm-Gg: ASbGncvtnvNjnRRR0+tQMAVwN65RO+rdlJwfryZxtPUh7mqnYJQWGyIY5QoTwzb07qv
	jR1g3QGbfItiy+SsuDIZWEhzHM8rnPgkyAX1sfRDbIqbThUS8y//Vb54U06o+OF04bDE2kCNXkV
	WD2P9/Yh+LTs2b5+SQf21M3GoYWm2z1O4q0avwkCI6pvXjESFHvoczEbRw3ioQABZ+0x6F5YAVz
	czO8te5xXAXlYzxH+Q0mdrg/yhCcLqpNl7ZSYRp2TqEGHsV6LvVJmhLIll0aJ6eDiv62zSMbiH0
	G8hpchxpok+0wOD1HEGPgV80tYEz20dWkMrBeYLySCSsnZsXwlVd6GoNtQ==
X-Google-Smtp-Source: AGHT+IHGm6N7udAh5kUmRKYI+y4WUkbVC6Seg2Hl1n1knL0KkTOJXLUEmjJNH2ogtVLi5OCw8cUlqg==
X-Received: by 2002:a05:6a21:7001:b0:1ed:534e:38b1 with SMTP id adf61e73a8af0-1ee5c85fa2cmr1060630637.41.1739303850821;
        Tue, 11 Feb 2025 11:57:30 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53f481ec4sm5371235a12.9.2025.02.11.11.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:57:30 -0800 (PST)
Date: Tue, 11 Feb 2025 11:57:27 -0800
From: Joe Damato <jdamato@fastly.com>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	stfomichev@gmail.com, horms@kernel.org, kuba@kernel.org,
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
Message-ID: <Z6urp3d41nvBoSbG@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	stfomichev@gmail.com, horms@kernel.org, kuba@kernel.org,
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
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6uM1IDP9JgvGvev@LQ3V64L9R2>

On Tue, Feb 11, 2025 at 09:45:56AM -0800, Joe Damato wrote:
> On Tue, Feb 11, 2025 at 12:09:50PM +0100, Paolo Abeni wrote:
> > On 2/10/25 8:38 PM, Joe Damato wrote:
> > > +def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
> > > +    test_dir = os.path.dirname(os.path.realpath(__file__))
> > > +    xdp = subprocess.Popen([f"{test_dir}/xdp_helper", f"{cfg.ifindex}", f"{xdp_queue_id}"],
> > > +                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
> > > +                           text=True)
> > > +    defer(xdp.kill)
> > > +
> > > +    stdout, stderr = xdp.communicate(timeout=10)
> > > +    rx = tx = False
> > > +
> > > +    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
> > > +    if not queues:
> > > +        raise KsftSkipEx("Netlink reports no queues")
> > > +
> > > +    for q in queues:
> > > +        if q['id'] == 0:
> > > +            if q['type'] == 'rx':
> > > +                rx = True
> > > +            if q['type'] == 'tx':
> > > +                tx = True
> > > +
> > > +            ksft_eq(q['xsk'], {})
> > > +        else:
> > > +            if 'xsk' in q:
> > > +                _fail("Check failed: xsk attribute set.")
> > > +
> > > +    ksft_eq(rx, True)
> > > +    ksft_eq(tx, True)
> > 
> > This causes self-test failures:
> > 
> > https://netdev-3.bots.linux.dev/vmksft-net-drv/results/987742/4-queues-py/stdout
> > 
> > but I really haven't done any real investigation here.
> 
> I think it's because the test kernel in this case has
> CONFIG_XDP_SOCKETS undefined [1].
> 
> The error printed in the link you mentioned:
> 
>   socket creation failed: Address family not supported by protocol
> 
> is coming from the C program, which fails to create the AF_XDP
> socket.
> 
> I think the immediate reaction is to add more error checking to the
> python to make sure that the subprocess succeeded and if it failed,
> skip.
> 
> But, we may want it to fail for other error states instead of
> skipping? Not sure if there's general guidance on this, but my plan
> was to have the AF_XDP socket creation failure return a different
> error code (I dunno maybe -1?) and only skip the test in that case.
> 
> Will that work or is there a better way? I only want to skip if
> AF_XDP doesn't exist in the test kernel.
> 
> [1]: https://netdev-3.bots.linux.dev/vmksft-net-drv/results/987742/config

I'll give it a few more hours incase anyone has comments before I
resend, but I got something working (tested on kernels with and
without XDP sockets).

xdp_helper returns -1 if (errno == EAFNOSUPPORT). All other error
cases return 1.

Updated the python to do this:

  if xdp.returncode == 255:
      raise KsftSkipEx('AF_XDP unsupported')
  elif xdp.returncode > 0:
      raise KsftFailEx('unable to create AF_XDP socket')

Which seems to work on both types of kernels?

Happy to take feedback; will hold off on respinning for a bit just
incase there's a better way I don't know about.

