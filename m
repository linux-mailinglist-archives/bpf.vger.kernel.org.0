Return-Path: <bpf+bounces-9577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B96D7992E4
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 01:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAC81C20BBA
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 23:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765E3747C;
	Fri,  8 Sep 2023 23:42:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376307466
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 23:42:19 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4EDE6B
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 16:42:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bf1f632b8so325454866b.1
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 16:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694216535; x=1694821335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVueYonso672uybu5Vb51IyxXsZW8Dwv4UiB+SFLpfE=;
        b=LricNFa2Bu1y/gTlu5piJVubmBCwjYQthnO8tV9bz/8bIVS/dD6/4LNLwKnnD7Qk9W
         T5sAxZ/Ru3rJ7VPrUXPe49r4RxUsDLnCq9/o9vcPZloou2GC65oVUTKUbv2WMPzy3aAa
         rnOfrO/RSK5InqIznd6Won2cIZFyyjozTAcCfkrdl2lB0twYCixQnDZ3mMkx0/evYrKu
         5tBsLqvQdG1GV5eN1H14GtvrLT/zS5y1lMLmzbyVFY+Sg1p90FL9s/EvBJgkuqfAzKx4
         L0BmgrCCUbs402dPEhG95rAlinpVqzoRzu4BYXiIe+530K4e94BH+e1/3BzQ/iCIUbvW
         eO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694216535; x=1694821335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVueYonso672uybu5Vb51IyxXsZW8Dwv4UiB+SFLpfE=;
        b=hNyz15qFIXhvpd3fziZJylGmZH6jXQ6L4A2Nu/OltPYRqsAdYht2iaQHDmiFOJWcHu
         WC39J/5/Ku1YovDSH7/UW7UtPsHGq6GhfpylyTSkyeX281Gr01MXi+DrP+/jHmidXR1B
         zhZ9T060U1atwtEw8DUjJlejeb218c6xHM0P9URvwAOAek95GpStN7cBuQb2NJruDKe/
         gIqwjQKUhf8p9ribg2UDfH5C59QkDt1GTdFdPw4yDAMF9TZNVRYD5AC73lwUH4wxTwXj
         7I7F4N+VauI0DZj9ZKq5prVhVZV8DjpdxHg9sc6E75b2t4rvT/7uLh+HV819fy8IZqUf
         dw0Q==
X-Gm-Message-State: AOJu0Yx4Wn9cy74q2DNYNNNc5EwN/dZSX7LXW5qHb9WwfRK5NFlcvN20
	dIW/W5LMgq8Kuv25jCIBJJLxKJIDGimhIEQGWNU=
X-Google-Smtp-Source: AGHT+IE60zlKI8rm8AXS7O3qZlk3MqMPNQwEBjPqR8+Uc31Q/LG5dYIejxo/9KqyZtj+5avq7k8Hq5GIUN1/eB7uFlc=
X-Received: by 2002:a17:906:328c:b0:99d:e142:464e with SMTP id
 12-20020a170906328c00b0099de142464emr2888536ejw.11.1694216535359; Fri, 08 Sep
 2023 16:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907210023.2467151-1-sdf@google.com>
In-Reply-To: <20230907210023.2467151-1-sdf@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Sep 2023 16:42:03 -0700
Message-ID: <CAEf4Bzb5VkJ=_4NKjSuwOVAUeSBxyVjNu_rMmatfeQZdB+bohg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Future-proof connect4_prog.c
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 2:00=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> With the new internal clang version I see the following optimization
> that makes connect4 program unverifiable.
>
> The following code:
>
>         int do_bind()

Yonghong added __weak to do_bind a few months ago ([0]), which makes
it illegal for the compiler to assume 0 or 1 return. Can you please
double check that this is the issue with __weak?

  [0] https://lore.kernel.org/bpf/20230310012410.2920570-1-yhs@fb.com/


>         {
>                 if (bpf_bind() !=3D 0)
>                         return 0;
>                 return 1;
>         }
>         int connect_v4_prog()
>         {
>                 return do_bind() ? 1 : 0;
>         }
>
> Becomes:
>
>         int do_bind()
>         {
>                 if (bpf_bind() !=3D 0)
>                         return 0;
>                 return 1;
>         }
>         int connect_v4_prog()
>         {
>                 return do_bind();
>         }
>
> IOW, looks like clang is able to see that do_bind returns only 0 and
> 1 and the extra branch around 'return do_bind' is not needed.
> This, however, seems to break the verifier, which assumes that
> bpf2bpf calls can return 0-0xffffffff.
>
> Note, I can produce those programs only with the internal fork of clang.
> The latest one from git still produced correct bytecode. It might be
> some options/optimizations that we enable and that are still
> disabled for the general upstream users, not sure. I've desided
> to send this patch out anyway since it seems like a correct optimization
> the compiler might do.
>
> So to be future-proof, reshape the code a bit to return bpf_bind
> result directly. This will not give any hint to the clang about
> the return value and will force it generate that '? 1: 0' branch
> at the callee.
>
> Good program:
>
> 0000000000000000 <do_bind>:
>        0:       b4 02 00 00 7f 00 00 04 w2 =3D 0x400007f
>        1:       63 2a f4 ff 00 00 00 00 *(u32 *)(r10 - 0xc) =3D r2
>        2:       b4 02 00 00 02 00 00 00 w2 =3D 0x2
>        3:       63 2a f0 ff 00 00 00 00 *(u32 *)(r10 - 0x10) =3D r2
>        4:       b7 02 00 00 00 00 00 00 r2 =3D 0x0
>        5:       63 2a fc ff 00 00 00 00 *(u32 *)(r10 - 0x4) =3D r2
>        6:       63 2a f8 ff 00 00 00 00 *(u32 *)(r10 - 0x8) =3D r2
>        7:       bf a2 00 00 00 00 00 00 r2 =3D r10
>        8:       07 02 00 00 f0 ff ff ff r2 +=3D -0x10
>        9:       b4 03 00 00 10 00 00 00 w3 =3D 0x10
>       10:       85 00 00 00 40 00 00 00 call 0x40
>       11:       bf 01 00 00 00 00 00 00 r1 =3D r0
>       12:       b4 00 00 00 01 00 00 00 w0 =3D 0x1
>       13:       15 01 01 00 00 00 00 00 if r1 =3D=3D 0x0 goto +0x1 <LBB0_=
2>
>       14:       b4 00 00 00 00 00 00 00 w0 =3D 0x0
>
> 00000000000001b0 <LBB1_30>:
>       54:       bc 60 00 00 00 00 00 00 w0 =3D w6
>       55:       95 00 00 00 00 00 00 00 exit
>
> 0000000000000578 <LBB1_28>:
>      ...
>      180:       85 10 00 00 ff ff ff ff call -0x1
>      181:       b4 06 00 00 01 00 00 00 w6 =3D 0x1
>      182:       56 00 7f ff 00 00 00 00 if w0 !=3D 0x0 goto -0x81 <LBB1_3=
0>
>      183:       b4 06 00 00 00 00 00 00 w6 =3D 0x0
>      184:       05 00 7d ff 00 00 00 00 goto -0x83 <LBB1_30>
>
> Bad program:
> 0000000000000000 <do_bind>:
>        0:       b4 02 00 00 7f 00 00 04 w2 =3D 0x400007f
>        1:       63 2a f4 ff 00 00 00 00 *(u32 *)(r10 - 0xc) =3D r2
>        2:       b4 02 00 00 02 00 00 00 w2 =3D 0x2
>        3:       63 2a f0 ff 00 00 00 00 *(u32 *)(r10 - 0x10) =3D r2
>        4:       b7 02 00 00 00 00 00 00 r2 =3D 0x0
>        5:       63 2a fc ff 00 00 00 00 *(u32 *)(r10 - 0x4) =3D r2
>        6:       63 2a f8 ff 00 00 00 00 *(u32 *)(r10 - 0x8) =3D r2
>        7:       bf a2 00 00 00 00 00 00 r2 =3D r10
>        8:       07 02 00 00 f0 ff ff ff r2 +=3D -0x10
>        9:       b4 03 00 00 10 00 00 00 w3 =3D 0x10
>       10:       85 00 00 00 40 00 00 00 call 0x40
>       11:       bf 01 00 00 00 00 00 00 r1 =3D r0
>       12:       b4 00 00 00 01 00 00 00 w0 =3D 0x1
>       13:       15 01 01 00 00 00 00 00 if r1 =3D=3D 0x0 goto +0x1 <LBB0_=
2>
>       14:       b4 00 00 00 00 00 00 00 w0 =3D 0x0
>
> 00000000000001b0 <LBB1_3>:
>       54:       bc 60 00 00 00 00 00 00 w0 =3D w6
>       55:       95 00 00 00 00 00 00 00 exit
>
> 0000000000000578 <LBB1_28>:
>      ...
>      180:       85 10 00 00 ff ff ff ff call -0x1
>      181:       bc 06 00 00 00 00 00 00 w6 =3D w0
>      182:       05 00 7f ff 00 00 00 00 goto -0x81 <LBB1_3>
>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  tools/testing/selftests/bpf/progs/connect4_prog.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/te=
sting/selftests/bpf/progs/connect4_prog.c
> index 7ef49ec04838..b7fc46a0787b 100644
> --- a/tools/testing/selftests/bpf/progs/connect4_prog.c
> +++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
> @@ -41,10 +41,7 @@ int do_bind(struct bpf_sock_addr *ctx)
>         sa.sin_port =3D bpf_htons(0);
>         sa.sin_addr.s_addr =3D bpf_htonl(SRC_REWRITE_IP4);
>
> -       if (bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa)) !=3D 0)
> -               return 0;
> -
> -       return 1;
> +       return bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa));
>  }
>
>  static __inline int verify_cc(struct bpf_sock_addr *ctx,
> @@ -194,7 +191,7 @@ int connect_v4_prog(struct bpf_sock_addr *ctx)
>         ctx->user_ip4 =3D bpf_htonl(DST_REWRITE_IP4);
>         ctx->user_port =3D bpf_htons(DST_REWRITE_PORT4);
>
> -       return do_bind(ctx) ? 1 : 0;
> +       return do_bind(ctx) ? 0 : 1;
>  }
>
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.42.0.283.g2d96d420d3-goog
>

