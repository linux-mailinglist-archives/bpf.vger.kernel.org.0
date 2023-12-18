Return-Path: <bpf+bounces-18231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C58817959
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 19:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197A7285D17
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 18:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B113E71465;
	Mon, 18 Dec 2023 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8bYzy65"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E65D74A;
	Mon, 18 Dec 2023 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5522ba3f94aso4147831a12.1;
        Mon, 18 Dec 2023 10:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702922599; x=1703527399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXdqNZYmXLzUeBYg/YluJviWJ+yD19wV70WwK0p1fG8=;
        b=m8bYzy65HtGMtq60Kairil4zTZJqOI1bdOnM4SQm9tBlMJ07d3PFJ6PM7qT7xkg4dr
         +X2OTC8Z3W2oW4Gq0Ig0DOe2uaJgc8PMtG2tfcgxBlCKVZ7dOjEax7g1dIbxUB61SHqS
         pt+ZXobeWvAoTNiruzksK8tb0x3wTb8x18RRydKWw1TzZd+fUo/SPcP9nqJWtmyMAada
         p+WCxoB3B83DLg4Da4QXN7c9Eyb2N+szZL70eNg0AUtih3FbQWczEVA20cHKQxZQDx88
         fIH0KgIA6HM5bBY8rcPgSxzClRNCKw73WoT8X3J9NMuruHtRRrdcByWwD2h6testpLC4
         EFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702922599; x=1703527399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXdqNZYmXLzUeBYg/YluJviWJ+yD19wV70WwK0p1fG8=;
        b=uaii+gHShPY+SHwYo2ZA5EGUUI/qTGzrot45I4YEYvyCc3x1/TnjjTOtDCAEPIRvym
         3gltrXeAShjdAq9rgWh7gHrNh5zJfrVm5o8BFAdGt0oU59nCCHiMePAVQHmV4my9rOry
         OZv1kTYOWR1WxKrjKJuBPhEZg9RZr7ISFKCHK3losVlonBPcHSLemkDBupP/dtYI4Th5
         5A0+MhAyRjrdySuSKVSLrVoyWzJQj3cE5ZEGVH2ykwkDc+n1o/IKjSCehGx+b3mcdB7B
         kbxDWFleAqvOiE5J4QGRrEHaF7W44Jwig6Fotx9Sz0fs9kzgF5pWfMmiCU7Qdof8zXhX
         NIug==
X-Gm-Message-State: AOJu0Yx0kCzpBv0wZ9czG5cNCElcHqgpvj8xPb03MQcO1km/MbrTGwo0
	Web63YM6NR2SSte0MLYBcs5qWxJy4N3tzf81l50=
X-Google-Smtp-Source: AGHT+IG2ZkH310Fgk2lLq12WAYCF4BIANdkcKZIdUpqWMhraUa3k7jB2IU6dY7NJgInRMaBzR4Zm+9LaGOthG+hHwpw=
X-Received: by 2002:a17:906:c14a:b0:a23:5780:6305 with SMTP id
 dp10-20020a170906c14a00b00a2357806305mr726692ejc.216.1702922598760; Mon, 18
 Dec 2023 10:03:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217131716.830290-1-menglong8.dong@gmail.com> <20231217131716.830290-4-menglong8.dong@gmail.com>
In-Reply-To: <20231217131716.830290-4-menglong8.dong@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Dec 2023 10:03:06 -0800
Message-ID: <CAEf4BzZc3edO35FJwxgRscE4n5_qkpwQOJXjUAYjjfWwLkcANg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: add testcase to
 verifier_bounds.c for JMP_NE
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	alexei.starovoitov@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 5:18=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Add testcase for the logic that the verifier tracks the BPF_JNE for regs.
> The assembly function "reg_not_equal()" that we add is exactly converted
> from the following case:
>
>   u32 a =3D bpf_get_prandom_u32();
>   u64 b =3D 0;
>
>   a %=3D 8;
>   /* the "a > 0" here will be optimized to "a !=3D 0" */
>   if (a > 0) {
>     /* now the range of a should be [1, 7] */
>     bpf_skb_store_bytes(skb, 0, &b, a, 0);
>   }
>
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_bounds.c     | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>

LGTM, but please add a comment that we rely on bpf_skb_store_byte's
4th argument being defined as ARG_CONST_SIZE, so zero is not allowed.
And that r4 =3D=3D 0 check is providing us this exclusion of zero from
initial [0, 7] range.


> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index ec430b71730b..3fe2ce2b3f21 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -1075,4 +1075,31 @@ l0_%=3D:   r0 =3D 0;                              =
           \
>         : __clobber_all);
>  }
>
> +SEC("tc")
> +__description("bounds check with JMP_NE for reg edge")
> +__success __retval(0)
> +__naked void reg_not_equal(void)

technically, you are testing `r4 =3D=3D 0` :) so maybe call the test
reg_equal_const or something. And then add similar test where you
actually have `r4 !=3D 0`, called req_no_equal_const?

> +{
> +       asm volatile ("                                 \
> +       r6 =3D r1;                                        \
> +       r1 =3D 0;                                         \
> +       *(u64*)(r10 - 8) =3D r1;                          \
> +       call %[bpf_get_prandom_u32];                    \
> +       r4 =3D r0;                                        \
> +       r4 &=3D 7;                                        \
> +       if r4 =3D=3D 0 goto l0_%=3D;                          \
> +       r1 =3D r6;                                        \
> +       r2 =3D 0;                                         \
> +       r3 =3D r10;                                       \
> +       r3 +=3D -8;                                       \
> +       r5 =3D 0;                                         \
> +       call %[bpf_skb_store_bytes];                    \
> +l0_%=3D: r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32),
> +         __imm(bpf_skb_store_bytes)
> +       : __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.39.2
>

