Return-Path: <bpf+bounces-57991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87606AB2BF7
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 00:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477DF177B01
	for <lists+bpf@lfdr.de>; Sun, 11 May 2025 22:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C0A262FEE;
	Sun, 11 May 2025 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no649vpx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A5014EC73
	for <bpf@vger.kernel.org>; Sun, 11 May 2025 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747002851; cv=none; b=c2PlZyXSmA3K1uEdyPUmZYALL9YAauGYLMm8ppb4AlbkAqNX2KR7TGz6ZCfAp5B224g77hLugK8d6w4Ve9JmlB4n04RO3QD6oizofZbsI3qzuR6qyBhZc+EalwYxCNUx/zKIUy3LsjzQJCoigTxoKmF6w5RUNl5enxPIjkEG9Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747002851; c=relaxed/simple;
	bh=zNMwUKgoGIhwmqIuVrAb8nC18+e6i7ZZSXEMfPRlYk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHOo1IM4YgiZ2y4l4PPLo+Miotia+r1rXl0RrPPJeuTni65/HNGOaOy24xge3MGuSoytJT6F4vUfA0MXXwv5mjg/rf/TvRDejE53DEy4tSnWubd8tSZyAB+6YDVLCu/Ov2Uinh1/rvSpyjxYJ2N6q9Y+O6h+GnEsm9DOnm7avc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no649vpx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0b9625662so3099848f8f.3
        for <bpf@vger.kernel.org>; Sun, 11 May 2025 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747002848; x=1747607648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vT+ThJ5/Cl0cz3og9wRFuvECzIH9g41ktoMw3fowCAU=;
        b=no649vpxDTSiceimf2+2JdmqLeIkDJfYb8eLgRyG+twC7//p3z57FkAVN6DDs7ThSJ
         pxzisiuaj2RdeLIy4SZ++oGJB27FBBLfa66E5LXWs1KJp5cCKtjjG0IpWZhCb/uqUUiW
         dae7MQ5YRlWeQwTRBy/EV7YOCiPpiRzqIdHGKtlcBB9FEnPffS8QrySyKadpMs/3vJe5
         7e+yNFLn1WiVsnfUJQJRbBi91Zg2ZVDTwRbKyFMP4BrUCQvXlX3aDi3W/Etv5mUBarAD
         DMAVhGfgIG7naWsWGYEgy6knhZufq7FPJ+fPKLSTYnBtqkWwLWfwY9+BIu5do0ZLOhUV
         8Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747002848; x=1747607648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vT+ThJ5/Cl0cz3og9wRFuvECzIH9g41ktoMw3fowCAU=;
        b=TAqNbavhgJCfMFDMmCoKOuUSclddEntpxuDO4s2YoAMHBv8b4n85BXUb88v2hDNRJU
         EHwh3carZhbRDjQJhnq2bPYqfSJYLwtOxymRhMSpyqAkDI3cbsuhQNPWQBQXwl7nx909
         FsXam34IBIUOOQjtp3zM3idRyavLA6Z9hFfOoDVg6SEM7TWTnZeisUz8tjYJsP9ZxlTc
         UwUw3q08GPBftQFgZBDWnjUTOhHaUP6najAE4cnDL9aZe5bEqpFPb16SJ7gX9fiXg9e5
         DL/iIfPEFlPM3a0bf4gsaIvqoxLkD6lqLbQq866PrwjmNWZtlqgKxyRDat0eyMDRLFo+
         7EFA==
X-Gm-Message-State: AOJu0Ywxz4QeCIQ3bYbxvtrHP5bkSTEKqgLJOlW049EeKWSa7qcBQE/w
	+DBnCrsWGcHnh3nMZb0XjOS38IwKSPZXusgYiEKSmyQfxQdr9TJ49hi8lmg1ywzjCCdgt7M+Fqi
	kPkN1Wzep2OSNb/pAS/WdaK+NI4rT6zIf
X-Gm-Gg: ASbGnctMA0q0me0Bg+Uyx2GWECy9jqE9VC/RnvjkQC+njHJX9yoYkei8w/bRk2faYlx
	636FByZhrQHXJ6kpdftWruFInpVmvTfN6nmpAAoaJF3toRdq5mK0rdWyt0yJNi6hl5/tqZaNJwZ
	1vI5FNJZ5Qk9X3HAE41cU/WaxJmsNClgpZAeIc0ywf3XOe7ZOw16F3hNhBNl7J
X-Google-Smtp-Source: AGHT+IHuFLWI7AjxTWau2BAxThXxmTJLAuBCgRk6MO/uleHqhlmFwoVuJBu+tsNKt5gMe3d3UWuNFxwLrymoOnS67CM=
X-Received: by 2002:a05:6000:2a1:b0:3a0:7d39:c23f with SMTP id
 ffacd0b85a97d-3a1f6458648mr7890035f8f.21.1747002847680; Sun, 11 May 2025
 15:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511162758.281071-1-yonghong.song@linux.dev>
In-Reply-To: <20250511162758.281071-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 11 May 2025 15:33:56 -0700
X-Gm-Features: AX0GCFvTJWxQp0kSSvPlhHmfqPHPttNX7Vg5nEtj2SQP4pu_VWFkJf-EbKqHeV4
Message-ID: <CAADnVQLi8dP9uOTcs7qt_9Y42go9NVu4FSEk_eB_=egP3kCraA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Do not include r10 in precision
 backtracking bookkeeping
To: Yonghong Song <yonghong.song@linux.dev>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 9:28=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Reported by: Yi Lai <yi1.lai@linux.intel.com>
> Fixes: 407958a0e980 ("bpf: encapsulate precision backtracking bookkeeping=
")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 28f5a7899bd6..1cb4d80d15c1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4413,8 +4413,10 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx, int subseq_idx,
>                          * before it would be equally necessary to
>                          * propagate it to dreg.
>                          */
> -                       bt_set_reg(bt, dreg);
> -                       bt_set_reg(bt, sreg);
> +                       if (dreg !=3D BPF_REG_FP)
> +                               bt_set_reg(bt, dreg);
> +                       if (sreg !=3D BPF_REG_FP)
> +                               bt_set_reg(bt, sreg);

The fix makes sense to me.

but it crashes on s390 according to CI:

2025-05-11T16:48:18.5929491Z #401     struct_ops_refcounted:OK
2025-05-11T16:48:18.7330807Z ------------[ cut here ]------------
2025-05-11T16:48:18.7333824Z kernel BUG at kernel/bpf/core.c:533!
2025-05-11T16:48:18.7335154Z monitor event: 0040 ilc:2 [#1]SMP
2025-05-11T16:48:18.7336972Z Modules linked in: bpf_testmod(OE) [last
unloaded: bpf_test_no_cfi(OE)]
2025-05-11T16:48:18.7341000Z CPU: 0 UID: 0 PID: 109 Comm: new_name
Tainted: G           OE       6.15.0-rc4-ga9827e5c6a13-dirty #13 NONE
2025-05-11T16:48:18.7343245Z Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODU=
LE
2025-05-11T16:48:18.7344697Z Hardware name: IBM 8561 LT1 400 (KVM/Linux)
2025-05-11T16:48:18.7347056Z Krnl PSW : 0704d00180000000
000003320039d8ca (bpf_patch_insn_single+0x29a/0x2a0)
2025-05-11T16:48:18.7349372Z            R:0 T:1 IO:1 EX:1 Key:0 M:1
W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
2025-05-11T16:48:18.7351910Z Krnl GPRS: 000002b200000016
ffffffff7ffffffe ffffffffffffffde 00000000ffffffde
2025-05-11T16:48:18.7354602Z            0000000000000003
0000000000000005 0000000000000000 000002b2000b5048
2025-05-11T16:48:18.7356934Z            0000000000000018
000002b2000b5000 0000000000000003 0000000000000002
2025-05-11T16:48:18.7359164Z            000003ff81badf98
0000000000000002 000003320039d738 000002b200687840
2025-05-11T16:48:18.7361217Z Krnl Code: 000003320039d8bc: e3005ff0ff50
sty %r0,-16(%r5)
2025-05-11T16:48:18.7363048Z            000003320039d8c2: a7f4ffc6 brc
15,000003320039d84e
2025-05-11T16:48:18.7364611Z           #000003320039d8c6: af000000 mc 0,0
2025-05-11T16:48:18.7366106Z           >000003320039d8ca: 0707 bcr 0,%r7
2025-05-11T16:48:18.7367449Z            000003320039d8cc: 0707 bcr 0,%r7
2025-05-11T16:48:18.7368855Z            000003320039d8ce: 0707 bcr 0,%r7
2025-05-11T16:48:18.7403748Z            000003320039d8d0: c004004bdc60
brcl 0,0000033200d19190
2025-05-11T16:48:18.7407899Z            000003320039d8d6: eb6ff0480024
stmg %r6,%r15,72(%r15)
2025-05-11T16:48:18.7410576Z Call Trace:
2025-05-11T16:48:18.7411713Z  [<000003320039d8ca>]
bpf_patch_insn_single+0x29a/0x2a0
2025-05-11T16:48:18.7413433Z ([<000003320039d738>]
bpf_patch_insn_single+0x108/0x2a0)
2025-05-11T16:48:18.7415210Z  [<000003320039eb72>]
bpf_jit_blind_constants+0xd2/0x1b0
2025-05-11T16:48:18.7416879Z  [<000003320020b5ee>]
bpf_int_jit_compile+0x46/0x448
2025-05-11T16:48:18.7418417Z  [<00000332003c12d4>] jit_subprogs+0x594/0xbe0
2025-05-11T16:48:18.7419782Z  [<00000332003dacc8>] bpf_check+0xe28/0x14b0
2025-05-11T16:48:18.7421128Z  [<00000332003a9328>] bpf_prog_load+0x4d8/0xba=
0
2025-05-11T16:48:18.7422570Z  [<00000332003ab976>] __sys_bpf+0x98e/0xdd0
2025-05-11T16:48:18.7423887Z  [<00000332003abdfc>] __s390x_sys_bpf+0x44/0x5=
0
2025-05-11T16:48:18.7425227Z  [<0000033200ce61b2>] __do_syscall+0x132/0x260
2025-05-11T16:48:18.7426522Z  [<0000033200cf162c>] system_call+0x74/0x98


Ilya,

Could you please verify whether the fix is related or not ?

