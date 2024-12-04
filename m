Return-Path: <bpf+bounces-46100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5809E4525
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 20:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11169B3A4A9
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 18:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48AD23919A;
	Wed,  4 Dec 2024 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HERP3IhY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D97239184
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335824; cv=none; b=tal5Vf3P9khNnIhE1VfSMykkRPexqPu5Ns2TVuJ24yVQN5+vt/zuQAqcYvPq3MH1zAg948lQ6zdsKZwk0ymDcedICyspP3JFcKeiVhG6dnz/KDQRHfxSTQvNa+yR3TTgz58vVQK251woM4rf1VZDaFAOaAo5q2/zsGuzJ0YPpWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335824; c=relaxed/simple;
	bh=kUekum4HbWbQDYDTKOb9fknyoZ6+mi63k3jIbf0CwPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0aZYGINVkDnsihn0NTkCH0yVmJuR8qJrmd6G5OTB30tUk2915I2YQFkANSWi79OcQZThLxdj/ZaY32AHVaWu3toSwoRjt9NhL9ToM+KnK6gPVNNOaRPWdkAqz0NBHgm875jUgpQkJ7cAMNNw5h0K/LVxPI+RdXhupdYZ1y9Fzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HERP3IhY; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fc41b4c78bso51124a12.3
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 10:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733335820; x=1733940620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ335oQMBaA/zyXP0cU1/+XrqHe4J5M73D0xeuBpnDM=;
        b=HERP3IhYXz40RAk1tUGuVa/XCHuOa8ht+FA0RdawSqMJg2VXutzcAkqQ/u1Q1wQQ3W
         Lx/BH6N/zApJdvxY+BMOw8HfjnJvip2Lz03wXRcMqphjnH1mNT7bAze/eQaBPPAz8Ssd
         WihdXTnQ0V5NmU/QNo18VBJaJ6zI/5ZW3zx4Vvle5gScVLOXrfkEuu0oU7scAf/uaM23
         JyTbKmODY+JM9CNUeSX50bPVo+V3zVA2Y/AnzPkp7UOelhcTY1aNythVp5D2BzGzCaRC
         cSDiPEj/qBGyArhkdmuoCeRsOz/QxH/QPGq86gpWpZpJ7Ym/CzluI45fcvDLyeSqpif8
         V2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733335820; x=1733940620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJ335oQMBaA/zyXP0cU1/+XrqHe4J5M73D0xeuBpnDM=;
        b=FvhoPKE7+9CM0E2R3Ir5DtFGYx/Iw4TfN6KbTuYIp6Hh1ln29c2Tfs/wFndrW7CXmF
         PPt7yVuFKuJUtwUhBFGLVUqgCJze5Wdbp2IYHg4tA9Y/NBg44pWE/awiEVkvtxCDKlen
         t/3/yQkildLsWMIsLVqEr9wO/s1OTUcZjDBcnLd7v+ZdouGpOwtPTUJ+EnWH6g67KDWE
         XOavIA64Dh4gARCDu79HHwGMxgFHM88o2xyX9vA2QOlzRmJWGjnP+ayQ7FTI/XqcECnz
         2aHT8JRaEAiju+0Nz+CoudXsuBnJ+r2Y2iWCNSMzO0WAsjgtLsuuA7iIdiwc+tGxoBC5
         On3w==
X-Gm-Message-State: AOJu0YxK3CV3h8/MDbulUaML5aln5f2rBvx6C8Gi2pHkfcDPdX/8qn8q
	B9g3wLhh8A2fEfSGTrUD1+5nG8ecUtB9NosMxVXziUafgtXYKHCkqQnrHVd7nVkG9gVa3FKCMZZ
	Y2FLr8EnOxdjqubf1ZpGt/7SXPp+qTw==
X-Gm-Gg: ASbGnctbhAuaHL5dqKPydWw6N3BM4B/26nQoLHp9gIcms1KPoMjQ+Txcos67UkiFck9
	Uya7/iRlSpazE2MRQz2ChDqCX2qTBqSqhDSsC1H+J7bqNmYU=
X-Google-Smtp-Source: AGHT+IFCKrrDhgdA5dllJyREDyWVUlnwzdYdozjacp7ccu19NPVkpgbzJ6ku2RY0D7kYEnfOPGuzp1Kx45cJyyIqyeM=
X-Received: by 2002:a17:90b:380a:b0:2ef:30ec:14c9 with SMTP id
 98e67ed59e1d1-2ef30ec1c96mr2651069a91.18.1733335820312; Wed, 04 Dec 2024
 10:10:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203135052.3380721-1-aspsk@isovalent.com> <20241203135052.3380721-6-aspsk@isovalent.com>
 <CAEf4BzYBGfMttkMTN44158oOTm2uESMExEMxOcAF8Jy12ihAOQ@mail.gmail.com> <Z1BK0NQO/Ub8uBeY@eis>
In-Reply-To: <Z1BK0NQO/Ub8uBeY@eis>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Dec 2024 10:10:08 -0800
Message-ID: <CAEf4BzZ6V6yUVyJuX3r12rPEHj2uiJ_gNGr8bbCA+yxJntVqng@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 5/7] selftests/bpf: Add tests for fd_array_cnt
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 4:25=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> On 24/12/03 01:27PM, Andrii Nakryiko wrote:
> > On Tue, Dec 3, 2024 at 6:13=E2=80=AFAM Anton Protopopov <aspsk@isovalen=
t.com> wrote:
> > >
> > > Add a new set of tests to test the new field in PROG_LOAD-related
> > > part of bpf_attr: fd_array_cnt.
> > >
> > > Add the following test cases:
> > >
> > >   * fd_array_cnt/no-fd-array: program is loaded in a normal
> > >     way, without any fd_array present
> > >
> > >   * fd_array_cnt/fd-array-ok: pass two extra non-used maps,
> > >     check that they're bound to the program
> > >
> > >   * fd_array_cnt/fd-array-dup-input: pass a few extra maps,
> > >     only two of which are unique
> > >
> > >   * fd_array_cnt/fd-array-ref-maps-in-array: pass a map in
> > >     fd_array which is also referenced from within the program
> > >
> > >   * fd_array_cnt/fd-array-trash-input: pass array with some trash
> > >
> > >   * fd_array_cnt/fd-array-with-holes: pass an array with holes (fd=3D=
0)
> >
> > nit: should be removed, there is no such test anymore
> >
> > >
> > >   * fd_array_cnt/fd-array-2big: pass too large array
> > >
> > > All the tests above are using the bpf(2) syscall directly,
> > > no libbpf involved.
> > >
> > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/fd_array.c       | 340 ++++++++++++++++=
++
> > >  1 file changed, 340 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_array.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/fd_array.c b/tool=
s/testing/selftests/bpf/prog_tests/fd_array.c
> > > new file mode 100644
> > > index 000000000000..1d4bff4a1269
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/fd_array.c
> > > @@ -0,0 +1,340 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <test_progs.h>
> > > +
> > > +#include <linux/btf.h>
> > > +#include <bpf/bpf.h>
> > > +
> > > +#include "../test_btf.h"
> > > +
> > > +static inline int new_map(void)
> > > +{
> > > +       LIBBPF_OPTS(bpf_map_create_opts, opts);
> > > +       const char *name =3D NULL;
> > > +       __u32 max_entries =3D 1;
> > > +       __u32 value_size =3D 8;
> > > +       __u32 key_size =3D 4;
> > > +
> > > +       return bpf_map_create(BPF_MAP_TYPE_ARRAY, name,
> > > +                             key_size, value_size,
> > > +                             max_entries, &opts);
> >
> > nit: you don't really need to pass empty opts, passing NULL is always
> > ok if no options are specified
> >
> > > +}
> > > +
> > > +static int new_btf(void)
> > > +{
> > > +       LIBBPF_OPTS(bpf_btf_load_opts, opts);
> > > +       struct btf_blob {
> > > +               struct btf_header btf_hdr;
> > > +               __u32 types[8];
> > > +               __u32 str;
> > > +       } raw_btf =3D {
> > > +               .btf_hdr =3D {
> > > +                       .magic =3D BTF_MAGIC,
> > > +                       .version =3D BTF_VERSION,
> > > +                       .hdr_len =3D sizeof(struct btf_header),
> > > +                       .type_len =3D sizeof(raw_btf.types),
> > > +                       .str_off =3D offsetof(struct btf_blob, str) -=
 offsetof(struct btf_blob, types),
> > > +                       .str_len =3D sizeof(raw_btf.str),
> > > +               },
> > > +               .types =3D {
> > > +                       /* long */
> > > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 64, 8)=
,  /* [1] */
> > > +                       /* unsigned long */
> > > +                       BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),  /* [2] */
> > > +               },
> > > +       };
> > > +
> > > +       return bpf_btf_load(&raw_btf, sizeof(raw_btf), &opts);
> >
> > same, you don't seem to actually use opts
> >
> > > +}
> > > +
> > > +static bool map_exists(__u32 id)
> > > +{
> > > +       int fd;
> > > +
> > > +       fd =3D bpf_map_get_fd_by_id(id);
> > > +       if (fd >=3D 0) {
> > > +               close(fd);
> > > +               return true;
> > > +       }
> > > +       return false;
> > > +}
> > > +
> > > +static inline int bpf_prog_get_map_ids(int prog_fd, __u32 *nr_map_id=
s, __u32 *map_ids)
> > > +{
> > > +       __u32 len =3D sizeof(struct bpf_prog_info);
> > > +       struct bpf_prog_info info =3D {
> > > +               .nr_map_ids =3D *nr_map_ids,
> > > +               .map_ids =3D ptr_to_u64(map_ids),
> > > +       };
> >
> > nit: bpf_prog_info should be explicitly memset(0), and only then
> > fields should be filled out. It might be ok right now because we don't
> > have any padding (or compiler does zero that padding out, even though
> > it's not required to do that), but this might pop up later, so best to
> > avoid that.
> >
> > > +       int err;
> > > +
> > > +       err =3D bpf_prog_get_info_by_fd(prog_fd, &info, &len);
> > > +       if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
> > > +               return -1;
> > > +
> > > +       *nr_map_ids =3D info.nr_map_ids;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int __load_test_prog(int map_fd, const int *fd_array, int fd_=
array_cnt)
> > > +{
> > > +       /* A trivial program which uses one map */
> > > +       struct bpf_insn insns[] =3D {
> > > +               BPF_LD_MAP_FD(BPF_REG_1, map_fd),
> > > +               BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> > > +               BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> > > +               BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> > > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ma=
p_lookup_elem),
> > > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > > +               BPF_EXIT_INSN(),
> > > +       };
> > > +       LIBBPF_OPTS(bpf_prog_load_opts, opts);
> > > +
> > > +       opts.fd_array =3D fd_array;
> > > +       opts.fd_array_cnt =3D fd_array_cnt;
> > > +
> > > +       return bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, A=
RRAY_SIZE(insns), &opts);
> > > +}
> > > +
> > > +static int load_test_prog(const int *fd_array, int fd_array_cnt)
> > > +{
> > > +       int map_fd;
> > > +       int ret;
> > > +
> > > +       map_fd =3D new_map();
> > > +       if (!ASSERT_GE(map_fd, 0, "new_map"))
> > > +               return map_fd;
> > > +
> > > +       ret =3D __load_test_prog(map_fd, fd_array, fd_array_cnt);
> > > +       close(map_fd);
> > > +
> > > +       /* switch back to returning the actual value */
> > > +       if (ret < 0)
> > > +               return -errno;
> >
> > this errno might have been modified by close(), but you actually don't
> > need errno, libbpf will return errno directly from bpf_prog_load(), so
> > you can just do:
> >
> > ret =3D __load_test_prog(...);
> > close(map_fd);
> > return ret;
> >
> > > +       return ret;
> > > +}
> > > +
> > > +static bool check_expected_map_ids(int prog_fd, int expected, __u32 =
*map_ids, __u32 *nr_map_ids)
> > > +{
> > > +       int err;
> > > +
> > > +       err =3D bpf_prog_get_map_ids(prog_fd, nr_map_ids, map_ids);
> > > +       if (!ASSERT_OK(err, "bpf_prog_get_map_ids"))
> > > +               return false;
> > > +       if (!ASSERT_EQ(*nr_map_ids, expected, "unexpected nr_map_ids"=
))
> > > +               return false;
> > > +
> > > +       return true;
> > > +}
> > > +
> > > +/*
> > > + * Load a program, which uses one map. No fd_array maps are present.
> > > + * On return only one map is expected to be bound to prog.
> > > + */
> > > +static void check_fd_array_cnt__no_fd_array(void)
> > > +{
> > > +       __u32 map_ids[16];
> > > +       __u32 nr_map_ids;
> > > +       int prog_fd =3D -1;
> > > +
> > > +       prog_fd =3D load_test_prog(NULL, 0);
> > > +       if (!ASSERT_GE(prog_fd, 0, "BPF_PROG_LOAD"))
> > > +               return;
> > > +       nr_map_ids =3D ARRAY_SIZE(map_ids);
> > > +       check_expected_map_ids(prog_fd, 1, map_ids, &nr_map_ids);
> > > +       close(prog_fd);
> > > +}
> > > +
> > > +/*
> > > + * Load a program, which uses one map, and pass two extra, non-equal=
, maps in
> > > + * fd_array with fd_array_cnt=3D2. On return three maps are expected=
 to be bound
> > > + * to the program.
> > > + */
> > > +static void check_fd_array_cnt__fd_array_ok(void)
> > > +{
> > > +       int extra_fds[2] =3D { -1, -1 };
> > > +       __u32 map_ids[16];
> > > +       __u32 nr_map_ids;
> > > +       int prog_fd =3D -1;
> > > +
> > > +       extra_fds[0] =3D new_map();
> > > +       if (!ASSERT_GE(extra_fds[0], 0, "new_map"))
> > > +               goto cleanup;
> > > +       extra_fds[1] =3D new_map();
> > > +       if (!ASSERT_GE(extra_fds[1], 0, "new_map"))
> > > +               goto cleanup;
> > > +       prog_fd =3D load_test_prog(extra_fds, 2);
> > > +       if (!ASSERT_GE(prog_fd, 0, "BPF_PROG_LOAD"))
> > > +               goto cleanup;
> > > +       nr_map_ids =3D ARRAY_SIZE(map_ids);
> > > +       if (!check_expected_map_ids(prog_fd, 3, map_ids, &nr_map_ids)=
)
> > > +               goto cleanup;
> > > +
> > > +       /* maps should still exist when original file descriptors are=
 closed */
> > > +       close(extra_fds[0]);
> > > +       close(extra_fds[1]);
> > > +       if (!ASSERT_EQ(map_exists(map_ids[0]), true, "map_ids[0] shou=
ld exist"))
> > > +               goto cleanup;
> > > +       if (!ASSERT_EQ(map_exists(map_ids[1]), true, "map_ids[1] shou=
ld exist"))
> > > +               goto cleanup;
> > > +
> > > +       /* some fds might be invalid, so ignore return codes */
> > > +cleanup:
> > > +       close(extra_fds[1]);
> > > +       close(extra_fds[0]);
> > > +       close(prog_fd);
> >
> > nit: technically, you should check each fd to be >=3D 0 before closing =
it
> >
> > > +}
> > > +
> > > +/*
> > > + * Load a program with a few extra maps duplicated in the fd_array.
> > > + * After the load maps should only be referenced once.
> > > + */
> > > +static void check_fd_array_cnt__duplicated_maps(void)
> > > +{
> > > +       int extra_fds[4] =3D { -1, -1, -1, -1 };
> > > +       __u32 map_ids[16];
> > > +       __u32 nr_map_ids;
> > > +       int prog_fd =3D -1;
> > > +
> > > +       extra_fds[0] =3D extra_fds[2] =3D new_map();
> > > +       if (!ASSERT_GE(extra_fds[0], 0, "new_map"))
> > > +               goto cleanup;
> > > +       extra_fds[1] =3D extra_fds[3] =3D new_map();
> > > +       if (!ASSERT_GE(extra_fds[1], 0, "new_map"))
> > > +               goto cleanup;
> > > +       prog_fd =3D load_test_prog(extra_fds, 4);
> > > +       if (!ASSERT_GE(prog_fd, 0, "BPF_PROG_LOAD"))
> > > +               goto cleanup;
> > > +       nr_map_ids =3D ARRAY_SIZE(map_ids);
> > > +       if (!check_expected_map_ids(prog_fd, 3, map_ids, &nr_map_ids)=
)
> > > +               goto cleanup;
> > > +
> > > +       /* maps should still exist when original file descriptors are=
 closed */
> > > +       close(extra_fds[0]);
> > > +       close(extra_fds[1]);
> > > +       if (!ASSERT_EQ(map_exists(map_ids[0]), true, "map should exis=
t"))
> > > +               goto cleanup;
> > > +       if (!ASSERT_EQ(map_exists(map_ids[1]), true, "map should exis=
t"))
> > > +               goto cleanup;
> > > +
> > > +       /* some fds might be invalid, so ignore return codes */
> > > +cleanup:
> > > +       close(extra_fds[1]);
> > > +       close(extra_fds[0]);
> > > +       close(prog_fd);
> >
> > same about if (fd >=3D0) close(fd); pattern
> >
> > > +}
> > > +
> > > +/*
> > > + * Check that if maps which are referenced by a program are
> > > + * passed in fd_array, then they will be referenced only once
> > > + */
> > > +static void check_fd_array_cnt__referenced_maps_in_fd_array(void)
> > > +{
> > > +       int extra_fds[1] =3D { -1 };
> > > +       __u32 map_ids[16];
> > > +       __u32 nr_map_ids;
> > > +       int prog_fd =3D -1;
> > > +
> > > +       extra_fds[0] =3D new_map();
> > > +       if (!ASSERT_GE(extra_fds[0], 0, "new_map"))
> > > +               goto cleanup;
> > > +       prog_fd =3D __load_test_prog(extra_fds[0], extra_fds, 1);
> > > +       if (!ASSERT_GE(prog_fd, 0, "BPF_PROG_LOAD"))
> > > +               goto cleanup;
> > > +       nr_map_ids =3D ARRAY_SIZE(map_ids);
> > > +       if (!check_expected_map_ids(prog_fd, 1, map_ids, &nr_map_ids)=
)
> > > +               goto cleanup;
> > > +
> > > +       /* map should still exist when original file descriptor is cl=
osed */
> > > +       close(extra_fds[0]);
> > > +       if (!ASSERT_EQ(map_exists(map_ids[0]), true, "map should exis=
t"))
> > > +               goto cleanup;
> > > +
> > > +       /* some fds might be invalid, so ignore return codes */
> > > +cleanup:
> > > +       close(extra_fds[0]);
> > > +       close(prog_fd);
> >
> > ditto
> >
> > > +}
> > > +
> > > +/*
> > > + * Test that a program with trash in fd_array can't be loaded:
> > > + * only map and BTF file descriptors should be accepted.
> > > + */
> > > +static void check_fd_array_cnt__fd_array_with_trash(void)
> > > +{
> > > +       int extra_fds[3] =3D { -1, -1, -1 };
> > > +       int prog_fd =3D -1;
> > > +
> > > +       extra_fds[0] =3D new_map();
> > > +       if (!ASSERT_GE(extra_fds[0], 0, "new_map"))
> > > +               goto cleanup;
> > > +       extra_fds[1] =3D new_btf();
> > > +       if (!ASSERT_GE(extra_fds[1], 0, "new_btf"))
> > > +               goto cleanup;
> > > +
> > > +       /* trash 1: not a file descriptor */
> > > +       extra_fds[2] =3D 0xbeef;
> > > +       prog_fd =3D load_test_prog(extra_fds, 3);
> > > +       if (!ASSERT_EQ(prog_fd, -EBADF, "prog should have been reject=
ed with -EBADF"))
> > > +               goto cleanup;
> > > +
> > > +       /* trash 2: not a map or btf */
> > > +       extra_fds[2] =3D socket(AF_INET, SOCK_STREAM, 0);
> > > +       if (!ASSERT_GE(extra_fds[2], 0, "socket"))
> > > +               goto cleanup;
> > > +
> > > +       prog_fd =3D load_test_prog(extra_fds, 3);
> > > +       if (!ASSERT_EQ(prog_fd, -EINVAL, "prog should have been rejec=
ted with -EINVAL"))
> > > +               goto cleanup;
> > > +
> > > +       /* some fds might be invalid, so ignore return codes */
> > > +cleanup:
> > > +       close(extra_fds[2]);
> > > +       close(extra_fds[1]);
> > > +       close(extra_fds[0]);
> >
> > ditto
> >
> > > +}
> > > +
> > > +/*
> > > + * Test that a program with too big fd_array can't be loaded.
> > > + */
> > > +static void check_fd_array_cnt__fd_array_too_big(void)
> > > +{
> > > +       int extra_fds[65];
> > > +       int prog_fd =3D -1;
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < 65; i++) {
> > > +               extra_fds[i] =3D new_map();
> > > +               if (!ASSERT_GE(extra_fds[i], 0, "new_map"))
> > > +                       goto cleanup_fds;
> > > +       }
> > > +
> > > +       prog_fd =3D load_test_prog(extra_fds, 65);
> >
> > nit: hard-coding 65 as the limit seems iffy, when we change
> > MAX_USED_MAPS this will need adjustment immediately. How about picking
> > something significantly larger, like 4096, creating just one map with
> > new_map(), but using that map FD in each entry, then doing
> > load_test_prog() once and check for -E2BIG?
>
> This will not work with -E2BIG, as when maps are the same,
> they will not be added to used_maps multiple times. I still
> can try to bump the number here, but not sure if this is
> possible to track MAX_USED_MAPS from userspace?

ah, makes sense, it has to be all different maps... Ok, never mind
then, we will detect breakage easily if we ever change internal
constant, so not really a big deal

>
> (All your comments above make sense, will fix.)
>
> >
> > > +       ASSERT_EQ(prog_fd, -E2BIG, "prog should have been rejected wi=
th -E2BIG");
> > > +
> > > +cleanup_fds:
> > > +       while (i > 0)
> > > +               close(extra_fds[--i]);
> > > +}
> > > +
> > > +void test_fd_array_cnt(void)
> > > +{
> > > +       if (test__start_subtest("no-fd-array"))
> > > +               check_fd_array_cnt__no_fd_array();
> > > +
> > > +       if (test__start_subtest("fd-array-ok"))
> > > +               check_fd_array_cnt__fd_array_ok();
> > > +
> > > +       if (test__start_subtest("fd-array-dup-input"))
> > > +               check_fd_array_cnt__duplicated_maps();
> > > +
> > > +       if (test__start_subtest("fd-array-ref-maps-in-array"))
> > > +               check_fd_array_cnt__referenced_maps_in_fd_array();
> > > +
> > > +       if (test__start_subtest("fd-array-trash-input"))
> > > +               check_fd_array_cnt__fd_array_with_trash();
> > > +
> > > +       if (test__start_subtest("fd-array-2big"))
> > > +               check_fd_array_cnt__fd_array_too_big();
> > > +}
> > > --
> > > 2.34.1
> > >
> > >

