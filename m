Return-Path: <bpf+bounces-77397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8CECDB34D
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 04:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4175C3031CED
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 03:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA69219E8C;
	Wed, 24 Dec 2025 03:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9Hi+/FA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2434A55
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 03:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766545318; cv=none; b=noRTBuYucJz2OBH/BIZdbaA/eBwOQOFlboQxrTiryAsIIbcD/QQdbUcqXb49jJhNiQBIQAuFbENgmrrzvyxVVWSzx6IzSD7pBYq0htlqJ2UIK4qGDsO8gQ5KxitM9x8IMYn7JMjspyK99Luxd4mrZ51gRgMQRvxQkrLZWP/KqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766545318; c=relaxed/simple;
	bh=vCfEpD5so7+LP1vUfgHognLhOxYtZgdClO2gE1jIbZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rseDJKPwL8Lof0k+pK5CYjSze5Lh3EWoX9KjJGxP/vcbTBpehbzaKcka/W0omjw73Un3lTRAaG8lWv5B8doCBj/V+/829LCELw6Njy3Go+888Axm3I/iNBGkIN9LLRk/qHNHxLbe5Yk7z9mGnPtsyQdjMAaGvxMEncA6tA5BYZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9Hi+/FA; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-640e065991dso4916939d50.3
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 19:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766545316; x=1767150116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCfEpD5so7+LP1vUfgHognLhOxYtZgdClO2gE1jIbZY=;
        b=g9Hi+/FAb7Odq++WdIDe0Q/G8AQMiFmv5JaLYBedr5az1VybkMeuqSdKaAjy7oCrGo
         BE9eIapJFmyQhZIkFbRMV7OnGoUp0rud/56MMO8HOBLTZPrNeToMFTqt80F55C+NzIzN
         1zLF+NrdIKEaX36MUoktckIuUUapu95nLO1Mbmudrksq83ax17NRfMZKnfGIWrTT+P9e
         0bLEqpLBlttRxa1QC/VqzhnZsJ1GlKN0SmC6r0tMre5QY+cQZuMuKcWindVJoE6zKeHU
         GAGlxcSt4oL+DvgW9tgVnCwxFF/yvOlafasns0F2Hsg6VMv7gYbWiYQQAGRuZhVETb3s
         2kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766545316; x=1767150116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vCfEpD5so7+LP1vUfgHognLhOxYtZgdClO2gE1jIbZY=;
        b=KFOhOCupwVMvceGlgpiNw7ndNMgXyhaULNrsE5mDONJXSKFG87pjwxPGXKVMhj3Cds
         bAxRsy88e/oxbh8FkGpEoT8cbCa2AfMQvBES924Q9oaU5iRzlWX/G63Fqw0Ue9bR9BHm
         k6QZhqdzqnkEGcn0mA841LKr294UwZnMh2RlNWyKwCpQ5HWba9PkZjRiz7Xfs/9pUn07
         +KNxSuuX28fvLC09VK6S7k/5tY1MhS3GVIbyQw6K4cRnga/ePJisr445iz9Jd2kt+evG
         XqmZ/djOFijygvWk1C42O0XrnHcm2yhvE/zz74MYXm+6fC7+ufcKRE99bsprHiYjtV+U
         dckQ==
X-Gm-Message-State: AOJu0Yxd1jEMKsE9el3ZFN9Kze9q2S17xWoQZoS0y0DxOPMO4BAmyYht
	f4gx+ebOv9jpJxASvYmmMEAOpHsZp4IQLM1j2Krh3CgQ9f5yRPkbLRlevvaLf5Z05AxjuSCmqPT
	4yeySeXx8UxsKNdNCE7YwgwQ9N0G3Q5c=
X-Gm-Gg: AY/fxX6k1UMFl/fHr5Zi3X8eAFfhWdAv1Qpfk7uFyAN8szPjg7+BdsLOfyMHVbH/NaH
	w4s9nN8PWeIeYOIUc6mbqp4Br7v7YkOQpPhfNLL6OM5hnmoBHw1XBIJon7ouGIPBgGK4FqgZL1D
	VLWzSlKg5TWyTw2jukfmwQjUOr5edAnA66lX2IHzKxK/ZEOVq0GdTTaoqvkWyxXwDNi3ML19SGl
	u/xYkwYCWbAEjpLfzfau+QmJgv0TCscl6d48g/lTQM2/7hjyYrg7X7prIi4YjVFI+E8TOGj
X-Google-Smtp-Source: AGHT+IFbwWNUxSaChd2OuHftBW+AAdLfRyTXjDRPDHTwTeLXfg251DqBzw5mdGlkv0MXjfSaYz7092MOEjJvUXs4sSA=
X-Received: by 2002:a05:690e:206:b0:63d:bfad:6c7 with SMTP id
 956f58d0204a3-6466a8aba70mr9964995d50.58.1766545315638; Tue, 23 Dec 2025
 19:01:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
In-Reply-To: <20251223044156.208250-1-roman.gushchin@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 24 Dec 2025 11:01:18 +0800
X-Gm-Features: AQt7F2pR7dGxQ6UGyYEhLIEnnYYQxm2KwapPQ3bSkmjzaZNl2u4VYPoOrRhcJS0
Message-ID: <CALOAHbAQQ59mSmh8aO47jnDjOu9S+FESxKw+YUp9g2Q2qvqedA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/6] mm: bpf kfuncs to access memcg data
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	JP Kobryn <inwardvessel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 12:43=E2=80=AFPM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Introduce kfuncs to simplify the access to the memcg data.
> These kfuncs can be used to accelerate monitoring use cases and
> for implementing custom OOM policies once BPF OOM is landed.
>
> This patchset was separated out from the BPF OOM patchset to simplify
> the logistics and accelerate the landing of the part which is useful
> by itself. No functional changes since BPF OOM v2.

Hello Roman,

Thanks for driving the BPF-MM upstreaming work=E2=80=94this is great progre=
ss.

Would it be possible to upstream the bpf_st_ops and cgroups patch as a
standalone series as well? [0]

While the upstreaming of BPF-THP is currently stalled, we are actively
experimenting with more BPF-MM related features=E2=80=94like BPF-based NUMA
balancing=E2=80=94on our production servers. This work is a great fit for
per-cgroup tuning via BPF, and having your bpf_st_ops and cgroups
changes upstream would be very helpful for these efforts.

[0] https://lore.kernel.org/bpf/CAADnVQJGiH_yF=3DAoFSRy4zh20uneJgBfqGshubLM=
6aVq069Fhg@mail.gmail.com/

--=20
Regards
Yafang

