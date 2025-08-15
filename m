Return-Path: <bpf+bounces-65771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C83B2804D
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 15:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DF2189F9DD
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD030147B;
	Fri, 15 Aug 2025 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjOf/PTG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9A11D8DE1;
	Fri, 15 Aug 2025 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262948; cv=none; b=LIIOOkM73YevdEfHIqC74eU4ooedexVP29BG3GQ7HD8O9+G3pR+4aH9MCwj6hDGlSsmNZ7fR9D6fQtdM5CZCCGsPMxSKhNkWg2ytdfuuzRiCiEjlO234kkMFrxd3vMEEVZV+5bCQnuGimzgsWH5xQMC4FV+OPIAj8CeIAeWT4xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262948; c=relaxed/simple;
	bh=u2ps14JXB0LkkuaVrO5TB009zdNfH12FXy6mTNPj9A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUXP5adaciGAtKw5elBISeIyTXpmM/k2RmNGkf6dTTHmxthcSKMT+KOSqQclccd1W9izFq1xqmYeURaTyfy/g1EOF2Y2yVh1wjJ2SJGPO60FHe5B7wBg09H/ugNNbM6scveqbvTdf6OLhkSqeYESRQ1V6tY11FzZiT4cic19jb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjOf/PTG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9d41d2a5cso1603071f8f.0;
        Fri, 15 Aug 2025 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755262945; x=1755867745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCqdqKfR7JWpIAzXwpOsu5S5/DY9ctzDb5dC2b7Rt6k=;
        b=RjOf/PTGdXJJ6azgiPNhxPwd83Tbm0iGtHVdkmSkzMKsXwqfcHw+/A0A9echnbuYKI
         BKoZp4s43tLkvZ6l6vT34DoV+VeuH8iDKsIxZZgLdtWOTKbPqNcWYecCMTomcqBTGQK5
         9W9Kd1vQimhH0FZ/+z7b6C+Op5WJrv3AF25b8SxqQf6ir6JPuVn6uClxK7rAlezb777W
         ZVPhYy679BADzi5V4jdyiL3tvdpXiIevgj4HAECttUUnbywCC2wBO+T6Z48F6CZspAAu
         SCO55IR6xzSnIQ1gXotc0mL456fx3RDgIP9EwqFJ+Zqvbaf7Bwxr0UnDe+qcz4jjwoqX
         pJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755262945; x=1755867745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCqdqKfR7JWpIAzXwpOsu5S5/DY9ctzDb5dC2b7Rt6k=;
        b=wpsdslrX6KxN8xVgjUWiinOC/RGLRMvcMmUo79lK52tNjsCLL/s6VhO2a+F3XM7Vt5
         2fUTMu64svR3mmPu6gww9P0yVATWg33apIKBHm3nTNwduE3ITguYnTUxdltdZlSH2u15
         YhzuiHcUvoQ3hgwkvia40P9of9HoQTwicO6zQ6G+kbj8ezA1A6OtFzu7vD72b6m5hL8c
         F08zOn6kcplzSTgJDZLGMTnUVxeLAqK3moEivbKwm3hr2m7AeRAOPjpxRLB2cbB+0JB9
         uNgqDtzH7c7CQdJIJrNZ5rwHlUwrVBkh4JRRuOcBtnMqqxgGjB8DjSTjHNRemSNYjyzc
         BFKw==
X-Forwarded-Encrypted: i=1; AJvYcCUO9yuw+vdVo//o5tB/EVLamDqr043F+eWzrxag5Sj46EXi1WcNdYibxbCB3chqnfY5Jpc=@vger.kernel.org, AJvYcCXg/+zYfhmzkkoZmkSLDu3QYuJGMaGsP8M2XOYrl5E69bBMpBmQiCo4EE52k4mRyMtE7RdoTJrIY6KH3XZi@vger.kernel.org
X-Gm-Message-State: AOJu0YxoWovQaV4YOwbg5C5QpQLRda/NrEMfIJ2jJmUs2fL2hB8up1Dv
	mEZVYOGidV9Wx+WmC4uLmDh+VzWFqVE37s5MQ9xjuUwWceN6O0FEV6Ymj5XqmBg21vxhootDALx
	7yEOGfF57vGZbBA5ddCwKzgJ2BcbTXD8=
X-Gm-Gg: ASbGnctQ4I5SOT0BUqjjzkQ/Subt2KROIsHQJT/g17l4CfgAbMLtz4iYfAg4GDwghHX
	mF6RznckSWgW/pJt1rAlD+vVSQXbk77NYw/W5gv2RdHm2LGzG0MgiX4izpUu0jgwNV47eOU+sO+
	VspEIXL6dPd9nFdw9e6X5Y/k9DvckGVl7cAQOjJaMTADPCdVN9OwgY8c6LLlZua+gsVhAjNnNIX
	zJI
X-Google-Smtp-Source: AGHT+IGEdwLg3p2fR5bmwGm5l1IK6ISQ9DvNjZPh+0oZUeBkXgmVZSVjAvnuPzdYE45LUoMyon7I3WsAQTd3w9AT2Jo=
X-Received: by 2002:a05:6000:144b:b0:3b4:9dbd:eee9 with SMTP id
 ffacd0b85a97d-3bb68a1889bmr1590923f8f.36.1755262945365; Fri, 15 Aug 2025
 06:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815061824.765906-1-dongml2@chinatelecom.cn> <20250815061824.765906-2-dongml2@chinatelecom.cn>
In-Reply-To: <20250815061824.765906-2-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Aug 2025 16:02:14 +0300
X-Gm-Features: Ac12FXxhpjPOjkPr0vtpq9_q-GpsyHvtAa-ClsGNYuYMIqzoIFfdzL5KMNRvFGY
Message-ID: <CAADnVQKA98hBSsb02djL-zMsaXQDCjn4Ytck+WP3SWfvgXqDYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] rcu: add rcu_migrate_enable and rcu_migrate_disable
To: Menglong Dong <menglong8.dong@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 9:18=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> migrate_disable() is called to disable migration in the kernel, and it is
> used togather with rcu_read_lock() oftenly.
>
> However, with PREEMPT_RCU disabled, it's unnecessary, as rcu_read_lock()
> will disable preemption, which will also disable migration.
>
> Introduce rcu_migrate_enable() and rcu_migrate_disable(), which will do
> the migration enable and disable only when the rcu_read_lock() can't do
> it.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  include/linux/rcupdate.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 120536f4c6eb..0d9dbd90d025 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -72,6 +72,16 @@ static inline bool same_state_synchronize_rcu(unsigned=
 long oldstate1, unsigned
>  void __rcu_read_lock(void);
>  void __rcu_read_unlock(void);
>
> +static inline void rcu_migrate_enable(void)
> +{
> +       migrate_enable();
> +}

Interesting idea.
I think it has to be combined with rcu_read_lock(), since this api
makes sense only when used together.

rcu_read_lock_dont_migrate() ?

It will do rcu_read_lock() + migrate_disalbe() in PREEMPT_RCU
and rcu_read_lock() + preempt_disable() otherwise?

Also I'm not sure we can rely on rcu_read_lock()
disabling preemption in all !PREEMPT_RCU cases.
iirc it's more nuanced than that.

