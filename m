Return-Path: <bpf+bounces-71495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AE9BF57E2
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 11:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BDB3B09A8
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 09:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5676432AAA8;
	Tue, 21 Oct 2025 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noEdxz1c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED7A31D736
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038765; cv=none; b=iKQstH+/5HjqhEFSkdeu/uYWuiIX3+ES2ZyUqlCoMWDjNpBasr+kDkMQ2z9fvMWIliwo2IGIipFfpS6SpZnVa5NKeM8bu/QuoYIZsymPKgKyEdExYnQBi1FMvQgxFFwY/tivdAXuOUr9XiOlF2RcMFbW4xdENlcpmqUnxH4rykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038765; c=relaxed/simple;
	bh=VFQphnGkoktZvUzEwKwCJ8sXqt24rjb9W6hVqumfQyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfDmpgnGde7vIbdHPK3MtWhNecuGxSpuUAeA820XW1o4H676mtnJGmV7BqgGWnv9JWwWsIJc0TMqFRegJQgRJKd4S9QXnXJ0tRHz+IxiClra8qQ66dXjNs/swZ2XUKnyGtUHgp+9nfd9wIzWNZWOvmbV7sGra7nygDy8jItn5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noEdxz1c; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46b303f7469so42559615e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 02:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761038762; x=1761643562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOpWrFnzvrU8dTkKh9SzfT0djhjWURZWY8moqWPz71I=;
        b=noEdxz1cmxgyCrbf3Wd6MWCQBkpKNuZl7HVtYdP3Y3ADUEPOGo/W4mv8fGrl1kwgzs
         bF2CQSmwtzufVKYln5FMiHBQMBapwLx1+DDrJjaSyhC7Kez+WAI6iP4j2YvQmOllZmU7
         1IvELMEK2Tcic7sajjCEp6mIlkYRnpjSUfJw24joMxXOVfhjeQZu1xiKCOm7cbzzUCLT
         Mq/ls385ZSNy6/l/+Km18SBrMO777cinIWNAwFhtu9Z461iVlI1N6PHW7+JRQHINlgHc
         3lpHy4tO7TTbHoShpmcBV2JXIe3ziQxhzpoWB+kqiDPbyrNEdbu3gLjbXLYHYIQ3FtDO
         O2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038762; x=1761643562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOpWrFnzvrU8dTkKh9SzfT0djhjWURZWY8moqWPz71I=;
        b=PtS081ME+h2EYqUT6AJLt3HGNZaTITQLByDN12y41bP41NjNLcgXxZDdoV1E99KSE6
         ZS8TiUTPFugWdW8yG2inWRN7ConjvTC4EM1a1ZjRd3ve7Kp6WlieiONS2+PAk5HlHv38
         wODR6Nb+IIx3FlNH3JTYmuaafBeXV9gykQ7FXHf+w886fUnyi+dsk37WiAVUHPemGCh0
         x60z+wDwh5ISRYI30cyc4TzhL9JiTsfLIXMvszOPtvCaJ8RmMtjss+9aQI6M4hmMOJjL
         YYnAXRtkX9c/tj3Ah2A8GhJOxuO40U1jqkbcJgtOyImTH/DJPxuygcGFV0ByWG4UP9jj
         3txw==
X-Forwarded-Encrypted: i=1; AJvYcCVcuPoYYpqsn1SNKkFVuB7mdgTsP6mSKfmqYqd9Aqxfj6EQv5IpYfo0xIDoWJqPPlcVbP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5vD+ryccbQ40ZL74YdJtMeBNoCfKCLAIjsOAIHrCFL54FSAqT
	kHF5ADgrgexpazQFg7LaboFnR1v7ifGrIQlFaeQJP+ZeV2M24cUw9b3sT/Uv1g==
X-Gm-Gg: ASbGncuIyJpt3j+JT8BV56yLdV6qxiaWnImtBw2LVQi8hyg/jg2EjqzigFaPEcbv+yM
	E1HDmFijNrhjMD6ELTDNLMuv2y/Ti8u3zhn8b08zUiMjiBqFAEfOU2IcJ89N8/2A4aSkUAZq6ZD
	HkmBfxZFcUKnShnrGhtyXLiRYKxHV8jeFrc+0QrMuZdV/ucKMX5PZv7lR8sMWZZxFarN/BTv5P9
	fAN6fOWfmLlDMOxFW+4MoDlI4CZciEdJXTc91tP/l/S2aHquvHlAVM4nMW76OdiwFWmH09rIBsP
	pKwPJc2xcOSo1ZAGOpREsKWkvb8CrJ2WzttLK7EP+mlSYxuIbUeK+/aIZtV/43pFqR1PNO71v6c
	aPJvqWpEQDYwa+JaOIoESll93HsOfR+Ctw5MqTSnEjIxyjADSOfYvPZ4l7uswz/2fZ50wlQ6TJm
	Xnre5R46Q2Tipr3/aJrPtw8jIrOVMtYi9GwJMaBBWguSCus7DyDOXSTeIgfkbTbaw=
X-Google-Smtp-Source: AGHT+IHG9qJps3XQWPNYA4OPAfHFr1juDXQi4VNXIDoZlFbccTY3/HGAyaSBPRBTf6Mk1q4iNuNdsg==
X-Received: by 2002:a05:600c:818f:b0:46f:b42e:e361 with SMTP id 5b1f17b1804b1-47117931c89mr109559365e9.41.1761038762110;
        Tue, 21 Oct 2025 02:26:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0ec2sm19195113f8f.3.2025.10.21.02.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:26:01 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:26:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
Message-ID: <20251021102600.2838d216@pumpkin>
In-Reply-To: <20251020212639.1223484-1-kees@kernel.org>
References: <20251020212125.make.115-kees@kernel.org>
	<20251020212639.1223484-1-kees@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 14:26:30 -0700
Kees Cook <kees@kernel.org> wrote:

> Add flexible sockaddr structure to support addresses longer than the
> traditional 14-byte struct sockaddr::sa_data limitation without
> requiring the full 128-byte sa_data of struct sockaddr_storage. This
> allows the network APIs to pass around a pointer to an object that
> isn't lying to the compiler about how big it is, but must be accompanied
> by its actual size as an additional parameter.
> 
> It's possible we may way to migrate to including the size with the
> struct in the future, e.g.:
> 
> struct sockaddr_unspec {
> 	u16 sa_data_len;
> 	u16 sa_family;
> 	u8  sa_data[] __counted_by(sa_data_len);
> };

One on the historic Unix implementations split the 'sa_family'
field into two single byte fields - the second one containing the length.
That might work - although care would be needed not to pass a length
back to userspace.

NetBSD certainly forbid declaring variables of type 'sockaddr storage',
the kernel could only use pointers to it.
These days that might be enforcable by the compiler.

	David

