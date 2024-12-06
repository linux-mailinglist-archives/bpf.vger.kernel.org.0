Return-Path: <bpf+bounces-46232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FCF9E63EB
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 03:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D5216A39B
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 02:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C9213B79F;
	Fri,  6 Dec 2024 02:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+vf3j25"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3214A635;
	Fri,  6 Dec 2024 02:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451251; cv=none; b=uBg7ug9Y+qP3C/8i7S+7UNihrIacNpAaMcZp4/u6letYvsDAvuyvhywxvcZDAV4YQsApHuY34dAyJHIFITH/mO+pPOiz3pu1GD0eXLaReVTnP7HTbA4uk1hrh4nUz6N85+Z6+mTfW6H/r3iDAL+bgYLZydnZ5Vz13b0JemoFZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451251; c=relaxed/simple;
	bh=PmaAJnwsgVguSTDMSQlRJ0Of93LX9r891BFyAkXKTCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMmFntNskwx5sykH6VQSllYGDeQJunqeo2/hlv0yc3azPoke5fMZIKe9v6SIATIQ2qZB2loSKsT414WvPthojRZ0R7QB1LL0c0+lPt8O85esu2SboNS/0Av457RrMZ0Uo6iCxwYk2y3zya9NT2oNNcsf2F7fBcJUYY3TqLzaATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+vf3j25; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so16125145e9.1;
        Thu, 05 Dec 2024 18:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733451248; x=1734056048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmoGVefPaCohRxbkNS8HIVZcAmk0JM77MXc31N8oagg=;
        b=Q+vf3j25PPNOc2hHriCD1IFqaRRL+JDrJWRu0MrxlJm5cEGMzIfY8BBwOgb1RVvGEJ
         TEAJD5nAffHz7iQiEpocsVyk9egGyjSdwIJJMZfbV/18SaqgVB6QKoTsj6ZbzRft2dP/
         w5NvdpS2S8HRKa/kIYs5wOFiPbTP0pC+jz8uT/+/l9IwipxUvWaNesabcJXBiXC5hRHH
         ZOIs8g/OX0e062xK/s7SqGgweN5+0effM67PtQawe6TxoHnpLrXAhckAbmZ+44J1Hj42
         ExaP00u4UrX5Jka2/KPYAMn0Uamd74lwW+wNeoJJ2FjstQtgQX12HmBikKpo2JIFMSn/
         qbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733451248; x=1734056048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmoGVefPaCohRxbkNS8HIVZcAmk0JM77MXc31N8oagg=;
        b=qndebckCr53gqHNvqDn+0YtSxj4bXb/eh2APIjv99a8zf/MXfKudbApysbzkmaerAI
         e5SYiOUYPVezKSQNSPHSs6DIvaXfQMkm2Ej/dWymYbcZLtkLDG8wpWkx81fOlmMBhngR
         pIpVaEjRm/W/4uo/5rkXayH9Ban8lZJTMtPY680q+wzLdhpjGl/76ufR4ol1iOeAsmOM
         c38USAp9f7MVNK+F1fNycKM+T+ExKbufwKpG+9Nk9Ip9wXkKTBNrGMEJAdzRt6BkXl80
         FxCerwRORYIv2jfD5/c9lNLSnp+rwo+jFJy90E3JJzt3raEVVEXX64cDGxP2dm02rY5M
         ADfA==
X-Forwarded-Encrypted: i=1; AJvYcCUOnXfl8Sg3qygIaypzkmzLb19ROKs7RDCpp340v2+kyqHIrNiVuys2vEnmFKxP4xyV1ktu2kdXETFgVnDh@vger.kernel.org, AJvYcCUisnDcdqwOqgbRYHBndxJvDSCzyvZ+Y8h0YC9/91o4P4RpsXopuMSHw64o6FxFXDPLU2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy48EtocUYbUaaJSqqcBur9s2SJrkmtlCl3uTljyld10/1f1gus
	2uGIa6VYuYzIwu3BTxzBdEW6exx4xCo0Lxo5UhOeE4BjOdkAouyCu2oj4K0Bp0Ns4LmDjInRab1
	STE4sDiBEaz6rFxu+eGc2ydNP1dw=
X-Gm-Gg: ASbGncv/zzsvAPnxxk3c3Ol4xBu1qlLqwwV1Kwo+ZVoV0sKY4p5fbH6knIwNuKpHluN
	TykwUmGiCBUR6GpeSz0sj7cSPD4Q2844uZ3bUCdd0Xpuz/l4=
X-Google-Smtp-Source: AGHT+IFwAEMnn4rd04aD5634MCqysZ4oFc15CGUREQRxrX+wtknCRdJO2kj1w/76ep1E1P6yObkFf3PTlGIL2CLsDYY=
X-Received: by 2002:a05:6000:1f85:b0:386:1ab3:11f0 with SMTP id
 ffacd0b85a97d-3862a92dad3mr1049546f8f.28.1733451248083; Thu, 05 Dec 2024
 18:14:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733449395.git.rongtao@cestc.cn> <tencent_B497E42A7CAF94A35B88EB060E42A2593408@qq.com>
In-Reply-To: <tencent_B497E42A7CAF94A35B88EB060E42A2593408@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Dec 2024 18:13:56 -0800
Message-ID: <CAADnVQKRSjV61=Yza_K0Mvyv1kK_hU-+4PhPzzR5dBDg=VDGrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpftool: Fix gen object segfault
To: Rong Tao <rtoax@foxmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, rongtao@cestc.cn, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, 
	"open list:BPF [TOOLING] (bpftool)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 6:01=E2=80=AFPM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> If the input file and output file are the same, the input file is cleared
> due to opening, resulting in a NULL pointer access by libbpf.
>
>     $ bpftool gen object prog.o prog.o
>     libbpf: failed to get ELF header for prog.o: invalid `Elf' handle
>     Segmentation fault
>
>     (gdb) bt
>     #0  0x0000000000450285 in linker_append_elf_syms (linker=3D0x4feda0, =
obj=3D0x7fffffffe100) at linker.c:1296
>     #1  bpf_linker__add_file (linker=3D0x4feda0, filename=3D<optimized ou=
t>, opts=3D<optimized out>) at linker.c:453
>     #2  0x000000000040c235 in do_object ()
>     #3  0x00000000004021d7 in main ()
>     (gdb) frame 0
>     #0  0x0000000000450285 in linker_append_elf_syms (linker=3D0x4feda0, =
obj=3D0x7fffffffe100) at linker.c:1296
>     1296                Elf64_Sym *sym =3D symtab->data->d_buf;
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/bpf/bpftool/gen.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 5a4d3240689e..e5e3e8705cc7 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1879,6 +1879,8 @@ static int do_object(int argc, char **argv)
>         struct bpf_linker *linker;
>         const char *output_file, *file;
>         int err =3D 0;
> +       int argc_cpy;
> +       char **argv_cpy;
>
>         if (!REQ_ARGS(2)) {
>                 usage();
> @@ -1887,6 +1889,17 @@ static int do_object(int argc, char **argv)
>
>         output_file =3D GET_ARG();
>
> +       argc_cpy =3D argc;
> +       argv_cpy =3D argv;
> +
> +       /* Ensure we don't overwrite any input file */
> +       while (argc_cpy--) {
> +               if (!strcmp(output_file, *argv_cpy++)) {
> +                       p_err("Input and output files cannot be the same"=
);
> +                       goto out;

This is completely broken. Just because the names are different
doesn't mean that they don't point to the same file.

Fix the root cause of segfault instead.

pw-bot: cr

