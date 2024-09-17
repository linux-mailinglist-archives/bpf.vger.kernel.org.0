Return-Path: <bpf+bounces-40044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E80E97B1DA
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 17:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA411F25F07
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 15:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EA41A01BA;
	Tue, 17 Sep 2024 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="kh0WGWOJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CE017A591
	for <bpf@vger.kernel.org>; Tue, 17 Sep 2024 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585488; cv=none; b=Xhas6Q4lmQec4rS2xrc7/ai3zKKNjyftO0E8JoG+Q2pAxUvcf78X9/6b7RC7cGqM0tc48ms7zQ8W8b+PqQxugfQud66bxGTG8CGkWMX9kPyG5UV/aLbLrVcgpxDrHHRoDzOMmpQw4Dse5/MiX2g/uhlshOIDKSDiEoT+6ufCqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585488; c=relaxed/simple;
	bh=GJySo1QLJuf6dwgUVZqMny214eD9CWadNUh9T9UQUF8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTQCvpGkhbOO38D+MO5mMg+m0w/ly7XI2bgxC8rKifoKCBLcdSZoAeRWxcpILDyvq9f1ejtxCmvLW+B9pXTzgnbmDtER1ILOE2vDVKWafRa2n/ed59wanBiyE7hcireUMMf7luxsu2g2uODGWqo5TKq2s8e7Bgq7/4mcS2muvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=kh0WGWOJ; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1726585484; x=1726844684;
	bh=myfcJgscrVRN5KMOTufcsgVeLJhvlDYn5zknGm+BtLQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kh0WGWOJkPfgmd+QOqgUnAi2ObioLa3Yg4i/zIAFLqvn4NvGGLKBaSky3jJdZ82gx
	 3i/wFsVMXJFpzeJFeEacFoxf9jzBQ73TNtUrqet3l/lxSq0p1GGV3vmlIKX4MDZ6gF
	 NC0f9/zffUPWGx//1ydQq6qZTfL2EfCx4bG1jKz84AjJzcKhmN7d7vuz3qiXaVEvgM
	 NvzuIoHRAIwMSpb7D3zF0BqNRCEY2rxU0cYr0o/EpzVP5+zjXIGk3fwPaG9Nyl++za
	 80hgMAs9KhBe1+nRaeGgCjZHDfiPVjZb04BXAamzF3zIp6QRsezq3jMvy9u410tkqE
	 xQLAC/oaJG3/w==
Date: Tue, 17 Sep 2024 15:04:39 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com, bjorn@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: set vpath in Makefile to search for skels
Message-ID: <p_YHaXjA1ci8khO7PzqJph62Huednrj7sb4zUJLrAaLUuZin6wKAJoqSl2Z32FIJs05h7FdiFHK1t4tkUem1J1ZEuD_99APjQ8zKlfOZNjs=@pm.me>
In-Reply-To: <dbf5eb3056eabbd44775d526a64b53e1a43b9f59.camel@gmail.com>
References: <20240916195919.1872371-1-ihor.solodrai@pm.me> <20240916195919.1872371-2-ihor.solodrai@pm.me> <dbf5eb3056eabbd44775d526a64b53e1a43b9f59.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: cd024463cb190b9f2e04cf4428f2b4fae1bf7ee0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, September 16th, 2024 at 9:00 PM, Eduard Zingerman <eddyz87@gmail=
.com> wrote:

[...]

>=20
> When I try this patch, the following happens after first full tests build=
:
>=20
> $ touch progs/verifier_and.c; make -j test_progs
>=20
> CLNG-BPF [test_progs] verifier_and.bpf.o
> CLNG-BPF [test_progs-no_alu32] verifier_and.bpf.o
> CLNG-BPF [test_progs-cpuv4] verifier_and.bpf.o
> GEN-SKEL [test_progs] verifier_and.skel.h
> GEN-SKEL [test_progs-no_alu32] verifier_and.skel.h
> GEN-SKEL [test_progs-cpuv4] verifier_and.skel.h
> TEST-OBJ [test_progs] verifier.test.o
> BINARY test_progs
>=20
> Note that multiple binaries are built.

Eduard, I've just tried on master (without this patch)

    $ touch progs/verifier_and.c; make -j test_progs

and I get a similar sequence:

    CLNG-BPF [test_progs] verifier_and.bpf.o
    GEN-SKEL [test_progs] verifier_and.skel.h
    CLNG-BPF [test_progs-cpuv4] verifier_and.bpf.o
    GEN-SKEL [test_progs-cpuv4] verifier_and.skel.h
    CLNG-BPF [test_progs-no_alu32] verifier_and.bpf.o
    GEN-SKEL [test_progs-no_alu32] verifier_and.skel.h
    TEST-OBJ [test_progs] verifier.test.o
    BINARY   test_progs
    TEST-OBJ [test_progs-no_alu32] verifier.test.o
    EXT-COPY [test_progs-no_alu32] urandom_read bpf_testmod.ko bpf_test_no_=
cfi.ko liburandom_read.so xdp_synproxy sign-file uprobe_multi ima_setup.sh =
verify_sig_setup.sh btf_dump_test_case_bitfields.c btf_dump_test_case_multi=
dim.c btf_dump_test_case_namespacing.c btf_dump_test_case_ordering.c btf_du=
mp_test_case_packing.c btf_dump_test_case_padding.c btf_dump_test_case_synt=
ax.c
    BINARY   test_progs-no_alu32
    TEST-OBJ [test_progs-cpuv4] verifier.test.o
    EXT-COPY [test_progs-cpuv4] urandom_read bpf_testmod.ko bpf_test_no_cfi=
.ko liburandom_read.so xdp_synproxy sign-file uprobe_multi ima_setup.sh ver=
ify_sig_setup.sh btf_dump_test_case_bitfields.c btf_dump_test_case_multidim=
.c btf_dump_test_case_namespacing.c btf_dump_test_case_ordering.c btf_dump_=
test_case_packing.c btf_dump_test_case_padding.c btf_dump_test_case_syntax.=
c
    BINARY   test_progs-cpuv4


%.bpf.o -> %.skel.h -> %.test.o have to be built for each TRUNNER,
right? And then each TRUNNER needs to be rebuilt because of %.test.o
change. Using vpath for skels doesn't change this behavior.

Maybe I'm missing something, let me know.


