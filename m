Return-Path: <bpf+bounces-38827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E29396A7B1
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 21:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6204E1C23A95
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 19:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2AF1C9DCE;
	Tue,  3 Sep 2024 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdIasmSe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040661DC741;
	Tue,  3 Sep 2024 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392738; cv=none; b=SK4hU5FnlKali1CjTVpWmkWFdTAROpyqpcU6RQy1vO9VkLLwXQ5CUNCC0no/Ew6BIiZ99FlO/f2nZjdlHj20lmnzL+/S5IvWxWOR3uKdtijpU19FcJaaU+7UWBO9OC60ANJ+r1cAeKK6DRzTnlW+4vRNowtpOhRc1h0xeBlz8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392738; c=relaxed/simple;
	bh=rvHjuYOEV1CINRkoyoSlcK07YHioQTEhKdC1rpNv7Gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsVdriqz+nP+mw6R/S4ZaLfFjtBqkMkqo/jLkRf9ZwGLUVxWGNca4IzSPqMhuJM7guf1tesdjdavevGyko4QdkLx+gK7R1PkhocAzW1VUQXQAE49Cb3ZMyW255uoDqcUo8OjiE1Tsy4eBVHoGmRLDrw49X/xSeAr6wecuLF5fgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdIasmSe; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c3400367so2337603f8f.2;
        Tue, 03 Sep 2024 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725392735; x=1725997535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPkNgkLdOPg5qYoIVaAIoztYKuro5zmWaepDFvWuEFo=;
        b=hdIasmSeepU4ukwC0RVkp73/JwFz5txJPqRJy8QFU6233VIMdl+vcyqgkMVMw02UwO
         6H7+9k7QsqXQU9VKbCnOTKwTEQzTYGapXYgskKnhGwHQjy8E8MQcmxYCwUO7iElDjc82
         Oye1ufSThITnwbawZh1maVB64Mih/0ZvWrvUSQHNM57jAt/suDGT6F28x57WOa+ldEf3
         8mUHYAvicNmZh/lG6SC1egY12m5tevCVYwjzbrG/82DYBcAOl2bvOGFE3X+4kaEcig2h
         S5MySO6MgbFHZ0tSk/Yc8GM/wsvwECg4nMYFTllW+k33kqjUVfIzRab97TQe7mZRSMgT
         ltrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392735; x=1725997535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPkNgkLdOPg5qYoIVaAIoztYKuro5zmWaepDFvWuEFo=;
        b=uItmuUqWlbamqfjenzfrhY8MZ+2QyvllcSTU+ybIaRMQpFRgYZBRQylBUpw563SSdU
         DNVGQrSyNb88GYLABEcs/HofrvFNLnSyUBu2NRsniNO0zrX5fsMfAZuq4WpL9ARn/Kbd
         D2JM/sDNOpv0PwwlcgtvkZ8MBwd8/aJ02f5d1a3N7nBAB54Cxd4GpUDK6WFW/OZh81rl
         p7QtFBhgXsxqEj/cfatphVXJqIE3GMyPJ9wYvKjohKeD+bXm4RJY8KimhNeI5QDEy5ys
         Y2DGvMxvbFjJk0qVpBLuTiDwWS3Ele+90tNrvIxd2XuAXQJEGPTtJ0V7o+K1leXR9Cl2
         QhYw==
X-Forwarded-Encrypted: i=1; AJvYcCU1qxEE6Nq4wmW7uxhBI4FyqzJu5g9ueHBzYws/v7JtUuSk8ZeMhVLNt4KRM0z/uPLXfI8=@vger.kernel.org, AJvYcCVHb11qXNE7aihOAMe6ZyKdeNO1G1+8JuiFXEyY61+GpNq2Myyi6FZJmfTwGxS0HRKM5h3NANob4BK8JB9m@vger.kernel.org
X-Gm-Message-State: AOJu0YwZa/TaFibGCY6kS2jNqKx4COspE0MEI5NkBUxuSayFXpjrkX8C
	NnlkBoyB48tbbhre0RBA7M7cTkJdM/Wnd/Jb0xPUp5ugfOVcPqLwo5tPWVhIDBz44ZdcIw+rPba
	zcIZBJ5X3oVUvloBbynwbzHANR7c=
X-Google-Smtp-Source: AGHT+IFcGducwhXW6NaIYICoNN32Z4VWbi6fF/OnzddCSZfTmpnrJbs4ahiRHR+0RsEBEjIC8WjOoXqKZUCe0AXIT6Q=
X-Received: by 2002:a05:6000:889:b0:371:8dd3:27c8 with SMTP id
 ffacd0b85a97d-3749b544d81mr15041811f8f.23.1725392734966; Tue, 03 Sep 2024
 12:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop> <20240903163318.480678-7-paulmck@kernel.org>
In-Reply-To: <20240903163318.480678-7-paulmck@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Sep 2024 12:45:23 -0700
Message-ID: <CAADnVQJCRksMjpKzpNFNXR4ZggnuLN4yTmBbFCr5YW33bbwSwQ@mail.gmail.com>
Subject: Re: [PATCH rcu 07/11] srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 9:33=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 84daaa33ea0ab..4ba96e2cfa405 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
...

> +static inline int srcu_read_lock_lite(struct srcu_struct *ssp) __acquire=
s(ssp)
> +{
> +       int retval;
> +
> +       srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
> +       retval =3D __srcu_read_lock_lite(ssp);
> +       rcu_try_lock_acquire(&ssp->dep_map);
> +       return retval;
> +}

...

> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 602b4b8c4b891..bab888e86b9bb 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> +int __srcu_read_lock_lite(struct srcu_struct *ssp)
> +{
> +       int idx;
> +
> +       RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_r=
ead_lock_lite().");
> +       idx =3D READ_ONCE(ssp->srcu_idx) & 0x1;
> +       this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter); /* Y */
> +       barrier(); /* Avoid leaking the critical section. */
> +       return idx;
> +}
> +EXPORT_SYMBOL_GPL(__srcu_read_lock_lite);

The use cases where smp_mb() penalty is noticeable probably will notice
the cost of extra call too.
Can the main part be in srcu.h as well to make it truly "lite" ?
Otherwise we'd have to rely on compilers doing LTO which may or may not hap=
pen.

