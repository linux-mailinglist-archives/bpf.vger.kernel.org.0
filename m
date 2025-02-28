Return-Path: <bpf+bounces-52913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5009EA4A4E6
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5184A3B5D0E
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 21:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79A41D5CEA;
	Fri, 28 Feb 2025 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVONY7bX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E26B23F370
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777683; cv=none; b=ZhbwTZS7pVukxpzHyf/FZYLLR7G0vyxPO+KX8gcme23/iUaqOG/5sOpJqqqMJgoEHXjivDu8ubiyZ9zBgZNFkwTo7NzwT8XOYhyEXC1TdwgcYZ8Xo47Wz9GwteV5V2AXAk5jgg/JKStLY9kNBfvaTpIZgFktFRqo7Ohx/L5DYRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777683; c=relaxed/simple;
	bh=YjmQ1RbQw6K2to53k2kUL0hSOyqIRIWLc56/whoMfwY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=df4wTKu2x4oq7yWGkyO3nCJV+zR0p4e1KbDWdRSMDoFOdHeZcUz2kKg1qyYwfmjx10xAR+cO1wsvjPQZyY+VnbktG1aJOHMNy8JfshRQ+7Sp+7Hq37HDC+xLMEeGJulX+vZ0AgaRpfz1w0xFEexKfG0MRJtMiBrB1nTlpfl5hG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVONY7bX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220f4dd756eso60281965ad.3
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 13:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740777681; x=1741382481; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YjmQ1RbQw6K2to53k2kUL0hSOyqIRIWLc56/whoMfwY=;
        b=hVONY7bX8taLXofRkkGqVt96TgC+/6c1N1UqGzDAVIAzqM+Bh1F5QCZAL069Jrvq7C
         iPyQIVFaDkOOFg5c6tAkomsCOqqLnYjcxReEGafglCXky8MiPhVOslu8HGPRFGi4qDSX
         N1AbZI3oJ9xJsgb/FLf/NWovzYHYggAd4zB4EisOII01i9x3EpoU+Jjtm+hUqZ8Je+We
         RIv3sUiIlj+mR0Zu7traTO1h+FUAmYZK6ENOAmLHpdJsYjZk+OodDc9LKz1e9xLg4yz2
         B9QL4b9Cx1woAw+rDHBK3aHnkqMFQOUKIDkQeJgeX58Bprk81k5Pt/12aj5n83DWqFv7
         xfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740777681; x=1741382481;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YjmQ1RbQw6K2to53k2kUL0hSOyqIRIWLc56/whoMfwY=;
        b=NaAYWEF91fE3YuE5+DjdRr1ARzFlIT5HWnwIWEGQoeCo49QJHhxLczqlp3anANxgH5
         E8V2CHs/KLRYU/C08I1FFcmKh1tvwM37oeJ8xRiAbO5dtfokjvDdZzvTOUe5BB08PiQb
         nvcg/o6ytEUs/Ki7UTG7D+UtrnGMwh672XLRq9ioBIQIg6un6zZLnY4TpB8ycPhXcRwl
         EaQAEnhlb4/s+/lJRUZ7oTdrjVgmmwHFs1T5jgajqqARQVi94+zv/iD1uS96m3s7KliW
         uxrFD1EtlcaSii6ABBauflYoxMTvXn/H5w+K0ADFuuJTtVsWT0QX2kOq8QTw7jDN7VYy
         TCqg==
X-Forwarded-Encrypted: i=1; AJvYcCUESc2bRxMl4eH4IYyKjb8NFJqrHY1LPo46Ou+rml5chcAUslRbCE74OIJoQKIA1B6hX0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTUILHqqnRBrRtIbyVo3lO7fnkp7d2z6AE3tlBQnBgcpPyHrnx
	30rT/BXaeEncG1aXbowzed5DYl2yHyJcx5K+RgG8mu8QvrEQG5+z
X-Gm-Gg: ASbGncsXnJhUOxhgVu386lWErpWNJO1IS9hbsQC86SkvlKhKW+Rc/8iDGomNFHTmmnv
	dwX44iQsq2B2b6szFQ+TyCCeLr8spfrJvvg+xIYzvxq5wY8vzesvmC13Xfq+Z1FUgDgujCiUyIC
	JmUKP0dlJF0pnqqtNXtYwGPd2rbPLj73oi+WR75OR/kPUzKYbg0RnWAQWv0A0VRtbzf5z69jdRN
	Fi8XW5p3Bb1+MhhwxsYtHQ0/kVGq5MGt9Wft1hDV9g1C9Js/IVVsKN6daRl0mOKpqD+H7M1xRFc
	9fPOFi/mpZLPg2AuvmExjro=
X-Google-Smtp-Source: AGHT+IEc5e45djKRfYpiLoQP1rT++VjnawyTxpvQ+LaH4u1ZPWesKNA6NjV0w6IwLwnZxh4g7zeYfQ==
X-Received: by 2002:a05:6a00:8c83:b0:736:2ff4:f255 with SMTP id d2e1a72fcca58-7362ff507a9mr1664717b3a.15.1740777681269;
        Fri, 28 Feb 2025 13:21:21 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2b836sm4244415b3a.26.2025.02.28.13.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 13:21:21 -0800 (PST)
Message-ID: <21a2581566485760d26b7cdea65f03778b254cb8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Test sleepable global
 subprogs in atomic contexts
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kkd@meta.com, 	kernel-team@meta.com
Date: Fri, 28 Feb 2025 13:21:16 -0800
In-Reply-To: <20250228162858.1073529-3-memxor@gmail.com>
References: <20250228162858.1073529-1-memxor@gmail.com>
	 <20250228162858.1073529-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-28 at 08:28 -0800, Kumar Kartikeya Dwivedi wrote:
> Add tests for rejecting sleepable and accepting non-sleepable global
> function calls in atomic contexts. For spin locks, we still reject
> all global function calls. Once resilient spin locks land, we will
> carefully lift in cases where we deem it safe.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Maybe add one more layer in some of the tests?
E.g. call non-sleepable global from sleepable global and vice-versa?

[...]


