Return-Path: <bpf+bounces-47754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF789FFEB2
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8303C1883A0E
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 18:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FC71B4122;
	Thu,  2 Jan 2025 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="05VvvzlB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FD36FB0
	for <bpf@vger.kernel.org>; Thu,  2 Jan 2025 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735843416; cv=none; b=U4KKUhMHBBcVHbJIVl15e1GbM8rPXiGkp0JULTTsRRi7EM2XLCKY7kDp/wBFnwnQ6/6oGJuxoGdyg9HbPlSyRQhsEDhaQbjn6IramR02zsq98ZN1WGUTFF/BYa2lxO3VVUBnIYYa7IUWg7QdYt8fRNg5LAad0Tqgsp5WKbcRXFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735843416; c=relaxed/simple;
	bh=eiml2yjpmOszRDlSCn6XV9ArVvimnR2tz8b95UUvfR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAry/OObeM8Pw9SpmOrpCOAXK3Dn1x1xT6BHYvxGhjxJD5qT6Mpibz8FXrJ/emE5XCnlBqdw7Rqia684BnqwlgFgiF4nxvowQ/s18DtO+TxqAIGuE2bcjzQZojp6mJujHe4jxG+ngo5WkAC9aUzMOe5tiGtqqClIV0VKJ9lGbEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=05VvvzlB; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d89a727a19so110962406d6.0
        for <bpf@vger.kernel.org>; Thu, 02 Jan 2025 10:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735843413; x=1736448213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eiml2yjpmOszRDlSCn6XV9ArVvimnR2tz8b95UUvfR8=;
        b=05VvvzlBImTVfWoF+IKInLEEpnshPPdwh8HxISJVnMz5jnOEdW+MgcPXiT7Fwqg+Ct
         dE48JYCjKkhtGWBvZudc+yAuUP3z+MuiYePm/N1nIkf5QLBmaQwmD9Emx878y5QITGtn
         XgSqXGsheeNLvty627Cc4Chz0nAups9jbzcgZAOvdL0WDSIhOy97pJ785EO7IA0onxP6
         8kWaLnpTaZjb5cBjbNufhkCBJp4m8DTdXW1GhYB9i14D/nErYthIw6shB0shxR8s/dPO
         fy2WYD7vYSpgtbIqO7v3eQi5inA39UGwL+YP26sYuFvgqQrrA5VeOkYIGSB3bpTmEPQH
         Av6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735843413; x=1736448213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiml2yjpmOszRDlSCn6XV9ArVvimnR2tz8b95UUvfR8=;
        b=gRZn1M5OZmS+uu3ovSKEehKEV4BmTbtxGXvJniKVutXdVbPHqR5ZIZE7HBgn7T1ktW
         uBc1MxK9OrsJD7YxoyL2Owb0W+c4BCQ0z74EON1OU+IugYe2AE9VxIOHScfThuA8717D
         BBZknHUfGFTbRt4ftcl+v8+4vDqlZTyaznl5iNp/RwFQz5qf48SHzcSUPctbBfHbv2D8
         omAdAf0eUYDnk6h3bXW1tlvMrh4BH7rDuOPaOIclf30n+pYqN46Kt5Pyxffnh48V0Cbj
         Ue/K94Ys92IvPHqS4v0uf2zfletGvQoCsAPcelAJeYLPuSYdXF1X7e2Z6zUrsDUYyb8S
         t08g==
X-Forwarded-Encrypted: i=1; AJvYcCWQH6Vu/M52FUy1nAhTOMPI20hHM+npUCqavSQK5+jWQazkqjYhw3g36gpSkeONJKxRoMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKljLi1Bly6+9GreACN069HoYHpIHkENpMSguG84jxt0lRR4sf
	i7HD4XUtKoLkpTSAAg4n89VS3Zx09zsedFvxXKD6rnUND6NC1jiwIkhfHJ92Oe11RWh26qiLQ6r
	xRScTS/WSttozFM5bF0HfTpem1fMZkdDvp0HY
X-Gm-Gg: ASbGnct7UpwPf1lfIGosgugiBj5hj2e/LC6k5ZecrszIjv3h2u63G3L+vd9jdt+Iyo9
	66IFz2+x46EVk0FNUo3EoxGnRXlCPiwEOWznE
X-Google-Smtp-Source: AGHT+IF2tZXZGzK4SR62kPfJyDlYZjAffFvMlSMw7+NG+gQt+geLbrrGjOcGHqDzqV0Ly6l7e8fT7ZNqEBaPAWkEaVw=
X-Received: by 2002:a05:6214:5bc7:b0:6d8:8a0b:db25 with SMTP id
 6a1803df08f44-6dd23618b5bmr751231406d6.21.1735843413422; Thu, 02 Jan 2025
 10:43:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218133415.3759501-1-pkaligineedi@google.com>
 <20241218133415.3759501-3-pkaligineedi@google.com> <3ad7bdd2-80d2-4d73-b86f-4c0aeeee5bf1@intel.com>
In-Reply-To: <3ad7bdd2-80d2-4d73-b86f-4c0aeeee5bf1@intel.com>
From: Joshua Washington <joshwash@google.com>
Date: Thu, 2 Jan 2025 10:43:21 -0800
X-Gm-Features: AbW1kvYJhRQu9jWJ1-H0lGB_jEU0IWP-wY0jRAO_aZNMsIq7HMjjdk9-3POyjeg
Message-ID: <CALuQH+W3TK4Kvgbf1d+eFjR8W45_84M7T=aD0BeAdbGQdm5koQ@mail.gmail.com>
Subject: Re: [PATCH net 2/5] gve: guard XDP xmit NDO on existence of xdp queues
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, 
	Willem de Bruijn <willemb@google.com>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	open list <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Wouldn't synchronize_rcu() be enough, have you checked?

I based usage of synchronize_net() instead of synchronize_rcu() based on other
drivers deciding to use it due to synchronize_rcu_expedited() when holding
rtnl_lock() being more performant.

ICE: https://lore.kernel.org/all/20240529112337.3639084-4-maciej.fijalkowski@intel.com/
Mellanox: https://lore.kernel.org/netdev/20210212025641.323844-8-saeed@kernel.org/

> You need to use xdp_features_{set,clear}_redirect_target() when you
install/remove XDP prog to notify the kernel that ndo_start_xmit is now
available / not available anymore.

Thank you for the suggestion. Given that the fix has gone in, I was planning
to make this change as part of a future net-next release with other XDP changes.
Would it make sense to make those changes there, given that the patches as
they went up, while not completely correct, should at least cover the
vulnerability?

Thanks,
Josh

