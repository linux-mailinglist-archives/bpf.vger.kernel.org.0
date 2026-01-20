Return-Path: <bpf+bounces-79549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C92D3BDFF
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 04:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16ADA34BCD0
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 03:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244D1331A7A;
	Tue, 20 Jan 2026 03:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw/BMzIS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6153314DF
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 03:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768880397; cv=none; b=j7kTcySBE5yDlloZ1za4I4L8MRh/MVcIjw6ESOU0TuhPinCqNS0R/2gHywQNKUqM0PIY4PEFVMnTkfrDmSN25Py6AJEQhGCEOLR8Ma/biXXKlA5uEOtyF6Swzfh/7+zrBcO9hqtWKQ+305AixdKmfWZeDof9JxaCWJe19hJaT3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768880397; c=relaxed/simple;
	bh=PkQnT9HrASsJc7IurqBQq+Uzv9yailjV38eVPJVHhAg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EytkeGOc3mhAANKAQNKLpuzvFhzPt69QxXtUCwHS7HSiX4TPTMFB6QYkEtSZBn0gGHpt0bFloxFwZ3acPnTZPIKhT5hwoPONMTgHSuKnQWsOzZWU63HYnhvZbfJrooHiHZ3GSb0pEU1Q8PEvB2alW2H1KbKnRhrTnEtPrZZa+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw/BMzIS; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79088484065so45876727b3.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 19:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768880395; x=1769485195; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+f2e7dJ5whTj9SkU/TlgqUpo4cL0LQRd5uYBnJ44hS4=;
        b=Gw/BMzISSY9TwPlVTqjdrPv5xoy9IucnPOywTAMIcOG2d12GuE3BvIM86jkEIbbzWG
         jpQfag4w2e4OcO7fVhb82Tjtz+ElJSnDDkyjXAu43uJK5vVfwcnHiJJUyKUf8z8+5IR+
         ErBQ5n6LqGlXzEtzS2F3wWMRj2F7UTcD6E6/XRnDugIhEVvynaqHWLQZtrQ8po/oN3KV
         y5kbkfdOZZSZRtz0wHQVRcklTCp1KWbX5UXdKBG9bHhL7aEcdaqiokMuDW7n04SUGRXw
         BkO9TQs5GWdB/TKji+PeaIXS+mlcUhQdE/GFtMW8BktTG+Y2Lu3w/rzkaUe91V3llMjG
         6v1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768880395; x=1769485195;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+f2e7dJ5whTj9SkU/TlgqUpo4cL0LQRd5uYBnJ44hS4=;
        b=IJd9RFD6ubu/3qGmjf87Si5wK+Z4AtYUZ25G2ggXTA4P1DPhvdzqnn1drIB4ZtATzC
         tDgEvz8IQNJVD+rFKyRIdJ8bN0g7ZsE9q7dFqN2xqC0czFbl9F3GMLAkqMQvdpIzukcP
         It2WMHr88QrLcxzxGkkVUOHS4soVXom36g1DIDLYaikKKzPfREJNtFCQmzobLoKZgWD6
         O6xg07PZv9aWOlyP27SjB7Jxn6ekOeQ4MCF9/OuqrAZ5+jB1Kzbk3klQHR0rWm8ViqmH
         kvEVBQTJeNxrbsJ6mvwICpbU7nBCj0DTlzblOUbdl4zpa960XhPAuXlVRbLG/dftdAIa
         eAnA==
X-Forwarded-Encrypted: i=1; AJvYcCU6zp4HtFlheZYFv5YTyIjriK+MYYXYOfQWreVDHwyZb+0a9apBvcDICJWFYf0JTZDk6/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOZbPtT/QFvUHwegtNBHM/KglDAI6RRhJkeu8DnQ0PHdN2Jps
	FUpmb1Y6E7rD4bocykKauY8EUKVs+4EczQCWYQ7mmZ31DvtA3d8mWB6M
X-Gm-Gg: AZuq6aJyZlud5KrUfyTGLtgOrW7YbEnf0Unk8/QPWBaP6xZPESF/SaWlKAjoW2I25L0
	fRaGRMjirCI3qGOrqAVSiFUf7qwxrYkbFBThZ03kCID0bgUEv/ZvRjb3XCUXJZq858fWXbAGtrF
	wzSUoGuj1bgfUsUst4iLwiJZZ1DeGi9soAXpfx2NeIDYNVzbBmVNHeK01CaNZZSYM37nrNPPMDY
	QFk1AnkcqX/D/Gw1vl5ZBQiiUzAFJo9jKlZaxHCb4M8vhfQLAYGuBE4/Av1cd+O2+YhiE5geaMZ
	xPdnyadURNm6nkwMRoZ4D69HnZ8PthIwB+STZ9R9XLocvPGnbmu16dmPSi5Z5/nBOQZzQU8JjLV
	7rnZJnSJo2nTvzsQNGxPPkjX2iiY36ImqboejMjON9se8iKO8mMKMeZb0YXK5Ipu17E7mhhrRJp
	DDgGJhQ0/4+8rYGSqDAwhEYJDQp+YBeOoYLO3JPia6sOr4E/YMG1091AL0lqe0j/IDmeA=
X-Received: by 2002:a05:690c:dd3:b0:794:35b:af5e with SMTP id 00721157ae682-7940a0e6771mr11618687b3.5.1768880394417;
        Mon, 19 Jan 2026 19:39:54 -0800 (PST)
Received: from smtpclient.apple (2607-8700-5500-8678-0000-0000-0000-0002.16clouds.com. [2607:8700:5500:8678::2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c68d305dsm47643947b3.55.2026.01.19.19.39.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 19:39:53 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH bpf RESEND v2 1/2] bpf: Fix memory access flags in helper
 prototypes
From: Zesen Liu <ftyghome@gmail.com>
In-Reply-To: <55f01664fc714615206cc8d100cabf4f310f2302.camel@gmail.com>
Date: Tue, 20 Jan 2026 11:39:31 +0800
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 Shuran Liu <electronlsr@gmail.com>,
 Peili Gao <gplhust955@gmail.com>,
 Haoran Ni <haoran.ni.cs@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B91D5A7E-4967-416D-A2AC-CD3428F3C702@gmail.com>
References: <20260118-helper_proto-v2-0-ab3a1337e755@gmail.com>
 <20260118-helper_proto-v2-1-ab3a1337e755@gmail.com>
 <55f01664fc714615206cc8d100cabf4f310f2302.camel@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)

[...]

> On Jan 20, 2026, at 04:24, Eduard Zingerman <eddyz87@gmail.com> wrote:
>=20
> Q: why ARG_PTR_TO_UNINIT_MEM here, but not for a previous function and
>   not for snprintf variants?

For bpf_get_stack_proto_raw_tp, I chose ARG_PTR_TO_UNINIT_MEM to be =
consistent with its siblings:

=E2=80=A2 bpf_get_stack_proto_tp (bpf_trace.c:1425)
=E2=80=A2 bpf_get_stack_proto (stackmap.c:525)
=E2=80=A2 bpf_get_stack_sleepable_proto (stackmap.c:541)

All of these are wrappers around the same core function bpf_get_stack() =
/ __bpf_get_stack(), passing the buffer with identical semantics, and =
all use ARG_PTR_TO_UNINIT_MEM.=

