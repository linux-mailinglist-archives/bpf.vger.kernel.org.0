Return-Path: <bpf+bounces-74748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E53C6508B
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id F11D828FFB
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D16E2C178E;
	Mon, 17 Nov 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Loh+SqJY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD942BEC30
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395548; cv=none; b=m9HdDLLI9QV56KToBZ0NJRPX0txlkbPmiUYcXX4nMQRzfYsUhPr1WDvSK55oC2C6EzprBG6lVRA3V1KqPr/TGWJ61RgsyGA5LaI9pd7++OEXqSv0pt5q+PUmM3pKR1VHwngR/xl5aq3UoTag1XGu4gjE9dZLEXvhzfqMtbnC7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395548; c=relaxed/simple;
	bh=zR11PadUKffBVoAS2I53jVhWoEUv6Rds+RYWfmCWtD4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=GArd3GdUrnOFdFrHAUHB/nOTUBh+K0gbs8j06Gee4+ecfK+rCCTjAQiClpHVk9DHlkSLw1HDkaUcNAgG5LK8DsFnX7/gqLcmo3tqNoSKrSGKr/Y6ZVzDnYsKxHwpUf7dbDPku4fb1BGoCdJbZ22+WYpLjydsWWk9u6l2N9fXXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Loh+SqJY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso30406675e9.2
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 08:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763395545; x=1764000345; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=veP6ZsFPLmRwgmCdpo5pE77+0E1WbpqRaQfM3K7/5S0=;
        b=Loh+SqJYiVGQEAVFX0kxXdZpT4MKZ3u7QInsz1A2u/ZPjbwsFHAFD1x8ta4i/soq7D
         uEZgOgQm4DXKF64R3TE9ROsAQPdCkFJXKFdabHY0jYzVNyLjX4TD/W4bEnsZNxY5YWt7
         rTH6hufZsCMPPOxwMpeNW/UoG4VTYsh6cRfFwDps6hf4QZuWPx3MrAXB5zU+q6Cs9B4C
         jBfRtyCwuA607Se5to40ev1ec9AbrA9Xp05tIjDkj9TlMQgDkmJ35tZ4smi5G1UEanr2
         smiagnzpf6tw2mLcMp8uigGK1J2DEQJwoqdc8waNBalKJoMoR1SheZXw0an9dp+1Anhg
         6wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763395545; x=1764000345;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=veP6ZsFPLmRwgmCdpo5pE77+0E1WbpqRaQfM3K7/5S0=;
        b=TCdi55UYAch/dVHoEIIYY75NdwwgJN1tNxTOZ9zKZ1VUY/wS2pKGvi6AlVsCO0IDpd
         ISlaGdsXr7dKJkBB6ZQ/vvhxlPU+Qrk4qAMxzXQ5wIjMct7NSVYPMU1GyOvlMYI0cmdX
         LOsuWU95Vrsj7LVy7RvkR3uv8RnS8XaouNdvxDqcuj3vUFohFiHGd5CxHcbQFNGvxx5U
         +8AxnGZI7JqUiuSH5zXTG0US5gl+8LrRDoSgRK+6lxJ1H4PtFcnuXKjIG+VALy20k4hA
         G7ptUUrU1CCHr094GXY2CYQjm4ELNEJbVCZWZ/fRDXEIThT6q07dI4JxSukEGEuSU1cO
         HboQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN16QVZ86c01PRrVl3ImEELLWer6HqOFY0G/HzBSnxHwTUMwcdr5waVdCCg+VvUbD9jr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy5w7XZUADIYJwvHkCdtHJcpN3jGKNVm8BScMj0TESKdvszd8H
	+/l/1/ehH5HAbYMGcIIm5r2Tp/P9Z3K8T06LFEb7vQQeaUBH9SN1mOTm
X-Gm-Gg: ASbGnctyc97Ybs/xntFckWHeW69XQqXCf4+QG1dNoAuQuHczqvKx4wIdlFtMBDCrCh0
	3OA9Lm1O9jzyJFLnGia4XobW3OcS2zmH9lSnD26ACEvyIry5O6dn1HE/0F5fmelDXqhnmHfKE4y
	V2PWgiu2lUi1nFJ2IvhA2GkI4Y+SmOI8mc5rsXBkFdQiyp17dmNUoN8eANNGOLyxK6UMQUOGppy
	aXizDdWoW8m7p2cDoPZCkrCa8E6CCzGm8OZ+b9V1ZdAn5Nn6xIggONv8ceOZe0g4D/6GVU6/8Jt
	7Oj/XPBN39IiOccWeeSk0d9kShi+F1cnWA5s7Ucasr4Y6q/2zJfNLfO7xGl8Tf438Y39fO0q1Ig
	yJA/kubXuL5xqq3eo9swfHtTaLw0P/5MeykUPgTyrs78hSand/xZD7HP+yY4zUCuNzf5a3dNl9t
	rwfvArG6bxCzqpRPdvW5+5TLI0HgcNOdG8ig==
X-Google-Smtp-Source: AGHT+IELmBtYaKQJWSaqOyfivRd23QI/DFTaZg6tiH7/6qdQirofoDu9HP7b5w4rLfETnNrziPkg1g==
X-Received: by 2002:a7b:c014:0:b0:477:994b:dbb8 with SMTP id 5b1f17b1804b1-477994bddeemr52518145e9.11.1763395545080;
        Mon, 17 Nov 2025 08:05:45 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7408:290d:f7fc:41bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779cec0f2fsm51154305e9.10.2025.11.17.08.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:05:44 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
  <netdev@vger.kernel.org>,  Simon Horman <horms@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
  <bpf@vger.kernel.org>,  Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH net-next 2/3] tools: ynl: cli: Parse nested attributes
 in --list-attrs output
In-Reply-To: <20251116192845.1693119-3-gal@nvidia.com>
Date: Mon, 17 Nov 2025 15:57:21 +0000
Message-ID: <m2o6p0mz32.fsf@gmail.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
	<20251116192845.1693119-3-gal@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gal Pressman <gal@nvidia.com> writes:

> Enhance the --list-attrs option to recursively display nested attributes
> instead of just showing "nest" as the type.
> Nested attributes now show their attribute set name and expand to
> display their contents.
>
>   # ./cli.py --family ethtool --list-attrs rss-get
>   [..]
>   Do request attributes:
>     - header: nest -> header
>         - dev-index: u32
>         - dev-name: string
>         - flags: u32 (enum: header-flags)
>         - phy-index: u32
>     - context: u32
>   [..]
>
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

