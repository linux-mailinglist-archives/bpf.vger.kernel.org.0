Return-Path: <bpf+bounces-39141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AA896F653
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 16:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9EF285653
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD8C1CFED6;
	Fri,  6 Sep 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubmNvtCp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7E1CB31D;
	Fri,  6 Sep 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631728; cv=none; b=PgY8NJY9csfoMrA4QJW6cVsOtmB3MUv2NGOsCbjgQl/asqfq7piVmVafg7fjOtojTyVqLFrr6ut64qyjEtdffovbjTjNxhh5Vkm8GHoIea48ItDOB4nWnDXm7mxR92IuRMxM/dSnXCpIdIiW8WuUXkQH8HfxqBIMDnlJaP/BF4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631728; c=relaxed/simple;
	bh=/y/UqiYNJYSj4YSmig75Z6o0Ghm1ajTdKXOuhrekOdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZpKQV1hBkWaClK5CpkxWpXw5KBjmslB3vx/+GsmZk4go8wIVrmMy8XzPK+rYJ+OU+Yx7Zucfe4jjh5Dro4LGVv1kFwIUe2b6+CtxeeV19W9VvlU77QHcMh7r9AWwh63s463DAFzMstPM3RtIb0WpRt+hWYhNvkodtPdxK7dsOsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubmNvtCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD70CC4CEC4;
	Fri,  6 Sep 2024 14:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725631728;
	bh=/y/UqiYNJYSj4YSmig75Z6o0Ghm1ajTdKXOuhrekOdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ubmNvtCpilRHsj7Xus8YQDC2qoYGmQPAc/rDpn0Ua6FyW8HYP74hBOgiTDR4T6pNg
	 tifCHe+EZY2kTYEna4qDRUKZBGRFchsF0ZKmp+NryT9czXh8UKs2xlp8csFNhSLFry
	 NLQPYIrTiBp4/hJYa1AHXmtlcFwEUm0Ot+T9TI0cX279T6xjPBR3DM23UUfVvAEXXL
	 BXxT22OgAkKQV/dIUJYeQ7c+Auja5BD6B0NvFEG56xxdk7/KupNitwHgX6/PWEn5ZV
	 r4u3souSQqQZN4iDDWJTANGKoT8yfw8Bz4a06eTK27LM00yG+/wACjAI9W5UzCpSP2
	 AUH/Z+EwRgchw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, Daniel Borkmann
 <daniel@iogearbox.net>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Puranjay Mohan
 <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next v3 00/10] Local vmtest enhancement and RV64
 =?utf-8?Q?enabled=F0=9F=98=81?=
In-Reply-To: <540dd7eb-1099-4c38-8004-1cb556b0b9be@huaweicloud.com>
References: <20240905081401.1894789-1-pulehui@huaweicloud.com>
 <e9816f7c-a603-c73e-5fcc-71bbcf6c6ca3@iogearbox.net>
 <540dd7eb-1099-4c38-8004-1cb556b0b9be@huaweicloud.com>
Date: Fri, 06 Sep 2024 16:08:44 +0200
Message-ID: <87bk10g9hv.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lehui, Daniel!

Pu Lehui <pulehui@huaweicloud.com> writes:

> On 2024/9/6 2:52, Daniel Borkmann wrote:
>> On 9/5/24 10:13 AM, Pu Lehui wrote:
>>> Patch 1-3 fix some problem about bpf selftests. Patch 4 add local rootfs
>>> image support for vmtest. Patch 5 enable cross-platform testing for
>>> vmtest. Patch 6-10 enable vmtest on RV64.
>>>
>>> We can now perform cross platform testing for riscv64 bpf using the
>>> following command:
>>>
>>> PLATFORM=3Driscv64 CROSS_COMPILE=3Driscv64-linux-gnu- \
>>> =C2=A0=C2=A0 tools/testing/selftests/bpf/vmtest.sh \
>>> =C2=A0=C2=A0 -l <path of local rootfs image> -- \
>>> =C2=A0=C2=A0 ./test_progs -d \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \"$(cat tools/testing/selftests/bp=
f/DENYLIST.riscv64 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | cut -d'#=
' -f1 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | sed -e '=
s/^[[:space:]]*//' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's/[[:space:]]*$//' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | tr -s '\=
n' ',' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )\"
>>>
>>> For better regression, we rely on commit [0]. And since the work of ris=
cv
>>> ftrace to remove stop_machine atomic replacement is in progress, we also
>>> need to revert commit [1] [2].
>>>
>>> The test platform is x86_64 architecture, and the versions of relevant
>>> components are as follows:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 QEMU: 8.2.0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 CLANG: 17.0.6 (align to BPF CI)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 ROOTFS: ubuntu noble (generated by [3])
>>>
>>> Link:=20
>>> https://lore.kernel.org/all/20240831071520.1630360-1-pulehui@huaweiclou=
d.com/ [0]
>>> Link:=20
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D3308172276db [1]
>>> Link:=20
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D7caa9765465f [2]
>>> Link: https://github.com/libbpf/ci/blob/main/rootfs/mkrootfs_debian.sh=
=20
>>> [3]
>>=20
>> Nice work! Next step is upstream BPF CI integration? :)
>
> CC Bj=C3=B6rn=F0=9F=98=81

Indeed, very nice work! Every year is "The year of RISC-V BPF CI
integration". :-P

> Yeah, that's what we're most looking forward to and we've been trying to=
=20
> move forward with that. There are currently several options, but they=20
> are not very suitable yet.
>
> 1. Cross-platform testing with subset of tests (test_verifier +=20
> test_progs), it will cost a bit more time.
>
> x86_64 host:
> Summary: 536/3594 PASSED, 68 SKIPPED, 0 FAILED
> real    30m 18.88s
> user    6m 52.97s
> sys     21m 3.03s
>
> 2. Cross-platform testing will parallel mode, it will meet flaky=20
> problems while the time consume looks good.
>
> x86_64 host:
> real    7m 45.42s
> user    6m 13.59s
> sys     15m 41.12s
>
> 3. Real board testing, which relies on Hypervisor Extension to enable=20
> kvm on qemu. We are still trying to find a suitable board.

There's a board coming out soonish with H -- let's hope it doesn't suck!
;-)

I have a CI running, that's runs all the BPF tests (and the rest of
kselftest) on various trees/branches, and it takes *hours* on QEMU TCG
[1] (the GH CI doesn't report fail/ok in the UI, so you need to download
the logs [2] -- filename *kselftest-bpf*).

Obviously this is a no-go for pre-commit/patchwork CI, but for, say,
a longer release test (post-commit), spending a couple of hours on a
test would probably be OK.

If there's a post-commit CI running somewhere, maybe we could plug in
RISC-V BPF QEMU TCG tests there? ...and then when we get proper H
machines, we can add RISC-V to Meta's PW CI as well.

Daniel, is there a "release test CI" running, or is that mostly manual
work?

Bj=C3=B6rn


[1] https://github.com/linux-riscv/linux-riscv/actions/runs/10725237865/job=
/29742632222#step:5:30
[2] https://github.com/linux-riscv/linux-riscv/actions/runs/10725237865/art=
ifacts/1899421897

