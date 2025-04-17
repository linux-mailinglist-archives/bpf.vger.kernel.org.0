Return-Path: <bpf+bounces-56147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32926A922C4
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 18:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89ADE463A81
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C26254B12;
	Thu, 17 Apr 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="L2BHWXuB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2341A3178
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744907600; cv=none; b=F/IJT9s3Wo17FXtwLEOMlSl/NUms47JKoT+hPPS2FRcz4vRs+ENuIUXI1OPk2JW2MvrCYXGw8rbhPT5PglCyM9v63Qc23fncvzHnI85bKqb/EJh64S6+801zIOPjH0yT4NscuqRgPVBBvpTQBwQeg3nb2xTF3X9+ZA7L6kiR7ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744907600; c=relaxed/simple;
	bh=MorJ0Vcovdi4XLQZKAYt8UWHrt+gqIuT1WCj8KBdkGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOme4Rs0h9CPOlLLHoR2m6ygea2IWJDKqj/3/jOQ9h8U75HXlQxNJMgurkTdRI9Te+6z85YC1dDfw/x2/Sl3nQAu/T7ELzjTSB27x90OZ5Be+w4dJ8+Kpoeu72U1wSlKNZgvEw602VZb7nI6rnAr08Cd+IM+t6+rIs9J2hecTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=L2BHWXuB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224171d6826so16286955ad.3
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744907598; x=1745512398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mprfwwo0Da4LxnvcuRCJo8vR8B5fCLfrLhkCs2VqZg0=;
        b=L2BHWXuBfQDvEXIUJ2E9Y9ISzkb04o6NxilKIALyLn2k/F1a/k/Jhtew0qp5NcaQR+
         yBdIBb8V6lIarsQgoYIsyEUKb3xUnfQacsT219Ndp3wvcv099AiTTvzUUq2YQmyiX/y8
         QyAwIvSBEgeqtE6O7ZOsAZUTJUcM29nhF2obE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744907598; x=1745512398;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mprfwwo0Da4LxnvcuRCJo8vR8B5fCLfrLhkCs2VqZg0=;
        b=qm75noB6JeFP1ddm+Y2DvRHC1kH+2boS74Eazd7Msyp2BeqX8Uop7KgTgw1Zt0nvFe
         c4fHpXf4dYKbec78+GnTBqZoJDyCPe4BGaKRAJVNmX5FngL0xiGBBGhmAc6DtH/N2ndu
         VUe8wT80vt2ge4rzPQWPn2+35p86HBVohoxYTyRDe6x31Y3BjUD74HJ2b1ffM6CMI/Vy
         8cix+JCnlUPzN1RRcuKo+1hCORtIN3mQdgkc+NJtCb592X88NEzqQiPB1EfHGt7hx1sE
         h63EnYqhj8Asc7qMSOiwMGWQByiPqnlo5PqGYNbmkb6MWjbXamCmJ+Tk7SnVPsAjXiLC
         ERkA==
X-Forwarded-Encrypted: i=1; AJvYcCXKhNqEKw+49NCgRjOXsokXgN8RW3Fmp0k232UCDmDr702VF6lCgaCiQg/co6nOaHdPaqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTLmtF39AZRo27InMfPDGdSdL9nylsR99RvNMgfFxSSiyrmIRu
	KBtMJc/7jKHWBWbufT95xxWITL4IBwpLJGb5wZ07b8HVwKXTAvQh59UQXXHx+jk=
X-Gm-Gg: ASbGnctOj9d5DfxP6YHpy85m+jlBL+gRddtPSgWfK7x0B1/MRIgVeHcV9NQf/i5boVX
	EQlz1qYzWKZefGycBrbYKOgKcLnGflk0uInUFivosWYyZaeKHbDmykuigL2yUJPmYaGxUCP6nUY
	KNQoyoXdbp7j1aNFmkih3g5PHaoMJwY/MOOC0YKDrV4kjJhtOMNYkxaefa2zzT5q778gB6xQKor
	nuw7+ewHBzmVUX2Pm20CR+MBDZ5Crm2KkFPFSU/oHYHSm/z5/hMKI13wyHgI6pQPg925A7q/3cF
	H/6VW5j0Q0420VasB5v71MrDYHkNIn6vvb97LTs3dx9N1+6uIdyVZwv3vTPo4cYszpGOdBix14b
	23LqzLemsVxrR
X-Google-Smtp-Source: AGHT+IGJpmGDv/RmZoBpASwHCPsKTxrbaXtrzgvFEb/fiM5N6VFMbYf2bDKD9j/RfqFYVUJiTtyDyA==
X-Received: by 2002:a17:902:ce91:b0:224:1ce1:a3f4 with SMTP id d9443c01a7336-22c358c543amr88775005ad.1.1744907597917;
        Thu, 17 Apr 2025 09:33:17 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bdae5dsm2114315ad.35.2025.04.17.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 09:33:17 -0700 (PDT)
Date: Thu, 17 Apr 2025 09:33:14 -0700
From: Joe Damato <jdamato@fastly.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org,
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
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: Test that NAPI ID is
 non-zero
Message-ID: <aAEtSppgCFNd8vr4@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	kuba@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
References: <20250417013301.39228-1-jdamato@fastly.com>
 <20250417013301.39228-5-jdamato@fastly.com>
 <b1fa9607-f9bd-4feb-a22f-55453a9403e9@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1fa9607-f9bd-4feb-a22f-55453a9403e9@redhat.com>

On Thu, Apr 17, 2025 at 09:26:22AM +0200, Paolo Abeni wrote:
> On 4/17/25 3:32 AM, Joe Damato wrote:
> > diff --git a/tools/testing/selftests/drivers/net/napi_id.py b/tools/testing/selftests/drivers/net/napi_id.py
> > new file mode 100755
> > index 000000000000..aee6f90be49b
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/napi_id.py
> > @@ -0,0 +1,24 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +from lib.py import ksft_run, ksft_exit
> > +from lib.py import ksft_eq, NetDrvEpEnv
> > +from lib.py import bkg, cmd, rand_port, NetNSEnter
> > +
> > +def test_napi_id(cfg) -> None:
> > +    port = rand_port()
> > +    listen_cmd = f'{cfg.test_dir / "napi_id_helper"} {cfg.addr_v['4']} {port}'
> 
> Not really a full review, but this is apparently causing self-tests
> failures:
> 
> # selftests: drivers/net: napi_id.py
> #   File
> "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./napi_id.py",
> line 10
> #     listen_cmd = f'{cfg.test_dir / "napi_id_helper"} {cfg.addr_v['4']}
> {port}'
> #                                                                   ^
> # SyntaxError: f-string: unmatched '['
> not ok 1 selftests: drivers/net: napi_id.py # exit=1
> 
> the second "'" char is closing the python format string, truncating the
> cfg.addr_v['4'] expression.
> 
> Please run the self test locally before the next submission, thanks!

I did run it locally, many times, and it works for me:

$ sudo ./tools/testing/selftests/drivers/net/napi_id.py
TAP version 13
1..1
ok 1 napi_id.test_napi_id
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Maybe this has something to do with the Python version on my system
vs yours/the test host?

I am using Python 3.13.1 from Ubuntu 24.04.

Please let me know what Python version you are using so I can try to
reproduce this locally ?

