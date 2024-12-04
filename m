Return-Path: <bpf+bounces-46072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6A19E39D4
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 13:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C425316438F
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 12:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F591B6CF9;
	Wed,  4 Dec 2024 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="eX+t7yfQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129AC2C181
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315151; cv=none; b=ixN99Lzh9JOI87k7YTR7WSYzH6Bd/MekOgiPwF4tMgHLD8dPdH7uwwCY9UMOcexLd5GbtmK3UdkiUi6/QGXWEyodIkVTlyi50b1gPXrsJlAjJ90B1v8w2MkZbkil1fzy8eQxEZEyJ9AxrFnFnn08EY59nNiTsJAQ0zzgbXZUSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315151; c=relaxed/simple;
	bh=WzC63ap1+EY/gMqDqsO+dooFkfUjzHS+3MOn1gtSNOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMKkkrfAZbVv/NZsLAaQsR1lr6lS17wnSCXD8lSlD0mJyQ/SN/Dxr8LNRg/GC/cUi7SEM64p2NjqdwlgxBE61lXGWqtU9zniIDfYng5ea6g/Ge8xbsd6BMOvPpUjMMoST9GDoAlWmV0swuXpn2jF0X4pDvZ8XYmrsQZpTCv3Bhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=eX+t7yfQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434ab938e37so43850995e9.0
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 04:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733315147; x=1733919947; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nDRswvidoAkxR0/ZXVAq7ynfy3MbmTW7kk9Z+0+fbew=;
        b=eX+t7yfQYpplGX3PiEJTkXXh08B423ljSkTl45HHc2tY7iOcoP45lAiFVkhGoeqkRR
         Mi2pgFGtTpjcF3txZggpt7BGAzLDmoRKi2aXCB4SLxKMzotUSShaSxAIr/oHbdQiBNrY
         AcQ7E8NC0l7qLIm3ctODMlknUgo7WyvuNxN6p1qQmghPYNaD6Hjvsm0e/zLHrr6gQLeh
         7f1U3IHTVGnrO9kFsOvgEzlPL7t91junfVrkJOB8+lznEI1g9ZwPlmeukmvOSFfttNuA
         JqGSBe4Z5uac41ImYHHfnuALz4JgiBGpE+C5kmKMOqXukes7pHeoufSQTOLjRHiW6hsk
         teTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733315147; x=1733919947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDRswvidoAkxR0/ZXVAq7ynfy3MbmTW7kk9Z+0+fbew=;
        b=IQOxXVuUidEDxyYvVaX4Qrr3bJFO41rjLPgN6qjPy9V1X4DTT9OgB0OTfKMNeGEJHI
         evm+Yo5Im+9tEfQhiTopQnQtWjDiZi6bHG0sgRJCoZysLLrYkV4zXHc6GP37LiYPdpUt
         INrFw/scoMStvgOf8PBikCNhKMAPxzOcscSalMenPTtMFHFGVomA+Jb8LSE3JFYVfrlD
         A6SVef37QJEfND9bUQSOgELJQ/FIkK4NZmyOPwmxF40/3rjll8bJY1H52RxapHiivjIc
         g0Fqo3mKfPqVkv3F7fIZfSMF0Mlv6CxbngWhlMsl7dENDdEwP2G9egblIoJ/qfW4GpQ/
         y9xw==
X-Gm-Message-State: AOJu0YyIOY1LMeh60rZ3zQADYC27YKWeOdkmqq+wyLCeqZplFC7tbvEk
	VQQSNirMLO+YNPczav7uyHLDurp82mSFptLLCwaNxNM+AoPfiEqAu2fxAhL4V1N7NhRqpIyT8tp
	9
X-Gm-Gg: ASbGncvo2LqzUDdWdA85/cEVbxJDXHmJ51WXNEHApO0YKHgMzBuIDa4AucPjAhQQ/Ss
	VoqeHnr3extWhhskRei1j1MAgGBjNmZ8P1PSfWhWoU5VGXb0Bv0c1dbS+eN07B268V0Jj6zdGM3
	GbRDG2G6jyHR/uw0rtXVYa1qpZ7WnAPVLreeyMtAgCGW3kbhgctKmy1qBe86SiZMODQbn/gv8Ep
	XXvk/a9B8le6XmvtsnI46SWVHrDsIGJcZjfNnc=
X-Google-Smtp-Source: AGHT+IHlOVo6H1+DBfnSniaEp9aHSypLH6C6/qrSHhiX+Y03z1IMiCn2vXCH6pqIaiOZUZ6R6teJKg==
X-Received: by 2002:a05:600c:19ce:b0:431:5871:6c5d with SMTP id 5b1f17b1804b1-434d3f8e454mr40121445e9.3.1733315147284;
        Wed, 04 Dec 2024 04:25:47 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52a5be8sm23047865e9.31.2024.12.04.04.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:25:46 -0800 (PST)
Date: Wed, 4 Dec 2024 12:28:00 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 5/7] selftests/bpf: Add tests for fd_array_cnt
Message-ID: <Z1BK0NQO/Ub8uBeY@eis>
References: <20241203135052.3380721-1-aspsk@isovalent.com>
 <20241203135052.3380721-6-aspsk@isovalent.com>
 <CAEf4BzYBGfMttkMTN44158oOTm2uESMExEMxOcAF8Jy12ihAOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYBGfMttkMTN44158oOTm2uESMExEMxOcAF8Jy12ihAOQ@mail.gmail.com>

On 24/12/03 01:27PM, Andrii Nakryiko wrote:
> On Tue, Dec 3, 2024 at 6:13 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > Add a new set of tests to test the new field in PROG_LOAD-related
> > part of bpf_attr: fd_array_cnt.
> >
> > Add the following test cases:
> >
> >   * fd_array_cnt/no-fd-array: program is loaded in a normal
> >     way, without any fd_array present
> >
> >   * fd_array_cnt/fd-array-ok: pass two extra non-used maps,
> >     check that they're bound to the program
> >
> >   * fd_array_cnt/fd-array-dup-input: pass a few extra maps,
> >     only two of which are unique
> >
> >   * fd_array_cnt/fd-array-ref-maps-in-array: pass a map in
> >     fd_array which is also referenced from within the program
> >
> >   * fd_array_cnt/fd-array-trash-input: pass array with some trash
> >
> >   * fd_array_cnt/fd-array-with-holes: pass an array with holes (fd=0)
> 
> nit: should be removed, there is no such test anymore
> 
> >
> >   * fd_array_cnt/fd-array-2big: pass too large array
> >
> > All the tests above are using the bpf(2) syscall directly,
> > no libbpf involved.
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  .../selftests/bpf/prog_tests/fd_array.c       | 340 ++++++++++++++++++
> >  1 file changed, 340 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_array.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/fd_array.c b/tools/testing/selftests/bpf/prog_tests/fd_array.c
> > new file mode 100644
> > index 000000000000..1d4bff4a1269
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/fd_array.c
> > @@ -0,0 +1,340 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +
> > +#include <linux/btf.h>
> > +#include <bpf/bpf.h>
> > +
> > +#include "../test_btf.h"
> > +
> > +static inline int new_map(void)
> > +{
> > +       LIBBPF_OPTS(bpf_map_create_opts, opts);
> > +       const char *name = NULL;
> > +       __u32 max_entries = 1;
> > +       __u32 value_size = 8;
> > +       __u32 key_size = 4;
> > +
> > +       return bpf_map_create(BPF_MAP_TYPE_ARRAY, name,
> > +                             key_size, value_size,
> > +                             max_entries, &opts);
> 
> nit: you don't really need to pass empty opts, passing NULL is always
> ok if no options are specified
> 
> > +}
> > +
> > +static int new_btf(void)
> > +{
> > +       LIBBPF_OPTS(bpf_btf_load_opts, opts);
> > +       struct btf_blob {
> > +               struct btf_header btf_hdr;
> > +               __u32 types[8];
> > +               __u32 str;
> > +       } raw_btf = {
> > +               .btf_hdr = {
> > +                       .magic = BTF_MAGIC,
> > +                       .version = BTF_VERSION,
> > +                       .hdr_len = sizeof(struct btf_header),
> > +                       .type_len = sizeof(raw_btf.types),
> > +                       .str_off = offsetof(struct btf_blob, str) - offsetof(struct btf_blob, types),
> > +                       .str_len = sizeof(raw_btf.str),
> > +               },
> > +               .types = {
> > +                       /* long */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 64, 8),  /* [1] */
> > +                       /* unsigned long */
> > +                       BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),  /* [2] */
> > +               },
> > +       };
> > +
> > +       return bpf_btf_load(&raw_btf, sizeof(raw_btf), &opts);
> 
> same, you don't seem to actually use opts
> 
> > +}
> > +
> > +static bool map_exists(__u32 id)
> > +{
> > +       int fd;
> > +
> > +       fd = bpf_map_get_fd_by_id(id);
> > +       if (fd >= 0) {
> > +               close(fd);
> > +               return true;
> > +       }
> > +       return false;
> > +}
> > +
> > +static inline int bpf_prog_get_map_ids(int prog_fd, __u32 *nr_map_ids, __u32 *map_ids)
> > +{
> > +       __u32 len = sizeof(struct bpf_prog_info);
> > +       struct bpf_prog_info info = {
> > +               .nr_map_ids = *nr_map_ids,
> > +               .map_ids = ptr_to_u64(map_ids),
> > +       };
> 
> nit: bpf_prog_info should be explicitly memset(0), and only then
> fields should be filled out. It might be ok right now because we don't
> have any padding (or compiler does zero that padding out, even though
> it's not required to do that), but this might pop up later, so best to
> avoid that.
> 
> > +       int err;
> > +
> > +       err = bpf_prog_get_info_by_fd(prog_fd, &info, &len);
> > +       if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
> > +               return -1;
> > +
> > +       *nr_map_ids = info.nr_map_ids;
> > +
> > +       return 0;
> > +}
> > +
> > +static int __load_test_prog(int map_fd, const int *fd_array, int fd_array_cnt)
> > +{
> > +       /* A trivial program which uses one map */
> > +       struct bpf_insn insns[] = {
> > +               BPF_LD_MAP_FD(BPF_REG_1, map_fd),
> > +               BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> > +               BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> > +               BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > +               BPF_EXIT_INSN(),
> > +       };
> > +       LIBBPF_OPTS(bpf_prog_load_opts, opts);
> > +
> > +       opts.fd_array = fd_array;
> > +       opts.fd_array_cnt = fd_array_cnt;
> > +
> > +       return bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, ARRAY_SIZE(insns), &opts);
> > +}
> > +
> > +static int load_test_prog(const int *fd_array, int fd_array_cnt)
> > +{
> > +       int map_fd;
> > +       int ret;
> > +
> > +       map_fd = new_map();
> > +       if (!ASSERT_GE(map_fd, 0, "new_map"))
> > +               return map_fd;
> > +
> > +       ret = __load_test_prog(map_fd, fd_array, fd_array_cnt);
> > +       close(map_fd);
> > +
> > +       /* switch back to returning the actual value */
> > +       if (ret < 0)
> > +               return -errno;
> 
> this errno might have been modified by close(), but you actually don't
> need errno, libbpf will return errno directly from bpf_prog_load(), so
> you can just do:
> 
> ret = __load_test_prog(...);
> close(map_fd);
> return ret;
> 
> > +       return ret;
> > +}
> > +
> > +static bool check_expected_map_ids(int prog_fd, int expected, __u32 *map_ids, __u32 *nr_map_ids)
> > +{
> > +       int err;
> > +
> > +       err = bpf_prog_get_map_ids(prog_fd, nr_map_ids, map_ids);
> > +       if (!ASSERT_OK(err, "bpf_prog_get_map_ids"))
> > +               return false;
> > +       if (!ASSERT_EQ(*nr_map_ids, expected, "unexpected nr_map_ids"))
> > +               return false;
> > +
> > +       return true;
> > +}
> > +
> > +/*
> > + * Load a program, which uses one map. No fd_array maps are present.
> > + * On return only one map is expected to be bound to prog.
> > + */
> > +static void check_fd_array_cnt__no_fd_array(void)
> > +{
> > +       __u32 map_ids[16];
> > +       __u32 nr_map_ids;
> > +       int prog_fd = -1;
> > +
> > +       prog_fd = load_test_prog(NULL, 0);
> > +       if (!ASSERT_GE(prog_fd, 0, "BPF_PROG_LOAD"))
> > +               return;
> > +       nr_map_ids = ARRAY_SIZE(map_ids);
> > +       check_expected_map_ids(prog_fd, 1, map_ids, &nr_map_ids);
> > +       close(prog_fd);
> > +}
> > +
> > +/*
> > + * Load a program, which uses one map, and pass two extra, non-equal, maps in
> > + * fd_array with fd_array_cnt=2. On return three maps are expected to be bound
> > + * to the program.
> > + */
> > +static void check_fd_array_cnt__fd_array_ok(void)
> > +{
> > +       int extra_fds[2] = { -1, -1 };
> > +       __u32 map_ids[16];
> > +       __u32 nr_map_ids;
> > +       int prog_fd = -1;
> > +
> > +       extra_fds[0] = new_map();
> > +       if (!ASSERT_GE(extra_fds[0], 0, "new_map"))
> > +               goto cleanup;
> > +       extra_fds[1] = new_map();
> > +       if (!ASSERT_GE(extra_fds[1], 0, "new_map"))
> > +               goto cleanup;
> > +       prog_fd = load_test_prog(extra_fds, 2);
> > +       if (!ASSERT_GE(prog_fd, 0, "BPF_PROG_LOAD"))
> > +               goto cleanup;
> > +       nr_map_ids = ARRAY_SIZE(map_ids);
> > +       if (!check_expected_map_ids(prog_fd, 3, map_ids, &nr_map_ids))
> > +               goto cleanup;
> > +
> > +       /* maps should still exist when original file descriptors are closed */
> > +       close(extra_fds[0]);
> > +       close(extra_fds[1]);
> > +       if (!ASSERT_EQ(map_exists(map_ids[0]), true, "map_ids[0] should exist"))
> > +               goto cleanup;
> > +       if (!ASSERT_EQ(map_exists(map_ids[1]), true, "map_ids[1] should exist"))
> > +               goto cleanup;
> > +
> > +       /* some fds might be invalid, so ignore return codes */
> > +cleanup:
> > +       close(extra_fds[1]);
> > +       close(extra_fds[0]);
> > +       close(prog_fd);
> 
> nit: technically, you should check each fd to be >= 0 before closing it
> 
> > +}
> > +
> > +/*
> > + * Load a program with a few extra maps duplicated in the fd_array.
> > + * After the load maps should only be referenced once.
> > + */
> > +static void check_fd_array_cnt__duplicated_maps(void)
> > +{
> > +       int extra_fds[4] = { -1, -1, -1, -1 };
> > +       __u32 map_ids[16];
> > +       __u32 nr_map_ids;
> > +       int prog_fd = -1;
> > +
> > +       extra_fds[0] = extra_fds[2] = new_map();
> > +       if (!ASSERT_GE(extra_fds[0], 0, "new_map"))
> > +               goto cleanup;
> > +       extra_fds[1] = extra_fds[3] = new_map();
> > +       if (!ASSERT_GE(extra_fds[1], 0, "new_map"))
> > +               goto cleanup;
> > +       prog_fd = load_test_prog(extra_fds, 4);
> > +       if (!ASSERT_GE(prog_fd, 0, "BPF_PROG_LOAD"))
> > +               goto cleanup;
> > +       nr_map_ids = ARRAY_SIZE(map_ids);
> > +       if (!check_expected_map_ids(prog_fd, 3, map_ids, &nr_map_ids))
> > +               goto cleanup;
> > +
> > +       /* maps should still exist when original file descriptors are closed */
> > +       close(extra_fds[0]);
> > +       close(extra_fds[1]);
> > +       if (!ASSERT_EQ(map_exists(map_ids[0]), true, "map should exist"))
> > +               goto cleanup;
> > +       if (!ASSERT_EQ(map_exists(map_ids[1]), true, "map should exist"))
> > +               goto cleanup;
> > +
> > +       /* some fds might be invalid, so ignore return codes */
> > +cleanup:
> > +       close(extra_fds[1]);
> > +       close(extra_fds[0]);
> > +       close(prog_fd);
> 
> same about if (fd >=0) close(fd); pattern
> 
> > +}
> > +
> > +/*
> > + * Check that if maps which are referenced by a program are
> > + * passed in fd_array, then they will be referenced only once
> > + */
> > +static void check_fd_array_cnt__referenced_maps_in_fd_array(void)
> > +{
> > +       int extra_fds[1] = { -1 };
> > +       __u32 map_ids[16];
> > +       __u32 nr_map_ids;
> > +       int prog_fd = -1;
> > +
> > +       extra_fds[0] = new_map();
> > +       if (!ASSERT_GE(extra_fds[0], 0, "new_map"))
> > +               goto cleanup;
> > +       prog_fd = __load_test_prog(extra_fds[0], extra_fds, 1);
> > +       if (!ASSERT_GE(prog_fd, 0, "BPF_PROG_LOAD"))
> > +               goto cleanup;
> > +       nr_map_ids = ARRAY_SIZE(map_ids);
> > +       if (!check_expected_map_ids(prog_fd, 1, map_ids, &nr_map_ids))
> > +               goto cleanup;
> > +
> > +       /* map should still exist when original file descriptor is closed */
> > +       close(extra_fds[0]);
> > +       if (!ASSERT_EQ(map_exists(map_ids[0]), true, "map should exist"))
> > +               goto cleanup;
> > +
> > +       /* some fds might be invalid, so ignore return codes */
> > +cleanup:
> > +       close(extra_fds[0]);
> > +       close(prog_fd);
> 
> ditto
> 
> > +}
> > +
> > +/*
> > + * Test that a program with trash in fd_array can't be loaded:
> > + * only map and BTF file descriptors should be accepted.
> > + */
> > +static void check_fd_array_cnt__fd_array_with_trash(void)
> > +{
> > +       int extra_fds[3] = { -1, -1, -1 };
> > +       int prog_fd = -1;
> > +
> > +       extra_fds[0] = new_map();
> > +       if (!ASSERT_GE(extra_fds[0], 0, "new_map"))
> > +               goto cleanup;
> > +       extra_fds[1] = new_btf();
> > +       if (!ASSERT_GE(extra_fds[1], 0, "new_btf"))
> > +               goto cleanup;
> > +
> > +       /* trash 1: not a file descriptor */
> > +       extra_fds[2] = 0xbeef;
> > +       prog_fd = load_test_prog(extra_fds, 3);
> > +       if (!ASSERT_EQ(prog_fd, -EBADF, "prog should have been rejected with -EBADF"))
> > +               goto cleanup;
> > +
> > +       /* trash 2: not a map or btf */
> > +       extra_fds[2] = socket(AF_INET, SOCK_STREAM, 0);
> > +       if (!ASSERT_GE(extra_fds[2], 0, "socket"))
> > +               goto cleanup;
> > +
> > +       prog_fd = load_test_prog(extra_fds, 3);
> > +       if (!ASSERT_EQ(prog_fd, -EINVAL, "prog should have been rejected with -EINVAL"))
> > +               goto cleanup;
> > +
> > +       /* some fds might be invalid, so ignore return codes */
> > +cleanup:
> > +       close(extra_fds[2]);
> > +       close(extra_fds[1]);
> > +       close(extra_fds[0]);
> 
> ditto
> 
> > +}
> > +
> > +/*
> > + * Test that a program with too big fd_array can't be loaded.
> > + */
> > +static void check_fd_array_cnt__fd_array_too_big(void)
> > +{
> > +       int extra_fds[65];
> > +       int prog_fd = -1;
> > +       int i;
> > +
> > +       for (i = 0; i < 65; i++) {
> > +               extra_fds[i] = new_map();
> > +               if (!ASSERT_GE(extra_fds[i], 0, "new_map"))
> > +                       goto cleanup_fds;
> > +       }
> > +
> > +       prog_fd = load_test_prog(extra_fds, 65);
> 
> nit: hard-coding 65 as the limit seems iffy, when we change
> MAX_USED_MAPS this will need adjustment immediately. How about picking
> something significantly larger, like 4096, creating just one map with
> new_map(), but using that map FD in each entry, then doing
> load_test_prog() once and check for -E2BIG?

This will not work with -E2BIG, as when maps are the same,
they will not be added to used_maps multiple times. I still
can try to bump the number here, but not sure if this is
possible to track MAX_USED_MAPS from userspace?

(All your comments above make sense, will fix.)

> 
> > +       ASSERT_EQ(prog_fd, -E2BIG, "prog should have been rejected with -E2BIG");
> > +
> > +cleanup_fds:
> > +       while (i > 0)
> > +               close(extra_fds[--i]);
> > +}
> > +
> > +void test_fd_array_cnt(void)
> > +{
> > +       if (test__start_subtest("no-fd-array"))
> > +               check_fd_array_cnt__no_fd_array();
> > +
> > +       if (test__start_subtest("fd-array-ok"))
> > +               check_fd_array_cnt__fd_array_ok();
> > +
> > +       if (test__start_subtest("fd-array-dup-input"))
> > +               check_fd_array_cnt__duplicated_maps();
> > +
> > +       if (test__start_subtest("fd-array-ref-maps-in-array"))
> > +               check_fd_array_cnt__referenced_maps_in_fd_array();
> > +
> > +       if (test__start_subtest("fd-array-trash-input"))
> > +               check_fd_array_cnt__fd_array_with_trash();
> > +
> > +       if (test__start_subtest("fd-array-2big"))
> > +               check_fd_array_cnt__fd_array_too_big();
> > +}
> > --
> > 2.34.1
> >
> >

