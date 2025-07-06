Return-Path: <bpf+bounces-62476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FA1AFA737
	for <lists+bpf@lfdr.de>; Sun,  6 Jul 2025 20:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F6E7A855B
	for <lists+bpf@lfdr.de>; Sun,  6 Jul 2025 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C9A288C18;
	Sun,  6 Jul 2025 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="ZObrtIBH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E61917FB
	for <bpf@vger.kernel.org>; Sun,  6 Jul 2025 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751826975; cv=none; b=KmWh36bqa/y3H+1ACnKjSYUuGPmmqw2PWWM4tVUyPlY6Eimyq1ikgZQ6+zalqteZw8D3F9seiEJaNOMxIWBuhFchmpqre6rxWWSwCoyCftPjFj8IxDx2B11HBYdR+Aulp/yI4/afvD4CGgsOx71nsZtRLbNWeOyMagew8AtyX64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751826975; c=relaxed/simple;
	bh=EaSyyumbPn/z7D+Peo+TAe7w8FD0BhRKW0vhSRvqVvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9/9N0p5BOrraflK8eEAfnqU1MSA7GTcpyaOqdXOL7jazveycPidMCpV1uyRIXUtaOIuZC0Bo7qUW7vxDeDz602ykmrmIehnX3iK5CQ/4+atuhI6Xl2pInHToaOPcj8Ed18yqr9g9XFw0UiHUMkuTA2KyPbyQ7tMC+Q0UDfWK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=ZObrtIBH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7426c4e3d57so399569b3a.2
        for <bpf@vger.kernel.org>; Sun, 06 Jul 2025 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751826973; x=1752431773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EaSyyumbPn/z7D+Peo+TAe7w8FD0BhRKW0vhSRvqVvI=;
        b=ZObrtIBHEY6pPbYUQqBzAYsakvIjgeIsFRdEsBTqK7Xwgk1D4+5Q58wn/bGnj0oe5e
         y93APPaN7TUAoa8lAmH0VIXCcE0OIgwF/7t189p0jEu/q9AR54OBBhoB+0jx3ePJHayO
         0gMG4xBOxJeRecmmaZiS0ldW9sHJOKsk7jSweTaQUCr1+NLXbfMFbmqAFu6AOiRgaVPM
         ukgSTsGEY5sH2MwY17cLSHZ5tii7a6xOya3jyuoUb6kXpKtSrPe1OaVCCF/zx01XJemr
         uooeRI0UI8NLJXTHGw3y9ODEiZ1qW50ASqL58Rp9xJafMwfOO3K5JZMO8tG3V2npAIh2
         QzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751826973; x=1752431773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaSyyumbPn/z7D+Peo+TAe7w8FD0BhRKW0vhSRvqVvI=;
        b=sNWYHTOXBc2E9R2gJtRzcekoVFQgAYDkmkkXICOr3S4L1fA+D3CaHdcNu3gZ1gDszc
         Qfs5oPy4x652NJusOYja0BbhIdoS3CaBwl9O2bzc9VP6Muhwm6P5sH+o6rPPZP8cO3Pa
         5PAqR6kl0ZWLTTqxu0ihSRVu5NPkCnmiiSIyWy6WGxnUTE3u1fBYpOIHihUVRZ7L8uGj
         CfX0+9zhwK9cVka+UrJfA/2iXZXQTulXMrm9uOTuS7jTd5YjaXKGbSmtVh/6Fded8yDM
         9SLR1S6B2kFR94abD4pETMkIwlWosG8BJ/l6RBhXMG+GY+CQosyU4alrVm8wSe9SkzPE
         SAdw==
X-Forwarded-Encrypted: i=1; AJvYcCW4Cf093iKNdVcrg+36e70oISQD+K+Vjq7hWr1D/W6RAr3//CcrwyPRGVICDj2KXcLfMog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrGb/8HoB/wMkXYZzybgPyJShdzqReyMRbxQb81/ho9DdPpGd
	iAd3fg7LyCWBJbfSm02bCeetFEAWvMhR5O2pgrApqZxqhbSqw5f9Zk3Q7DBAitZexZ4=
X-Gm-Gg: ASbGncu5MdIY0R7L7+hO8k3WBJaUELFY/RRGF5mFu1NV1hFOGcedRiujacd8joeYlNz
	KNff501iOTWHAexeu6esGTIWNEjgiEvwgPftlh7awUWOroD8bQJSRpfaKbKY8K+0km0Xc7Wnnw0
	FDdPgl9HYY9hJrq3uxLdpMk7hGEBiIAWhYuaH7s7OcgTNj3cK9TXSpigp2LFvyxckHesEzOMyhX
	yG7Zvmdf3sFY3U7G51T2cwAGUjjaEmYaxPv4IK0HzX/B+DxAxr8alM4nVR94nBdwmmXCF5P+qXs
	rJ0PGFpjo1/aSG0mlLCbC7sZyddow3+7HWJjKvqFiias4ZrDIbeVG5QVIN8=
X-Google-Smtp-Source: AGHT+IG91q24WBqoOFy3IButW8Z/B4H/etgIOaxw4tS2rHdcvGhID6hawdPFnji8oLdkp4ZpY0LPqA==
X-Received: by 2002:a17:902:dad1:b0:234:c549:da0c with SMTP id d9443c01a7336-23c87178d8bmr52961415ad.0.1751826972892;
        Sun, 06 Jul 2025 11:36:12 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:8dab:9982:878f:106d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431e15dsm66523425ad.36.2025.07.06.11.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 11:36:12 -0700 (PDT)
Date: Sun, 6 Jul 2025 11:36:09 -0700
From: Jordan Rife <jordan@jrife.io>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/12] bpf: tcp: Avoid socket skips and
 repeats during iteration
Message-ID: <s55nxnbs4gq56ytq627n7wanqkcrbn5vmbht43tdrrbcbe5jl7@uufojhrm6qyh>
References: <20250630171709.113813-1-jordan@jrife.io>
 <20250630171709.113813-6-jordan@jrife.io>
 <aGLYO7XRafb9ROQi@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGLYO7XRafb9ROQi@mini-arch>

> nit: let's drop {} around sk_nulls_for_each_from?
> nit: add break here for consistency?

Thanks for taking another look. Will address this and other nits in v4.

Jordan

