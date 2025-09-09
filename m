Return-Path: <bpf+bounces-67827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D77FB49E75
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 03:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352277ACB76
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 01:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0050C22154B;
	Tue,  9 Sep 2025 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2cA1Iwt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA5F9C1
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379707; cv=none; b=gAR/KfwU0JsAYvdzqJ89ec2EnQicjLAg1Kcim1K97tzkxwiM3KQYaXHWiSl9MpZwCV82IToFlpXl7sXU9ZURZQOgv5H7QiCp2/ClwMDzRhnT1yBeMEG50s4L/OboW2g42U6V0ftjB1vokWTqIJ/VHLCghJ1L8deLiJZAPF7U68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379707; c=relaxed/simple;
	bh=D8q4oz+5nQ+UM/w4vLFgmI8FUHgj0o4Jl+WMAS3scsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EULJdi/C0mETwFK/vQm95/x6JkV6/XfNlnJhNMpdl4RA43rDAZIzpgAOlt7ROuTF6EjgJ4n6CU5O7OppXyCsBayes9BBW9G4g4ijB6cruQ1bL4L6f/QEAB0x7uouhtvyTbQz5dgjXQxIdeyXhVklGJ2Nu2DnhNupp29f78hxL2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U2cA1Iwt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24b1622788dso34652505ad.2
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 18:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757379705; x=1757984505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8q4oz+5nQ+UM/w4vLFgmI8FUHgj0o4Jl+WMAS3scsA=;
        b=U2cA1Iwt+7QWVVP6lkooMkFChrTRKqwBLENAXXCFpdVdF+HPz+BidLqv9BuPSkuBB7
         8xq/dx5PudU+CO8AQIX5et7mEK1JuH6TdoOpM6WwqvoRARYmnGgQPczDD4JVYZ72+BxP
         DwUjB/Y9mnJCgYMS4KShI0RJn9nEnEgmwcW8kixHfn65n5M9w1RWKXCmjY9TTeHAGjC2
         Wsytud8gxv23mNow+wggSCxqbOSg3TwJV3SSPOX2GxGtai+jdKPa+o89m3buUYChj4bK
         Toxne8hYW7MADPThAOOuCAMdVtkqf/JDDcQwgCC+18ejrLO7jT8BNTtNC52sCdgL9A9M
         197w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757379705; x=1757984505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8q4oz+5nQ+UM/w4vLFgmI8FUHgj0o4Jl+WMAS3scsA=;
        b=ash0cJOWEVm2Z/7SV6Wr+lRE5PfqV0kDj+OT4YoCGk5fQym38ES4XaiEBv1blJA7GT
         yXo6W4w+PWQ9EJeyDkf5Fg8g0XCN8BnLckGeott3mLamOXsJ1oxL6h72FwchfnpyFxsb
         a8OLvWsu5E5cJnyEezjMxFIopEvUG3vpOHm+AWiyz0Ms5AmUwMlbtf30nv6F177e8GNA
         XR3vsTSzmvPyzgk7bmfMJMMRyjzfE6113wniZyt3ddtJknWGlcN8G8oRYb9+ek0qZU5N
         jpishD+FVm3/eb82oObQX98qxr0vQISAg+HMkdf+pex/N8Xwquc8XcJBGTpZP4DE6+YN
         yYQw==
X-Forwarded-Encrypted: i=1; AJvYcCUfB616DP1OazM+/yBrs0Le0W+XPItSwYsU2sd4LGuZWg/skrhmXHcmK5V7OrstRz6mjIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0q4GIeOT530WNx7uDjwiGpRVTVZ1myUOc15wI9jRk68OZAZjX
	p8Lq/NDps+G+8QTOJBXuTwuXm9FFgqvpei5OZm2AmLdsVPoy5K8qTsKbl8FWf8Xl9oc+0Rq4JDs
	CFnjmne3z98BsygzDyHHkUDLstszUYhIwgOm5OmYe
X-Gm-Gg: ASbGncsfas+1SdtyuLsZbVo0qWL7Vk/UYR/EsCgJsNM6ZEQzn2vYEwrA0Okw7T0gZHr
	J60cyhWbX1xK7L5hIx4SXb3sTOcSzQSoT6qN61n9aBw9hk1VoEok3YTd2i1PB6NgXEobbexHu7z
	/k0mAyNRI7d9zvQXi9VmbboKB85G1H+QWZtxbid8wutgxf6u9vz5Pxvp6O1RQwI1ziQTR2IE4Mx
	srElUJFDdoWVkX2iItZ6nkf0xpBZTq9kQhMeVIM
X-Google-Smtp-Source: AGHT+IGbfF85Gb8yUX1S5kLrlaqHX4+uOflDbv+3FPsdm9s3A4fbVGZGXb/apYzXp9uLCO3LRWcHy0W8tfE+64q709c=
X-Received: by 2002:a17:903:ac5:b0:240:6aad:1c43 with SMTP id
 d9443c01a7336-25172578d86mr126852905ad.48.1757379705302; Mon, 08 Sep 2025
 18:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908223750.3375376-1-kuniyu@google.com> <hlxtpscuxjjzgsiom4yh6r7zj4vpiuibqod7mkvceqzabhqeba@zsybr6aadn3c>
 <CAAVpQUC1tm+rYE07_5ur+x8eh0x7RZ2sR1PGHG9oRhdeAGBdrQ@mail.gmail.com> <r2lh33nhc5pyx7crfahdeijd5vdq74abcmrbqkls2zwnih76fk@opua7takczmc>
In-Reply-To: <r2lh33nhc5pyx7crfahdeijd5vdq74abcmrbqkls2zwnih76fk@opua7takczmc>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 8 Sep 2025 18:01:34 -0700
X-Gm-Features: Ac12FXzmOHLKUGla1DBqQy8MItu9iGPqcKsPVwmymYI-Zh_kp_tuOXZOHFq_XaE
Message-ID: <CAAVpQUDBF8_GEuhrQBHaTkAAFX0C=zwnjifmyMnRkMDAyWDdbg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next/net 0/5] bpf: Allow decoupling memcg from sk->sk_prot->memory_allocated.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 6:00=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Mon, Sep 08, 2025 at 05:55:37PM -0700, Kuniyuki Iwashima wrote:
> > Maybe _EXCLUSIVE would be a bit clearer ?
> >
> > net.core.memcg_exclusive (sysctl)
> > SK_BPF_MEMCG_EXCLUSIVE
>
> Let's go with the exclusive one.

Thanks, will use it.

