Return-Path: <bpf+bounces-20886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF6F844FF3
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFDA1F247B1
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 03:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C330F3B785;
	Thu,  1 Feb 2024 03:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVqfp3SR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0E3AC01;
	Thu,  1 Feb 2024 03:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759717; cv=none; b=mpdQ2854GOSlLiQ2st9SXFoFALnWJiUkG4OVORTNSnGN9Aj6KAPRyMmrNv5UbAPDb6B1VQE1IePWX5WmNSAWMZb358hdhw/JK2yDnyRzidDwH8JNKSqH/NlDNL6QWcNCc1H0/znSfVTLUFPk3TwJVW9t1SG6CtlDTRhS57zvJQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759717; c=relaxed/simple;
	bh=WMEkIx9MEEnXTCtPfWejStR3ll+FdZncOEPJ2at7Cw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lV2SugesU/EK8gzFry+7qMaNSYGJDLmTdrS79Y1ZSZ3InHflNUyBuMyEx60+GEBfU+y7BAigXhHkdr/dMI6PtcAfg0tYVGdzD/DDiRkNuR+0olgBmXEctQawnQ7DmNNN0cLpBYQoroUYni87/BIqkclunQ208a8EHpRZfEErWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVqfp3SR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e8d3b29f2so3940805e9.1;
        Wed, 31 Jan 2024 19:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706759713; x=1707364513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Olc45ZP5rRpjqMnLe9OlfAlDeYaBIp+NzRiTKYTnbX4=;
        b=nVqfp3SRwuG8UvpvEasITQcKb06oilFKeFXmsOLEwxT1k/6vSIFZEgJZ4tsI3crB8W
         jSOhtKVexzzxCYulWMAEox8sRPSRd9wDc2ELPg58K1R18MjU5iNNy2Fmop+2FpUI2nKp
         Efoa8o0PpCKCzBkEwsNN+2C7gbmGi1Ql4tVfim3HIV0h1TwS42h/DlxmPVSwkBDwLHAt
         KBH0va4jhs+B9qaFVfniZRwT5kO+j+0CipzKACgqgGxnPIy4GeEge7wjBPbsuRcJAx/4
         KGpbnr7sj56Hae8XZbPZVScvn+m7hp9/pVgfzhfpTvggMaYoGGBaQ4AEbxXuLHWZnRuk
         vXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706759713; x=1707364513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Olc45ZP5rRpjqMnLe9OlfAlDeYaBIp+NzRiTKYTnbX4=;
        b=Kdx40B+RuT/hNzaMD2Z3NFjzPbT0Zb1ze6pkykfD5OYAg6eeZfmhfy0D4kaGZAjPhF
         IyfBbAYnJ/JtciwtMuKLpx7JEYmfw5PUdRS2hL7DpJaBZN9UPSDXdDTnxFjIIg8JtE6X
         oRa7+hKRRszHdHa5QYoBtXOnmWn91/VLz9qid6qnKKmgp5LAS5eA2vUpoZS2y3nzgyLM
         OXT2QRu2XfqawQUBTDkH2I9m8ZxL9tP5jvBO2h/deWUn0fjPcR/EAEXXU6jkdRASWF1F
         3fGnb7LjaQy72bgOa5df5Vbthh4+AqaGHDHDPqMCQhuRrmUyo6prtnk4iBDQDFPrJFK7
         QTNw==
X-Gm-Message-State: AOJu0YyHeIR9AOYnoRL9Nl0Rqei/TGu5Y1ciFO9dtMkLZsoxLWFYwdbg
	y1hGJH/62s3FvpngJS/KpXUV9iLk2dwlGTJwXdb2RgesXz3ZUeFKNP06BHSCzl4/MIkbwPRwUOc
	8OR6jTFkzJBz1Rtq92/PzvpAqdHA=
X-Google-Smtp-Source: AGHT+IGAUpcIir2cqoyINodp1d/6dXRuBHU4yESWFyMLeHupPOJAMuIWoXJA8fAxJwpRIEZDbkmFJutrKM57/i7O5i0=
X-Received: by 2002:a05:6000:22b:b0:33b:1786:f911 with SMTP id
 l11-20020a056000022b00b0033b1786f911mr70161wrz.54.1706759712713; Wed, 31 Jan
 2024 19:55:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201142348.38ac52d5@canb.auug.org.au>
In-Reply-To: <20240201142348.38ac52d5@canb.auug.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Jan 2024 19:55:01 -0800
Message-ID: <CAADnVQLGZFf64X+HinDzCkVxzhB0ja62aMSeMG7Lm0=KLd977g@mail.gmail.com>
Subject: Re: linux-next: runtime warnings after merge of the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Xu <dxu@dxuuu.xyz>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:23=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the bpf-next tree, today's linux-next build (powerpc
> pseries_le_defconfig) produced these runtime warnings in my qemu boot
> tests:

le - little endian?

Do you see this on other architectures or powerpr_le only?

Daniel,

any ideas?

>
>   ipip: IPv4 and MPLS over IPv4 tunneling driver
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_s=
et+0x68/0x74
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc2-03380-gd0c0d80c1162=
 #2
>   Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf=
000004 of:SLOF,HEAD pSeries
>   NIP:  c0000000003bfbfc LR: c00000000209ba3c CTR: c00000000209b9a4
>   REGS: c0000000049bf960 TRAP: 0700   Not tainted  (6.8.0-rc2-03380-gd0c0=
d80c1162)
>   MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000482  XER: 0=
0000000
>   CFAR: c0000000003bfbb0 IRQMASK: 0
>   GPR00: c00000000209ba3c c0000000049bfc00 c0000000015c9900 0000000000000=
01b
>   GPR04: c0000000012bc980 000000000000019a 000000000000019a 0000000000000=
133
>   GPR08: c000000002969900 0000000000000001 c000000002969900 c000000002969=
900
>   GPR12: c00000000209b9a4 c000000002b60000 c0000000000110cc 0000000000000=
000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd=
250
>   GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c1=
060
>   GPR28: 0000000000000000 0000000000000007 c0000000020c10a8 c000000002968=
f80
>   NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
>   LR [c00000000209ba3c] cubictcp_register+0x98/0xc8
>   Call Trace:
>   [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
>   [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
>   [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
>   [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/=
0x1c
>   --- interrupt: 0 at 0x0
>   Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4b=
fff8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4=
c0121
>   ---[ end trace 0000000000000000 ]---
>   NET: Registered PF_INET6 protocol family
>         .
>         .
>         .
>   Running code patching self-tests ...
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_s=
et+0x68/0x74
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-03=
380-gd0c0d80c1162 #2
>   Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf=
000004 of:SLOF,HEAD pSeries
>   NIP:  c0000000003bfbfc LR: c00000000204900c CTR: c000000002048fe0
>   REGS: c0000000049bf970 TRAP: 0700   Tainted: G        W           (6.8.=
0-rc2-03380-gd0c0d80c1162)
>   MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000482  XER: 2=
0000000
>   CFAR: c0000000003bfbb0 IRQMASK: 0
>   GPR00: c00000000204900c c0000000049bfc10 c0000000015c9900 0000000000000=
01a
>   GPR04: c000000001218fb0 0000000000000002 c0000000049bfc02 0000000035b57=
93c
>   GPR08: 0000000000000000 0000000000000001 0000000000000000 000000009e3fc=
b99
>   GPR12: c000000002048fe0 c000000002b60000 c0000000000110cc 0000000000000=
000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd=
250
>   GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c1=
068
>   GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c000000002048=
fe0
>   NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
>   LR [c00000000204900c] bpf_rstat_kfunc_init+0x2c/0x40
>   Call Trace:
>   [c0000000049bfc10] [c0000000020c10b0] 0xc0000000020c10b0 (unreliable)
>   [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
>   [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
>   [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
>   [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/=
0x1c
>   --- interrupt: 0 at 0x0
>   Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4b=
fff8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4=
c0121
>   ---[ end trace 0000000000000000 ]---
>   registered taskstats version 1
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_s=
et+0x68/0x74
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-03=
380-gd0c0d80c1162 #2
>   Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf=
000004 of:SLOF,HEAD pSeries
>   NIP:  c0000000003bfbfc LR: c000000002050fdc CTR: c000000002050fb8
>   REGS: c0000000049bf970 TRAP: 0700   Tainted: G        W           (6.8.=
0-rc2-03380-gd0c0d80c1162)
>   MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000482  XER: 2=
0000000
>   CFAR: c0000000003bfbb0 IRQMASK: 0
>   GPR00: c000000002050fdc c0000000049bfc10 c0000000015c9900 0000000000000=
01d
>   GPR04: c000000001223600 0000000000000002 c0000000049bfc02 fffffffffffe0=
000
>   GPR08: 0000000000000000 0000000000000001 0000000000000000 0000000024000=
242
>   GPR12: c000000002050fb8 c000000002b60000 c0000000000110cc 0000000000000=
000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd=
250
>   GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c1=
068
>   GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c000000002050=
fb8
>   NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
>   LR [c000000002050fdc] bpf_fs_kfuncs_init+0x24/0x38
>   Call Trace:
>   [c0000000049bfc10] [c0000000020c10b0] 0xc0000000020c10b0 (unreliable)
>   [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
>   [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
>   [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
>   [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/=
0x1c
>   --- interrupt: 0 at 0x0
>   Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4b=
fff8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4=
c0121
>   ---[ end trace 0000000000000000 ]---
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_s=
et+0x68/0x74
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-03=
380-gd0c0d80c1162 #2
>   Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf=
000004 of:SLOF,HEAD pSeries
>   NIP:  c0000000003bfbfc LR: c000000002050fa4 CTR: c000000002050f80
>   REGS: c0000000049bf970 TRAP: 0700   Tainted: G        W           (6.8.=
0-rc2-03380-gd0c0d80c1162)
>   MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000482  XER: 2=
0000000
>   CFAR: c0000000003bfbb0 IRQMASK: 0
>   GPR00: c000000002050fa4 c0000000049bfc10 c0000000015c9900 0000000000000=
01a
>   GPR04: c0000000012235e8 0000000000000002 c0000000049bfc02 fffffffffffe0=
000
>   GPR08: 0000000000000000 0000000000000001 0000000000000000 0000000024000=
242
>   GPR12: c000000002050f80 c000000002b60000 c0000000000110cc 0000000000000=
000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd=
250
>   GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c1=
068
>   GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c000000002050=
f80
>   NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
>   LR [c000000002050fa4] bpf_key_sig_kfuncs_init+0x24/0x38
>   Call Trace:
>   [c0000000049bfc10] [c0000000020c10b0] 0xc0000000020c10b0 (unreliable)
>   [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
>   [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
>   [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
>   [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/=
0x1c
>   --- interrupt: 0 at 0x0
>   Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4b=
fff8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4=
c0121
>   ---[ end trace 0000000000000000 ]---
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_s=
et+0x68/0x74
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-03=
380-gd0c0d80c1162 #2
>   Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf=
000004 of:SLOF,HEAD pSeries
>   NIP:  c0000000003bfbfc LR: c0000000020517dc CTR: c000000002051790
>   REGS: c0000000049bf940 TRAP: 0700   Tainted: G        W           (6.8.=
0-rc2-03380-gd0c0d80c1162)
>   MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000422  XER: 2=
0000000
>   CFAR: c0000000003bfbb0 IRQMASK: 0
>   GPR00: c0000000020517dc c0000000049bfbe0 c0000000015c9900 0000000000000=
01a
>   GPR04: c000000001227670 0000000000000002 c0000000049bfc02 fffffffffffe0=
000
>   GPR08: 0000000000000000 0000000000000001 0000000000000000 0000000024000=
282
>   GPR12: c000000002051790 c000000002b60000 c0000000000110cc 0000000000000=
000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd=
250
>   GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c1=
068
>   GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c000000001227=
670
>   NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
>   LR [c0000000020517dc] kfunc_init+0x4c/0x110
>   Call Trace:
>   [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
>   [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
>   [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
>   [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/=
0x1c
>   --- interrupt: 0 at 0x0
>   Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4b=
fff8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4=
c0121
>   ---[ end trace 0000000000000000 ]---
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_s=
et+0x68/0x74
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-03=
380-gd0c0d80c1162 #2
>   Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf=
000004 of:SLOF,HEAD pSeries
>   NIP:  c0000000003bfbfc LR: c0000000003976c8 CTR: c00000000039769c
>   REGS: c0000000049bf970 TRAP: 0700   Tainted: G        W           (6.8.=
0-rc2-03380-gd0c0d80c1162)
>   MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000422  XER: 2=
0000000
>   CFAR: c0000000003bfbb0 IRQMASK: 0
>   GPR00: c0000000003976c8 c0000000049bfc10 c0000000015c9900 0000000000000=
000
>   GPR04: c000000001228d70 0000000000000002 c0000000049bfc02 fffffffffffe0=
000
>   GPR08: 0000000000000000 0000000000000001 0000000000000000 0000000024000=
282
>   GPR12: c00000000039769c c000000002b60000 c0000000000110cc 0000000000000=
000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd=
250
>   GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c1=
068
>   GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c000000000397=
69c
>   NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
>   LR [c0000000003976c8] init_subsystem+0x2c/0x40
>   Call Trace:
>   [c0000000049bfc10] [c0000000020c10b0] 0xc0000000020c10b0 (unreliable)
>   [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
>   [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
>   [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
>   [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/=
0x1c
>   --- interrupt: 0 at 0x0
>   Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4b=
fff8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4=
c0121
>   ---[ end trace 0000000000000000 ]---
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_s=
et+0x68/0x74
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-03=
380-gd0c0d80c1162 #2
>   Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf=
000004 of:SLOF,HEAD pSeries
>   NIP:  c0000000003bfbfc LR: c000000002051ed8 CTR: 0000000000000000
>   REGS: c0000000049bf950 TRAP: 0700   Tainted: G        W           (6.8.=
0-rc2-03380-gd0c0d80c1162)
>   MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000220  XER: 2=
0000000
>   CFAR: c0000000003bfbb0 IRQMASK: 0
>   GPR00: c000000002051ed8 c0000000049bfbf0 c0000000015c9900 0000000000000=
01a
>   GPR04: c00000000122ad08 0000000000000001 c000000004810c00 c00000007fc92=
c30
>   GPR08: 0000000000000017 0000000000000001 0000000000000008 0000000024000=
222
>   GPR12: 0000000000000034 c000000002b60000 c0000000000110cc 0000000000000=
000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd=
250
>   GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c1=
068
>   GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c00000000122a=
d08
>   NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
>   LR [c000000002051ed8] cpumask_kfunc_init+0x98/0xf0
>   Call Trace:
>   [c0000000049bfbf0] [c000000002051e84] cpumask_kfunc_init+0x44/0xf0 (unr=
eliable)
>   [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
>   [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
>   [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
>   [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/=
0x1c
>   --- interrupt: 0 at 0x0
>   Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4b=
fff8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4=
c0121
>   ---[ end trace 0000000000000000 ]---
>   Loading compiled-in X.509 certificates
>         .
>         .
>         .
>   netconsole: network logging started
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_s=
et+0x68/0x74
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-03=
380-gd0c0d80c1162 #2
>   Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf=
000004 of:SLOF,HEAD pSeries
>   NIP:  c0000000003bfbfc LR: c000000000f0099c CTR: c000000000f00970
>   REGS: c0000000049bf970 TRAP: 0700   Tainted: G        W           (6.8.=
0-rc2-03380-gd0c0d80c1162)
>   MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000282  XER: 2=
0000000
>   CFAR: c0000000003bfbb0 IRQMASK: 0
>   GPR00: c000000000f0099c c0000000049bfc10 c0000000015c9900 0000000000000=
01a
>   GPR04: c0000000012b12c0 0000000000000002 c0000000049bfc02 fffffffffffe0=
000
>   GPR08: 0000000000000000 0000000000000001 0000000000000000 0000000000000=
000
>   GPR12: c000000000f00970 c000000002b60000 c0000000000110cc 0000000000000=
000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd=
250
>   GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c1=
068
>   GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c000000000f00=
970
>   NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
>   LR [c000000000f0099c] init_subsystem+0x2c/0x40
>   Call Trace:
>   [c0000000049bfc10] [c0000000020c10b0] 0xc0000000020c10b0 (unreliable)
>   [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
>   [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
>   [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
>   [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/=
0x1c
>   --- interrupt: 0 at 0x0
>   Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4b=
fff8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4=
c0121
>   ---[ end trace 0000000000000000 ]---
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_s=
et+0x68/0x74
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-03=
380-gd0c0d80c1162 #2
>   Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf=
000004 of:SLOF,HEAD pSeries
>   NIP:  c0000000003bfbfc LR: c000000002094ab0 CTR: c000000002094a70
>   REGS: c0000000049bf960 TRAP: 0700   Tainted: G        W           (6.8.=
0-rc2-03380-gd0c0d80c1162)
>   MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000282  XER: 2=
0000000
>   CFAR: c0000000003bfbb0 IRQMASK: 0
>   GPR00: c000000002094ab0 c0000000049bfc00 c0000000015c9900 0000000000000=
003
>   GPR04: c0000000012b1260 0000000000000002 c0000000049bfc02 fffffffffffe0=
000
>   GPR08: 0000000000000000 0000000000000001 0000000000000000 0000000000000=
000
>   GPR12: c000000002094a70 c000000002b60000 c0000000000110cc 0000000000000=
000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd=
250
>   GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c1=
068
>   GPR28: 0000000000000000 0000000000000008 c0000000012aef20 c0000000012b1=
260
>   NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
>   LR [c000000002094ab0] bpf_kfunc_init+0x40/0x18c
>   Call Trace:
>   [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
>   [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
>   [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
>   [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/=
0x1c
>   --- interrupt: 0 at 0x0
>   Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4b=
fff8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4=
c0121
>   ---[ end trace 0000000000000000 ]---
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_s=
et+0x68/0x74
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-03=
380-gd0c0d80c1162 #2
>   Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf=
000004 of:SLOF,HEAD pSeries
>   NIP:  c0000000003bfbfc LR: c000000002094ccc CTR: c000000002094ca0
>   REGS: c0000000049bf970 TRAP: 0700   Tainted: G        W           (6.8.=
0-rc2-03380-gd0c0d80c1162)
>   MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000282  XER: 2=
0000000
>   CFAR: c0000000003bfbb0 IRQMASK: 0
>   GPR00: c000000002094ccc c0000000049bfc10 c0000000015c9900 0000000000000=
006
>   GPR04: c0000000012b25e0 0000000000000002 c0000000049bfc02 fffffffffffe0=
000
>   GPR08: 0000000000000000 0000000000000001 0000000000000000 0000000000000=
000
>   GPR12: c000000002094ca0 c000000002b60000 c0000000000110cc 0000000000000=
000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd=
250
>   GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c1=
068
>   GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c000000002094=
ca0
>   NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
>   LR [c000000002094ccc] xdp_metadata_init+0x2c/0x40
>   Call Trace:
>   [c0000000049bfc10] [c0000000020c10b0] 0xc0000000020c10b0 (unreliable)
>   [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
>   [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
>   [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
>   [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/=
0x1c
>   --- interrupt: 0 at 0x0
>   Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4b=
fff8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4=
c0121
>   ---[ end trace 0000000000000000 ]---
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_s=
et+0x68/0x74
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-03=
380-gd0c0d80c1162 #2
>   Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf=
000004 of:SLOF,HEAD pSeries
>   NIP:  c0000000003bfbfc LR: c000000002095890 CTR: c000000002095800
>   REGS: c0000000049bf940 TRAP: 0700   Tainted: G        W           (6.8.=
0-rc2-03380-gd0c0d80c1162)
>   MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000282  XER: 2=
0000000
>   CFAR: c0000000003bfbb0 IRQMASK: 0
>   GPR00: c000000002095890 c0000000049bfbe0 c0000000015c9900 0000000000000=
003
>   GPR04: c0000000012b5938 0000000000000002 c0000000049bfc02 fffffffffffe0=
000
>   GPR08: 0000000000000000 0000000000000001 0000000000000000 0000000000000=
000
>   GPR12: c000000002095800 c000000002b60000 c0000000000110cc 0000000000000=
000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd=
250
>   GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c1=
068
>   GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c0000000012b5=
938
>   NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
>   LR [c000000002095890] bpf_prog_test_run_init+0x90/0xec
>   Call Trace:
>   [c0000000049bfbe0] [c000000002095848] bpf_prog_test_run_init+0x48/0xec =
(unreliable)
>   [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
>   [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
>   [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
>   [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/=
0x1c
>   --- interrupt: 0 at 0x0
>   Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4b=
fff8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4=
c0121
>   ---[ end trace 0000000000000000 ]---
>   modprobe (54) used greatest stack depth: 28336 bytes left
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_s=
et+0x68/0x74
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-03=
380-gd0c0d80c1162 #2
>   Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf=
000004 of:SLOF,HEAD pSeries
>   NIP:  c0000000003bfbfc LR: c00000000209bd0c CTR: c00000000209bce0
>   REGS: c0000000049bf970 TRAP: 0700   Tainted: G        W           (6.8.=
0-rc2-03380-gd0c0d80c1162)
>   MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24000242 =
 XER: 20000000
>   CFAR: c0000000003bfbb0 IRQMASK: 0
>   GPR00: c00000000209bd0c c0000000049bfc10 c0000000015c9900 0000000000000=
01b
>   GPR04: c0000000012bcb28 0000000000000002 c0000000049bfc02 fffffffffffe0=
000
>   GPR08: 0000000000000000 0000000000000001 0000000000000000 c00000000291f=
b90
>   GPR12: c00000000209bce0 c000000002b60000 c0000000000110cc 0000000000000=
000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd=
250
>   GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c1=
068
>   GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c00000000209b=
ce0
>   NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
>   LR [c00000000209bd0c] bpf_tcp_ca_kfunc_init+0x2c/0x74
>   Call Trace:
>   [c0000000049bfc10] [c0000000020c10b0] 0xc0000000020c10b0 (unreliable)
>   [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
>   [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
>   [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
>   [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/=
0x1c
>   --- interrupt: 0 at 0x0
>   Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4b=
fff8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4=
c0121
>   ---[ end trace 0000000000000000 ]---
>   Freeing unused kernel image (initmem) memory: 6464K
>
> Exposed (and maybe caused) by commit
>
>   6e7769e6419f ("bpf: treewide: Annotate BPF kfuncs in BTF")
>
> --
> Cheers,
> Stephen Rothwell

