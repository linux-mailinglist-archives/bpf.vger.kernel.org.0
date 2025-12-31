Return-Path: <bpf+bounces-77599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43068CEC52A
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B6353012BDE
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA0329BD87;
	Wed, 31 Dec 2025 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzIRqTTC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD3284883
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767200876; cv=none; b=TJWznaGba7FVqV0AimJnOYk4onKTunkyI8WCr+J5hKHFdTnd+aOUAGRChIJLQEQlj0PTcHUTWZH890ZT2lWkJpmYyFNDqW/371fQN5Jw/1e1XP/oAni1XoXkTxEv+MDlpDUlIBWWrRTfcMqvBywUgolEbuvfZO9Y1MK/brQzntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767200876; c=relaxed/simple;
	bh=iz/UUlvU1upnV3KH0c/iPCBatJHmNiwakC/d+LY3L/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTBybEr9TeCirp5ymZov/UOTpQ2LBdaDlhPiN+Z59w/gnZo0kJauNH4DTJY53tUUQAdT7Iaw14vItSJPBJSw2X8qbeFQIAxFgZR45rIEX5TaGS79MXEtUHsJ+7w+r8cW5W364qyR++lClodLwLho3fvmK+OWU2rIFSTzkzjC2pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzIRqTTC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso6570587f8f.2
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 09:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767200871; x=1767805671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLSVM7oT2x+mygqgfjoFl6JBKT9XHb0lY82HBBdL4IY=;
        b=jzIRqTTCVdhEKKNGlwCIi+eUIBVfhK9wcYFD5AVOC3i6TjURwa50tigvn8003guT/U
         RaxPVxFlVmHkTjnrUpdkrEz81IU54zhBKM6Ck45bK0QpjBhVTjYHGzrT6mcwDrVhxnIi
         aMrUkv6HUdPmeE1aOUHUGCWQnTi4nZRJvVnN09seE+0QcGovDhypePzbUy6RZVA9qvXr
         nn1uejQpafAjJwU77KrGgEOGTPYbtDdlxw3f8GzyS8aUZVQMuqYh3ejuYd/HU9CXlNco
         ITTH4i0ghIfeDBgGm0wxQj6+M+TGN4AXLlLmvx6uzFweclgEZURDpGNN2m3eTAYq91LW
         jh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767200871; x=1767805671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jLSVM7oT2x+mygqgfjoFl6JBKT9XHb0lY82HBBdL4IY=;
        b=gvpEwCM+Aj01LON00J23XrOB6w8H60tLBQd8WzNgeiUQ6KCCG5q/ii6zdOnLoYgVZt
         OiTu3obGgMPscPMW7VHSCXyUnBR0r5BVoRFT+5Y/uBC+Psjd0zocTEbiPupQVPNYlBmy
         QuhpgZSFaHtoI6tR0r5shUYiY/fQRHKIRlzMbfVd/ksxcV4OVnpwALqVMfdYE2FHcnBn
         NA7rYriIA1Nci8tBQigTU8YRhYwVsQqzjPoM3f2ANvS26pFwoiVjoK3JGE//+K6rrzTK
         9Hp+ezG9EzQvXozovd53LddCmmOM0Pqea82PZ36e4ALIsjTvMgbOWffut/xROxAA9ieo
         AV2w==
X-Forwarded-Encrypted: i=1; AJvYcCVLTDqAIqHQ3Tu6oiMh3ZuSGxPJVCqxIx+7BgrQEvQ+HNaFQRIwOajIrUEW7WamqKg+iIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Px9p+Fi9ybbQysis4F2pOvHauQd1jgiTKKOBac3iVpZZxfGz
	N6oON2ouBfu3HGT2shrG8z3rvxqJpi+Lb3r4Z6DP5WFttqEgYSlPgtgNJS6+u8x7KyBcBrm1aLC
	KSe63ffMfdzX/JtPrdGaoDUoPcJ5ZjEo=
X-Gm-Gg: AY/fxX5b3MBWEE7GV2R6fyPULHdrs5uizbjjQlbDrSHdF4BWK3RyVD0rB6LiB2bqLAG
	F7XuPz4/jznLi6KKxRHmzcH+EHmv19uZuSkR3JpTyPO4SkW5q0hdrzTRqWqCwWflh6Qs9/H1IqI
	+kZfHC+0dfAnFxaulQ+V25m7XmCQQEhNkdZ3IDgkCSXnQ/kksmt5HLlJ6R5NHBpRhHDALaiec/O
	N7qVUG+Mkori5f80y4ZyeT7XMomsXOjijEaaF2TwZ4HdiAtwE1yv1wQH2Qi37b4b2j5j5fLcUAG
	WXrH5NwKJQwNHuPdzyK4vV/O82kc
X-Google-Smtp-Source: AGHT+IEkhAN3JBU8zznfxeuU4iqR4nG6AkymGS0XQpDyuqMfnwRYOj7A11/R/1jpmMlTRsWkkib46OaiAjAonYbdyx4=
X-Received: by 2002:a05:6000:2886:b0:42f:dbbc:5103 with SMTP id
 ffacd0b85a97d-4324e4fda18mr46838205f8f.35.1767200871338; Wed, 31 Dec 2025
 09:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231012558.1699758-1-ihor.solodrai@linux.dev>
In-Reply-To: <20251231012558.1699758-1-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 09:07:40 -0800
X-Gm-Features: AQt7F2rgOTewqDmcAzVEygDD_JCldDLnUICazgBgTeXp9vlBwTr9MFsimdJvJoQ
Message-ID: <CAADnVQ+biTSDaNtoL=ct9XtBJiXYMUqGYLqu604C3D8N+8YH9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] resolve_btfids: Implement --patch_btfids
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 5:26=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> Recent changes in BTF generation [1] rely on ${OBJCOPY} command to
> update .BTF_ids section data in target ELF files.
>
> This exposed a bug in llvm-objcopy --update-section code path, that
> may lead to corruption of a target ELF file. Specifically, because of
> the bug st_shndx of some symbols may be (incorrectly) set to 0xffff
> (SHN_XINDEX) [2][3].
>
> While there is a pending fix for LLVM, it'll take some time before it
> lands (likely in 22.x). And the kernel build must keep working with
> older LLVM toolchains in the foreseeable future.
>
> Using GNU objcopy for .BTF_ids update would work, but it would require
> changes to LLVM-based build process, likely breaking existing build
> environments as discussed in [2].
>
> To work around llvm-objcopy bug, implement --patch_btfids code path in
> resolve_btfids as a drop-in replacement for:
>
>     ${OBJCOPY} --update-section .BTF_ids=3D${btf_ids} ${elf}
>
> Which works specifically for .BTF_ids section:
>
>     ${RESOLVE_BTFIDS} --patch_btfids ${btf_ids} ${elf}
>
> This feature in resolve_btfids can be removed at some point in the
> future, when llvm-objcopy with a relevant bugfix becomes common.
>
> [1] https://lore.kernel.org/bpf/20251219181321.1283664-1-ihor.solodrai@li=
nux.dev/
> [2] https://lore.kernel.org/bpf/20251224005752.201911-1-ihor.solodrai@lin=
ux.dev/
> [3] https://github.com/llvm/llvm-project/issues/168060#issuecomment-35335=
52952
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> ---
>
> Successful BPF CI run: https://github.com/kernel-patches/bpf/actions/runs=
/20608321584
> ---
>  scripts/gen-btf.sh                   |   2 +-
>  scripts/link-vmlinux.sh              |   2 +-
>  tools/bpf/resolve_btfids/main.c      | 117 +++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/Makefile |   2 +-
>  4 files changed, 120 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
> index 12244dbe097c..0aec86615416 100755
> --- a/scripts/gen-btf.sh
> +++ b/scripts/gen-btf.sh
> @@ -123,7 +123,7 @@ embed_btf_data()
>         fi
>         local btf_ids=3D"${ELF_FILE}.BTF_ids"
>         if [ -f "${btf_ids}" ]; then
> -               ${OBJCOPY} --update-section .BTF_ids=3D${btf_ids} ${ELF_F=
ILE}
> +               ${RESOLVE_BTFIDS} --patch_btfids ${btf_ids} ${ELF_FILE}
>         fi
>  }
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index e2207e612ac3..1915adf3249b 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -266,7 +266,7 @@ vmlinux_link "${VMLINUX}"
>
>  if is_enabled CONFIG_DEBUG_INFO_BTF; then
>         info OBJCOPY ${btfids_vmlinux}
> -       ${OBJCOPY} --update-section .BTF_ids=3D${btfids_vmlinux} ${VMLINU=
X}
> +       ${RESOLVE_BTFIDS} --patch_btfids ${btfids_vmlinux} ${VMLINUX}
>  fi

Applied, but please follow up to reduce the verbosity
  OBJCOPY net/mptcp/mptcp_diag.ko.BTF
  OBJCOPY net/bridge/br_netfilter.ko.BTF
  OBJCOPY net/bridge/netfilter/ebt_log.ko.BTF
  OBJCOPY net/caif/caif.ko.BTF
  OBJCOPY net/bridge/netfilter/ebt_ip.ko.BTF
  BTFIDS  net/netfilter/ipvs/ip_vs.ko
  OBJCOPY net/netfilter/ipvs/ip_vs.ko.BTF
  BTFIDS  drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko
  OBJCOPY drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko.BTF


All of these OBJCOPY lines are not correct anymore and can
be simply removed. No need to yell at the user about these steps.

imo BTFIDS lines can be removed too. They just scroll on the screen.

