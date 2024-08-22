Return-Path: <bpf+bounces-37818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6EE95AC96
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 06:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBB71F22416
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 04:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9506D3A1AC;
	Thu, 22 Aug 2024 04:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmPQIVOj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08113AF2
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 04:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300956; cv=none; b=HF0AklkR60cWBdf3Uu3uLZdX0SD8ePL0Fmv8FGuzCy0BJzzMZz952lmxpsxbs11oD8BZ0QRxrur4mx8nf/KUsWUcn4fQSCL2AMIsZig0mK+GYYr8Pz7GIgO+otI/PGRduOefebianUpZHK4RJ5j2IqHRe2xCrq1MAKha/R7bxMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300956; c=relaxed/simple;
	bh=FxYEMWI1I5GV4jyEDyN/dMBbTkbWAgnRvYIgqFRIF38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiSGiATuqMhVBaBn8zqYBmaMbgVnTra1jNre+yNMOX/Tc8/0lcPl00OgdN374zJUDN5Qb0z1wQy7wjWguQ6S4wYZUcdPMAu0AdG3S+EvSVCgX2Oob4joXFrP3zx1WhFcxIGxXSzjJ31CIqgaoDvkni78X4/gddt0NswIzkyNY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmPQIVOj; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7cd835872ceso265781a12.3
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 21:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724300954; x=1724905754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2K/I78JJaqoHgM8WLsw0EpIafbpAOL/rjAkGqg+oa8=;
        b=CmPQIVOju/3sFXImJaPdnE3aP9dm+gPb5eDOVC+2vbaTpXXfRgPKLYcSBemkvb/+yy
         NYqYAhnpZXwkeZvmg3+THVabJAMd/pO9x1TSc2zhVpqZ3zSIOlzjlxcC2l9WIge1omEj
         MHkQ85+b1AKpHPLT9+aqTRpLnl3CsU+NhrdUod9x+3+92obzmF4BjIhF3rcaAwnvLD4H
         bn8DAMlRI/v4a6kxlbfCWOUrZjdmIW9Y92yA/+JaZ1Q9egsSBAc7zv56nYIKfa9aIket
         ys5dKJE43z7dnht3fxJnJ5aGYugCH8KJErifu7zur8zPP5/6GFoB/hdlU6Sd1BZAxcAT
         1lEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724300954; x=1724905754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2K/I78JJaqoHgM8WLsw0EpIafbpAOL/rjAkGqg+oa8=;
        b=aiNduI9aYIzGWwvH/5+Me+kEBj7wguaY0VUDckmv02BweMWEvUOmjwQlcDd95e0sQn
         NEcjZu8UlUGekd1X8yeOhoh7AzFBy6DA6PnYyzZ7wuahIEJOca//wYoumd14ivCEoQqQ
         /z5lbDGwqof0g69szXRvJwVGvnev7yfw0DQ172nOakVaBLDyg2dCMxLc4wpIeI4PDTZ+
         CKx+AfiqX9cxJqpEVtaS4xgzxn9JKpFSl6zEzcSSvpjeINRmM+VfY5yUp2GBtqq9+H/i
         0MuTI7Nw5xr0/CFLEzHHOuHJxKmy0XVFyx/xLyZ88rWYwy8ySIf0AfZJW3DmozbzP9fO
         +vXw==
X-Gm-Message-State: AOJu0YwGiJmzH/lmTM9Xyll1L9+tZ5iySh+Bm0OuxlHw5FvGYBBubI8K
	cgvd0UNdEl1YFsxmfSMNKGHxztRzhtH1hORI7Yns+qHRdcP1aJejlbpoumi3zPH5joJGQlWzWAl
	kHxBy23UuA5jrkSFoP88A6GyZP+8=
X-Google-Smtp-Source: AGHT+IH8VxWdosDlRFvHMQdn5jxseZlHRLainOUeWe0ja5etZl0ae+cxTiwrpqAOUDHKIZddwFbWxzUbnBtcDvqD+4s=
X-Received: by 2002:a05:6a20:2794:b0:1ca:dbd8:2de3 with SMTP id
 adf61e73a8af0-1cadbd82e13mr3475322637.2.1724300953754; Wed, 21 Aug 2024
 21:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822001837.2715909-1-eddyz87@gmail.com> <20240822001837.2715909-3-eddyz87@gmail.com>
In-Reply-To: <20240822001837.2715909-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Aug 2024 21:29:01 -0700
Message-ID: <CAEf4BzaVjrHSi9eh9-YP37tsH2B5n0ah3m290Y7_v6zBXrEBiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: test for malformed
 BPF_CORE_TYPE_ID_LOCAL relocation
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, cnitlrt@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 5:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Check that verifier rejects BPF program containing relocation
> pointing to non-existent BTF type.
>
> To force relocation resolution on kernel side test case uses
> bpf_attr->core_relos field. This field is not exposed by libbpf,
> so directly do BPF system call in the test.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/core_reloc_raw.c | 124 ++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/core_reloc_raw=
.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/to=
ols/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> new file mode 100644
> index 000000000000..1ab3ab305d3b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Test cases that can't load programs using libbpf and need direct
> + * BPF syscall access
> + */
> +
> +#include <sys/syscall.h>
> +#include <bpf/libbpf.h>
> +#include <bpf/btf.h>
> +
> +#include "test_progs.h"
> +#include "test_btf.h"
> +#include "bpf/libbpf_internal.h"
> +
> +static char log[16 * 1024];
> +
> +/* Check that verifier rejects BPF program containing relocation
> + * pointing to non-existent BTF type.
> + */
> +static void test_bad_local_id(void)
> +{
> +       struct test_btf {
> +               struct btf_header hdr;
> +               __u32 types[15];
> +               char strings[128];
> +       } raw_btf =3D {
> +               .hdr =3D {
> +                       .magic =3D BTF_MAGIC,
> +                       .version =3D BTF_VERSION,
> +                       .hdr_len =3D sizeof(struct btf_header),
> +                       .type_off =3D 0,
> +                       .type_len =3D sizeof(raw_btf.types),
> +                       .str_off =3D offsetof(struct test_btf, strings) -
> +                                  offsetof(struct test_btf, types),
> +                       .str_len =3D sizeof(raw_btf.strings),
> +               },
> +               .types =3D {
> +                       BTF_PTR_ENC(0),                                 /=
* [1] void*  */
> +                       BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),  /=
* [2] int    */
> +                       BTF_FUNC_PROTO_ENC(2, 1),                       /=
* [3] int (*)(void*) */
> +                       BTF_FUNC_PROTO_ARG_ENC(8, 1),
> +                       BTF_FUNC_ENC(8, 3)                      /* [4] FU=
NC 'foo' type_id=3D2   */
> +               },
> +               .strings =3D "\0int\0 0\0foo\0"
> +       };
> +       __u32 log_level =3D 1 | 2 | 4;
> +       LIBBPF_OPTS(bpf_btf_load_opts, opts,
> +                   .log_buf =3D log,
> +                   .log_size =3D sizeof(log),
> +                   .log_level =3D log_level,
> +       );
> +       struct bpf_insn insns[] =3D {
> +               BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
> +               BPF_EXIT_INSN(),
> +       };
> +       struct bpf_func_info funcs[] =3D {
> +               {
> +                       .insn_off =3D 0,
> +                       .type_id =3D 4,
> +               }
> +       };
> +       struct bpf_core_relo relos[] =3D {
> +               {
> +                       .insn_off =3D 0,          /* patch first instruct=
ion (r0 =3D 0) */
> +                       .type_id =3D 100500,      /* !!! this type id doe=
s not exist */
> +                       .access_str_off =3D 6,    /* offset of "0" */
> +                       .kind =3D BPF_CORE_TYPE_ID_LOCAL,
> +               }
> +       };
> +       union bpf_attr attr =3D {};
> +       int saved_errno;
> +       int prog_fd =3D -1;
> +       int btf_fd =3D -1;
> +
> +       btf_fd =3D bpf_btf_load(&raw_btf, sizeof(raw_btf), &opts);
> +       saved_errno =3D errno;
> +       if (btf_fd < 0 || env.verbosity > VERBOSE_NORMAL) {
> +               printf("-------- BTF load log start --------\n");
> +               printf("%s", log);
> +               printf("-------- BTF load log end ----------\n");
> +       }
> +       if (btf_fd < 0) {
> +               PRINT_FAIL("bpf_btf_load() failed, errno=3D%d\n", saved_e=
rrno);
> +               return;
> +       }
> +
> +       memset(log, 0, sizeof(log));

generally speaking there is no need to memset log buffer (maybe just a
first byte, to be safe)

on the other hand, just `union bpf_attr attr =3D {};` is breakage
waiting to happen, I'd do memset(0) on that, we did run into problems
with that before (I believe it was systemd)

> +       attr.prog_btf_fd =3D btf_fd;
> +       attr.prog_type =3D BPF_TRACE_RAW_TP;
> +       attr.license =3D (__u64)"GPL";
> +       attr.insns =3D (__u64)&insns;
> +       attr.insn_cnt =3D sizeof(insns) / sizeof(*insns);
> +       attr.log_buf =3D (__u64)log;
> +       attr.log_size =3D sizeof(log);
> +       attr.log_level =3D log_level;
> +       attr.func_info =3D (__u64)funcs;
> +       attr.func_info_cnt =3D sizeof(funcs) / sizeof(*funcs);
> +       attr.func_info_rec_size =3D sizeof(*funcs);
> +       attr.core_relos =3D (__u64)relos;
> +       attr.core_relo_cnt =3D sizeof(relos) / sizeof(*relos);
> +       attr.core_relo_rec_size =3D sizeof(*relos);

I was wondering for a bit why you didn't just use bpf_prog_load(), and
it seems like it's due to core_relos fields? I don't see why we can't
extend the bpf_prog_load() API to allow to specify those. (would allow
to avoid open-coding this whole bpf_attr business, but it's fine as is
as well)

> +       prog_fd =3D sys_bpf_prog_load(&attr, sizeof(attr), 1);
> +       saved_errno =3D errno;
> +       if (prog_fd < 0 || env.verbosity > VERBOSE_NORMAL) {
> +               printf("-------- program load log start --------\n");
> +               printf("%s", log);
> +               printf("-------- program load log end ----------\n");
> +       }
> +       if (prog_fd >=3D 0) {
> +               PRINT_FAIL("sys_bpf_prog_load() expected to fail\n");
> +               goto out;
> +       }
> +       ASSERT_HAS_SUBSTR(log, "relo #0: bad type id 100500", "program lo=
ad log");
> +
> +out:
> +       close(prog_fd);
> +       close(btf_fd);
> +}
> +
> +void test_core_reloc_raw(void)
> +{
> +       if (test__start_subtest("bad_local_id"))
> +               test_bad_local_id();
> +}
> --
> 2.45.2
>

