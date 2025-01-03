Return-Path: <bpf+bounces-47854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 409C7A00ED1
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 21:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B12163EB4
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 20:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F641BEF6E;
	Fri,  3 Jan 2025 20:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFQIobNh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6851BEF6A
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735936282; cv=none; b=gT1qDHzNIuolvhPPB62xYHaQhJOihJlkB0zFuVzmWlJa9XseXTNBkckBbacxfPj6WM6yyQN98GjJt04ztvxN8MI5xUyjBW0qUeXyRS9Vnw/piW8y2JCcUZRdQSpj2r2WdJy04yWY/7nhbr1Ro2Fg2BosBYEuXu7/ByE7U7ktVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735936282; c=relaxed/simple;
	bh=wKgpe49oK97da4p3eJ662ZhtqW1Xo23Man9EIhjddH0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S88oyCvHyJ7SQ9+3IAMxNze+99KbIexiExqgO9WYOJd0i/AQBo1KKaJkHSqo4VtsJRBjK0rbqG037HHyOzQ4TFmoY6HH8f5YHxcbrRvnkhgnlIdFieBz5Gvs3MVOcz0VxGwDhx1spj+/lZfMrVYKJSIvlRo7l9zPGgGshe9+Lag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFQIobNh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21619108a6bso164108515ad.3
        for <bpf@vger.kernel.org>; Fri, 03 Jan 2025 12:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735936278; x=1736541078; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3409L/Uci4wXlvDC46+m6cp8K1rl2CfqcIOCC++t2A=;
        b=fFQIobNhJuXcfJVJNycKD8W2Fya67iO3A8eXhQDP+ef+G5Y7RX2KVVEJ0441y3itGf
         +sBrZ6jtugFL5MnwQHfXTnoi3vUU5rNsDcepeHdVl07BAPmXGp+E2iUSRoKROAYGNB8t
         7qAkebPE+gwpHlede14sT5LYzh1taju+vlK9q6lbCl/0nsViL1DvDyZRW6yQANEci7Pt
         8Jkap027YaNlgAsh1XASoJzgw3LxNVMze6XQUcKBJG8qt0wQ7MoTmUBbJky44Z34K4nL
         /gQaARNCcFnOYMJwa1rUlEt1ijEXVj0uWUq6yKltMNACeFwNctpkzmdsfAlWth8bQY4t
         /2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735936278; x=1736541078;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b3409L/Uci4wXlvDC46+m6cp8K1rl2CfqcIOCC++t2A=;
        b=b5NXtPd0BIXyusFY1MzSnUm9Iw1ePqI1IUisS0BqzGRUVreA5Hy/ytViA/cvXw8hCx
         pHXKHcTeIkrJ2p2w70ISw9bukSJSq++v5S1bJbSnIFMyF0pf25Etd1l6734jskaYOXLC
         EXzj1srBcojKjl0jKJTGfXUv38XAxPcswpTnvH/S6URZ38aeVfUpkQ4I3Y3yyAUqjC82
         xOlAB8iNptcacPKvPGee+HjiPir/K/YE/4tU7VJ3Qx3i/2JDyb7TOoxXy/rZJ5fHVt64
         e2ZZwQdXlvbw3w+hmNJJOvvFWzNT0CKYVBiEXXmxQMvTWs/66FIW9IsDaMG4iskDtDJG
         qIqA==
X-Forwarded-Encrypted: i=1; AJvYcCX8w+uQTVLao7QAl864Aw/Xe05aessPwsUUoVqaiAW9goJK976VR6U/aQ1W7aGqiYgp3vU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6bAJnyfDjsnnL2UtS2I9yeumi7nfzIbJr1Xs4sSoQrhyTDRcj
	SEIUGulY/CeinQ2NViyxctb3ZXv8oAQU7El71e921cw3+Lc0Mjuu+IkTVA==
X-Gm-Gg: ASbGnctN3CgE1ESfjJOY67DjwA5Lfon+na0932thBMEH8hcd2wybCyNc3py2AofB7NU
	UUosXho6TrHAq/WVv18+sCxIDMghulg9Nrs7lBgnes2bfQUMyD+c2Q6MY3lhsjcEfWNOjXT26h+
	hOVrVjvjQGAugrE/CnulXj1eaWH6LdebXm7IUqEiIlyQ48LjDadzQnPElalPyHoS0IIqlypHfYL
	xLTFAZz0bzlQaqw7iLWydoZ28kfTpZBw6q0oVpY9kgGSQh/aMmluw==
X-Google-Smtp-Source: AGHT+IFGBv3Tmzpj5xLAdRD8DaQtmkUYlhjGtH1UIQH1G1kDHgAEfN81C1kDklM/BaJgzgbvttsmMA==
X-Received: by 2002:a17:903:94e:b0:212:68e2:6c81 with SMTP id d9443c01a7336-219e6ea0223mr806508405ad.24.1735936278335;
        Fri, 03 Jan 2025 12:31:18 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca0195asm249273275ad.243.2025.01.03.12.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 12:31:17 -0800 (PST)
Message-ID: <d58e28b03ecee04dba5c16c588330741c255cc0c.camel@gmail.com>
Subject: Re: [QUESTION] Check bpf_loop support on kernels < 5.13
From: Eduard Zingerman <eddyz87@gmail.com>
To: andrea terzolo <andreaterzolo3@gmail.com>, bpf@vger.kernel.org
Date: Fri, 03 Jan 2025 12:31:13 -0800
In-Reply-To: <CAGQdkDt9zyQwr5JyftXqL=OLKscNcqUtEteY4hvOkx2S4GdEkQ@mail.gmail.com>
References: 
	<CAGQdkDt9zyQwr5JyftXqL=OLKscNcqUtEteY4hvOkx2S4GdEkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-03 at 12:03 +0100, andrea terzolo wrote:
> Hi folks! I would like to check with you if the verifier failure I'm
> facing is expected. The verifier rejects the following eBPF program on
> kernel 5.10.232.
>=20
> ```
> static long loop_fn(uint32_t index, void *ctx) {
>   bpf_printk("handle_exit\n");
>   return 0;
> }
>=20
> SEC("tp/raw_syscalls/sys_enter")
> int test(void *ctx) {
>   if (bpf_core_enum_value_exists(enum bpf_func_id, BPF_FUNC_loop)) {
>     bpf_printk("loop\n");
>     bpf_loop(12, loop_fn, NULL, 0);
>   } else {
>     bpf_printk("skip loop\n");
>   }
>   return 0;
> }
> ```
>=20
> With this error:
>=20
> ```
> libbpf: prog 'test': BPF program load failed: Invalid argument
> libbpf: prog 'test': -- BEGIN PROG LOAD LOG --
> number of funcs in func_info doesn't match number of subprogs
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'test': failed to load: -22
> ```
>=20
> This sounds like a valid use case. I would like to use bpf_loop if
> supported by the running kernel otherwise I can fall back to a simple
> loop. This issue goes away on kernel 5.13 with the introduction of
> PTR_TO_FUNC [0]. Is there a way I can use CO-RE features to avoid this
> issue? I would expect the verifier to prune the dead code inside the
> `if` but the error seems to be triggered before the control flow
> analysis.
>=20
> [0]: https://github.com/torvalds/linux/commit/69c087ba6225b574afb6e505b72=
cb75242a3d844

bpf_loop was introduced by commit [1] and released as a part of 5.17.

The error you see is indeed caused by the lack of PTR_TO_FUNC register
type in an old kernel. In your program the call to bpf_loop would look
like below in the assembly:

  ...
  r2 =3D loop_fn  ;; here function pointer is taken
  ...
  call bpf_loop

Before main verification pass verifier.c:add_subprog_and_kfunc()
discovers subprogram entries by looking at function calls and function
pointer assignments and compares it to function information provided
via bpf_attr->func_info. The kernel that does not know about
PTR_TO_FUNC would not find the loop_fn entry, hence the error message
about mismatch.

Additionally, verifier.c:check_cfg() looks for parts of the program
that can't be reached by jump and call instructions. For this purpose
pointers to functions are treated as function calls. The kernel that
does not know about PTR_TO_FUNC it would seem that loop_fn is unreachable,
this would cause another error message.

Even if you add a dummy call to loop_fn verifier would most likely
reject the program at 'r2 =3D loop_fn'.

The approach libbpf uses to detect running kernel features is based on
programs accept/reject status [2]. E.g. your program could be simplified to=
:

  static int loop_fn(int i, void *c) { return 0; }

  SEC("tp/raw_syscalls/sys_enter")
  int test(void *ctx) {
    bpf_loop(1, loop_fn, NULL, 0);
    return 0;
  }

And checked if load is successful.

[1] e6f2dd0f8067 ("bpf: Add bpf_loop helper")
[2] see <kernel>/tools/lib/bpf/features.c


