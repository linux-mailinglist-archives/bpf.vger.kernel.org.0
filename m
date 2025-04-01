Return-Path: <bpf+bounces-55088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B94AA780D4
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 18:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F658188F5B6
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F107F211299;
	Tue,  1 Apr 2025 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FplJlPvG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5CD20C006;
	Tue,  1 Apr 2025 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525923; cv=none; b=eWCcOyOuQ6CzSl4qk7KMdjxPjmt/VBg8Ht9FjGdkbCIdwBRUn/Ge99m12upEWe0Vg0KH/P1d77BcfFom4+hisfF4ZNZdJQGQ899fuGZ9hcqQqGK9qpBL9GxLIAH007jdg1udxSXxjqXrWCN771vj/VWwumQfnH6uDYgjV7Aqmeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525923; c=relaxed/simple;
	bh=FQRzceMu5PfqWDxq7jqSN1LyrWg6gQ6twYztodXRRVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKwMVintKeq5mJzyY7OlvlWAq6YV8jkYw9KcigpZUV67goi+Qlsg+/dcJWn6OihCxLUDqYCzpHDzKMDYZxX6cuID1AdmXDE5M2Nu2sfM7mFC/6xMtKFgHDd5HDwUVqH7vXqNbyf2uPD0N0p45ta3UYxsw13NMq7Rfa3g7uGapLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FplJlPvG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223f4c06e9fso247115ad.1;
        Tue, 01 Apr 2025 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743525921; x=1744130721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Nw69mQoIfcr7PG0OaaKVJexApQmL7lFoCUOI3rp0LI=;
        b=FplJlPvGJRIysqx2dWGpEJ2xc5sfypF7/fvyEKIMgxtNud4XEJPPIax/LRcFWrPI5v
         jbIxqMf3VNfED7gPVa1LrS6Zw+nT2t82FV/PDICo5QTcV+uB0luAC/N88dPKRLyLbTGk
         warRckvURd4m45jpRWj30jcTomOnM3a/tBncigEzGF3DSfYNO5edSpvqYEgRph5iQ+al
         vyRzoQf0tZUtoGRNZdiWsIBfqCQOkgz0hnTkqtWOXiTI0m/aHYm1A1XHr3nM6DFN2RJU
         nor7QyKQg6LHAUpr4EmJHj9E7Chn/hHkSP8dl4Gk/kcIFstNzarS3jSobVywmEb7HI85
         r0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525921; x=1744130721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Nw69mQoIfcr7PG0OaaKVJexApQmL7lFoCUOI3rp0LI=;
        b=D+k6AXN/tPJz8qCMaY4XcbdshuOcY7HJu1d25nEPVvHH8IxCvxAikAKrmaMchXFJ5R
         6+YXndS+UEnYyEc/Y04fW7K2IF0yJ4+xw75JnKR0MfxhNK7eqehroVHihqzWhu0b0a1w
         7zEjzqfc9xHpBXnAGS8pe57leioUXI4dkMkAurM7V77u5dn9XEehnkTI9cKU70lvLFac
         Ttqr26rWRZgj5zOOMm7QllQnizG2CibBREJw9UMec+ANFzIzKNpqMnUUZGtRPNnXFxVx
         xVRtAnc5L9D1iCja4/mE995PVvypdyUhUX7y1zQMjhX9ORBMXjLzr81JL15gEXfvN0Wv
         JhKw==
X-Forwarded-Encrypted: i=1; AJvYcCWJYGwX2PXavij4EuuAOFStdHLlsJlhLKmUsb9p5m1HJitnSfA9littieA7ni0U+shpFDQ=@vger.kernel.org, AJvYcCX6Xbxzc5T5sXsPdDHZ/a6s1PhX44VkOeTcfT4peFjAjtTmoHYhJ7qBIAWmKucKSyaRXeeY1N8Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwCQnf3uUAaXA8h4EOF6TF9mC4nHAK/gZPEn3DuA9uYOjfcCb5f
	VVG92JvdyrS/CRbIxHM4HF6cQfh729t76trwzm66XaW62t7SzXc=
X-Gm-Gg: ASbGnctsm8emqHRgwUXEe6qKoN1ABMOlHWplv4Vqn/wmDXTB4wLDvByl3aoFG9/KKkd
	Mwqr4p6cFvYb9TNfKjEHpylZ26CrOD53OWCvuD8/8h6/GTcG9dlXT8Swm0d9NTsYQi1erWHGMWV
	l5YnbjE3a8s5D5Z7KnTT4QXlK321nlIIwHhGutB/GWiKJ1nOTA2qdjSkerAcFRd2+6oCKKq6EQQ
	yRr5mEevfKbekaJrNtK2VT2HdCxJEK0Sh2+5pBKY1FuTzyqaaO1AWJt9QjJrv3as4pm8bagNoK2
	w40DApmHqDPMlueFil+xsO41z61j6bM+yNjPh2nhz8Gf
X-Google-Smtp-Source: AGHT+IEt23FR6gEupTyJ8VCJLzQrkAkKqDDnyXXQpCwagz7Gv7kZAqQ4IGIdYhY59+4DjYbrtkQj3g==
X-Received: by 2002:a17:902:f545:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-2296829b1bemr9485385ad.2.1743525921073;
        Tue, 01 Apr 2025 09:45:21 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eec693esm90791875ad.31.2025.04.01.09.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:45:20 -0700 (PDT)
Date: Tue, 1 Apr 2025 09:45:19 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: new splat
Message-ID: <Z-wYH-gIvMd89-3d@mini-arch>
References: <CAADnVQJFWn3dBFJtY+ci6oN1pDFL=TzCmNbRgey7MdYxt_AP2g@mail.gmail.com>
 <647c3886-72fd-4e49-bdd0-4512f0319e8c@redhat.com>
 <d24ea1cc-4d32-44f9-9051-0c874f73f1c5@uliege.be>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d24ea1cc-4d32-44f9-9051-0c874f73f1c5@uliege.be>

On 04/01, Justin Iurman wrote:
> On 3/31/25 10:07, Paolo Abeni wrote:
> > Adding Justin.
> > 
> > On 3/31/25 1:28 AM, Alexei Starovoitov wrote:
> > > After bpf fast forward we see this new failure:
> > > 
> > > [  138.359852] BUG: using __this_cpu_read() in preemptible [00000000]
> > > code: test_progs/9368
> > > [  138.362686] caller is lwtunnel_xmit+0x1c/0x2e0
> > > [  138.364363] CPU: 9 UID: 0 PID: 9368 Comm: test_progs Tainted: G
> > >        O        6.14.0-10767-g8be3a12f9f26 #1092 PREEMPT
> > > [  138.364366] Tainted: [O]=OOT_MODULE
> > > [  138.364366] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > > [  138.364368] Call Trace:
> > > [  138.364370]  <TASK>
> > > [  138.364375]  dump_stack_lvl+0x80/0x90
> > > [  138.364381]  check_preemption_disabled+0xc6/0xe0
> > > [  138.364385]  lwtunnel_xmit+0x1c/0x2e0
> > > [  138.364387]  ip_finish_output2+0x2f9/0x850
> > > [  138.364391]  ? __ip_finish_output+0xa0/0x320
> > > [  138.364394]  ip_send_skb+0x3f/0x90
> > > [  138.364397]  udp_send_skb+0x1a6/0x3d0
> > > [  138.364402]  udp_sendmsg+0x87b/0x1000
> > > [  138.364404]  ? ip_frag_init+0x60/0x60
> > > [  138.364406]  ? reacquire_held_locks+0xcd/0x1f0
> > > [  138.364414]  ? copy_process+0x2ae0/0x2fa0
> > > [  138.364418]  ? inet_autobind+0x41/0x60
> > > [  138.364420]  ? __local_bh_enable_ip+0x79/0xe0
> > > [  138.364422]  ? inet_autobind+0x41/0x60
> > > [  138.364424]  ? inet_send_prepare+0xe7/0x1e0
> > > [  138.364428]  __sock_sendmsg+0x38/0x70
> > > [  138.364432]  ____sys_sendmsg+0x1c9/0x200
> > > [  138.364437]  ___sys_sendmsg+0x73/0xa0
> > > [  138.364444]  ? __fget_files+0xb9/0x180
> > > [  138.364447]  ? lock_release+0x131/0x280
> > > [  138.364450]  ? __fget_files+0xc3/0x180
> > > [  138.364453]  __sys_sendmsg+0x5a/0xa0
> > 
> > Possibly a decoded stack trace could help.
> > 
> > I think a possible suspect is:
> > 
> > commit 986ffb3a57c5650fb8bf6d59a8f0f07046abfeb6
> > Author: Justin Iurman <justin.iurman@uliege.be>
> > Date:   Fri Mar 14 13:00:46 2025 +0100
> > 
> >      net: lwtunnel: fix recursion loops
> > 
> > with dev_xmit_recursion() in lwtunnel_xmit() being called in preemptible
> > scope.
> 
> Correct, I came to the same conclusion based on that trace. However, I can't
> reproduce it with a PREEMPT kernel. It goes through without problem and the
> output is (as expected), i.e., "lwtunnel_xmit(): recursion limit reached on
> datapath".

For me adding the following to the config did the trick:
CONFIG_PREEMPT
CONFIG_DEBUG_PREEMPT

And reverting your patch made it go away.

