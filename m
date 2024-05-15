Return-Path: <bpf+bounces-29791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450A98C6B82
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 19:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764D61C226EE
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14B451C2B;
	Wed, 15 May 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myAIAEZb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960324CB36
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794387; cv=none; b=i3CQepSjv1IKr2RjmhZcYe5zM+i9XAKFOwIvQM2GffGSg9XAq4DylKfRbEwBoo+7vw9kxbxyyGWpPOp1jYYsF1mp81z0P6CC1PPhFDK264qdoDu/6ktcMK1T7KnsnCn/1o2kpuv6//+vLIzedFpOpAtwyjZN0VkIrIrmOJKi8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794387; c=relaxed/simple;
	bh=BnH6O+aaOkOEGa46rYLRIpbIIGlfHwp76z7nEmXksNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMev7c97nkTSW0cHV+NViNTNnmqT2eld5CWM3+if/K8CfYHGOXXYH7YNFgIDKu3lNxM4nwi5c5AErX7Q9TZIYhXQApPevSvmiUi57MY2wXcSsaO1yTAsz+Zi3kl00Chk21PE3BDWP8zPt0NktdzEA2mQXApXE47Atz9WB42euJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myAIAEZb; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a5a0013d551so112310766b.2
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715794383; x=1716399183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BnH6O+aaOkOEGa46rYLRIpbIIGlfHwp76z7nEmXksNM=;
        b=myAIAEZbWTFTmZEgQFEy/azmO0Jd0/59TSBFm9Fqp/jM+nVVettXiJBWpjxkG8RmXp
         O/CKEgoVI3AvYh3I0psKdDIMsvBWZjiYznYeyq6y50D1jO/U1WxAe/CFrZVjA0UZqOkm
         b6dpi+bMoJuHYPpXc3sKXDG77VhNBqyji/WTpOz0ljAX5R2ap3Kxu9jw8Q8zN0UvzJCY
         rH2r4uASKtMTYlRcB43/ElF6aDufdqX3dYgfDJlSHrj0MGxrP/ysLlvDu/qbYLZb57d3
         N67Dhmf4BeZGxBnwMYHC3ACdx6v8LioMjZj2VD7ngnA802HyTkQC0EGPyEOWSz94Fi4X
         +awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715794383; x=1716399183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnH6O+aaOkOEGa46rYLRIpbIIGlfHwp76z7nEmXksNM=;
        b=jLE+sfRhh3VhdI41SRKibdmRq0Z+EyCq/npytTJm6zYSpTp2AjdyehZdSncmCHY6wj
         wJnCDKymbP4nUN0UHp5zJDYZnDp59qKujuaQP/VVQORuQFa6bGOApNslTb9U3bS48IoP
         Y9rSRUzqZkdlpjBE4y6Xf/l5jSDzvk3Wb2lJYq/d3HJAkQhNoY3jLZR3NPIdxUWe4xqu
         F4FYwMO1y8ZX6QOJvJENC9KkK/kX+z80F7XEO4oeIGM2ObjBJfvHQQhbhAwVbYuEj6Yn
         4cHfNhDR8L5E7YQ1YXsjsYHqWJOBpy4TWzZN2t+kFl26CPDjhF26Cpsj3uHf0FiMC5Vx
         sKDQ==
X-Gm-Message-State: AOJu0Yzle5JHks7RLVxkc298taebOswg/qDzo0QnlRUjqtdDQfJUvLNl
	HwMENlqnSKTcFKpfhT8gWSDBfEbdGgX75l/xXMj6bPomcgn19qFdQ6MEeNmq39qWEG+T1P+oel0
	jy/dh71UJ4xSeNh7wKPN34sSM5jk=
X-Google-Smtp-Source: AGHT+IGS4DrRGVFx8hoWFi2oAXFJ1yCd1CtegTCE3XWN5JNGbSpAlVCwn5iC4XgROw/tDX6R8gxY3T2DGgzReTDrchQ=
X-Received: by 2002:a50:ab58:0:b0:56b:829a:38e3 with SMTP id
 4fb4d7f45d1cf-5734d5c1701mr13258296a12.16.1715794382669; Wed, 15 May 2024
 10:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514124052.1240266-1-sidchintamaneni@gmail.com> <20240514124052.1240266-2-sidchintamaneni@gmail.com>
In-Reply-To: <20240514124052.1240266-2-sidchintamaneni@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 15 May 2024 19:32:26 +0200
Message-ID: <CAP01T777zErv2x8AsDKnPeCm+_Nds-B4ufs_s_-2vaqQF9EUiw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Patch to Fix deadlocks in queue and
 stack maps
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net, 
	olsajiri@gmail.com, andrii@kernel.org, yonghong.song@linux.dev, rjsu26@vt.edu, 
	sairoop@vt.edu, miloc@vt.edu, 
	syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 14:41, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> This patch is a revised version which addresses a possible deadlock issue in
> queue and stack map types.
>
> Deadlock could happen when a nested BPF program acquires the same lock
> as the parent BPF program to perform a write operation on the same map
> as the first one. This bug is also reported by syzbot.
>
> Link: https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@google.com/
> Reported-by: syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
> Fixes: f1a2e44a3aec ("bpf: add queue and stack maps")
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

There are a couple of extra newlines, it's minor but can also fix them
if you respin.

