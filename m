Return-Path: <bpf+bounces-21677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29F085023E
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 03:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D601C22D8D
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 02:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894755234;
	Sat, 10 Feb 2024 02:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FsV23qRh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A933C0
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707533162; cv=none; b=lUI2WrP2M4Fdoxau2N4VMAAWNsFB6X5oTs7/zlyUlTgPrAIrR7yo3AnnLKnDHpmCCL8HK/hgbdLTuCcA4CUmMKkJxwJiGMf7HVemSFkMTtqpW+GI5putdW1Btb8vp+vFG7hMMHNhMQpjfVE6LPJCdTiP57Rq8lOWsKdcC/fkL9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707533162; c=relaxed/simple;
	bh=fvcxdwhch+UgCOqtnEyZPh1ECKl5d5IgD43prRrJsXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piW/hq2WCLepNN22oDWpAdCaZO/6p/0KOl4umxXCErgXyNFVBma/wfkDuMFMQrBVtmaGhbsaJfN1rlP//e7zBDyOSNKruqhdfU/MlpZOtR6IQHjtMITUM19CXvwZZ9vuC8VU+MiHsI4BnXALjk8YtztgWzYR4ttQNY15vHicC98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=FsV23qRh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d8ef977f1eso13721675ad.0
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 18:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707533160; x=1708137960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juvAKGT5CeRrHs5S/LFrLMDdPScLSP5NQP+Ax181rF0=;
        b=FsV23qRhe5NqfIAPYtjRTgh5nDJf2nmCSeZ9e6MTvkdNvQL2XXHld8zP+U4UsM8E1L
         qTqO/zRwefc78kJB7t1Vws7Juk9BcfPS+TQuLHGo4CdFEMtYT9EXmFxfwjsmDeOQ99zJ
         YmgHXcRp0CUKO9RAIMFPmdXLx1bP8iCx4IJjVbNdqdorUNFFHQVbtmGzL+gv6eT7VJIn
         gcAaDtws+OhMjCJ6JF3UPfXSupgXKDUX501bGbCjXOKJ41/tc2sLEMCMm3xM/Yyggbtj
         yvp682EFc2LfEC6XolT/H38hICo6OhwkIDLTl77YGH7Sh+Yg3BDoeoKZzefEMf2hCq6E
         WsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707533160; x=1708137960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juvAKGT5CeRrHs5S/LFrLMDdPScLSP5NQP+Ax181rF0=;
        b=klfZ2JZ3R9OMMMiiu2Q2lZH8sf7tm2wtkYIQLiO24Wbhc1/Hxx9dZI4Y8HMy87Ct4M
         dj2c19CUSUoshjyEybtZ6pIjj/pug6P7yYgesZQ1w4gUivyfg7lDWDhcXDkGBS+fOCK9
         8fpnIUcofRrdsSXqBWmzQlbNS2cdaaaETZ+mdPAQaiyDWX67x5InIbVxjhcqLgLLBkNy
         MS1zdvF3i6qEnDw1p8f+ju8Q4+POXt5Dyv+qOC74elJIotvyDA33bEMBs18IcUYebd9z
         EWLuWRTiciX1AmddBhF0f0OYPQ8HNujo1olPdZ0R7DvOf8S4yn3CpskOrX3zQBNtw8Bc
         70Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVq5MVucYHPH7J9fMlR8BtY8WyzlZqo7VvPn55sa1QR31N4lpnWSv+bfsxzMLChzRuYSMgfq0ohOGvIrX/r0b6Kq9Ln
X-Gm-Message-State: AOJu0YzW9Pnv3w/rgqD8QKBAb4r6R+2KvqaaGNdfEISs3jPw6OPSOsXW
	m2EcQYZKl6F5vM54YKrqzHnuXvayAyUB2Z4pNVNjp7VY8p5LxkM/Oq7W+b8X1bM=
X-Google-Smtp-Source: AGHT+IHEDqbAC4lmL3ZpUXSCN9GdkEM2l7fe8xTltkLkxmu1UR60/e25RS/zMOOX5wfJlxuteXW2tw==
X-Received: by 2002:a17:902:ec8f:b0:1da:e86:3d9e with SMTP id x15-20020a170902ec8f00b001da0e863d9emr1412208plg.43.1707533159777;
        Fri, 09 Feb 2024 18:45:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMhzRkPJU68x71VCI0cCzTS1iGPROvorEHI8y/T4VEsPqoWKRiyLc6jpPnVnKyR0zJXFEBaQnHeIE9zBh6zGXKxKyy+69dAWbHc0cnlF/TixP9rdrhlkWGVbNYTmzwM8fPlu9XTnBpdXUyqMKn3yTL6Rsutw05p5yMUO5nqD1NE31MbFZvloHyWGYSV1eJJVaMWJ2keeytwpKYeVaELobWX4mCrvEtYg//ovV0TKLVKwXW7JhD3Tx4+WaLMube7ba5D8oQGgw83DyJ8YXup0gXBaT92tcI0eNYel3yhLEXra2BvSwFKyGdEJ48enl3MzyOclUYmQr1sL3m8FyrEm8q8rLyPEjIy+uHll/0f0hse679uE3lxbRm3BP676KdKumQKhN3ISg6shx/pXVo63coSaXdfB9bti21OvyKuV/uhofsNXW5tac4rbv/lticgt4p+dalE9KXCG3XGt2a5rTwLptPsnyG+3nsvILh9cGGbTQZYElnQdeGHU/SzhqwIloQYcRKUR0cqO54hwxFz1nBRZx+OVdWweRwpzKCKYsfSHi1DphxVSx4LeLATF3KML1avYiiqwq+Dx1TeVhwXMGLdZa4EXGE+V64Stk=
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902ee8100b001d94c709738sm2149523pld.217.2024.02.09.18.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 18:45:59 -0800 (PST)
Date: Fri, 9 Feb 2024 18:45:56 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
 (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v2] net/sched: actions report errors with
 extack
Message-ID: <20240209184556.00cde1a2@hermes.local>
In-Reply-To: <20240209183133.1cc0a4f5@kernel.org>
References: <20240205185537.216873-1-stephen@networkplumber.org>
	<20240208182731.682985dd@kernel.org>
	<20240209131119.6399c91b@hermes.local>
	<20240209134112.4795eb19@kernel.org>
	<20240209155830.448c2215@hermes.local>
	<20240209183133.1cc0a4f5@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Feb 2024 18:31:33 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 9 Feb 2024 15:58:30 -0800 Stephen Hemminger wrote:
> > > I mean that NL_REQ_ATTR_CHECK() should be more than enough by itself.
> > > We have full TC specs in YAML now, we can hack up a script to generate
> > > reverse parsing tables for iproute2 even if you don't want to go full
> > > YNL.    
> > 
> > Ok, then will take the err msg across all places using NL_REQ_ATTR_CHECK?  
> 
> Take _out_ ? That'd be great, yup.


I don't think that is actually a good idea because new kernel needs to still
report errors to older userspace iproute2.

This is kind of academic hair splitting, iproute2 doesn't send these kind
of missing part messages. It is more from test suites, or from custom
user programs; found this when looking at DPDK device driver that was
sending its own netlink.

