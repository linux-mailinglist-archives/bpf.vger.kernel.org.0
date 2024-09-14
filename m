Return-Path: <bpf+bounces-39898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 165BE97901E
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 12:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897D91F2305F
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA2B1CEACC;
	Sat, 14 Sep 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="refMkUEC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD6A17CA1D
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311258; cv=none; b=XMQbbNeftJDqdxOE0Q6Ptq1ndImkQedUNW7wrZa1+Y1b1VvtmREp0rwrSWkEZZzLZgEz5JxsD3Vw6rfnrIgrh7kmUVpYLXLtOPsfklM5LwGfAdGNQR7+PteGIQ/4H3QF8TdUJrY/o3ftCQyAWCQ1g8iUPuuxe830DJzkUuH/ojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311258; c=relaxed/simple;
	bh=7m/stVyb+5mVPAroEs00KIzk7Tm/JggDRFLvobm5C7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M0e8bO+jcx2M+GQIta4sZRcrC/4La+sozdLI1+ucDAsffm11keK9gFM1k7syvBlrwFLVMVi2ybd4m6dX9BXuBAzB8PyrXpe/7SQDWBRhqBq8iVhfnJsx3bgC52C/KXUMnbTQeIeYzMEZwr9HkhYuD1cNygWmxPFof2V30IrAF7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=refMkUEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FBEC4CEC0;
	Sat, 14 Sep 2024 10:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726311258;
	bh=7m/stVyb+5mVPAroEs00KIzk7Tm/JggDRFLvobm5C7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=refMkUECzoLa6waav+UHnodS7ROgtq08ND3730zibkQN/TlBm176USC+33Foo2idx
	 dUUcbAMbMKFWjCTDADGaOu+eWMMIVRyAftUZtQwsgxuKUlMtFFt7HTm334FHJKo8ik
	 aNeQTOmfKpic7Gh/TDSStoYc28e+avMqJUjne+mtXjsnp7D1MxnCPJ4ocSrKMv00gY
	 nS9KLASN0hgaCfLnWK9ZJ041/RGIbFOeGReTXhJyHqVZAccrkyZgZzeejBvbbvX7eK
	 HNX7v8WL48CSqNvajgHTgfJxO4TkcBgDSW26ytFFv0fyGLu1pERL64daLl5kzX75rI
	 OdDi2qhgYGXVw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii.nakryiko@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 eddyz87@gmail.com, daniel@iogearbox.net, mykolal@fb.com, Anders Roxell
 <anders.roxell@linaro.org>, patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for
 test objects
In-Reply-To: <Q3BN2kW9Kgy6LkrDOwnyY4Pv7_YF8fInLCd2_QA3LimKYM3wD64kRdnwp7blwG2dI_s7UGnfUae-4_dOmuTrxpYCi32G_KTzB3PfmxIerH8=@pm.me>
References: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me>
 <172141323037.13293.5496223993427449959.git-patchwork-notify@kernel.org>
 <877cbfwqre.fsf@all.your.base.are.belong.to.us>
 <Q3BN2kW9Kgy6LkrDOwnyY4Pv7_YF8fInLCd2_QA3LimKYM3wD64kRdnwp7blwG2dI_s7UGnfUae-4_dOmuTrxpYCi32G_KTzB3PfmxIerH8=@pm.me>
Date: Sat, 14 Sep 2024 12:54:14 +0200
Message-ID: <87seu2a4kp.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ihor Solodrai <ihor.solodrai@pm.me> writes:

> On Friday, September 13th, 2024 at 7:51 AM, Bj=C3=B6rn T=C3=B6pel <bjorn@=
kernel.org> wrote:
>
>> I'm getting some build regressions for out-of-tree selftest build with
>> this patch on bpf-next/master. I'm building the selftests from the
>> selftest root, typically:
>>=20
>> make O=3D/output/foo SKIP_TARGETS=3D"" \
>> KSFT_INSTALL_PATH=3D/output/foo/kselftest \
>> -C tools/testing/selftests install
>>=20
>> and then package the whole output kselftest directory, and use that to
>> populate the DUT.
>>=20
>> Reverting this patch, resolves the issues.
>>=20
>> Two issues:
>>=20
>> 1. The install target fails, resulting in many test scripts not copied
>> to the install directory (e.g. test_kmod.sh).
>> 2. Building "all" target fails the second time.
>>=20
>> To reproduce, do the following:
>>=20
>> Pre-requisite
>> Build the kernel for yourfavorite arch -- my is RISC-V at moment ;-)
>>=20
>> make O=3D/output/foo defconfig
>> make O=3D/output/foo kselftest-merge
>> make O=3D/output/foo
>> make O=3D/output/foo headers
>>=20
>> 1. Install fail
>> make O=3D/output/foo TARGETS=3Dbpf SKIP_TARGETS=3D"" \
>> KSFT_INSTALL_PATH=3D/output/foo/kselftest \
>> -C tools/testing/selftests install
>>=20
>> 2. Build "all" fails the second time
>> make O=3D/output/foo TARGETS=3Dbpf SKIP_TARGETS=3D"" \
>> KSFT_INSTALL_PATH=3D/output/foo/kselftest \
>> -C tools/testing/selftests
>>=20
>> make O=3D/output/foo TARGETS=3Dbpf SKIP_TARGETS=3D"" \
>> KSFT_INSTALL_PATH=3D/output/foo/kselftest \
>> -C tools/testing/selftests
>>=20
>>=20
>> Any ideas on a workaround?
>
> Hi Bj=C3=B6rn.
>
> I was able to reproduce the problem on bpf-next/master.
>
> I found that in commit
> https://git.kernel.org/bpf/bpf-next/c/f957c230e173 [1] the file
> tools/testing/selftests/bpf/test_skb_cgroup_id.sh was deleted, but not
> removed from the TEST_PROGS list in tools/testing/selftests/bpf/Makefile
>
> Because of that rsync command (invoked by install target) fails:
>
>     rsync: [sender] link_stat "/opt/linux/tools/testing/selftests/bpf/tes=
t_skb_cgroup_id.sh" failed: No such file or directory (2)
>     rsync error: some files/attrs were not transferred (see previous erro=
rs) (code 23) at main.c(1333) [sender=3D3.2.3]
>     make[1]: *** [../lib.mk:175: install] Error 23
>     make[1]: Leaving directory '/opt/linux/tools/testing/selftests/bpf'
>     make: *** [Makefile:259: install] Error 2
>     make: Leaving directory '/opt/linux/tools/testing/selftests'
>
>
> After I removed test_skb_cgroup_id.sh from TEST_PROGS list, the
> install target completed successfully.
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index f04af11df8eb..df75f1beb731 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -132,7 +132,6 @@ TEST_PROGS :=3D test_kmod.sh \
>         test_tunnel.sh \
>         test_lwt_seg6local.sh \
>         test_lirc_mode2.sh \
> -       test_skb_cgroup_id.sh \
>         test_flow_dissector.sh \
>         test_xdp_vlan_mode_generic.sh \
>         test_xdp_vlan_mode_native.sh \
>
> Could you please check on your side if this helps? Maybe there are
> other issues.

I don't even get that far in the "install" target. When I revert the
patch, I get to the issue you describe above (trying to install
non-existing file).

Here's an excerpt from a failed "install":

  |   BINARY   test_progs
  |   BINARY   test_progs-no_alu32
  |   BINARY   test_progs-cpuv4
  | make[1]: Leaving directory '/home/bjorn/src/linux/linux/tools/testing/s=
elftests/bpf'

At this point the "all" target is complete; All good, and the "install"
is started.=20

  | mkdir -p /home/bjorn/output/foo/kselftest/kselftest
  | install -m 744 kselftest/module.sh /home/bjorn/output/foo/kselftest/kse=
lftest/
  | install -m 744 kselftest/runner.sh /home/bjorn/output/foo/kselftest/kse=
lftest/
  | install -m 744 kselftest/prefix.pl /home/bjorn/output/foo/kselftest/kse=
lftest/
  | install -m 744 kselftest/ktap_helpers.sh /home/bjorn/output/foo/kselfte=
st/kselftest/
  | install -m 744 kselftest/ksft.py /home/bjorn/output/foo/kselftest/kself=
test/
  | install -m 744 run_kselftest.sh /home/bjorn/output/foo/kselftest/
  | rm -f /home/bjorn/output/foo/kselftest/kselftest-list.txt

This is from the top-level "tools/testing/selftests/Makefile", and we
enter the BPF directory for "install".

  | make[1]: Entering directory '/home/bjorn/src/linux/linux/tools/testing/=
selftests/bpf'
  |=20
  | Auto-detecting system features:
  | ...                                    llvm: [ OFF ]
  |=20
  |   LINK-BPF [test_progs] test_static_linked.bpf.o
  |   LINK-BPF [test_progs] linked_funcs.bpf.o
  |   LINK-BPF [test_progs] linked_vars.bpf.o
  |   LINK-BPF [test_progs] linked_maps.bpf.o
  |   LINK-BPF [test_progs] test_subskeleton.bpf.o
  |   LINK-BPF [test_progs] test_subskeleton_lib.bpf.o
  | ...
  |   EXT-COPY [test_maps]
  | make[1]: *** No rule to make target 'atomics.lskel.h', needed by '/home=
/bjorn/output/foo/kselftest/bpf/atomics.test.o'.  Stop.
  | make[1]: *** Waiting for unfinished jobs....
  | make[1]: Leaving directory '/home/bjorn/src/linux/linux/tools/testing/s=
elftests/bpf'
  | make: *** [Makefile:259: install] Error 2
  | make: Leaving directory '/home/bjorn/src/linux/linux/tools/testing/self=
tests'

...and for some reason the auto-dependencies decides to re-build, and
fails.

So, unfortunately it's something else related to your patch.

A reproducer:
  | $ docker run --rm -it --volume ${PWD}:/build/my-linux ghcr.io/linux-ris=
cv/pw-builder bash -l
  | # cd /build/my-linux
  | # cat > ./build.sh <<EOF
  | #!/bin/bash
  | set -euo pipefail
  |=20
  | rm -rf /output/foo
  | mkdir -p /output/foo
  |=20
  | export PATH=3D\$(echo \$PATH | tr : "\n"| grep -v ^/opt | tr "\n" :)
  |=20
  | make -j \$((\$(nproc)-1)) O=3D/output/foo defconfig
  | make -j \$((\$(nproc)-1)) O=3D/output/foo kselftest-merge
  | make -j \$((\$(nproc)-1)) O=3D/output/foo
  | make -j \$((\$(nproc)-1)) O=3D/output/foo headers
  | make -j \$((\$(nproc)-1)) O=3D/output/foo TARGETS=3Dbpf SKIP_TARGETS=3D=
"" KSFT_INSTALL_PATH=3D/output/foo/kselftest -C tools/testing/selftests ins=
tall
  | EOF
  |=20
  | # chmod +x ./build.sh
  | # ./build.sh


Bj=C3=B6rn

