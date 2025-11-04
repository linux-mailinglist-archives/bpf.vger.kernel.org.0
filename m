Return-Path: <bpf+bounces-73460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74F6C32221
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 17:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB28E42114E
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C700233506D;
	Tue,  4 Nov 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb8h+u/2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112D280023
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274957; cv=none; b=UwuCRPlhetlgy3svta053ouDteT3Ak9gtsKpPIf17muwHfQbzN4rIzAJu28kNG3GM3G+Aj4xwiSnFOzQnZmYu9pv+/4M58DgXK3qqohQpc/0ywr+QGp42u9z1WtlpRcdbv3Fl/iLYovVNl/G0Ir0IZbrDthYZmE7PPq6KnWV/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274957; c=relaxed/simple;
	bh=AgcpgTBE+L92fcxiCascc0g0cNfvY1b3U1TfhB56VU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqlJcxLCVwqK5QT34ePe0oEQx/JHE3hHm+/lEgiQKyYs3P++qnuQg13r4QQ0ylCt1w9uhs7sXfHiLsrC1six2VlXW7xVu3yBek3GahpdUhf23un0h9svRGJ5pHqGFy2HESabmXWZc+wG1XE/AMClLOG5iwD0OxilbEtk7gST7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lb8h+u/2; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-421851bca51so4914274f8f.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 08:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762274954; x=1762879754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFIqzDO+KqUXlLPJJwscs0UKASNinQ0oWd9RNothXaA=;
        b=Lb8h+u/2jV5Nx8eZXAThAtkNmMuNtSkzgMTuwdJHu0CdePxMT4zsJ9sBmS2ex2RJ9+
         3F75vTLV4lANBED3k2llaTagSiDqML6kIaBp7YtINTo5VrSiCcEss3sx/Z/52P8TqXOF
         dkiVoYVbYF79e9kQymON756xVtGEwPIKFOE3dON+QTAvxYo2dSAt9L08eVU+zBJLfdx8
         Nef1pt6cq8UFzc0my7sh6GcAtoPvrkKJzNFSxJUSZTEGpgq2cNOxy2zR+1nnMFI6e/XR
         /dz4oTKxN/NOycgRKdh4HfDkGjceU1lrymePG8RhfDp2Ny5uXxVeDK0gZHeHxgHZmutJ
         efNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274954; x=1762879754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFIqzDO+KqUXlLPJJwscs0UKASNinQ0oWd9RNothXaA=;
        b=jNlaGy8NAWLghYeQbHQMhZ9RegQpfAfgSgYRhVKXLt24oon3TPGbjTuuceNaoV+Gbb
         7REjxy+SWrt4oNha/t2Q2WhhZ4ad6UiPeFpAmFd5xlckqSG6mDPQd2Yy4DaNEBASQ+W4
         thYcSg+qmlvAttf9udbg3eUvv4mh5Xb8sVhiPVtMug/0wBpFXiyym1VC+qfFeGR+5Irv
         CfFfSr8LNMMXNbjJ9ZFyQMvuao46HH3QxcjPfZjAgr5hMOrRm7VDezRmDRSK8vKWs1Ko
         12h2b1eFWv6I8ANfD5MQXArC2VH1qc+ULWqTkVWI/ko8JiUUNHus4t/sZW0UDABdTc1b
         XTvA==
X-Gm-Message-State: AOJu0YzI1DCZ8yoQ9IMk8sXtTlsbfXZ67uIK9/wg+COFDEJNswcMFRst
	HoDvS3TQPV71DDsA9xzGYOfpm9T8OdgMhUjICboqBJbjZPLkm/UnPzOP+izkqqaQqEXl6hwgZCc
	Df6ga1yYbb0axDAi8FrSJoTMpHp0pAD8=
X-Gm-Gg: ASbGncvkrlw8Pros8OoWgy/ObtD+/b2YKVCrA0LgLm4nKxXIAccT1d9qCzYGpvqh25i
	1w8Sk92o5N0KaQGR2UrGEYmdU6cpcdDDuLNQz0JL66bEvB1Uyh3nT9BI5yscpldPvvtgE8lpUp5
	pqdqxj6ubOBsV8fWqpeBtx19gRz69HL7yvMAdaYm5fz6jN4JZDFmQ+oDhqHeThdLh8NilXSGAtR
	P6gavHmiXvBf21w9KIt8CzXI9zg+Aswhj/Zg96JOb3CQhk9JIUmXRv+bEmmeLGiG3klUUioqqPd
X-Google-Smtp-Source: AGHT+IHNZxzUJPaDTdPgOXBqR8Uub3X+d65ZYrwSsiJRkufmwzof6GdrGn0a1JZU7j4YLLFX/NC8f/dye8HP3YL69Sk=
X-Received: by 2002:a5d:6f07:0:b0:429:c774:dbfd with SMTP id
 ffacd0b85a97d-429c774dc94mr12991292f8f.12.1762274953406; Tue, 04 Nov 2025
 08:49:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
 <20251102205722.3266908-3-a.s.protopopov@gmail.com> <CAADnVQ+soo36eMJxcnLhbU+jTz053vd7NU-Dm46U+EJnWAzuTA@mail.gmail.com>
 <aQoFFPSIDLW0YDK1@mail.gmail.com>
In-Reply-To: <aQoFFPSIDLW0YDK1@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Nov 2025 08:49:01 -0800
X-Gm-Features: AWmQ_bnldQAsUEXE1bd4nHNr1dxTlTFSG6ykrusURT4IgTLEw6GYEDEOg9iVU-U
Message-ID: <CAADnVQLvAFt3VUo0vfp8cx-xd7dY0Mx08R5-ezmw3p6e7WnxFA@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 02/11] selftests/bpf: add selftests for new
 insn_array map
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:46=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 25/11/03 06:10PM, Alexei Starovoitov wrote:
> > On Sun, Nov 2, 2025 at 12:52=E2=80=AFPM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >
> > > Add the following selftests for new insn_array map:
> > >
> > >   * Incorrect instruction indexes are rejected
> > >   * Two programs can't use the same map
> > >   * BPF progs can't operate the map
> > >   * no changes to code =3D> map is the same
> > >   * expected changes when instructions are added
> > >   * expected changes when instructions are deleted
> > >   * expected changes when multiple functions are present
> > >
> > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/bpf_insn_array.c | 409 ++++++++++++++++=
++
> > >  1 file changed, 409 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_a=
rray.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c =
b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > > new file mode 100644
> > > index 000000000000..96ee9c9984f1
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > > @@ -0,0 +1,409 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <bpf/bpf.h>
> > > +#include <test_progs.h>
> > > +
> > > +#ifdef __x86_64__
> > > +static int map_create(__u32 map_type, __u32 max_entries)
> > > +{
> > > +       const char *map_name =3D "insn_array";
> > > +       __u32 key_size =3D 4;
> > > +       __u32 value_size =3D sizeof(struct bpf_insn_array_value);
> > > +
> > > +       return bpf_map_create(map_type, map_name, key_size, value_siz=
e, max_entries, NULL);
> > > +}
> > > +
> > > +static int prog_load(struct bpf_insn *insns, __u32 insn_cnt, int *fd=
_array, __u32 fd_array_cnt)
> > > +{
> > > +       LIBBPF_OPTS(bpf_prog_load_opts, opts);
> > > +
> > > +       opts.fd_array =3D fd_array;
> > > +       opts.fd_array_cnt =3D fd_array_cnt;
> > > +
> > > +       return bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, i=
nsn_cnt, &opts);
> > > +}
> > > +
> > > +static void __check_success(struct bpf_insn *insns, __u32 insn_cnt, =
__u32 *map_in, __u32 *map_out)
> > > +{
> > > +       struct bpf_insn_array_value val =3D {};
> > > +       int prog_fd =3D -1, map_fd, i;
> > > +
> > > +       map_fd =3D map_create(BPF_MAP_TYPE_INSN_ARRAY, insn_cnt);
> > > +       if (!ASSERT_GE(map_fd, 0, "map_create"))
> > > +               return;
> > > +
> > > +       for (i =3D 0; i < insn_cnt; i++) {
> > > +               val.orig_off =3D map_in[i];
> > > +               if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, =
0), 0, "bpf_map_update_elem"))
> > > +                       goto cleanup;
> > > +       }
> > > +
> > > +       if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> > > +               goto cleanup;
> > > +
> > > +       prog_fd =3D prog_load(insns, insn_cnt, &map_fd, 1);
> > > +       if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> > > +               goto cleanup;
> > > +
> > > +       for (i =3D 0; i < insn_cnt; i++) {
> > > +               char buf[64];
> > > +
> > > +               if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val),=
 0, "bpf_map_lookup_elem"))
> > > +                       goto cleanup;
> > > +
> > > +               snprintf(buf, sizeof(buf), "val.xlated_off should be =
equal map_out[%d]", i);
> > > +               ASSERT_EQ(val.xlated_off, map_out[i], buf);
> > > +       }
> > > +
> > > +cleanup:
> > > +       close(prog_fd);
> > > +       close(map_fd);
> > > +}
> > > +
> > > +/*
> > > + * Load a program, which will not be anyhow mangled by the verifier.=
  Add an
> > > + * insn_array map pointing to every instruction. Check that it hasn'=
t changed
> > > + * after the program load.
> > > + */
> > > +static void check_one_to_one_mapping(void)
> > > +{
> > > +       struct bpf_insn insns[] =3D {
> > > +               BPF_MOV64_IMM(BPF_REG_0, 4),
> > > +               BPF_MOV64_IMM(BPF_REG_0, 3),
> > > +               BPF_MOV64_IMM(BPF_REG_0, 2),
> > > +               BPF_MOV64_IMM(BPF_REG_0, 1),
> > > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > > +               BPF_EXIT_INSN(),
> > > +       };
> > > +       __u32 map_in[] =3D {0, 1, 2, 3, 4, 5};
> > > +       __u32 map_out[] =3D {0, 1, 2, 3, 4, 5};
> > > +
> > > +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> > > +}
> > > +
> > > +/*
> > > + * Load a program with two patches (get jiffies, for simplicity). Ad=
d an
> > > + * insn_array map pointing to every instruction. Check how it was ch=
anged
> > > + * after the program load.
> > > + */
> > > +static void check_simple(void)
> > > +{
> > > +       struct bpf_insn insns[] =3D {
> > > +               BPF_MOV64_IMM(BPF_REG_0, 2),
> > > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ji=
ffies64),
> > > +               BPF_MOV64_IMM(BPF_REG_0, 1),
> > > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ji=
ffies64),
> > > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > > +               BPF_EXIT_INSN(),
> > > +       };
> > > +       __u32 map_in[] =3D {0, 1, 2, 3, 4, 5};
> > > +       __u32 map_out[] =3D {0, 1, 4, 5, 8, 9};
> > > +
> > > +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> > > +}
> > > +
> > > +/*
> > > + * Verifier can delete code in two cases: nops & dead code. From ins=
n
> > > + * array's point of view, the two cases are the same, so test using
> > > + * the simplest method: by loading some nops
> > > + */
> > > +static void check_deletions(void)
> > > +{
> > > +       struct bpf_insn insns[] =3D {
> > > +               BPF_MOV64_IMM(BPF_REG_0, 2),
> > > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > > +               BPF_MOV64_IMM(BPF_REG_0, 1),
> > > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > > +               BPF_EXIT_INSN(),
> > > +       };
> > > +       __u32 map_in[] =3D {0, 1, 2, 3, 4, 5};
> > > +       __u32 map_out[] =3D {0, -1, 1, -1, 2, 3};
> > > +
> > > +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> > > +}
> > > +
> > > +/*
> > > + * Same test as check_deletions, but also add code which adds instru=
ctions
> > > + */
> > > +static void check_deletions_with_functions(void)
> > > +{
> > > +       struct bpf_insn insns[] =3D {
> > > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ji=
ffies64),
> > > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
> > > +               BPF_MOV64_IMM(BPF_REG_0, 1),
> > > +               BPF_EXIT_INSN(),
> > > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ji=
ffies64),
> > > +               BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > > +               BPF_MOV64_IMM(BPF_REG_0, 2),
> > > +               BPF_EXIT_INSN(),
> > > +       };
> > > +       __u32 map_in[] =3D  { 0, 1,  2, 3, 4, 5, /* func */  6, 7,  8=
, 9, 10};
> > > +       __u32 map_out[] =3D {-1, 0, -1, 3, 4, 5, /* func */ -1, 6, -1=
, 9, 10};
> > > +
> > > +       __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> > > +}
> >
> > I was thinking of taking the first 5 patches, but this one fails:
> > ./test_progs -t bpf_insn_array
> > ...
> > #19/4    bpf_insn_array/deletions-with-functions:FAIL
> > #19/5    bpf_insn_array/blindness:OK
> > #19/6    bpf_insn_array/incorrect-index:OK
> > #19/7    bpf_insn_array/load-unfrozen-map:OK
> > #19/8    bpf_insn_array/no-map-reuse:OK
> > #19/9    bpf_insn_array/bpf-side-ops:OK
> > #19      bpf_insn_array:FAIL
> >
> > I don't see what you're changing later in the patches
> > to make it pass, but the failure highlights the issue with
> > bisectability. Pls take a look.
>
> Thanks! I've found the chunk, it was
>
> @@ -21664,2 +21705,4 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>                 func[i]->aux->arena =3D prog->aux->arena;
> +               func[i]->aux->used_maps =3D env->used_maps;
> +               func[i]->aux->used_map_cnt =3D env->used_map_cnt;
>                 num_exentries =3D 0;

argh. No need for this copy. Pls use prog->aux->main_prog_aux instead.

> > This one also fails:
> > #170/3   libbpf_str/bpf_map_type_str:FAIL
> > #170     libbpf_str:FAIL
> >
> > I was thinking of hacking it as an extra patch
> > (without full support in patch 8), but gave up when I saw
> > deletions-with-functions failing.
> >
> > Maybe also split the main libbpf patch into prep patch
> > with basic introduction of insn_array ?
>
> I've split a commit that teaches libbpf about insn_array + moved
> the bpftool commit lower. All the tests pass now.
>
> > Or keep it as-is, if respin comes soon.
>
> I can send the first chunk separately today,
> or the whole thing a few days later.

Up to you. Smaller chunks are easier to review.

