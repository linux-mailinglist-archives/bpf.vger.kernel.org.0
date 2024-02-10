Return-Path: <bpf+bounces-21691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E509B8502D0
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 07:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2E8282FCD
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 06:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6F1804D;
	Sat, 10 Feb 2024 06:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnyWN5yB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652B3171B4
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707547837; cv=none; b=pPyswW4xYBFu4SQTarRQHNwnkONg8B3/eZXvdumpPxwXevgfFalvgr5lMb9NUHQTahj9gBwnKaT0RMxuDEQh43Z3uKl18qKQlZQpi/HggEbI593Hp7PX0N67zavnsLpOBbkG3TfgO+9ejovian9NJ3aZ6Ll0mnIoD9Z34uqqekc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707547837; c=relaxed/simple;
	bh=PohR/NYDZ0E/mLKlqIrdymR28sYwxAg8sf1TqpycxEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HsSrkTU4OI4Ozrc9+KiX/SqlPQG1qr2HkbOYXFpoz6IwcfKrsku61p7uAgbcfyBHHQ1Ffe26N5wixFjFAwNAaWe9R7XJCAmueranMj/ePxy0vPKKSfd8Od6zHIsO18v5/hDPbWVLjuwph7E+EG0ggheCMfhHEVVNIcoDqn/0Gq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnyWN5yB; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a38271c0bd5so207609666b.0
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 22:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707547833; x=1708152633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kofXlfSw5eG7uFS5fzcRJor8xoj2JsyQJRb5Nt+X1gc=;
        b=BnyWN5yBh6YzhHRRBjcK/tEX5mtP1TkrwiLV7oyrfqrpsynMTKZ83hR6Sbq6OIJ3iV
         S4F7uEHQz6dLPbDR9/7IwClRdJeU1Jbgh6PgBrWGtVlPsAoMTltoYxnMlhQzzNR6TrlT
         ldu6k/XTBItSfJA7oCLHKZ7NEEs+Kk8wXciAm7OCslQskVMRiU0YisrZt8LQJQT78ULD
         EzGoVoBk6rTIPcZ5HEg/sJM3k0ZXhp4rdjPYQ/GOW3PUi+YVIqBoJLsn4IvBZ7vzO2lg
         eEsc/ymUgGLl95u7IMTVNtYRw4BDhKK5r9FRFUIeysL/Whd+8fzGigOkQswmSupE+BG4
         bkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707547833; x=1708152633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kofXlfSw5eG7uFS5fzcRJor8xoj2JsyQJRb5Nt+X1gc=;
        b=AS1kWVOnQXm0XqcApT9uLBgr5YtZQ386grZlLeuj183Sp3Y3nY4gJZYowX4vZIRYcf
         XFQe53mbXk9hLEoG5o+56q7WZZ83OjnFiHdYGr2vftOpDFIUPGU8yMY4g+1Ulm3W16Bh
         neF8QvMqg82KUDOfk7AL3xBri0gQ4Z4CnIx35hYOe+bTTHJvTTNO8LItRXB7F4EphcYw
         lgw5YLpxxTKLppX7CdSvqpZZT6I/O5mB87WDyk6MrEmqE4tIPLnVjkYJ8U/37IBo4M43
         0do5Kb9rLjSYVXnGY9LgydvgZDoG9TcIUTPU5MyLlPuIo7Auj0mDKkan3DbBkbXu5D7S
         4VjQ==
X-Gm-Message-State: AOJu0Yx76aWjiQ2fMeXErtO7wNIhiyEKDytmRbgyJE3dR/rAEqbBGhqA
	sVODS8xAmWyy9xzolBoxQSI1j8v7wHlMRQxnLDtkPsiBMTFiuyVEvfwysqkmlLem2G59Z76CWCz
	lq7z83C4nns5Z6/dAdIyyVn5anb8=
X-Google-Smtp-Source: AGHT+IFZgv9srpEBT2S7q2JO6RMJz8FGaKrZrkZ33WTwTTcbuhNUwu9Nv5gvlp+EIa1Fxms2quSzm51R1MlQt+/yMKY=
X-Received: by 2002:a17:906:1b16:b0:a38:80a3:6692 with SMTP id
 o22-20020a1709061b1600b00a3880a36692mr724469ejg.30.1707547833413; Fri, 09 Feb
 2024 22:50:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-2-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 10 Feb 2024 07:49:57 +0100
Message-ID: <CAP01T75mtjMqz0WaJvzaXrO7gjbbqwbV14q8rU-KaNUsuJ0vkw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/20] bpf: Allow kfuncs return 'void *'
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, tj@kernel.org, brho@google.com, hannes@cmpxchg.org, 
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 05:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Recognize return of 'void *' from kfunc as returning unknown scalar.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  kernel/bpf/verifier.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ddaf09db1175..d9c2dbb3939f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12353,6 +12353,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>                                         meta.func_name);
>                                 return -EFAULT;
>                         }
> +               } else if (btf_type_is_void(ptr_type)) {
> +                       /* kfunc returning 'void *' is equivalent to returning scalar */
> +                       mark_reg_unknown(env, regs, BPF_REG_0);
>                 } else if (!__btf_type_is_struct(ptr_type)) {
>                         if (!meta.r0_size) {
>                                 __u32 sz;
> --
> 2.34.1
>

