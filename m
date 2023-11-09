Return-Path: <bpf+bounces-14583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E817E69E5
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 12:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FCF281382
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 11:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9C91C28F;
	Thu,  9 Nov 2023 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy7s6w+7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323E31A73B
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 11:47:49 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D9D19E
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 03:47:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9d2d8343dc4so129405166b.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 03:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699530467; x=1700135267; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Okv4iAPprpViExhW7Nl3CanFXOrYlvqAqr81C8dj3l8=;
        b=hy7s6w+7dImobuGTzoV6Gb+VJQLU6ICPvE2zMisRDR3H8IHz13FXnKzc6HpS+fVaQY
         1GJPMXhJy9NfB/Kg8lQLkpbX0Jd47dhPmK+bcPWcvo01ku79S7krcSDVlYlQ1yv/OJhW
         it8Mu9KAnTRKrvVH9SQwVkJJd99MBFPOCH8aGH5q3YaJtvE2nBzYNiigzUqXXl26UCRv
         6U+yt0tQc33Q3oqnpG3O+71KDJdAaL4GSkVsuzoXDK3Zo6rOISPZW7TrXOuourdrVgPG
         wGPEJFPnSX/k0Rk6COxjFBkKRI7NUpQwLijBYJtC6MbJjC9itJgHcGxfXddrvLp+3t4B
         n3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699530467; x=1700135267;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Okv4iAPprpViExhW7Nl3CanFXOrYlvqAqr81C8dj3l8=;
        b=OZXLH/lxiOdTV4g5pasCk/M8VmOLOtVMVtIENa3IIiQmz7KO6Q9uamco7gv/zgpgir
         +o1gwFeZuYSmH4r2grksPOW5tZcQKWyjsaO3mUTnKjkC0VyPEuRjE/le7il7j93NsHxt
         6RxYFWuiLe77KyyZ9/mqQTzztyCuUy84oC5HwaFIA331WypiqlTAfkbPEO5L4c52sSgM
         K+Nh9QdtybMJ50rZrnPdMGi4InFyrAz7q3T9lwcVi6yS3/thvtrnv1u1fFss0hAxeMSy
         WZLgLkLrEjJ048O/s56Q2M+Kc61pHBNGqrAm18wYZucdrIUJnJ4lkINkq3uTIk9PWt3+
         uHfw==
X-Gm-Message-State: AOJu0Yy0FjEK/Pu8ERnv2ZkOyBPC46RBcpqywtXLTsY9CFsb+VWPISAz
	FkfrEpXGdDr/BauLZU+twTQ=
X-Google-Smtp-Source: AGHT+IHTIFSy5l02rbNOZ2g8UqHMMzdVCzS8ZWKeCDJoBqTeaypZB2TrN/TRC3svsWAZauWTwBp8iQ==
X-Received: by 2002:a17:907:6e94:b0:9d1:73da:e4fc with SMTP id sh20-20020a1709076e9400b009d173dae4fcmr4093024ejc.73.1699530466611;
        Thu, 09 Nov 2023 03:47:46 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q8-20020a1709060e4800b009de61c89f6fsm2420223eji.1.2023.11.09.03.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:47:45 -0800 (PST)
Message-ID: <6bf022a8cfd8c821ec0a8370fa85bcfd806c8be7.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix pyperf180 compilation
 failure with llvm18
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Thu, 09 Nov 2023 13:47:44 +0200
In-Reply-To: <20231109053029.1403552-1-yonghong.song@linux.dev>
References: <20231109053029.1403552-1-yonghong.song@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-08 at 21:30 -0800, Yonghong Song wrote:
> With latest llvm18 (main branch of llvm-project repo), when building bpf =
selftests,
>     [~/work/bpf-next (master)]$ make -C tools/testing/selftests/bpf LLVM=
=3D1 -j
>=20
> The following compilation error happens:
>     fatal error: error in backend: Branch target out of insn range
>     ...
>     Stack dump:
>     0.      Program arguments: clang -g -Wall -Werror -D__TARGET_ARCH_x86=
 -mlittle-endian
>       -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include
>       -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/w=
ork/bpf-next/tools/include/uapi
>       -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include -idir=
after
>       /home/yhs/work/llvm-project/llvm/build.18/install/lib/clang/18/incl=
ude -idirafter /usr/local/include
>       -idirafter /usr/include -Wno-compare-distinct-pointer-types -DENABL=
E_ATOMICS_TESTS -O2 --target=3Dbpf
>       -c progs/pyperf180.c -mcpu=3Dv3 -o /home/yhs/work/bpf-next/tools/te=
sting/selftests/bpf/pyperf180.bpf.o
>     1.      <eof> parser at end of file
>     2.      Code generation
>     ...
>=20
> The compilation failure only happens to cpu=3Dv2 and cpu=3Dv3. cpu=3Dv4 i=
s okay
> since cpu=3Dv4 supports 32-bit branch target offset.
>=20
> The above failure is due to upstream llvm patch [1] where some inlining b=
ehavior
> are changed in llvm18.
>=20
> To workaround the issue, previously all 180 loop iterations are fully unr=
olled.
> Now, the fully unrolling count is changed to 90 for llvm18 and later. Thi=
s reduced
> some otherwise long branch target distance, and fixed the compilation fai=
lure.
>=20
>   [1] https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c=
607313a566eebb16e
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Can confirm, the issue is present on clang main w/o this patch and
disappears after this patch.

Yonghong, is there a way to keep original UNROLL_COUNT if cpuv4 is used?

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

