Return-Path: <bpf+bounces-39835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C52DB9782EC
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 16:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A3F288151
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 14:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982782B9C6;
	Fri, 13 Sep 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJBdv2B+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C054286A8
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239113; cv=none; b=BCQ1eX+GANzY9lcecVXxoSRdp/jCi/HA5FJw0XY1WDuj76U9QO44PZZ2KTqxf17J9F6Ym8X3GHRT4bJy3TjO3tzU6/SIkAwZjxhRs+gm0z7nQ1P3E9dRKqb7qGLSISKYfW1ipFULar0DqEDN0yiM2UCWyhPBsakhY6BrfjYGqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239113; c=relaxed/simple;
	bh=xobkrjCDcsS3NYpEWQkWBAcAwBL6dx9GigjQubMA6Sw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AsK+u4sTebFXya23R28lr2PaMCgfBIrpXd/dU0buHszKIip6bcBTg5gGjWfASTfIst0ntNG6bunf1hghpciKe+Ez7wTwG3KfeG+9rJrTMBtXOd5OXFdACP64OrytLYFx3toWiJZLMszxlboRiDfgZe7ZjyW9mWRsl6diIDyI9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJBdv2B+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F40C4CEC0;
	Fri, 13 Sep 2024 14:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726239112;
	bh=xobkrjCDcsS3NYpEWQkWBAcAwBL6dx9GigjQubMA6Sw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KJBdv2B+deMtsUJGqG2eAyQh7CelskULGZ+Or4TfCVa01m01nCZ64hg8J4E9KcoRt
	 Cv1CFrYWx/mZ3NcyNrDf1tK9P+oYQq0B/Ct6Lwv3jaVe4VRHQUWov/42DeaEH+Nrp5
	 z50TdBklr6qHVwyYwG9CV1N+jgEXA8O+tdWpNW0vUEn8BlEVk2509zw593v0VEMG0K
	 MmOnks/Nhpvv2rJv6hST4bmJ/9XN2C5/0YkEtRE4D2UOUdrVjYPUXe2T9SI1vRKzf0
	 DJlZOuUjd8mqgN/hAyAGiTMsa2MW5r1hJkRktTNQW9tfnJp3asqNr2H17Qz2MHRJdb
	 Qc8Fx4nbOPlow==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>, andrii.nakryiko@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org,  eddyz87@gmail.com,
 daniel@iogearbox.net, mykolal@fb.com, Anders Roxell
 <anders.roxell@linaro.org>, patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for
 test objects
In-Reply-To: <172141323037.13293.5496223993427449959.git-patchwork-notify@kernel.org>
References: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me>
 <172141323037.13293.5496223993427449959.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 16:51:49 +0200
Message-ID: <877cbfwqre.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

patchwork-bot+netdevbpf@kernel.org writes:

> Hello:
>
> This patch was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:
>
> On Thu, 18 Jul 2024 22:57:43 +0000 you wrote:
>> Make use of -M compiler options when building .test.o objects to
>> generate .d files and avoid re-building all tests every time.
>>=20
>> Previously, if a single test bpf program under selftests/bpf/progs/*.c
>> has changed, make would rebuild all the *.bpf.o, *.skel.h and *.test.o
>> objects, which is a lot of unnecessary work.
>>=20
>> [...]
>
> Here is the summary with links:
>   - [bpf-next,v4] selftests/bpf: use auto-dependencies for test objects
>     https://git.kernel.org/bpf/bpf-next/c/a3cc56cd2c20

I'm getting some build regressions for out-of-tree selftest build with
this patch on bpf-next/master. I'm building the selftests from the
selftest root, typically:

  make O=3D/output/foo SKIP_TARGETS=3D"" \
    KSFT_INSTALL_PATH=3D/output/foo/kselftest \
    -C tools/testing/selftests install

and then package the whole output kselftest directory, and use that to
populate the DUT.

Reverting this patch, resolves the issues.

Two issues:

  1. The install target fails, resulting in many test scripts not copied
     to the install directory (e.g. test_kmod.sh).
  2. Building "all" target fails the second time.

To reproduce, do the following:

  Pre-requisite
    Build the kernel for yourfavorite arch -- my is RISC-V at moment ;-)

    make O=3D/output/foo defconfig
    make O=3D/output/foo kselftest-merge
    make O=3D/output/foo
    make O=3D/output/foo headers
=20=20
  1. Install fail
    make O=3D/output/foo TARGETS=3Dbpf SKIP_TARGETS=3D"" \
      KSFT_INSTALL_PATH=3D/output/foo/kselftest \
      -C tools/testing/selftests install
=20=20
  2. Build "all" fails the second time
      make O=3D/output/foo TARGETS=3Dbpf SKIP_TARGETS=3D"" \
      KSFT_INSTALL_PATH=3D/output/foo/kselftest \
      -C tools/testing/selftests
=20=20
      make O=3D/output/foo TARGETS=3Dbpf SKIP_TARGETS=3D"" \
      KSFT_INSTALL_PATH=3D/output/foo/kselftest \
      -C tools/testing/selftests


Any ideas on a workaround?=20

(And not related to this patch; It's annoying that "bpf" is the default
SKIP_TARGETS in kselftest. A bit meh 2024. ;-))


Bj=C3=B6rn

