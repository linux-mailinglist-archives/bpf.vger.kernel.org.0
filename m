Return-Path: <bpf+bounces-14311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F6D7E2D5E
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 20:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3DD2808FB
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 19:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41AF28DAD;
	Mon,  6 Nov 2023 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR8bg96/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23DB1C29
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 19:56:36 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F819125
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 11:56:35 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5437269a661so11664054a12.0
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 11:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699300594; x=1699905394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmYBCfyEZ0VrZxOZRqTzddN1bPy0Wru/imnn8vt6caM=;
        b=GR8bg96/jb3ZnC1GIxMc+jjiUE9kJYfOcUKiTjmbjbJw2zfnzae438b5Zx24DmdG/h
         VScsacJozMJ4rerhLAmsI+mUyMEd9VS+ADMC2cfK8EPbx3O547L3r1t87MtQrDnia0s0
         FmtZbwFWkLUcxoYLU0WYkv534nGC2znFVesGdI0jZB/Dark0VBQxksCfn+dpDxMfXgf7
         34fzGl260O/xOhALe3NHPC2tSeEmTqrifAeHwQBQuSNSRL7BmmyekyPrayEU1e4tkz+s
         8TayJ1QF70B5QvKGThYxijZI/1CYtjwKngOC7awWa90ejoOSz482IOkCafW2DEpRrgek
         eHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699300594; x=1699905394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmYBCfyEZ0VrZxOZRqTzddN1bPy0Wru/imnn8vt6caM=;
        b=DBsJACSpHoQxAzvphE+Uy7nqU9ua+Dd9XTT+dx50VUwLYYKrzihqK4L1I0tTsIpVu+
         YUJmmyYDUUXJAFs0hfM2Tt/6Fj0CrFOAFFxzePBu1WAB3vD9unamBsAUqu4LypLCLtNP
         bksZGt0ZjesRdU/WRjKHd1/ARagI+BRMGBUxJfmQlyo9UccHDlBhlIj5wgTecK7DDg2C
         4m60mcl+q0GNf6hxqdp8kU4x1zYaSrL4QoMlFE/Gsq6/LeDWSLu+KR6XVme0V/Y0xanJ
         MBYWv3Qo0UVDxR90ywcAhTQ4nyBOQ3Hyc91jheiq75k3torYRdb0KV+QeRQz+d7xDRN/
         SbBA==
X-Gm-Message-State: AOJu0YwrmfNVYkykT5v7drUfYuxpVJWBHhcp8FCV2EtgYR+/ZHmefgJA
	EBzLO0fbzEIRh2xu/6hEBZbQmgKlLQ1aFIZEh1w=
X-Google-Smtp-Source: AGHT+IGteWjmX6hy89DkfNbFtpTTFWXJirzGHzgCPPt4o4jNIuaLiEmbP1L+DlLWpyoQlYw1Krpq4jhHsvTu7ZDs2+8=
X-Received: by 2002:a17:906:74cb:b0:9a9:405b:26d1 with SMTP id
 z11-20020a17090674cb00b009a9405b26d1mr488432ejl.5.1699300593815; Mon, 06 Nov
 2023 11:56:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106021119.10455-1-shung-hsi.yu@suse.com>
In-Reply-To: <20231106021119.10455-1-shung-hsi.yu@suse.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Nov 2023 11:56:22 -0800
Message-ID: <CAEf4BzZABSe-kbFzrO=9umVriJO=PSwCtw3nxt0PdS3Ltq4gmw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf, tnums: add bitwise-not helper
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 6:11=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com>=
 wrote:
>
> Note: Andrii' patch mentioned in the Link tag isn't merge yet, I'll
>       resend this along with the proposed refactoring once it is merged.
>       For now, sending the patch as RFC for feedback and review.
>
> While the BPF instruction set does not contain a bitwise-NOT
> instruction, the verifier may still need to compute the bitwise-NOT
> result for the value tracked in the register. One such case reference in
> the link below is
>
>         u64 val;
>         val =3D reg_const_value(reg2, is_jmp32);
>         tnum_ops(..., tnum_const(~val);
>
> Where the value is extract of out tnum, operated with bitwise-NOT, then
> simply turned back into tnum again; plus it has the limitation of only
> working on constant. This commit adds the tnum_not() helper that compute
> the bitwise-NOT result for all the values tracked within the tnum, that
> allow us to simplify the above code to
>
>         tnum_ops(..., tnum_not(reg2->var_off));
>
> without being limited to constant, and is general enough to be reused
> and composed with other tnum operations.
>
> Link: https://lore.kernel.org/bpf/ZUSwQtfjCsKpbWcL@u94a/
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>
>  include/linux/tnum.h | 2 ++
>  kernel/bpf/tnum.c    | 5 +++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> index 1c3948a1d6ad..817065df1297 100644
> --- a/include/linux/tnum.h
> +++ b/include/linux/tnum.h
> @@ -46,6 +46,8 @@ struct tnum tnum_and(struct tnum a, struct tnum b);
>  struct tnum tnum_or(struct tnum a, struct tnum b);
>  /* Bitwise-XOR, return @a ^ @b */
>  struct tnum tnum_xor(struct tnum a, struct tnum b);
> +/* Bitwise-NOT, return ~@a */
> +struct tnum tnum_not(struct tnum a);
>  /* Multiply two tnums, return @a * @b */
>  struct tnum tnum_mul(struct tnum a, struct tnum b);
>
> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index 3d7127f439a1..b4f4a4beb0c9 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -111,6 +111,11 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
>         return TNUM(v & ~mu, mu);
>  }
>
> +struct tnum tnum_not(struct tnum a)
> +{
> +       return TNUM(~a.value & ~a.mask, a.mask);
> +}
> +

In isolation this does look like it's implementing the tnum version of
~x, so I have no objections to this. But I'm not sure it actually
simplifies anything in my patches. But let's see, once it lands,
please send a follow up applying this tnum_not().


>  /* Generate partial products by multiplying each bit in the multiplier (=
tnum a)
>   * with the multiplicand (tnum b), and add the partial products after
>   * appropriately bit-shifting them. Instead of directly performing tnum =
addition
>
> base-commit: 1a119e269dc69e82217525d92a93e082c4424fc8
> --
> 2.42.0
>

