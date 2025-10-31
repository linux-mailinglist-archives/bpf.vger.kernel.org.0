Return-Path: <bpf+bounces-73093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2193C22E77
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 02:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B2A3ACE2F
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A286D257859;
	Fri, 31 Oct 2025 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNJN6Q7x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B127257448
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874950; cv=none; b=XGJD4btSicmmyqls4k3rie81WZarmfBcTosMO2JmLTgVk35atlGtjbVq/nBpZ/1GcOejgiAMmy8rVth478HeBIblpU7o922kmdWflr5qE5kAqBrjaldizUxGjGo4ny4bMOWvC6Knik9kZdnUio6AoWS9312k4+lCWqZA50MWIgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874950; c=relaxed/simple;
	bh=2ATUNGgbaZSw6y4sW6ppozk2GJl7GnxzpyFCiq20UPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGK8D9b7Xi3ayHn6GzBe+XxjoPqu+FkwWgzMsg6Ty8Uii4lRM/dY/8tSTNxPLWaP20YHnBaPtEEFc8yT6JBnArZbDEja4YA42qCpYVgqgWuiybtYnp5Ctk2dCG34dW3KknNcNu0Rs34iGZoDR4XWaXw9uRer9MyDURhOyseeA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNJN6Q7x; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4710683a644so15724545e9.0
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 18:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761874947; x=1762479747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcA2fuPv0nibJjY5gaLuKw0u8MBZgVhL7lh4erE+P+w=;
        b=KNJN6Q7x+09HFG1z3MRfzLk5FkOv6YDPSRQArFOZ442yfP95jQFd7XArxq4CLY5qfM
         QI0S/3GFJ8deigXQw6yTyKw0zoojJhB0LYW6n1U9oUr2vJFgPdClFn2MC0JjeBQ6sUOz
         GRGSfQ/agjxJqFY3d/rlNmt6eafl6z49Bh+jsiCDFj5gHmIm3IihV8VqJRgCtFkUKzHh
         yxp09M+j4DgO9UNwb5V3rnhsJgPnXCJkoTHB0yPC408aPpG9ILjgf1Lg5kPIwTlnwdFA
         jqRqnocLf9DcOMbA3ahzm92CfbmSqZENsOq7LsBwmFWkOzL4iWC3VbZmQvoyAHbtN6LO
         L0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761874947; x=1762479747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcA2fuPv0nibJjY5gaLuKw0u8MBZgVhL7lh4erE+P+w=;
        b=EV3TI4U8/hQqJoXN7DgHkb7a2gPJs3LVjOYDfoaoL1lvTBYq2hpsMFZ3BOrz57Jn52
         05x12BeB5tsyOxWk9zQmJv3VRdSno/gXxwDqqe3eFJ91DY2Iap0VjJnh6Lz6UC6J9mfc
         kS6UK+2fTRY4RLCjQ5KKk1uO4q4/KHMt2YBu9gDvoPZB7ytj7o/gD7kpw9RPh2cozeTH
         JLoRaXrzrM2PETD3TMUQzuvU++o+ntwdV9WhQX2DNvqGSaC88pYxGNrnX61cOujWd3HK
         Hra5jGkFa4+kl9W2OAwfWNgZ4/i0612ZdbaGd8AQlCBKaclgK2gcEeSLlqNRVkDzcpix
         pCNA==
X-Forwarded-Encrypted: i=1; AJvYcCX3bGC9uexDtPOAGA4auZ6EZFr64NjWhwoxJx6iHyOqhZiqlKy0Wtk/LdPbw1qB6NsFAbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI9qsVQXaQyA977SRMtnDx+xIdvi4B7v65IKUpRI+1WiQ72hI7
	Cy0RlNDHg9PQX60NdGyLJPCUQo08Gw/A/azrBAEn8np8qvHuoovDRx+ze5tSFtiJRmrDEkLu1wi
	uw/Zir4EudlMPClV6aeVrtObRdgjr8Eo=
X-Gm-Gg: ASbGncsz2JY8vf/1jdTdi1VmRRb73ppcLLlOXYpn1HgoeK4sueu8SZvKg8KTKwmZQeG
	sriQjKI6iTnD8uevDXEajxVESfYn+YWhZAOBVp7T7+rWH9gX2TAACZjZLhz1UC+PoYm0ZcaCifD
	WT6Lu5YdRBFvt3WcUPQBsbNm3YvbaC60qLDTsJz7aVUQ+IJxggDI9/v/JF9lEtFDaEezAvB4OzJ
	WbM0lsG7h2OsrFXkL0GYZ95HPJsXc3O7YAiFook1S2+VEbd+5r+4IH1w9uxO4ISbhuVBz4YTIb7
	gnc9v1k/Ivi06v5XlQ==
X-Google-Smtp-Source: AGHT+IHjgEAGnr4nfdh0LhSmnH+sRjuCT8RoVd5GbtltDrO5Kk8/oATSx8VT/19HA2xAKXMbh+mARs050dlD33ztYz0=
X-Received: by 2002:a05:600c:8a8:b0:471:793:e795 with SMTP id
 5b1f17b1804b1-47729701baamr22601315e9.0.1761874946389; Thu, 30 Oct 2025
 18:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026030143.23807-1-dongml2@chinatelecom.cn> <20251026030143.23807-5-dongml2@chinatelecom.cn>
In-Reply-To: <20251026030143.23807-5-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Oct 2025 18:42:15 -0700
X-Gm-Features: AWmQ_bkU5AnX8Bwj31yvGuqNgMmOr74c9fvilG5ffkhrLd1xgPSqCBlrOWUn840
Message-ID: <CAADnVQLfxjOUqbbexFvvVJ4JTUQ2TKL0wvUn3iHv6vXvGfitoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting
 for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 8:02=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Add BPF_TRACE_SESSION supporting to x86_64. invoke_bpf_session_entry and
> invoke_bpf_session_exit is introduced for this purpose.
>
> In invoke_bpf_session_entry(), we will check if the return value of the
> fentry is 0, and set the corresponding session flag if not. And in
> invoke_bpf_session_exit(), we will check if the corresponding flag is
> set. If set, the fexit will be skipped.
>
> As designed, the session flags and session cookie address is stored after
> the return value, and the stack look like this:
>
>   cookie ptr    -> 8 bytes
>   session flags -> 8 bytes
>   return value  -> 8 bytes
>   argN          -> 8 bytes
>   ...
>   arg1          -> 8 bytes
>   nr_args       -> 8 bytes
>   ...
>   cookieN       -> 8 bytes
>   cookie1       -> 8 bytes
>
> In the entry of the session, we will clear the return value, so the fentr=
y
> will always get 0 with ctx[nr_args] or bpf_get_func_ret().
>
> Before the execution of the BPF prog, the "cookie ptr" will be filled wit=
h
> the corresponding cookie address, which is done in
> invoke_bpf_session_entry() and invoke_bpf_session_exit().

...

> +       if (session->nr_links) {
> +               for (i =3D 0; i < session->nr_links; i++) {
> +                       if (session->links[i]->link.prog->call_session_co=
okie)
> +                               stack_size +=3D 8;
> +               }
> +       }
> +       cookies_off =3D stack_size;

This is not great. It's all root and such,
but if somebody attaches 64 progs that use session cookies
then the trampoline will consume 64*8 of stack space just for
these cookies. Plus more for args, cookie, ptr, session_flag, etc.
Sigh.
I understand that cookie from one session shouldn't interfere
with another, but it's all getting quite complex
especially when everything is in assembly.
And this is just x86 JIT. Other JITs would need to copy
this complex logic :(
At this point I'm not sure that "symmetry with kprobe_multi_session"
is justified as a reason to add all that.
We don't have a kprobe_session for individual kprobes after all.

I think we better spend the energy designing a mechanism to
connect existing fentry prog with fexit prog without hacking
it through a stack in the bpf trampoline.

Sorry.

pw-bot: cr

