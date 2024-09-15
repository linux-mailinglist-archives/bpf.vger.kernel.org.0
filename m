Return-Path: <bpf+bounces-39944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260AE9797A0
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 17:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7731C20FF9
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 15:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434B51C7B6B;
	Sun, 15 Sep 2024 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLk8/N+/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21C42065
	for <bpf@vger.kernel.org>; Sun, 15 Sep 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726414891; cv=none; b=hj0lH6Sc1MzJzlx9CrWIwsFnUMvh856xVGhoWQwxAMcSinVo0CboNB9V9wKOCZLBb0n0BIAKPmSD9B70+bd7AVASPwLC/uCAQq8oYj3CMtC+ysyzNSumFWfbhk65LiCm9wFoYO1O8PCT9zqp3VWHj9v89kNbXkJ+T2zElbIVVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726414891; c=relaxed/simple;
	bh=2gGjwIFetu21jpHVivGtBEksCG7AZdrLqZqP4C6VylM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=moWuyM/x67N1vSi95S6aD7ZNHfVRFkyFWRZGR4oHdlXwRoMjQvRrrKr84Z3R0wlmq4N/VY/BQTn16CfDI4iOQLDprexglQ2UI6kZhvLbhqi9rHn1EotIGo0C4+PqPV5JfnEVxaKYrT55oFSEUA9YIRswLlSck5T8PFOIgh52vJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLk8/N+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D38C4CEC3;
	Sun, 15 Sep 2024 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726414890;
	bh=2gGjwIFetu21jpHVivGtBEksCG7AZdrLqZqP4C6VylM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BLk8/N+/js/8R4epjlzzUdMIHpr1SUYwatoo79YJn8SgE781dHNLGxc20/fxHjM3n
	 msQZhe4osQS27W9KcrIT5vj7pk7athBkfx5hQ6Hba6aq1q8OLQZoT+RuKPj4kC555K
	 dB78TkTJXiBaMk1HcPrjSuJyF8yj2Jo9P5KUFWvguV3z76lhZDjlG5eiYsnlAmyRTh
	 ZyFE2uVvvjKQj500b+o6zjxj3rQGyKIEm2/LcC9bk2F5Rr7CuUhQ5IO9jnXMx0ZuNv
	 c+OAs3AsZ2nJhYtlDKfKr1sARWDrGMpb4x0OyruIAgHGIoUTipxzrZT3wG8S4k9Ycr
	 91trdtneBRITQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii.nakryiko@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 eddyz87@gmail.com, daniel@iogearbox.net, mykolal@fb.com, Anders Roxell
 <anders.roxell@linaro.org>, patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for
 test objects
In-Reply-To: <CIjrhJwoIqMc2IhuppVqh4ZtJGbx8kC8rc9PHhAIU6RccnWT4I04F_EIr4GxQwxZe89McuGJlCnUk9UbkdvWtSJjAsd7mHmnTy9F8K2TLZM=@pm.me>
References: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me>
 <172141323037.13293.5496223993427449959.git-patchwork-notify@kernel.org>
 <877cbfwqre.fsf@all.your.base.are.belong.to.us>
 <Q3BN2kW9Kgy6LkrDOwnyY4Pv7_YF8fInLCd2_QA3LimKYM3wD64kRdnwp7blwG2dI_s7UGnfUae-4_dOmuTrxpYCi32G_KTzB3PfmxIerH8=@pm.me>
 <87seu2a4kp.fsf@all.your.base.are.belong.to.us>
 <CIjrhJwoIqMc2IhuppVqh4ZtJGbx8kC8rc9PHhAIU6RccnWT4I04F_EIr4GxQwxZe89McuGJlCnUk9UbkdvWtSJjAsd7mHmnTy9F8K2TLZM=@pm.me>
Date: Sun, 15 Sep 2024 17:41:25 +0200
Message-ID: <87cyl4lyai.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ihor Solodrai <ihor.solodrai@pm.me> writes:

> On Saturday, September 14th, 2024 at 3:54 AM, Bj=C3=B6rn T=C3=B6pel <bjor=
n@kernel.org> wrote:
>
> [...]
>
>> >=20
>> > Could you please check on your side if this helps? Maybe there are
>> > other issues.
>>=20
>>=20
>> I don't even get that far in the "install" target. When I revert the
>> patch, I get to the issue you describe above (trying to install
>> non-existing file).
>>=20
>> Here's an excerpt from a failed "install":
>>=20
>> | BINARY test_progs
>> | BINARY test_progs-no_alu32
>> | BINARY test_progs-cpuv4
>> | make[1]: Leaving directory '/home/bjorn/src/linux/linux/tools/testing/=
selftests/bpf'
>>=20
>> At this point the "all" target is complete; All good, and the "install"
>> is started.
>>=20
>> | mkdir -p /home/bjorn/output/foo/kselftest/kselftest
>> | install -m 744 kselftest/module.sh /home/bjorn/output/foo/kselftest/ks=
elftest/
>> | install -m 744 kselftest/runner.sh /home/bjorn/output/foo/kselftest/ks=
elftest/
>> | install -m 744 kselftest/prefix.pl /home/bjorn/output/foo/kselftest/ks=
elftest/
>> | install -m 744 kselftest/ktap_helpers.sh /home/bjorn/output/foo/kselft=
est/kselftest/
>> | install -m 744 kselftest/ksft.py /home/bjorn/output/foo/kselftest/ksel=
ftest/
>> | install -m 744 run_kselftest.sh /home/bjorn/output/foo/kselftest/
>> | rm -f /home/bjorn/output/foo/kselftest/kselftest-list.txt
>>=20
>> This is from the top-level "tools/testing/selftests/Makefile", and we
>> enter the BPF directory for "install".
>>=20
>> | make[1]: Entering directory '/home/bjorn/src/linux/linux/tools/testing=
/selftests/bpf'
>> |
>> | Auto-detecting system features:
>> | ... llvm: [ OFF ]
>> |
>> | LINK-BPF [test_progs] test_static_linked.bpf.o
>> | LINK-BPF [test_progs] linked_funcs.bpf.o
>> | LINK-BPF [test_progs] linked_vars.bpf.o
>> | LINK-BPF [test_progs] linked_maps.bpf.o
>> | LINK-BPF [test_progs] test_subskeleton.bpf.o
>> | LINK-BPF [test_progs] test_subskeleton_lib.bpf.o
>> | ...
>> | EXT-COPY [test_maps]
>> | make[1]: *** No rule to make target 'atomics.lskel.h', needed by '/hom=
e/bjorn/output/foo/kselftest/bpf/atomics.test.o'. Stop.
>> | make[1]: *** Waiting for unfinished jobs....
>> | make[1]: Leaving directory '/home/bjorn/src/linux/linux/tools/testing/=
selftests/bpf'
>> | make: *** [Makefile:259: install] Error 2
>> | make: Leaving directory '/home/bjorn/src/linux/linux/tools/testing/sel=
ftests'
>>=20
>> ...and for some reason the auto-dependencies decides to re-build, and
>> fails.
>>=20
>> So, unfortunately it's something else related to your patch.
>
> Bj=C3=B6rn,
>
> I think I figured out the cause of the issue, but some details and a
> proper solution are unclear yet.
>
> In generated %.test.d makefiles some dependencies (in particular
> %.skel.h) are referred to by filename as opposed to full path. For
> example:
>
>     $ cat /output/foo/kselftest/bpf/cpuv4/atomics.test.d
>     /output/foo/kselftest/bpf/cpuv4/atomics.test.o: \
>      /opt/linux/tools/testing/selftests/bpf/prog_tests/atomics.c \
>      [...]
>      /opt/linux/tools/testing/selftests/bpf/trace_helpers.h \
>      /opt/linux/tools/testing/selftests/bpf/testing_helpers.h atomics.lsk=
el.h \  # <-- THIS
>      /output/foo/kselftest/bpf/tools/include/bpf/skel_internal.h \
>      /output/foo/kselftest/bpf/tools/include/bpf/bpf.h
>
> This is of course a problem, because make needs to know how to build a
> target with this exact name. And in the patch it was (partially)
> solved by this piece:
>
> +# When the compiler generates a %.d file, only skel basenames (not
> +# full paths) are specified as prerequisites for corresponding %.o
> +# file. This target makes %.skel.h basename dependent on full paths,
> +# linking generated %.d dependency with actual %.skel.h files.
> +$(notdir %.skel.h): $(TRUNNER_OUTPUT)/%.skel.h
> +	@true
>
> This links %.skel.h to /output/foo/kselftest/bpf/no_alu32/%.skel.h and al=
ike.
>
> Your build is breaking because there is no such rule for
> %.lskel.h and %.subskel.h, which are trivial to add:
>
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -628,6 +628,12 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$=
$$(%-deps) $(BPFTOOL) | $(TR
>  $(notdir %.skel.h): $(TRUNNER_OUTPUT)/%.skel.h
>         @true
>=20=20
> +$(notdir %.lskel.h): $(TRUNNER_OUTPUT)/%.lskel.h
> +       @true
> +
> +$(notdir %.subskel.h): $(TRUNNER_OUTPUT)/%.subskel.h
> +       @true
> +
>  endif
>
> With this change a command below completed for me in the environment
> you shared:
>
>      $ make -j \$((\$(nproc)-1)) O=3D/output/foo TARGETS=3Dbpf SKIP_TARGE=
TS=3D"" KSFT_INSTALL_PATH=3D/output/foo/kselftest -C tools/testing/selftest=
s install

Thank you! FWIW, this solves my build issue, and by extension making it
possible for the RISC-V CI to test BPF again! ;-)

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

Would be awesome if you can spin a patch proper for the above. Even if
it's uncomplete (by what you mention below), it solves my immediate
issue.

> What is a mystery to me is why this was not an issue for simple `make
> -C tool/testing/selftests/bpf`. And also why in the environment I
> tried yesterday I didn't get the failure you're seeing.
>
> Do you happen to have a Dockerfile of ghcr.io/linux-riscv/pw-builder ?
> If possible, I'd like to look at it and compare with my local
> environment.

Sure, it's at: https://github.com/linux-riscv/docker

Note that it's not something special. Simply Ubuntu 24.04 (noble), with
Clang/LLVM nightly from apt.llvm.org. I can reproduce this on my laptop,
and non-Docker builder that are running 24.04,a and Debian Sid.

> The other issue that I'll have to think about is the unnecessary
> re-builds that you've noticed. I suspect this happens due to the same
> reason: a generated dependency on X.skel.h can't find a file in
> current directory (because it was put to /output/foo), and so rebuild
> is triggered. I'll have to come up with a workaround.
>
>
> Bj=C3=B6rn, please try a change suggested above and let me know if it hel=
ps.
>
> I will investigate these problems more, and there will definitely be a
> follow up patch.
>
> Thank you for reporting.

Thank you for the swift response, and workaround! Much appreciated!

Now, enjoy the rest of the Sunday!


Cheers,
Bj=C3=B6rn

