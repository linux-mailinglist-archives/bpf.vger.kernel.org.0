Return-Path: <bpf+bounces-64893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDA5B18466
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 17:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CDA5671D7
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261ED248868;
	Fri,  1 Aug 2025 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPcrlalu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AD24690;
	Fri,  1 Aug 2025 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060561; cv=none; b=Nho/i0xRJdkowyU9tHb7C9QwbWi7NWSPBnU2dyh6kiA6KX9J4tkz5mk5essjqDI41VBQugzo0WI5HuIoGR3OxpxFgK4q1GLHBhEOzyuvGB+9MES928KV3RjGdaRwFLvum5LC/ssG9hl7fQlN94mqeVfWT2gUuZaIKvDV6kBzD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060561; c=relaxed/simple;
	bh=OGs/zjt23oeVvRyGTQ5LM4hO8UmeAAkrKfuW1sIdqII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eceo5RLJdosvcxZiDnqchEBpjlRiKgqtq3RvBu1DWkRmCeZuo/eFNwIXOOCb97cpkE8JBio5LWq2cfedjkBfyUsLtF6tLRNX8eErt+gPNnoPa0EID23mtdy0MtszeQpkNBAuh0DF+7fXZxa3sFaXTWIfpiRBfQWJo2JEcgQnMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPcrlalu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4563a57f947so12874775e9.1;
        Fri, 01 Aug 2025 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754060557; x=1754665357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIs7RIYZnKjSY6t2jaZDFOukHpNQNdpysTR2/kJbT3Y=;
        b=mPcrlaluoGZrU/q5Ye86dvSKPQsAH2V82Xgas3av5wuggDOsGdCBIImDM0nyB2xclo
         V2bD3oBx/t9mDXf3a30hyepJgkrB2+AL+pBabdsSNlq9MSuqGHbzrKOA13RSSOuIKEQr
         OuHvNX1H6zn499jDZPV4TZi+wF2PNvTeTm2gRsozG7dtXxWTU6dIjG85zyhrC6yl0+dv
         cn7BaK/LruEL9EZGoQVo5ObX/LXetfZ6mYWqQhwAdp6mzf3f9sDTuepa0EoTMDuKwxNy
         XWo5/T/YriFjt3yEOvxBIb7NQO3/m5otVBtu+EgN/8NNC/n0gC8f143xmJwNGfXc0tGX
         AxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754060557; x=1754665357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIs7RIYZnKjSY6t2jaZDFOukHpNQNdpysTR2/kJbT3Y=;
        b=rzCCJuE94P3IShT98g03e8SK88quNq8sFItmUt0okFukFKPOQR1SE2P1j/xM6h4UGK
         Tq/zyi2ZQ2VkHbeuX6FOU1ubiV+CpygGQnIk4lJGZxtE08uekgtot+HsXS0Si+Y95teT
         UUbhc5e8Fn4txbieKyS1Y1jZWQKvyzkZkYWXYSbe187iIPJ18ZiocTjLkJVyTexJDmS5
         5DELW2tb7bknikQRwGNf18Sn+MQPh/jWAKqwKv4oAGqa9CFfqRvj7slNV3QtgTNmbpbC
         t49F4ww8O6xn1HnsCxubs9FKCj+F09Xqm3q4dCa1YnqhHv98xVdpzr4OH/ekGe0sByKf
         6SSA==
X-Forwarded-Encrypted: i=1; AJvYcCXN23PDfI/VenqpkoSOh5DQFikoWunF/+byljGCrQmJluVMYNOovWrV/J/0c3HteC2+VY2faz4ITyAdA3Txd2iBQwL7@vger.kernel.org, AJvYcCXbRK5/gTzksnOV7okfAfaMdSMMJBnT04R4HTke88fh2hhMSOnVXBxBPED873pWUYm3E8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0CbakWRZ7Y3t4NZvBYkgvisupr3Emmb1T8CjZY9qW8aOoVTlG
	Ur+QjNlNY8cAvGnNsXzuI7Cm+rklp0yPtbtm3igPHzST+U0GchjBxkhbscDY/B2jl2W8MDi+G32
	RDwfYZwI7d5VB4q6RaWrriDuDtQT2gQs=
X-Gm-Gg: ASbGncsMUJPE2OKQc3zHhhg3aaIsk8EfINGmY4jLmyFCpcTCNpUBr98+kBPuLgcW026
	SJX9yc2qiaWpYOln6CoceUo+Y2ERHmcfKmFqg+1cP7HMbTlCNLW/Kq45VocAD+Ite/op+7+aR+l
	tXgKD6ZKNsssE79z06DMhtRUb0CSek2vnnkUlO7t00+Ul90eAIlwnXTy3GlGj5hk1cQLXpcwLX1
	Ko3/F+2LG1nS0Irb5jxZelhnDdDHXMOsjIZ
X-Google-Smtp-Source: AGHT+IHdXD3CXIjBp8hrOdw9VLJ3bcyQXI5pJhPM/3JLAldgwJO6va75xGJn195gtlayZ2ExmybVxMO9Q79WUnwiW2E=
X-Received: by 2002:a05:6000:40db:b0:3b6:d0d:79c1 with SMTP id
 ffacd0b85a97d-3b79d4511a7mr5494920f8f.10.1754060556730; Fri, 01 Aug 2025
 08:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801071622.63dc9b78@gandalf.local.home>
In-Reply-To: <20250801071622.63dc9b78@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Aug 2025 08:02:24 -0700
X-Gm-Features: Ac12FXzhVGbzzq9uO0g0HZvhRsAZT5Ko_guZPc0sBg-98_qTHuvCXF5RSFlAa08
Message-ID: <CAADnVQLky+R-tfkGaDo-R_-tJ8E3bmWz8Ug7etgTKsCpfXTSKw@mail.gmail.com>
Subject: Re: [PATCH] btf: Simplify BTF logic with use of __free(btf_put)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 4:16=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> Several functions need to call btf_put() on the btf pointer before it
> returns leading to using "goto" branches to jump to the end to call
> btf_put(btf). This can be simplified by introducing DEFINE_FREE() to allo=
w
> functions to define the btf descriptor with:
>
>    struct btf *btf __free(btf_put) =3D NULL;
>
> Then the btf descriptor will always have btf_put() called on it if it
> isn't NULL or ERR before exiting the function.
>
> Where needed, no_free_ptr(btf) is used to assign the btf descriptor to a
> pointer that will be used outside the function.
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/btf.h         |  4 +++
>  kernel/bpf/btf.c            | 56 +++++++++++--------------------------
>  kernel/trace/trace_btf.c    | 15 +++++-----
>  kernel/trace/trace_output.c |  8 ++----
>  4 files changed, 31 insertions(+), 52 deletions(-)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index b2983706292f..e118c69c4996 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -8,6 +8,7 @@
>  #include <linux/bpfptr.h>
>  #include <linux/bsearch.h>
>  #include <linux/btf_ids.h>
> +#include <linux/cleanup.h>
>  #include <uapi/linux/btf.h>
>  #include <uapi/linux/bpf.h>
>
> @@ -150,6 +151,9 @@ struct btf *btf_get_by_fd(int fd);
>  int btf_get_info_by_fd(const struct btf *btf,
>                        const union bpf_attr *attr,
>                        union bpf_attr __user *uattr);
> +
> +DEFINE_FREE(btf_put, struct btf *, if (!IS_ERR_OR_NULL(_T)) btf_put(_T))
> +
>  /* Figure out the size of a type_id.  If type_id is a modifier
>   * (e.g. const), it will be resolved to find out the type with size.
>   *
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 1d2cf898e21e..480657912c96 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3788,7 +3788,7 @@ static int btf_parse_kptr(const struct btf *btf, st=
ruct btf_field *field,
>         /* If a matching btf type is found in kernel or module BTFs, kptr=
_ref
>          * is that BTF, otherwise it's program BTF
>          */
> -       struct btf *kptr_btf;
> +       struct btf *kptr_btf __free(btf_put) =3D NULL;

Sorry I hate this __free() style.
It's not a simplification, but an obfuscation of code and logic.

--
pw-bot: cr

