Return-Path: <bpf+bounces-39916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F02F49794A2
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 06:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36DCEB210A2
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 04:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2098C16415;
	Sun, 15 Sep 2024 04:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="UngRAzTU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99B1B85CD
	for <bpf@vger.kernel.org>; Sun, 15 Sep 2024 04:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726375669; cv=none; b=WJ+VYjY8KXsN3R9OcJN2sl14MqmESTwAkfuo9kgVujP/RNSrqwqgZksAJGPI9oM7UnkOG5IEqrDl1e74S6w8ko6CH83VtPbEIW8hraHe9q+LIJtMGowksDaezx0t2h7NVh7r4mwrRATzr/xR6T5kanz9Ap87hiY7js10yi8bO0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726375669; c=relaxed/simple;
	bh=4Ow+CTqUHx2vkfDMOJoEZJ6Ib0f8U4FB7OAUrHCzenM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDK+bsehdotuOM3Mwi/e04zGuxivDbviU/YPgsr5CGoVevCZ7QeggNZqTl3E1bE2JpR8ENb9r/ZGabqGAaaBl46xN3eWZJ4tujHP+WhiFOTBzI31J7aDwSDGG3bOchFrUsEsU7FrqLqlfAkTlsa8bKI18XpiUj/Qthqn1WrL3DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=UngRAzTU; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1726375659; x=1726634859;
	bh=67l83c4xFSPyJ5YMXi2veOdQO6Qoq51fJeJwi6EiGu0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UngRAzTUuvh6JVVsbB2xWX20jx6xVgIbMId4ASKK3paJPcu+SRNRrjWUgXgiiBk3o
	 3oKSBXf10AbPa0i04Bf2gcYWwIcBIeQpAC0rYrKrOdkX8Js6n0fp/Z6oO8DmqxKzAf
	 e5Pzac7vXNMgXcHxc/O0SZb8VJKiF2w6CpUgqWkKTiVe5y9SPokkoNDhJUhLUmQt6T
	 p3L0QUWrR+UYVtbJJqyHnRxo0V1XC9CSobDj8Rx3PiIof8qybpnh/8n4PP8eI+nmS1
	 aRHlpOq49u1eIZ5XIIK1BtnRewyCw7Xf0lDlmdXIg4mx9Q7kXypBZfP36J7SP2lGsB
	 E11uwgW0oommw==
Date: Sun, 15 Sep 2024 04:47:34 +0000
To: =?utf-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii.nakryiko@gmail.com, bpf@vger.kernel.org, ast@kernel.org, eddyz87@gmail.com, daniel@iogearbox.net, mykolal@fb.com, Anders Roxell <anders.roxell@linaro.org>, patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for test objects
Message-ID: <CIjrhJwoIqMc2IhuppVqh4ZtJGbx8kC8rc9PHhAIU6RccnWT4I04F_EIr4GxQwxZe89McuGJlCnUk9UbkdvWtSJjAsd7mHmnTy9F8K2TLZM=@pm.me>
In-Reply-To: <87seu2a4kp.fsf@all.your.base.are.belong.to.us>
References: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me> <172141323037.13293.5496223993427449959.git-patchwork-notify@kernel.org> <877cbfwqre.fsf@all.your.base.are.belong.to.us> <Q3BN2kW9Kgy6LkrDOwnyY4Pv7_YF8fInLCd2_QA3LimKYM3wD64kRdnwp7blwG2dI_s7UGnfUae-4_dOmuTrxpYCi32G_KTzB3PfmxIerH8=@pm.me> <87seu2a4kp.fsf@all.your.base.are.belong.to.us>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 15083ee248842ec9b907ecdca99f70294cc0bcf6
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Saturday, September 14th, 2024 at 3:54 AM, Bj=C3=B6rn T=C3=B6pel <bjorn@=
kernel.org> wrote:

[...]

> >=20
> > Could you please check on your side if this helps? Maybe there are
> > other issues.
>=20
>=20
> I don't even get that far in the "install" target. When I revert the
> patch, I get to the issue you describe above (trying to install
> non-existing file).
>=20
> Here's an excerpt from a failed "install":
>=20
> | BINARY test_progs
> | BINARY test_progs-no_alu32
> | BINARY test_progs-cpuv4
> | make[1]: Leaving directory '/home/bjorn/src/linux/linux/tools/testing/s=
elftests/bpf'
>=20
> At this point the "all" target is complete; All good, and the "install"
> is started.
>=20
> | mkdir -p /home/bjorn/output/foo/kselftest/kselftest
> | install -m 744 kselftest/module.sh /home/bjorn/output/foo/kselftest/kse=
lftest/
> | install -m 744 kselftest/runner.sh /home/bjorn/output/foo/kselftest/kse=
lftest/
> | install -m 744 kselftest/prefix.pl /home/bjorn/output/foo/kselftest/kse=
lftest/
> | install -m 744 kselftest/ktap_helpers.sh /home/bjorn/output/foo/kselfte=
st/kselftest/
> | install -m 744 kselftest/ksft.py /home/bjorn/output/foo/kselftest/kself=
test/
> | install -m 744 run_kselftest.sh /home/bjorn/output/foo/kselftest/
> | rm -f /home/bjorn/output/foo/kselftest/kselftest-list.txt
>=20
> This is from the top-level "tools/testing/selftests/Makefile", and we
> enter the BPF directory for "install".
>=20
> | make[1]: Entering directory '/home/bjorn/src/linux/linux/tools/testing/=
selftests/bpf'
> |
> | Auto-detecting system features:
> | ... llvm: [ OFF ]
> |
> | LINK-BPF [test_progs] test_static_linked.bpf.o
> | LINK-BPF [test_progs] linked_funcs.bpf.o
> | LINK-BPF [test_progs] linked_vars.bpf.o
> | LINK-BPF [test_progs] linked_maps.bpf.o
> | LINK-BPF [test_progs] test_subskeleton.bpf.o
> | LINK-BPF [test_progs] test_subskeleton_lib.bpf.o
> | ...
> | EXT-COPY [test_maps]
> | make[1]: *** No rule to make target 'atomics.lskel.h', needed by '/home=
/bjorn/output/foo/kselftest/bpf/atomics.test.o'. Stop.
> | make[1]: *** Waiting for unfinished jobs....
> | make[1]: Leaving directory '/home/bjorn/src/linux/linux/tools/testing/s=
elftests/bpf'
> | make: *** [Makefile:259: install] Error 2
> | make: Leaving directory '/home/bjorn/src/linux/linux/tools/testing/self=
tests'
>=20
> ...and for some reason the auto-dependencies decides to re-build, and
> fails.
>=20
> So, unfortunately it's something else related to your patch.

Bj=C3=B6rn,

I think I figured out the cause of the issue, but some details and a
proper solution are unclear yet.

In generated %.test.d makefiles some dependencies (in particular
%.skel.h) are referred to by filename as opposed to full path. For
example:

    $ cat /output/foo/kselftest/bpf/cpuv4/atomics.test.d
    /output/foo/kselftest/bpf/cpuv4/atomics.test.o: \
     /opt/linux/tools/testing/selftests/bpf/prog_tests/atomics.c \
     [...]
     /opt/linux/tools/testing/selftests/bpf/trace_helpers.h \
     /opt/linux/tools/testing/selftests/bpf/testing_helpers.h atomics.lskel=
.h \  # <-- THIS
     /output/foo/kselftest/bpf/tools/include/bpf/skel_internal.h \
     /output/foo/kselftest/bpf/tools/include/bpf/bpf.h

This is of course a problem, because make needs to know how to build a
target with this exact name. And in the patch it was (partially)
solved by this piece:

+# When the compiler generates a %.d file, only skel basenames (not
+# full paths) are specified as prerequisites for corresponding %.o
+# file. This target makes %.skel.h basename dependent on full paths,
+# linking generated %.d dependency with actual %.skel.h files.
+$(notdir %.skel.h): $(TRUNNER_OUTPUT)/%.skel.h
+=09@true

This links %.skel.h to /output/foo/kselftest/bpf/no_alu32/%.skel.h and alik=
e.

Your build is breaking because there is no such rule for
%.lskel.h and %.subskel.h, which are trivial to add:

--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -628,6 +628,12 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$=
(%-deps) $(BPFTOOL) | $(TR
 $(notdir %.skel.h): $(TRUNNER_OUTPUT)/%.skel.h
        @true
=20
+$(notdir %.lskel.h): $(TRUNNER_OUTPUT)/%.lskel.h
+       @true
+
+$(notdir %.subskel.h): $(TRUNNER_OUTPUT)/%.subskel.h
+       @true
+
 endif

With this change a command below completed for me in the environment
you shared:

     $ make -j \$((\$(nproc)-1)) O=3D/output/foo TARGETS=3Dbpf SKIP_TARGETS=
=3D"" KSFT_INSTALL_PATH=3D/output/foo/kselftest -C tools/testing/selftests =
install


What is a mystery to me is why this was not an issue for simple `make
-C tool/testing/selftests/bpf`. And also why in the environment I
tried yesterday I didn't get the failure you're seeing.

Do you happen to have a Dockerfile of ghcr.io/linux-riscv/pw-builder ?
If possible, I'd like to look at it and compare with my local
environment.

The other issue that I'll have to think about is the unnecessary
re-builds that you've noticed. I suspect this happens due to the same
reason: a generated dependency on X.skel.h can't find a file in
current directory (because it was put to /output/foo), and so rebuild
is triggered. I'll have to come up with a workaround.


Bj=C3=B6rn, please try a change suggested above and let me know if it helps=
.

I will investigate these problems more, and there will definitely be a
follow up patch.

Thank you for reporting.

>=20
> A reproducer:
> | $ docker run --rm -it --volume ${PWD}:/build/my-linux ghcr.io/linux-ris=
cv/pw-builder bash -l
> | # cd /build/my-linux
> | # cat > ./build.sh <<EOF
>=20
> | #!/bin/bash
> | set -euo pipefail
> |
> | rm -rf /output/foo
> | mkdir -p /output/foo
> |
> | export PATH=3D\$(echo \$PATH | tr : "\n"| grep -v ^/opt | tr "\n" :)
> |
> | make -j \$((\$(nproc)-1)) O=3D/output/foo defconfig
> | make -j \$((\$(nproc)-1)) O=3D/output/foo kselftest-merge
> | make -j \$((\$(nproc)-1)) O=3D/output/foo
> | make -j \$((\$(nproc)-1)) O=3D/output/foo headers
> | make -j \$((\$(nproc)-1)) O=3D/output/foo TARGETS=3Dbpf SKIP_TARGETS=3D=
"" KSFT_INSTALL_PATH=3D/output/foo/kselftest -C tools/testing/selftests ins=
tall
> | EOF
> |
> | # chmod +x ./build.sh
> | # ./build.sh

And thank you for a reproducer, very helpful.


