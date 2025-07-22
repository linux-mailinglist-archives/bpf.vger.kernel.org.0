Return-Path: <bpf+bounces-64099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 771C5B0E4EF
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DACC56808F
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 20:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF0E2853F2;
	Tue, 22 Jul 2025 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9/KY5qN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B9327F747;
	Tue, 22 Jul 2025 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753215890; cv=none; b=bbnubY+SkJb5U/XX8wugSx0S7cTJtyuv/x0XWDjC4l8X1pcfIogwphpa3gYVJcTnuCsxbZLG6XIB6MSNeZKCu7M6loBg/4LECnikxqu7W8F3DvAYs4KuXYYdAw9xuHWu8gqxpCHpDMabL7jlUdq1psLpZXmrDCNfsDmAsfMQthY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753215890; c=relaxed/simple;
	bh=/USxhzYE8kXjBo2YSy0g12UyghfZ9iOb8Jk2utFuTKQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cpqiNLTbrSxruwa4GzQ2hbqsdEEU7w1w0QA1TCT3QHkPN0vB0Wo10w2+0IQ3qYp67O3CfdQ3i5p3P8L3UvyjW3aVosozcvAvVIf9uoVkrE3bDKB6HynDujKEXpdx3LyolEk0kUCMY4+chjqDhAEqgXUBlINydgWI1YV6wJE+Q7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9/KY5qN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b56b1d301so3970863b3a.1;
        Tue, 22 Jul 2025 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753215889; x=1753820689; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/USxhzYE8kXjBo2YSy0g12UyghfZ9iOb8Jk2utFuTKQ=;
        b=a9/KY5qNQqLm0dlE2k6QdYL+xY4KLoxWMxhZaH/q/kaEgQECqdB4s1M3cPntiSx1BM
         kh9414fEOG35atarnbjreLuIo4kb10ZMy+6222uTZWIUXrG1FmVCAhWcXdof1WlPXk+5
         BwHFPoBdEpBuz0LLgNIeKYWxGovFic608/ReGytGruWHjmQITgR1UZUMLFsLMdnA2rKf
         W/U6suQXP3Kcy8TudjCiop4zIZ1CqoVP7WsquYnY76lKLKFZ8sis/MTaH6qWyVdZ6YLE
         6OsmRCLA7u4ynSWbwxz6FO5PgSmNkyiLPAirWpjhUDsNVFe7RB966/qWL+vCCZQWLwtD
         xkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753215889; x=1753820689;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/USxhzYE8kXjBo2YSy0g12UyghfZ9iOb8Jk2utFuTKQ=;
        b=oEW+sruNAAIkhvD4l+yQi3VFrI9xCR+7DCKdfTTZdpyi4xeSIepvmB8oQqY34y+dy9
         doyO+afV0TgqXr0ijSAqPcNoUDIA9oCt7Xalw1vgQXgJFK3slh2dPS/zajOZ91+xFE2w
         JCNkvkblN09aidnwniTGrCKgUd6fDzApcOXqdHn5HjJNQ4YC38eRQgeIL75nV8VWlav9
         ujGxIGE48bkH96PF17YMNeTU/vgV1me/mjgHVBFXK1KSX6LTac6tmUQPnw4DvhIeMPzY
         rMl96jAepWAoSCKI6IfqDJVD7CXNZdx+h/JoIxMJUP+IIwLt4P6LrH9t4voYYNhPqSNd
         i49Q==
X-Forwarded-Encrypted: i=1; AJvYcCX54H3HcB8dQzZsLt8vnuIKVd3FC3a1Ada/d9CVBqjuPxZ7zVLVQBO+sX0kqRSDgorv0pVHT2y0@vger.kernel.org, AJvYcCXLa8K4gsdvD/f/0L20zq5C4WX3j8gsH6cFiz6Ya6cC1pVV4p4v7NCMqiJShTdN4aTBOrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgsj8Ob/LKkXNt7dHPy58OMa3AO2XDf49Xor61tis0HakbtIl7
	YQmszLv8bofaEoVKd1KYAOlB1ptdnxWqjNZJrA/eMr6AT+dLdVoeyTSL
X-Gm-Gg: ASbGncssFRvv1YsNm0WZH3HA3lKuk11nIN2oQLsZQD+MFhhhhPCK02a1Zh+2NrImIFW
	F02+17g5vcaPGCp5TmAa/pL33juILIEyv8uOjfYazYjpCFxlcjUDS/bZLQfDij8Zu6hs0sEZY+3
	pGVAo7mwWy+TUoB1Tv0U/AR7W115LJYJi1Dtn2tfKBKPhwj708avmjadxo2WsYh7bC3YcoEbz2C
	mCOQJsUkmiPY0ijD860rgt2xaimSEFrCeyh7mC5fdwSf5bNE/0cElWpI0BaxAykotp+nI02jY6N
	8PUM0Qmoke77cMpvPzNbLGWC8gWB3+haTHFp2kq8V8ZeEgvguK6JM0SCTIt+XsK5wvZ+NCQ8dGd
	3NUsPD0RSlI+504v5cLhCjzdJy6Ma
X-Google-Smtp-Source: AGHT+IHyoMVlYHRax1ygQQPE+kj5NXCOmsDmpHi4e3P6GXFlt40aI5LuY/oVKuIY3oEEwXKtVRLJ9g==
X-Received: by 2002:a05:6a00:a0b:b0:74c:efae:fd8f with SMTP id d2e1a72fcca58-76035df4f41mr650988b3a.15.1753215888552;
        Tue, 22 Jul 2025 13:24:48 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:e6e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb156a04sm8068220b3a.70.2025.07.22.13.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 13:24:48 -0700 (PDT)
Message-ID: <28dc06b0c3e6f3fca100de8c2a922640ba83991f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 08/10] selftests/bpf: Cover read access to
 skb metadata via dynptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>, Daniel
 Borkmann <daniel@iogearbox.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer	 <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, Joanne Koong	
 <joannelkoong@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>, kernel-team@cloudflare.com, netdev@vger.kernel.org,
 Stanislav Fomichev	 <sdf@fomichev.me>
Date: Tue, 22 Jul 2025 13:24:46 -0700
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-8-e92be5534174@cloudflare.com>
References: 
	<20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
	 <20250721-skb-metadata-thru-dynptr-v3-8-e92be5534174@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 12:52 +0200, Jakub Sitnicki wrote:
> Exercise reading from SKB metadata area in two new ways:
> 1. indirectly, with bpf_dynptr_read(), and
> 2. directly, with bpf_dynptr_slice().
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

