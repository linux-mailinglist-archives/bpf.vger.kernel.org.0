Return-Path: <bpf+bounces-35258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FF49393D8
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665091C215E3
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F88517083F;
	Mon, 22 Jul 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoAHdBDL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8617238DC7;
	Mon, 22 Jul 2024 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721674082; cv=none; b=JqbwZboyfHA7/13MSwXrafH8Pnw4UNfF9QxzhnCjVj9yC0n6gPirHtZ+SF23E5amwmBG8BmT1IUKcwwvvZnOpicscGjVhQbdSRzuszA8M15BBu7TWXhrasKtsqiwi/0uvbmeonmDa+MxefSVLJjkW1gh39bDFGJW4J//v3gBQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721674082; c=relaxed/simple;
	bh=YT1G6z6f1UMio3qlxrxQpaN1hLCP2KlC0vYZ7ZElp8M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IJghtrGr/7ak08YSqI81swoJ8bAGdgAlMjAJamvFODKmV5vqW3Wd2ZTgEWaBEkXPMkvJwGtKdi7bJwm2u7Edx0Y5Ro09tnaD07UCFGIXScXoQyuoAxxgW1uw43UpdYGukxRcZOinzzgMQQ2ITfaCZSeU6t78/UO9bO7Sw0JPXzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoAHdBDL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d2b27c115so890189b3a.2;
        Mon, 22 Jul 2024 11:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721674081; x=1722278881; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YT1G6z6f1UMio3qlxrxQpaN1hLCP2KlC0vYZ7ZElp8M=;
        b=JoAHdBDLHDCRo3sjj/2eHOAEw/4ZjEo6x7RC8wFayQfTbBsiYcrDR5oOcHIXQJDX2o
         +F3Ri7IcxB/0JGD8ruPj2ueMWnR+A4EFmg0OjLAk8KX6e+folOSjM01eqAxP95wma267
         8q4Kb7sT1H2k8QQBnBcDA1zDiFEdlE9TwTt2IudC1t4yuIY0S5d63pU7j2i5SLWE/ZcN
         K3FXCA34NBJU35BSjRKxgbXBMkmJf7dHVy+rSS4gGCFizj9qyeX0ozHwwIG299XXbdg/
         X112pzny9hAsIWTmsf17JoPuQTs51IRTE8gr2+G0oYzZw54mVsJWfgsyQrthW7djkF+Y
         mNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721674081; x=1722278881;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YT1G6z6f1UMio3qlxrxQpaN1hLCP2KlC0vYZ7ZElp8M=;
        b=hHgW554neioFK7OJP08JBfKhOMAMvIGXJH173EymB5F9k+r2yb1Is2dtytnvGDvW2c
         NJPIFKeAAjvBXWS6TIFtTWV5VvC6QWq51SaCnqQoLVWZ0Tjm6wgyT+exot6j9SwOhEgZ
         TOEvnIeUjVf+KoYQujn+CfFEnj2RHQj3s/zwdau8omjCEKZOAeIxXOJx+SbLVl7RFJi8
         hkP32S+qyHIJ28C4YJoXntjttrp8rtye3qVhv7mXZztXJAIFjTAlEuWHc9/Nhj8w0Srk
         /IfqFQMXLQV18qWJRiZKOQQf7QxebCRWn+VG2X3VILMu1bRrn/HL72LR/QmJ3DoZr5kh
         fZvw==
X-Forwarded-Encrypted: i=1; AJvYcCUv0qxVysNat7E2O4aDmdI4SDH4BgggCE+IvURLU5yaBWs9fHLMXFNwtps5xN+q0KyM68K83lE3ow9N2t3sUkVmtTyQuhStCYbPlKfLTRHvlAeCeyhGYoEfGOi99YJQr4oFMHhbGv7dCNgSxEEL
X-Gm-Message-State: AOJu0Yze0isgIvmk0tcd2rNsji/ok3K3nQBAB97HabyuAASP8LBmj0y2
	KMZZYaBo4rfKLbS07WakM/uYrmmFwRpuGTu3V+lw/cdFdfSmTiXk
X-Google-Smtp-Source: AGHT+IFARhx17YmjAw/Ctt/erbqqFO5Sa/JclzO9trxS0oMrVio9oi5pziQSNFQ11V0kvMfY19t0OA==
X-Received: by 2002:a05:6a00:ac4:b0:704:2f65:4996 with SMTP id d2e1a72fcca58-70d0efa433dmr9672732b3a.11.1721674080736;
        Mon, 22 Jul 2024 11:48:00 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a0de7abd43sm3162257a12.23.2024.07.22.11.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 11:48:00 -0700 (PDT)
Message-ID: <0e46dcf652ff0b1168fc82e491c3d20eae18b21d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/9] bpf, verifier: improve signed ranges
 inference for BPF_AND
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Xu Kuohai
 <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>,  KP Singh
 <kpsingh@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, Matt
 Bobrowski <mattbobrowski@google.com>, Yafang Shao <laoar.shao@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, "Jose E . Marchesi"
 <jose.marchesi@oracle.com>, James Morris <jamorris@linux.microsoft.com>,
 Kees Cook <kees@kernel.org>, Brendan Jackman <jackmanb@google.com>, Florent
 Revest <revest@google.com>
Date: Mon, 22 Jul 2024 11:47:55 -0700
In-Reply-To: <wjvdnep2od4kf3f7fiteh73s4gnktcfsii4lbb2ztvudexiyqw@hxqowhgokxf3>
References: <20240719110059.797546-1-xukuohai@huaweicloud.com>
	 <20240719110059.797546-6-xukuohai@huaweicloud.com>
	 <a5afdfca337a59bfe8f730a59ea40cd48d9a3d6b.camel@gmail.com>
	 <wjvdnep2od4kf3f7fiteh73s4gnktcfsii4lbb2ztvudexiyqw@hxqowhgokxf3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-22 at 20:57 +0800, Shung-Hsi Yu wrote:

[...]

> > As a nitpick, I think that it would be good to have some shortened
> > version of the derivation in the comments alongside the code.
>=20
> Agree it would. Will try to add a 2-4 sentence explanation.
>=20
> > (Maybe with a link to the mailing list).
>=20
> Adding a link to the mailing list seems out of the usual for comment in
> verifier.c though, and it would be quite long. That said, it would be
> nice to hint that there exists a more verbose version of the
> explanation.
>=20
> Maybe an explicit "see commit for the full detail" at the end of
> the added comment?

Tbh, I find bounds deduction code extremely confusing.
Imho, having lengthy comments there is a good thing.


