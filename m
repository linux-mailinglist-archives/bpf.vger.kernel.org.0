Return-Path: <bpf+bounces-62144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1A9AF5E0A
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 18:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29124A2607
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1B52E0401;
	Wed,  2 Jul 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyYj9RBM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D7265CCF;
	Wed,  2 Jul 2025 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472348; cv=none; b=QXJJhHAhdcfs36YnDrE320mYgjW4bnkMn1QzHCwX7akntauyG8sSOzNwrtrDeRUo9k3IJqVXLpBIZXzE+MjrbE+oncksvg5uCczLK7H823aOw803LEh33Boyv7256mIDjyZ+HrOxJnzupFvbuQFanGbmIb+xWrMj2DOl1JiNLtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472348; c=relaxed/simple;
	bh=XHSaZUqWFpPf32cofuoMkUOCMLvBHui8u1a32CHiVHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMDbkjk+EU8EmMH1lhePlauvsCKwh+eXuxO0dlEfH9oyLCayUzJzBOtWUM/6k/aK89+h3hpQ/JFIrIXuSYtukeC2SexS+ZagDKvNaqbSD3zJ9B9KzMg3dxFeFrJOT3D7+twoDC5iRAnsnH03j1d1ip1VJdrsBleRcpBs2t9lskg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyYj9RBM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b321bd36a41so4136350a12.2;
        Wed, 02 Jul 2025 09:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751472346; x=1752077146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypLI1VXmvZ1gRCtrJ2LYYmyjsx3eV6bzTaZRpkQ9E/0=;
        b=jyYj9RBMQh5S/mBwm4InoajQGDPbYb5Gpp6Ix9aySejuqZVdnlQyP3rWlCoy/dAhkv
         VeDFoF/SiXPVdSegxbmop04s7tJpNwnCH1c2wd2iUCxd1qHyBobBYLDCL9a0Ej6zd+aV
         JfisPPYDM9iDXciw5Q1Op4E9Vsr8ZsAvEooayer85OuQN1ZmuuviRlelUzI8Q1Eaiweh
         LTH9Ycf5+hykBq3SJlSFg03lQFHqiJAZ/orqaNIt8/4RPh60XAibtgV/v6eKQyeo18ke
         3GbFJs6S/810mKnPimZdfQJ5UOTHP/o8UKTznjw0TKqlz+iE5Ps5hz2oSPrqrWfRCnkZ
         yfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751472346; x=1752077146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypLI1VXmvZ1gRCtrJ2LYYmyjsx3eV6bzTaZRpkQ9E/0=;
        b=IXQV3ZW+BPyn6J92EHpqeVgo3jgJWsCCjNF0Hyp/0YheTFw6iE/UPS/ZRRUCh6+K6x
         HzUgQWoDhtpPdOtc5pzxQauSnu29haYdDo9oCg0iWxAXnGrmbeQnKNnfgQ1xVhlnW7jO
         wMhmFw0OkhJBJFghO4ipzNPnpWO+gbtEWBp+Y6KMRSKwMVO0pZlwNoIzCTVXbWG/rw3r
         Yaa+iHuQwov/WEvtyx5c+DkPjxQKqIu1SwlJsAP7w8g6Iv1ykTdZRvtzkrVhk2gbebDI
         vXTQgt07aJuqAJ5QpfpBktAaxLbt4QO2ABTVm1cHMtCEJ1yjgqq3UqBRMtW/MHGY02FH
         0nag==
X-Forwarded-Encrypted: i=1; AJvYcCU8ja0m40Bsm9oLk/PLvLkFxWpDG7Ei07CJ/qU8x3gnILzM0CxcxgmvPr1kyFBF+9EjkXg99iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHD0oX2uzT0w7GUtsCw9zXz9sPAOqwtri7W2jvm6L/nyyJPitw
	HXCOA+UCg3t6U5rV7bH/r03+k9IgdMQAktzUi4eDwzurR8S4MpbUxqE=
X-Gm-Gg: ASbGncsbno6zP+RF43Dc23IKB4xd0JWD9AvL4K3R+rE0ShB2BzC9Xy14YUAYnoI7Zyc
	9Sey90X/qSCKDsDVi5a7xjDb6tqys9GAZZQ+aG+NLFKNC9Se+kahMCltzjqkp2nj4MQn9ZO9u5i
	fTXlgqAGEexpoUmC5YQcqMTm24ph7+0SYJUo4jxGJbHXRSTPXAdPUlTbVnqRWbjwBF+CS9h6Gd7
	IXqLx/S0Teu53rGRbn31moiYX4Med3YnYvYBw0YMEh2H1ZuLwyePqq+418GGtjKkwPd6+YPwiGi
	i26thf7VrEEU3JXrrXC82uH3TBQCgv5cVOizUxxMRDb3A1KAiwXQqZyA/1ZiHuMfEWAeretrK/w
	hgbqXfPbgaKrJNfWX7KlVgO0=
X-Google-Smtp-Source: AGHT+IEJfovoW+dOOcSbSLwvCJk918wOrDCRfRL2iAOfFFVqg9aZ7yBdTlMf/LXTJwdvBVghW8guKg==
X-Received: by 2002:a17:90b:288a:b0:311:a561:86f3 with SMTP id 98e67ed59e1d1-31a90b178aemr4214789a91.6.1751472346300;
        Wed, 02 Jul 2025 09:05:46 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31a9cc6dd44sm156756a91.21.2025.07.02.09.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:05:45 -0700 (PDT)
Date: Wed, 2 Jul 2025 09:05:44 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <borkmann@iogearbox.net>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
	kernel-team@cloudflare.com, arthur@arthurfabre.com,
	jakub@cloudflare.com
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
Message-ID: <aGVY2MQ18BWOisWa@mini-arch>
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <175146824674.1421237.18351246421763677468.stgit@firesoul>

On 07/02, Jesper Dangaard Brouer wrote:
> This patch series introduces a mechanism for an XDP program to store RX
> metadata hints - specifically rx_hash, rx_vlan_tag, and rx_timestamp -
> into the xdp_frame. These stored hints are then used to populate the
> corresponding fields in the SKB that is created from the xdp_frame
> following an XDP_REDIRECT.
> 
> The chosen RX metadata hints intentionally map to the existing NIC
> hardware metadata that can be read via kfuncs [1]. While this design
> allows a BPF program to read and propagate existing hardware hints, our
> primary motivation is to enable setting custom values. This is important
> for use cases where the hardware-provided information is insufficient or
> needs to be calculated based on packet contents unavailable to the
> hardware.
> 
> The primary motivation for this feature is to enable scalable load
> balancing of encapsulated tunnel traffic at the XDP layer. When tunnelled
> packets (e.g., IPsec, GRE) are redirected via cpumap or to a veth device,
> the networking stack later calculates a software hash based on the outer
> headers. For a single tunnel, these outer headers are often identical,
> causing all packets to be assigned the same hash. This collapses all
> traffic onto a single RX queue, creating a performance bottleneck and
> defeating receive-side scaling (RSS).
> 
> Our immediate use case involves load balancing IPsec traffic. For such
> tunnelled traffic, any hardware-provided RX hash is calculated on the
> outer headers and is therefore incorrect for distributing inner flows.
> There is no reason to read the existing value, as it must be recalculated.
> In our XDP program, we perform a partial decryption to access the inner
> headers and calculate a new load-balancing hash, which provides better
> flow distribution. However, without this patch set, there is no way to
> persist this new hash for the network stack to use post-redirect.
> 
> This series solves the problem by introducing new BPF kfuncs that allow an
> XDP program to write e.g. the hash value into the xdp_frame. The
> __xdp_build_skb_from_frame() function is modified to use this stored value
> to set skb->hash on the newly created SKB. As a result, the veth driver's
> queue selection logic uses the BPF-supplied hash, achieving proper
> traffic distribution across multiple CPU cores. This also ensures that
> consumers, like the GRO engine, can operate effectively.
> 
> We considered XDP traits as an alternative to adding static members to
> struct xdp_frame. Given the immediate need for this functionality and the
> current development status of traits, we believe this approach is a
> pragmatic solution. We are open to migrating to a traits-based
> implementation if and when they become a generally accepted mechanism for
> such extensions.
> 
> [1] https://docs.kernel.org/networking/xdp-rx-metadata.html
> ---
> V1: https://lore.kernel.org/all/174897271826.1677018.9096866882347745168.stgit@firesoul/

No change log?

Btw, any feedback on the following from v1?
- https://lore.kernel.org/netdev/aFHUd98juIU4Rr9J@mini-arch/
- https://lore.kernel.org/netdev/20250616145523.63bd2577@kernel.org/

