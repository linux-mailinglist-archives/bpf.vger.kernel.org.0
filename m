Return-Path: <bpf+bounces-54361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EFCA68459
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 06:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C32188F748
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 05:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79194212B04;
	Wed, 19 Mar 2025 05:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgMa4xPM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54FA29;
	Wed, 19 Mar 2025 05:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742360654; cv=none; b=BnzFk0FEzVFQWs53gVEsyC+sAb9dt+zJu/UsgyB/SHGE1fiX7CE2XQ9TpZ8Ys+CrOlw3gadUBDaDzOOUAfeJHctNuu4kjnys4IG3IVpaFEgOz5v3NKSXkPWtPdvETVOQJX1fu+Pi1XwEfvmp9E/V/FtAKHDftA2XAjwjJAyum4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742360654; c=relaxed/simple;
	bh=K9cqEsrg10sN2hEPIv2LuuniTdu3Pv38pnqwmx25GQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4sz1efzecza5RhAcinfDJYLCUyMvBTKurnMqWq25whyhgkVqzkQXEqhNFdfNE6PfRpIKfzuydi92Ya7/bILLcQQHuQFZs/RZaBnbr6uHE6kCy8XNDF05ygwFy4KdZD5qbLZdfiPcI40Jk905t4bDCim9CdEsQlk0NyrUsWDvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgMa4xPM; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30613802a04so72445801fa.2;
        Tue, 18 Mar 2025 22:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742360650; x=1742965450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9cqEsrg10sN2hEPIv2LuuniTdu3Pv38pnqwmx25GQQ=;
        b=FgMa4xPMm6bLClFkXK6ufTLTjRQy1aS++DLqbPSOcnA0moTI9asQPqX6IXJiv8HPE+
         ySH2RKu3fqx55COJMbh3HTOVt1DPhnvtwBqtXdeX86dXVEcBfwuBDu9D/02yms4sAvpG
         1qkMrAEE9qyNz2SltmasxBbTPCofFL5nHwaqqu6daRXtmOrtwKnp6tenzahBsPDFR3ob
         /V9+Y9imGnbAT1Ndi/yxW5v+5z2iNh568H3HpZDBJTwS0gnvQi6XRwSz84CmScgZT450
         vrIDL1Nn+d+dGxpN4rwPDgguyEFPpdDrrBeo5EINRYjV3+XKnz/85Ps66B9awd+e+/Z+
         +O1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742360650; x=1742965450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9cqEsrg10sN2hEPIv2LuuniTdu3Pv38pnqwmx25GQQ=;
        b=nqqvKFXdx5OxEEZbZYSBfXHDFLbHp1PyQa32La2oHPralig7qivTBCtiOD7F9GjzxG
         bNvSVCkq5Gs+D6/xHtufbl5J3XnQ+dwFiDVddc+3oS0NH/5wUtFv3IVKY51xu20+36dr
         HpNs+zNaU5Qn4hPe9hoMJtSKRCj3jcl3BMd4UPds93skb9P1QL/0WADNzBsZk6wmgTRg
         iTB+HGwLtHEttrxXsclxkDfkpbtmosdWG4dxJurVewO8JZAh4977RQ189YXgChaQN2cL
         zF27DV0nTKDWQOCejWwVAtxGdv+4lqxVfMQrUkLbh6dL6tsVhDtxhkHolxAsCNQqocWb
         DaQw==
X-Forwarded-Encrypted: i=1; AJvYcCUP8ZGwDoEjKaiGQ1uxz/mSmeS3C0uUUcpIXidxbEfxfawfvgEKUAIwjE5P4vI+fMSx88A=@vger.kernel.org, AJvYcCV0+O/h58HYtPl+022QR7u/T1VDRalBW1lKUHe8OYd4oMaerfKgKBCeC5ZeiNsl3pu7ptrBhyYH@vger.kernel.org, AJvYcCVFg4usg5yESJp0NgBjRdeO09dk7KZn+SZnhrvLh3kmwcZ2npTU+6VkwwjwF/4ffhoD5Et9eib8dfKb+Q==@vger.kernel.org, AJvYcCWuSEeSLLsL8EOVijMLPukuzzujhSy38mzqUVlR+UavcEwQcrt1paf+dhSEk41qUmk4136JbmpG6xohyWbA@vger.kernel.org
X-Gm-Message-State: AOJu0YziHhOVqzO2IzhlNdUSiA4cPsXkPC6XbeaWajvfZbD7hnvhNTsX
	Ec8EY4RdkGBB3jk/dOD6AxWzP3yTDhBzmQQ5biEk7SuKisywvAiW8dBPbSlwM+Lky/uRexSqcfZ
	WMatdoXDZMPzDyHLk8fVcrJfbecBAys0a
X-Gm-Gg: ASbGncuCzc7C7CfPV9LnmM8CVFKigcIyJD5RxKnTDJYKRoWvPDEYtqd8BtzObQoshPp
	kmLVQtrIAi0PsphuG0NZQOjNNzSzLFfLTHSycsPy8tbcUOntgdEz7cKeyl6zqMMYFxGcHfzFx2K
	06iDIfpHNwulFdX0X4inDPMd5LnA==
X-Google-Smtp-Source: AGHT+IFBEKm7QSYXMFei+Jt2Q0kxGJr9qdw9JtrNW3V3AckRCmRUVFTGuZniOmWNfxwEKa+V9BlU7nHb9lygs5woRiA=
X-Received: by 2002:a2e:3812:0:b0:30b:ef0f:81f1 with SMTP id
 38308e7fff4ca-30d6a411061mr3691261fa.20.1742360650242; Tue, 18 Mar 2025
 22:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319133309.6fce6404@canb.auug.org.au>
In-Reply-To: <20250319133309.6fce6404@canb.auug.org.au>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 19 Mar 2025 06:03:58 +0100
X-Gm-Features: AQ5f1JrBsC7ZnHFadNWISPWdsbiOW1kMeosysAWck6DOgmlA0PRxbvzsNi9Gfvc
Message-ID: <CAFULd4aaOPYMpSWN=FNueoqXDKKfLu7P0NLr2DU1J2HKgxr_8A@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 3:33=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
> Caused by the resilient-queued-spin-lock branch of the bpf-next tree
> interacting with the "Enable strict percpu address space checks" series
> form the mm-stable tree.
>
> I don't know why this happens, but reverting that branch inf the bpf-next
> tree makes the failure go away, so I have done that for today.

percpu pointers are now checked by the compiler, and their address
spaces have to be handled properly. It is like "sparse" rule, but now
enforced by the compiler.

This functionality was in fact introduced to catch programming errors like =
this.

Thanks,
Uros.

