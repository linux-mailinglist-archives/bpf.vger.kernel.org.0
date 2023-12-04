Return-Path: <bpf+bounces-16605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED0C803CA6
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 19:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FC1281151
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 18:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7406E2EB0A;
	Mon,  4 Dec 2023 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU8oxty/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409C2D2
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 10:19:10 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ca0288ebc5so16707011fa.0
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 10:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701713948; x=1702318748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5hHvryNiKjfIEXp1xAqAbzd0zw2wErJBOsWeNkFOOI=;
        b=AU8oxty/lxmW+75T40nd5zeWFvRKEbQkhFWwADk1PG9XmNJor9achgwu5esoy6yH+e
         V+pW6RuxBl1TCBjorgaOXKOLSxeQd/ynfOup78iFfJtnH1w8lm36Z+kjntgFFSbmg8qY
         rWIBypbCQ51Os9rQFPICdrdoJrofk69hPq08ME/B+UL9uMAvd9FjOJUCJokXF9BuOAP+
         TBko6k3TRURGNUfKqqOuUqKEVngyCzmx+6owaHS7KNAHucKWL4In7ZtsdhieKUgfy4qt
         VlX8H3Mw+iiCjeCIPNEIEbvoPhWKv75WuGAHV5zR1cFxAPGAXkPI/W0QCB+E/E6V+EVO
         dDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713948; x=1702318748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5hHvryNiKjfIEXp1xAqAbzd0zw2wErJBOsWeNkFOOI=;
        b=tqFJhScZNqumyw5M3+fljLj/7S3QQ0gVJef7aesEQgz/jNLmOnP56nOzCUwfzarUcO
         SvGkE6ReYSa+WKJm/xZgM3/JxkaEexzRKFTKP4CN0a+PgNvd4U+XNqs+GauL0xJVC9Xo
         C5JDiq+0j8AGZZZlbeUoImN3MYwEn78FaW67q0+BmYbjhTmHwgnzNdT/gQtFJ9hH5qLG
         /QI4SCNWZTR4d4HVYnekTza1vuaDLlZK+UQz125b9oPs5Nkz2VIGfP1gdOEN5clbGoMb
         2tk4zNkmW2S/WBdCUT3Y5mm+8LAhJBcLQH8UeKytwy+qYKEZyE8F/b4LFQ75ExwSUc0K
         P/Ag==
X-Gm-Message-State: AOJu0YzzambevAj3Y1f/QUhCYfQTpIeod1LluxIA4XMx/R9Talmnlo1Q
	Up3qHJTKrCDKupZWo/dqrVeFbYQZN5hTRq3QP3LdwKU+
X-Google-Smtp-Source: AGHT+IEGWxdsjsgHpKWGSNrmbDr4ilE5IdduOJvoIZJjHJ6OfgMqTCR9nzx154B6mGtqx7CdaFggPNrERJBK64XQbQs=
X-Received: by 2002:a2e:9b8e:0:b0:2ca:ad:8811 with SMTP id z14-20020a2e9b8e000000b002ca00ad8811mr1097145lji.57.1701713948162;
 Mon, 04 Dec 2023 10:19:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231202230558.1648708-1-andreimatei1@gmail.com> <20231202230558.1648708-2-andreimatei1@gmail.com>
In-Reply-To: <20231202230558.1648708-2-andreimatei1@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 10:18:55 -0800
Message-ID: <CAEf4BzZo9W9iBpeOisj46ur8V=+W0N4kUouo+UZqOd0ikNJLCg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/3] bpf: add some comments to stack representation
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com, eddyz87@gmail.com, 
	kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 2, 2023 at 3:06=E2=80=AFPM Andrei Matei <andreimatei1@gmail.com=
> wrote:
>

Please add some commit message here, even if a single sentence one.



> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  include/linux/bpf_verifier.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index aa4d19d0bc94..ec3612c2b057 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -316,7 +316,17 @@ struct bpf_func_state {
>         /* The following fields should be last. See copy_func_state() */
>         int acquired_refs;
>         struct bpf_reference_state *refs;
> +       /* Size of the current stack, in bytes. The stack state is tracke=
d below, in
> +        * `stack`. allocated_stack is always a multiple of BPF_REG_SIZE.
> +        */
>         int allocated_stack;
> +       /* The state of the stack. Each element of the array describes BP=
F_REG_SIZE
> +        * (i.e. 8) bytes worth of stack memory.
> +        * stack[0] represents bytes [*(r10-8)..*(r10-1)]
> +        * stack[1] represents bytes [*(r10-16)..*(r10-9)]
> +        * ...
> +        * stack[allocated_stack/8 - 1] represents [*(r10-allocated_size)=
..*(r10-allocated_size+7)]
> +        */
>         struct bpf_stack_state *stack;
>  };
>
> @@ -630,6 +640,10 @@ struct bpf_verifier_env {
>         int exception_callback_subprog;
>         bool explore_alu_limits;
>         bool allow_ptr_leaks;
> +       /* Allow access to uninitialized stack memory. Writes with fixed =
offset are
> +        * always allowed, so this refers to reads (with fixed or variabl=
e offset),
> +        * to writes with variable offset and to indirect (helper) access=
es.
> +        */
>         bool allow_uninit_stack;
>         bool bpf_capable;
>         bool bypass_spec_v1;
> --
> 2.40.1
>

