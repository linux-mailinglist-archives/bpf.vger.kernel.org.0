Return-Path: <bpf+bounces-66198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746C4B2F7E0
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D4B3B5468
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132BE2E0916;
	Thu, 21 Aug 2025 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1d0O64rI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2AE2853E2
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779069; cv=none; b=hmfpxcmuzovYvi5NT7wXqQqjgX8IG6QT0Dwxwv5tEA9U1VgRHgqxGfF4l23O7+duiRQND4TOJxbOh2CwdTlNfwpsByEo87I0osYSCot8d5xst/dqmTvnW6BVG808qkHkNBf7akdznirkntZVEMFPaakr1FbPpzy9A1aijHm0bvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779069; c=relaxed/simple;
	bh=f1AbBbvLlmetpbm2cknoVOkum8sEWbncoukC/4LrwuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTuk15QGlSESUBk9gL0XevWO9SfWVtvgM8ud1sayH9N2xMw7gmdUUTOsw8G48WH61unmE/JN2pVBIWCvlkAOuApzylYaQrk5/VfYy1IFrkIVpUc3PNJKp32iO+FLoszPqsqz1yfEI+sX+1CZl3IEbECYJKnZ0PbDykGSFaIP8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1d0O64rI; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b2979628f9so11011381cf.2
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 05:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755779067; x=1756383867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1AbBbvLlmetpbm2cknoVOkum8sEWbncoukC/4LrwuI=;
        b=1d0O64rICsWpfp1eb4Q5gc2LxsR6uLVDSPIZcm8PyqVlfeafi0vD4fErSm4wlrEwGY
         /1C5qgn34lKV/0q8/M2nkGtaLrphZRFmZJxRp1sq+trcmeasboSJlozEWSfuMVj5v2ln
         pS9wSyf7yCWv01yYzqo27s37v/XmdSFrHvIcVpyVn6NtPjWJRsReafak0htJaHRKJe6N
         il5/tD0mWSvOwIaTSwHaqHL+w1QjF5BxZScQ8x4Z4m2EzA9dpcH93fFQfASCSCdWVMDS
         eis4A4mS+ZKuiweh7NLa8za4Hc1zI02G+ScsdFmibuMenFxbz/1Z008uPaI5wDi9Sex0
         QTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779067; x=1756383867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1AbBbvLlmetpbm2cknoVOkum8sEWbncoukC/4LrwuI=;
        b=wQOLCICxjFiUuIh/ebPCHYwzPt1ZYHOZozOPQeM0KQ/z7iTnrSWG+lLXSv0RDgK3a/
         NGwrmJF/5d5mVHQjBuTZ0v+j4S+SBVYVRbEbGiFI/aVk2X+Ld3zcthxXII6npk0wSOPr
         q4o/FL88tVk7x30IhnkH3J3ulLxLqaqd/fbmNqZh5WElQBsEEJs3TYy9o5h5KcWHsPD8
         ZbVBqB6oG1j7OaCeuwX795bu2ddTPu22fPIgyGyvxlWLVDg0ecVIBV75S7xHMHFRk39O
         1331Y3/Haj6Ar81kJnJfLV7LufA0mKQZ6/GgnmKqCXFbM0x8KKHFfw0i3tolvqFtjMEw
         KjEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4R7mMjz1C9JYbsTTCnV8yq11ffejl4BQkN/CKviv+Q7IEOppQEJt1aPbjoSzhPAMZG3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwblPZeIjXv/Jg3VtORKJWOIBE11a33lS9rujLOBDzccSkJ41J
	+xIgGIpv3IRE4nQJ2dh3CQjkr0kcgZru1hkTdrP3Q2zRGXLK0xqYDEyJAMmat4tBqa22RMkesH4
	ZLdhi2dhoNE740tBQEiVti1v5xIAJjNwIwgZ7Zuj4XccKlWL8tDRbIP3h
X-Gm-Gg: ASbGncuvWF+gc0VkFwppLslKAsUXpsg7DuUZja+KSgKg5j3wfn/s/RfoGMPYG/o/EuO
	f1PyCzMZXziiqGkCN3i6fewWKUfwBmhFTQqWvmTZ7Swh43Ano17I6nDGQ4T3r7G1SoEgWtwB2Yk
	pYHBYh7l8JqWLk0uOaUXLmELi7AbWCgteg7zIxL/FO0GQ+aJUi9Tg2Alb5EVoiWNez1mBZcY2wW
	zVav/GXzq4lvzWzZeZIsZ6D6Q==
X-Google-Smtp-Source: AGHT+IE9nHthnuO3iyaaTFTophq+5yluqv4flsuTIbWyobQg+AKCHWYdoAelc0nDHS8WwCDQgE8Y49CEmLBBB7iUtng=
X-Received: by 2002:a05:622a:5e17:b0:4b2:8ac5:25aa with SMTP id
 d75a77b69052e-4b29ffc2c09mr20057031cf.83.1755779066699; Thu, 21 Aug 2025
 05:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-9-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-9-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 05:24:15 -0700
X-Gm-Features: Ac12FXz4ItLodbd6ls4z56PUPr7M6ZV9VCYXJm2RKx6YiZF5T39E5oM6J1bp_oU
Message-ID: <CANn89iKvwM4EFwzuLXOr8OzddQto_rPfdBHUMLzS=xxG3USzTg@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 08/14] tcp: accecn: AccECN needs to know
 delivered bytes
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

On Fri, Aug 15, 2025 at 1:39=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> AccECN byte counter estimation requires delivered bytes
> which can be calculated while processing SACK blocks and
> cumulative ACK. The delivered bytes will be used to estimate
> the byte counters between AccECN option (on ACKs w/o the
> option).
>
> Non-SACK calculation is quite annoying, inaccurate, and
> likely bogus.

Does it mean AccECN depends on SACK ?

>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

