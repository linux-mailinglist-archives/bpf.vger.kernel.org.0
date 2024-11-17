Return-Path: <bpf+bounces-45053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8251E9D0646
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 22:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FFA2820B6
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 21:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D9F1DDA39;
	Sun, 17 Nov 2024 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="WdELKkRV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9388F1DD86E
	for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731878850; cv=none; b=L31VzJQsH0aGHb+rEcUmvmN0xL5RgZZkbfPw4V6GO9yr2paYF0sqU77+AQOYOLABpwXgQRodW4UxFfeQzIyiZLm8Y7fpnQQna1YEhHP9nYPRp/JfUNb8F26+c+TXonEQVpNzjeRjNvrmmXPIDjLD+XiGEjWsrLJUNHcoQcG8dM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731878850; c=relaxed/simple;
	bh=R245TqSjsvh5+lUXXJgex0hSvWwFajBBrSotBzwy/kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWVwwYlndaE4q8RQJ/mod6PMnBIYp9yo8PZvqsWQ6Q6PzJGDwfrrmedfwWg8eefpIseTymXrtGNhWi+cignZgNJ3+jx98i7Eq1AxaEdyZva8z4oR4EAdNnlbssQOXlZApptmeCem2b9WybF4XMPTkQa1pUESZ+1cWY+JEX0G0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=WdELKkRV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso19666915e9.3
        for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 13:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1731878845; x=1732483645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IBhQzgA/0h0FbJ17bVvEpfiFxjXHLd19apX1blqOUow=;
        b=WdELKkRVjz3Ta7q79T2RoJXXrtjuI8kXbGNkm7BVDQnye94M+wuwFYP+EwDJulvLWb
         xMYSaz6pVF9V2P2sr0oNaMYo1O0HnINr5ynyVx1MGsYc4P/qJbMRzdwjy4xDi9IBBaJ6
         rx6KMPkKfF9cBdeb/6SorQGlkZM9BRZ8KewlTkjeqd1WgM9yRneo6vL9qG5I9mIA2C4m
         CJmD/Q/NrQz/m9XpWYrIDMoh0EWUY/0w7NnfP+j+5A0/0WU9dIYloVGRZ+oV1qRKkiNl
         ZQ3qVCe9uNs6Lkohahyw2dnMSBQ/KVcvzQnYHLAKWLHteHjsCYe6OqWRMjKNY2U51ryK
         k51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731878845; x=1732483645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBhQzgA/0h0FbJ17bVvEpfiFxjXHLd19apX1blqOUow=;
        b=IV3h05L5Tp5+Tc7HND1LilV6rLoWnOsjcfLP26Wv/kjghs97nM5ouwf/5KIjAxCO/6
         v5lbq+AGdDwAJpY6vZ3oTAm12jR6r9zaaM2KuKcnDrBtvm9l6ftdTxqAKzr7gdAYj0jl
         WHphMU/z1IobtuM0D1BYw85NxhMGuAFf8I6f7UZST1JwNLR1HGb1cFQ0Qt93Q48qcQyi
         WnvrP+J8yrIMV8mj5dCoZVtZNqQiGXULfuserGrElo82SO4ztvtP7GH/YKxzpGp9GYRH
         ENGNhlAqN9MosueGKSeKUdxC83tco7Z/5klCAeaNEwHphNCrDucqo7CMBdbVHuKCAxGy
         f0pg==
X-Gm-Message-State: AOJu0YwApqmW8U6lJ4nN0+nKUr9CVbmfAgdFWVWJ9gOD5dPsw72tV126
	NwSLYz0f1dREob9Q2h7KdjIwxJ3ustzeGbdnQaYh8z9l7sZ+2kb+NKOlVGCfCi2ITlHY9nj15ND
	A
X-Google-Smtp-Source: AGHT+IH9UDQEX18PDnn3mB0dfxk7azK2n7Jg/OEsiQQpD8mBx+2sU3SJ6oKEe/1UWuJb8XzplTbuSQ==
X-Received: by 2002:a05:600c:1e89:b0:431:5863:4240 with SMTP id 5b1f17b1804b1-432df78e296mr81189105e9.24.1731878844913;
        Sun, 17 Nov 2024 13:27:24 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac223e6sm131912985e9.43.2024.11.17.13.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 13:27:24 -0800 (PST)
Date: Sun, 17 Nov 2024 21:30:22 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Add tests for fd_array_cnt
Message-ID: <ZzpgbsM7j1Z4fE05@eis>
References: <20241115004607.3144806-1-aspsk@isovalent.com>
 <20241115004607.3144806-5-aspsk@isovalent.com>
 <d4a2099893f2cf3c2a97fd1960b269a0850dcf50.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4a2099893f2cf3c2a97fd1960b269a0850dcf50.camel@gmail.com>

On 24/11/15 07:06PM, Eduard Zingerman wrote:
> On Fri, 2024-11-15 at 00:46 +0000, Anton Protopopov wrote:
> 
> [...]
> 
> > @@ -0,0 +1,374 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +
> > +#include <linux/btf.h>
> > +#include <sys/syscall.h>
> > +#include <bpf/bpf.h>
> > +
> > +static inline int _bpf_map_create(void)
> > +{
> > +	static union bpf_attr attr = {
> > +		.map_type = BPF_MAP_TYPE_ARRAY,
> > +		.key_size = 4,
> > +		.value_size = 8,
> > +		.max_entries = 1,
> > +	};
> > +
> > +	return syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
> > +}
> > +
> > +#define BTF_INFO_ENC(kind, kind_flag, vlen) \
> > +	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
> > +#define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or_type)
> > +#define BTF_INT_ENC(encoding, bits_offset, nr_bits) \
> > +	((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
> > +#define BTF_TYPE_INT_ENC(name, encoding, bits_offset, bits, sz) \
> > +	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_INT, 0, 0), sz), \
> > +	BTF_INT_ENC(encoding, bits_offset, bits)
> 
> Nit: these macro are already defined in tools/testing/selftests/bpf/test_btf.h .

Ok, right, I will move them to some common place in v2.

> > +
> > +static int _btf_create(void)
> > +{
> > +	struct btf_blob {
> > +		struct btf_header btf_hdr;
> > +		__u32 types[8];
> > +		__u32 str;
> > +	} raw_btf = {
> > +		.btf_hdr = {
> > +			.magic = BTF_MAGIC,
> > +			.version = BTF_VERSION,
> > +			.hdr_len = sizeof(struct btf_header),
> > +			.type_len = sizeof(__u32) * 8,
> > +			.str_off = sizeof(__u32) * 8,
> > +			.str_len = sizeof(__u32),
> 
> Nit: offsetof(struct btf_blob, str), sizeof(raw_btf.str), sizeof(raw_btf.types)
>      are legal in this position.

Ok, thanks. (I've copy-pasted this part from some other test, will
change the similar code at the source as well then.)

> > +		},
> > +		.types = {
> > +			/* long */
> > +			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 64, 8),  /* [1] */
> > +			/* unsigned long */
> > +			BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),  /* [2] */
> > +		},
> > +	};
> > +	static union bpf_attr attr = {
> > +		.btf_size = sizeof(raw_btf),
> > +	};
> > +
> > +	attr.btf = (long)&raw_btf;
> > +
> > +	return syscall(__NR_bpf, BPF_BTF_LOAD, &attr, sizeof(attr));
> > +}
> 
> [...]
> 
> > +static void check_fd_array_cnt__fd_array_ok(void)
> > +{
> > +	int extra_fds[128];
> > +	__u32 map_ids[16];
> > +	__u32 nr_map_ids;
> > +	int prog_fd;
> > +
> > +	extra_fds[0] = _bpf_map_create();
> > +	if (!ASSERT_GE(extra_fds[0], 0, "_bpf_map_create"))
> > +		return;
> > +	extra_fds[1] = _bpf_map_create();
> > +	if (!ASSERT_GE(extra_fds[1], 0, "_bpf_map_create"))
> > +		return;
> > +	prog_fd = load_test_prog(extra_fds, 2);
> > +	if (!ASSERT_GE(prog_fd, 0, "BPF_PROG_LOAD"))
> > +		return;
> > +	nr_map_ids = ARRAY_SIZE(map_ids);
> > +	if (!check_expected_map_ids(prog_fd, 3, map_ids, &nr_map_ids))
> 
> Nit: should probably close prog_fd and extra_fds (and in tests below).

Ah, thanks! I will also check the other tests in this file for the
same bugs.

> 
> > +		return;
> > +
> > +	/* maps should still exist when original file descriptors are closed */
> > +	close(extra_fds[0]);
> > +	close(extra_fds[1]);
> > +	if (!ASSERT_EQ(map_exists(map_ids[0]), true, "map_ids[0] should exist"))
> > +		return;
> > +	if (!ASSERT_EQ(map_exists(map_ids[1]), true, "map_ids[1] should exist"))
> > +		return;
> > +
> > +	close(prog_fd);
> > +}
> 
> [...]
> 

