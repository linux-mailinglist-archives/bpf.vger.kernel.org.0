Return-Path: <bpf+bounces-77063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F47CCDFF5
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46BED302038B
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 23:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6A826ED4A;
	Thu, 18 Dec 2025 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqBqzLtU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3974D15ECD7
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766101607; cv=none; b=Je/zI5fbVxInvfuruTCO2Y8WYll6S3b7IN13uI/D7CzTcCiJD57RtxPUu+984SEyE/xaILaOeZJVmYWpubATiveQg+aShecsYxT01aScR3PrkbqnMTNCAXJB+NIt4mpnqv3PnxT8ATWGS8H78aBVfkxCxtqdvRxelASnZTEHFZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766101607; c=relaxed/simple;
	bh=r/qmsINSaXxEk9giUZs9XHwVC2SubTd6Wn09hm8SifI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNnSpVyBc71lM+FYm+dTVqZC4jsD5S4KMtHF98QGQnNu+I/+sGJzoqOGzOzBcz536X+0c1/76RyFdlWN3GjcpDRjSqEknwQ4dEwut6DSNiMxDsWYABtg6qsX+aXdNWxyyowum26mbaTH3qd++DoGqMk/1Vt8ncoHZyzFs3oe0jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqBqzLtU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bfb84c2fe5eso486890a12.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 15:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766101605; x=1766706405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjnykRVpk681XDZP1aSCkFEo1PMad3vfCPQ+zI/qcDA=;
        b=VqBqzLtUEj08cx6sP8l2ScJlrlza9u6KhrQ/Y9BdbunQModW3W9tU/Zq6P5WDyqThj
         DcgAKxgW7mBXWW1bdXUO5co39MvfmmdPmPJMOfkWOpvVxXmFRzI137rV8QN2wBrqT9bU
         r8wB2Crs43vK/raVACiQ7xIu3BkasKKzs8gPffeaiqpeWa+jlSyypyfLH1xkZUh8ORvy
         WH/Pg3y16nzT2O6kX8VopNj4LHHC/QnUvfCMC+EMBPnNPBaxw0kHHlhsw0/FG7RGbwa3
         CaevRnvUlHm/FmVOzKws/jthhMVxHNbyXe9rfb/H5bVhpigh0XSglxw2Y10/b9KrQet9
         yzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766101605; x=1766706405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bjnykRVpk681XDZP1aSCkFEo1PMad3vfCPQ+zI/qcDA=;
        b=UYqW4VF8/Q9cFGbwKTg9ZZUwAbfaCzs1wqfaDeWXLTi5zdNVwuV5swaA2PNLAH8oFw
         sCCCqkTBG6IAezJEE6x1wosAYa0sy4l5qa66tGM6bpM0qAZgDedlp5nyOyidT8Q8wXDI
         VuvDbjqWwHwVvf9XJcPizqHxByaIpwtmMny8gYg9xKaO5w0AA6XGj4hsoUBC28cgu67W
         Gfl4OC2rvLwZO6aKPBRxZZr7JmtJJFIfGjOX5+qNCdtZZUmnJ4QeQgqbTkmg8qhB5Tn/
         /5TW6XMQTrkpRXS0Tlr3cEebIzVosQTIvW67ZhD/t8YZqyeK2MIb/bszpTduOWl1/zGO
         Ms9A==
X-Forwarded-Encrypted: i=1; AJvYcCXWca44+PX/2hOLBkfCu4IrhB+lHI1RwBUbDWPD3HQSftPA5NKXDTVFspufDK+F3Rg5nt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrs3Drg1a1EV7pQIjDyriSqXmoxxFCOy7wF4A2T63MSKHqj/89
	VihQrShMWhdbSwD5Jmspjajf45aD//P8y3eNU3EG89WArEPZQ/H645pVVyse95HsZDpJHDMeTtT
	jDaBb0pn1cAaZiJHRVAt3jPtcSuxAnZs=
X-Gm-Gg: AY/fxX5GaNbzpd3l5le+EmJLg/ob1wnC5cu3N/TrHTQIrEjuF6rSU2uwXvumm73Dobv
	j0e6jqsiU+uNHOBzf8eIH+gNkAde+tDBFSWbVPcjNDXVUL5mAqo4vcqNzhxlRFdPWd9NgSvyXEm
	+5kNSBxcXNHiWqbxP0WdjrIYLw4QeWzOtdR23xKQPi/en+OkHXKyHjcK15T97aHhC6QPDG2p6oR
	eXsgmG784keEfLl04QLz0+3RQYkDP0rQ1xqjCdrH5d0SSvB8dNpaLGD2NDDHgGY5kYFTMYJZeoU
	QhJACf4YcgI=
X-Google-Smtp-Source: AGHT+IGpASpuSAB4fQAdQUWZzlTS/T6XKXVDdb3tBu1WPsM+jRLS3Ze2y7izGIOlIWo204XD6CyOosXzS0yKhVNc3ns=
X-Received: by 2002:a17:90b:2d50:b0:343:43bf:bcd7 with SMTP id
 98e67ed59e1d1-34e90de0291mr971327a91.13.1766101605494; Thu, 18 Dec 2025
 15:46:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com> <20251218113051.455293-8-dolinux.peng@gmail.com>
In-Reply-To: <20251218113051.455293-8-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 15:46:33 -0800
X-Gm-Features: AQt7F2r9UoKXfexr61MMlNmFSM8ttUY3ZXMcVLdpENTmbwvw1sqva_fSJgPWcic
Message-ID: <CAEf4BzZopn6gi=xf-OakYZtyv5bMy9HojSfvGznv1RiOcF5sew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 07/13] btf: Verify BTF Sorting
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> This patch checks whether the BTF is sorted by name in ascending order.
> If sorted, binary search will be used when looking up types.
>
> Specifically, vmlinux and kernel module BTFs are always sorted during
> the build phase with anonymous types placed before named types, so we
> only need to identify the starting ID of named types.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  kernel/bpf/btf.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>

please make sure to apply feedback received for libbpf-side
implementation for kernel-side implementations as well

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0394f0c8ef74..a9e2345558c0 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -550,6 +550,60 @@ u32 btf_nr_types(const struct btf *btf)
>         return total;
>  }
>

[...]

