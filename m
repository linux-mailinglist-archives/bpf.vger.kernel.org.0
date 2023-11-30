Return-Path: <bpf+bounces-16218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7E17FE4B8
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 01:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE718B20D6B
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 00:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9F2388;
	Thu, 30 Nov 2023 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGWknLVw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDB21A3
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:20:10 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a013d22effcso46697066b.2
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701303608; x=1701908408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xS+QlX6HhoDJ3QFE5FMThj8r+l9Cv4VlfhiwaQtBGE=;
        b=lGWknLVwbDOmDuUCIzo9A5PV0yuhtyBcyLxxvij4wBEGGXFE0Vszl5TWWJJ6xk2mdk
         kcr8reCvuJQg59/36X2VA/IAKMJ5oswxkO6FOC/ETnnQ6l0zfFuoW5lgWZZaUBA21rCe
         FD2xghXZrLGSnGdupsAgTsS2bZ4l3NYs2+8h3/Uz+MTsKIMtrjhXo8zhqf6CWMwYR82W
         ca8dJ+yeshkp2ufNocrKecuMDESpl1GYCV/PWwe+UdT3rSjGiW6XVK91kqmiPliOR9DL
         pNFifOTlgNn0LU7ouI1Qwddcg3bLWoR+4qeFFonaXsWOxn2x2MJKXAg31guUzW5oss27
         VtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701303608; x=1701908408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xS+QlX6HhoDJ3QFE5FMThj8r+l9Cv4VlfhiwaQtBGE=;
        b=DLxwY3P/Uq2MmWNuZ4d90lJlFDJvFgd/j2b1ErfM3a0vPAzcaOmg9hY3ARhy/4fbVm
         TdPV+VVMzWneX0Dvw28NrLIGlhuV47g287KG7w9sV5xxI57D3R9Dex5Gbh9b8u2sJzPq
         r6eha9BxV7bHpfSJRi25LO48o7GVq7NZiIFgYWQPOyuYEJX/i/J0gWe32ACwtzqKTpll
         OGv4LQhNClZDUzKXMvu5/amrkroZjRy70L7X3CuHQcAPcbegQp2YRmRTQCTvahUp0pU+
         eB3RZ4lruRnuxrckgql9sCodRRGOO3NuImOS8XmurBUzJsn9ensWMELBRJRXHv0cTUB7
         Oq6w==
X-Gm-Message-State: AOJu0YxsPOrvk5wgw2GyEhjuxpjgt6Bi0/zyoLh4Z+8yLAY6O7oW+cBe
	FtwOL0JlrsQhtNbips7WDHp+g6GvcZ8ljtlh1tg=
X-Google-Smtp-Source: AGHT+IFqRXW5jWMFKykZPJg0F5n4GzoHdD4orLXiCRa17pg5HO6NoOZHUPuIfn1KVoi5I7fW3sNwiO1MU15QYFcIXjg=
X-Received: by 2002:a17:906:158e:b0:9fd:8d07:a3ad with SMTP id
 k14-20020a170906158e00b009fd8d07a3admr11173204ejd.17.1701303608289; Wed, 29
 Nov 2023 16:20:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130001516.3522627-1-yonghong.song@linux.dev>
In-Reply-To: <20231130001516.3522627-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Nov 2023 16:19:56 -0800
Message-ID: <CAEf4Bza_pH9kEg82=z0eTSjJNgTi_zipS76sR8sW_YOvo1ccRA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix a verifier bug due to incorrect branch
 offset comparison with cpu=v4
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 4:15=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Bpf cpu=3Dv4 support is introduced in [1] and Commit 4cd58e9af8b9
> ("bpf: Support new 32bit offset jmp instruction") added support for new
> 32bit offset jmp instruction. Unfortunately, in function
> bpf_adj_delta_to_off(), for new branch insn with 32bit offset, the offset
> (plus/minor a small delta) compares to 16-bit offset bound
> [S16_MIN, S16_MAX], which caused the following verification failure:
>   $ ./test_progs-cpuv4 -t verif_scale_pyperf180
>   ...
>   insn 10 cannot be patched due to 16-bit range
>   ...
>   libbpf: failed to load object 'pyperf180.bpf.o'
>   scale_test:FAIL:expect_success unexpected error: -12 (errno 12)
>   #405     verif_scale_pyperf180:FAIL
>
> Note that due to recent llvm18 development, the patch [2] (already applie=
d
> in bpf-next) needs to be applied to bpf tree for testing purpose.
>
> The fix is rather simple. For 32bit offset branch insn, the adjusted
> offset compares to [S32_MIN, S32_MAX] and then verification succeeded.
>
>   [1] https://lore.kernel.org/all/20230728011143.3710005-1-yonghong.song@=
linux.dev
>   [2] https://lore.kernel.org/bpf/20231110193644.3130906-1-yonghong.song@=
linux.dev
>
> Fixes: 4cd58e9af8b9 ("bpf: Support new 32bit offset jmp instruction")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index cd3afe57ece3..beff7e1d7fd0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -371,14 +371,17 @@ static int bpf_adj_delta_to_imm(struct bpf_insn *in=
sn, u32 pos, s32 end_old,
>  static int bpf_adj_delta_to_off(struct bpf_insn *insn, u32 pos, s32 end_=
old,
>                                 s32 end_new, s32 curr, const bool probe_p=
ass)
>  {
> -       const s32 off_min =3D S16_MIN, off_max =3D S16_MAX;
> +       s64 off_min =3D S16_MIN, off_max =3D S16_MAX;
>         s32 delta =3D end_new - end_old;
> -       s32 off;
> +       s64 off;
>
> -       if (insn->code =3D=3D (BPF_JMP32 | BPF_JA))
> +       if (insn->code =3D=3D (BPF_JMP32 | BPF_JA)) {
>                 off =3D insn->imm;
> -       else
> +               off_min =3D S32_MIN;
> +               off_max =3D S32_MAX;
> +       } else {

nit: it would be more symmetrical and easier to follow if you set
S16_{MIN,MAX} in this branch, instead of using variable initialization
approach

>                 off =3D insn->off;
> +       }
>
>         if (curr < pos && curr + off + 1 >=3D end_old)
>                 off +=3D delta;
> --
> 2.34.1
>

