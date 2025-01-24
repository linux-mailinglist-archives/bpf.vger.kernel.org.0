Return-Path: <bpf+bounces-49700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BEEA1BC73
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 19:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A81A18919DD
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 18:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA53224AE0;
	Fri, 24 Jan 2025 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcsSTSh8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470662248A6;
	Fri, 24 Jan 2025 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744598; cv=none; b=oM+v8JzIAACtN+jSqgkMWvORUBFB6sW2OGsYOcXcF7H9JQJIaB/eL81Qeodn4fYx8oi1L2R+8i6gdenJDkoRWSWgLDwpessKAfqVehos/8fTsBcWjVP3me8nZ92Q2MEma4TD5LOJlEkrzFaI2ROtOg0cJgb824G9Fl9XYdsksRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744598; c=relaxed/simple;
	bh=NJp7oppR92Hw0tt0fW3Iu+BgiNht7BrqXdHjJ8WVL/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIOr+hieK+TCQ8T2stqyctAJvD3janxBwF6WiFjl5ts4x55AMHJUxkMD91TkBTh3wGR0O+7Ho65vcCbxqcsaNQ8Mc3Eu3OtEIjbXBz9O9+4XONYjI77UrFQvlCZAWoHxMQgFnQe78zh582NU9U8fV/Ymf+h1y3P9saBJGB/nTJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcsSTSh8; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so4593183a91.0;
        Fri, 24 Jan 2025 10:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737744596; x=1738349396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3N5MaD45vyaWe371aHjK3064JqExmCzhOIvGa1SSHE=;
        b=dcsSTSh8D/5IZdNsWrSKUBQmmT1qj0ztmJpfdzb23G8jXi0pQX1RJwnwGBn8ZV1hI6
         M2Q7VSHPK0Dm5xdx8OMKj9Nx0ccnphLkXEWJ/FU0ZhSJcf++evJ1LnlplXbQGNY8OIMJ
         HQhoe3gRaHJYM8NbFuxCkd9o8hEo096IPoCE6rLipyRW17hHaFHicRAW8jSUIOlOvLBk
         6kGBZKl6dEAaFyVNpLBZiDiWtYYTcelHsfhhWn8k5jg5iVfOBfuydnEE57fzHRz1IIT8
         0tGJ+q/NO20lrIN5TM2Otg1mBJY2yPmVPElThRi12wdTq8pnGtcst9G3n9hMa5tYHCTd
         6Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737744596; x=1738349396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3N5MaD45vyaWe371aHjK3064JqExmCzhOIvGa1SSHE=;
        b=oLJcnIFBFGUh7GQSMNERpWzRJhUmWkMwNwu+gyZ8eSf5GraaWi3QdjIOlFrHwaQjCI
         ibktQb8lDFcvzJiI3mVSGICuIkajR3Z3KX1aHYVn7k3OBsrrN5bAQl9JS5+jBX1cmjCH
         OcyGDRIJ5WXdgNk/QY6jTMSIHdvCEyZ3LLK1F8dNVD3MFkah/k+YJDJ3pGJHD8aySmp7
         otWVy75bjFJ2AYcsq4EALCmtxzR4+yTltepG8V5Rcaed8B838SRzpi5KprGA+zfpkkBI
         tP3h+6tNyOyttPKo4B0m1ZnvluCcBsIdBgQkCEomA+Aw48CiKzEuuHfIFZvGxGJUHNHH
         3ckA==
X-Forwarded-Encrypted: i=1; AJvYcCVe2nx0VnuRPmeeQqe3hZo3UKmpU4WtgzFiOulasZUpfhDNI94iQqB8W8zY9mDl6W8JxN3F6VYaXpyDwwA=@vger.kernel.org, AJvYcCXNRfMh1rucOJGglQWpVAntSVvc5vOdl4v/Q7iPkGLinoALJMqAtEyIbwCeHSXYwd++TxnnyMtF9b8t9kCO@vger.kernel.org, AJvYcCXutsrFqrA6ddVDHFY6uDPNPDkgCXyj+VMRpmErCkuetGzL9gBPl8AEOA1+c0NW98cEvbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynDtqRtD8yK6CmcfQcN+0tUzA5ryDn7HHMspl9tHFRNi5BCRvX
	4R/2k3TNA7Vj1KYM6QYRqtv9o7xUS+po4bbZ/3Lu7bu3NTYKKtNGeOqdUhOABaMtTMh0G5WXXXw
	VhYqse+N584l4MYzniuc3YSLTiLc=
X-Gm-Gg: ASbGncs3Ucldkvnm5ZJla2mDSSxexBOP/XJCLZue9mihjUztAPP0nd98KZBOvXcXGEq
	83Bqhl2uPPka29ex5pTxAY6eIlrvdn173EaA4ntil7sH4dp7MMEAhp7ey6C9sOwTpsNYPhz9wXI
	reWA==
X-Google-Smtp-Source: AGHT+IGqebUMLn3/ncB1bXCStDidt/IoIH5WPjnwOE5yBk3mNQWW10AFyZhS0gMVsKwbt88mpDOsXz86ti/CtPbtBF0=
X-Received: by 2002:a05:6a00:2d19:b0:725:ffe:4dae with SMTP id
 d2e1a72fcca58-72dafa44ce7mr40749819b3a.10.1737744596350; Fri, 24 Jan 2025
 10:49:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123081950.173588-1-jinghao7@illinois.edu> <20250123081950.173588-3-jinghao7@illinois.edu>
In-Reply-To: <20250123081950.173588-3-jinghao7@illinois.edu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Jan 2025 10:49:44 -0800
X-Gm-Features: AWEUYZmBWXh_2JOTCjNCZfyviZZ9xUcNVQPe8HmE9P3d6HoLbmQ36dhDufGPkRU
Message-ID: <CAEf4BzbCm4=NLV4DOyRxvxEtZUONzqmXBOFMp5cg=4hPEEYUtA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] samples/{bpf,hid}: fix broken vmlinux path for VMLINUX_BTF
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

On Thu, Jan 23, 2025 at 12:20=E2=80=AFAM Jinghao Jia <jinghao7@illinois.edu=
> wrote:
>
> Commit 13b25489b6f8 ("kbuild: change working directory to external
> module directory with M=3D") changed kbuild working directory of bpf and
> hid samples to samples/{bpf,hid}, which broke the vmlinux path for
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
>  samples/hid/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

can you please split samples/bpf from samples/hid changes, so we can
land samples/bpf fix through bpf-next tree independently from other
changes?

pw-bot: cr

> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 96a05e70ace3..f5865fbbae62 100644
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
> diff --git a/samples/hid/Makefile b/samples/hid/Makefile
> index 69159c81d045..db5a077c77fc 100644
> --- a/samples/hid/Makefile
> +++ b/samples/hid/Makefile
> @@ -164,7 +164,7 @@ $(obj)/hid_surface_dial.o: $(obj)/hid_surface_dial.sk=
el.h
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

