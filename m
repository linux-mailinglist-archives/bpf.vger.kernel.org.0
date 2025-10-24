Return-Path: <bpf+bounces-72088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E756CC06358
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 14:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AFD44FCF26
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 12:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BD32D46CB;
	Fri, 24 Oct 2025 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ml1fy9PO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADC1314D3D
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308281; cv=none; b=ZGsV9tAU2nfODn4gF3JEz7bNVBGq/gLuhDTkclF8cL+IBFvoN9PzOewqIc0eGjpWCg3XATTZYHdKfh8/UcpiUvbm9ZEs5JjzyFoBN/Ldk2HxK6fJ8B/D7G76zF8EKxS0lr9E2PLpiZkuEfgarTr0IkvVnTKnojJ93005BDpzY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308281; c=relaxed/simple;
	bh=ILD40X74to4JJxXmIV9fExfJmF8MLUGSaGPvFP7I+ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D+mZd5xj936MryiaVYvC4LYcRvu+w2KlERz+yUkRvAmeC6WTHkzN08Sa0C+DQd+SibwGoxam4LJiiflNSxz8TlJhw1zJzUOMNkQ+5Plux1A5sQdizAmM1p7vHEyUh2RBZYit6DXk1UFR43p3F44J5lwp5ZpjANjDAZXStL0lfqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ml1fy9PO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63e18829aa7so2853308a12.3
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 05:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761308277; x=1761913077; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ILD40X74to4JJxXmIV9fExfJmF8MLUGSaGPvFP7I+ko=;
        b=Ml1fy9PO83aU5AY114Nb5D04dYtIyDdv/07o2jD8P2uslzoKFfALBSFwdpG2nMHOS0
         MhnHUCGLOOEQg3TWw1Mi3pPKEbJnpZsGEM8KbStCEH8v9+kkX26AjVTUn6ZjL44LolSn
         lWyLfwnRDAQ7hnpTKRe/klBDWGVlx+TGos3EHr4WKTg3V6qyC3En8OZ24yhEVc/085mz
         o+QGgqogEIbMZtncjLSZThygk7Hw20NHPZxzWI6zPu/jZYwC5oHnB6+c3Lfbp1/AQMyH
         Aj8YZlXcXVuWyFErh33GULgzpPc7GUxpL7Ml9k+pPXTYuaJdixYLBh3JCusR0csInie6
         IXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761308277; x=1761913077;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILD40X74to4JJxXmIV9fExfJmF8MLUGSaGPvFP7I+ko=;
        b=MVEkh230rasZe3Zjt7uQ5RTC0DcQxZ+d2Q7ykTCX2mw4ZsmP4wrO5kW8762cDQhJvJ
         FrI09YGzX+PV0FLx8AAvwr8rawbYyQw1pI3wF6/iCQhbgpJAPTAy1/x7HUevTZhJSEHv
         SmfPkBASyZgydTolh0AobGm8FbZx1PjEps8esjYy/mPUC/L0brqoyPi+ZSMi8hGSs2ln
         HdjjnwAW0UpL2oDZULaw8LKriimpXm9/pBJGebwf1rQ1pSpcvqzjSwYMlujTq3f6exHe
         KVERczZITL6aGdNZ6oTRvv75WOlLktBDIpqDyCgNEeSCCeiPqHs6M1YceApYLIu8vZNc
         lLpA==
X-Gm-Message-State: AOJu0Yw4Xlerg1mo0tdcd6R4PAmOt9+fqFKGZfD+NC5WfSnOdwmZbv2u
	XuUiFb91m1pkKIb1Priosqo2xaVOjtgeNiDAea8fhmVqgPq97BBN6vEPpsV3V9tLtgA=
X-Gm-Gg: ASbGncuinaZENJesH7aUnX2ipAruJ1SOsF4GEBzr1xj3/8h7r15obqtvDqKsfUtEarD
	jwSz0zzYPnJDL/lzQoIB0sZawIKw1bDy/2Hr6103qRpwIyUBtizZ2TgXL5KA7ZlQiyeSxsJozfy
	mj3u5PASEprEUjkvH2SGlPuGTi8sSqSCYa5Sc9NFp8Gh9ZH+8jdvGtm+F7z+jRVrVekGCxg9eSr
	z0Q1DrklyYtWOjJkjq6sipRzGO6bN9oim9R0shF8ZBKlYiQV3nRjKsZayxLk+4sZDJaifNWKX4/
	8wPAuENbkQN/Z5ZzkJxOiq/Ln4A7isgSky+F48s2B0mL01hRjRttCiGqznB72LWYoizG9wwIe8E
	p6LWuTh8Y1IhXcBjMFIYea07r3oxMpNw+my2vi/HGkLvMs9VVQ+NxkqA3mSYlZfPHvUWoEgc2SN
	6SkA==
X-Google-Smtp-Source: AGHT+IHOfSLnLjNWUqFngN92+6HXjYXo+BBWQIQXvbkaxZXMdy4qeqH1cAY92A2uNRHh3J89ZB/3fw==
X-Received: by 2002:a05:6402:2686:b0:63c:1a7b:b3bb with SMTP id 4fb4d7f45d1cf-63c1f631befmr27471260a12.1.1761308277518;
        Fri, 24 Oct 2025 05:17:57 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:12f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3ebcd742sm4414983a12.15.2025.10.24.05.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 05:17:57 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Daniel Borkmann <daniel@iogearbox.net>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,  Alexei
 Starovoitov <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,
  Eduard Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,
  Yonghong Song <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,
  Hao Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Arthur Fabre
 <arthur@arthurfabre.com>,  netdev@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v2 01/15] net: Preserve metadata on
 pskb_expand_head
In-Reply-To: <20251023175119.62785270@kernel.org> (Jakub Kicinski's message of
	"Thu, 23 Oct 2025 17:51:19 -0700")
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
	<20251019-skb-meta-rx-path-v2-1-f9a58f3eb6d6@cloudflare.com>
	<20251023175119.62785270@kernel.org>
Date: Fri, 24 Oct 2025 14:17:56 +0200
Message-ID: <87ikg4v6h7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 23, 2025 at 05:51 PM -07, Jakub Kicinski wrote:
> On Sun, 19 Oct 2025 14:45:25 +0200 Jakub Sitnicki wrote:
>> pskb_expand_head() copies headroom, including skb metadata, into the newly
>> allocated head, but then clears the metadata. As a result, metadata is lost
>> when BPF helpers trigger an skb head reallocation.
>
> True, then again if someone is reallocating headroom they may very well
> push a header after, shifting metadata into an uninitialized part of
> the headroom. Not sure we can do much about that, but perhaps worth
> being more explicit in the commit msg?

This is where the skb_data_move() helper, proposed by the next patch,
comes in. We will try to move the metadata out of the way if possible,
and clear it if don't have enough headroom left. That approach relies on
all pskb_expand_head users adopting the helper, which is no simple task.

I can add guidance for pskb_expand_head users to the commit description,
or maybe better yet, add a note in pskb_expand_head docs.

