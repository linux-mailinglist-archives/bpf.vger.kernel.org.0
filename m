Return-Path: <bpf+bounces-75010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BB9C6BE8B
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 23:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF6A734C9AA
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 22:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D2030DD25;
	Tue, 18 Nov 2025 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXy1uKR2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16224309F0A
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763506545; cv=none; b=ZBCFS88Zi7TcK8C4pvLgn1XgR3NwN4e2o+JeeTR/hK0L04jgB+P3ipGNGjqEvQ8n9Sh2NGateCUgAFHwCA8Qw8A84PMKgJbJVJ4OZfIyK7hGgaZ8EyKH8q7JqjPYAl+2YBoS1Pv0J/XrIaFA2bfk5d7Bh+o6cgZhZkFSpq5GHfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763506545; c=relaxed/simple;
	bh=JLFaPVWDIgTD39+/bMjIyLUd3/StZk7hWCfgSQcYabE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LeT7FbgUzzoOTCb8VqCvNRDe2tFG3W4mjDi7s0RyrBDBst1GQvafpFKqqZqJYJqYTep/zLG2jth9jd+78kKifZioE4vTk1pBZpAUknT7nCAosvOlmh101wy1INsYGPtru1nHDBg1ggCb+jjc05D1pmQLC5E0Sg1GNkbREWbn+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXy1uKR2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so6883234b3a.3
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 14:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763506543; x=1764111343; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JLFaPVWDIgTD39+/bMjIyLUd3/StZk7hWCfgSQcYabE=;
        b=NXy1uKR2wev5dP99WAk18I4XffUHGSGGZoB9in0Lig+U/F+I0X0V+u1e0S7WdAbZJM
         Go7mVUz5XgYkvTycTYND7cQB5sePbzRWI2xNDTTzMztbjqngSI/AmZoO7R7M4cebHDjq
         Jn6sl5J+jIs52o1VOVO2rMk06qp0RWiGYv0oeYZxpkxaeAdEhBCbZY5dTza9whTLA+Aa
         MznIEL2qcZ4jk2QTCy6mEmjgNCBm6AUDfjAq3A/0gxeYusx+33Kk/zlK+C17sXyh64Wh
         sq+txgS9241jONvTyZ4Ta5Kqu9BU7TkRdUx0YrJ2X3Pm9Ab4V2r9zTcPQvSaM3QHEtwb
         ReBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763506543; x=1764111343;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLFaPVWDIgTD39+/bMjIyLUd3/StZk7hWCfgSQcYabE=;
        b=TuVgwf4pE64mqfR5ydRRUpZb86jkbuUwSmlLFXIM28ejVciYD8jbHbJ2X1tKlL5FT+
         uQ2BqKqo0NJDUCexJVEEMn5uru8oEFoYX5ZwXKqaaPsY9R+GzkK40VvXPROqKn1t9+q9
         P+QZdivsyIc79I9x/D6sNElmCuBbTvE2fTw6e2MAsn12PJDrZlR0/7AD99/rcMwY+AZO
         OAs82zTl0ppWd5n14aRoles8N+1DnKmRDJDy4ehnz3GwJLxI2LwzHSVYuaPSqLtYOgem
         gi2wnjb4odxJenZtHGbJNmmAfaZ39U4IOmvb+wSpPiSQxHAP2A8Vr6uhhLg1HKYEGnzL
         P3Qg==
X-Forwarded-Encrypted: i=1; AJvYcCW2m9wEjpEPLRM/9siSRIC8pkPvH0ybnBuK1Ro2iBINLduIQBrzjHYRd7pCtySTLucLAAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwinJ9QAstLaQsa0zKV99wxqA4ZHHbdn38yXjVzLYDgwLoyPF4Y
	j2WbrmzLEnjDSIK4rEpXDjPYlbe4OLiTpJofn7YhlppyUS4mF3eU6Ept
X-Gm-Gg: ASbGncstFILts8H0GZKNw6OcDhNChcF4jhKNZagTLi/Dta6EdHX2fK4x1KlKlPh2+Ud
	S1wmJW/SbSq/TvkSJm5WkRfQEAW84Fr7lHfwGQzLQ+dQQw8oQvGCcjerEfRU2f0f5xXZWr4CnGc
	aQcZRMOmKkPRto/EtfMzx91hFEltNiqMMdkGu/UE4hlHTE9AOMTWg62FR8RqiiaImielYMv9P+5
	fqV0lojGE6tQhx6SuajweTkuO27/Kh2bWvAD+TeVwhE1s+ntS9d7wIUOKtdIEy2ugbK7JkoVzhH
	1HmjXZt6t1QmbkgaspgxAMICNNKI1aW/ScE9sVtH0xHgO393NQlUlSMpKTD3x0yKujY6IanezJp
	2MF5vAbfyo4oH8son9NO4o/V1rVOI2/FkJY1h+6YkwsU8F/rVyObQnPZtBwPMZGeFgZ/4uRfm5d
	5lybG+SPf9miFAQ4OOyarO9hJZUP0SGucOwVJUHQ0I2ZmF3PQ=
X-Google-Smtp-Source: AGHT+IHnPO+xc7WSiz6vXKgyoPPQMvIiqxT5hbFJiDX2Amw5+RMPl3QEzwHd20vibnIsp+H87YekRQ==
X-Received: by 2002:a05:6a00:1a93:b0:7ab:21ca:a3be with SMTP id d2e1a72fcca58-7ba39bb1decmr22397926b3a.12.1763506543341;
        Tue, 18 Nov 2025 14:55:43 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a9d4:ea4c:ca6f:e5fd? ([2620:10d:c090:500::5:ee25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d32e8sm17623649b3a.24.2025.11.18.14.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:55:43 -0800 (PST)
Message-ID: <21961a5ba6f9e3c08a1b0386ca98ffca07e18068.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/4] bpf: test the correct stack liveness of
 tail calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin Teichmann <martin.teichmann@xfel.eu>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
Date: Tue, 18 Nov 2025 14:55:42 -0800
In-Reply-To: <20251118133944.979865-5-martin.teichmann@xfel.eu>
References: <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
	 <20251118133944.979865-5-martin.teichmann@xfel.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-18 at 14:39 +0100, Martin Teichmann wrote:
> A new test is added: caller_stack_write_tail_call tests that the live
> stack is correctly tracked for a tail call.
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Same here, please add signed-off-by.

[...]

