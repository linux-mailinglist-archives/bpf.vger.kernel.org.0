Return-Path: <bpf+bounces-66628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EB2B379A3
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 07:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3850D4600F3
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 05:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2D627E04F;
	Wed, 27 Aug 2025 05:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep/lnniK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615B2773D6;
	Wed, 27 Aug 2025 05:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270958; cv=none; b=X4jnDSYZk1vv9GEKxNTsliyE52aOQRJiel/joASKBU3PyPvG8PLQiSWyjF8PAX/cNUQGZ4npLuzfG69v9qTjybmbkEr5HLl7QobWeddxlwHL64TzvEcVZ8Mgd40GLHAAlalWlH/pOqkbmiPAIzoRjhyHvip4ybMLBnU72souu5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270958; c=relaxed/simple;
	bh=Vcp1XtddgS3TH273PGhGN13goT+ZKlfbI1Ep785Gy/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HboHM8ZEb5UahoHOi3QYyly0j8na2Vlz6/k0RqVAn5h5DuvFhNK81ALcWspfgey94r+ZduBgUp5gD1UNCSMaRs7bCJ5Z2PEkPb4N7L63F7AVo+ZZJHTHwSB3BYSAqvA46ab7tvciesFlQBk9QNgjds2s6DCBL9jcTSbdOjsoiTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep/lnniK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7720c9e2900so29452b3a.0;
        Tue, 26 Aug 2025 22:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756270956; x=1756875756; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LeM+Mpn4EFgQrwxcvuHGdcfY7PFnyH0qkM9NmZextQg=;
        b=ep/lnniKC/DToEErzGojlhcWrVbDoSAKnSpdqDCqgOhHkkI1sj25KK0sMKZDiXIDdW
         xmx0spupDyAEN+n/nvU/KsgOo0MXLS+gb34JvyVrCAP03k4tFm/W3feYsNX3FsGVjrce
         NGsVWG3Q1Bpyo3n3+0YFO9EPYCiMNofzAjQ9RGhiSZzfQBkk2Sp489vfGUrjrsaMe1yY
         mBG+fS44zjnS6a55sBBtb5wga4bQZn54KEN5Xcp5GgfZz+idPkbFYv+9O6jO7mKae3s8
         H2gKYTVWkWwHRSUiZk1hjkJ6SrTmqifIEVJk6/192Kq9+nPF6mfNt2ejHT2U3FXCPvEu
         27SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756270956; x=1756875756;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LeM+Mpn4EFgQrwxcvuHGdcfY7PFnyH0qkM9NmZextQg=;
        b=DNUtXpgwaIDJu15tinSoFNip6IZAdRowgX86794jV7l7CiTYeLfi4F2z2Q/5rNmczF
         WZU7gBlq2kMhMQO73ove75cjUwSqvCYAwx26B6dQlQLYhsq7nlKQVGRhkTLBBD6/DMTT
         faVVLfvdVMxQNg63La7Il8+rYcJ+WiN0T3nCFPw2rd4vp774lXK7tkmMWKS1kIx5+y+y
         qduGhY9nrMS5niU3Ls6dRIi0bn6vjaqyChDcFVFxTZLFiH4On/2/5R5uWPmDH/pT546L
         0q0z2bhQ0fbvU7h9YKZ0dCNMUk06XWl80dJ1vVbBqMYih6aEtbOsJg8FLfw1ZZqTvzAg
         esEg==
X-Forwarded-Encrypted: i=1; AJvYcCW72SqlIeJpptZ8zsfqYlqwT3Z7YLeJQbpsrtxVwwne0qjhHhmEfKdbFFhrqs0FjwmghGM=@vger.kernel.org, AJvYcCWaUK9gWzbsLaSwvRsfbFx60vBDf+cwSRIz75E/Y7FIWBnXYYnUruLOgKlzF4DuUVjFR/8N2q/tTYerYIGm@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTA4BUc/mpV5y+gOOSg/p6PINreLh1H8yL2Zu4TqkwzsfN/Nv
	mIWE2CwvS2HUP0AW2OmBV6N7Ca9TuExU96lezNgLi7+CV3+0WI2CVqIb
X-Gm-Gg: ASbGncu5Hgz2XZirTgT2v+lF4cRAWB+ut2ODuYSEsWDuv7uZ3c6CWK7E7mhTqp5tMVB
	viu0JmyQ+z2V5iP6oLuNiNdkJhuqaYSuNKFT5Zu0g5iiRzCpRoqzM0xhqXxP1LktfBEgBBNBzca
	Y+L8kUTQJKJCTqfwD7naDDFQDdpoCMBMhU3FvuMstzBH9NqXgw6T00tXLxObP9pg/XNHKoidvVn
	79VJSqzeWenTem0RolyHSKQzt3+dvq+8YQ0l0YKEaFolKP03ZX5EqHKJr4ZDUTZWAInXhk65w73
	2EsAd8BpT5QdmLsAQ1ynnd2AkKbKUYH9XGgr0q+pjCws/XPd2/SHcu0SEHoNshDrdP6BNshaOeq
	5i3m6CtmrKU8FFkvx/A==
X-Google-Smtp-Source: AGHT+IFgbIkdhtil0mgw6R2rh7Ryreb1GY780QH8z1fIcOdmxULIk8uFz+LUCp2ratUmymGQSGN/Sw==
X-Received: by 2002:a05:6a00:2991:b0:770:374c:6c60 with SMTP id d2e1a72fcca58-770375bb1b7mr22489863b3a.12.1756270955889;
        Tue, 26 Aug 2025 22:02:35 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffb478asm11863528b3a.13.2025.08.26.22.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 22:02:35 -0700 (PDT)
Message-ID: <45c49b4eedc6038d350f61572e5eed9f183b781b.camel@gmail.com>
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Andrea Righi
 <arighi@nvidia.com>,  Alexei Starovoitov	 <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko	 <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 26 Aug 2025 22:02:31 -0700
In-Reply-To: <86de1bf6-83b0-4d31-904b-95af424a398a@linux.dev>
References: <20250822140553.46273-1-arighi@nvidia.com>
	 <86de1bf6-83b0-4d31-904b-95af424a398a@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-26 at 13:17 -0700, Yonghong Song wrote:

[...]

> I tried with gcc14 and can reproduced the issue described in the above.
> I build the kernel like below with gcc14
>    make KCFLAGS=3D'-O3' -j
> and get the following build error
>    WARN: resolve_btfids: unresolved symbol bpf_strnchr
>    make[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:91: vml=
inux] Error 255
>    make[2]: *** Deleting file 'vmlinux'
> Checking the symbol table:
>     22276: ffffffff81b15260   249 FUNC    LOCAL  DEFAULT    1 bpf_strnchr=
.cons[...]
>    235128: ffffffff81b1f540   296 FUNC    GLOBAL DEFAULT    1 bpf_strnchr
> and the disasm code:
>    bpf_strnchr:
>      ...
>=20
>    bpf_strchr:
>      ...
>      bpf_strnchr.constprop.0
>      ...
>=20
> So in symbol table, we have both bpf_strnchr.constprop.0 and bpf_strnchr.
> For such case, pahole will skip func bpf_strnchr hence the above resolve_=
btfids
> failure.
>=20
> The solution in this patch can indeed resolve this issue.

It looks like instead of adding __noclone there is an option to
improve pahole's filtering of ambiguous functions.
Abstractly, there is nothing wrong with having a clone of a global
function that has undergone additional optimizations. As long as the
original symbol exists, everything should be fine.

Since kfuncs are global, this should guarantee that the compiler does not
change their signature, correct? Does this also hold for LTO builds?
If so, when pahole sees a set of symbols like [foo, foo.1, foo.2, ...],
with 'foo' being global and the rest local, then there is no real need
to filter out 'foo'.

Wdyt?

[...]

