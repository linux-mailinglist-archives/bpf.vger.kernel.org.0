Return-Path: <bpf+bounces-50581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A31A29E19
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CDBA7A336E
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 00:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA08C1F95C;
	Thu,  6 Feb 2025 00:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feM0neWn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF962B9A5;
	Thu,  6 Feb 2025 00:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738803286; cv=none; b=qJ3RJbhieJXkntQCjYBcKhYY6SpWLBY7OxiCpKl4LsZQGcywsY7/J5VU08pxn0NCK+BaInnkc7sBd/jqQWUdkpbZXs8C9fTck4mes/oRZtTzWBu0Ts6QPAbSr3Cj88jgUQ6sMVZfVfdfgn+qUe8vmMbv+LJW6HePiYhURHJijCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738803286; c=relaxed/simple;
	bh=VpisVvIMFoCftNCpHixMUVnakOhW9UvSb7HD4i6fCr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R70cbCn9Cn85xju+WCBRnwlDAMg6KV1sY/f3mmMy2nFrn67mkdvsPx7eR2FfqRrXiODn1a7fqL8OOMU8GoU5pIOyAey3Onv6elyvI3tIyBQGgdXf0m6ADtMQCzsVNm3TOJTn0tUM3Wr3+OlAPXijE8BkvfkLbm5vrnnrjkOQpD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feM0neWn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f9c3ef6849so572327a91.3;
        Wed, 05 Feb 2025 16:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738803284; x=1739408084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxpOkZOkCuxEBr8nyhrAOoznPB66YiDk0UNNr5Nt7mY=;
        b=feM0neWnyAZSG6Exg8bNs5GjbzOjZl1EcUHN+a5f89waac2EwYG22p0Q0UMzuB7Ktv
         LaVfA13dFtbTXJ1UHIOw/pwG63x8+3S9Yr+evSNXNtgaSxQ6fZVO/bsrTSQDWn+l6yP2
         ToMJsCJLOOZThJ32kAQ02lY/NKsib3gxCunhcDofwE69+NU+RZmFqGkx6iy6G4bRKH6g
         KkIs/Z6Mu0raDxTAItuuZaOoVaNbLVwOMWZZea7ldxVD9AbIv1XGpyltPBqxGGXvPMh0
         jvdnMkrDc5nO78VSN0QQtuUR9rKyT27Xek8ZAxwGlHtSdv6mOP0iPWQYaZ4AFcYpgRsL
         Vbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738803284; x=1739408084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxpOkZOkCuxEBr8nyhrAOoznPB66YiDk0UNNr5Nt7mY=;
        b=jkh+C2/3mYwcYTb9BrIJhHC+EWW8ZyAKG7CTl23MuLcbbbLSBb0+MZSKevvIrgKS8l
         mMLwwp63cUOtR4CRu44fUUG2p3jUyYp2vXyA9qydXlvIpFQ2Vy4KiIr+YVtYSttid6t6
         gc2ixQ2965egP+LVU8wfARKzQmmPu9JJ8FSg3wrKT88DwOcgMBxQ0ykfs4clL5YT+/mV
         /Bn6/DN8WqSLUtf4KIa+7RzinrlUYpgdcJmUeVyNWRHnPKHmW+feYqioTO3hJhKRqwd4
         bjG+jgHbVZyQRCw0Nrc+IDWy4fWEKEDLHIJksMBuz+6QmKhqr5YR4yt+zxzdVvPIrJZj
         IXiw==
X-Forwarded-Encrypted: i=1; AJvYcCUq4876JJomk7eMZVRY+O4wp4eVxOqJUdjXxveJyBJXq6t5E1X9QoAXbmPCaq4WCok6HzI=@vger.kernel.org, AJvYcCVRxjUM820pQ1rr0joBLtbUYntYqG/CdAdAmzHb+g9tzPR5hLQXA+wQpsP0IQiSQjrFWVN6Ph7dsf7s27M=@vger.kernel.org, AJvYcCWqsIlwB9Szfn1nKYM89X7j1vHux/dT4e2AHXm8Q6njvnvnabLnqwUAmkIjY50K9BO5jbscmTkAeRuPMTaq@vger.kernel.org
X-Gm-Message-State: AOJu0YwtWX/lB2JEJ9Ch9dmfHgH3ngebmt8dsCGmJJyurJz38uqMCrLs
	VA+WyLhb7ooQhvQp1ye1gjiAOuFVj9vgo9hdDl/4X7CAdhlhV3eM2vjCxfFkgku/JfVa80KNRN9
	Rh3ZkJxqMmWCqWRJ5hVIPmXAuyLhFOw==
X-Gm-Gg: ASbGncv00k1Qyp1dq69WWaTvuEDHICTNCPiXLH15sQvZCwhsRz7c/9TS+1yK3vVya3C
	SVpv++PUyljpZfucvfnuIe6eVT/B1wnVmP2DG9wZPysSBdWNKNZxFF3F14TVCzjz5cxBbgNKYNX
	DQsEjTyUDnz9g8
X-Google-Smtp-Source: AGHT+IFSLoc2DjjMKHytTrp0lZD2pPvYLRfUG7/NwwKFLJlmv6yD4/JsCoZrywCy9NBhx0rx9hBy/Qwjoa2ZPDm7Q+0=
X-Received: by 2002:a05:6a00:aa05:b0:72a:a7a4:9c6d with SMTP id
 d2e1a72fcca58-7303521c70amr9373134b3a.24.1738803283983; Wed, 05 Feb 2025
 16:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203085506.220297-1-jinghao7@illinois.edu> <20250203085506.220297-3-jinghao7@illinois.edu>
In-Reply-To: <20250203085506.220297-3-jinghao7@illinois.edu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Feb 2025 16:54:29 -0800
X-Gm-Features: AWEUYZkOyXdnPrFYjkSJbomR9axi8zEcr4MqtCizAMblOi7zjWCfxqJ5_35asJU
Message-ID: <CAEf4BzY7yML7=C8Z+T8_RdzZt1Ab+rwK0g7b0GKf99T-uaGpxQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] samples/bpf: fix broken vmlinux path for VMLINUX_BTF
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicolas Schier <n.schier@avm.de>, Ruowen Qin <ruqin@redhat.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 12:55=E2=80=AFAM Jinghao Jia <jinghao7@illinois.edu>=
 wrote:
>
> Commit 13b25489b6f8 ("kbuild: change working directory to external
> module directory with M=3D") changed kbuild working directory of bpf
> sample programs to samples/bpf, which broke the vmlinux path for
> VMLINUX_BTF, as the Makefiles assume the current work directory to be
> the kernel output directory and use a relative path (i.e., ./vmlinux):
>
>   Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /p=
ath/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like=
 "VMLINUX_BTF=3D/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.
>
> Correctly refer to the kernel output directory using $(objtree).
>
> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module=
 directory with M=3D")
> Tested-by: Ruowen Qin <ruqin@redhat.com>
> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> ---
>  samples/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Applied this patch to bpf-next. I presume HID ones will go through the
respective tree. Thanks!

> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index dd9944a97b7e..5b632635e00d 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -307,7 +307,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS :=3D $(TPROGS_=
CFLAGS) -D__must_check=3D
>
>  VMLINUX_BTF_PATHS ?=3D $(abspath $(if $(O),$(O)/vmlinux))               =
                 \
>                      $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vml=
inux)) \
> -                    $(abspath ./vmlinux)
> +                    $(abspath $(objtree)/vmlinux)
>  VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS)))=
)
>
>  $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
> --
> 2.48.1
>

