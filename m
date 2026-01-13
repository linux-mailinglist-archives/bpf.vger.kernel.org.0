Return-Path: <bpf+bounces-78660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F31CD16B53
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 06:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ECC8302531C
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 05:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176B5359709;
	Tue, 13 Jan 2026 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi0P1HkH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705CD357A4E
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768282472; cv=none; b=tlcVKcfHTs8rsqLkIDoxx5gXrlwiY1KcishvvkyxTXqgm1YuV8a8CZxAys4ButUNUh7HmGE32Q3P6HuN7e7l8o9jObcl3YnFBGyntboFj31R+wNfI5GoWMYKb8BVEsvJ6lGMTT2ie0qQjPba8x539YHR14kBsYoFXY4BJRK4kdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768282472; c=relaxed/simple;
	bh=vksA+EIfpcr5nEbE3T0odlE0kg9ymd6yCaeY6w6Gv5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxO8A/M2xFoq1sKp33zoSBh+E+rGEEN4RETMnVUYYHG65cqYD6lNoA1hMxq59Qxs3pNJFPArMQyNhXhBpPMbKNYkU7lqQ0hZzQxrDdBSj798zjiLwY15iGrkVfDXeHO2znj0t4qfe5zRqsM+S5vo/LY8No0CVoUtBuOcJwqkwrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi0P1HkH; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c6cc366884so3740359a34.1
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 21:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768282459; x=1768887259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vksA+EIfpcr5nEbE3T0odlE0kg9ymd6yCaeY6w6Gv5M=;
        b=Qi0P1HkHLkIYX/JKQVkF/9qm9c7ufOIH+uEmfizwjWJ4PTEqwJHPc2VNxHpPMxD2iY
         uQCalXujiFI80t9M+Ay/IP2k0xuFAxQyrzc4I8xv2WIw2PUqr6EcVnzKwln9Ozqzn0bu
         RKZuvEw5L/Ovrd1z0DFb0Af1Nor6NJsy3bDL6+PkgpHLgYDK/cJHpjf0JBKGoQ44yLw1
         HlCRlOVotht318coQf8ZOtnIFB9UllhAo+ngh1nLhmT+2a0Slg6PsXw4UIeazVlTSbMu
         ghzVHvEEZLDGgkDtkHQdbijjNFPXuPqWLglbfEQ0CmnBiEtHAecTiwML4tJxjolZoWWM
         2CpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768282459; x=1768887259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vksA+EIfpcr5nEbE3T0odlE0kg9ymd6yCaeY6w6Gv5M=;
        b=K8/7uwL9jVVerm1D80Y08YOIlDca83w4N7qXt29MgLd9GKiCjkaxH9EPZwoMf4GYcz
         uZlDxoVBP6m/HKpoFYjcP9tr05SC1Ac8Ersx/1/iawS1pUydDgUEU0fhYSKjEk9tXCgu
         biV498iLZvlek4D0T14Ccsko17iacPnc3Rlt6/DD9R67Wn/RZwtAgDSdYnKy1QT0pXhZ
         RRZofjKX28khLsEtef7r4f+qhsxgnztKlOH6Gd8X/M4auJzFHlfJmBVdzMy+m5CziToh
         KQ4z2sA3Ph3e5U7tszzBtzQsp0onQ/LYDqPg3/0wGBtztaVRJkdo2eYx/fkDXx1DEwPi
         KPOw==
X-Gm-Message-State: AOJu0YyqH14irZOlnXF1DNkzmk4eiTXlbm+i77BuGTW0RZDstgmcTSgv
	3er5MmCwAl2NqSWfVYkwFbl6NCMDU3yg822t/2jvG3oylpeNUuNVCs5dA++MkhgkrqPE3cEtwI0
	q986XuQYOu4rIXGerszUPF0i3cRWDOKI=
X-Gm-Gg: AY/fxX5Zc7r3Wg4jchi9mrDbKHrMoR8zokH0j3gRkk0mDch6J2b+T2tuUzLtmMkDkP+
	4PSckBHYwNSxtCYH9S7oyqIdn2HiloiEtBuexPhQicfqqxxDOpU+mOSOkjgsZV8PKrNU38yAjba
	r3BcuAPQKIbCWo/Ocqkbo0aoIRrvmHbALJfOjmVOTSjtlSjESh+TfGaQ7zx/BytoHREs4TrBzio
	cnvp/TfjzKXWnz52ePoFPczuX3MbSfrmrmiSSGW8KJCwcbe1YT+y6mSH61c6gHEgSZQ1jSwfbgb
	lYluirs=
X-Google-Smtp-Source: AGHT+IGUWvJNZ4ZkTAUw4qdkc0PCAeA1Ef1SChvyzkxPUurNCVcqpq8VZPOJBJoics8U1EpcygF6TSKigI0mES/zmgE=
X-Received: by 2002:a05:6820:2282:b0:65f:7470:38be with SMTP id
 006d021491bc7-65f74703e4bmr4185292eaf.61.1768282459515; Mon, 12 Jan 2026
 21:34:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104012125.44003-1-kerneljasonxing@gmail.com> <20260104012125.44003-3-kerneljasonxing@gmail.com>
In-Reply-To: <20260104012125.44003-3-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 Jan 2026 13:33:43 +0800
X-Gm-Features: AZwV_Qia6l88ADQNzz1m_sO2YC4k30nIzEfbrxq1JjMEght9dQfip4Vy5SfFItQ
Message-ID: <CAL+tcoDgNWBehTrtYhhdu7qBRkNLNH4FJV5T0an0tmLP+yvtqQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/2] xsk: move cq_cached_prod_lock to avoid
 touching a cacheline in sending path
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 9:21=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> We (Paolo and I) noticed that in the sending path touching an extra
> cacheline due to cq_cached_prod_lock will impact the performance. After
> moving the lock from struct xsk_buff_pool to struct xsk_queue, the
> performance is increased by ~5% which can be observed by xdpsock.
>
> An alternative approach [1] can be using atomic_try_cmpxchg() to have the
> same effect. But unfortunately I don't have evident performance numbers t=
o
> prove the atomic approach is better than the current patch. The advantage
> is to save the contention time among multiple xsks sharing the same pool
> while the disadvantage is losing good maintenance. The full discussion ca=
n
> be found at the following link.
>
> [1]: https://lore.kernel.org/all/20251128134601.54678-1-kerneljasonxing@g=
mail.com/
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Hi Magnus, Maciej and Stanislav,

Any feedback on the whole series?

Thanks,
Jason

