Return-Path: <bpf+bounces-58735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9636EAC1086
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 17:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D12750160F
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 15:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB6B28DB74;
	Thu, 22 May 2025 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9JHNlfB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EB9286D65
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929436; cv=none; b=Omfrp5A8p9d25n8q73iYn05/6/IT+PsYPvnK9bxN98KYcTsOw6bxz1LQ6SkEB4LFrXl3Q9qTRQTdproU0BgdGSAZM+dY3mpBYQDxAKJM41xvWsrL6JrkGRNga3vIQwiH5isQ5hGWC/OIpS+uJsVeEwTrcOEjPQ2zBgzx6eeQE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929436; c=relaxed/simple;
	bh=7UhZDnsojLr+fZGqu0PCL8SDDPtyRZiusCg+sQz4Zfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJLlaHDXsjCKyc5AuyJU8+LBJkvhDnvexAPqrbVvEzFc6d1b6y9nu+QxNI4ZB4tejwansF5zLGQhMiVkmQ+DhXeHrzSBDSm4mczpJKOuFYzhxJT+epfypwaDaX8fHsdpDa7Me2O5FJm9dOMP/0kuG+9637OqZgFLqXhPrfnuOSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9JHNlfB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ede096d73so60821045e9.2
        for <bpf@vger.kernel.org>; Thu, 22 May 2025 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747929433; x=1748534233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UhZDnsojLr+fZGqu0PCL8SDDPtyRZiusCg+sQz4Zfw=;
        b=d9JHNlfBClVf48sJebbV0e+9XBU3LV3shGiTQXaQ3QVRKcCBQWqgIzZW2CsCQIOSdB
         vwvNXYtIWZZHIKhuNQrdZPHpHnPebljwgdcdHbHrGvnCBTQvISH893JVIuBImuBhN/1J
         UiSpQSjR1DeH/ZeNtJIi1ESyzq6x22pkFIZjxSJ/sDZOg62Ipe+XL/kP0hmpDOhFOzyw
         EBD+8lAbHlaQCbXtEuXjuInV2ao+ndmVOFmj03RurPwnlZr7EAf0OocXS2wXuusmRCf9
         ecMwHjnj3nQ2lf9LpcDxIgDflGJpae6xUOg0x61RvdcHBctAuKoLKI6M7TARBjLj9qco
         4UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747929433; x=1748534233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UhZDnsojLr+fZGqu0PCL8SDDPtyRZiusCg+sQz4Zfw=;
        b=mkLxeaz7OXh8UCQ2qFhZX34JjvhRBaDFUL6bpzP3aKlhZyxgjLTtfa2aH2ZI03RIly
         H3cDvbrKOp4GlB1YfIxiM3ZFK5o4py5OeOdiDQG9Kg730heKq2wiQ+AfbXRvEIIGgM2s
         nNOgxIsrUyBXosh6HEBNaOqEYdE4Rxbry9ZAGQLnJhpWvRwYk7pe0hE35UeWL/35ZtKX
         XekuG4NXLFtveQ/Fcw/YkMkm7zk1KTM7Sl79PQUvVsRziSoB16el/rUUP7qJ66xMLwtJ
         BzQv5nMxUxciy+y/5vWTunt/UTEODQ/3qgVOEyFbP8Kuj+4yqqk7NYjKEoDxHLzUPVeo
         g8Qg==
X-Gm-Message-State: AOJu0YwAZheN3mikz+FnHU63Mop9AtPXUuUxqp1xrkrBjswIg05jlqw2
	K+DZDL9p1eFcJg+cU+4pRwCBCzkROO7xwVMbHa85Oh+Mx/Jjaj40cfuL8S8295HJ/oQrtCE/3CO
	5rGcKxcYNTFmdj4wWYW9LNuz+QpOAit5qPA==
X-Gm-Gg: ASbGnctDYiqyLEcgjLSzGEOuQoeHgeSbJjkbdVDkHYrh+w4LsTG6UTfF7E9ws3GWv+2
	iJ9b+1nYdiVs3oY8KypFK9uAur87Y4vWRl1OsFcUzrmlu5nZxqX2LKZzIA+lW9CDOg6ohUe9Hoh
	D9tfnEaZlR8PwtVSC+atqFODInHvIMg7IvJwn+KspHpvrDP1csqITEN9MRLWhltA==
X-Google-Smtp-Source: AGHT+IGgw/YRqGqx5u8glLXh+8xFkAcwjWrsoHaZ2C+E9Y+Fah20eOMN7LXxikaFy4zBfA6ot8PLEK3xTMTseoDFLmc=
X-Received: by 2002:a05:600c:83c5:b0:439:86fb:7340 with SMTP id
 5b1f17b1804b1-442fd67515emr286362815e9.30.1747929432577; Thu, 22 May 2025
 08:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521032047.1015381-1-yonghong.song@linux.dev> <20250521032057.1016838-1-yonghong.song@linux.dev>
In-Reply-To: <20250521032057.1016838-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 May 2025 08:57:01 -0700
X-Gm-Features: AX0GCFuaOXh4CZmeCvFkZd0855IV7ycJrGWqrw8XQlPfQxdNGpIj6kAQCZmMYSU
Message-ID: <CAADnVQJ+eQuhLAy0SYUp67U-pU_Bdf3-Jyy0PAnpfko3qcTKTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Warn with bpf_unreachable() kfunc
 maybe due to uninitialized variable
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 8:21=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> +__bpf_kfunc void bpf_unreachable(void)
> +{
> +}
> +

Eduard made a good point on LLVM diff that
reserved functions have to start with double underscore.

