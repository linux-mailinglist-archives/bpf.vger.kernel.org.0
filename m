Return-Path: <bpf+bounces-72184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D10C08E43
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 11:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 518454E4AE2
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 09:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57C02D7DD0;
	Sat, 25 Oct 2025 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUyzPYDS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF567DDA9
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761383431; cv=none; b=BRJuoOJaTu23VhniPAlx20OZiUZBm5MuDftydTEixJxzjTvtnDPSxV/3B8/JRjsCpGZ8QRSyKRqkaDbG4L6d53K33JGmx54N9p4oX7J1Z37tTJF4HXADwG8pjwrMswqgiqxO28rXAt4wMJoxUsMhGrZjTtd17yjPqxxzDMsz5y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761383431; c=relaxed/simple;
	bh=+dh9ZID6S13botEdBx33Bjjmhjr8VcnrKxwvkT33DLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7yToOJR1/d5y7M+wSCNWcCjA59Pn4eASS7h8/oo8FXiv+9OSwmLPo/q3ujUpGCvHJOYi9Cm3snSnMD9OmCgK43wWmy6xvjad/YtxYf6XMppNqYPCaEOXeObDjAaMjyNzXqmRNLBbCIfvFY9yF9gHVJl+NNInyZs9Fhqsy7NMq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUyzPYDS; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-940d7cd5045so124899439f.0
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 02:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761383429; x=1761988229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fzgs/MggFO7bRdso2leVmefczP9Yg5GRKMMwO23N2o8=;
        b=iUyzPYDS8jptawWTDjRBwbbSb+L/z+3+RIVTRCOsPcslOrS2bKu2oQw4C8KcWm+gYG
         hrbhQxmop/Jukjku6EG2wQugPuHNriCRyiYqHZlBVgMTYPbVV1rtOJUnTijeG2gGGtbj
         BEDLo2Vx2Ps2JBASz0lRUBtiKogien84VLOIHyhWCgrkN4NSLS0nM+EIRPc/5dQizAhB
         /5pXkuioGkI666/4oFFZmgN8XoQrEs+uQPPkNhv/FLSFjVVR1eebYX7ocqREjrubr5p5
         Y3bpwPtG+hHt5/SG7zHmm9N713urWwMzxCFlCMZ3Fwnh60Ws/KUzQebeGBOZS/03Nvt1
         iucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761383429; x=1761988229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fzgs/MggFO7bRdso2leVmefczP9Yg5GRKMMwO23N2o8=;
        b=rrc1ph5tqiXaD3km1yTMwRpo018ihWi3V8qrcXiHiEJKn+s3bX6V+fwlfPKLsa+iyb
         IG2gXlqDRf7btVOEodk9HsqYaBeCaI96JFGRloMPXZeA0odU4Lfc20t8/1az4alwu6qE
         TcU3+MQdz4nYCRr0UmHXyjxQwQPtLN+oT0yiQH/okiuG818jXJoz2K5ZzI8GyA9rBF3D
         VuKueJKWXVCrkm2K6p5u77ypNsAS09m7CUveparJnYQmP4huSOulme2c3i/yru0Z7E7c
         0f9qBUDWbvMHA2retyDxCLSUYvzLWj1mVHVqcYYhyC0pJZlVi4oTmo+XtSTNdj31P/3J
         J7Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVeCZH+79fZoDTDKH24NHzINqcaU/l7T4htNYgOi+ni2oySL5MzVvIDze9xLYWOx6J+xsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7rHvXA+o+HXF34cpxWddwklWRZrGCTKgogOX8bn3xQ+TNee2S
	odAzwDUym7/zIybduh7I9UfvqBe1r/aV6yJAIy7A/5WkJyU9DDlC4AEucKzuQGNPW1rwba7RNXI
	YFBg4K+BKCnoEyY6Y/5vhx4ZpsWfvLSc=
X-Gm-Gg: ASbGncvDNWcxKyixZ3T99xE8dtN9n4eDPop5fxUYhxFNPxXVDh2c/FezzfC/SZKbi9F
	Q95v5MnVOF8x816jARiZjEgTwFiDDaQrF5AbPMQAnBNJLckb/B6bRsa0AJWadWBrD9wClkgk1lm
	ON2+ACMlqZkUwJC5awhcGqvGxzgNG5hJcTe4Qlq1SLtdopO4QjCvvhVBzvzRSXfZyH+2zJtkKm7
	3B7zL32CQxULpV51XvHfhvm2bYj9bZJnCQNpyQ7asLMAZ438TkAQbHzmew=
X-Google-Smtp-Source: AGHT+IGsL0psFClfGN7YpBYlsl7QR+D7+uODL2Xdw5QnAJZf9Y12m2LGYkBe4CSwXs8Ylwl/u9ejOn0rg1jEnFeybuY=
X-Received: by 2002:a92:cdaa:0:b0:42e:72ee:4164 with SMTP id
 e9e14a558f8ab-431ebed7bbdmr58753815ab.23.1761383428986; Sat, 25 Oct 2025
 02:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-8-kerneljasonxing@gmail.com> <aPt__0JeH9lW-1yd@horms.kernel.org>
In-Reply-To: <aPt__0JeH9lW-1yd@horms.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Oct 2025 17:09:52 +0800
X-Gm-Features: AWmQ_bluboBvA6zF7nGajp1q5XP5f-rJTlMzH49P0tu6VMvaQBDSoF8Vera7RVE
Message-ID: <CAL+tcoBj7ot1_aWOwet+cK=mj0+G9MahfRM4=U4w-7ycEiD=rA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/9] xsk: support batch xmit main logic
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:32=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Oct 21, 2025 at 09:12:07PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This function __xsk_generic_xmit_batch() is the core function in batche=
s
> > xmit, implement a batch version of __xsk_generic_xmit().
> >
> > The whole logic is divided into sections:
> > 1. check if we have enough available slots in tx ring and completion
> >    ring.
> > 2. read descriptors from tx ring into pool->tx_descs in batches
> > 3. reserve enough slots in completion ring to avoid backpressure
> > 4. allocate and build skbs in batches
> > 5. send all the possible packets in batches at one time
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> Hi Jason,
>
> __xsk_generic_xmit_batch is defined in this patch, but not used
> until the next one. Which results in a transient warning when
> building with W=3D1.
>
> Perhaps it's just as well to squash this patch into the following patch?

Sure, I will do it as long as reviewers will not complain that patch
is too long :P

Thanks,
Jason

