Return-Path: <bpf+bounces-59452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5AFACBC3A
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 22:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D267A1EFB
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 20:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEACE14B965;
	Mon,  2 Jun 2025 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhR8KEs9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344123CE
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748895508; cv=none; b=gjVffcUjE4Da8PWhoXYISLfoLwj+d19AkvNLr3j71bbJfoIElWO1QJEWaAJ9QfklcBGSUOIvXPDe4wdG5M7EsVVx4HTe/q9B2lYmgcaM2lvg2nuF4+TiLyj92mttKTGEqNTDmZMYOHPJGI6PA7HwZeUGmiJMlczEtUHNsAGrWJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748895508; c=relaxed/simple;
	bh=EubSesAjd1/Xq0YAZdQLONg72yN4dtr331lxU3bguic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqhnBY+N8CcawECIueTyT6SlIwAQk/KQLzUbCjSD+HVnDo97sLl38bmDOXPdDsPRxzbY7pszqh9vVxdEkPwhTdnRx6fVPZawoRalHCHwf/M7HTpxECcWRLZnPw/OW7bKSLIOWEgLpmEZdtS6RDjOh12kilkKcdGZRhT844EuEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhR8KEs9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d7b50815so13666105e9.2
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748895505; x=1749500305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRpc1dkvYedWoOrypmb09KsMIoPxxNgSIFOgZzWvTnU=;
        b=RhR8KEs9/eTv+4E42sK9huIb2Ta0uIj2akV6QwQcEOSymZyLhVHJ8NflFAjaSGbP8q
         eDR9femN/KCaMoZ8pm3iJI5ZkNtKQyL7XsPyNl51Ysas3P3BaAXdx2WCm5ZLaSb5porL
         u48pG5jRZrzGyNIDbzokB9vyJoVE7cO+u1U64SXZkCwoUUWhSjfVAQYJTIxD1m6mqfTe
         DE+4bDfWIgdXJxs1LYeKMzbyBuXMekmSPmgxisGG+nRdc5OS4K3qAS7xaSZaLymVHm/d
         YVtf28vziQBsI3mabx/zFOvEngpfuha8xon37IA7Lj9KS39aeTIAUA8PN49biGl25Tfl
         3vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748895505; x=1749500305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRpc1dkvYedWoOrypmb09KsMIoPxxNgSIFOgZzWvTnU=;
        b=ZMZGBGdj9lVMNYxjSPHvaty4GxOu8w8rgHNrp6xcJZC0gCVOdw/9FD6gji+HI2uFzJ
         dcXh4Z5s0qUAUEYev+dnHyRIFX2GMr9yA9gKEdGIzzX9lUxJ4F+oigSmS1xAxmVByvwb
         PWDXizJLYWsxlF4WfC0R2f6TbyNpAY7DgSH2yYRgzDsSvz9EAICJZvIb9taOq5DM45fr
         TS2RB2mWpgtw+DBadsDayXHrnPzhJbIdqQfPKieRTRlwzTtdVoREcweodN2TFVc6pjq2
         C6jRVhmm6vJsVmLOM7PzE9/LmmPKVns5PK73M3cQ37qUx8r8IVJvkT4NQVa+kHecIFUF
         9cFw==
X-Gm-Message-State: AOJu0YxY16gk1KLH/xttIMJSICCWUXrCjpJpJnV634jZaV79LXmRViAW
	nLozApLykQjUPdipYScAHLtluWDzouOo2M895tzdAGhXRadBrClf73SthB50Pg5/S4FH8N01GL2
	oIfI7Xn8PmHbfSbCln/Bi0ZTB4pAgoPQ=
X-Gm-Gg: ASbGncs+kBOEkOg8KAmLetFe5EmGiyNu9EmqSWvZ5FAsMWqzDeVH3gblO/hcRpw1Jc6
	vtyWnFk0RnNABOS2TYEfX2TGrKa16IPG6DBETQUzJNNqhKsetDEdjKIS1E8MUIpDvfhfSj3Dy9W
	V00HK4mYqQ+ZItwSIG2jB2ZWxc+zv/jIUf8u33O0PA2ZttJYglu/Ju6U6r6go=
X-Google-Smtp-Source: AGHT+IEiTfQNyY/SMIUQedAT6RCxJq4eXfRcb3TlUMGAGg5W8VEoCYroUicXGWoKlBk967GIHG6rgWHL/tZDsMyDrtk=
X-Received: by 2002:a05:600c:1c2a:b0:444:c28f:e81a with SMTP id
 5b1f17b1804b1-450d887e0f4mr122788495e9.27.1748895504589; Mon, 02 Jun 2025
 13:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-3-memxor@gmail.com>
In-Reply-To: <20250524011849.681425-3-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Jun 2025 13:18:13 -0700
X-Gm-Features: AX0GCFszcz15aTHuHqIxzyDVO1tAC7ZnY_5TSmAuE2SmB0fqJjeQAjJMMmkGVnI
Message-ID: <CAADnVQ+M20Jn_+hkLuRTJJGZQSVvwZQd0q0RxBV-u7CpTf0Orw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/11] bpf: Add function to extract program
 source info
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 6:18=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Prepare a function for use in future patches that can extract the file
> info, line info, and the source line number for a given BPF program
> provided it's program counter.
>
> Only the basename of the file path is provided, given it can be
> excessively long in some cases.
>
> This will be used in later patches to print source info to the BPF
> stream. The source line number is indicated by the return value, and the
> file and line info are provided through out parameters.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h |  2 ++
>  kernel/bpf/core.c   | 49 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d298746f4dcc..4eb4f06f7219 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3659,4 +3659,6 @@ static inline bool bpf_is_subprog(const struct bpf_=
prog *prog)
>         return prog->aux->func_idx !=3D 0;
>  }
>
> +int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, cons=
t char **filep, const char **linep);
> +
>  #endif /* _LINUX_BPF_H */
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 22c278c008ce..7e7fef095bca 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3204,3 +3204,52 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
>
>  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +
> +int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, cons=
t char **filep, const char **linep)
> +{
> +       int idx =3D -1, insn_start, insn_end, len;
> +       struct bpf_line_info *linfo;
> +       void **jited_linfo;
> +       struct btf *btf;
> +
> +       btf =3D prog->aux->btf;
> +       linfo =3D prog->aux->linfo;
> +       jited_linfo =3D prog->aux->jited_linfo;
> +
> +       if (!btf || !linfo || !prog->aux->jited_linfo)
> +               return -EINVAL;
> +       len =3D prog->aux->func ? prog->aux->func[prog->aux->func_idx]->l=
en : prog->len;
> +
> +       linfo =3D &prog->aux->linfo[prog->aux->linfo_idx];
> +       jited_linfo =3D &prog->aux->jited_linfo[prog->aux->linfo_idx];
> +
> +       insn_start =3D linfo[0].insn_off;
> +       insn_end =3D insn_start + len;
> +
> +       for (int i =3D 0; i < prog->aux->nr_linfo &&
> +            linfo[i].insn_off >=3D insn_start && linfo[i].insn_off < ins=
n_end; i++) {
> +               if (jited_linfo[i] >=3D (void *)ip)
> +                       break;
> +               idx =3D i;
> +       }
> +
> +       if (idx =3D=3D -1)
> +               return -ENOENT;
> +
> +       /* Get base component of the file path. */
> +       *filep =3D btf_name_by_offset(btf, linfo[idx].file_name_off);
> +       if (!*filep)
> +               return -ENOENT;
> +       *filep =3D kbasename(*filep);
> +       /* Obtain the source line, and strip whitespace in prefix. */
> +       *linep =3D btf_name_by_offset(btf, linfo[idx].line_off);
> +       if (!*linep)
> +               return -ENOENT;
> +       while (isspace(**linep))
> +               *linep +=3D 1;

The check_btf_line() in the verifier does:
                if (!btf_name_by_offset(btf, linfo[i].line_off) ||
                    !btf_name_by_offset(btf, linfo[i].file_name_off)) {
                        verbose(env, "Invalid line_info[%u].line_off
or .file_name_off\n", i);
                        err =3D -EINVAL;
                        goto err_free;
                }

and later in the verifier we do:
        s =3D ltrim(btf_name_by_offset(btf, linfo->line_off));
        verbose(env, "%s", s); /* source code line */

so please drop these two checks.

> +       return BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);

I would return it by reference as well.

