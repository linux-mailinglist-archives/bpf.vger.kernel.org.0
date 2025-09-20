Return-Path: <bpf+bounces-69114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CF0B8D1D4
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 00:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8405C628310
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 22:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EF51B423C;
	Sat, 20 Sep 2025 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au7uo8/u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032DEA55
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758407567; cv=none; b=mKhk+j2elCqvsh0BO6iskaezjrG/Z8rF/XU9/l4gZRwB9xB3QBzSz+YGpBrR8g7b8pTXfWoXgQ+s8hujaR6JjoH2/9tixcRu6bOIquFaAPaEQx7If1uDg9D72FjLUGPKAJRa06JmF2MHQZlxuhUUfilnL4k2g5jqIZagTr67qa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758407567; c=relaxed/simple;
	bh=9MgNOVm/aCbFOba0mu7r1qV8sPmWho6UopS4H/9xlzM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bhF97XA8X4Vf/U2UfP77KzVlD5hCoVLSPGg8f3UcEKPUtSHdKavQojjYgnuk5mQctqeYA+hGQSTCnx7fJdKntGawkexi5zzlFfG4RAzyBbs5wg2RfTP+tFwyQXzv+T4o8Of0B5ZgvZZXPRytzN0aw0V1wHRufGfbXW4GuqVxlKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Au7uo8/u; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so2945160b3a.1
        for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 15:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758407565; x=1759012365; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5I9WYuEcC7Dkxn55xqcHmpqW99guZ0IQLuOXoVALgg=;
        b=Au7uo8/uE0F2TgQiDBT1HIKm1gcKtqqIZ5IG5AP7MIw6fFFcLdUKo3hdXRvwcjt2PS
         zFaUW+5cfketxBx9iRF9iNOzQp8DqDV+wcQjfIO+qLhnKuS+1F3//knEC8barENpx7QE
         WmhbZNGSePJPn0D9XkFHx8DH7fWuW8wBV0H7kP3aufeFsdAG5+Gm+6JantsRK9ufSPEv
         Ma2ZLIzvAIQz5Fqmcywqld7K20vgzhULely6Bi+bbR/BuQDccxtWhhaSkgn2g2y3BtbX
         uiam1hSncwkcPS7uA/Qx4C7cDp0h/QpnUTEq0fLDOD3w360GWDvW45epc1wlZDM5au7c
         btoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758407565; x=1759012365;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E5I9WYuEcC7Dkxn55xqcHmpqW99guZ0IQLuOXoVALgg=;
        b=V0YbJaC/ySN+zhSJ1NRftXzXVGJaLtGRFbKyH5V5rooCkI6Kl21LjkhI+M6h21oTeb
         G0nUylH5nQakrlxKXrwSHXV4AYuKa99T9B3u0ROAQsErzKK4zylRLxdWJxmEuOlB2TzR
         j6lFNh6xDPVEGbr8LplNwt/95Xkz7bR1DZAJAscRAAvZ7OKr8mPLsLVBVQmAKRAUR6wc
         Q3pQjBf7BtHPjhrw98cuY99ghe6DHY61P4dMGTyufmUFYG7tarpX1/gcd0ZoWd7Flbc0
         K8JMb1CPOZtknWXD9XqzhLNxCyhVSHz9WGMw6Z6sILY64rv5wwbbzkhWgLfBlBOlrcDd
         6DiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaMmPjAusRV7T89OJP4p8eXIV0VC4zh2YKvmXoBkU0fHlkYE4p297ygWaNkMKY9olWkmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6rwCirFtNPqAtPsMXazD2Xphh4Oq4Uoi4EqMUNRZbeSX4Ss6i
	fXNewDaleYjIW83mecVencAaktind/nAYtiKOlCQg+Ro/28ku5tuWd+j
X-Gm-Gg: ASbGncv06p3Icuapz8Ng0YlJeigbARz9xo6q1lYUaTI6+R16qyoVrVtmDlE2lKYYZu3
	kXrMPaA12psURxS/Tob20O8H60ZK6hbmcll6OGQBafSWrI55HOGvvXtLZjhl1vvf9mxdu9lB5gN
	otAuqbtKBoheJxKVL80n3B0+p0tWDgHqdhpuORjV0HvoBQH6UaAZJb+2IhJXsqjZMkLX2vgs8nt
	4GAelu5jMQVe4HJB02Y5OSaHw3jQ47TNxgJXmRwx63hHz33AoqQrJaufLnK6YsWjESe3/8xn296
	uQLeKaZ/p5fryd59SWnRcODZBlK5Znf/U2TwW2fMRI3TJvIx0VRXSuUwoCd+nKjRSJKEUaNf1ol
	ti2bnruQyI+hyWBDiAuM=
X-Google-Smtp-Source: AGHT+IFqUDtUIcfUhukzlzPPi1dqQKMJIZt0gruEmb+ODgse6ebxLN+mSp7sez7CtfD44MwKzNDj8Q==
X-Received: by 2002:a05:6a00:8514:b0:77f:9ab:f5 with SMTP id d2e1a72fcca58-77f09ab0175mr4301903b3a.14.1758407565174;
        Sat, 20 Sep 2025 15:32:45 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfe760f38sm8814428b3a.57.2025.09.20.15.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 15:32:44 -0700 (PDT)
Message-ID: <5682271a4c66d8c0fb81c516d301aa1a8ca66b99.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 13/13] selftests/bpf: add selftests for
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Sat, 20 Sep 2025 15:32:41 -0700
In-Reply-To: <8f529733004eed937b92cc7afab25a6f288b29aa.camel@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
			 <20250918093850.455051-14-a.s.protopopov@gmail.com>
		 <71cc9b1aaae03dc948f2543b44efab2ed6c1b74f.camel@gmail.com>
	 <8f529733004eed937b92cc7afab25a6f288b29aa.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-09-20 at 15:27 -0700, Eduard Zingerman wrote:

[...]

>   ".pushsection .jumptables,\"\",@progbits;\n"
                                            ^^^^
                                should be w/o newlines, sorry

[...]

> Having such complete set of such tests, I'd only keep a few canary
> C-level tests.

*Having complete set of such tests, ...

