Return-Path: <bpf+bounces-45010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEA79CFC72
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 04:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B721B27D2D
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 03:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4128F15381A;
	Sat, 16 Nov 2024 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYD49l0a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D70963D
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 03:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731726408; cv=none; b=gR6YIv2hm6eAMracCiH+UdDre4wEpyA8Kstx/kL9kftjKGOPo5QWrdAgbyjvaHYuB/TGddyJrhD1OmTcsIv0NIBA8qoWjKMjk2L/AP4u1P7AS8zcE0BndlCVw9+7XF3YvjpVaOdILjtDStOTGWWBp6BuSIg9cu7jmGRfO2+D6eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731726408; c=relaxed/simple;
	bh=MktqgCK4TI4U0zEww7WNWXFM2LD+ANGUXOVRofffjdU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iYarCc7Wn13xDDOjqxWv3gaNiKu3+S7jkrEkVny818dplb4yIxdKeyMMcmb2rpztkWLzfoDP2yC+EdIp3Q2TYhN3lEL1JN9jdf5kTqX0NWOM3MtqJlrl45vX6wfLjuW96Suc5Thgx0kZlluEJ7aPm0c1gvqX3yLvhO8dOV7Nllc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYD49l0a; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7eab7622b61so1806817a12.1
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 19:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731726406; x=1732331206; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGGML6BmwoYTxYFIwg8+FbXi0p7QXI0RJRD6TkaagYk=;
        b=SYD49l0abitczG4wzOn7qTjPdfRxTglbDQeKk4HK0HhpUCwGkeUCjbW+zt8IWMvIG+
         7Q8M/v1GhiGqP6Itknjqlbp3pd2I5Zg9vD/LtWtzu2a2z0c7eAN4KWk/o7AJlXPiEmdQ
         h/roSTezZibswx4nGwdgHJ4ay7+57XSN6bWhElc2gV1KPPnSI/3ofVyc/udUvMkd8mPb
         1mtifnJmcDvz93vNd+wWLu15MvVMdXE/MMSJH2dm77ns8nxSBF3mKScuyYYq4iNH2TBM
         cPPnShLizZeSdGIbD7c/dcloRbzeUhxeYBCjEGgrpBBJBIXPaike+o/T0dserkVZVfIF
         HjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731726406; x=1732331206;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qGGML6BmwoYTxYFIwg8+FbXi0p7QXI0RJRD6TkaagYk=;
        b=LgJGVgRwSKvABo604AJ/PX/QoSOWkwBRqW6WGqD1i1/WpQ1z7KdmUV2SOOQwIYwV9f
         JErTXkOYDFy39cXs6SLdMARRHQL12OgyBOIAAk70w6PQ8Fxyt+z0KejInqfNOIjYIW4q
         mgwVc1JIAjXgnqjV6NdkGJdwQD0Zayz2cwm7uwakfYlNy4whScXJ4jn0sKMajeuxZntO
         GpP2ug/j6X/+Exy1cWnd3fpvCX/4aWF+Zfm48TMk4vhOV2lBh0BC0Ovq/g0KQjD3RUmr
         5hw96ciuTfz4z18HxblsuGUzq2SaWpL5obnONxiOH9WAL8AE9Mu9dad3derjaQ9vSiTJ
         mpiA==
X-Forwarded-Encrypted: i=1; AJvYcCVeaHmnHR0IbgnVT/iFQY/HST44QDLX7Xo3GRzvHkF2uTwyVYJZTN24NXk4BPOkXucbUyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGRISzoPCchE9MQQn/ykR0RCcGvlyoAzwKzbr8ssMcg5xH4ofJ
	IfXgrnTrMmZ+xrLyyfSKnlcM/xJTqbGsAbf+6iQooB5Hf7GineP4
X-Google-Smtp-Source: AGHT+IHkHY6gVBv1AReDU37EHQ8vVvKdxZ6UCfKncGKiQz9ctBrf24SMxA2fPdSGmCUKoKaEEAQcGA==
X-Received: by 2002:a05:6a20:12ca:b0:1db:eff0:6ae7 with SMTP id adf61e73a8af0-1dc90bae872mr5756373637.33.1731726406579;
        Fri, 15 Nov 2024 19:06:46 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c63ddfsm2008681a12.46.2024.11.15.19.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 19:06:46 -0800 (PST)
Message-ID: <d4a2099893f2cf3c2a97fd1960b269a0850dcf50.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Add tests for fd_array_cnt
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <aspsk@isovalent.com>, bpf@vger.kernel.org
Date: Fri, 15 Nov 2024 19:06:41 -0800
In-Reply-To: <20241115004607.3144806-5-aspsk@isovalent.com>
References: <20241115004607.3144806-1-aspsk@isovalent.com>
	 <20241115004607.3144806-5-aspsk@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-15 at 00:46 +0000, Anton Protopopov wrote:

[...]

> @@ -0,0 +1,374 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +
> +#include <linux/btf.h>
> +#include <sys/syscall.h>
> +#include <bpf/bpf.h>
> +
> +static inline int _bpf_map_create(void)
> +{
> +	static union bpf_attr attr =3D {
> +		.map_type =3D BPF_MAP_TYPE_ARRAY,
> +		.key_size =3D 4,
> +		.value_size =3D 8,
> +		.max_entries =3D 1,
> +	};
> +
> +	return syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
> +}
> +
> +#define BTF_INFO_ENC(kind, kind_flag, vlen) \
> +	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
> +#define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or_=
type)
> +#define BTF_INT_ENC(encoding, bits_offset, nr_bits) \
> +	((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
> +#define BTF_TYPE_INT_ENC(name, encoding, bits_offset, bits, sz) \
> +	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_INT, 0, 0), sz), \
> +	BTF_INT_ENC(encoding, bits_offset, bits)

Nit: these macro are already defined in tools/testing/selftests/bpf/test_bt=
f.h .

> +
> +static int _btf_create(void)
> +{
> +	struct btf_blob {
> +		struct btf_header btf_hdr;
> +		__u32 types[8];
> +		__u32 str;
> +	} raw_btf =3D {
> +		.btf_hdr =3D {
> +			.magic =3D BTF_MAGIC,
> +			.version =3D BTF_VERSION,
> +			.hdr_len =3D sizeof(struct btf_header),
> +			.type_len =3D sizeof(__u32) * 8,
> +			.str_off =3D sizeof(__u32) * 8,
> +			.str_len =3D sizeof(__u32),

Nit: offsetof(struct btf_blob, str), sizeof(raw_btf.str), sizeof(raw_btf.ty=
pes)
     are legal in this position.

> +		},
> +		.types =3D {
> +			/* long */
> +			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 64, 8),  /* [1] */
> +			/* unsigned long */
> +			BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),  /* [2] */
> +		},
> +	};
> +	static union bpf_attr attr =3D {
> +		.btf_size =3D sizeof(raw_btf),
> +	};
> +
> +	attr.btf =3D (long)&raw_btf;
> +
> +	return syscall(__NR_bpf, BPF_BTF_LOAD, &attr, sizeof(attr));
> +}

[...]

> +static void check_fd_array_cnt__fd_array_ok(void)
> +{
> +	int extra_fds[128];
> +	__u32 map_ids[16];
> +	__u32 nr_map_ids;
> +	int prog_fd;
> +
> +	extra_fds[0] =3D _bpf_map_create();
> +	if (!ASSERT_GE(extra_fds[0], 0, "_bpf_map_create"))
> +		return;
> +	extra_fds[1] =3D _bpf_map_create();
> +	if (!ASSERT_GE(extra_fds[1], 0, "_bpf_map_create"))
> +		return;
> +	prog_fd =3D load_test_prog(extra_fds, 2);
> +	if (!ASSERT_GE(prog_fd, 0, "BPF_PROG_LOAD"))
> +		return;
> +	nr_map_ids =3D ARRAY_SIZE(map_ids);
> +	if (!check_expected_map_ids(prog_fd, 3, map_ids, &nr_map_ids))

Nit: should probably close prog_fd and extra_fds (and in tests below).

> +		return;
> +
> +	/* maps should still exist when original file descriptors are closed */
> +	close(extra_fds[0]);
> +	close(extra_fds[1]);
> +	if (!ASSERT_EQ(map_exists(map_ids[0]), true, "map_ids[0] should exist")=
)
> +		return;
> +	if (!ASSERT_EQ(map_exists(map_ids[1]), true, "map_ids[1] should exist")=
)
> +		return;
> +
> +	close(prog_fd);
> +}

[...]


