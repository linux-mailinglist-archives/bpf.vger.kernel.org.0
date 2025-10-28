Return-Path: <bpf+bounces-72524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 265F5C147E9
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 13:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0AA44FF3B8
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42606315D33;
	Tue, 28 Oct 2025 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPXx0Jg6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136153164DB
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652774; cv=none; b=m0JEy0A3OGcgioJONNvBOawU7NhETCh3TV3RdOUfZK49XnSf4CIjLRR3oh0r72e33KKRoRVJQ0vsp1bdO9Yx6wPqCbXg6g60MeKbCpnvLbhGNFr50sSpp7231U83btkOHNY/wCyR8DHugFghzwdu5Qbyjt6evBfx1FL2zf4Pha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652774; c=relaxed/simple;
	bh=496Cj4B4oPYr5qYzc6XJwxHRsYx7HPx7g7H21GzRH3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVHXZkOPiTWXJxYsBvRLqLacoOU6Aq6j1OnzRgXORagTEqIslHVOpKGxDxMxC6qxGtRW7UOQKFxOedvnyHfoOccbRfoJSbsSWuY/S+zH8llR7CvFiciMkr9VikVO8F47+NfHfMgCvLyCYFvd0sqTwRgGihJhdMwqOJY3H6rzPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPXx0Jg6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47719ad0c7dso6628185e9.0
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 04:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761652771; x=1762257571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+fxn94+HNpCf1GCzkDNyKEG4+u6LZDq/Aiup15HG3c=;
        b=KPXx0Jg6IWw6V2x7dujo0OBtYzRokDOUHN8s3EOyS/WoiED0wMkXvvzdX4d+uQThKn
         fQv0GKwcCZMqVZd3w4h8d08BQSRZ2YfgAso6R17KxXBcNGeWb4Hw7emPvsj+vLlfX4Oq
         4H0bBa++BBPELOYkuHj7Vs+fcX+o+6lf+pf5R0+DeFm7zdH0pgY9vpnSeri3WzHQqrZB
         7fXMZA9QZmQoiL/Rx4xGXawkdd5/oKWlL6hA0Ssvx6a4lvKXwo4y2ueU8sx1RnqNvi7T
         EJWibFmBEpDOjMQWAQ5VkiqAj+9RRQUzLbDMleeB+2Y1eKSQLvvi23TMO8flMVEtiOA6
         zrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761652771; x=1762257571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+fxn94+HNpCf1GCzkDNyKEG4+u6LZDq/Aiup15HG3c=;
        b=ZpkrwVjS9KN0BmmmAZ9Psuiva7phiAIOMQnPMYjv2sHMHoXbLFzFyhwMzrTzRj4ADz
         JA1vysueX5pbQ9Os4u9QUGjiMhNPaQqziwjdDjmUU77WmH82Kqfl82DdJtFjpQeUKs7N
         Nb2Rp4/zINKaluzbnVxdbFjc5l9EhGuM9IcR7EtgwdDtn64I9y1e6yJowqEQdNq2m12y
         BKYpHmBkQMsv9/rS5y62qEH9tga4/Na1PcwKMUWpLzH1Qmt3zuot3RnH+gfRYdh5yvMX
         pRcmJD/htznL2p2XDo2b264b1L3M4YhOeyJru2LI1295Bz1KRs9Qn/Y2BPrSJIV4QuTb
         2+Ew==
X-Gm-Message-State: AOJu0Yzt3BlWB/pfViVkEN6wpsTdQMN5KbTLXOCUDnrhwSn/M+hoKdf+
	JxsnvntJzMq4lGV/VktSY+8PMwWuDGyrtWkrmJ6tPKpGRlSvr/IQLIjA
X-Gm-Gg: ASbGncuEQFimPH91OCHTehNxZflOapOJ/A7bQBs+6C+60PDgkadTM+x1kAXZbStqnSr
	A5NRACI9DrJWAqi9rD70+fjrCvLrTpiy+vHD5fPOAS+XiN04ipMW56NyA3xB687h619d0SLkjtt
	mMmv1SS6Equm2dkyVRPpCtqYzbg2E/YrFRpdzZoNl+ayVCwcrFQVGHECcuN1OzjJ/vCBjXu+hXH
	4rVvTe5oqbz9VnkiSQ/+Nae8Dechfdm4J/8A43DIRWCY+qfoVeEHO6Bat6Y1JIT4upkwVFIFXU2
	GXU9DnW7zW1jRxdjiwsVqNkoTMH0PU07zvYYyY4m7We3QXxkBXTX0AQ0T7HoG1AESp+VEURJYOq
	IIOzhrBZqv2jNBA3Wm+SLqT2S9oH1F5LTqwui35AiXwog6r+HNwAPQ1HCFPO6ayb9TqYmStddUT
	f1fybNH5EScA==
X-Google-Smtp-Source: AGHT+IGKPu4Q9UU6BieHygwtgR+VDbBilq1SLQhMdUCbo7QkzG7T3MsOZLEz6dQzWK8fbOpjyoecpw==
X-Received: by 2002:a05:600c:474f:b0:475:d7a6:f42a with SMTP id 5b1f17b1804b1-47717def7cbmr27480525e9.1.1761652771173;
        Tue, 28 Oct 2025 04:59:31 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df62dsm21757651f8f.45.2025.10.28.04.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 04:59:30 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:06:06 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v6 bpf-next 16/17] selftests/bpf: add new verifier_gotox
 test
Message-ID: <aQCxrhhGgF0qp3c6@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-17-a.s.protopopov@gmail.com>
 <b0e59e59fbe35090809ccbe0b01d923212c789ab.camel@gmail.com>
 <aPtltvv+WHPMEnNt@mail.gmail.com>
 <aP4VTXG6n7XYnm23@mail.gmail.com>
 <b781c6ae49f6cf3834e345d7c53e4a54bd958bb8.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b781c6ae49f6cf3834e345d7c53e4a54bd958bb8.camel@gmail.com>

On 25/10/27 04:11PM, Eduard Zingerman wrote:
> On Sun, 2025-10-26 at 12:34 +0000, Anton Protopopov wrote:
> > On 25/10/24 11:40AM, Anton Protopopov wrote:
> > > On 25/10/21 03:42PM, Eduard Zingerman wrote:
> > > > On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> > > > > Add a set of tests to validate core gotox functionality
> > > > > without need to rely on compilers.
> > > > > 
> > > > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > > > ---
> > > > 
> > > > Thank you for adding these.
> > > > Could you please also add a test cases that checks the following errors:
> > > > - "jump table for insn %d points outside of the subprog [%u,%u]"
> 
> I'm surprised this one can't be triggered.
> In case if there are multiple subprograms defined,
> and map has two entries pointing to different subprograms,
> what other checks can catch this?
> I see only the check in the bpf_insn_array_init() that will make sure
> that offset does not point outside of the program.

Yes, you were correct. I will add a test.

> > > > - "the sum of R%u umin_value %llu and off %u is too big\n"
> 
> Ok, this one is handled by map value read.
> 
> > > > - "register R%d doesn't point to any offset in map id=%d\n"
> 
> And this one as well.
> 
> > > Yeah, sorry, these actually were on my list, but I've postponed them
> > > for the next version. Will add. (I also need to add a few selftests
> > > on the offset when loading from map.)
> > 
> > So, tbh, I can't actually find a way to trigger any of them,
> > looks like these conditions are always caught earlier...

