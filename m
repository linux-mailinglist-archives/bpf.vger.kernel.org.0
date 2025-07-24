Return-Path: <bpf+bounces-64283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10407B10EC0
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4771D01328
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B8E2EA46F;
	Thu, 24 Jul 2025 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H94zABVE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1AE2E36ED;
	Thu, 24 Jul 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371049; cv=none; b=b7jN/PqDnrtw3EHw4vapS8PFQo4XT6LpJIFsdtvTAArTNwwzy/1+j+XH/BkLwra7WK3FlxwlLdHoIoPrScdXgE5NKdghV3mysQGIuw5wFlAUucEUmpkzKQe8A3KuzbCiuuuWmQECvHl+QIpfGlSsjna5RMP05fCLJArkMRA19Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371049; c=relaxed/simple;
	bh=s6n0+4J3j3E/bwSmPKHNNlPN0uXRfALwz6qCZuavh+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0FRVgPwoTYM2AFJix7+46mr00iSCU/S8EREOGux1yH3eJmxMxujVUxEN6pizwtZf5sTGEu8FI7Gb/GN0siRF6UZlmfwUKPq+npUf0zHb8n8+sPIp7BfpVrkfoKotEPZaDRILRlaDXRM7QuavtvKCOEo8bxlbIGvR3Vku0QX4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H94zABVE; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab63f8fb91so9156571cf.0;
        Thu, 24 Jul 2025 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753371047; x=1753975847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bns7Kk0Rpa4pq4zt0eqAHfJ1qsmgjPeI84GDNp5EYCw=;
        b=H94zABVEXHxKIMJCrQBkxzt72LMwdnIDpYPLTS+q0fd0y8Ti6if0SaHkg+XRDcri7c
         Z++nGEuvG8/3aUoYIYzBgh5/BUkSVrBBG6d4+cF+eofLgVcg0kUXydpPqo+fRqzSjnTi
         HRYWOEY/FLF3v3qe+sHYegXDkcdVaykA1kUlHUywYA6oFB/KBOyU4ZAdPmXMjBzwwwJu
         e9Wu5niOC3xWyxPxmHombGhHg5En3JLf43GPGGIof64GJZ1lEpQLCB+NqMBSGYemRBvJ
         72vFyT/1EaZgB3MsSLPgRL9ztn1Yl5djwDjfDeZoXHcLq50GiNHktcSqkBt1fLH3W/+R
         GTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753371047; x=1753975847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bns7Kk0Rpa4pq4zt0eqAHfJ1qsmgjPeI84GDNp5EYCw=;
        b=YM06WEwLZdlB8KywtXlChw5FDPnAMLUl6yQcWVGoOE5RKBk35uAQmqRxSAL+aelx9a
         HLLUzXt/1cOKBQS7JAQr67uqYjvGB83x4BNJq0IUFvM3tajeBGCEo0ZWrx8TSfbM8eV1
         Lkv8Zre7CFTRzkK8L5vm1Qt005ko2A47+AKW/pwoNtDrwlQA1qAIshciH3HIHoWu8Jxx
         B60hghWSMVvKRhr78jX/a9pZYtK3+Q02XS/OOPzVcoqe8slFLHeyFogt3aQwDzCgolgv
         W7D76GEo1grmxlv7yIyolHSCRKNdv8gMRZQclfM06I4hUf1YUrU7nDbahE3eD3vmIWoI
         yJMw==
X-Forwarded-Encrypted: i=1; AJvYcCVKElG4POiazA2yJGT4U9hUd+CMIZnyJDqKtDFk/lfQrWcXOwCOKf6cABZ34mkS+jJciYHJkow3W+1VY5c3@vger.kernel.org, AJvYcCXZ/CdVVSn0B+4AzZa17Q8IPYKsubUGoYR8afOdzbAi0PO+Fehl2lt3khoDom64QCup09s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXge/FORnU6p1otbyOjmbjNaQLw93+ciqWLvjupPV8sppJL86E
	G5tqMdrAigWW92xY3YotTQDtaA8Y3TbNEW0sXoOUdZD5ETBkSqoEqnXX1UFe836d3mvMXZXTYjD
	Rgc8FDzSKPH2cFlTRoX2D+zjj9YCgXak=
X-Gm-Gg: ASbGnctpCGAgudH9njojdoRKJrX4S/BnrvjlkuA+9UrGnIZ+Ei25yIEyPEdbvvWqums
	yMXABW59l84l0Ysxo0O0P7reakz4i2pqqUqevQVEvGYcqMMa9KG1jwaN6ALytoPSzEDyTB6ejhb
	+6rq6rc/ZWYZeRB9EuTPyFwftwbI71Ar5I0rM/yReiNG+6i0q00OTNZtpIHPK4Yxp4mj+Q9WLse
	uONSYY=
X-Google-Smtp-Source: AGHT+IFneajSujJFQ97vJcxifdOb9B3fL1wtrAniITfCV3VYjoOZ3QlmTUWuT4bgBenSgy2Gnd2jFCXUqEkPtzVI9bw=
X-Received: by 2002:a05:622a:10e:b0:4ab:5429:f961 with SMTP id
 d75a77b69052e-4ae6df467a1mr98689901cf.35.1753371046736; Thu, 24 Jul 2025
 08:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724141929.691853-1-duanchenghao@kylinos.cn>
In-Reply-To: <20250724141929.691853-1-duanchenghao@kylinos.cn>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Thu, 24 Jul 2025 08:30:35 -0700
X-Gm-Features: Ac12FXzYVMc9LtJ5ub-Hay_uu6iwvZYf5WJFpfcdpSQsl15oaprz3hONyJyeCuw
Message-ID: <CAK3+h2zirm6cV2tAbd38RSYSF3=B1qZ+9jm_GZPsAPrMtaozmg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Support trampoline for LoongArch
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, hengqi.chen@gmail.com, chenhuacai@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 7:19=E2=80=AFAM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> v4:
> 1. Delete the #3 patch of version V3.
>
> 2. Add 5 NOP instructions in build_prologue().
>    Reserve space for the move_imm + jirl instruction.
>
> 3. Differentiate between direct jumps and ftrace jumps of trampoline:
>    direct jumps skip 5 instructions.
>    ftrace jumps skip 2 instructions.
>
> 4. Remove the generation of BL jump instructions in emit_jump_and_link().
>    After the trampoline ends, it will jump to the specified register.
>    The BL instruction writes PC+4 to r1 instead of allowing the
>    specification of rd.
>
> -----------------------------------------------------------------------
> Historical Version:
> v3:
> 1. Patch 0003 adds EXECMEM_BPF memory type to the execmem subsystem.
>
> 2. Align the size calculated by arch_bpf_trampoline_size to page
> boundaries.
>
> 3. Add the flush icache operation to larch_insn_text_copy.
>
> 4. Unify the implementation of bpf_arch_xxx into the patch
> "0004-LoongArch-BPF-Add-bpf_arch_xxxxx-support-for-Loong.patch".
>
> 5. Change the patch order. Move the patch
> "0002-LoongArch-BPF-Update-the-code-to-rename-validate_.patch" before
> "0005-LoongArch-BPF-Add-bpf-trampoline-support-for-Loon.patch".
>
> URL for version v3:
> https://lore.kernel.org/all/20250709055029.723243-1-duanchenghao@kylinos.=
cn/
> ---------
> v2:
> 1. Change the fixmap in the instruction copy function to set_memory_xxx.
>
> 2. Change the implementation method of the following code.
>         - arch_alloc_bpf_trampoline
>         - arch_free_bpf_trampoline
>         Use the BPF core's allocation and free functions.
>
>         - bpf_arch_text_invalidate
>         Operate with the function larch_insn_text_copy that carries
>         memory attribute modifications.
>
> 3. Correct the incorrect code formatting.
>
> URL for version v2:
> https://lore.kernel.org/all/20250618105048.1510560-1-duanchenghao@kylinos=
.cn/
> ---------
> v1:
> Support trampoline for LoongArch. The following feature tests have been
> completed:
>         1. fentry
>         2. fexit
>         3. fmod_ret
>
> TODO: The support for the struct_ops feature will be provided in
> subsequent patches.
>
> URL for version v1:
> https://lore.kernel.org/all/20250611035952.111182-1-duanchenghao@kylinos.=
cn/
> -----------------------------------------------------------------------
>
> Chenghao Duan (4):
>   LoongArch: Add larch_insn_gen_{beq,bne} helpers
>   LoongArch: BPF: Update the code to rename validate_code to
>     validate_ctx
>   LoongArch: BPF: Add bpf_arch_xxxxx support for Loongarch
>   LoongArch: BPF: Add bpf trampoline support for Loongarch
>
> Tiezhu Yang (1):
>   LoongArch: BPF: Add struct ops support for trampoline
>
>  arch/loongarch/include/asm/inst.h |   3 +
>  arch/loongarch/kernel/inst.c      |  60 ++++
>  arch/loongarch/net/bpf_jit.c      | 521 +++++++++++++++++++++++++++++-
>  arch/loongarch/net/bpf_jit.h      |   6 +
>  4 files changed, 589 insertions(+), 1 deletion(-)
>
> --
> 2.25.1
>

Tested the whole patch series and it resolved the xdp-tool xdp-filter issue

[root@fedora ~]# xdp-loader status
CURRENT XDP PROGRAM STATUS:

Interface        Prio  Program name      Mode     ID   Tag
  Chain actions
---------------------------------------------------------------------------=
-----------
lo                     xdp_dispatcher    skb      53   4d7e87c0d30db711
 =3D>              10     xdpfilt_alw_all           62
320c53c06933a8fa  XDP_PASS
dummy0                 <No XDP program loaded!>
sit0                   <No XDP program loaded!>
enp0s3f0               <No XDP program loaded!>
wlp3s0                 <No XDP program loaded!>

you can add Tested-by: Vincent Li <vincent.mc.li@gmail.com>

