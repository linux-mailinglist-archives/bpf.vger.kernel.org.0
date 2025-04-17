Return-Path: <bpf+bounces-56148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D5A922EF
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 18:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2212519E6E2D
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 16:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277E42550A0;
	Thu, 17 Apr 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hFP13GVt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DB9254B1A
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908208; cv=none; b=cuxlhW1oBx5MXXta1h/8RyMc1sQQQPysLSoGRW7ugjdvDV0RNPiBRsc632z0KGVJ6Bfh9sZYf/5rrjmYNSxMij2kM7wJOJ/ZKNa+ZcaHZecsCIaJuKFY9dmop1HW6bP8CqJPWEmN90P1Mad9/OGKKccO+2SE1KOydWp/VkCV8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908208; c=relaxed/simple;
	bh=cE0SsJXubMVoO/NUjivTf4Jtt0m+Kx9DZncRgLItiJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbFN7fEuy3XQvv6Bgn7FhiE1QTPYuM/XMFXzcDtZ7zPblQlWAzaHQcpNQ/XJSNopAleDtNEJie4vlcaxvuM6NtWCRa7z2uU7jLbo7HJn4oCj4XzcWvpKmn3aUrPEs/DHiRSPO8i5IMHOXxqSvYl7vIPaDG8b98E4xb6lonqDuyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hFP13GVt; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73972a54919so932286b3a.3
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 09:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744908206; x=1745513006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJs3R27mGXFnUc6xsOALgXGRVDRyXs8OoUcWIG3enHk=;
        b=hFP13GVtwYn8MV8aG2khVJWT1njBW5N2uFkrWfNIV4v+CTVErrPkFiBGt6Mnnp+j1j
         f1bIW6/SyZhCQWNRNuV2paZCvpH4lwtXa2Ww3iSVipiSnrMfqmer2evE1yHz+261x9Vh
         bsQfyf5nTXFJ+whm6X1eTfJPdePEcOeHYdZsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744908206; x=1745513006;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJs3R27mGXFnUc6xsOALgXGRVDRyXs8OoUcWIG3enHk=;
        b=iKLR04D1fXTBqxdx96xxpEhMn/LYdFDh35ABnIhcGbUBDMiUgbxiGV4opNncZXNmCZ
         leNz53n0BBAVbn/FwLroyHnJSVuGCY/jm2RWrqvUb9cl+Vosp6781NfpE56c4YsfrdPH
         VPuDzRnGE8xgSAw41aHQscbKwB4IDtq5FkGVlplli0UNTVsoXNJWwxa9Ly+UKQlXfYKu
         iHBea3WG6G8wk6Q5UFBuv93jHC+v0OsZgMRqzwC7NbPD3BboOebCmkNJa9iFsLZxuOMK
         8Qre3BINRYYxhESmSfP3tsjPT8BTDJZz++mbRGseVx+G+lXDf5V8IprQbKiJB7CC6HzW
         i31A==
X-Forwarded-Encrypted: i=1; AJvYcCUoWjzpDxUENQUOXZTw4VAIbPkqKhxxubZ1haE7idhzkYcpMvmC7yFzQZePrXC1xu4tvKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fsFXYktApdjtjQ0Cj5/Pr+cdefaiQJTU7GRbHQ9DqOs4tW59
	4WA707uFJWHkNIjHZq+xq8agrhuWL7q6s1SHMxnNKoV7gMtAbMzeDZ04sX9wLMw=
X-Gm-Gg: ASbGncuaAaTHxI1N/ov3tNVVkb7C7DhkOy1/YHqxGJ2BETOX3vAa8uW4mNwRASETJ+T
	7PPCTX8ORn6TL1guq1Y5sf/rv92z6PDfodOMU78+3jdfrx4WWMaEfeyy6WTztqXGOveU2Vaw6RS
	8FJu6/0jgqPrIVO4AyXqvctps7xQ1Qhad7a/3QQbmDxsewhqC4B6ZiZSsEd/8zhbLuODAvaq36N
	0u80fm//x4amBdaiwZfzSGoYbsdo+rvvTn7CRDMrAZMlJHKZ/OzZChZ4ROH43aIOm/mE+NWsxmQ
	MZEMh+8Mmc/UWCxG6+djxplDhI61QCAZ4bltg9HZoxhcEx79yFWEx1HgYfoQCjZlTBlWgAsrF9C
	f4AoO0SvQxgXg
X-Google-Smtp-Source: AGHT+IG+XpQJVC4yi6kR32NZ5IA6ihEOayDuhg24CWyM1y1U1cd5X2UW8o/p/Y+LyClf8OSD/ROclA==
X-Received: by 2002:aa7:88d2:0:b0:735:d89c:4b9f with SMTP id d2e1a72fcca58-73c264c4cb4mr8349614b3a.0.1744908206170;
        Thu, 17 Apr 2025 09:43:26 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8bf802sm63829b3a.13.2025.04.17.09.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 09:43:25 -0700 (PDT)
Date: Thu, 17 Apr 2025 09:43:23 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: Test that NAPI ID is
 non-zero
Message-ID: <aAEvq_oLLzboJeIB@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
References: <20250417013301.39228-1-jdamato@fastly.com>
 <20250417013301.39228-5-jdamato@fastly.com>
 <20250417064615.10aba96b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417064615.10aba96b@kernel.org>

On Thu, Apr 17, 2025 at 06:46:15AM -0700, Jakub Kicinski wrote:
> On Thu, 17 Apr 2025 01:32:42 +0000 Joe Damato wrote:
> > Test that the SO_INCOMING_NAPI_ID of a network file descriptor is
> > non-zero. This ensures that either the core networking stack or, in some
> > cases like netdevsim, the driver correctly sets the NAPI ID.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  .../testing/selftests/drivers/net/.gitignore  |  1 +
> >  tools/testing/selftests/drivers/net/Makefile  |  6 +-
> >  .../testing/selftests/drivers/net/napi_id.py  | 24 ++++++
> >  .../selftests/drivers/net/napi_id_helper.c    | 83 +++++++++++++++++++
> >  4 files changed, 113 insertions(+), 1 deletion(-)
> >  create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
> >  create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c
> > 
> > diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
> > index ec746f374e85..71bd7d651233 100644
> > --- a/tools/testing/selftests/drivers/net/.gitignore
> > +++ b/tools/testing/selftests/drivers/net/.gitignore
> > @@ -1,2 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  xdp_helper
> > +napi_id_helper
> 
> sort alphabetically, pls

Thanks, fixed.

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
> you need to deploy, in case test is running with a real remote machine
> and the binary has to be copied over:
> 
> 	bin_remote = cfg.remote.deploy(cfg.test_dir / "napi_id_helper")
> 	listen_cmd = f'{bin_remote} {cfg.addr_v['4']} {port}' 

Thanks, fixed.

> > +    with bkg(listen_cmd, ksft_wait=3) as server:
> > +        with NetNSEnter('net', '/proc/self/ns/'):
> > +          cmd(f"echo a | socat - TCP:{cfg.addr_v['4']}:{port}", host=cfg.remote, shell=True)
> 
> Like Xiao Liang said, just host=cfg.remote should work.

You are both correct; sorry about the noise. I thought I tried this
last night and it was failing, but clearly I was wrong/something
else was broken.

I've fixed this locally and dropped patch 3 which is now
unnecessary.

I think the main outstanding thing is Paolo's feedback which maybe
(?) is due to a Python version difference? If you have any guidance
on how to proceed on that, I'd appreciate it [1].

My guess is that I could rewrite that line to concat the strings
instead of interpolate and it would work both on Paolo's system and
mine. Would that be the right way to go?

[1]: https://lore.kernel.org/netdev/aAEtSppgCFNd8vr4@LQ3V64L9R2/

