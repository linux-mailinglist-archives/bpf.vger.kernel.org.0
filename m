Return-Path: <bpf+bounces-76741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E35CC4BC1
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE61A3008062
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E3B2F1FDC;
	Tue, 16 Dec 2025 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXENxXeL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7F729B8FE
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906770; cv=none; b=GINdxIICx4RqwxfD7L+hv3hNpkw4WfPYPupuaI87A+K4PccXcI8jzqSCkEVzZYjSyMuveJ47coaW34DPur8eK2JAU2/LTfCI/EYGL8Zi5tr8wczjN9fiKNHDPm1iv2oMm4xLhT/xe30CgHieR7iyuJoeyFsYIn/tJg1Ohox2Xhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906770; c=relaxed/simple;
	bh=LHgW3pQ94auFS6QXdkB8ekFBN1VodJgyFKRiNodMnyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyRzNKyqcuZO7QWNNrdWXy/qHw4NU64j6uTo20AYjXlZdF2i5rlNJx5lHfM4kdLfEf+sma8Fh7ndRcJRVG8C/jpt7kNmxmHhQNH3fMlqhdIxHz4BMu+MmbXpAaNi2M4n8eVZU3d2ojn5C9ntI0IqoorKci6l6Ws9/CUjZXRuJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXENxXeL; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78ab03c30ceso44207127b3.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 09:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765906768; x=1766511568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wDRVcNBtR+iW6Yf99Q/xL+9AQK2g/UaoVu1pJaWUN/8=;
        b=cXENxXeLhV56mtFSNBrNFOt8ybK2HfOgC5XoIiGld9g2Ul+UuWn0a5AWcFjytrH6Rk
         jNg0mklC9hVZSZ6Ybh4Vjbr8cZ1MOnsrddBfVjkECjSXdqtoUCgBD7vuAC6jJZlQAcnX
         eKkmACuPIGDEM061ITaXPPMLziEygz5K1VVePoAsqruehDFgsQAKE9Rj/li9lsYxxIC+
         xiruYwQCkeNzSTkgMBhwZkzezGW1CZnnmBD0ecZbtnZc59Yjt1esN7OswbTF6QtvwLza
         YWfXTpEikqDEhwZwEayVXkTlSLlXBaDRQfLN89XYCoQRXccH+rKNu72Ov5yz0qbrLcAy
         t2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906768; x=1766511568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDRVcNBtR+iW6Yf99Q/xL+9AQK2g/UaoVu1pJaWUN/8=;
        b=U2dDMVd2733tOAYgMy7SNZhoG8zuzbEBQN0E29MKFxyHWjHi+P8lBv0s3FlZQJ4BmP
         6lIw+OpqzjqEJzryOy/SZSddPL/LrZlJi+c9lBqDUydx7DsjYuFgpoZRvLEvNCIiNPK7
         JRRLxvxGKrI43KxLx9xUCSUIUAdQHvpzOaxtOWtg0H0wYEcAXfb0cAPWb2ggZAFgRxmW
         +bw3vwMgjXLlNTjSsQMgTgb48nM3D1mh3+TnS79iwu9Z6NzidV0xLHt8WAEnYKKbPcv/
         YAhlvLyOsyo4kvBwu5R+rUwnqSafsJz69gRHZ9hIclEtaBzFKeJmyuTjirFfqMbWGatW
         /9zA==
X-Forwarded-Encrypted: i=1; AJvYcCUknD3usH+F3JRuTF0ENG14x+1CCzU6M+omghsPltuhv0B9TyISdiHb3QfHEh4W5UjYTq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxqLPGvay8KvheenoTDPmfZzGb9VNaxbfYYlPUEwTPQ4yocIgV
	UL1ZYYYTVpUbpBd4j5J+ojLAhIFelFPyNjOXp4sCF/NUnHqxLKz5mbRn
X-Gm-Gg: AY/fxX7hlFS5i4G0+e4s7MENduU2YjSdx8CvoxZQY2O0JLGijFNEpRoIHGXSZna9DqS
	ANQLUWmixQaYKWn8l8YBbKAvQ/pwCWW/OJI5pzP4FaDh4pzSCelgQz2dFHcDtsUXx2USxoIPoeI
	ZxjhtSa+BaRxi9jf98XDNnwZJEWKQA9i7NDgEZ7g8n7w7Of9PLzTcT/0YGFKdbvcXwFDOHzoobh
	yM/xIaDOF715irCWLnFr6CKvW9xMqSeUXJiSyl2MZ2El5xrPhX0vJClwBbSy+UedixowWnyOPhh
	yx6D/TgYsndWk3vMAdycLTgDHt1wxcW59Gr3GH+06xgjz52gtKVJi597AmGwSNyIJxKnw7n8NfJ
	wXlaF7GCbyZEhe7cQeOMhOHcxUyXA0XGMfQvyXnF5Wh3cHYqA6e7h7BNIK9qqwv8ugnx/2rONkc
	uqYQ617jgdRsyDoeJ+4g==
X-Google-Smtp-Source: AGHT+IE3NinGFdKlAN7UhDAbPKCkBHxHtNBkcwDeZ6wptkYuBgdRACzHAMbsJH1rL1T21esZqKIaWg==
X-Received: by 2002:a05:690e:1248:b0:641:f5bc:68e1 with SMTP id 956f58d0204a3-645556680bamr11330010d50.78.1765906767566;
        Tue, 16 Dec 2025 09:39:27 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:7f3c:658f:3c84:2aa3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e74a57202sm41212187b3.57.2025.12.16.09.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:39:27 -0800 (PST)
Date: Tue, 16 Dec 2025 12:39:26 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: aou@eecs.berkeley.edu, alex@ghiti.fr, andii@kernel.org,
	andybnac@gmail.com, apatel@ventanamicro.com, ast@kernel.org,
	ben.dooks@codethink.co.uk, bjorn@kernel.org, bpf@vger.kernel.org,
	charlie@rivosinc.com, cl@gentwo.org, conor.dooley@microchip.com,
	cyrilbur@tenstorrent.com, daniel@iogearbox.net, debug@rivosinc.com,
	dennis@kernel.org, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, linux@rasmusvillemoes.dk,
	martin.lau@linux.dev, palmer@dabbelt.com, pjw@kernel.org,
	puranjay@kernel.org, pulehui@huawei.com, ruanjinjie@huawei.com,
	rkrcmar@ventanamicro.com, samuel.holland@sifive.com,
	sdf@fomichev.me, song@kernel.org, tglx@linutronix.de, tj@kernel.org,
	thuth@redhat.com, yonghong.song@linux.dev, zong.li@sifive.com
Subject: Re: [PATCH v3 1/3] riscv: remove irqflags.h inclusion in asm/bitops.h
Message-ID: <aUGZTkLGYuew7-s1@yury>
References: <20251216014721.42262-1-cuiyunhui@bytedance.com>
 <20251216014721.42262-2-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216014721.42262-2-cuiyunhui@bytedance.com>

On Tue, Dec 16, 2025 at 09:47:19AM +0800, Yunhui Cui wrote:
> The arch/riscv/include/asm/bitops.h does not functionally require
> including /linux/irqflags.h. Additionally, adding
> arch/riscv/include/asm/percpu.h causes a circular inclusion:
> kernel/bounds.c
> ->include/linux/log2.h
> ->include/linux/bitops.h
> ->arch/riscv/include/asm/bitops.h
> ->include/linux/irqflags.h
> ->include/linux/find.h
> ->return val ? __ffs(val) : size;
> ->arch/riscv/include/asm/bitops.h
> 
> The compilation log is as follows:
> CC      kernel/bounds.s
> In file included from ./include/linux/bitmap.h:11,
>                from ./include/linux/cpumask.h:12,
>                from ./arch/riscv/include/asm/processor.h:55,
>                from ./arch/riscv/include/asm/thread_info.h:42,
>                from ./include/linux/thread_info.h:60,
>                from ./include/asm-generic/preempt.h:5,
>                from ./arch/riscv/include/generated/asm/preempt.h:1,
>                from ./include/linux/preempt.h:79,
>                from ./arch/riscv/include/asm/percpu.h:8,
>                from ./include/linux/irqflags.h:19,
>                from ./arch/riscv/include/asm/bitops.h:14,
>                from ./include/linux/bitops.h:68,
>                from ./include/linux/log2.h:12,
>                from kernel/bounds.c:13:
> ./include/linux/find.h: In function 'find_next_bit':
> ./include/linux/find.h:66:30: error: implicit declaration of function '__ffs' [-Wimplicit-function-declaration]
>    66 |                 return val ? __ffs(val) : size;
>       |                              ^~~~~
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

> ---
>  arch/riscv/include/asm/bitops.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> index 238092125c118..3c1a15be54d80 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -11,7 +11,6 @@
>  #endif /* _LINUX_BITOPS_H */
>  
>  #include <linux/compiler.h>
> -#include <linux/irqflags.h>
>  #include <asm/barrier.h>
>  #include <asm/bitsperlong.h>
>  
> -- 
> 2.39.5

