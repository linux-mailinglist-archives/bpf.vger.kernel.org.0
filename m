Return-Path: <bpf+bounces-49186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 024ACA14F84
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 13:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1C7188B94F
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9873F1FF5EF;
	Fri, 17 Jan 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJMM21QM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A99B1FF1D9
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117837; cv=none; b=jpBSvz+oq1boBOBvbGRZXJyp7xwdCd/lx3knH0Y3JKwuiHibq5Fs/y1qeuXSJTFPUm8r+wmPaxuFCi05UdDrhO9bpknr/CGKpU9XL/BGawqmKRCT3rwAi5UTbIc4mHP0zJZ8qkKzHdTZzEqYXQDUid5WK4wK6l7whXt1ltSLegY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117837; c=relaxed/simple;
	bh=+zykB88dG5lsQpKBJ0HHZ+LIhLvermH0yDY5HlcO3hc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oCiuFwQcOS75QML7/Ph04kTTTj9Fk0BeWnouyCrL1q9VS0DPuznM5S9tEaGGtfoZXPdW7w1iPpipd5/VfA0rQwNCY8GxNQbx13DtyIDBZErDI8BBZo5fhyz3XF9l2qtrsyDbBvlFjE1yCZS4HodbYGs5vIyUehsPHTHaeGW2Dhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJMM21QM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737117834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zykB88dG5lsQpKBJ0HHZ+LIhLvermH0yDY5HlcO3hc=;
	b=FJMM21QMUxnwSXJ+jmVcnq8yrHGx80zF2hhoYJpe0B2M+KSS6hqB6wAfKfoCJ60QZW89hW
	0IxqoMujuRd9UKzbaCO1gEgFmgoqF3WrMXJRhvu8kpG5eR9OTFYqntSzgTtiFhjIdZLtLJ
	lpXhhnq9QQj+RGcp9ZVM97lW7/Eu9GI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-mWnLR26BNM6iHArFw6rcsA-1; Fri, 17 Jan 2025 07:43:53 -0500
X-MC-Unique: mWnLR26BNM6iHArFw6rcsA-1
X-Mimecast-MFC-AGG-ID: mWnLR26BNM6iHArFw6rcsA
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d3f01eeef8so1930217a12.0
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 04:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737117832; x=1737722632;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zykB88dG5lsQpKBJ0HHZ+LIhLvermH0yDY5HlcO3hc=;
        b=N3mfkO6tcVbIjNs8TbNVvl2jw9z5G9BM8UrrFrnTUb8RjdKHVElyfr4W8XqEWmZfn0
         OAOA1DKSg3l3Z+WK1LyYq1lhws6Kzcavu8/YDnUAcBlogLGFCtal6fuAvXqRdA2nw28Q
         Ty7fu9UBkd5kaOSRepj6ZyRh8f5JryPDxWIBvCLvFelVSBKxIq0DrdAN/kPGv04pBpIc
         9XsJkRA8pgbTfoMVTIFPDebnK1/Razyd4op06i9unj8clyFHy/vrvxDYUXO5rctw64ET
         krcgM+EDB47ngGJWbycDBuyvgaJY9OoikLucYvijLftQOJXr8zgDGP+PM4TXTJVHw+U3
         yhrw==
X-Forwarded-Encrypted: i=1; AJvYcCUdWu0Tu8NKFDtVeQBbQWLMxIJKOB6gFIVsi4k5nXNgMHxaMIlvemRcrVhINmhq3naLWKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVPH7u0mS71SE4yjpoDShmlmlXYQb1gquahBz1D0eKJRn2+WHd
	20IhZ3rQMmXkv2Kozoq50Ae8NiBOVFUvNVO9X8z4CfXhbDXCxtCYhdp3qcqt9Jgw1hD9d8XJ/4a
	DZFOkvMiuOyErXIs/i9eP8csvbd7iRDxxghnsN3yrMsFiJnX6Eg==
X-Gm-Gg: ASbGncvzUi+nUdTm+Tw8SJGERE7sUGzP89bXekOwlnZfVB/dtRTaV9Egxa3ERhE37Zu
	Gkdggnyvso40gtBn+BKKM6gpzHhHLM3uwZKGO1wd27t5ro6ao1NZJN1/jP8rGVolHhhZa4QkRui
	dxHLi9eZCY+RduoZmVNRLyc3YVHO6xkZKi62Wpnx4X1xXGrtQ65dNiQgJejTmzGoWfmP2BenaFk
	tx+8XianPQ+MBSPEujPnKniyHVeRFqSI5qXwVh2Kq3iOcwRjSiFwaU1MrAU8FOpW4VG0oQhnmPA
	o8/wpA==
X-Received: by 2002:a05:6402:518a:b0:5d3:ba42:e9e3 with SMTP id 4fb4d7f45d1cf-5db7d2f5ec0mr5872113a12.13.1737117832333;
        Fri, 17 Jan 2025 04:43:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLlw+tf9R7HynsAHI9siG0tNAf70xgcN7yQ8QdeHS81e7hKnmmBmhhrwwYWsYR/zzg31juZQ==
X-Received: by 2002:a05:6402:518a:b0:5d3:ba42:e9e3 with SMTP id 4fb4d7f45d1cf-5db7d2f5ec0mr5872062a12.13.1737117831977;
        Fri, 17 Jan 2025 04:43:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73eb5b9bsm1406605a12.55.2025.01.17.04.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:43:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 44F1617E7868; Fri, 17 Jan 2025 13:43:49 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] net: gro: expose GRO init/cleanup to
 use outside of NAPI
In-Reply-To: <20250115151901.2063909-3-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-3-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:43:49 +0100
Message-ID: <87frlhobju.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Make GRO init and cleanup functions global to be able to use GRO
> without a NAPI instance. Taking into account already global gro_flush(),
> it's now fully usable standalone.
> New functions are not exported, since they're not supposed to be used
> outside of the kernel core code.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


