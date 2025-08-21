Return-Path: <bpf+bounces-66211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75ECB2F99D
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 15:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B53A25F84
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2570321F3D;
	Thu, 21 Aug 2025 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEQJcZ/O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EAC320CC4
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781476; cv=none; b=M2CopvafV5hwDdMxYOlYb3NL/L+cjHJyt7FJNl1uLzTNsxNUAMoGKmmNHKqPktLlJqJ8BloHqVfiQh8TC72HImTZCb2rSMX6IodGODg8NRvgeFbiINBxtKOepdL14AY3wDsNjNRbO+NXjdER4jPQegQGllWL/7ainpjHdXdq6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781476; c=relaxed/simple;
	bh=dksXjVdpoZxSgSUQEjTqurSba+l6eHHY6MPN1daXJck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewhnNoafnxSav+ye7F+1njfsx66Ih+pH6cgwT7klwbaKCqB3hlUq3iFKbtvwOfdfAOf29UedlYMBfD2O1Sw3gQWjeNztA5FZc3PV11rxp2d2F3pjjGpV6IP0aRdX8hkbrlbDYXvKh70NdqvQV6YdV3DRPmM9jQbOYczQn/L10qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mEQJcZ/O; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e86faa158fso138287485a.1
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755781473; x=1756386273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cyf0y+0F3zjeNAsfKiaSOtP08SnUX+d4gcmortqinM=;
        b=mEQJcZ/O65dATBlYGtnKTmDmhKhukdF45BXUwIsXmz/8E2kVElQXFQwIHNWVg8q8ug
         9KJSNf+LkwVn+QrVlYkNYyuvRTL9mIdG9Jrlu/ZE5Lv/ct+K7HFLzF6WiD8i9UVn7Wf+
         NT69uI9ElWNrfOgQedsLVuF58qC/tyoHAFUrCDC/GW0uaK2YjuA1K94TUmfEu0hbBZZA
         UY4SvTIZnpW2fAWKbH0tWJ4WXPnlpUnZ2QqdgYmJUllauwdS6LkRSkJFxRsCnnCgkBv5
         CqWkiB7g+KDAy7u1MxPXXdLedySimf/Nm+WOoyMjaMsRFTJ6sfiV6QhGoIxyu/F4zGVz
         5mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755781473; x=1756386273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cyf0y+0F3zjeNAsfKiaSOtP08SnUX+d4gcmortqinM=;
        b=tSHTzFV7Rot020ddEwaHR4nbEUtsz+QFuftSAG6yzvGcV2q04ueY9NmHK0CxQiMf3A
         iJNVJLaDZuR0onZeMTHnKV5IU122aXlOHjlv7wSEC6nM9GRfWmYml7cKxwWF54EQsQUz
         b+6ETdZISImQJ6pFUo7yk5HzDOYzua4V/UHDIkKKjjUE2AtkPIXEn85wp35Yjv0qZjrp
         EA7KH2oREEU+9z/73NdvnTLID7TQu9Gi7y8SYlsaPg1VCuNWNIw88bJVniCWZCh4ljnY
         O/QV7E7A03mHQz1cDhd4U/gPVn47qcHH3L/yqa+SNMRq2lWlRPd/4QdBuJFdO5Q9mLVS
         yTMg==
X-Forwarded-Encrypted: i=1; AJvYcCWV7BMNgZ9m+yPwzpiCbwY5lTVE5Bxr1eBETo+w2zLyVeCzpP9NWEyj7ZrzX9VK/iDmziI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiz9gDhDIAUHCiKfyjLCmzlUYbcWOd8An1DbM+r/LmkzUSdeNC
	wrAPDTDMbEecme7Fz9oxGoQ0Y0nbsyVtzsMLxPwc2a1SWVzNyKW1VQgecYycT+eQNm73vT0mUZl
	attoucngzVp+8DqIfzqPvtLumeuRdoPmZduWnPn/R
X-Gm-Gg: ASbGncuooSlO+nuvcdZQpAfI2TxDETvjeSUG2YgSxfGMCMd/puYy1gU+0zl78+DOHMK
	5Ocw3UGtNw68Ezn0RB9sKDwKNjvRrBoyDZxF3NSjMDXlox8sDjZyh9m4N3+ACXKISmHDucFmwcZ
	nlZJtbSkpqTL+28jIhea8kBoyQn2MrtxJB8BuY9Rkv1e+vN5poqAnY+KC/ZMIfQ8bsKyxqf0Ad/
	uSaQby+2SHTEyWoYaa7EPfwfg==
X-Google-Smtp-Source: AGHT+IE/rVuZ9SCIHg1gU7wHZFKJcVFlbis3SdAosQsMQXAAs3D+JvW5TH6jC+V2oisrZbfPgFfUQfa4iF740e0XHhA=
X-Received: by 2002:a05:620a:1915:b0:7e9:f820:2b32 with SMTP id
 af79cd13be357-7ea0972ad73mr237461685a.39.1755781472346; Thu, 21 Aug 2025
 06:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-15-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-15-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 06:04:20 -0700
X-Gm-Features: Ac12FXyJZ2QzT9xkYMMFg0cMwGaeSy-IVq_aPmJhAwN18-ZLuJFS365DtCRetGA
Message-ID: <CANn89iLFEM+mbU2d0AEH3O+3zg5Cwm7pdmaadUxXifUqLuaQLg@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 14/14] tcp: accecn: try to fit AccECN option
 with SACK
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:40=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> As SACK blocks tend to eat all option space when there are
> many holes, it is useful to compromise on sending many SACK
> blocks in every ACK and attempt to fit the AccECN option
> there by reducing the number of SACK blocks. However, it will
> never go below two SACK blocks because of the AccECN option.
>
> As the AccECN option is often not put to every ACK, the space
> hijack is usually only temporary. Depending on the reuqired
> AccECN fields (can be either 3, 2, 1, or 0, cf. Table 5 in
> AccECN spec) and the NOPs used for alignment of other
> TCP options, up to two SACK blocks will be reduced. Please
> find below tables for more details:
>
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> | Number of | Required | Remaining |  Number of  |    Final    |
> |   SACK    |  AccECN  |  option   |  reduced    |  number of  |
> |  blocks   |  fields  |  spaces   | SACK blocks | SACK blocks |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> |  x (<=3D2)  |  0 to 3  |    any    |      0      |      x      |
> +-----------+----------+-----------+-------------+-------------+
> |     3     |    0     |    any    |      0      |      3      |
> |     3     |    1     |    <4     |      1      |      2      |
> |     3     |    1     |    >=3D4    |      0      |      3      |
> |     3     |    2     |    <8     |      1      |      2      |
> |     3     |    2     |    >=3D8    |      0      |      3      |
> |     3     |    3     |    <12    |      1      |      2      |
> |     3     |    3     |    >=3D12   |      0      |      3      |
> +-----------+----------+-----------+-------------+-------------+
> |  y (>=3D4)  |    0     |    any    |      0      |      y      |
> |  y (>=3D4)  |    1     |    <4     |      1      |     y-1     |
> |  y (>=3D4)  |    1     |    >=3D4    |      0      |      y      |
> |  y (>=3D4)  |    2     |    <8     |      1      |     y-1     |
> |  y (>=3D4)  |    2     |    >=3D8    |      0      |      y      |
> |  y (>=3D4)  |    3     |    <4     |      2      |     y-2     |
> |  y (>=3D4)  |    3     |    <12    |      1      |     y-1     |
> |  y (>=3D4)  |    3     |    >=3D12   |      0      |      y      |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>

It is unclear if this chart takes into account the TCP TS option ?

Can you clarify this point ?

