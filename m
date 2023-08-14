Return-Path: <bpf+bounces-7694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD1B77B14C
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 08:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307171C2098E
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 06:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF03F5660;
	Mon, 14 Aug 2023 06:14:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C4C185D
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 06:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C65C433C7;
	Mon, 14 Aug 2023 06:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691993689;
	bh=eTq5lg24E4jKVRcCvUSUIYtJjm4KTPFGD0GKMh0DwbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pwFkuPtx46gDfSQ66A/GRRPyzJjcJt1TI5pNb82BdeWjlND/GZO+giPGpnxXDRVVA
	 TGGBHnuZ+PN07ZH3/NXiuZ7sepOrEs6yvGMslevzLBNWwkoMfYyewErt664hm7hj1Q
	 m11doQknDFzC1bTt5ake8lMFvycE/Bs0dw43da0clEL3pgb8UHUXETDgzHTKKEAhL4
	 wKI2tou1K/8cHSYoJh9t7Np2BQIWIlGO746RNbUYtOtI3yQHk5sY+64TAhP5PgdFCX
	 gdVaHRssYwAKX9ut8WcogxzN3+wAY69OynwpSXeVjVx6pyuZSOlkPSCcbFBN9lyCDE
	 7043B8bPTtE5w==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, pulehui@huawei.com,
 conor.dooley@microchip.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 kpsingh@kernel.org, bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: Re: [PATCH bpf-next 0/2] bpf, riscv: use BPF prog pack allocator in
 BPF JIT
In-Reply-To: <87ttt21yd1.fsf@all.your.base.are.belong.to.us>
References: <20230720154941.1504-1-puranjay12@gmail.com>
 <87ttt21yd1.fsf@all.your.base.are.belong.to.us>
Date: Mon, 14 Aug 2023 08:14:46 +0200
Message-ID: <874jl2up49.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Puranjay Mohan <puranjay12@gmail.com> writes:
>
>> BPF programs currently consume a page each on RISCV. For systems with ma=
ny BPF
>> programs, this adds significant pressure to instruction TLB. High iTLB p=
ressure
>> usually causes slow down for the whole system.
>>
>> Song Liu introduced the BPF prog pack allocator[1] to mitigate the above=
 issue.
>> It packs multiple BPF programs into a single huge page. It is currently =
only
>> enabled for the x86_64 BPF JIT.
>>
>> I enabled this allocator on the ARM64 BPF JIT[2]. It is being reviewed n=
ow.
>>
>> This patch series enables the BPF prog pack allocator for the RISCV BPF =
JIT.
>> This series needs a patch[3] from the ARM64 series to work.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> Performance Analysis of prog pack allocator on RISCV64
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>
>> Test setup:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Host machine: Debian GNU/Linux 11 (bullseye)
>> Qemu Version: QEMU emulator version 8.0.3 (Debian 1:8.0.3+dfsg-1)
>> u-boot-qemu Version: 2023.07+dfsg-1
>> opensbi Version: 1.3-1
>>
>> To test the performance of the BPF prog pack allocator on RV, a stresser
>> tool[4] linked below was built. This tool loads 8 BPF programs on the sy=
stem and
>> triggers 5 of them in an infinite loop by doing system calls.
>>
>> The runner script starts 20 instances of the above which loads 8*20=3D16=
0 BPF
>> programs on the system, 5*20=3D100 of which are being constantly trigger=
ed.
>> The script is passed a command which would be run in the above environme=
nt.
>>
>> The script was run with following perf command:
>> ./run.sh "perf stat -a \
>>         -e iTLB-load-misses \
>>         -e dTLB-load-misses  \
>>         -e dTLB-store-misses \
>>         -e instructions \
>>         --timeout 60000"
>>
>> The output of the above command is discussed below before and after enab=
ling the
>> BPF prog pack allocator.
>>
>> The tests were run on qemu-system-riscv64 with 8 cpus, 16G memory. The r=
ootfs
>> was created using Bjorn's riscv-cross-builder[5] docker container linked=
 below.
>
> Back in the saddle! Sorry for the horribly late reply...
>
> Did you run the test_progs kselftest test, and passed w/o regressions? I
> ran a test without/with your series (plus the patch from the arm64
> series that you pointed out), and I'm getting regressions with this
> series:
>
> w/o Summary: 318/3114 PASSED, 27 SKIPPED, 60 FAILED
> w/  Summary: 299/3026 PASSED, 33 SKIPPED, 79 FAILED
>
> I'm did the test on commit 4c75bf7e4a0e ("Merge tag
> 'kbuild-fixes-v6.5-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild").
>
> I'm re-running, and investigating now.

I had a bad environment on for the rebuild; A proper rebuild worked. No
regressions. Sorry for the noise!

