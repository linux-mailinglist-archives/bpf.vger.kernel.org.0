Return-Path: <bpf+bounces-40049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A0897B3D5
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 19:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966B928400E
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480C874068;
	Tue, 17 Sep 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0egb5HB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CB9200A3
	for <bpf@vger.kernel.org>; Tue, 17 Sep 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726595595; cv=none; b=VtgLHPeWWNaMYzf2L7EmcixExGDX6qhKfki82NgHBKj5y1kG0P05JN+BgH2pWFvSV7CYDD8Ptn1jmbwYHzgUl/eYZorsgMvzurjhFxUoIQEM7Xx1ZRch32LejWhHeKGrTDitnzCmXNLvvJNAQkJ4hMrU1iHsaw0DTmpkuUWP9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726595595; c=relaxed/simple;
	bh=Gqg7lPIoygATenk89nY/lBVzy4LAZSGjw8PGjtYSCSA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OGjFkZh0VumGx+ZaoYywcwDmD/KmlKHXWZCrlnD0I4D3laneHXScZOoKcpMCtEmivMrVGNo4JpZess8LJjJmPW8BaPWxVZGU9ZGRH8yiHpIno7bKuxr9MDxQPCwiAc3rEvlyvzM/Y4hUSrR8M/n59Jc/kmcllp48J/3AMTMVKAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0egb5HB; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7db238d07b3so4735408a12.2
        for <bpf@vger.kernel.org>; Tue, 17 Sep 2024 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726595594; x=1727200394; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UdR/KyCa6z7pTbS4F7tDsuB5dcYlP0jCNbK/Kuxy5fI=;
        b=V0egb5HB1kmnoXImVj/dLU6b+Jkdn+B9oTutiy4H5aU6aZITo3CdlCImd/uJzMDY1X
         IzGNBA7rZ8zoFgGdsZd38q3jKVJi64ELIXKMuXpissse8IBPhyC5SzGtEL6dkik1IhHo
         sGrMe8N/pv+7NgRwpu215YK/DN7Dw8I87KhyBhw5AKvA/BjYUnc3LSvfyWIq1fbZfqry
         ek2TXvpiGd9qbdTLLE0od8n4B49tm3yf7zqWrX9KHs6VX80p78zB4YCcpUGbNJxJZu9O
         8K4VYywyG3OTfDNiptuDPsV3L7AtSu6shcbLx8thEyMlZNvQ47QMTgr2c6pU+tlhfwSN
         EcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726595594; x=1727200394;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UdR/KyCa6z7pTbS4F7tDsuB5dcYlP0jCNbK/Kuxy5fI=;
        b=IeyyDovAj3zdHa1TB1SMMBD3xWbV26oTdR+PE5ND+LARN8Z2u4/JPbqF7vk7n4xkL2
         obxtkAQKfCOgZd+GRao/H6eDCJDNXRnmWZPyNFUV6q09+1ipX+Vs0Bo55OqC+XVlLHKV
         Xa1nT7UVQNtF55KwkYSUyG1SaH2jDgbH47Vz0Yn8RqSi12Z4cj4OtkHfiGRWoL5NxGU5
         bzDgzZ/7pZbgAJRFw4Kf+EDKSbF4tu6IWZ0pwYcuwIA7S2dSzu+juKtaApXjjJUsduyw
         D3scI9LmANBia6MvX5kWMqVUAnUI4HVJzIe5xl7x5/CS2awQc0WCGKYZC8HCj8nxr5E0
         hMBw==
X-Gm-Message-State: AOJu0Ywd0IoNUQzG2qUnBZxDB4TMD3cyKfuwVXgUaUel84TFqxtNriBz
	v5Ew6mXLsuJD4O2zdNiUgAjgOg/vu9Ni7ubRu/ixksgoGF0Zh+vn
X-Google-Smtp-Source: AGHT+IGZmzcklPwUb9QXwcPc0s7VC5kpUiFnYlFX34c9Y5Uf2NVrRInhO8EUs6z1uIrDK1M6GnpTJw==
X-Received: by 2002:a05:6a21:3a85:b0:1cf:2a35:6d21 with SMTP id adf61e73a8af0-1cf764ae838mr30628440637.45.1726595593728;
        Tue, 17 Sep 2024 10:53:13 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a98087sm5438144b3a.9.2024.09.17.10.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 10:53:12 -0700 (PDT)
Message-ID: <66f06b3323d17ddff2534649306be9f86aa60b5b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: set vpath in Makefile to
 search for skels
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net,  mykolal@fb.com, bjorn@kernel.org
Date: Tue, 17 Sep 2024 10:53:03 -0700
In-Reply-To: <p_YHaXjA1ci8khO7PzqJph62Huednrj7sb4zUJLrAaLUuZin6wKAJoqSl2Z32FIJs05h7FdiFHK1t4tkUem1J1ZEuD_99APjQ8zKlfOZNjs=@pm.me>
References: <20240916195919.1872371-1-ihor.solodrai@pm.me>
	 <20240916195919.1872371-2-ihor.solodrai@pm.me>
	 <dbf5eb3056eabbd44775d526a64b53e1a43b9f59.camel@gmail.com>
	 <p_YHaXjA1ci8khO7PzqJph62Huednrj7sb4zUJLrAaLUuZin6wKAJoqSl2Z32FIJs05h7FdiFHK1t4tkUem1J1ZEuD_99APjQ8zKlfOZNjs=@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-17 at 15:04 +0000, Ihor Solodrai wrote:

[...]

> Eduard, I've just tried on master (without this patch)
>=20
>     $ touch progs/verifier_and.c; make -j test_progs
>=20
> and I get a similar sequence:
>=20
>     CLNG-BPF [test_progs] verifier_and.bpf.o
>     GEN-SKEL [test_progs] verifier_and.skel.h
>     CLNG-BPF [test_progs-cpuv4] verifier_and.bpf.o
>     GEN-SKEL [test_progs-cpuv4] verifier_and.skel.h
>     CLNG-BPF [test_progs-no_alu32] verifier_and.bpf.o
>     GEN-SKEL [test_progs-no_alu32] verifier_and.skel.h
>     TEST-OBJ [test_progs] verifier.test.o
>     BINARY   test_progs
>     TEST-OBJ [test_progs-no_alu32] verifier.test.o
>     EXT-COPY [test_progs-no_alu32] urandom_read bpf_testmod.ko bpf_test_n=
o_cfi.ko liburandom_read.so xdp_synproxy sign-file uprobe_multi ima_setup.s=
h verify_sig_setup.sh btf_dump_test_case_bitfields.c btf_dump_test_case_mul=
tidim.c btf_dump_test_case_namespacing.c btf_dump_test_case_ordering.c btf_=
dump_test_case_packing.c btf_dump_test_case_padding.c btf_dump_test_case_sy=
ntax.c
>     BINARY   test_progs-no_alu32
>     TEST-OBJ [test_progs-cpuv4] verifier.test.o
>     EXT-COPY [test_progs-cpuv4] urandom_read bpf_testmod.ko bpf_test_no_c=
fi.ko liburandom_read.so xdp_synproxy sign-file uprobe_multi ima_setup.sh v=
erify_sig_setup.sh btf_dump_test_case_bitfields.c btf_dump_test_case_multid=
im.c btf_dump_test_case_namespacing.c btf_dump_test_case_ordering.c btf_dum=
p_test_case_packing.c btf_dump_test_case_padding.c btf_dump_test_case_synta=
x.c
>     BINARY   test_progs-cpuv4
>=20
>=20
> %.bpf.o -> %.skel.h -> %.test.o have to be built for each TRUNNER,
> right? And then each TRUNNER needs to be rebuilt because of %.test.o
> change. Using vpath for skels doesn't change this behavior.
>=20
> Maybe I'm missing something, let me know.
>=20

Hm, right, sorry for the noise.


