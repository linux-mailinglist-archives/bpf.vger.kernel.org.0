Return-Path: <bpf+bounces-30157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 749778CB46C
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 21:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11DE71F2305C
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 19:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBCD14900F;
	Tue, 21 May 2024 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZelQr8CG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBA450A63
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320936; cv=none; b=jOqxoUH54LIg+3WDDrOzYWdRVGKLBqQ/jEAssSVGSadCuxxazDKPH3kSnpaEC+vcud95P6ueJjDHEC6/Wvf/rfEZHe2VLBHvoEEg1Qepx7th9x9Qy1CAUE+M55RhF8/6KottGNgtWd2ssWN9DlykZfLEP6EErztuwhaneZDKJcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320936; c=relaxed/simple;
	bh=CYGezNgwz5skEgORZpKhd84VGS9rn/Q/QO3kjk2WwZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GhZu+ihgC2pBZdRyReb/yvo3cCA3ww+abyJgNjFARvwuqCk2+CvCg60wymcMClPErVPM7NG4jzPPin5aOTay3moSenrInx+QabFw0XNQDFSkKoB/uG8lMnk2zQXEw8Zhf7LCI2EmzRpsdNky7N2cPYFgU4ZcIl6nq8jQvqnWRE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZelQr8CG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f457853950so160875b3a.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716320934; x=1716925734; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CYGezNgwz5skEgORZpKhd84VGS9rn/Q/QO3kjk2WwZE=;
        b=ZelQr8CGd0fH0Txlf5bqKVUd88yX5HK3m7XWzB0BXPQi3pWiM2rBmC42HaeRfUkage
         Dzh/afm1s28u02/Y6AhX46KP9Cbw9jQuLyc+jgs/HN9M+DQGoR6EVkBPaYRGQItu/B6y
         ks0vfRs0llQBmq5jqRyLrHixOUfc3TQwO/RLbZpOVvG3oMY3w9d9qlgKYt0OQ+NcCINF
         Nkdn9e6exd6RHoOVnUwVnKx4I+lO5o1bhMegUdJOy7nFT+rzr6hK6kNUdP+0plqD9enj
         iKvyBNc1sSSSBdDPZVtp1pny/y8gk1R5nln9dym6kx0rVQciip2O69mX3eMqJTfceNMX
         70SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716320934; x=1716925734;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CYGezNgwz5skEgORZpKhd84VGS9rn/Q/QO3kjk2WwZE=;
        b=TajsXMI0l8bYQEBSSnGcrI2dV+QCThninAVadG5ez1z16iSDKOLihSxsRq6dRBw9bQ
         UtSP/zWDZPiBatPMgGrJ6qjU9MecImfvfSs/5CWuRNvtI76Z5Zl8MdxZscD9+fsMWBL/
         QP2l5jcg4QrxEC4tjvi3Q5J5/I/rrzwe/+S+8nGRXPHNK0R+37uzrkfO2jMyrNtHp0VR
         9sizrEgneLMyjxXIUwEXG8jG5KGQE3J/dQ0XmlgXUE1YZJUt4gn4YqMyiSgKItv3vXAS
         HkU/7kFxsh7blk8iTSJCDdgQng2vVx0rmNWC5leZTp6Xj1y3FrEINwJ5ECHWHRzF2mNb
         e8mA==
X-Gm-Message-State: AOJu0YwZD/OUHq8iC0lOTVzN6ZCafI4JNE8VnNSPxm8BWfgDNBB1q4Bu
	bcQOIVZjnIA9n6AbxJmZGJfzHT4Txk5ypRiu1AM6jQnmDThA3qgY
X-Google-Smtp-Source: AGHT+IEm97+MuNem1MV0zZyD86oI1mxUkAxQepkBHBus+Z0sBQjn85qc8E6MkLJSuDz500Rb6ZvXFw==
X-Received: by 2002:a05:6a21:9989:b0:1b0:2421:4341 with SMTP id adf61e73a8af0-1b1ca3b8ec1mr15172652637.9.1716320934130;
        Tue, 21 May 2024 12:48:54 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4fa8db6a2sm17796120b3a.177.2024.05.21.12.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:48:53 -0700 (PDT)
Message-ID: <63d69f3020c54a5dcb3b1817838f2c8034fd4f0f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests: bpf: crypto: use NULL
 instead of 0-sized dynptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>,  Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org
Date: Tue, 21 May 2024 12:48:52 -0700
In-Reply-To: <20240510122823.1530682-4-vadfed@meta.com>
References: <20240510122823.1530682-1-vadfed@meta.com>
	 <20240510122823.1530682-4-vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 05:28 -0700, Vadim Fedorenko wrote:
> Adjust selftests to use nullable option for state and IV arg.
>=20
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

