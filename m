Return-Path: <bpf+bounces-78257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9697D06763
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 23:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B62AD302A126
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 22:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19577337109;
	Thu,  8 Jan 2026 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGQejxtf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B00212FB9
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912430; cv=pass; b=FjebDhBaF5m6ds7S1PptdMLgOJ78v9ee8Hb/7PCguit7tmo6elKA5cL6OfVyCNuKnRdJ6HXEib2mPogZlAGiMoVgz17S4BPF1yYepTr0xuzt5qhqFMFlKnDhIsSxvy9EgziGhecMQTD6hxgn8BEmUsWbPrOtXX9sY73/CqNPJA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912430; c=relaxed/simple;
	bh=05M7G+yD5bg2zpxfBRZSfkHw88GfIvX7aX3Dn7f4FHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgVeQcsBPH2Zj+rIiXZOMsqziOwvK7KPUyYEjiONOnUwQChfDCEexoMm/sDyBTiAgSGrjEzM+KSjGBw5bKGy0UNYqoLzzdL7orgeGGduxH2VaIU91CbOt8HIem9VmpkZm19j/sIQdqJAEgDs1Fq0kdA2wD+uuvowiXr964qPOYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGQejxtf; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4edb8d6e98aso180271cf.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 14:47:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767912427; cv=none;
        d=google.com; s=arc-20240605;
        b=MRPmAqedYLiCoTFOVW/+cS3D2NiBQm1IFUpI01zqk5f6OA6AgyFDCS9dQV+do45JJf
         ekIvTw25Sau1PxDGDHceEVps8W+NbgQT7QKHs0HVxOfmOxxlAPNcW0IiKrTQOWc3QJWn
         oZ/ohT1FE0gTvPQvsdfq+iId1zFHR7PPE/EUq67pCVLBQL1tX4Fs9lSJe2q01Pmcyaxp
         B15ud7aT8AKUPjTawWzJG+z8TdehgXCODOTr3R4Q8qjr8dxBdKGO361hdv6xygLNHSdb
         DPaPA9o/Am44//HmUfO++4FPwjMWYzF53aiY8jNU1fNJRjifvEG+slV2S8MRmDcZZXvt
         ncLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=05M7G+yD5bg2zpxfBRZSfkHw88GfIvX7aX3Dn7f4FHo=;
        fh=QQ/sfEKPq2Hp6Y2g59LT1RX2q4RXExz5ZmcSdBql1rI=;
        b=h9Rvi1kQsNHFrngkNLliZmI0FccAQm0LKeAxxTbcCKGgiOCuThtfwCkBgy9nbuFnJ1
         zkK/BgfKTcaYCC/AarIf1KFQGZdc81D4g1aRt8phjHI25tKiPX/2WPtr0cHdIew+5vd4
         KXoLGIq8gB60i7ysbnMxChrujGanz0UdnHUDQgXDwPA0J7ErRF2wYmmvNcAYpOy4QWaF
         qKmH65CmXOQL8RLt3z+NJNLA2VEfIL/10qmNyuA3I69Gqm+R179SJF7sqA3sRmiIv8Mt
         IPRk9NzVYIMgwc3zYlI2x7bB7tl8DHosXmH1IXuENusUPd+TdsMAn83JdPsYwcmHeCYB
         xfOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767912427; x=1768517227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05M7G+yD5bg2zpxfBRZSfkHw88GfIvX7aX3Dn7f4FHo=;
        b=NGQejxtf2Jaa+RGslgJRJN+JXurmKYzqnYxfVp8GPq3Zay9NOOR7eoF3Zscb/0kT6J
         BRXM3Koq5aNwJG6Xs9rIRhTbWIS1/1hmL4glbb95HoB6mT9RiMEOHNw6wIc1rTBTILlQ
         HwEosyqJ9ExuavMPnseG6vxblXkOSut6IYTp95WMS6rKmy+V0pF3ZDuR6+RlfSJf+XRg
         hUmJu81DWN5mH9KtOy99zamcPFbKZf+e4BVQIa3fw50k7Kazafz5+mfgGrzwZ+uMJwdU
         rsi1333NfXMsMETzrVe+4gUN7q86gY2CLx3o3Yzo5e/opPEzxJi1AQzEnFwZNeYNTgcs
         yE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767912427; x=1768517227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=05M7G+yD5bg2zpxfBRZSfkHw88GfIvX7aX3Dn7f4FHo=;
        b=M7j3xK38C/WmK1XY+qOmP4bUZPqVXynBc+YCrgxuod1dM/6n4extG6H8AISZW7fCsZ
         U76QO9WNhrSejXrgJ4coXYxlXEpmpByWXQcbj4GgsSyl9XgHuRUk/FmYQIhtNLxDD8aF
         0E3OPw7iWREolY/9ReYQfd4+Scv4EhUayPNGpx3UHSLzCX10bYt03hQmqgDC0irrHT3x
         +xA+kOlnNiU3NYnbi/DQ2SaHUijB9CzeVGm7Gt8YSal3yfTVRecH4j4RXvkhK0zJn+GO
         y15/e++Wfb6Gm8NSuo2AmmWqedunU0nLRvrwjgQrmIRXU3/2+SP927xSYgOcw2bn+Pct
         rEFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdZvFzRiSvqJpdHTkmmV3YGxDzQLtsuc/U6pHmws55t5gcfjjasKiI1/MlxjNmaP+Hyhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/62JoPxi5QMJZ+FTMi++OR4Jygq/67ulY06IpRX/jEOqSU3Pu
	fUYqySbh7Y/ZfCl7Z0MyrZ/ULvBSKFL9ydIKUNDzkb+5O1fghsSfh9dUGIsyJCPj93VU8stCp+m
	9EeebrPALLYAjkqkYuL9UZaOcXnz3auec9FQuZx9h
X-Gm-Gg: AY/fxX6dLR+SXGAsfH3MJNp3UBLLr2L6N0SPi2FDdbiyVJgtb4bCKxylXaPFxQ6081v
	ECK2fYyuqXG8gLKD6rQkEey9UVepKz5eizmKgLRhniJixOVNiXLWeEiYqXRNbMaCrxrvSFFDigF
	DAvhmGgel8D1JnmOO0JdcEsGyDLQo6kTggqZx3ynH7hPYhy/CxnrLOiVNBPjkooy6yZo1dgBUHr
	YzSUymgjIf3H1d1Hicn9FH5iXfvnXl1JmR/uxQKfc53ZpDZZi5TR0aGttnM2lEVQ9qTyKDaaukr
	ZIDofol7/0w8ZLfGaIoO+B9Km/RTLjzGveBoHSICkOpKDwqm1nJnZP+4PmfH3PT9E1SWng==
X-Received: by 2002:ac8:5782:0:b0:4f3:7b37:81b with SMTP id
 d75a77b69052e-4ffca3ad29bmr3817721cf.18.1767912426910; Thu, 08 Jan 2026
 14:47:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com> <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 Jan 2026 17:46:47 -0500
X-Gm-Features: AQt7F2ovG-v9G1YvqpyTasF2O1QIEJ_BUtc_E8UKj2kCrrVV8U2__Yy5KoIU4r0
Message-ID: <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com, 
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Linux Accurate ECN test sets using ACE counters and AccECN options to
> cover several scenarios: Connection teardown, different ACK conditions,
> counter wrapping, SACK space grabbing, fallback schemes, negotiation
> retransmission/reorder/loss, AccECN option drop/loss, different
> handshake reflectors, data with marking, and different sysctl values.
>
> Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Co-developed-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> ---

Chia-Yu, thank you for posting the packetdrill tests.

A couple thoughts:

(1) These tests are using the experimental AccECN packetdrill support
that is not in mainline packetdrill yet. Can you please share the
github URL for the version of packetdrill you used? I will work on
merging the appropriate experimental AccECN packetdrill support into
the Google packetdrill mainline branch.

(2) The last I heard, the tools/testing/selftests/net/packetdrill/
infrastructure does not run tests in subdirectories of that
packetdrill/ directory, and that is why all the tests in
tools/testing/selftests/net/packetdrill/ are in a single directory.
When you run these tests, do all the tests actually get run? Just
wanted to check this. :-)

Thanks!
neal

