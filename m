Return-Path: <bpf+bounces-45687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D899DA1D8
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 06:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24812846BB
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 05:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D817143C69;
	Wed, 27 Nov 2024 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klm15TlZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6113B588
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732686715; cv=none; b=rui6yAhEPSugLYYLMkoLZwtZhSiZLA/AjeTE1Rp5Yof5kSvGt2Q3RTGSQ6x88AVMv8SyEo6KpgY7cv9CogvdPz6qM4vfkgjTppfW6DEVM2y3t+TfJktJkKCQ+Wb/KY+LlTOCbDYF0wRrLmXDSSj0hLR2DIypr6pJTTVGQhBvkVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732686715; c=relaxed/simple;
	bh=Isi7Giy3STaOaJuNmL8NKXvCSA55v41YROrstdfoUQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ywpgxv0lSbqfc0r3I9T6saLGwht6lfai7AA5ylPmATlz8i+HEyRkcJrtLJypOF3fjvD2ybdGtmozvFpS+w2ktm6Mv8rVcGPLniCeWpcD9lLpx9hIWpfDTYaVj7HP/0mBRTTyX7LZqqeqM9bF1aXIrfeTgiWvY2ktnowWiY5xJcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klm15TlZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382411ea5eeso219620f8f.0
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 21:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732686712; x=1733291512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwKvzZUTOUZ8mWH4+tU1BkrocfP08Ks1uCcj1lFTyK0=;
        b=klm15TlZ1yXaZH2ZUIHzt9BbAEjEFHbZ348c0gvkvq/PTdLFaZd4wK2rxveEIp/zZ+
         tuAJZa0HL+vbzorHv3x+elo8zQE36bWGhC36GCJ3QvUUNtZdJSll12qh5dDeuTfe2khg
         FWHSY469ETlAYwvIMaf9j6l1gYiVeC6uocTGlOmDA0VM3o6f+rqXOhw7neWMpTyOJuKi
         uD7+q4M3ni34aeTviOKH+Uoo17IdoSsYB1XJFdtObyEaAVbfvyDv2eg1aNaB9QHQOMUc
         5U4Pfo9SRqRswejVIPUMv1IFWtoo/9MOl6vMEmzv5Yb1p9oevd+12CJcIWlNJrW4t5us
         9O/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732686712; x=1733291512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwKvzZUTOUZ8mWH4+tU1BkrocfP08Ks1uCcj1lFTyK0=;
        b=ShEN3yxurCMhkoP1z2taIuNIF0sn4ozuVnAg8mDLBmSs/T3zvYXEPWiX1WSS36Zl5R
         ukRF5ILybFLHgNHoX8lJXHJfvzRbAOSmHecl1gqkd1u7H4aXAoe3LLvTOGmriGwC6bpV
         UxZCA8tF1pIJ+QB2kvk42Rj2umsPlsnMUsMpQ10Z2DbM6Ovz7nKPTUSsNpX51kIqkAC+
         d3OaP61FpkKxXSo7W9YDxvnOrbSOvzRV9fIrZDMptJXUasour4MzfJHN+FGKNz+ywbrb
         z6iOE/ZLpR9OFefOXnrV0SMzP/bhlMxRE6Teuqqpz5voAqZQN+A5QXilYP+Hun2/LmbM
         nuzQ==
X-Gm-Message-State: AOJu0YwqOLNcbgD5xK+8IfNLLbmQhFe38nJalDsR5RnrpzuhyKc5bZKj
	GDQNtw08CobGYQ5RB3ioK3M2x2BS2IVCGOZxZ3ZyX88X/Ud808qbm3NSrOQEBjU+YRBr01v1jDk
	0F7kzoYzVkY9/cqcOsVuJxTvw7Z8=
X-Gm-Gg: ASbGncuhHIFBNcUEGUjtGmhK1qav8jHVK5HyVfaJjMxg2f32DMLdiatHD5JWKWGBSyU
	SP+aWgXvIySLMbfMjC5W8xz40l1A3oHp/pu1X+EFVeqUIlR0=
X-Google-Smtp-Source: AGHT+IHyJPcELY/52nFCXE459KqfNmNN7a8Lc7z7ye9AvmUcYchOig70RRL4/kjTqxelgSoT1qvvj1yMJu86lP5mfe4=
X-Received: by 2002:a05:6000:18ae:b0:382:484d:45da with SMTP id
 ffacd0b85a97d-385bf9ee227mr5103527f8f.6.1732686711562; Tue, 26 Nov 2024
 21:51:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127004641.1118269-1-houtao@huaweicloud.com> <20241127004641.1118269-7-houtao@huaweicloud.com>
In-Reply-To: <20241127004641.1118269-7-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Nov 2024 21:51:40 -0800
Message-ID: <CAADnVQKZ3=F0L7_R_pYqu7ePzpXRwQEN8tCzmFoxjdJHamMOUQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 6/9] bpf: Switch to bpf mem allocator for LPM trie
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 4:34=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> 2. nodes are freed before invoking spin_unlock_irqrestore(). Therefore,
> there is no need to add paired migrate_{disable|enable}() calls for
> these free operations.

...

>         if (ret)
> -               kfree(new_node);
> +               bpf_mem_cache_free(&trie->ma, new_node);
> +       bpf_mem_cache_free_rcu(&trie->ma, free_node);
>         spin_unlock_irqrestore(&trie->lock, irq_flags);
> -       kfree_rcu(free_node, rcu);

...

> +       bpf_mem_cache_free_rcu(&trie->ma, free_parent);
> +       bpf_mem_cache_free_rcu(&trie->ma, free_node);
>         spin_unlock_irqrestore(&trie->lock, irq_flags);
> -       kfree_rcu(free_parent, rcu);
> -       kfree_rcu(free_node, rcu);

going back to under lock wasn't obvious.
I only understood after reading the commit log for the 2nd time.

Probably a code comment would be good.

Though I wonder whether we should add migrate_disable/enable
in the syscall path of these callbacks.
We already wrapped them with rcu_read_lock().
Extra migrate_disable() won't hurt.

And it will help this patch. bpf_mem_cache_free_rcu() can be
done outside of bucket lock.
bpf_ma can easily exhaust the free list in irq disabled region,
so the more operations outside of the known irq region the better.

Also it will help remove migrate_disable/enable from a bunch
of places in kernel/bpf where we added them due to syscall path
or map free path.

It's certainly a follow up, if you agree.
This patch set will go through bpf tree
(after hopefully few more acks from reviewers)

