Return-Path: <bpf+bounces-66377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E24C9B333DF
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 04:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7615E189DB1A
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 02:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7A022DF95;
	Mon, 25 Aug 2025 02:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/K8pDVd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1842215F6C
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756087882; cv=none; b=JwSQPi++1dmbrJnb2xReZbVGptq5JAquUQ+BYrh5mPzRLpY08VZ3jYBhwALi5URA/MJR/6U5J7SDMCL5d0Ufcc0JVhqvS07jj5rIvgY+HBdGdfEUGk3eEYtAtu/tLcBCLpSLbWescg7LAmjwhb4r7fBrNGLQfe9eiwzhc49RyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756087882; c=relaxed/simple;
	bh=TyW8v0tkCVtHu4cmdJXa1X+Tz6q4M/tb1TgnSbRBk+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pN/r3M1FDFM8ZaxBWQrRPN0RzXp66zzG8IT6hB8F7sjaNvNy0QGoUB8i2OlfhmLNVg6/b6F94tVDsu1u6hrrJotEecCM0lLmmKvctcAOyH+za50dLKmW3dYpMFmKxwt0dTid2SCpDm3Te9WxT53CmykZE0DinLStYfOi9nU96h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/K8pDVd; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b134f1c451so57087281cf.1
        for <bpf@vger.kernel.org>; Sun, 24 Aug 2025 19:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756087880; x=1756692680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zBN6uIrwk8W4rRVF0NfRinFBRrEKDWukDgqTocnXYo=;
        b=m/K8pDVdsP2I4lLJ72Nj8PeOyyYMcPLEx786k6aTzv7+HT+/ejsNmiDA1aCXvd1x0c
         Z4kExLXuG/W3P1zu0dpjEiN2woKDbcQBGCFEW3uOiP94qVQ+REE+tQLvEppdpWQawNB+
         dXcawXBSOZjg81IKR82aiP0R9fpgWGiVt2LrQQq2X6ryRYWWYO55k6EIBoCqIb89SRmN
         ANg3fUHYhidw4NpHX0gnac7Mkrt9fvQqMvclUy4ZzU0WWrOqW1ILjOkw07kuf7YxdPd8
         K1jeLTD2l1tqP6X5JVgB1zBi3rFEzxlbXFkXcDavSdVsP4KeyUSshHkcjGJz7mEjrL8F
         orEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756087880; x=1756692680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zBN6uIrwk8W4rRVF0NfRinFBRrEKDWukDgqTocnXYo=;
        b=WtfxHKLEwzxVzIkmIi3NXB4W0ke0Xcd35I4VH8kUPAoS0ZCUBo9ISdZTzZ33Fuz3Hy
         eIhoiuhKSQTXPXenYPqd7KFpobLYs/q2gh2Iiq7LuN8Kh7Bp0i9OrG9yRgzVFkUTIIZO
         Lqe2ZBBAJmxNFkNKxAbhkPsSrBU5qjTScMZ69nJlF8P3O0Lcqf4AzCADutMNBqO3+fgZ
         KVAb8wIUy8T1x9NBt24Au75mncI9cLyuJglrW2nQTXmsWX4z955IYxfBA6VAct14Ckz9
         mO6FBsX+oTBuLMrpURiFtKZ0YvoqYouZm2lkhc2KVfQf+HM5q7ZqiyLw0Mb/z6BSBXss
         TQrA==
X-Forwarded-Encrypted: i=1; AJvYcCXS5zF4YY3syleQkx5BoGvbVeUg6a2vjCyT2mN93SWaZSaXR0kaQ4BPvagK0WfIw+pQKxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYpryc4dYQsfyULe/ipQuiSEKE1TTqDAyjw+KradiZw/ArEh12
	g3KGgQRJFDC+tQQAHMaa7QfR+M36pWqLRih1rwfdBu3ArQjT4vkq0FSgsoPj2Ll0811aFS1uZMO
	N4r6ZPqFgHJW6ZRoUa6FfsjRT+fsV6cM=
X-Gm-Gg: ASbGncsJx+X8f7zwKSxMuMWSniz6o3X8b1OEa5lnCA6MTusNlar19dSWhl0WDXwo/Xa
	4nm/wgKDRlZjWdgoI46UMt03rMxikKruRDtJot1uDwjEOrcEzbp7bMs6LWL7sNgsZ/umKhXOCk7
	7+fzAGZPCu01fQd7g+lDmoy/n4SAjsxsAvBZDvHbcqHjyaDnu9sbkaNvQ5NdCD0Hsm9q9DDa3mq
	hIxj8Q=
X-Google-Smtp-Source: AGHT+IHVkoUZGowdFSTkgl4LbXKBceF61hSY3wUFutUbImjAU7ryiXeHBgFXlWnqK0JaJStAihQ+74+tMyJaQu9ffKA=
X-Received: by 2002:a05:622a:92:b0:4b2:8ac5:27bf with SMTP id
 d75a77b69052e-4b2aab513c2mr120600001cf.74.1756087879534; Sun, 24 Aug 2025
 19:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821091003.404870-1-hengqi.chen@gmail.com>
In-Reply-To: <20250821091003.404870-1-hengqi.chen@gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Sun, 24 Aug 2025 19:11:08 -0700
X-Gm-Features: Ac12FXzDM6kbMFEc3IG7buSfGiLD5L067Awb_cRPHaN9KsF-VGmAXUb84tK8VFY
Message-ID: <CAK3+h2znPrsopFNc67vXddKzAnfLoLXN+3KPQyG638kDk5E8dA@mail.gmail.com>
Subject: Re: [PATCH 0/3] LoongArch: Fix BPF trampoline related issues
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: chenhuacai@kernel.org, yangtiezhu@loongson.cn, jianghaoran@kylinos.cn, 
	duanchenghao@kylinos.cn, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, bpf@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 5:16=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> The following two selftest cases triggers oops on LoongArch:
>
>     $ ./test_progs -a ns_bpf_qdisc -a tracing_struct
>

I tested this patch series by running bpf selftests as below to bypass
the tests that would hang up the loongarch kernel, I also denied the
tracing_struct that I think is related to module_attach and
subprogs_extable, these three tests I think is  related to
fentry/fexit on kernel module functions and that would hang up
loongarch kernel. The rest of bpf selftests failed report for the
loongarch kernel  is here [0].

./test_progs \
--deny=3Dmodule_attach \
--deny=3Dstruct_ops \
--deny=3Dsubprogs_extable \
--deny=3Dtracing_struct \
--deny=3Dtimer_lockup \
--json-summary=3D"./ns_bpf_qdisc.json"

...
#213/1   ns_bpf_qdisc/fifo:OK
#213/2   ns_bpf_qdisc/fq:OK
#213/3   ns_bpf_qdisc/attach to mq:OK
#213/4   ns_bpf_qdisc/attach to non root:OK
#213/5   ns_bpf_qdisc/incompl_ops:OK
#213     ns_bpf_qdisc:OK
...

[0]: https://www.bpfire.net/download/ns_bpf_qdisc.json.txt

Tested-by: Vincent Li <vincent.mc.li@gmail.com>

> This small series tries to fix/workaround these issues.
> See individual commit for details.
>
> While at it, remove a duplicated flags check in __arch_prepare_bpf_trampo=
line().
>
> Hengqi Chen (3):
>   LoongArch: BPF: Remove duplicated flags check
>   LoongArch: BPF: Sign extend struct ops return values properly
>   LoongArch: BPF: No support of struct argument in trampoline programs
>
>  arch/loongarch/net/bpf_jit.c | 54 +++++++++++++++++++++++++++++-------
>  1 file changed, 44 insertions(+), 10 deletions(-)
>
> --
> 2.43.5

