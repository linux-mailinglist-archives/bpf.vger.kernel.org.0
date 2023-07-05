Return-Path: <bpf+bounces-4058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0FB748556
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 15:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF6A1C20B3D
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F858D313;
	Wed,  5 Jul 2023 13:45:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41CFC8F8;
	Wed,  5 Jul 2023 13:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30B0C433C7;
	Wed,  5 Jul 2023 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688564733;
	bh=2nZc8QuDXQtU0mJQdbBKKU3T4vyKo8XqmVijsQeBb+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HHCNlWJdsDyCfJAqxVw88yhrOEwjE4+AzjYxJ5QdiR8zt2Bq3oevCi7o2fOX30Vs9
	 vR4PqMoHxn+Lu2H8Z56jIubA19YmDBfJKFWE6sO4kkMYH0qdo6rsCG7LGu3w3/RN4t
	 XIgbDrYMp/K5PeAmItfPHIpVfVuLJy2b65tmxMT0o3IqOBb4eVUNsNj/EjOrEB7Lms
	 Ki+JeSy0W8UmVOzyslNJUj5BvAD4YWTGpWbPcxD71SfAeh4OxhX8/nv0wdNMxK1fTd
	 b4Gj68qHZOwIh2u5ghqhV5kuA1UFfeWvCE/zKBicWXuF9rz5rWJUVEzb4ZcddFTEAc
	 QJIN5x6a71C0A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Alexei
 Starovoitov <ast@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH bpf-next 0/2] BPF kselftest cross-build/RISC-V fixes
In-Reply-To: <9ee053a4-500c-2722-d822-d137648e55e5@iogearbox.net>
References: <20230705113926.751791-1-bjorn@kernel.org>
 <9ee053a4-500c-2722-d822-d137648e55e5@iogearbox.net>
Date: Wed, 05 Jul 2023 15:45:30 +0200
Message-ID: <87bkgqtqth.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 7/5/23 1:39 PM, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> This series has two minor fixes, found when cross-compiling for the
>> RISC-V architecture.
>>=20
>> Some RISC-V systems do not define HAVE_EFFICIENT_UNALIGNED_ACCESS,
>> which made some of tests bail out. Fix the failing tests by adding
>> F_NEEDS_EFFICIENT_UNALIGNED_ACCESS.
>>=20
>> ...and some RISC-V systems *do* define
>> HAVE_EFFICIENT_UNALIGNED_ACCESS. In this case the autoconf.h was not
>> correctly picked up by the build system.
>
> Looks good, applied thanks!=20

Thank you!

> Any plans on working towards integrating riscv into upstream BPF CI?
> Would love to see that happening. :)

Yes! I started hacking a bit on that some time back:

  https://github.com/libbpf/ci/pull/87
  https://github.com/kernel-patches/vmtest/pull/194

(TL;DR: I'll continuing that work at some point.)

RISC-V still needs cross-compilation, and testing on qemu/TCG (on
typically x86-hosts), which puts some constraints on the
rootfs/cross-compilation host; For RISC-V Debian Bullseye is way too old
(a lot packages are missing/broken). Typically for BPF it would be
Ubuntu Kinetic (or later), or some Debian Sid snapshot.

The rootfs, the host, and the host foreign arch would need to be the
same for "no-hassle cross-compilation on Debian derivatives" -- and at
least younger than "Ubuntu Kinetic"-age.

AFAIU, there are some issues with rootfs version and build host
versioning for other archs as well: https://github.com/libbpf/ci/pull/83


Bj=C3=B6rn

