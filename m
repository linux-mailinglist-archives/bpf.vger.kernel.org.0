Return-Path: <bpf+bounces-49311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81460A17548
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A3F1887C28
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 00:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B52D2FB;
	Tue, 21 Jan 2025 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/871EPk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3918A8F58;
	Tue, 21 Jan 2025 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737420206; cv=none; b=NYvJ3gktAncv/G/3NiEk4PXU1Jk2sMqQTut1ySf4pIroYqEpHNOcoje7iA38MZVoO6fDU3JDbB3dDe9V9vDR9YitzY87CW58i5gwkq7dnUV5Bxsel506Si4dvHuxOqh58D0j2gyPNC1FtlTmyjSfnL7EgJi/vQCsSLBF6A2xygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737420206; c=relaxed/simple;
	bh=AAEucaHhq8ErQaw69WnBN+Z1QpR59ldziQoTgbEm+Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6aD31BOdRMprNJgL+cNWpbgs3mEJNobsIMmhBRzhwDk6qGgFOLRzX8oQibv1hJh+FjUcdbwTkfHQZSAv+OjiaAGthPkEpr+9htguT9s/Nwecqp7P+iXa6L0u2zzBlEmDiiy7GI+7bnZG80rAJXqXaGbZ6xt1/RTX9/XPJXb6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/871EPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D49C4CEDD;
	Tue, 21 Jan 2025 00:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737420205;
	bh=AAEucaHhq8ErQaw69WnBN+Z1QpR59ldziQoTgbEm+Ds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F/871EPk4D6Xg8kMgOYP4Uh0E015EXlBfE8aWR4qHpyaOmxYaE9n7cG8pribRAV/L
	 C23IlDOzh4FzQf/XUQkpp/05Cd2To/N3aIci8al3IGHfv4PUGUxRPJpy13PqZC4H8H
	 KSnPo7OdZlmAy7nDNLZoZrovonJEwzhKDGj1up/7gyKMXBlFmfadx6Ia9jWm9k+XSz
	 2uHHx8StDdWR0fITlIuP3iFjHj4Ts3rYWIjxdBnqma1o7aC4nISpVT7YWAejTYG931
	 sLclGqmPTPl6WBRy01Vy/tETSG6b2Zc8zAkqK2toTSDw2r/HgT6yg3+IL+v4aZ/pAH
	 4smugZU2xCxkw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54020b0dcd2so6424975e87.1;
        Mon, 20 Jan 2025 16:43:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhrY6uMS1qv2qRjt+5OHIFyRdWCQ9okOnd/13Nc3imOwCtyWx8yMGp+q2GJ5Sbm3rFQzY=@vger.kernel.org, AJvYcCXVsa9Ztq+3AC3UIbR1RC3PJWvFzhqov+DppI8ypds1AeWTLG+tQCb49TmBH9Kcf4ibo3LlcayAqZIiPyWl@vger.kernel.org
X-Gm-Message-State: AOJu0YyeiysFBmJ6yzayDzGKkZ/6kfCyYrMHZ9sJchsMiP7s/Pu6+/Py
	VGzqRnKgrGyLOkqzUYyyGdCz5+LpyvAI52mSTbnonYZFyA7GZ0vezOFoBPUjSlOA8L9SdYpNsty
	496pxpQRX9lVlOEL1NK1cZPax758=
X-Google-Smtp-Source: AGHT+IGXs6Rmj4lhgJvxHBhU0aRrUWB3soYF5hSkYpcPHu6lF+VXMV9yrdLXZd//DcYCQHxWcd3y0s6RzvGgSI9FU+4=
X-Received: by 2002:a05:6512:1045:b0:542:8a7c:509f with SMTP id
 2adb3069b0e04-542abf503d2mr7758919e87.2.1737420204354; Mon, 20 Jan 2025
 16:43:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120023027.160448-1-jinghao7@illinois.edu>
In-Reply-To: <20250120023027.160448-1-jinghao7@illinois.edu>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 21 Jan 2025 09:42:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNASn2aS6kcOy2Ur=tv_0fuEw8Gv06cVrOJ0x==AD9YRwRg@mail.gmail.com>
X-Gm-Features: AbW1kvYTx7gx3eHLmeWbNwuaSGpO6L12t3mn8MVtOOEdtM_RSEL_7J4XD5HUwgc
Message-ID: <CAK7LNASn2aS6kcOy2Ur=tv_0fuEw8Gv06cVrOJ0x==AD9YRwRg@mail.gmail.com>
Subject: Re: [PATCH bpf] samples/bpf: fix broken vmlinux path for VMLINUX_BTF
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Ruowen Qin <ruqin@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nicolas Schier <n.schier@avm.de>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 11:30=E2=80=AFAM Jinghao Jia <jinghao7@illinois.edu=
> wrote:
>
> Commit 13b25489b6f8 ("kbuild: change working directory to external
> module directory with M=3D") changed kbuild working directory of bpf
> samples to $(srctree)/samples/bpf, which broke the vmlinux path for
> VMLINUX_BTF, as the Makefile assumes the current work directory to be
> $(srctree):
>
>   Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /p=
ath/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like=
 "VMLINUX_BTF=3D/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.
>
> Correctly refer to the kernel source directory using $(srctree).
>
> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module=
 directory with M=3D")
> Tested-by: Ruowen Qin <ruqin@redhat.com>
> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> ---
>  samples/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 96a05e70ace3..f97295724a14 100644
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
> +                    $(abspath $(srctree)/vmlinux)

This is wrong and will not work for O=3D build.

The prefix should be $(objtree)/





>  VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS)))=
)
>
>  $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
> --
> 2.48.1
>


--=20
Best Regards
Masahiro Yamada

