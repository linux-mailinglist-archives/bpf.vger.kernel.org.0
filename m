Return-Path: <bpf+bounces-77570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3AECEB55C
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 07:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 483E33026B29
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 06:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5780331062C;
	Wed, 31 Dec 2025 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNHLHECs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D218CBE1
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767161893; cv=none; b=EQsmxCTLwIzX5nNziQfIUjB+VWRCCIvNBN6tWWe5C97wHG6qhZ6L+YY/VqzjAcHhr/yD/P/Bd3BMDXDXNDrrg8OYxRVqwr2jxRlXW/+bZ6sg2uG/LfKn/i6ei4sX+3DrROvV84S1IvgM+R3jGQYx3VQqmZ3h/4iTQKNjVNS9Oxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767161893; c=relaxed/simple;
	bh=HEMKX1gAVWF6u4wFgM4kD2y92lncAAX3Akj+9zK08wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVU0ajrv97WTA2mwzPRIWqbjDd6EDcRS8IWFg2d9CeUs4YQPZuzYDavEPgnx+9NWY3mw1TXM05uNKdcbMFVFzE6pk3HKkzRz2GLr+DOO3wPxhLRmLyq5CUZK4njzkr27hKccIt6Ob3imULR1kBOw4mkztmaxdT6wLCdirUDmHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNHLHECs; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-644715aad1aso12280158d50.0
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 22:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767161891; x=1767766691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddzeUStFONqIx1aXW+JxsIdCzA36/HY/XY20lMxIU64=;
        b=CNHLHECsDf6oVgUlrOoVQXekTUdtRJi+YL+UR+hx3TWbGJGftxvRL3Laq6i1T1Q3Ce
         a/Qa0U2sYZSAJuD6XYGsOlH0d24oJxuB6Z5YBerXmfmmWOjdtOour0T23J8Y0WTJ90ed
         Gt6VafeQf9H9io+NX0qtSG9jnE6rPjEINv91+K1jBXGALRGnTqcJnWynngSFDrH/PTXJ
         7jLpoEtkHqGJf2qk+1NT+RBWwiiy9bFra2CByv6rrogu/32ZFy28kg8AgT1Mak2GC+IG
         Or9ClzozCYcowifsVEnQvNQOwU+LWWJOpNzTEq1yVdecufJ6qcLaVdPuBXcVqlcvmcaN
         pliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767161891; x=1767766691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ddzeUStFONqIx1aXW+JxsIdCzA36/HY/XY20lMxIU64=;
        b=P4FSiG8W4mxkJbmeqxxeBoEWo0ZM8ONxFAVEzmvypGu3KuiEByzBLwaEpnxJ/vmeKm
         nJwUC0vxL7AuoH3qp9cmZqhdzRcuG1bgrk4pAQElqc/4NkDsdudCOaR1S+Qq/zZlpUiw
         JDacvDy7eoCAtU39FfGT7B857J5mtQ2TxMNaFTwU9RqQyaLQUbSab/UNgmmHGOQbTpMb
         tL5ojOASUgowrqXW4TcgFIE1UywrI58wNYAEjDYwznfuQsxPcidbtI+0PnTmZ2JdNoz5
         Br/vFfC8qcgyvT6W3aBznicQF5+vjvDSUc34HZ7CyFS+HIDHvlQOtExTdjSjM2Oe9rex
         AgFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdfqe7SmOsDq/8yW4H8LTPcSoEdqSCsquqmcfn4K8SaQBcRnO0KeRlYTCS53kdwpjLDBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxYzwXgZxXZ0WLQMw1/0k9STnwgDx1pYFw8Uhz52j1P1TBRbcK
	18nWrrnmHit6GP7k3nImuf94q2UXSOLJu7Ct5hqUZNmeN2Ou13VW5COFFuu1jTdcaWtiO8HBHhz
	O+XENtt9xl4zXkII3GJye5u/7PldB1I8=
X-Gm-Gg: AY/fxX4KS3+3ucCfEeG8kvNfKm2UqdS5Sy34VFHV053pJPk0Xc/jezA6TLQSwmRDy1y
	BPVY38hBVufz/qW3FXPyyPAoRGep98ByLcfbyWxWu9x5MSp0Ufvybhe+sLqhw6b7L6rFKWW8PXG
	S8DVbX+mnsTLYfE0OQg0MUnm93n5Pb2Q3+sRxdhVJOmysEHcku1miI+J19PB61l6VRkmIP3hYcj
	iSNR0TjwwSqkzJYqXQV1dD8D6eh9buvO+pBCZLlbF32cwfqUiGvG7Ku2YuwXY2HTyXQd35SVLRY
	Fimq/w==
X-Google-Smtp-Source: AGHT+IG+GcO6uN1TpV3Zbw1on7PQ9Zhkc0TL4TXergd2EvC8gMaHy0KrA0QNNWkDEtI+CH1zS+2LKC1db1GdhKMMO64=
X-Received: by 2002:a53:8592:0:b0:646:69a2:d400 with SMTP id
 956f58d0204a3-64669a2dec2mr23305338d50.10.1767161891401; Tue, 30 Dec 2025
 22:18:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69546dea.050a0220.a1b6.0306.GAE@google.com> <20251231031754.299998-1-buaajxlj@163.com>
In-Reply-To: <20251231031754.299998-1-buaajxlj@163.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 30 Dec 2025 22:18:00 -0800
X-Gm-Features: AQt7F2q0tFCibzfEcQT0gZ-XceqecG8RcQbLhIgBiqBmFL3lJQYT0v5OLcxt5_k
Message-ID: <CAMB2axOZeGGXiO-6uXOa0HUefDjoU+7_287K3au0EMLxnWu=4g@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_get_local_storage (2)
To: Liang Jie <buaajxlj@163.com>
Cc: syzbot+4fe468a3f7fac86ea2c9@syzkaller.appspotmail.com, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev, liangjie@lixiang.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 7:21=E2=80=AFPM Liang Jie <buaajxlj@163.com> wrote:
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it 3f0e9c8cefa9
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 69988af44b37..2bc27ece5cc5 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1768,6 +1768,9 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *,=
 map, u64, flags)
>         ctx =3D container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run=
_ctx);
>         storage =3D ctx->prog_item->cgroup_storage[stype];
>
> +       if (unlikely(!storage))
> +               return (unsigned long)NULL;
> +
>         if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED)
>                 ptr =3D &READ_ONCE(storage->buf)->data[0];
>
>

Hi Liang,

I don't think we can do this here due to backward compatibility. The
return type of the helper is RET_PTR_TO_MAP_VALUE. Your proposed fix
would require adding a PTR_MAYBE_NULL and existing BPF programs would
no longer pass the verifier.

Did you look into why the storage pointer is NULL in the first place?

BTW, there is also another similar report and a work-in-progress fix
[1]. Do you think this is a separate issue from that?

Thanks,
Amery

[1] https://lore.kernel.org/bpf/20251203195050.3215728-1-ameryhung@gmail.co=
m/

