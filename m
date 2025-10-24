Return-Path: <bpf+bounces-72140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE14FC07A95
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 20:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1AC3A596D
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9E6346E71;
	Fri, 24 Oct 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyBW6PfX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA2346E50
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329475; cv=none; b=AicBRIXVUoNA734cEWRrM+fY2+9+UTqLCiulRzHrmqoaXBebeC2w+dZ7fokRA2WBsYNF7J5ubpxnaeu6KS0dJCw8fuD7nQhVlgE8R0uTqnD2OhoCglz10S2gTeZthI9+bocWSYRYKuL7apb9u7VnqJAyq2Tau6rlnNx9zqxQn5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329475; c=relaxed/simple;
	bh=bMYyMRYYx63usGZcxhgDTyUi63gOzISxxw+njEnKuUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnHft47G8pgTlKTR5GGI8LEHIMFP42OgO6q1UIoqEZNoZ2AKHpCDW1V7cADhwZcQvi53IkhJ7e+L/2jPJJDh9vT9QfVn1AEpb/7hc4Wwjp7IaHiaCpABcnrbyLz5CV9EAlCV3Q7C2KcXvWDX37d5nEHUBpLDNxFVT0g2485pQ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyBW6PfX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b553412a19bso1532987a12.1
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761329473; x=1761934273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdBb9lC3u7xEME0W3SXgZb4MmUAFksfdfBLRlWCIW2k=;
        b=kyBW6PfX1ci8GdZZ1suXIC6Uu84624aGxWlENkQ8I5D4jILmJj8QcbdRhVw81couQx
         yNy33ljvcCgCJ0e/jqu5f7l2dylih01bDOWjN40lQUcp41ln0+HiMo9LNJVKrEa8Oyzq
         gVEOLaASh4W13bqEMmqiql6B8WVuZe2PNuAK39QdM2tBVMHJuo6oyppwSiJ/Zgq7eP5/
         KkSy75BVakUI1vwGVZiqPRC/5gF4FunpvbQb4pTvy22ReVNwIvXq9Hjp+kurIRQyRfPT
         FKMua0VFZAkfMHPAQpUnMjSTyjX6lyShfKB349XH1hw731ruCude1uS+SexJA+FtqYf4
         Hu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329473; x=1761934273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdBb9lC3u7xEME0W3SXgZb4MmUAFksfdfBLRlWCIW2k=;
        b=s1kqIhi5g78ZGEluwoSWftD2GoKiq8EWTBjqKVaUK30faWNYMKLWjNtcTT9PE5nN0t
         1e8Oo2tp8gVCFEV+udpYhjESGtOA64vsvaEhVOTwT6Sr3/ZwRuM+H/zKof1HgxEb/kcJ
         mDxFuDoJ4W+5+IWhKdWN2jtNuB98/4mcS7aEuJXzQKR1uUEx53bUIzFvTaJmh3GKIqlA
         zmH3xA9pRHVDwYN987wdv5vz5e2QG9rLx1rE3N4Oz7FVCtm4BHNiPnbhcH++DZvqxZAX
         CXR0sEcMJRNuioOaXwmCD0u2d7Gcn+YH8a6w6ItaRTrQknmt8VExk8r4FiBSpjQ9YVg/
         nJhA==
X-Forwarded-Encrypted: i=1; AJvYcCXN1oHl3d2zvDsgDFJXow8sogGQubgABSYZRqIrOUQgqUqP449cK6wbqZbPRyOpnb2jRPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBVQCiCXUMQm3oaZ6k24sAv68JoN7WLdboRdt25WYc5bIQvs0q
	G5dxni+OkbQWXBc1gXFPZkFOfmhv8Nx8e+IvlTU5eRDUwJXAh09oFdE=
X-Gm-Gg: ASbGncvoYM+NKHAGMI7fIIlR/G+cNo8e2bt9aDWFSUOmm5IOnlRHOHJeWJOPnubZXba
	M2hO2lnuDfO1VqZbAKwZRiCNTZDxABV2zf7wWboYTxbKm8SpGgjxDALTUuhQ+4a1TWC1jgxp+ya
	AoQpkbPhMsobFdIo8PSWHQUJ72NunDTN/PpyrCWWe1tmhPeVNdYGyZh+PYCXzysWL0gL5Z/EY/M
	n4VpqO/5Mrph9t8u9DVROFtIMIhOcoDBhipsw9hpoM6vtKe8vxm4pg2/G+XRAv7/Uu9sKjX9dy6
	vpZTXoXjVaTPTwtD3qdK9DuDzbuY3hgZKjJu6eaiC0z+x6vwD1QcJSWnyo9ATljcan+paR2c2zA
	diHBMSKxBierF4zZnqao3VS3cYg1vjYxz3H2WH5eU/ktA7AWlclPgFaAuKJ7CptdckPtct5HxcO
	pBM4PAhvKPOs24BZIMI43s4W5r6kFRC59/6V5YpFEWI1sJzpJBvLRkHaUOmuOIN7BLk2r4j2w96
	0ktRaOWGuYl8d3TLQOt1S0YlkGKE5fQ+cMENPPAPcFVKJ0hX+VDT1NQXydVYBPmX6A=
X-Google-Smtp-Source: AGHT+IEnquZZ3WWeLP3I5w3hVGHiZ7NabHapZYUY+I27WMmRanZ2oSutfHqVIc6+kSwOgCVCmqzk2w==
X-Received: by 2002:a17:902:dad1:b0:26c:87f9:9ea7 with SMTP id d9443c01a7336-2948ba78fd1mr48423245ad.59.1761329473016;
        Fri, 24 Oct 2025 11:11:13 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2946dfc1314sm62440755ad.58.2025.10.24.11.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:11:12 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:11:12 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
	pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
	john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v3 01/15] net: Add bind-queue operation
Message-ID: <aPvBQJ6FUN5X2kMW@mini-arch>
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-2-daniel@iogearbox.net>
 <20251023191253.6b33b3f4@kernel.org>
 <c93a71ea-fddf-4f0c-9a01-ca5f1729037a@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c93a71ea-fddf-4f0c-9a01-ca5f1729037a@iogearbox.net>

On 10/24, Daniel Borkmann wrote:
> On 10/24/25 4:12 AM, Jakub Kicinski wrote:
> > On Mon, 20 Oct 2025 18:23:41 +0200 Daniel Borkmann wrote:
> > > +      name: bind-queue
> > > +      doc: |
> > > +        Bind a physical netdevice queue to a virtual one. The binding
> > > +        creates a queue pair, where a queue can reference its peer queue.
> > > +        This is useful for memory providers and AF_XDP operations which
> > > +        take an ifindex and queue id to allow auch applications to bind
> > > +        against virtual devices in containers.
> > > +      attribute-set: queue-pair
> > 
> >        flags: [admin-perm]
> > 
> > right?
> Oh, yes good catch! I've just checked for other instances in that file, don't
> we also need the same flag for bind-tx? bind-rx for example has it, only the
> info dumps don't. I can cook a patch for net

IIRC, TX side was non-admin-perm by design (because it only references the
binding for tx and doesn't need any heavy device setup).

