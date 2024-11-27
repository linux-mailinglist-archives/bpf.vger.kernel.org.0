Return-Path: <bpf+bounces-45689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0397E9DA26C
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 07:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6398FB21D68
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 06:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DC31487E1;
	Wed, 27 Nov 2024 06:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="JW35feYR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17BEC2
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 06:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689809; cv=none; b=L4J9yW+JsE5Hfaus6yeoGxiIlbx8YjjG1ccAkhBRfS8UomVdDomu5SKPBwJRIUTsyO/s4r7RZ48JcWGo8VmkkP/nLUTDDXCgpTdJ8pfIGS7TmlYL4SMSbyI2XwM/QmFwcXsBsxJnvhgb+2b0uGPGF7CU9N2PWBFAoYOq6I/44xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689809; c=relaxed/simple;
	bh=G1feWvUUyp3Yv/peHW9z8ovJJYnme5K5SdISVVTfl2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ0YBZ8QN8eLFjdRG7EGt/Q41gnZbZWxI9aKdH+fTrPp8P30e3n5VnTvYo2jp7HjutUlonxyVUIaG11UoqJX/SGbxTCT9SMxh+tCDjrYY2Vf86ovWyfDPVB/c3Jvs+ao8L6hr23PFobOePas3no2s9/THbtcZs2wk6Qd7ah2d5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=JW35feYR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cfaa02c716so8120694a12.3
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 22:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732689805; x=1733294605; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hcmPM2NK5SwMPWkjkagmXZZkDmlC8gln2+uK6wUfArE=;
        b=JW35feYRUR5GV1n0fwdHh+L5UXlUmjBvbVQc9obOGfnpVSsRafMZMFxO4XXzCRlJmu
         YSjtThaBYV/1k73AubwfgYkWYVMqz4wb9tKJfl4o9nhxSwinuu81KUVxsMbaSz9MObNP
         X2Revow0F2oUzv8aIr6vWGa6/XwsRDCPbVS002O3N5SCjxZ8OesevEI1+17rC7f8CCLK
         9oOPNaJ+UR7vkCUBSms+h4a5kufYKqwIQ+okoRw+saihsF+ERHjz6XdoBRWRn0Evv6ON
         0uUEqPvVTvqZ4yYQUu+FoZOY+HRYp4W6WnjSuduJe3H9YXoK6AgRS47pM/cRf6SYM5N2
         Xedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732689805; x=1733294605;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcmPM2NK5SwMPWkjkagmXZZkDmlC8gln2+uK6wUfArE=;
        b=ahQjxqlPVQ/2IOk2YznDl4rv8scEj5W1wiHwRtZAqFlnAYGZbYmoNTzynqswo908Ee
         wqeCh1tyFhwv3Ot9gkCM8/8vbYo2rmASjl7R0b/TcsuLxMgeCDeRRak2Z5dREAWHllE2
         fZvgIHSC8nsqBie0g9HSAn4G2SBx7YePpOEtzu+wrcrQCE+dFWuwTEAKZu+tNnKsDEZ/
         6Iosn2tQ85I48+ANDnLuRZpGzYD3iV218sBTVGimrHX/58QaSeihyjGCIdudWSGyO20J
         odzo8/fLtSuIW141fDTIsnX9gzLyAD2IrFEvV6fIUXKsYg+SR7/YNw1YivTfov0sprtb
         CvEQ==
X-Gm-Message-State: AOJu0YwwV3DV8TQcCGnyfXvftiSBkmkIAySBV7t/lqOjKHkUGDbvlaBY
	fsjC87Q0o6Bd8HeSnEOt2fcdXxOZ6FaDrUaGkEZhtBtA6X1ysojeJlrm+4heiDE=
X-Gm-Gg: ASbGnctzFab3a3BZN3OdOO3VscZHUjMXFlS/OlXVKVZoGVCHBcfSVbTYMJ5tUZd0y/z
	B+tE7Vm+fYyz+Yp3bR8z0fZWKySqEIMtKxl47wCyInpAulw4WUbgVDXLUKAFKL/Ue0yUMgmBy61
	M99kqhrTAD198Harv/P+FtKJcZ6DZaZ4wI+RnfVme4EpJrhmYLrP6RytAwVrA1RkfjT7SN7zeIN
	ACIrGXgw4scKCISKR/IxKDVZ8jrpSXxP5S4NCo=
X-Google-Smtp-Source: AGHT+IEVsSyge0hlsqLKSXQnJjT66F6q76H1RjCL464wlIUHeCszPf0MguTDgwZsPR3UpdsdXLfn6A==
X-Received: by 2002:a17:907:784d:b0:aa5:2575:e76a with SMTP id a640c23a62f3a-aa580f2bc6cmr106215266b.13.1732689804632;
        Tue, 26 Nov 2024 22:43:24 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f044dsm667437166b.46.2024.11.26.22.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 22:43:24 -0800 (PST)
Date: Wed, 27 Nov 2024 06:45:57 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 4/6] selftests/bpf: Add tests for fd_array_cnt
Message-ID: <Z0bAJcd0oH4vHVcS@eis>
References: <20241119101552.505650-1-aspsk@isovalent.com>
 <20241119101552.505650-5-aspsk@isovalent.com>
 <CAEf4BzbnAT1v5aEdDtvkOC5hf6bqgnZmmjygHd_5j_dnxv1dZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbnAT1v5aEdDtvkOC5hf6bqgnZmmjygHd_5j_dnxv1dZw@mail.gmail.com>

On 24/11/26 10:54AM, Andrii Nakryiko wrote:
> On Tue, Nov 19, 2024 at 2:13 AM Anton Protopopov <aspsk@isovalent.com> wrote:
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
> >
> >   * fd_array_cnt/fd-array-2big: pass too large array
> >
> > All the tests above are using the bpf(2) syscall directly,
> > no libbpf involved.
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  .../selftests/bpf/prog_tests/fd_array.c       | 381 ++++++++++++++++++
> >  1 file changed, 381 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_array.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/fd_array.c b/tools/testing/selftests/bpf/prog_tests/fd_array.c
> > new file mode 100644
> > index 000000000000..1b47386e66c3
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/fd_array.c
> > @@ -0,0 +1,381 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +
> > +#include <linux/btf.h>
> > +#include <sys/syscall.h>
> > +#include <bpf/bpf.h>
> > +
> > +#include "../test_btf.h"
> > +
> > +static inline int _bpf_map_create(void)
> > +{
> > +       static union bpf_attr attr = {
> > +               .map_type = BPF_MAP_TYPE_ARRAY,
> > +               .key_size = 4,
> > +               .value_size = 8,
> > +               .max_entries = 1,
> > +       };
> > +
> > +       return syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
> > +}
> 
> libbpf provides bpf_map_create() API. Please use that (and make sure
> it supports the new field as well), don't re-define your own wrappers.

Thanks, ack (for here and your comments below)

> 
> > +
> > +static int _btf_create(void)
> > +{
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
> > +       static union bpf_attr attr = {
> > +               .btf_size = sizeof(raw_btf),
> > +       };
> > +
> > +       attr.btf = (long)&raw_btf;
> > +
> > +       return syscall(__NR_bpf, BPF_BTF_LOAD, &attr, sizeof(attr));
> 
> ditto, libbpf provides low-level API wrappers for a reason, let's tick to them
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
> > +static int __load_test_prog(int map_fd, int *fd_array, int fd_array_cnt)
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
> > +       union bpf_attr attr = {
> > +               .prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
> > +               .insns     = ptr_to_u64(insns),
> > +               .insn_cnt  = ARRAY_SIZE(insns),
> > +               .license   = ptr_to_u64("GPL"),
> > +               .fd_array = ptr_to_u64(fd_array),
> > +               .fd_array_cnt = fd_array_cnt,
> > +       };
> > +
> > +       return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
> 
> bpf_prog_load() API
> 
> > +}
> > +
> > +static int load_test_prog(int *fd_array, int fd_array_cnt)
> > +{
> > +       int map_fd;
> > +       int ret;
> > +
> > +       map_fd = _bpf_map_create();
> > +       if (!ASSERT_GE(map_fd, 0, "_bpf_map_create"))
> > +               return map_fd;
> > +
> > +       ret = __load_test_prog(map_fd, fd_array, fd_array_cnt);
> > +       close(map_fd);
> > +
> > +       /* switch back to returning the actual value */
> > +       if (ret < 0)
> > +               return -errno;
> > +       return ret;
> > +}
> > +
> 
> [...]

