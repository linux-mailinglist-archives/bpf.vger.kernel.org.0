Return-Path: <bpf+bounces-77050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0D9CCDD17
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 23:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17A2A3043F41
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222312F39A9;
	Thu, 18 Dec 2025 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7Cgaw7R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0350D2F6560
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766096658; cv=none; b=YYBHbqzTodAsCbyHjxBWdjDaCbzStPZMui0WcYqqSgFxUZTAUwPVfP0XKA7uR/wjfbmggkG7cnyVg2rF39mBIfLynemy9vIv0MA7/BO9xKjGL/F25m04PSzh0vb9Da4Gc0KRUabPdGrtYq1WyJ3zGliRhWLRdwGVL5fa3W8clBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766096658; c=relaxed/simple;
	bh=s8byqvg++DSjnZ72W5NS31GKbByIlTxHj0U3/GBwmtw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+E8kF+nRK28h8OuTrCvULRcTgEPGQocJugKbQkNSnXkp31rrwvh0sen47GNxV4j2+g7HWmgk8xX94GohMCsEbtMzI92N/kmvVwyxxjkXQGTci+NvniQp4em4V7/SULVQ6T51+sBChnY3dEraFcjvl1soyYnGTc+Qp6MZ/CWtKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7Cgaw7R; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bc0d7255434so715975a12.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 14:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766096656; x=1766701456; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s8byqvg++DSjnZ72W5NS31GKbByIlTxHj0U3/GBwmtw=;
        b=F7Cgaw7RMH39UAWNiijW+UiwMvwmUp2E5qcSh+7BDAEDu21jDnAhmipqxVpv6VzMjC
         LQyxEGSQW7gNtiGauXLy/NM2EbkDVLOIrZmOL3evREYQG5dAOtQ9OvrGZNOOd++15+F9
         W2IsUSUMiMGNCl3c+++KjkY3vS6CF1MnWaahznufa2meW8QH8fUglUTkKFHophIpqZl3
         uyXTDmm/GJnd4MwSNAPacLfdDsNKBwJ3NoykQYbbItcvVkmCAPIllW2PuBrUEnsxyNSG
         YdBv73jEZs+B6S2FHfCcsuR9j/fgp33+DhF1BB0baj3iQvliz37/X7LQ1/nYRr5st96h
         HVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766096656; x=1766701456;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8byqvg++DSjnZ72W5NS31GKbByIlTxHj0U3/GBwmtw=;
        b=T/28uLmn4kXPnepAREGPK4Vxp4N+fsRqSvRONDQoQQHIV2m0hFwQDjMWX4HW0usykV
         zZnviV/Wot3QLQkxI3R7sqWJPeI9UYPvA/EZ09H13cd/76MG0+1Fs4LFcZTt06WnngWe
         AFY1Fzg0ENAQbPYvzz7tr6Dv5fkFu/7RGqt2cSlZY52gjMrQHsXJWI6cGCS0aECbvVNn
         0CkMAxpW/sBrsqiF/30JfgT9Xuu9f7TkDTZDPq74GRQb/bPL+ZHRd6M3xYLWxIq/Vb/7
         pijfnl0YAfoPp+PXkTm7BNf0O4+3kNj77+ie2/YrMH4R9C18mqus/HwPiTnpRkwe9Ddu
         K1eA==
X-Forwarded-Encrypted: i=1; AJvYcCU65F2yi9wMvyyF/qEjrii4pLNo1VJ8ZoZQnbJYFtLfSSSDnO6kKjg5NDkqj9HM4R46sgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM5P9Fw0Kf5NCNaYkyYMoO3WRA/ry1CHUv0jQ707I5H94uYPv7
	e6US4W7AZwUl+43KQYjBdVitr8vBvP2K/khM7CdnI2mn3g7aQR3+lTwM
X-Gm-Gg: AY/fxX4ETCSHtSn37DraBKe9ELCSNM2gYWZUCzIQXuN8cU0Af3jI73Dr13iOESCK3hr
	NLrHd9K59o8LMP2jZNNGGRb7ZZeqMzJ+hHFJt7xVieGdOAUgevY49E1Eq+s07/PnPnt6HgiMgxr
	9DiCfzUL8vQinRtcDnxPI1Ym8Cv5XcyAvYWeovkfKiAtEAbwd8Zo7bIFKUoi8iwqM0A6yWlYJWl
	lBazIE07OHX7fX3kj7DcFgg5kV7589A43dJvm5Q1Pqg5hoemo4Q9m2o8zbu7zySNLytqm1u+m6z
	WdJGEgd9jvf7lLjes/uH4aekUd6ugrdikgJ9oqSivJkSX+Dh3V4JrJqP1NKuEEExqYceOCulGVb
	hlNpHsqcRes+PIStoU45fvKJHFCnLTCl8RJ3419MFE5MdJcerTIFPfRrO3LoN/9qntTzT6GF4sR
	Bs27WPdu1gLQFpPdgieUhNkNM5DdyN0DLjzo14
X-Google-Smtp-Source: AGHT+IHuOhj+bh8y3BF70HdAofxbzkWx9krtu1hUsf4+gKJjwh5r7bJQM39ds2rVy1LB16bv23N/LA==
X-Received: by 2002:a05:693c:415b:20b0:2ae:55f2:ad57 with SMTP id 5a478bee46e88-2b05ec97ce7mr783016eec.29.1766096656143;
        Thu, 18 Dec 2025 14:24:16 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4779:aa2b:e8ff:52c4? ([2620:10d:c090:500::5:3eff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fffac8asm1719849eec.6.2025.12.18.14.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:24:15 -0800 (PST)
Message-ID: <6e725ff212d7ac80d671e86242a761962cbbcaf2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v10 08/13] bpf: Skip anonymous types in type
 lookup for performance
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Thu, 18 Dec 2025 14:24:14 -0800
In-Reply-To: <20251218113051.455293-9-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
	 <20251218113051.455293-9-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-18 at 19:30 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> Currently, vmlinux and kernel module BTFs are unconditionally
> sorted during the build phase, with named types placed at the
> end. Thus, anonymous types should be skipped when starting the
> search. In my vmlinux BTF, the number of anonymous types is
> 61,747, which means the loop count can be reduced by 61,747.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

