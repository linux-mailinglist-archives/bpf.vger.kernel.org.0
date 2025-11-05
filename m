Return-Path: <bpf+bounces-73545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D63C337E2
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 01:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7D5428639
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 00:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1566423ABB9;
	Wed,  5 Nov 2025 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ+N2tMt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CFF1DF970
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303265; cv=none; b=UwMJ+kYjNEaf3LRj4SlcQ14+pOb9UgVFxXOjo2Pnek1GPBhhJbM6AdwfHNSRf/v2LnNvLIjSOb5/NL/kALtlrrqBWZLsZfZhj470zPhcKpCoav1eedVUtBcETFRMXE4PXads5fzUQ1gxvLpMFv4zc6a9YNEOPnt6Fus/7OuQ69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303265; c=relaxed/simple;
	bh=iB2rxoQs6LHNjhiJgmkA5Yc78itROwORHlUrfQFQHXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewEmAGhd3X4s1HxY/CnHKbyM2UoWVu41gBEIJ6unPk5K0ddpPRZITkH76EJ2h2cT6zVK81TjeYbtNMHiHVo8vgmzYxz7dle9/7oi9/wt80ShBjK8TYBcneZJBIBaHsAxb7oGtalxKjwRBgiC/R9Pmvbjqe/8rIaQ5vMfKJ9JkBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ+N2tMt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2952048eb88so66587705ad.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 16:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762303263; x=1762908063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lY3hUxzseeyKTtHC+1V232znjyrt/mx43bxK4gMo3E=;
        b=AZ+N2tMtFMDYsxGQgMMAAS5kLBe9euC9xNNBygxInEDAHINlgZTpzyxbDH7F33y83G
         R6XiohF5bRaEhtQsXIq0LusqrK1SLLH2I/yZ5p4XW4/GUoPd0kJcjzwzgWDIex3bVnoG
         caFWi8tNlqf/gGsUG7YfAoeZE0PxkMBf5HtwWrf7HVPaCqKwNizW5f2IAePaGX9ygODO
         st71Wd//W8o+nYOWoLXzNiJXSKd/cvTQwT42Fw8wGcSWHE6eXTjrTPTSy+P0nnVFvqXX
         HHC+qGXO1IrU+9JCSSfVluhLQXFN1uvLs6QXrYvIHmcvC3KL4Keu3easK8EP8zXGyt3Y
         YxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762303263; x=1762908063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lY3hUxzseeyKTtHC+1V232znjyrt/mx43bxK4gMo3E=;
        b=NXUtMbl3YQuHBwm3Wz8kMMDPFO4Q7MIGa4OkH7OrFWMQqaI7MX0Wz+Yta2o5q4qNlX
         +IP2z3bYF4zXR9H2o7We2w0pMLd5B9OlgoSfkkNGni03+4EVdhrlev/DUvW7/ZdRts1Q
         ET8YadooULELNOUyiwlPHnvxRRv522oga/RYybeXKhfTyZmhSXo5HszH05OdXK3Yfiwa
         kl1xZv5Dfnq066HXUJmRDETHxP065KB9o9uR984/VHWHNJNJ1mVCeo0eGMduFQAqGM/n
         lP3oU8NmxU9oZUY5TPZxvSJ0J6BBJowZmMLss8loVvf0HUO39wvtpeQxKs2xGpYvhu2r
         jyUw==
X-Forwarded-Encrypted: i=1; AJvYcCXVFeJ5wzDdXoyGwminsHRCrGQdptpTUT3yovYvyzSXm0q1Q3mf/j8DBhY+FReP7H2FBG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsCC/5SL0sQ+LQWl/8wBUWYQbNHJYPCNXMA9TYUksaruXL1d4
	N35PJs5v4oZM0J/ns8aG+om2PikAfJ78TMSOR653MZEJm1YA4I1i3LixdtO6KS2hdJvhw31Qw9O
	5/9dMt1CNaOtBZbmNqhbyZl4wJx0BbVM=
X-Gm-Gg: ASbGnctHAX0I6Lfrv7LS5CozRfqjANiyG03hY3O1JTiKolIFnqKOU2b/M9qLEImxVH1
	+/5pnghH+gBeb9OxtlnxA8GvBXn8Sv+0IiaLArkjwAdvCERxkpPhjBkFtEOgl8lOrfd7FSWzNRJ
	Er6jzxaY6UpSAIIWvohbMEpOrz4ROiHkXiRSB/ZHDXUktNBuqXFU2u8f/U2U54v4dshiQIDFInU
	qB6PJo1O4Vwr64WtvXHsdGQcbT/pIbrXMBEzQr349OMPRpbdKJ0EzWopcICOjyqsRZjTxA4x2+O
X-Google-Smtp-Source: AGHT+IEU1E4MP5M572+waRD//phAEiALlYub9Hv2jmIr2Y/tWZXbS9wfZ+oS4MlVnNllbjwb8B0DR0MpRyvGDsfjouk=
X-Received: by 2002:a17:902:e5c5:b0:28d:18d3:46ca with SMTP id
 d9443c01a7336-2962adb62f9mr24024215ad.49.1762303263212; Tue, 04 Nov 2025
 16:41:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026030143.23807-1-dongml2@chinatelecom.cn> <20251026030143.23807-3-dongml2@chinatelecom.cn>
In-Reply-To: <20251026030143.23807-3-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 16:40:48 -0800
X-Gm-Features: AWmQ_blOfoM_l2r0lt4A2bvCtaXDmFSafOTdKDG85Hyl1uiyuVpe-mxuHnQsoBo
Message-ID: <CAEf4Bzbgqse2mSmGWd5ibJaDYgPw-WpLQp_XiF3fguw147qgPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf: add two kfunc for TRACE_SESSION
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, jolsa@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	leon.hwang@linux.dev, jiang.biao@linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 8:02=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> If TRACE_SESSION exists, we will use extra 8-bytes in the stack of the
> trampoline to store the flags that we needed, and the 8-bytes lie after
> the return value, which means ctx[nr_args + 1]. And we will store the
> flag "is_exit" to the first bit of it.
>
> Introduce the kfunc bpf_tracing_is_exit(), which is used to tell if it
> is fexit currently. Meanwhile, inline it in the verifier.
>
> Add the kfunc bpf_fsession_cookie(), which is similar to
> bpf_session_cookie() and return the address of the session cookie. The
> address of the session cookie is stored after session flags, which means
> ctx[nr_args + 2]. Inline this kfunc in the verifier too.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
> v3:
> - merge the bpf_tracing_is_exit and bpf_fsession_cookie into a single
>   patch
>
> v2:
> - store the session flags after return value, instead of before nr_args
> - inline the bpf_tracing_is_exit, as Jiri suggested
> ---
>  include/linux/bpf.h      |  1 +
>  kernel/bpf/verifier.c    | 33 ++++++++++++++++++++--
>  kernel/trace/bpf_trace.c | 59 ++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 88 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6b5855c80fa6..ce55d3881c0d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1736,6 +1736,7 @@ struct bpf_prog {
>                                 enforce_expected_attach_type:1, /* Enforc=
e expected_attach_type checking at attach time */
>                                 call_get_stack:1, /* Do we call bpf_get_s=
tack() or bpf_get_stackid() */
>                                 call_get_func_ip:1, /* Do we call get_fun=
c_ip() */
> +                               call_session_cookie:1, /* Do we call bpf_=
fsession_cookie() */
>                                 tstamp_type_access:1, /* Accessed __sk_bu=
ff->tstamp_type */
>                                 sleepable:1;    /* BPF program is sleepab=
le */
>         enum bpf_prog_type      type;           /* Type of BPF program */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 818deb6a06e4..6f8aa4718d6f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12293,6 +12293,8 @@ enum special_kfunc_type {
>         KF___bpf_trap,
>         KF_bpf_task_work_schedule_signal,
>         KF_bpf_task_work_schedule_resume,
> +       KF_bpf_tracing_is_exit,

we have bpf_session_is_return(), can't we just implement it for
fsession program type? Is that because we need ctx access? But we can
get bpf_run_ctx without that, can't we store this flag in run_ctx?

> +       KF_bpf_fsession_cookie,

same, we have bpf_session_cookie, can we support that? And again, we
can just make sure that session cookie is put into run_ctx.

And if not, let's at least use consistent naming then?
bpf_fsession_is_return() and bpf_fsession_cookie() as one more
consistent example?


>  };
>
>  BTF_ID_LIST(special_kfunc_list)
> @@ -12365,6 +12367,8 @@ BTF_ID(func, bpf_res_spin_unlock_irqrestore)
>  BTF_ID(func, __bpf_trap)
>  BTF_ID(func, bpf_task_work_schedule_signal)
>  BTF_ID(func, bpf_task_work_schedule_resume)
> +BTF_ID(func, bpf_tracing_is_exit)
> +BTF_ID(func, bpf_fsession_cookie)
>
>  static bool is_task_work_add_kfunc(u32 func_id)
>  {

[...]

