Return-Path: <bpf+bounces-34343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9324192C841
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 04:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34C41F237DA
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 02:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F008F5D;
	Wed, 10 Jul 2024 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtyUACbE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ACF4C85
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720577326; cv=none; b=YJgTo+e22/rSzs3GhEYoZPcV+tks0fLfSe/WttLE2cSKHyBRg7foeLeetAPCX3qorKOl94sWSZBDQgThCKb4Efii6MCye0d6tkvCd6C/1QjO19AMJwyLk34Tu2nFPU61QZ90IibxM7hJJ9kw8jNJ4ekVdSnAl81O4hIdD2mg3Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720577326; c=relaxed/simple;
	bh=l+Jg1Rh88nmA9np3Raf/Vu5H61m2ytloz9+0tPc+5B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jH3z1LhsSCH5x9z2A8xwMdGoTdzfYvfBzaMH1zKaLp55xsMF5SdeDaXmYP14ciDKtT32c9tMRraiy2WOjeeO/hViLgm9uKRAXpHbRpv/Wr+nOQUpGdL8EobFuhaK4P6tmTLysqmGk33GGK3xRtGtWCCoQ41TynZT6RpSiidwqq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtyUACbE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42662d80138so21622115e9.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 19:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720577323; x=1721182123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvJzK1VHXPj2kWt7tDhANaRTvYzg1A7S/oCK7lYp4yk=;
        b=NtyUACbExoG/0qc1mCey3sFgKKZUSkTNUdjTwTg+6L5JV+TdQs6gTvKCgPiYi+pwUm
         TfrGjZjrImGaI32R9wcr0OGUvE3jRG0RQ7gzSlzglsJHjxpvxKAYbXDwXEf4HcaQAYaj
         qDIlEi0ksHocY7sSqu5BelOlIRYvhGdEqQgp9+t0TbFIWHuTxpDn9lyHx9EN7PNq1eRQ
         aHMwNCKeMH+vLFvHeVxXKHD80/5JN5nL5vYSkveq0YJCSBmMWQEm8ZNevgtsrBoFPmSX
         hGYBz2jkP1Q9GMeaRMdludWgCFYbWcEztN01p4ZiaCj3hFgy5F83buQdggfdx+iUhQCj
         0DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720577323; x=1721182123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvJzK1VHXPj2kWt7tDhANaRTvYzg1A7S/oCK7lYp4yk=;
        b=Sa+BEaEGyNEymuBmI2fpaJrNS4EdBsX89xETZwb5R4wu6rxodORVXjb6q1BbmdccCR
         6qClsbYXJbe2y5N9WG+rPtHEl2mlPjpvI6xEFmgeueZwHpgWleaPNhSeDP0H0KUuHVnQ
         Gj4RI+HhqKAhpVn4qgvXQsTrMdHPNqz9SdqmQyf6NWlaB7pqIMt+iWFdlHWt9W16OVi2
         U7Vs+vULv3jyJFa7EuZ8DWhUYJTqOI7iK7mTvjUv11MQY9LI9/V0cZaHG1HpBHqOkWMB
         gNl5WeSWjve5vYBA/XuTyzOivKYIlnJKrY05e/UPQAaz3rAQtDE47cAhvb1WhWTuJaO1
         CVZg==
X-Gm-Message-State: AOJu0YwUWpJOc+xhzEylsgiR57dWVGGs2LF8YE5Jfg3h8BNB4yFEh21P
	ojieFmR2Ls5/EtqquWdXJxf18mK2G7aO+94mGihr3F8uupItPhlm8p1YkBcNveRaMze/o3ptSM5
	KexZbloLaMVfq5S5duIj0iMLSsGE=
X-Google-Smtp-Source: AGHT+IH7WPdSKLYfgnTPiC5xSMQ0Sp49ypO92HNkgSTVzKONeBDlU0HEAZHEkhK33D0ZyYHaTwGe6xdg07ZjluTQT/g=
X-Received: by 2002:adf:cd8b:0:b0:367:99fd:d7b8 with SMTP id
 ffacd0b85a97d-367cea965a1mr2396621f8f.35.1720577323243; Tue, 09 Jul 2024
 19:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701055907.82481-1-shung-hsi.yu@suse.com> <20240701055907.82481-2-shung-hsi.yu@suse.com>
In-Reply-To: <20240701055907.82481-2-shung-hsi.yu@suse.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Jul 2024 19:08:31 -0700
Message-ID: <CAADnVQ+Ou-kxp2XKo2HHZL1xhBZt-XJfoRhwm+v3FY52HxJ2Kg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: use check_add_overflow() to check
 for addition overflows
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 10:59=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> signed_add*_overflows() was added back when there was no overflow-check
> helper. With the introduction of such helpers in commit f0907827a8a91
> ("compiler.h: enable builtin overflow checkers and add fallback code"), w=
e
> can drop signed_add*_overflows() in kernel/bpf/verifier.c and use the
> generic check_add_overflow() instead.
>
> This will make future refactoring easier, and takes advantage of
> compiler-emitted hardware instructions that efficiently implement these
> checks.
>
> After the change GCC 13.3.0 generates cleaner assembly on x86_64:
>
>         err =3D adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
>    13625:       mov    0x28(%rbx),%r9  /*  r9 =3D src_reg->smin_value */
>    13629:       mov    0x30(%rbx),%rcx /* rcx =3D src_reg->smax_value */
>    ...
>         if (check_add_overflow(*dst_smin, src_reg->smin_value, dst_smin) =
||
>    141c1:       mov    %r9,%rax
>    141c4:       add    0x28(%r12),%rax
>    141c9:       mov    %rax,0x28(%r12)
>    141ce:       jo     146e4 <adjust_reg_min_max_vals+0x1294>
>             check_add_overflow(*dst_smax, src_reg->smax_value, dst_smax))=
 {
>    141d4:       add    0x30(%r12),%rcx
>    141d9:       mov    %rcx,0x30(%r12)
>         if (check_add_overflow(*dst_smin, src_reg->smin_value, dst_smin) =
||
>    141de:       jo     146e4 <adjust_reg_min_max_vals+0x1294>
>    ...
>                 *dst_smin =3D S64_MIN;
>    146e4:       movabs $0x8000000000000000,%rax
>    146ee:       mov    %rax,0x28(%r12)
>                 *dst_smax =3D S64_MAX;
>    146f3:       sub    $0x1,%rax
>    146f7:       mov    %rax,0x30(%r12)
>
> Before the change it gives:
>
>         s64 smin_val =3D src_reg->smin_value;
>      675:       mov    0x28(%rsi),%r8
>         s64 smax_val =3D src_reg->smax_value;
>         u64 umin_val =3D src_reg->umin_value;
>         u64 umax_val =3D src_reg->umax_value;
>      679:       mov    %rdi,%rax /* rax =3D dst_reg */
>         if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
>      67c:       mov    0x28(%rdi),%rdi /* rdi =3D dst_reg->smin_value */
>         u64 umin_val =3D src_reg->umin_value;
>      680:       mov    0x38(%rsi),%rdx
>         u64 umax_val =3D src_reg->umax_value;
>      684:       mov    0x40(%rsi),%rcx
>         s64 res =3D (s64)((u64)a + (u64)b);
>      688:       lea    (%r8,%rdi,1),%r9 /* r9 =3D dst_reg->smin_value + s=
rc_reg->smin_value */
>         return res < a;
>      68c:       cmp    %r9,%rdi
>      68f:       setg   %r10b /* r10b =3D (dst_reg->smin_value + src_reg->=
smin_value) > dst_reg->smin_value */
>         if (b < 0)
>      693:       test   %r8,%r8
>      696:       js     72b <scalar_min_max_add+0xbb>
>             signed_add_overflows(dst_reg->smax_value, smax_val)) {
>                 dst_reg->smin_value =3D S64_MIN;
>                 dst_reg->smax_value =3D S64_MAX;
>      69c:       movabs $0x7fffffffffffffff,%rdi
>         s64 smax_val =3D src_reg->smax_value;
>      6a6:       mov    0x30(%rsi),%r8
>                 dst_reg->smin_value =3D S64_MIN;
>      6aa:       00 00 00        movabs $0x8000000000000000,%rsi
>         if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
>      6b4:       test   %r10b,%r10b /* (dst_reg->smin_value + src_reg->smi=
n_value) > dst_reg->smin_value ? goto 6cb */
>      6b7:       jne    6cb <scalar_min_max_add+0x5b>
>             signed_add_overflows(dst_reg->smax_value, smax_val)) {
>      6b9:       mov    0x30(%rax),%r10   /* r10 =3D dst_reg->smax_value *=
/
>         s64 res =3D (s64)((u64)a + (u64)b);
>      6bd:       lea    (%r10,%r8,1),%r11 /* r11 =3D dst_reg->smax_value +=
 src_reg->smax_value */
>         if (b < 0)
>      6c1:       test   %r8,%r8
>      6c4:       js     71e <scalar_min_max_add+0xae>
>         if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
>      6c6:       cmp    %r11,%r10 /* (dst_reg->smax_value + src_reg->smax_=
value) <=3D dst_reg->smax_value ? goto 723 */
>      6c9:       jle    723 <scalar_min_max_add+0xb3>
>         } else {
>                 dst_reg->smin_value +=3D smin_val;
>                 dst_reg->smax_value +=3D smax_val;
>         }
>      6cb:       mov    %rsi,0x28(%rax)
>      ...
>      6d5:       mov    %rdi,0x30(%rax)
>      ...
>         if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
>      71e:       cmp    %r11,%r10
>      721:       jl     6cb <scalar_min_max_add+0x5b>
>                 dst_reg->smin_value +=3D smin_val;
>      723:       mov    %r9,%rsi
>                 dst_reg->smax_value +=3D smax_val;
>      726:       mov    %r11,%rdi
>      729:       jmp    6cb <scalar_min_max_add+0x5b>
>                 return res > a;
>      72b:       cmp    %r9,%rdi
>      72e:       setl   %r10b
>      732:       jmp    69c <scalar_min_max_add+0x2c>
>      737:       nopw   0x0(%rax,%rax,1)
>
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>  kernel/bpf/verifier.c | 94 +++++++++++++------------------------------
>  1 file changed, 28 insertions(+), 66 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d3927d819465..26c2b7527942 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12725,26 +12725,6 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>         return 0;
>  }
>
> -static bool signed_add_overflows(s64 a, s64 b)
> -{
> -       /* Do the add in u64, where overflow is well-defined */
> -       s64 res =3D (s64)((u64)a + (u64)b);
> -
> -       if (b < 0)
> -               return res > a;
> -       return res < a;
> -}
> -
> -static bool signed_add32_overflows(s32 a, s32 b)
> -{
> -       /* Do the add in u32, where overflow is well-defined */
> -       s32 res =3D (s32)((u32)a + (u32)b);
> -
> -       if (b < 0)
> -               return res > a;
> -       return res < a;
> -}

Looks good,
unfortunately it gained conflict while sitting in the queue.
signed_add16_overflows() was introduced.
Could you please respin replacing signed_add16_overflows()
with check_add_overflow() ?

pw-bot: cr

