Return-Path: <bpf+bounces-79474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF5D3B3BC
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 18:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70EF03051314
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D3132694A;
	Mon, 19 Jan 2026 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMFxGtQJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F617322B63
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843010; cv=pass; b=Jz6GMgdDOPJAwrSVCf6Ojt1of7RtXb/lV7kpRkUADucfS2R9j7CkXd2ZNst33Lh/dRgZlNscsVWQbYcbH2AyXP3hW1T5I6L191ahZhr0Bk37uEw43gDAJv3jCFKg2POp/T3I4OguIgH7pTCuSTVB+4+7stjHDzUz4y8cV2D6Z+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843010; c=relaxed/simple;
	bh=ZsGcxa3/dujvAI4Rmb4qGNPcgAP3/YJKOOLBJnfEpuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJKJGDxptpPFepNe4t0UM+HHHodeSOxa9YMaGnZSDkn20Xii89lehGarJPy1K3tLGTMY7mD0xCF520/J0M9Acpc9R6gnMj0eJwNSe5RzO3umaEBjJVjKjD4KlI0s/Q9s2k3A4fwwEbyVxvEroZeDFNNh52WRHcScK3oCqyz1KwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMFxGtQJ; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so3953672f8f.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 09:16:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768843007; cv=none;
        d=google.com; s=arc-20240605;
        b=YoZJzWHjCk0oJ9Eb2kAu2Rn+FDXxrYDzXAOwJRZL1QZlhzf21XyyO/gc4tM2p9C6fG
         kR6ulxgLVBNujnqno8bF/gugB/eywlTL+tk7kMuF0SJmBEb8Amzf4AoFvukuSq+9aA6m
         maTiWL5i2YkFM13l+8EuD0EF5CVKa34KdwPGcrSEqU6I0ntaYcFLfVqWb8KVqF3eIKk4
         qj0LhnY5pHWm7fWwe0/2n+FjsmTujaWzycgnUHJ/1gCAbxwa8EnT3WLtqcQS6UnuPoFY
         rbFIxXFKHKLy4llrivz4C7gcTZLlFNH3G8nxP2S1PQoMn7bJPyLx+XUcQMlwajvWoXyB
         Xy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fWkUXehTFxDxM5oaQU46NekzR5HsGH8LROOWkLyzh8s=;
        fh=x5qJqUGvddb7dXaDPWnb9ft8iQo95rv4iioR9LqrhFs=;
        b=ctrzUO7i8/tmPVIygPl2umMqBaoKtXnJYW1H786gEmr9scKMCO1FvC6Ufxqt6e1bzG
         RwozTHxsK5OI1bT5eampzR9x0JsXB2Yj+X8oMIdYpldrDtorFsS1tvJ8p9uHIlLaHhfP
         z9KF6P3nlFA7qt+jNFUgAeGbteAZy7q7PtVtmjKqE0GAUjVG7hkE6Kv7KIwZPKKIEE9e
         0IrfOS3lYn5D4GPioka2o/sDO4TJjg9G4CCjh+YWOqHzHiP/ql5yoAKyS8RDmdLyKrav
         GoDUz7RIJZBk/eoXkKRKAMgiFbjo7fSQ+Q5Uw5CLfvGjM5+uy9GUb3QruoFPr3Adgq+/
         3hdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768843007; x=1769447807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWkUXehTFxDxM5oaQU46NekzR5HsGH8LROOWkLyzh8s=;
        b=HMFxGtQJB8yNIu+iVcfduKq8+H3jqRLpQiFPcT2JeIgJqtgWOvjV1F8lqYWHMHDzsc
         Jrb6SODsSSIx7IcLImFT2MJpUHgtO3YcCA7+kiosGu8mS3zsCcmkN/Fl8V/M3zAM0KbS
         k4XJ6ah/+Yz4Av71A+4SJI2jj91J0fri16+gggYbliR0aRVXwQtAtv0LI+5RWDaoQg1O
         75+GfZh77gq2hQhpuTHRHe3L5ObCCWiciWE/7oXWaMitr+L2vXSVFA3i/raNZZDz7dwT
         xzBz9k+irhxfskVD+xVxSiwt7DV/3Em9ij5ppgQslSEz7xJ0czzdzptalO2dbO2sEFWO
         3yrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768843007; x=1769447807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fWkUXehTFxDxM5oaQU46NekzR5HsGH8LROOWkLyzh8s=;
        b=Tg6TiNGd9XnIYPjDG7Sq3IQz4vkaJ0TStCtfLY5bEvshp9d8pFtR8e5ALN4lufRVAH
         Za4+ODFER8OWw6NXh0b2l7bbWzQgRH/S5qZA94HmKmPsu2U6yELE+w/Ugqt8iLMsRs1n
         4HlidrCGevlBNYz0zVYEpezl7tGTowC6nZw0WkwkxfWf8JaPNY7IYC8rj5kxmf4SwlYF
         4EVFzMbqhcgIM3tEDrrKbubu/hTKQ2+OJvywW7cZ6tX42Qq0Nv/54Zvg5rTblp1Fql1O
         PBtbAx8EpKnXvtoHDzrCG17AnLTP/KfagkM+tUjLh2+5ieFDjxHSGoyRVEqRzawABi7x
         AEtg==
X-Forwarded-Encrypted: i=1; AJvYcCUPyqnojh4y22FPO5qDWok8P4t0CDJYlYcuD6cbdzqdOul+T7ssCpYqOIxEKD9kzfn9zOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQ57uNvqrvSF2MHNR2Kip/KduxqQo/T264NE8KyW0ZlMH0ubv
	cSWloc7KYpDRwelIVs5MoA3ZmnaiO2XlX1F6zqyPamHkzixnFt4PnaRYoFxSpenoTmgZq5qrCSx
	IDgbPLFmnAv386qgh245l2zGK0uNAhXM=
X-Gm-Gg: AZuq6aLerO6xg1QoPiFs9/r8Vbgf1/jUKcZb2WetIGQ4SpI+3kVFfRc/nDnLo52TvRN
	Q5l4VoQx2Vrsl9HUq6hPCcQVmBmLmcEfQIM1PEJ9iRvZpfqFY+onRuUqaFkSdIkWm5I+tTHWfrJ
	gcn4f6UlyZz1rLlA/whDihYTm+9wh+zEAblseUbKYcOYfT/M/VapLOJGk6MvCfDYanL91q/GLDO
	zvu90N+dku29fHUYvexbImHfwxxx0kk5FAZz+qt0rcdytO6XUhgmbyDr8pu0Oq8KEUsxC0khB7l
	N1qhlVouIJmulDNJsJExS/DVnS+JsxfQhuZQA3lgOHIZ/z8/01Fs01I=
X-Received: by 2002:a05:6000:2282:b0:430:fc63:8d0 with SMTP id
 ffacd0b85a97d-4356a0773aemr14767256f8f.36.1768843007458; Mon, 19 Jan 2026
 09:16:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119091615.1880992-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260119091615.1880992-1-sun.jian.kdev@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 19 Jan 2026 09:16:36 -0800
X-Gm-Features: AZwV_QhGkCpvhEfASfQzOJSn-VdxNup-v3_JeJot5VLuqsiIqW0y6hGuFkj_iBM
Message-ID: <CAADnVQ+j8Q5+2KSsaddj3nmU1EkuRAt8XwM=zcSrfQfY+A1PsA@mail.gmail.com>
Subject: Re: [PATCH] netfilter: nf_flow_table_bpf: add prototype for bpf_xdp_flow_lookup()
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 1:16=E2=80=AFAM Sun Jian <sun.jian.kdev@gmail.com> =
wrote:
>
> Sparse reports:
>
>   netfilter/nf_flow_table_bpf.c:58:45:
>     symbol 'bpf_xdp_flow_lookup' was not declared. Should it be static?
>
> bpf_xdp_flow_lookup() is exported as a __bpf_kfunc and must remain
> non-static. Add a forward declaration to provide an explicit prototype
> , only to silence the sparse warning.

No. Ignore the warning. Sparse is incorrect.
We have hundreds of such bogus warnings. Do NOT attempt to send
more patches to "fix" them.

pw-bot: cr

