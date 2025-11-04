Return-Path: <bpf+bounces-73415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E006C2EEB9
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 03:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29583B8B68
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 02:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D7B23ABBB;
	Tue,  4 Nov 2025 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNbTOBBi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730E23A99E
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222230; cv=none; b=K5MCIjax5xDVij00Gk0f4eL6W1feV77uqPD333JK+zGg3uvxBWSs3Y0irBT1qw8eTX92LGNlCPlCMWA/HV6PDd7FOT6NysQCB+zVVZRDFoVT+bZ5OKSLKAR/rR1ObDqXrxZTetISzo0JMDIutzZg/VNaxDWOzBkpL/hfVMgt5Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222230; c=relaxed/simple;
	bh=q5b/ERY8WcRSW62mtXJw9Z3uCYM5pto4RKB9F3TfGcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpPrz0PS1PYpX+adTmhkiSlslombh3l3e7RIOc2+PttXq03tfnIB5vBxy4ctvbjA+1nQVIVRCoJLc9/9GH18lnO/VYar/mOxqyzYyW98h9Az0wrT3N+pOAPc5z4jL8ybQTK+cDKkfd5uKEAeDTJ5kvGWsASXfVHdq3yveXcj7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNbTOBBi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso8204319a12.2
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 18:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762222226; x=1762827026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxAEnXLnIH5T/l/63N8XnKruBaX0pRhdnvrXbaKTETU=;
        b=FNbTOBBik7NuSWn1i/74YIYXt7eiN0VjNl/V57wtI8idTuVDelVvxSFLSupv7DVi+b
         De3j8EcBYMRN4vhsCDPHgIUXc+Pa1yUjBvQTUzC0MbdGk5DgW5vgX9cDfBybIpXZcUjM
         RQp5d6t2jVLjTkqqnAcVkJtK55G+j//q1jEIzv6i0IYovcZQtsTEs7G06ZBZQDt3p3Nq
         UdkpoB5ngWwGx1wCS2Np0LQ9upZsTSKn7ipNK8TYft37mJ/1e9yziMYObFh8rCtJWSlu
         SwSJzJYQ2vW8aP8IEJJhFaD3NfLgNmTCFwPG67thmCEfNYygz01+Ur4/4DC3QohDBUEK
         AQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762222226; x=1762827026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxAEnXLnIH5T/l/63N8XnKruBaX0pRhdnvrXbaKTETU=;
        b=IlVN5GWC8S1jcW2cNJ2WVdGpa461lDyqhfkTrwSJ8bQOwr0Tg7EEhPd50YdNUpec5t
         dJBVRFTILt3rvcStiGhanjwvzZU7CfkV84QO6/h1hnmsQm6u6tFD3OXMyTkw88ELj6BE
         7Itt/melvD3RTypzHyzAlgRks5ZwonsPQe7XQ0FkYVc42xcMQe9kRlEtPDe5XV8yS0vP
         Wo8NFbi+fn4MD78fTJDYByIssbIkiOD3ZYdUWmC4MZW23tO5zFhlBf1BinEQuqACm19y
         /TjLBLfXBDh7AWSi97eeuk9iMe+G6bp+IMEuhepK7WGcnu6EzKqRt3mvoTsl3GvaNs07
         3FPg==
X-Gm-Message-State: AOJu0Yx7SlVKWKpb0tDQm9DSnRpb2mEdgMV6Chwp4f3jXw7jQOurDclZ
	JgnKQ1dgiLiiWG0HtPT6nc+kw8sjPwpp0HLnyFtfGwm0tmMNj/GJXx2g37VhdOUo3lQK4tHrbwb
	FAMy+ksLW1zsR2xTxtpTppRJiM3KXSdU=
X-Gm-Gg: ASbGncsCK6PZY83KBwtt9kQCC3I/tsCzmnJux4Vzj6bwx0vLFelm3qHiABKDdN7ecZq
	2RyA8TOTx5yspp6eJvBzpIwoVwt6tqM0Q/8Z87SnXAF1hjruhxr5oHnFsYlzykZYLdhapkqCv5a
	UV4i+ZcJnKUOwooHOmwcv9cKk9yxJUfdKKcI40QIiC/7cEZ5fguQh7PF0go/wq66Cjh1XPo+h/f
	ItfLTbzaadGx1XLKznwSsgcORWn7F0OEkVjnjcKZx8mlTkk59oNV/vmTj4mICOc0z/Mo7rgMaek
	rAXcGAZpco6grRg568MCiczKgNgi
X-Google-Smtp-Source: AGHT+IFw/9ZCKsC9QN+IMr8oeYOYPSk59ZwxKcFBIwVN3Pb71NiUz/M+Lfb+FY7ykMKo8ybprMD3HuyrZGEWTxtd/ig=
X-Received: by 2002:a17:906:fd87:b0:b6d:6a35:9996 with SMTP id
 a640c23a62f3a-b707085cb9dmr1640527166b.58.1762222226520; Mon, 03 Nov 2025
 18:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com> <20251102205722.3266908-3-a.s.protopopov@gmail.com>
In-Reply-To: <20251102205722.3266908-3-a.s.protopopov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 3 Nov 2025 18:10:15 -0800
X-Gm-Features: AWmQ_bkf27khPWAFgd1wnBGnceGrIQXUVCWs9ULdMk6_dyRpJJS7kM2pMZBmekY
Message-ID: <CAADnVQ+soo36eMJxcnLhbU+jTz053vd7NU-Dm46U+EJnWAzuTA@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 02/11] selftests/bpf: add selftests for new
 insn_array map
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 12:52=E2=80=AFPM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> Add the following selftests for new insn_array map:
>
>   * Incorrect instruction indexes are rejected
>   * Two programs can't use the same map
>   * BPF progs can't operate the map
>   * no changes to code =3D> map is the same
>   * expected changes when instructions are added
>   * expected changes when instructions are deleted
>   * expected changes when multiple functions are present
>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_insn_array.c | 409 ++++++++++++++++++
>  1 file changed, 409 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_array=
.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/to=
ols/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> new file mode 100644
> index 000000000000..96ee9c9984f1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> @@ -0,0 +1,409 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <bpf/bpf.h>
> +#include <test_progs.h>
> +
> +#ifdef __x86_64__
> +static int map_create(__u32 map_type, __u32 max_entries)
> +{
> +       const char *map_name =3D "insn_array";
> +       __u32 key_size =3D 4;
> +       __u32 value_size =3D sizeof(struct bpf_insn_array_value);
> +
> +       return bpf_map_create(map_type, map_name, key_size, value_size, m=
ax_entries, NULL);
> +}
> +
> +static int prog_load(struct bpf_insn *insns, __u32 insn_cnt, int *fd_arr=
ay, __u32 fd_array_cnt)
> +{
> +       LIBBPF_OPTS(bpf_prog_load_opts, opts);
> +
> +       opts.fd_array =3D fd_array;
> +       opts.fd_array_cnt =3D fd_array_cnt;
> +
> +       return bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_=
cnt, &opts);
> +}
> +
> +static void __check_success(struct bpf_insn *insns, __u32 insn_cnt, __u3=
2 *map_in, __u32 *map_out)
> +{
> +       struct bpf_insn_array_value val =3D {};
> +       int prog_fd =3D -1, map_fd, i;
> +
> +       map_fd =3D map_create(BPF_MAP_TYPE_INSN_ARRAY, insn_cnt);
> +       if (!ASSERT_GE(map_fd, 0, "map_create"))
> +               return;
> +
> +       for (i =3D 0; i < insn_cnt; i++) {
> +               val.orig_off =3D map_in[i];
> +               if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), =
0, "bpf_map_update_elem"))
> +                       goto cleanup;
> +       }
> +
> +       if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> +               goto cleanup;
> +
> +       prog_fd =3D prog_load(insns, insn_cnt, &map_fd, 1);
> +       if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> +               goto cleanup;
> +
> +       for (i =3D 0; i < insn_cnt; i++) {
> +               char buf[64];
> +
> +               if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, =
"bpf_map_lookup_elem"))
> +                       goto cleanup;
> +
> +               snprintf(buf, sizeof(buf), "val.xlated_off should be equa=
l map_out[%d]", i);
> +               ASSERT_EQ(val.xlated_off, map_out[i], buf);
> +       }
> +
> +cleanup:
> +       close(prog_fd);
> +       close(map_fd);
> +}
> +
> +/*
> + * Load a program, which will not be anyhow mangled by the verifier.  Ad=
d an
> + * insn_array map pointing to every instruction. Check that it hasn't ch=
anged
> + * after the program load.
> + */
> +static void check_one_to_one_mapping(void)
> +{
> +       struct bpf_insn insns[] =3D {
> +               BPF_MOV64_IMM(BPF_REG_0, 4),
> +               BPF_MOV64_IMM(BPF_REG_0, 3),
> +               BPF_MOV64_IMM(BPF_REG_0, 2),
> +               BPF_MOV64_IMM(BPF_REG_0, 1),
> +               BPF_MOV64_IMM(BPF_REG_0, 0),
> +               BPF_EXIT_INSN(),
> +       };
> +       __u32 map_in[] =3D {0, 1, 2, 3, 4, 5};
> +       __u32 map_out[] =3D {0, 1, 2, 3, 4, 5};
> +
> +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> +}
> +
> +/*
> + * Load a program with two patches (get jiffies, for simplicity). Add an
> + * insn_array map pointing to every instruction. Check how it was change=
d
> + * after the program load.
> + */
> +static void check_simple(void)
> +{
> +       struct bpf_insn insns[] =3D {
> +               BPF_MOV64_IMM(BPF_REG_0, 2),
> +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffie=
s64),
> +               BPF_MOV64_IMM(BPF_REG_0, 1),
> +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffie=
s64),
> +               BPF_MOV64_IMM(BPF_REG_0, 0),
> +               BPF_EXIT_INSN(),
> +       };
> +       __u32 map_in[] =3D {0, 1, 2, 3, 4, 5};
> +       __u32 map_out[] =3D {0, 1, 4, 5, 8, 9};
> +
> +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> +}
> +
> +/*
> + * Verifier can delete code in two cases: nops & dead code. From insn
> + * array's point of view, the two cases are the same, so test using
> + * the simplest method: by loading some nops
> + */
> +static void check_deletions(void)
> +{
> +       struct bpf_insn insns[] =3D {
> +               BPF_MOV64_IMM(BPF_REG_0, 2),
> +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> +               BPF_MOV64_IMM(BPF_REG_0, 1),
> +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> +               BPF_MOV64_IMM(BPF_REG_0, 0),
> +               BPF_EXIT_INSN(),
> +       };
> +       __u32 map_in[] =3D {0, 1, 2, 3, 4, 5};
> +       __u32 map_out[] =3D {0, -1, 1, -1, 2, 3};
> +
> +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> +}
> +
> +/*
> + * Same test as check_deletions, but also add code which adds instructio=
ns
> + */
> +static void check_deletions_with_functions(void)
> +{
> +       struct bpf_insn insns[] =3D {
> +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffie=
s64),
> +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
> +               BPF_MOV64_IMM(BPF_REG_0, 1),
> +               BPF_EXIT_INSN(),
> +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffie=
s64),
> +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> +               BPF_MOV64_IMM(BPF_REG_0, 2),
> +               BPF_EXIT_INSN(),
> +       };
> +       __u32 map_in[] =3D  { 0, 1,  2, 3, 4, 5, /* func */  6, 7,  8, 9,=
 10};
> +       __u32 map_out[] =3D {-1, 0, -1, 3, 4, 5, /* func */ -1, 6, -1, 9,=
 10};
> +
> +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> +}

I was thinking of taking the first 5 patches, but this one fails:
./test_progs -t bpf_insn_array
...
#19/4    bpf_insn_array/deletions-with-functions:FAIL
#19/5    bpf_insn_array/blindness:OK
#19/6    bpf_insn_array/incorrect-index:OK
#19/7    bpf_insn_array/load-unfrozen-map:OK
#19/8    bpf_insn_array/no-map-reuse:OK
#19/9    bpf_insn_array/bpf-side-ops:OK
#19      bpf_insn_array:FAIL

I don't see what you're changing later in the patches
to make it pass, but the failure highlights the issue with
bisectability. Pls take a look.

This one also fails:
#170/3   libbpf_str/bpf_map_type_str:FAIL
#170     libbpf_str:FAIL

I was thinking of hacking it as an extra patch
(without full support in patch 8), but gave up when I saw
deletions-with-functions failing.

Maybe also split the main libbpf patch into prep patch
with basic introduction of insn_array ?
Or keep it as-is, if respin comes soon.

deletions-with-functions is the most suspicious.

