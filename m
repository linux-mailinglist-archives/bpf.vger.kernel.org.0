Return-Path: <bpf+bounces-75202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B9AC76A22
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 00:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CE194E2EE0
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 23:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832142F39C7;
	Thu, 20 Nov 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyyvUt+S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7418C19E97A
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763682000; cv=none; b=hb24BLpf0jJErhL0Dtf41rJlL7wLDz8G/a8EqYv1O7RdSQNeSifNou0lsumScTjkc+KhVXN8x0wGTu+mYleJWKxBv5oZIjRO7IOAq1xErbXtPAM8d7xmvQWaG70rNgTVf7HXLt6pqXtr+U2LmfWEnRwySxX2SvY+Xyh7673uVdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763682000; c=relaxed/simple;
	bh=it8K7fKDxsR0fLTFkbbsuy115Bipn4DKeKkk3LYv9bQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tbiNOR9rlAJ451JwZdKy6drZhMYfGbdfHHEFdmM0kldtesMrtJiBVkUBAmNhIhG/2gjcFthqsnPDDFOSYRQGhGx2priqSyg3SvqcByzB95wzmWF/VypmZte81CH3IoUlDbs3WysClDuMA5qVlRP05/R6Me+Yei/+lDqRrYODuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyyvUt+S; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so1359242b3a.3
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 15:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763681998; x=1764286798; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/R+I+rLo7v2duLjKRhWjlNirU962QuaOFI4CZRCNOZg=;
        b=EyyvUt+SKHn5wNoiB+KxrVOhfC0EFj40Zeot805+IpGdVSxMO4ZYdLJ9Bl84o1Gflk
         QpbVnw45KN2WAQvnxeF410smABkDDpAyTvINB6Vi79vvdqbChsRCUT2cYG+2GtDYHPET
         H5vsJquZoFLN6F3QSf4sIAO5qeJy5H7DcF2Ac0dKpv6Mx9KpNR4mqpEH5wp5buIoRJwf
         AzF6kbnkdVYb5dLbxhbGoFdDiwwa/YTqnAMA2003+MzaXjnXFqgTaRHzvv2IN/Y2HUHE
         xotNTjSoPNFTrwR8QqqNoagZAwwhkqIScVg4cRydu6xJSSAKcNNlsIWmAR3WSnIZ6D9m
         VFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763681998; x=1764286798;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/R+I+rLo7v2duLjKRhWjlNirU962QuaOFI4CZRCNOZg=;
        b=gj8wSUkSqa54q28L2U3Nzcn/H47OUDBtpqNzpk1aa882XO4nJeC5RPc4RX7Usiyhpg
         Z7jgRJo8gyG8i5MSGEyC8cff7X3na+BW3gMoTpvSKuELiWyNHYryW7F0/CD6ap/T8VZD
         nx2h+v+YpczsVRi6Me/XgBtXRoB2c7vzng0GBLQOwnjTsTjcw//4HS+6qVtP0il2Pytr
         AdQYC/LCURpvoot0QBhglYSO1uc8FzBlPa7Upc/eA71jM/rKG74MzsPPs1auuK6N5lH7
         Sc4GXjsSJYJlSbCyZOMOuTL0PROJDVjzhMZ9ofTBc0T6JAe2nPv2OH8PPQwuQrTuRkmW
         j3mw==
X-Forwarded-Encrypted: i=1; AJvYcCUvQG1xspHzy3RUn65PpP5nkPnmNvEnfC/R1vjwwdvchX8rY3juwp+uT5O6g9lVmGTENzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoziJ8mP/PJ/p5BxMl6QR/a3ZiyMMB0at+RM/U1ovUlMD+WiF5
	4wTrXeTytQLRlQ07Mmeum0dczc4uZMQwkWyS72M8HFaH7yyGyX+V72y2
X-Gm-Gg: ASbGnctT0mFYMfqg/frvG7xNLpAqfUeH+yt4bWEInLDBgCFj+zbtDlGIhs/7K5bAgOW
	/vkfhxFRC2AAWSoJ2AyFWQEBZSendr0U4tvI84YkX5FXLJHmsw8HCgTyciYvrmuq3oVxCtV09B2
	R6X+C/QHj+YN1eeEbwninjwnO9GUlDKp62mMI30TFLMmCXGoyIEOmwFxtjgnQujvhggSL+txIu6
	FToMB2qJ5H85jyF+GSIf/4UbBirtvpt3sv5XbcnAn2cijXDepUzmVZBVfbXYS8ptKShP4/lbXHV
	EG+jk55OXEhDrHmqmAqda1rOcgrEKUyHt+YYFSbNwPPafAordZS1ohJiAfBJm3etEPDPmYq6+do
	6/9CZLyf86gQ2fJYMhVXqtmi6VM1cY5Kb+zPIKzzJNWlejL8S2GPrAbOmBi6lGGwos4+lZ2l5LU
	NzjDsRwZMcqtST2iNzDE9v2cRsxs/5mYZoUsY=
X-Google-Smtp-Source: AGHT+IHXcLfEpzcLUq8CEzZvMaPdzjLANpfGtvn5idZcnIt7ABGAQP+Ut/iJWOqrME44Yy7RNt/Knw==
X-Received: by 2002:a05:6a00:2d02:b0:7a2:882b:61b7 with SMTP id d2e1a72fcca58-7c58eb01a7fmr18658b3a.32.1763681997684;
        Thu, 20 Nov 2025 15:39:57 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:6e69:e358:27f9:ac0? ([2620:10d:c090:500::5:61f3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0d65682sm3945924b3a.56.2025.11.20.15.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 15:39:57 -0800 (PST)
Message-ID: <fdeda8c6ec282fae793799bf5546d7e3b0578e1a.camel@gmail.com>
Subject: Re: [RFC PATCH v7 2/7] selftests/bpf: Add test cases for
 btf__permute functionality
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org,  Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire
 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>
Date: Thu, 20 Nov 2025 15:39:55 -0800
In-Reply-To: <20251119031531.1817099-3-dolinux.peng@gmail.com>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
	 <20251119031531.1817099-3-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-19 at 11:15 +0800, Donglin Peng wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/tools=
/testing/selftests/bpf/prog_tests/btf_permute.c
> new file mode 100644
> index 000000000000..f67bf89519b3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
> @@ -0,0 +1,608 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Xiaomi */
> +
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include "btf_helpers.h"
> +
> +/* Ensure btf__permute work as expected with base BTF */
> +static void test_permute_base(void)
> +{
> +	struct btf *btf;
> +	__u32 permute_ids[6];
> +	int start_id =3D 1;
> +	int err;
> +
> +	btf =3D btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf, "empty_main_btf"))
> +		return;
> +
> +	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);	/* [1] int */
> +	btf__add_ptr(btf, 1);				/* [2] ptr to int */
> +	btf__add_struct(btf, "s1", 4);			/* [3] struct s1 { */
> +	btf__add_field(btf, "m", 1, 0, 0);		/*       int m; */
> +							/* } */
> +	btf__add_struct(btf, "s2", 4);			/* [4] struct s2 { */
> +	btf__add_field(btf, "m", 1, 0, 0);		/*       int m; */
> +							/* } */
> +	btf__add_func_proto(btf, 1);			/* [5] int (*)(int *p); */
> +	btf__add_func_param(btf, "p", 2);
> +	btf__add_func(btf, "f", BTF_FUNC_STATIC, 5);	/* [6] int f(int *p); */
> +
> +	VALIDATE_RAW_BTF(
> +		btf,
> +		"[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED=
",
> +		"[2] PTR '(anon)' type_id=3D1",
> +		"[3] STRUCT 's1' size=3D4 vlen=3D1\n"
> +		"\t'm' type_id=3D1 bits_offset=3D0",
> +		"[4] STRUCT 's2' size=3D4 vlen=3D1\n"
> +		"\t'm' type_id=3D1 bits_offset=3D0",
> +		"[5] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> +		"\t'p' type_id=3D2",
> +		"[6] FUNC 'f' type_id=3D5 linkage=3Dstatic");
> +
> +	permute_ids[1 - start_id] =3D 4; /* [1] -> [4] */
> +	permute_ids[2 - start_id] =3D 3; /* [2] -> [3] */
> +	permute_ids[3 - start_id] =3D 5; /* [3] -> [5] */
> +	permute_ids[4 - start_id] =3D 1; /* [4] -> [1] */
> +	permute_ids[5 - start_id] =3D 6; /* [5] -> [6] */
> +	permute_ids[6 - start_id] =3D 2; /* [6] -> [2] */
> +	err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
> +	if (!ASSERT_OK(err, "btf__permute_base"))
> +		goto done;
> +
> +	VALIDATE_RAW_BTF(
> +		btf,
> +		"[1] STRUCT 's2' size=3D4 vlen=3D1\n"
> +		"\t'm' type_id=3D4 bits_offset=3D0",
> +		"[2] FUNC 'f' type_id=3D6 linkage=3Dstatic",
> +		"[3] PTR '(anon)' type_id=3D4",
> +		"[4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED=
",
> +		"[5] STRUCT 's1' size=3D4 vlen=3D1\n"
> +		"\t'm' type_id=3D4 bits_offset=3D0",
> +		"[6] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1\n"
> +		"\t'p' type_id=3D3");
> +
> +	/*
> +	 * For base BTF, id_map_cnt must equal to the number of types
> +	 * include VOID type
> +	 */
> +	permute_ids[1 - start_id] =3D 4; /* [1] -> [4] */
> +	permute_ids[2 - start_id] =3D 3; /* [2] -> [3] */
> +	permute_ids[3 - start_id] =3D 5; /* [3] -> [5] */
> +	permute_ids[4 - start_id] =3D 1; /* [4] -> [1] */
> +	permute_ids[5 - start_id] =3D 6; /* [5] -> [6] */
> +	permute_ids[6 - start_id] =3D 2; /* [6] -> [2] */
> +	err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids) - 1, NUL=
L);
> +	if (!ASSERT_ERR(err, "btf__permute_base"))
> +		goto done;
> +
> +	VALIDATE_RAW_BTF(
> +		btf,
> +		"[1] STRUCT 's2' size=3D4 vlen=3D1\n"
> +		"\t'm' type_id=3D4 bits_offset=3D0",
> +		"[2] FUNC 'f' type_id=3D6 linkage=3Dstatic",
> +		"[3] PTR '(anon)' type_id=3D4",
> +		"[4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED=
",
> +		"[5] STRUCT 's1' size=3D4 vlen=3D1\n"
> +		"\t'm' type_id=3D4 bits_offset=3D0",
> +		"[6] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1\n"
> +		"\t'p' type_id=3D3");
> +
> +	/* Multiple types can not be mapped to the same ID */
> +	permute_ids[1 - start_id] =3D 4;
> +	permute_ids[2 - start_id] =3D 4;
> +	permute_ids[3 - start_id] =3D 5;
> +	permute_ids[4 - start_id] =3D 1;
> +	permute_ids[5 - start_id] =3D 6;
> +	permute_ids[6 - start_id] =3D 2;
> +	err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
> +	if (!ASSERT_ERR(err, "btf__permute_base"))
> +		goto done;

Nit: Maybe extract the VALIDATE_RAW_BTF as a function, so that it is
     not repeated? Otherwise it is a bit harder to tell that you are
     checking for BTF to be intact if error is returned.
     Same for the test_permute_split() case.

> +
> +	VALIDATE_RAW_BTF(
> +		btf,
> +		"[1] STRUCT 's2' size=3D4 vlen=3D1\n"
> +		"\t'm' type_id=3D4 bits_offset=3D0",
> +		"[2] FUNC 'f' type_id=3D6 linkage=3Dstatic",
> +		"[3] PTR '(anon)' type_id=3D4",
> +		"[4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED=
",
> +		"[5] STRUCT 's1' size=3D4 vlen=3D1\n"
> +		"\t'm' type_id=3D4 bits_offset=3D0",
> +		"[6] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1\n"
> +		"\t'p' type_id=3D3");

[...]

