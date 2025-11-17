Return-Path: <bpf+bounces-74749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B47BFC65094
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 6CBA028FA2
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8992C21F6;
	Mon, 17 Nov 2025 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ7jAYav"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592E62C21DB
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395551; cv=none; b=Ys+vgxdh0W5/OUs76+RdayRCPVFixepm4soPxIIjoVDQuDexiNArQPQqrWmb5Q6vlLHj8kvnpmiXdHNOm1LsvCxpi/uyM+fU3c/b1/iXDyvcbDY7z2RoHx4Wh6kbqalupUIq65nwFyfjsQaKwHYuxbfsAPLRmJ9CrhLy2aY2AC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395551; c=relaxed/simple;
	bh=rtpjIiIlwv8Z4omsOMF5KY5wtcbo4rQbTFrRHKz+CEQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=J+cCIzG1KSFF4gJ497rIfflQ3ZzT6tdQNAmnJ54C/77mg6yMZZr5mxGloQP7ubzqDv26Omb3Geg4qM5pR1rEFxHtsKbI16sXzNJCQjOWXmlBzauJrT3zWI3tPgEVO/rjMpZFWjlA9pLKaevroEjWZvBuA0yPn102LThHU3vXSeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJ7jAYav; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b566859ecso3468630f8f.2
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 08:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763395548; x=1764000348; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GIQH9Z7cUezUjldbG+MilUGr+vhpfO0JfTL7ifs5sCI=;
        b=hJ7jAYavo3C1/TG6ll6NAicftlF3LVdy+kf3hFlnuIZFykMFnD5AM2XPKaUTuLGUEF
         nuvKcWeBmGq5xutW+Vm25Epnk/yhaDqxBPrfL7ehUtNatWMtIN91zemgoQ4UQTFzDsqD
         o7qoxG7KJNgC3jWnu7Ea+8gpLjdii3kwsdHvR1WBk66qavmzz+rRv1qvPU+DiIKEP2MC
         rnfvbV4+5ab0eX85omsEJjNvlG4eSwaDUmLSAEN6B/ZxGUMxv0MI11lxbFHJ14Rsn3k+
         nqxKWlVFgrnhGmBztfg8S12+NoZD/+at5dUjz4/46FucwuJGocgVlLSovn+Erl9m6QRN
         b9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763395548; x=1764000348;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GIQH9Z7cUezUjldbG+MilUGr+vhpfO0JfTL7ifs5sCI=;
        b=GQ7lOqzUfaZ3fBBqU2yzTipky25zmkcqRWgcytLQ6AhCpJ1szymJ9i+AVnz2+as8zD
         dvZW8VzJkYHOkzm7KCAC9Irw48vzVeTePhjXenTAXcAAlUAq1RuZUeUGJoafxGpKuX4A
         WaVM8xyTnPtmrHRjfUmPIwfVihUF0jE/kwqXJuu0QFrVVt+R0pywM3mfRV5XDwDwZvmy
         zW8rrllD3Wz/NKNfKZmblZTZIn3xmgO7fpQdf92s55D5gwmdoNO0NwB1hV4UbvDSUsuD
         oFqLEfb+8uSOjqNLma40icmaTCADLHpEw+s7WM3EcXLjx7KpTPxLyGLRvmm/Gml2foeo
         Xv/w==
X-Forwarded-Encrypted: i=1; AJvYcCW5yMh9UlzlkEPwKCCAY+qWD42V/KarLMyXep+qKoeh6xy8jUeInE46QUTBzNxgasUSZ7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE8vSJjsJQ4oLIE0QZpjJiJlb+AZELwpgYhqvsWH5pt4x68h44
	aY95ywBNvxKu8ylT+55vagvWbfuJPAf9fHC6jcYuc13dASzI7IdRtMEz
X-Gm-Gg: ASbGnctEjos039EganHwsAJ3/NCU+S7+Zllu2L/YVNdMn/ohrQ8Ek43h8Acg7o7nI6x
	oY63xFasbbQb2ywPslMHMqyCq7QEsx578NM3CC/ur33qqLbjxCf1R2F+TqICZDDhw9rWu/ItVDZ
	G+1gy+RuN7uckJ7/mG0HhqBv4J68/2e6WcZ6neq6p2yotCOreMjVF2rjHnCO06E9ncuLlDjtYjU
	7pMEsZcDGteW9VHOql/sGlfHzoOBWdZq+2rjiS8PBFP9AbOVwrbSRWT56k/DX/5sl/f0z0zx5JZ
	Ae3UgtNAZjbfrXdUTtIGJmYQ5U0lCI5imgRGaNC/m/s/ihQ26eSX6ekB5EYeCzBAQLzWoWozTR7
	Rwt5mSaB9a942hYmbTQmkoiEu5uMl8qNX+tLqf0wq3V8DShicRmz57+64VM5YaPV0GmsgYtt5RQ
	ee+2TzYZIY2Xtl4GTJZD7MinXprjO4dJl+fA==
X-Google-Smtp-Source: AGHT+IFJtFrkxaLk28xLtAautoQrmDYpq9UtvQj5B3teNEO1FH5SHr/O+P9hTImJsKXpGip44YXjmg==
X-Received: by 2002:a05:6000:25c8:b0:429:c851:69bc with SMTP id ffacd0b85a97d-42b59342f3fmr10432513f8f.8.1763395547294;
        Mon, 17 Nov 2025 08:05:47 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7408:290d:f7fc:41bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae2dsm27430854f8f.5.2025.11.17.08.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:05:46 -0800 (PST)
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
Subject: Re: [PATCH net-next 3/3] tools: ynl: cli: Display enum values in
 --list-attrs output
In-Reply-To: <20251116192845.1693119-4-gal@nvidia.com>
Date: Mon, 17 Nov 2025 16:05:22 +0000
Message-ID: <m2jyzomypp.fsf@gmail.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
	<20251116192845.1693119-4-gal@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gal Pressman <gal@nvidia.com> writes:

> When listing attributes with --list-attrs, display the actual enum
> values for attributes that reference an enum type.
>
>   # ./cli.py --family netdev --list-attrs dev-get
>   [..]
>     - xdp-features: u64 (enum: xdp-act)
>       Values: basic, redirect, ndo-xmit, xsk-zerocopy, hw-offload, rx-sg, ndo-xmit-sg
>       Bitmask of enabled xdp-features.
>   [..]
>
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  tools/net/ynl/pyynl/cli.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
> index 3389e552ec4e..d305add514cd 100755
> --- a/tools/net/ynl/pyynl/cli.py
> +++ b/tools/net/ynl/pyynl/cli.py
> @@ -139,7 +139,12 @@ def main():
>                  attr = attr_set.attrs[attr_name]
>                  attr_info = f'{prefix}- {attr_name}: {attr.type}'
>                  if 'enum' in attr.yaml:
> -                    attr_info += f" (enum: {attr.yaml['enum']})"
> +                    enum_name = attr.yaml['enum']
> +                    attr_info += f" (enum: {enum_name})"

Would be good to say enum | flags so that people know what semantics are valid.

> +                    # Print enum values if available
> +                    if enum_name in ynl.consts:
> +                        enum_values = list(ynl.consts[enum_name].entries.keys())
> +                        attr_info += f"\n{prefix}  Values: {', '.join(enum_values)}"

This produces quite noisy output for e.g.

./tools/net/ynl/pyynl/cli.py --family ethtool --list-attrs rss-get

Not sure what to suggest to improve readability but maybe it doesn't
need 'Values:' or commas, or perhaps only output each enum once?

>  
>                  # Show nested attributes reference and recursively display them
>                  nested_set_name = None

