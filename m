Return-Path: <bpf+bounces-16475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CD680182A
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 00:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2FA1F210C8
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 23:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F64056B85;
	Fri,  1 Dec 2023 23:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMNpn6kD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8123BDD
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 15:54:03 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1a58fbe5e1so35068066b.2
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 15:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701474842; x=1702079642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AUdS0NIK+mqeTpoMU8uf+6hk+v+305jeSCEGwKfoEo=;
        b=aMNpn6kDOOu9A7IO2M6bWOVHXLXnlCLaU9QGA2aCGxL3/tQ/nAg6wcLZJyAPmWHpyJ
         LOVQTTcd36HZQI0y5wEvrkft1+stYyjbt2KiMPgaK1P+o5KuAqY2S7k7OclVRZK++Nzn
         KhXHRjjfRkOWp0eQ/iJtiro6eWU5meGc/zKOCnKjNLul0zmVQpIwLpqHQeO352tvmjR8
         y/WPktKzsHZHPlvzrfX8PF2yM9rR94IaG8UEkiUpPivpGaJO4L0Y4eQXfTm7UOFZoMAa
         ib9oJvjzvVg4RTdKPVotMA1rQfTl35FHyE0ca/G4eNeRe6hB+Cd/eugAIWXnlcNFcCRl
         3YEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474842; x=1702079642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AUdS0NIK+mqeTpoMU8uf+6hk+v+305jeSCEGwKfoEo=;
        b=j4GYagzXK1CnfhkPiDXOMKkvk9LezJMSkk8oSCUakryD6n4t6C6O11dB3fuTHgjpE2
         r0tvW8T8bk0QY14vxMnQ97XPAp6rMnm4CIrXRybAhkH9OjBY6jt1T+5WIYmf32KpcP11
         qiKoCJJzL/vNt/2rETFT5fplUfSbRYyaNSuzZ3UxXHKsqvoweoojHD7ZBG5BGYgTYjk2
         zJy97AeRe20e8YlK/kaDVYugDCOywL+xarBKacxEqCsJ4Bc+MZ6jvOvjgJboOHbWBNCt
         +qDxa6KOX+BWAevS0LpOc5anEeQY2WzrT94uBcSp9LzneHWssIgYxhs0lyunPxuamlFU
         t1sw==
X-Gm-Message-State: AOJu0Ywaxm5x5sZIjuxPnZrIQzv8T3AcU3yWQW7Dtib/2zQnbv/zG3qB
	yKkRVqIkVfa7npxABGhjGo38lultTbYZ5yRA9ZM=
X-Google-Smtp-Source: AGHT+IGrV6q6umFqbGWA8R5OD7Dl0Z3vjSDuOaSdD2qZ3x7YK6Q3TqOD5GPeutir2zk+Ak+cwwX6OXDfU8yoFNZA8Qs=
X-Received: by 2002:a17:906:51d3:b0:a04:837d:ebbc with SMTP id
 v19-20020a17090651d300b00a04837debbcmr1466964ejk.28.1701474841870; Fri, 01
 Dec 2023 15:54:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201024640.3417057-1-yonghong.song@linux.dev>
In-Reply-To: <20231201024640.3417057-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Dec 2023 15:53:50 -0800
Message-ID: <CAEf4BzaS1UgzExV_P=nVdLtZXSHbqk+SSsaz-o+Xt02=OnZKaQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: Fix a verifier bug due to incorrect branch
 offset comparison with cpu=v4
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 6:47=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
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
>  kernel/bpf/core.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> Changelogs:
>   v2 -> v3:
>     - not doing init for off_min/off_max at decl time and rather do
>       it at 'off' assignment time to make code better.
>   v1 -> v2:
>     - Change off from s32 to s64 to capture overflow case
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index cd3afe57ece3..e76762b5ad28 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -371,14 +371,19 @@ static int bpf_adj_delta_to_imm(struct bpf_insn *in=
sn, u32 pos, s32 end_old,
>  static int bpf_adj_delta_to_off(struct bpf_insn *insn, u32 pos, s32 end_=
old,
>                                 s32 end_new, s32 curr, const bool probe_p=
ass)
>  {
> -       const s32 off_min =3D S16_MIN, off_max =3D S16_MAX;
> +       s64 off_min, off_max;
>         s32 delta =3D end_new - end_old;
> -       s32 off;
> +       s64 off;

I combined off declaration with off_min, off_max on the same line.
Pushed to bpf, thanks!


>
> -       if (insn->code =3D=3D (BPF_JMP32 | BPF_JA))
> +       if (insn->code =3D=3D (BPF_JMP32 | BPF_JA)) {
>                 off =3D insn->imm;
> -       else
> +               off_min =3D S32_MIN;
> +               off_max =3D S32_MAX;
> +       } else {
>                 off =3D insn->off;
> +               off_min =3D S16_MIN;
> +               off_max =3D S16_MAX;
> +       }
>
>         if (curr < pos && curr + off + 1 >=3D end_old)
>                 off +=3D delta;
> --
> 2.34.1
>

