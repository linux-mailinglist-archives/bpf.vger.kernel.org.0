Return-Path: <bpf+bounces-79590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DF8D3C59E
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 11:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D913558AC3E
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 10:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490FE3E9F76;
	Tue, 20 Jan 2026 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RaYwrACB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906DC3E9F9C
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904322; cv=pass; b=d+maVzpa/pCe3l0DzdytD0XlL3yvrCKYjdspG6lNgWpMr3VYFODWhmGk5C7n/kvo2ErgG1jooVQv+R+IZm/NYuVk/JbDAeY6w5jHUfavIaCcB9elYKb6h0RcCf0OjekCLAi3PSkS1J8YaHdRijbvpYUeJF211Lt8InLi/XtJzhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904322; c=relaxed/simple;
	bh=b3/vqEjOYP5wT8rQWVCJ7bEZ9Lj9Z/WoJtk7uoPUAaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeTH8DaCgLdgpSq2bznGO/GPY5T7pd+uMk0ocPnT7CCelBVKDc2lJE+hYyxz+5IKS1rQUulG7yMvef6MVFdxHJaQccO2tl3BL7rcCfKiy1I3NUyY5V34saGna4E/RL+RSc/zpe8rrDT7JUhs/vt6slFCkPfFvUPlCgG4wVIdm5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RaYwrACB; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-502a2370e4fso32076681cf.3
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 02:18:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768904319; cv=none;
        d=google.com; s=arc-20240605;
        b=DVb+4hwPmqJ/JSbNDZ+sGluIICFybNz5mnxg0GJ7KWDdode3X4ed/u+pD7lRITz1AZ
         iQtlvTSWrIz6ZqFG7vPloD1UyuUKAOldWoJ+gMCJqxQ/S3Xy2f8X5jXjKnxuLZHGRR9z
         5HCw9T//mKBybFFYkk9iHX0xmfr3gA9MoiJKvxbtyETJyH1Q/wH4eogDju1EDJorEsaH
         2Tv9JMdIDU9j8uiKniwEVZ1pzmg4YuM0ktdcA5sI3zi5HE5QdWKG3RZQYYUlRt8YyMHI
         hH53nbOy/4nsI9AIP7zYXPLc576JL+8D+GBfCMqIBApKvNhmlVxJfrwplZlCsMu0prSj
         WnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b3/vqEjOYP5wT8rQWVCJ7bEZ9Lj9Z/WoJtk7uoPUAaY=;
        fh=6f330kM4Ry0mhNvOYcHA2lGWaTpKF6w4/psOwyNpnj0=;
        b=EJ6acUALOWWgf+WP2HBqsn3/w6BAeBioIeEV4nOS9UEPNAaJAIZk0uROUUBXzWF4X2
         op0URQ1n2rZF/cNespB2IG/LcuVxAcBW9vOjDXxE3Jnvhz9iN5vg9mRVnR/HtO+Axlm8
         mk/mNumRmJ/mpTKAEconQNVBB85e1lSM9beMgox7nYXjM9sNoGo5bvzYliamhNOIqMUn
         6JIKP1cQM00eXJO1es1j8/d2V5Ure+IIMcLPgc+vJIEa32CXJlnhCmkRwkJjC/NOSoWd
         LGX2WUtk8dQh23FpqwZuUdsMSPTDBQT/LQZHExcVxZvQjYSu9YAUeSHphUSrEjnzTjZm
         BuIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768904319; x=1769509119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3/vqEjOYP5wT8rQWVCJ7bEZ9Lj9Z/WoJtk7uoPUAaY=;
        b=RaYwrACB1pbJO9Q6eDg48UcHrWDmIg6oer89G3yBKamt5wwYLsIRNgBzqeyZqinyba
         XXViknaRsH9GVvVJsQWjHobR+hK20LmZ+kCnvzRCCkUy2htPs/doFR1WyyU9KtpZ1NT2
         ffDFimp/p0rAcoOXBu2185cRD+C54AinpRKF0oWW07214gGokq9p53sGIEIRu73kxYTG
         8/jafdk3orEy3XR3378E9zGmHbEO++wHIohIOy+tgE2BlOqrNRI5pMASS9G8c+SXVhbV
         ks9AucTDVt+4Zbgyqfty4lHAGyWi2A3wX6dIv6RueHd2dxMa+dbhXLrKkRCMGoK/1nlp
         rKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904319; x=1769509119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b3/vqEjOYP5wT8rQWVCJ7bEZ9Lj9Z/WoJtk7uoPUAaY=;
        b=lKJ9jwTNLYlsB9d60WCZo805TslbmJ+fmtpEhqDBp/Y3d1ggsUohqOgqAPLqF7zVA8
         a4ZNdJCkHBAmldJHGAVeF3H88JYy5zvzAEKnMSQhdxBbGNaNGmUEP8odIDF2nU1hhKZa
         odmGFQycUh2nBursqvs6gmtjS3FAnx860pziKj3PX06Ssc/zkYENnvB/Ab+M+zIXQouY
         NB2HDaQHZ9ElgjspCEWoIGUa8PM5gQarvDo5PCOSeEpclBduc2lpK26MNivPngwkTQSz
         Ip7AM1MMRDICrN7t0FTSiWIvRPH8h/3Xv7YYt2QJSjTXi5jccUyH0+TSD20z8J/g/0ZH
         Jfpw==
X-Forwarded-Encrypted: i=1; AJvYcCWXc0Ms8m/w+2LcbcV4zBfLJLckxs6nQKUdHE7xIbc55ix9JzBjZupWvJ3Yq5X9yLGAV5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YynlaM4q6AUjI2hQEmAau1MYj3BTaq9/G8kNIBClso66QZVfgkW
	wHT+FC+w3CK7ffn6ooUwhEfWwn3I2M/YuW4a4n+OkVGVTsipODG8y7ZrYd/xSjlpR3dlB2fnZBP
	PUR9iCKetQ7JLgF/NYaJrX185F2EzSVCO1Fk8xQrf
X-Gm-Gg: AY/fxX5uxGcByMIct0Rk2SdjwZivP5htXT34zuf0zdURw7KtT+pjdh/1G69gmYcSMMM
	7G413PPXy+Lek18X28emPKELgUsyiS1Gszkuq9H5Ojt+yQlYpvPcnMhOb1n3akHuej0oFUInRfd
	88uQZF0xC7hsq2a8+DfghO1rOchVx1ksXggxHuusSGQjh/mSSHHsAwtlZlKBMK8LB3l8H30K0u+
	MrbhSo3lzYAcJK54dFhvo+fOmnNpvLfb42zNjpxFU/6SrDRiJ8NH1ycgpTw0R9DoOKrCu4=
X-Received: by 2002:ac8:5952:0:b0:4ff:8fc7:917b with SMTP id
 d75a77b69052e-502a17d35fbmr194387991cf.80.1768904318971; Tue, 20 Jan 2026
 02:18:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-7-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-7-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 11:18:27 +0100
X-Gm-Features: AZwV_QjH7opN_HPqvhqUNXEbYAFk1K1nGv7G-5WTlprpaA8RI4H5El1vduIS2JM
Message-ID: <CANn89iJHz4ecnqfFY9F4Mkb-aKCiCRhtx8++YvKPZbSHy4NXGA@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 06/15] tcp: accecn: handle unexpected AccECN
 negotiation feedback
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
> has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) =3D (1,1,1)
> then receives a SYN/ACK with the currently reserved combination
> (AE,CWR,ECE) =3D (1,0,1) but it does not have logic specific to such a
> combination, the Client MUST enable AccECN mode as if the SYN/ACK
> confirmed that the Server supported AccECN and as if it fed back that
> the IP-ECN field on the SYN had arrived unchanged.

I find this a bit confusing.

3.1.2 has :

An AccECN implementation has no need to recognize or support the Server
response labelled 'Nonce' or ECN-nonce feedback more generally , as RFC 354=
0
has been reclassified as Historic . AccECN is compatible with alternative
 ECN feedback integrity approaches to the nonce (see Section 5.3).
 The SYN/ACK labelled 'Nonce' with (AE,CWR,ECE) =3D (1,0,1) is reserved
for future use.
A TCP Client (A) that receives such a SYN/ ACK follows the procedure
for forward compatibility given in Section 3.1.3.

The relevant section in the RFC is 3.1.2 _and_ 3.1.3 ?

Honestly, AccECN is way too complex for my taste :/

Please copy/paste the precise RFC parts, it will help future maintenance.

Reviewed-by: Eric Dumazet <edumazet@google.com>

