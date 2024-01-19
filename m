Return-Path: <bpf+bounces-19910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEC7833028
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA111C213FD
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 21:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE2F5789A;
	Fri, 19 Jan 2024 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5C8E8IM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235A7EF;
	Fri, 19 Jan 2024 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699122; cv=none; b=b/wdSOn7eHR1GEa/72dC6yeLCrRhSoiv9A/wOHNgydFWVRCpsBAd4/5F1AmpBoTXbNZmw33keWQ/s0W2A/i6t9wunlnJ41b7ZdUyZ9LSUob4gPf1p8GiNS5h7y1zGz5nbF5cPtTysY5mwGsWf/lI+RxwkkaC9agY6bRQ7jefyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699122; c=relaxed/simple;
	bh=SFFHPi5z+u3PxypmWvWvji2LjF5Tr3zXIeHvEmMeNq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyaTXlnKHajPpCG6gamgglWSmeGmCUrnUttdRmRjZf3V9889BvJfj4qadwGya5vFtJhWMaAjNOdUhBICHOan3Ds56xJqzk4w/2r7UqyDYI0Y+j8d2m/gQfPs/xdSm07aAApy8T66RBvuM+HhP5QSWSJMBgpzwMhwELlzl2N34Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5C8E8IM; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdfed46372so1144770a12.3;
        Fri, 19 Jan 2024 13:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705699120; x=1706303920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14fwaY4V0ADmkEmiNtkEZzCmvPzMkUSdeyzXlcYH+mE=;
        b=i5C8E8IMtap+ED4rU51ng3Rzwe3ETKRP5BeJey9Yk/cdhTrgnUq7fbicyCTzcpaRLP
         XCw6MZDSWGLJNVHH8dFAnJ1vXE9CQcPdhE7jxxU82Yy/8RZRTfyKi5zReO3Dm+yFjW8g
         6cSNAm1uT531YN66ICo6QN7SIaaua0p0mdcfg5yPHvl9mV5hfZ3Tgv5RBG/ptfNINEQN
         PXqeU7ZpfLdXHGTGOaD30nsdcdkxnGuAJ+hpPJnhWgfeQYk0V1DjE2UpdvhgnLLf6FGG
         +Nhnov9URg2VgpObuOdD7bLb7ci7I9pnj9EAViC5hgNDqFUFht2r3IUCaG2217tcIZxS
         Uh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705699120; x=1706303920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14fwaY4V0ADmkEmiNtkEZzCmvPzMkUSdeyzXlcYH+mE=;
        b=J5sbBFoQ0QJgGd7dhOlEjk2dVsdv1Fd51mI0JCTufA7pzMM8mlIZMbnfRCZWhLZTOU
         l9CtDRO76OP6c+X3WKUYEMZnfWFUfIhZBBE0ohuANfvDA1Qzx6UtzRRe4w0c457Were+
         hw291FWbO6/ofU7PkmrKvoTO4jvosTMUrxwgVo93YYDPOTx6GsPH0hRWh7cS+mnsVgYa
         ChlOWp2KQ3MakFE6LATERDVsfL2uROcZBnk+UW2hbwLoV86sAbtLn1cHJQy1wAk+14bC
         PPyWf2kQeJ2wRuxztSu8wJ+oF5W9hIJZzuIL/ZHjN2rRiEigQn6+uAgGnHTHVp/BFW4e
         M47A==
X-Gm-Message-State: AOJu0YyhJ3GSLJyRUlP7d+lHSGFFcQpGokqackTMfG71w7B7JEc4OIlZ
	xET+w4QzEkpxwpFLPU8u53SLi2rTrR4BHojM4tVB8ZEz7nQMa8cZW310Hx3THXUWNvK+jJBmC6o
	E7HWrK8KmBEcv7fpvDym9XrU4TQ6+sbz7
X-Google-Smtp-Source: AGHT+IE50YTrcJZjLwByxEZiiPtjKgx49jYojao0VcEmi4j52e4ZJhBwVEmXWxDLKj9YZugMKku5LFPY/Kj6sGJhg0U=
X-Received: by 2002:a05:6a21:150d:b0:199:e4ab:691c with SMTP id
 nq13-20020a056a21150d00b00199e4ab691cmr594311pzb.8.1705699119687; Fri, 19 Jan
 2024 13:18:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117111000.12763-1-yangtiezhu@loongson.cn> <20240117111000.12763-3-yangtiezhu@loongson.cn>
In-Reply-To: <20240117111000.12763-3-yangtiezhu@loongson.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jan 2024 13:18:27 -0800
Message-ID: <CAEf4BzYXayB91cXKktBXe_SMDLXhjNo3DGML6DuakLOysZ5jbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/3] libbpf: Move insn_is_pseudo_func() to libbpf_internal.h
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Hou Tao <houtao@huaweicloud.com>, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 3:10=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Currently, insn_is_pseudo_func() is only used in libbpf.c, move it
> to libbpf_internal.h so that it can be used in test_verifier, this
> is preparation for later patch.
>
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/lib/bpf/libbpf.c          | 5 -----
>  tools/lib/bpf/libbpf_internal.h | 5 +++++
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c5a42ac309fd..259d585d6ff5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -748,11 +748,6 @@ static bool is_call_insn(const struct bpf_insn *insn=
)
>         return insn->code =3D=3D (BPF_JMP | BPF_CALL);
>  }
>
> -static bool insn_is_pseudo_func(struct bpf_insn *insn)
> -{
> -       return is_ldimm64_insn(insn) && insn->src_reg =3D=3D BPF_PSEUDO_F=
UNC;
> -}
> -
>  static int
>  bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
>                       const char *name, size_t sec_idx, const char *sec_n=
ame,
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 27e4e320e1a6..a9c337345aff 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -532,6 +532,11 @@ static inline bool is_ldimm64_insn(struct bpf_insn *=
insn)
>         return insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
>  }
>
> +static inline bool insn_is_pseudo_func(struct bpf_insn *insn)
> +{
> +       return is_ldimm64_insn(insn) && insn->src_reg =3D=3D BPF_PSEUDO_F=
UNC;
> +}
> +

This just adds more internal code of libbpf used by selftests. While
we've allowed it in some cases to avoid duplication of more complex
logic, I don't feel like it's justified in this case. These helpers
are trivial enough to copy/paste somewhere into selftests helpers
header, so please do that instead.

>  /* if fd is stdin, stdout, or stderr, dup to a fd greater than 2
>   * Takes ownership of the fd passed in, and closes it if calling
>   * fcntl(fd, F_DUPFD_CLOEXEC, 3).
> --
> 2.42.0
>

