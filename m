Return-Path: <bpf+bounces-32326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 764AD90B93A
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFD31F25799
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 18:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF69A198A03;
	Mon, 17 Jun 2024 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHXf6PAV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4657197A82;
	Mon, 17 Jun 2024 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647972; cv=none; b=EWKEGAe7R0i+JJ6PpYTXD9gZVPJTsWCsnSW7nw5tCOTaN95tPv4M2nYs+K8R1QF+hH0UZQ39TdiuUzQSHO5PukOPgZgggRyXZHPLkrzkI6QJ6Dpno0oBo7I2UhH0lHe6BF1jHjphW4aOxrLus18Ha3pvdwtu6uvvWoGORGE8YyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647972; c=relaxed/simple;
	bh=z89m5L8BkCQNCX6Mp7ZeLOcjqhDyZ14R0EcGuO9k1t4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bj/+d/DnMarQnc3yufCuiBrLZfmfJN7NrnFWdmD/HDzaLNLdJZk0CUqvIoHF77chXjYNaTx6KYX1n/Cc6E2AAmuOsJR3opG4rTkQ44+HAwnl2+kYXNJHuh2MFoj6POR3WskdgRJNIXoCLPCKS1cwSaE/LF8ZJBvs+iZUCFxFoSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHXf6PAV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f700e4cb92so39916715ad.2;
        Mon, 17 Jun 2024 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718647970; x=1719252770; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iBOhF51JaKc1Fvw8WfRcyeNBVWLdpct6iiMQh0qswW4=;
        b=fHXf6PAVg+Bt/wkaDUJ01I8KA49ouy08dzZokX91M/ibUzqFTW0D4cs/9VdmyI3qog
         28Xo+3NnPLX/VRT6a1pTpEyVMJfl1Oj8IFUPR35ttjrsblkun/HfQkhC1Y3ZLvPHEpwm
         qT1B1mZ4z4KfdgVGAWSkcH/sPRIyS1EQCq6eS6Dsi97Jvr3E/AoVzTF5lBkYE0ovCukF
         n9rIGcp0iUGYlxAGnp1ww5DF8PWn76ntslytAw1sv2DzC0Z36owbbjoH+x/hgmVCVfo3
         I9jfGzqqyxraVnyUX5//j4oB0zberaHBj23H4Ox0kSWo4mn3MP3HZkL7dvrp8CGN+dES
         GjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647970; x=1719252770;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBOhF51JaKc1Fvw8WfRcyeNBVWLdpct6iiMQh0qswW4=;
        b=uM7NS+6QH4mB/8WML5xZsuToN1LdNmmDJsCEY97UuiYO95Q3CS3ywjsMonsBzT7R5j
         YI11bfaGgCrDlJedWS4d2iXbDCNfrkY7gVbo5dKkwEr4hzEe1YA7B04DPQKnY9Ojjhq1
         +Usa3I+xcVf85RNU4xAfFNhwIcW4wwp/Vn0A9lj6Lw/7BFpOUUUcW/o9iew5l16/fsXj
         jCVlCqZxqwL5wq7bjMeUtQ+15XZUJakddjVKo6ArmRGr+IG11EJAUA+RdJHd3j9uWc1/
         rKeYn7C2aV/RkkxGmtTLgv6V2gYRH773ZKpHU/W6yoJSYivPuj6TjwDpF8BWVDnuyk2q
         /F+g==
X-Forwarded-Encrypted: i=1; AJvYcCXFIjLwDitglGABsMOHMBJZthSO/0lqe0bPXBTKvSLe4mwYd4fCFhe6ckCs2NK/R9eyychl1X7+sLliUcMMMEyNyq9R5SwFCAVQi1OL9YksiNrRW6/uMNuYdYhbsx6tNd2c
X-Gm-Message-State: AOJu0Yw4bl2eDou5HCsjKA09kWEEcgI4aHmpvb7cgRZ4rXFufoZ5qcDv
	XtANVPtjgjGuvm+D8bxpq20GYMw1BRKzfi+t0MYU7XG2IhOZd5Um
X-Google-Smtp-Source: AGHT+IEMwdnfjlFWJdTDbL76rTSVZtVYE9oKBytXu6zHhpGRpLnwxUoClTfBz666j0leeghre60lGA==
X-Received: by 2002:a17:903:24f:b0:1f7:c52:1cc4 with SMTP id d9443c01a7336-1f8625c063emr145009225ad.5.1718647970031;
        Mon, 17 Jun 2024 11:12:50 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855eeebb1sm81975605ad.127.2024.06.17.11.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:12:49 -0700 (PDT)
Message-ID: <f4f51280bd0e83e04e7765e90081658e3ae975fd.camel@gmail.com>
Subject: Re: [PATCH] libbpf: checking the btf_type kind when fixing variable
 offsets
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: daniel@iogearbox.net, song@kernel.org, andrii@kernel.org,
 haoluo@google.com,  yonghong.song@linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 17 Jun 2024 11:12:44 -0700
In-Reply-To: <20240616002958.2095829-1-dolinux.peng@gmail.com>
References: <20240616002958.2095829-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-15 at 17:29 -0700, Donglin Peng wrote:
> I encountered an issue when building the test_progs using the repository[=
1]:
>=20
> $ clang --version
> Ubuntu clang version 17.0.6 (++20231208085846+6009708b4367-1~exp1~2023120=
8085949.74)
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
>=20
> $ pwd
> /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/
>=20
> $ make test_progs V=3D1
> ...
> /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/tools/sbin/b=
pftool
> gen object
> /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_def=
rag.bpf.linked2.o
> /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_def=
rag.bpf.linked1.o
> libbpf: failed to find symbol for variable 'bpf_dynptr_slice' in section
> '.ksyms'
> Error: failed to link
> '/work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_de=
frag.bpf.linked1.o':
> No such file or directory (2)
> make: *** [Makefile:656:
> /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_def=
rag.skel.h]
> Error 254
>=20
> After investigation, I found that the btf_types in the '.ksyms' section h=
ave a kind of
> BTF_KIND_FUNC instead of BTF_KIND_VAR:
>=20
> $ bpftool btf dump file ./ip_check_defrag.bpf.linked1.o
> ...
> [2] DATASEC '.ksyms' size=3D0 vlen=3D2
>         type_id=3D16 offset=3D0 size=3D0 (FUNC 'bpf_dynptr_from_skb')
>         type_id=3D17 offset=3D0 size=3D0 (FUNC 'bpf_dynptr_slice')
> ...
> [16] FUNC 'bpf_dynptr_from_skb' type_id=3D82 linkage=3Dextern
> [17] FUNC 'bpf_dynptr_slice' type_id=3D85 linkage=3Dextern
> ...
>=20
> To fix this, we can a add check for the kind.
>=20
> [1] https://github.com/eddyz87/bpf/tree/binsort-btf-dedup
> Link: https://lore.kernel.org/all/4f551dc5fc792936ca364ce8324c0adea38162f=
1.camel@gmail.com/
>=20
> Fixes: 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext suppo=
rt")
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---

Good catch, thank you for narrowing this down.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(Although, I agree with notes from Alan, having a comment would be good).

