Return-Path: <bpf+bounces-52665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCDFA46727
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 17:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344B17A8D4D
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CA322371B;
	Wed, 26 Feb 2025 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsChdBh2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27952904
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589008; cv=none; b=RuioZkkOu3B4WrmxWXVLCfM41gP6ToBWv55QNQz6KtMWZA4Y9MTdrLBSlXQQzdBR7NDQXCiHeEp51X9G3MghrX9RNktQxzP7qZ525DHHkRttWtnzzHO7upOue8/pG1awwjFMTijhURk4b/KSU9fpL2tet91XFh7PuvMQpXge1PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589008; c=relaxed/simple;
	bh=iRr0uOPXrU6ugXpiHgPNnJMpr3cM1K0J1MfxRCLwH9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+4UMQF6GPIpiepxpxZwJlGTIZV/em15aAV4MOvzUdKayI8gk5wZvpM9g6Sb3FT8EyMsWpsC6QkIqKW+dPq53EqjBOax7/ZlJjjo/W88r7P+DaC5groNbmn09gDa89y+qH8aVAvcVddU4kUX//Dz64qXzN6WgHqhMb9lH4w88XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsChdBh2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f325dd9e6so3762887f8f.1
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 08:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740589002; x=1741193802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29JUnLBRfQPoWbYVCuUDw7gEajR4ArdfEgKiU4JbF9g=;
        b=MsChdBh2q0/uFvh9A2P5ZMAqV6nNrqs8NN8cEmxCuYK7OoEcT92JuGCo9/8gtdB3s5
         xIsaxDKb4Sfjiuz2IqnTtHMT4yy9/e+E2Kq8FGhBVSj9Wc/rYycCkEs01BMExI4OdKgk
         xgPlwy2J+6ingsCnnq0PQ7eQ7grM6v5NGVUlBuUQiLQ06hNp9Y6KIhWWV8E+0jDGbU17
         zcT9YnVmCGUADvFL6ZmrHfQlK2pBKI6kBh3pGMDwXYIbHwz7hoF15ukLgKWtt8YwIYfW
         H/HBCwlGUCiwDJfSZ691Amld1aUjP3ApwQkZuOjggemAEC6Lttt92Abyxl9gQlYCsJJC
         pirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740589002; x=1741193802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29JUnLBRfQPoWbYVCuUDw7gEajR4ArdfEgKiU4JbF9g=;
        b=K+Dn1E6x0lLym9K33PqMKKgG6GrTHK7WTB17O4WeejdwqJD7wSDynZI3z5XgCoqZbv
         6uAqaqNvQVVowj7kDllg92dyMBT51cc4GpehbmYdipsbwrE/5p9wKYBxKsv3SEZtkhtu
         KlIaAbiq/+O6N0KIVqROliLwu/EbJjf2gQiixTniyK9Wlh3FgGJ5FRfqDbEQ1LZUircw
         zaDQhT6H0HdTMCHZ+zEjlNpqL3+5GWwJDWQiWAAFX30Xjvy1WVsBKRVbxPUVa7tIVWjq
         IilvwJmJbF1Y1yCEads0uTgoREFW8LNeaJ0NJpXRebu9Sf5rrq4aon0GImTDZBj+J9bx
         P9Jw==
X-Gm-Message-State: AOJu0YwZ7AXlPIxf89vP0fp+zFUZaUGfeWpCcnByRulIIg3Fq1wjuCmU
	41HPHCmAfRoupth9nSAsOeWFUnmq9U3r00/pQKh1a8RBraqr7u3YU8o6tjVrnI/AcyIUG7xjak4
	Uoyxk3hbS0YQA6sd/Gi7Ic6TKYF0=
X-Gm-Gg: ASbGncvxqxyetF15L+wNA4yorRRWBntJ27bg5ITHKjnS2JpglISFrCwUv0YpFtQ37DX
	CoAEOdLgJTXbe1RSefPzse7LGSa3QNojDRMJVIxrF/qd1kT63gcCSlZhaTFvfu/Rgy5gyielAoW
	GZ1xWlyKNMGNUWqkN3IwUgZW4=
X-Google-Smtp-Source: AGHT+IEK/MMm4gG18lWVAMaxiCOwObHx1F0eU4YoIsIhv3eeNKbWvUi58Z09UJY3DkkFSskvJH6iOc8xoQ2Icot8wNs=
X-Received: by 2002:a05:6000:18af:b0:38e:dcd4:a11 with SMTP id
 ffacd0b85a97d-390d4f429ecmr3085236f8f.30.1740589001989; Wed, 26 Feb 2025
 08:56:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107170924.2944681-1-yonghong.song@linux.dev>
In-Reply-To: <20241107170924.2944681-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Feb 2025 08:56:31 -0800
X-Gm-Features: AQ5f1Jr3SGiDBcf_vN7KwM7N1XztPqUzlYfMlJDzXz_sIBSCQDIz4h4V780O9Yw
Message-ID: <CAADnVQ+2PZBDJXKt1q54N8T9-=nr_ZxQ6iqpPvf9f8JBX9v21A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: Document some special sdiv/smod operations
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:09=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Patch [1] fixed possible kernel crash due to specific sdiv/smod operation=
s
> in bpf program. The following are related operations and the expected res=
ults
> of those operations:
>   - LLONG_MIN/-1 =3D LLONG_MIN
>   - INT_MIN/-1 =3D INT_MIN
>   - LLONG_MIN%-1 =3D 0
>   - INT_MIN%-1 =3D 0
>
> Those operations are replaced with codes which won't cause
> kernel crash. This patch documents what operations may cause exception an=
d
> what replacement operations are.
>
>   [1] https://lore.kernel.org/all/20240913150326.1187788-1-yonghong.song@=
linux.dev/
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

More than enough time has passed.
Applied to bpf-next.

