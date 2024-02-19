Return-Path: <bpf+bounces-22259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF2585A6F3
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 16:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79830B23AA2
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73940BE7;
	Mon, 19 Feb 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUODdbyZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36CC3F9FB;
	Mon, 19 Feb 2024 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355203; cv=none; b=dMe8rxzB5nQaTY6CD5JqMW/C0RnqTHydzWcjpXMnkyGZ0QT91GAoE+vBqz+TIoJvhwROm0YBsQ1R/E3D/pRP4+MdeOCNY7OQEIfvukKqmpwMkIZVkW3Wmf+yOraPDPuaruM1LFjsCNol94nkjQWTW5tCDdKa3unJuYsJY9l7xMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355203; c=relaxed/simple;
	bh=nJGhWNzAdmlA3lSqk7zXCDQYN188FpjuKH/iLDfwq2c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ad1jEjYAc9WuiVrQvJ4qnHh9A0BtkEI8bZ+py8eHuP5mzKY8DNu3WXLG3+RLeRfTEQyBKVg2G81JMFxytYNQNI3MRtwL8LotOx633l9uBzItpgr6W4HJKuSUG4l6CXLp2tp9+7/Uyr/UX/tTRVAZzMUSIHUZAbrbozJDh/gmiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUODdbyZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d61e39912so167090f8f.3;
        Mon, 19 Feb 2024 07:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708355200; x=1708960000; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yOTnLimYUvPNkTFJn38nSneD1s53IeoM0jyre9BMIA=;
        b=LUODdbyZc0pEfVSAgx2VGvR6lMov2ggBmoSF/ZjJzEbE7w9PvfkONZmmFTgtMuPWGG
         7Z1tTJSL/YOBww6XBbHeAFv3eRcbN1g9us2cc6aL/RmPw3rz25xB6tzwUSiMGTb5ZpER
         GXfrXVfCdOhKCmZO19VTQOmotMVjHdyema14bct92dqfz9tA+G6Br2YaHCYMuOHrII+9
         kb6lXzZ2WOg0viqBwDzqJdmeq7GoZOHFF2o06zKziifQ0pURjF8o51PpM9m+rbJqPAG3
         VCj6frLih4Q9SoYWpRARBRfFOVn/+U+BiHqz91rETT89QVUFJC9SVRBmlpEOCjWeKfQA
         hRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708355200; x=1708960000;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yOTnLimYUvPNkTFJn38nSneD1s53IeoM0jyre9BMIA=;
        b=nT2AO3m2wby4cpEl+tqNEswQD7tvI8gTTXssxm9vUxwHdH2k4Y/xorVsgMd8PsQ0iU
         2ZzX6EahM9AvGUtoMdZUJBWsxPBzoF2ePt/knU7gg+k39kPvGa6xvdmKTlQ7kSrhR5su
         usDCWsBPr5ZQa1HMyAIBytGMd0t7TPc5ntpaHeqNtASbwaLOBnwOcgaPmc0ZTTi8p4yw
         FTEh75gDAse6/8RdccjrISs0mKmUGf+lGpeCcnj1dnEc4OcD/8jyjdbCUXoFo4B+oR5t
         MJzZH3kNc1vHHbMUGcnORajLVc1qPDOc7JgqUGQon/6rVIoeQGgvREtNdS5EdojcL6nO
         bxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjIc0bkSUAVxTM7kS4zv2ehKxVf64s6kEQb/e9WsEZ2a+TES/NZFW03XRElYl75QZtH8tmrpvJfAulSCc4bl27VkTpJ5VJAW6mxilKqM62PdCx1D8N9mxCQeAhND27zpoYsAi8A68C8K4Eu96dpUmxBvVEz91rS66YVYd6V1ltw6I9XCmGm7KfO++Qq6kYFKJXhPCb9A34IlxPyeJa1wne1c8+R8zSuGN3khJZs9Y7nAI8jc31dOR9ltrGcTDnzYGThg24lqg5yfnLw0fL4F26E4N/qu5pJfNvzfuirjKTAyhyfm2WSSt1Gu6NnJ2welS7j360K79JQElItPZIOSv7nhVJvBil99JN7IpF
X-Gm-Message-State: AOJu0YxT+/4jXhCEFolXtkUYErPaO9ky+HjkLU9oiKC9Jy/p0tHw1x22
	YgYyAvmsVQj53ik3IyFTH/qiDX2A2qE6Ac5QZ7sUakvuOW9b6Aam
X-Google-Smtp-Source: AGHT+IGV3Dv8X5d9m0XBa0wcUYD14lxx+K6CWQDd1wmnBIzjONKraLrRCWecBGSIPRcOqs5nu0aqbw==
X-Received: by 2002:a5d:64ea:0:b0:33d:46b6:396a with SMTP id g10-20020a5d64ea000000b0033d46b6396amr3316172wri.4.1708355199934;
        Mon, 19 Feb 2024 07:06:39 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d55cd000000b0033b198efbedsm10518754wrw.15.2024.02.19.07.06.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Feb 2024 07:06:39 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Zi Shen Lim <zlim.lnx@gmail.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Johan Almbladh
 <johan.almbladh@anyfinetworks.com>, Paul Burton <paulburton@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "David
 S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Wang YanQing <udknight@gmail.com>, David Ahern <dsahern@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, netdev@vger.kernel.org, Kees Cook
 <keescook@chromium.org>, "linux-hardening @ vger . kernel . org"
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] bpf: Take return from set_memory_rox()
 into account with bpf_jit_binary_lock_ro()
In-Reply-To: <ec35e06dbe8672a36415ebe2b9273277c2921977.1708253445.git.christophe.leroy@csgroup.eu>
References: <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>
 <ec35e06dbe8672a36415ebe2b9273277c2921977.1708253445.git.christophe.leroy@csgroup.eu>
Date: Mon, 19 Feb 2024 15:06:36 +0000
Message-ID: <mb61p5xykpk77.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> set_memory_rox() can fail, leaving memory unprotected.
>
> Check return and bail out when bpf_jit_binary_lock_ro() returns
> and error.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> Previous patch introduces a dependency on this patch because it modifies bpf_prog_lock_ro(), but they are independant.
> It is possible to apply this patch as standalone by handling trivial conflict with unmodified bpf_prog_lock_ro().
> ---
>  arch/arm/net/bpf_jit_32.c        | 25 ++++++++++++-------------
>  arch/arm64/net/bpf_jit_comp.c    | 21 +++++++++++++++------
>  arch/loongarch/net/bpf_jit.c     | 21 +++++++++++++++------
>  arch/mips/net/bpf_jit_comp.c     |  3 ++-
>  arch/parisc/net/bpf_jit_core.c   |  8 +++++++-
>  arch/s390/net/bpf_jit_comp.c     |  6 +++++-
>  arch/sparc/net/bpf_jit_comp_64.c |  6 +++++-
>  arch/x86/net/bpf_jit_comp32.c    |  3 +--
>  include/linux/filter.h           |  4 ++--
>  9 files changed, 64 insertions(+), 33 deletions(-)
>

Reviewed-by: Puranjay Mohan <puranjay12@gmail.com>

Thanks,
Puranjay Mohan

