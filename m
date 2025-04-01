Return-Path: <bpf+bounces-55087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4A7A780A7
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 18:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A831887756
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA3220D509;
	Tue,  1 Apr 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqK9tW2l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2E20B7E1;
	Tue,  1 Apr 2025 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525551; cv=none; b=cAq8o6o4yrRWVeUg3mo0vBVCL2E3bxpC1nIXZucum7IL1ODOg4S97E9K4VWoyjJ0FoiCxtzHAoN25ZWTExANeOy+zDnOdEVQ8maYwZ14gMNT9zO11LGzbRPh3acOsjH/7ocWWWssDnPsO8pzm688riIzC17zYSNAw7NsGf6NIjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525551; c=relaxed/simple;
	bh=1+HPiGJkMYpy6pkR8X3utQL9ZJoe9RZZqaoc8k5B2kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+IvThasitlz/D7KKObm84MHFQ79KR20aEmdnPHJwApF6VwZQs8TPeznNB6WrCCFxUgSkQkRMUAz0CDINPoTutv6ft8OPQippd0rDeis3CiPaOkghrXc6D4/c9YCKCOVik7VH55/Hlncu/+6Gmcf92+FbRpXXf2PSNEMV9FXK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqK9tW2l; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227c7e57da2so87249355ad.0;
        Tue, 01 Apr 2025 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743525550; x=1744130350; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fXxG8/KJLq5lQeA9/oOuwtl3Ja9SvkQ3rvJPvyidBdk=;
        b=bqK9tW2lTAa51Kq8/qdCnctS8/Vu+yFBojtutV6ApEhINk2HKyLG0vkUPpCQ5wWpSz
         rYWfHh/+FNacXejJLC4T/Nnt0D63ziOnE6KiViCc4zQD+PPWmdK2KROI/dkj7ZoChuAZ
         JS3ve7t3HyjwN+10jXPj+8DHnckE5uQZHJ3EyemvYLHlHoCX6N3+K4I6m0isx4UcZiDE
         PmosCozMXQjoP+MVIkSr50Awu6ctj9gABa0BhwCtFhmCxwMq3lcbgXJj/DsP9RXKCm8z
         +mUbuCG8P8cLJBmUuzqjFsN59h7wLh5UjYUNEIWRfOmmZDpbUtQMJeVPY1P9joeF6+Ee
         ZMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525550; x=1744130350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXxG8/KJLq5lQeA9/oOuwtl3Ja9SvkQ3rvJPvyidBdk=;
        b=bj9QwE4pc+IhfLgfjx3YCUiIuWKK8E9jXif7HPMPGDguRNjJYkknsKbttV8zGg+Fc8
         JWAUXM1JOnwOFufpXuQns1lE2UvPVGGve/p/tUqifDHYahdsKA7cQ/oVP0NuOJD8hFk5
         mhs0wk0vYs07CA52eejet5hR/oFoG3GmeSv/BgSU0EpXm9MtkpE2JoPb83oVurVPp8Vm
         yP++mg7Q1K7E5sOiGIxeolF+/YGzs/x7IZ7wzgRVl/hHSfEN0U8oV+V5CLBX/W0q6Rk6
         CXBlkb0shQpmbZBJ585CrtRSsL7vBz19LJHvhvf53+nRxwPt6mpGwNYTc6X8kRwe8WCK
         qubg==
X-Forwarded-Encrypted: i=1; AJvYcCU/bMQVNzlBZfrrTjqyT8xJmqm6Ka4bNpTZy++lRrdGjSfSdohf7HCkayUscxLk2Jdp2V8=@vger.kernel.org, AJvYcCVrgQbI19iHlh6KiGd3WGhRR25opbUoLria7SWMfPlMBtKsF9DTB6NvJEzje1/XC1msrdBDjYIcIUu8pnvI@vger.kernel.org, AJvYcCWkky9fASzIZu/2nen66G+4KlMfJgpCmGk+2sOyBTMen/+L+FCmdXtCM+NuJ1tdjhd/BeAO+dHh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9seV/LUXHbTzLkonQojp2duG1IGmqS2A8VJAXkUs8aJZuZv2i
	FrJSwHBBZg/W2YWBm1uIWlKdkP6py+ZJJQ2vl0M8BsxHCm03LnZGwNbTRlRG9w==
X-Gm-Gg: ASbGncvoLofLhN5ynb+loJUNTD0LK68nBG3qA8QyUxQGmiHf3DzBHzSJ2SHKc3smSCq
	NLLOR+i1i5XKCUdajaU7z8/ztu2cCdg/NoYMY4wJjVOzChTsUNAWOVABLKtyJESFOnUrWRhl7Qf
	1SOGLDKb3x8EOAWjxz6ZIvrFncwe0YWlKetc3c91v0PijLaK6RCF+YkHLk7DTB3YITEgKsUSVGv
	gTWlzJtrzn9xfmS0mCRDrRhcZPGGzvzDxKYgNZKKPIQ/PcA48OLklZRxpp290Hd0nxPiaEol103
	fwIjy9pWS/VCF+Z6sEfSaJjyF2HST60NgGCeEglWDaR0
X-Google-Smtp-Source: AGHT+IFjFplP/VCj1K4hdj1XXuXFukTUKN/Y7r7TPX+q/ahHctFj6US+a3x6n/bezkuEQqYB8kG+jg==
X-Received: by 2002:a17:902:d507:b0:216:794f:6d7d with SMTP id d9443c01a7336-2292fa058c5mr244283035ad.48.1743525549716;
        Tue, 01 Apr 2025 09:39:09 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eec73b6sm90853395ad.43.2025.04.01.09.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:39:09 -0700 (PDT)
Date: Tue, 1 Apr 2025 09:39:08 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>,
	bpf <bpf@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf] bpf: add missing ops lock around dev_xdp_attach_link
Message-ID: <Z-wWrMfsUtfrnMiU@mini-arch>
References: <20250331142814.1887506-1-sdf@fomichev.me>
 <d2914c9f-5fc6-4719-bf6b-bc48991cd563@redhat.com>
 <CAADnVQJJFPD2X1enPCa-0D7RG6SraRFTdMj1bsKkzFuz6Nighw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJJFPD2X1enPCa-0D7RG6SraRFTdMj1bsKkzFuz6Nighw@mail.gmail.com>

On 04/01, Alexei Starovoitov wrote:
> On Tue, Apr 1, 2025 at 3:33 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 3/31/25 4:28 PM, Stanislav Fomichev wrote:
> > > Syzkaller points out that create_link path doesn't grab ops lock,
> > > add it.
> > >
> > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > Reported-by: syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/bpf/67e6b3e8.050a0220.2f068f.0079.GAE@google.com/
> > > Fixes: 97246d6d21c2 ("net: hold netdev instance lock during ndo_bpf")
> > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> >
> > LGTM, but are there any special reasons to get this via the bpf tree? It
> > looks like 'net' material to me?!?
> 
> Pls take it through net.

SG! LMK if I should repost to make it happen. (it's always hard for me,
with xdp, to figure out the proper tree)

