Return-Path: <bpf+bounces-33581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EDF91EBE2
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7575B1C21956
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520396FCB;
	Tue,  2 Jul 2024 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2+FyrsJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23B23D7
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 00:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719880925; cv=none; b=FC3WPtmPXxTHbl8El29Szropn8RRJzaFaUmjKk2tHKU6Wy7cdpEc1rLfXwVuyikxKP336aMRH6XtoSMcjd7lBUpfDf1LKimmrLL8mLLV/9ZpoZs8qhV8+Q+5U7Hmt0oqOcc7iTrfN9a1mV5trak8VGRQg0AWlkEGm/2a0wkW3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719880925; c=relaxed/simple;
	bh=im/RB6HZXb2me7GarpA/NphujHbtwbVg2nydRoFFC8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+A9E4QdEB2WzLmueP65f2fSqdblhuNjqi2BEw8LwEAzms/ghXv0wCSgLupnl+kuSo2UwEnootIRNxv50Hdpy05efHMEgu6dHTaoF5HdvFR/VsTJkK9AQa82KpFXstdnX9vXQWd5dBvYXClQZ5FUh//rLtyTiGVdjlHCr2oSQEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2+FyrsJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7082dd9bbf8so2502208b3a.1
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 17:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719880924; x=1720485724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc9R6R67PZ5pxsu6IZRwXaiVPld3aPKnDaEPp/aTAOo=;
        b=Z2+FyrsJJuk0xMYFTE8oidk97fmCogTI9Rm1wf2+Uhry8GzZAaURVMz7uRlUTo7W7Z
         9h8BQSmrEAVtc3EAaFseUPPjaY1CHlB4BMzo7DGD+Kraf8Td/sr21zktER/YIoyGf8TU
         dGyDFoFyiF9EZQ7nWaE6rsGkGHHMlh81ezHVI8MjQm4BmEEB7/fppRUlSPsUYPzhgY6w
         Pi7ueoQa1E0jrWq/SYFm7/TDzgAN7h+Ycca5kOWX3054ySqCfd2BngyJSkOXW3No3eLQ
         UHcclWx+cqrSdXIP23RA4dpVkb4u9f5x5tAr4zagDtpkXuwX0tJQtiFvCNcn1sV1vCm1
         L/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719880924; x=1720485724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tc9R6R67PZ5pxsu6IZRwXaiVPld3aPKnDaEPp/aTAOo=;
        b=AfeVIP0Ol7YYvVi4GoxpNvBnIMiDOxGxlC52w9MN2OZ1A4aJVNc71UedXlZQ/XK3uK
         +yroqI6fVHSsCfzGCBhuT81enVkT20HN9PvnX0soUmuwq2rXjD7tJP8axyID70GH0D9c
         C2bD1Te60usuEM55pUJ/n8gCdBrD7dnezs70u20DJFc7t9JRkVP1HP1ukJd5DEqLkjva
         vsXtahFbi2VGUOyFyL6+/qLHLnLoxmDPmik0I7AcjpTig/b8PqcmuJf71WvBxhXaOPqk
         nQalUfKkrhgHuMmn6UiNqzkr+r6Xbmma7MZUlLvc60EjjQakUsR7dAa6eeT7ayAYS/Su
         fuWg==
X-Gm-Message-State: AOJu0Yw7thIYf+4/5mwtwQ4dg0tiBDlbnxLaDBYJZIhE50WncTp46uD6
	uj9dooMBkTTZwLBuK1Y+5TUwh64Bcf8Kvw6O6R+OTlwfqhpg0GkOeXLfSVDsqwryUBHrifmArY0
	Ozvye7H+b4oRYs5ppBH9209eZPF0=
X-Google-Smtp-Source: AGHT+IH/bYvEI8rCjpVYGGo2h0JLrBi+MbpFTAcEU26X+lTH1sWT4ccIA09RggHedy9rbbYR4afohiFxeONKW9JNkWk=
X-Received: by 2002:a05:6a00:807:b0:708:2b90:eaed with SMTP id
 d2e1a72fcca58-70aaad2a1camr6074164b3a.6.1719880923590; Mon, 01 Jul 2024
 17:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com> <20240629094733.3863850-5-eddyz87@gmail.com>
In-Reply-To: <20240629094733.3863850-5-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 17:41:49 -0700
Message-ID: <CAEf4BzY_6iBHx5Hu1ick8qHb-kOaKpyG0vEqAcc1D7RKdbZs_Q@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 4/8] selftests/bpf: extract utility function for
 BPF disassembly
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 2:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> uint32_t disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz);

or you can return `struct bpf_insn *` which will point to the next
hypothetical instruction?

>
>   Disassembles instruction 'insn' to a text buffer 'buf'.
>   Removes insn->code hex prefix added by kernel disassemly routine.
>   Returns the length of decoded instruction (either 1 or 2).
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |  1 +
>  tools/testing/selftests/bpf/disasm_helpers.c  | 50 +++++++++++++
>  tools/testing/selftests/bpf/disasm_helpers.h  | 12 ++++
>  .../selftests/bpf/prog_tests/ctx_rewrite.c    | 71 +++----------------
>  tools/testing/selftests/bpf/testing_helpers.c |  1 +
>  5 files changed, 72 insertions(+), 63 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/disasm_helpers.c
>  create mode 100644 tools/testing/selftests/bpf/disasm_helpers.h
>

[...]

> +uint32_t disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz)
> +{
> +       struct print_insn_context ctx =3D {
> +               .buf =3D buf,
> +               .sz =3D buf_sz,
> +       };
> +       struct bpf_insn_cbs cbs =3D {
> +               .cb_print       =3D print_insn_cb,
> +               .private_data   =3D &ctx,
> +       };
> +       int pfx_end, sfx_start, len;
> +       bool double_insn;
> +
> +       print_bpf_insn(&cbs, insn, true);
> +       /* We share code with kernel BPF disassembler, it adds '(FF) ' pr=
efix
> +        * for each instruction (FF stands for instruction `code` byte).
> +        * Remove the prefix inplace, and also simplify call instructions=
.
> +        * E.g.: "(85) call foo#10" -> "call foo".
> +        */
> +       pfx_end =3D 0;
> +       sfx_start =3D max((int)strlen(buf) - 1, 0);
> +       /* For whatever reason %n is not counted in sscanf return value *=
/
> +       sscanf(buf, "(%*[^)]) %n", &pfx_end);

let me simplify this a bit ;)

pfx_end =3D 5;

not as sophisticated, but equivalent

> +       sscanf(buf, "(%*[^)]) call %*[^#]%n", &sfx_start);

is it documented that sfx_start won't be updated if sscanf() doesn't
successfully match?

if not, maybe let's do something like below

if (strcmp(buf + 5, "call ", 5) =3D=3D 0 && (tmp =3D strrchr(buf, '#')))
    sfx_start =3D tmp - buf;

> +       len =3D sfx_start - pfx_end;
> +       memmove(buf, buf + pfx_end, len);
> +       buf[len] =3D 0;
> +       double_insn =3D insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
> +       return double_insn ? 2 : 1;
> +}

[...]


> @@ -739,12 +685,11 @@ static void match_program(struct btf *btf,
>                 PRINT_FAIL("Can't open memory stream\n");
>                 goto out;
>         }
> -       if (skip_first_insn)
> -               print_xlated(prog_out, buf + 1, cnt - 1);
> -       else
> -               print_xlated(prog_out, buf, cnt);
> +       for (i =3D skip_first_insn ? 1 : 0; i < cnt;) {
> +               i +=3D disasm_insn(buf + i, insn_buf, sizeof(insn_buf));
> +               fprintf(prog_out, "%s\n", insn_buf);
> +       }
>         fclose(prog_out);
> -       remove_insn_prefix(text, MAX_PROG_TEXT_SZ);
>
>         ASSERT_TRUE(match_pattern(btf, pattern, text, reg_map),
>                     pinfo->prog_kind);
> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testin=
g/selftests/bpf/testing_helpers.c
> index d5379a0e6da8..ac7c66f4fc7b 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -7,6 +7,7 @@
>  #include <errno.h>
>  #include <bpf/bpf.h>
>  #include <bpf/libbpf.h>
> +#include "disasm.h"
>  #include "test_progs.h"
>  #include "testing_helpers.h"
>  #include <linux/membarrier.h>
> --
> 2.45.2
>

