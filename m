Return-Path: <bpf+bounces-67764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B59B4978C
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47539446E7B
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED4312838;
	Mon,  8 Sep 2025 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO0f2rIs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06095235BE8
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353770; cv=none; b=oL3OOpr5QwBlq+o/2O6Hyy4DZ7AKX/D3dfXOHVv1W19HBfgQT/GhbeIgZw2EYJlloEJ3ipgtqMiRPmqeo1DIqjCXerVWhO+CNW1OP7YpJUeFb7pSg4+mgM2oJfyp04ni76JM4G//XfehwRcTflGX2TthObLWOKrnEXPNj83yYvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353770; c=relaxed/simple;
	bh=Nz8Wzc8Hftz3sg9iQPtxvQS7DMveXFBUll9BA7Ozal0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU02lP/gbWbk6yc/4xSYrS1tp83MCqOAd6xvbjSH2T9vQoO/ZJZV8JxoViymr/8M1nxzop3flrxNqp2ILTcRwlD9a7Sb1BIdkXqjaNuCB3hF81eKOSxS9G6gT/UBRrjYJiwapHkmUy627E6Lj7/+7ZP+B1o5Mznw2XpX6cUoWX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO0f2rIs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so40469825e9.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757353767; x=1757958567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSRQ1ptpcI32Y0QelfghF7qMBMSqQwB11cAnuhMXi2A=;
        b=WO0f2rIsOS3KBZ+KzSnoz3LJhh70gurbD4KdhLm/ZZWSti3v7dzgqIPnRe7WmKctSK
         +MGj57ymyP8lcTWdMuRADT3cZX65wigLpElWZy52mhiTmSWf4zjIUZrVmUhxB32qx/UV
         BUypNUPYnwOxSv7Jhk+6U83AJ5ybUM2hbLoNEyp20+LQBNkQq/WQBlLuNBKfpRUsCMSr
         WmvUzXBjinPQCGo894KFpEL440VTms80iI98H15BcRdj1gm2VNJ4ERZ+nCqWyF5UyaVi
         XSAAOCkcYkrnxEH6dVnnEbbIrUWvdpXgb4DVs3TFFuwVMK3e0/0I6EMvhq70aOoHy2uU
         bUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757353767; x=1757958567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSRQ1ptpcI32Y0QelfghF7qMBMSqQwB11cAnuhMXi2A=;
        b=tGSEc7UPObkgva6yLsKTMgY+2UyFrkTh7FN/+P27G2hn2pGhYzR0pB0xJAKUXBQILW
         6Ea9vszbOCSvyNIiCRnbRJaQUiGuJR2XCyEXlaQNpV26MP15I1xW+6HcIYRo+WFCAOB7
         o8MaQDCLKVwiI32YqRDr3arzim1FYX8LyfNc7etIvIW+7AxIcn7P7o8okLvGHs5jqAZE
         DF7fon3HbY/2xSE71k9bnVSus4ftTHsN3/02DLeufh0+KjdcjTlMnOgNm0sVOLxD7D3L
         BMRvvrxFJtPxBwDf9uc3hNicg13VU/JHKT/Rf3FuuVGRTkTQCPXu8FERjQa9ddFwA7oL
         ucJA==
X-Forwarded-Encrypted: i=1; AJvYcCXvl38gUCRI6fvZGM5sMUxulNPgSY3iS9qikKCAyuWebU5K8Dc/4zaB6Z2Msb0qmy/ytyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2PkGXaX5hh4PriH12iSve4SJYelE67Qw9U9FjANcJxgHTWBYD
	livBGHoV/npyPgksauKj36Qn6hjH87R1iiYQFI1uLE2SEQdDeJLcdyijiJz/FZ3GTJs=
X-Gm-Gg: ASbGncsWkGBPZ55oodXg1CwkXm9VPJBkQ3xNiK3jyGwC1HpVOtGOdCtBGrvzU7t8Oqy
	Ls4Zvp5DDU+ET83BOf/XQv0zt/RemmChWW+UCb+FGdKU1Y0MDkl1kqXa7Y15HRx8Lz/dPH29/to
	kL4yE/No1aZnWtpoTw2SRXJwY6H/LJJbcbSh1+D9ZOTOKDuXbpB3wEFaQDV0iBxYmhD9t4c3kHV
	zugEs6j56OgjghE0c3LxUteaxgaCX2DKmix/W1K77CbJs6eTrmw5SgcwfiFMl0ot9Vidofr7yhM
	qJS7m/ZuvqLDK7SxLeT4NW/UZTgu6LB7B7VhVlRUCWhFlbiidOBvqIVsjhRR8OGO48kyWlTlsx0
	WUv8AT/b0a9Ko37P9vdZuBDWO4jgvkw==
X-Google-Smtp-Source: AGHT+IG6eTMGZlSvYS6870CgZ7yIJryNYolXHTtoC8ALrfKjoZtxsaUHa6cYySwR/CukO85ee0X7Ww==
X-Received: by 2002:a05:600c:4589:b0:45b:8795:4caa with SMTP id 5b1f17b1804b1-45dddeedbb4mr87688445e9.36.1757353767143;
        Mon, 08 Sep 2025 10:49:27 -0700 (PDT)
Received: from Tunnel ([194.65.32.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcff67787sm203223935e9.16.2025.09.08.10.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:49:26 -0700 (PDT)
Date: Mon, 8 Sep 2025 19:49:24 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: syzbot ci <syzbot+ci59254af1cb47328a@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, shung-hsi.yu@suse.com,
	yonghong.song@linux.dev, syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: bpf: Use tnums for JEQ/JNE is_branch_taken logic
Message-ID: <aL8XJI_gpHjjvX7o@Tunnel>
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
> There is nothing wrong with this logically and we haven't got a single
> real bug from the invariant violations check if I remember correctly.
> 
> Comparing the two functions, it looks like tricky cases are BPF_JE/JNE
> and BPF_JSET/JSET|BPF_X. However, given that regs_refine_cond_op() is
> called for a false branch with opcode reversed it looks like there is
> no issues with these cases.
> 
> I'll give this a try.

Hi Eduard,

Did you get a chance to look into this? syzkaller came back (finally)
complaining about the remaining invariant violations:
https://lore.kernel.org/bpf/68bacb3e.050a0220.192772.018d.GAE@google.com/
If not, I can have a look at the end of the week.

Paul

> 
> [...]

