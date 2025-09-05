Return-Path: <bpf+bounces-67659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA36B46756
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 01:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066EB56573A
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90273279DC5;
	Fri,  5 Sep 2025 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3A7p/QiZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC56E2797AE
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757116502; cv=none; b=qdC9cg1sWKb8k0Y3bs0AT9OWndjfXX4Cf14j3Iocd+VbxPePSzndeQd6nvk+zMp9HBv3PecYV2HVmbkMk1wTTbKBIyzBhEX2w3bfkjKhUAbmw2o563VK3ypUs+HoWjysK7IzekdQ5y+fXcf7i6wlqBSiREYyn9w9ZVlTrre41IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757116502; c=relaxed/simple;
	bh=UFjoh0yun9Jt3uWvDF9Z6Ur8uctyhnqqciFXlHuyWmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+tufolqZiywzlLra+IzdkNWJQmFljWO5S6fDMkqlvy98ox+yQsyFLP1vE4kl0QdkMmJFjqCsPb+dWn0SPZGAaIFCWpDftqfH53KEbC0dnfSETVsIGRQoQV9H5qohhvoaoB12g9KNWZ3xRHn6GOphP1FEuULGqYWcvXysD7o5kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3A7p/QiZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24cf5bcfb60so61155ad.0
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 16:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757116500; x=1757721300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFjoh0yun9Jt3uWvDF9Z6Ur8uctyhnqqciFXlHuyWmo=;
        b=3A7p/QiZNrzAVxBh1nJ8bpJqkCKgss5zI/D8uI1TjwKH1+PUVI4KUclRDShOAB/Hnh
         YhUFHoIhbaYTDZ7kkPaUoLM0u6MZaFHhkGf/sE8q7l2Y5YVwoELas+cPIpIeeHqPrngO
         fh3NMAPpkI5LpWCwNAg6qArYwztbNaaapppj2dwfAatUPhHhh79o34/JxqQsLj8tw41F
         yETNMLzd7dEofhyHaKRyitZ9d1r0vdHdQueXZuuTOkOm4J5idye4taxZGAPPmUtyxO5V
         PvoqN/pGZ9mLoofioeR1T1enxC/W8fiOBo6Ae5dQnMhCmlL9vq8Xd8Ptg5IOjF1MbK49
         kUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757116500; x=1757721300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFjoh0yun9Jt3uWvDF9Z6Ur8uctyhnqqciFXlHuyWmo=;
        b=GtQWfu8ey9sTbxwMa7By77X0guZJVovyFUuEiMRm+3qkgvtKppvD/I/CKUNx95axxI
         cCRg3z2fmBL1Cb84cRJB81DjqfaLbPi7uUpPF35G9xhE6dhJq09ekC1CGCl2fF4/dvZo
         /+gP4o2wsFFQ1SlA9fVPBoG5aZFXPe1AR5rPX9jMYqVhgTsa6GK2372t/Fh7uoUjAutp
         4kG9k2MJNgCaCtilc8FQkDjCmOi7cAV8bHxHwIstR54zz6Zg3y4mQCxvMXx8shpePUJ9
         0yX6WXDFl6eomZ4STgaMJ9qkEjwlejnpjZ9l3b1owSXa10Hwl3m+1OBn5Pn5kAg/sF3S
         sY/Q==
X-Gm-Message-State: AOJu0YzGo0kxV1BBWJdBYd4NEFtpt6/eKz/wUnWfqUNYU2UbSw1G3hx3
	ksVrNLaQZdmJe0a1Tu/szrvixl9N+cCi5wyDdX+lZzuElOXT+MRHgqFpF72ntUpEk31t57s+4S0
	AE/wfRg==
X-Gm-Gg: ASbGncvj+53rsCX1KM+etAS3I6bLmJiiWgNecZbkNwZafzLjgi9uDLi9Mydafv4As+C
	vaeYr6uH6opMYEwKp4wHYInwGfMf5Mon2EecoOwVNfSL5F4vD6R7pj5vehRndBmOsZSPX8bXyHw
	F2iNhvGrDzAo/+p8+pLZiDk71z+HlB6UhaoTokDAWUVIN0rSHtHjz9tDCgXR3twgPYPDZqyqfSk
	xQUDtMgR8WzUg/bSSmoijizGmF95PItXRxNmkzhLMfVqe4HVi8FSA8wv3yiWr+cCKdHzw13jrSW
	/2oX8/yaOfSUecWu0MAe1lKdM4qP2WOGTmvl9NWZIkhbeRidlF1DMfgAF7AeDw3oRTYfYWoMt+Z
	8P3ytzZFvVY1hPyfK32acEeSIEWKt1CrSpum05neARb/rUXOGSK6ND6IsHAaCMM9PpXEXL+Tr9i
	+NNA==
X-Google-Smtp-Source: AGHT+IEWOdZEWK6OGKrlJi/++b9kR9pvklbQTGYdOvIZsaWRdSDtHRwHhrXyU2eEfngOzkqrg5CSOA==
X-Received: by 2002:a17:902:cec1:b0:248:79e8:9a3b with SMTP id d9443c01a7336-25119470048mr1579015ad.12.1757116499518;
        Fri, 05 Sep 2025 16:54:59 -0700 (PDT)
Received: from google.com (132.192.16.34.bc.googleusercontent.com. [34.16.192.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e9fd022dsm11563888a91.3.2025.09.05.16.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 16:54:58 -0700 (PDT)
Date: Fri, 5 Sep 2025 23:54:54 +0000
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH bpf] bpf/helpers: Use __GFP_HIGH instead of GFP_ATOMIC in
 __bpf_async_init()
Message-ID: <aLt4TuoFy-83hkt2@google.com>
References: <20250905234547.862249-1-yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905234547.862249-1-yepeilin@google.com>

Hi all,

On Fri, Sep 05, 2025 at 11:45:46PM +0000, Peilin Ye wrote:
> Depends on mm patch "memcg: skip cgroup_file_notify if spinning is not
> allowed".

For context, currently the above mm patch is pending at:
https://lore.kernel.org/bpf/20250905201606.66198-1-shakeel.butt@linux.dev/

Thanks,
Peilin Ye


