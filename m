Return-Path: <bpf+bounces-48432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA79A07FEA
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 19:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F79F188BB72
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6531F19DF5F;
	Thu,  9 Jan 2025 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdvuiuTQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658B13B2B8;
	Thu,  9 Jan 2025 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447897; cv=none; b=ihV6pzkhqTAjOrOjoSPjgQZC9BtNHeUx1KinuWnwJ7x8RFvEJXmt8q6Lp0clBKNjhWRpE9w/6v1OPVHFs0S01UOEr9E7isMGsnNhj7h0WLguhYfzMSKN0P8SXSAXbrqSRoZEaqopG31JUeF1P5oCZ0R/Ly2qv2HMJZ9KV8hA99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447897; c=relaxed/simple;
	bh=zSP6D6bjK2tbK6WK5ilsvQlKdrXHFXX4Us2855EXq/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIlqSMg5owb3IPulwqwXshr9+Tj7XFOvFhnU6jlXDVNrvEJyZz1zHxCT7Ve6QvV6YzD4JeR/0K9PjHMqNXSvywHsHa+zU9wXOe6z8K97wmB2lrnRP/p1wv2jT76Tm4sYRKsor3Fi93P7pQzMPC2ydYvQUc33vjSMZA/SuwkDy/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdvuiuTQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436a03197b2so9791155e9.2;
        Thu, 09 Jan 2025 10:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736447894; x=1737052694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKXcwekm1hFAL30tllZAc39TUJQj/M0LGLE+F7vRRWE=;
        b=bdvuiuTQDhbO6ahJN2OhBEstQw+qfjqGSs3rxDIvf7LsLT8S/SZkbU7+eE70QA61c/
         2xqDXXiI4/MxliF12Gjbpe4lNfQt5OS/qwwHjdLs+EdrmP+h19nbE1rsGyx3A1A7Pa3m
         vGbdY1aC89lD0rvKOluqyL4rKy4ZTviBt79FvzpgOX2ucgrLK7scBUNi1W/49YC24eTo
         sTg6L6bY3SWRXjtQXCSYNwdhD5RT7juk1prsLnafGRSjh2KJrmmyd+gqSWtyqFeDQFik
         th+moVTLGOv6mdf50XA2uz4i1IQMwjoXr5VROy7KjXXFsNt+WxHURMMo8R4QHjzHdWSj
         gwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736447894; x=1737052694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKXcwekm1hFAL30tllZAc39TUJQj/M0LGLE+F7vRRWE=;
        b=wkmTk/V53iIa2Nmt6G8RHlmaQAjSFIyP2pzmTIANoc5RXSLzaYSI+qsRU1PSIf1nHK
         KMbdLhrhdG1MBa6Etd4Rp+wdLTq5uW0xz+qrPYntHXCwegk9dDh51FKUz/3/RmdNsrqb
         OKhqldl4d0DmPe+xQKgQr5u1TfFvmtuyIOsaN3j2h4jTylbGkQsulbc3JhDIkV7zFIW2
         z8LmkYzH2dW5m4y36/Ym5t3QmRnfYmWhPbeX+gY4FRDBOCph596YTmnDqp5j+ODpknFv
         phacarUawmH9WuDh4+E+GAn6g1oZiAMbepjS84opCeRQ4WrlrwVnVmwJMtpsgBxdzBdX
         /phw==
X-Forwarded-Encrypted: i=1; AJvYcCWVPFrkNQMlcAxvwrexMGnrPkB3XwPjCJp45Z0mVfdkpVzAFKLLH0N6XXPZQ94+QWS0yOdrZ15oueZmOuLdGUIA4muP@vger.kernel.org, AJvYcCWfwJFrsHh6aXwcUaESyrU4M1BJwN7Pz3YYaxg8Pd5HVzhWpLg+H2z7I6Pk15AX+WO8eLQ=@vger.kernel.org, AJvYcCXlpppM08CO5sV8lF0SArHlEExX6wms70wGbZEXxPYexrE+mhJ1Weh58vjDRmBzRob36/WOxg4k/HC0dvC5@vger.kernel.org
X-Gm-Message-State: AOJu0YzxDRQ2034EJNSFsskkuLBKuQme+69R+TilUqaY2HLfOM7FjjT6
	z2OywHWV7jsRG8G8c0UeiZSLbzRvjBb4tcwfWYhJA3U0fSoRTV+fx+VjR6d19gLYPGq/ZRf/c2n
	tBr3NILhBZ+7MfAz1RZd6Oe3JWSBWZA==
X-Gm-Gg: ASbGncsGFRlliO4A3qHk9q1I/0yAeGgkm4iFNb1TfqISaWzlb2VhHB7We5oXdoBFz85
	0RfCsbhZhSBgzrziEhruWTvOoCG39KmrNPjeQMaULkSXYO9bHnblSLQ==
X-Google-Smtp-Source: AGHT+IHNdPWO9416jtnYF4JAaCASYeZuXClMWM+NgvCxvJiTYZRatdC0zXIHlWdCLDcjt7Rat1YLDu57xNoo+7Gjz/I=
X-Received: by 2002:a05:600c:35c1:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-436e26efb22mr65409535e9.26.1736447894204; Thu, 09 Jan 2025
 10:38:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108090457.512198-1-bigeasy@linutronix.de> <20250108090457.512198-26-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-26-bigeasy@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Jan 2025 10:38:03 -0800
X-Gm-Features: AbW1kvbUfmHxU6Z5lFSwhi7BVYtas4mPxgWrYnt2TsYliMKpE-tykRSfk6GtH8U
Message-ID: <CAADnVQJPf9N1THd4DXbOC=UthYvaPmOm5xQD2rcFunGXp6h5_g@mail.gmail.com>
Subject: Re: [PATCH v3 25/28] bpf: Use RCU in all users of __module_text_address().
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 1:05=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> __module_address() can be invoked within a RCU section, there is no
> requirement to have preemption disabled.
>
> Replace the preempt_disable() section around __module_address() with
> RCU.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Matt Bobrowski <mattbobrowski@google.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: bpf@vger.kernel.org
> Cc: linux-trace-kernel@vger.kernel.org
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/trace/bpf_trace.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 1b8db5aee9d38..020df7b6ff90c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2336,10 +2336,9 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_m=
ap *btp)
>  {
>         struct module *mod;
>
> -       preempt_disable();
> +       guard(rcu)();
>         mod =3D __module_address((unsigned long)btp);
>         module_put(mod);
> -       preempt_enable();
>  }
>
>  static __always_inline
> @@ -2907,16 +2906,14 @@ static int get_modules_for_addrs(struct module **=
*mods, unsigned long *addrs, u3
>         for (i =3D 0; i < addrs_cnt; i++) {
>                 struct module *mod;
>
> -               preempt_disable();
> -               mod =3D __module_address(addrs[i]);
> -               /* Either no module or we it's already stored  */
> -               if (!mod || has_module(&arr, mod)) {
> -                       preempt_enable();
> -                       continue;
> +               scoped_guard(rcu) {
> +                       mod =3D __module_address(addrs[i]);
> +                       /* Either no module or we it's already stored  */
> +                       if (!mod || has_module(&arr, mod))
> +                               continue;
> +                       if (!try_module_get(mod))
> +                               err =3D -EINVAL;

lgtm.
Should we take into bpf-next or the whole set is handled together
somewhere?

