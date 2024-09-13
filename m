Return-Path: <bpf+bounces-39871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51478978B6B
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 00:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA95E1F22F9E
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 22:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CA014B965;
	Fri, 13 Sep 2024 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ECr00oCH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571EDD502
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726266810; cv=none; b=FKq/x8F0aD0pD/8GmkBmSNUv5NJkuAd5u4dqgTDC4cUZFm/4FSO0AzL/pVWx7/rokEC9ISehS5OOG+B1//NjCbst75Y9Hk58OtdFqDcyzk9eXXqIBycmtR9XZ7pizksUlsXaFPVHumugLujOqAdhlMi3RxB8eC8VS40TUDSa1KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726266810; c=relaxed/simple;
	bh=6C/UR3aBIp1eT8HzNif8PqrDlmzBp87upRMXVbznqEI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+JM3qFsSmSa/JPz/LyCnEMX4y4rqhgHtKtKuM3MkZ4/xyUiVaDQ5ZkU4Yi2Myq8/bQ6eeWEwYupKAxYJHUdDmyhIlu+PboRxdDGdGk9skSPN7Pp+fIZZ/N5zu4yMHgiHsLTSEQFYaXvp+tBJZE12mBeWt6sO8t6z9opd0YH/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ECr00oCH; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1726266805; x=1726526005;
	bh=cMEdYYm/zQ4ib6nW+Cxx9aZjUyWf8wlIfSwBKqgh7Ng=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ECr00oCHzZ8bhqmVSQvffYr3OLdhf9KcPvYLGcrvGnJvYxkpSHP9IvnGUQ+078sJ0
	 jIM11sX/S3/JuH/P/bS0zHTPQlRt5sZWSJYGTDlk4hN4ZS6C5tFogm8AVtZa0zahMb
	 osudRJh7Ob8/uw60aw5xC7j1YH74K4iUX9VjwG0UHm6gjGZV0oCBLhQJ0bCJ8IoIAz
	 793YGvLaoAQdz/u0nXPKZZ0BB8a5Ll0DlPwNTvemOPWgDLkts7g8QzOGPbE4Q5yKF+
	 krMvOUElxsc9h47Bg9bAWxDxfVJ6FA0gHgZYykUDxw3Qs2J5kPdgvg+PxEiZOUUJPl
	 dqtqd9PaukDzg==
Date: Fri, 13 Sep 2024 22:33:20 +0000
To: =?utf-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii.nakryiko@gmail.com, bpf@vger.kernel.org, ast@kernel.org, eddyz87@gmail.com, daniel@iogearbox.net, mykolal@fb.com, Anders Roxell <anders.roxell@linaro.org>, patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for test objects
Message-ID: <Q3BN2kW9Kgy6LkrDOwnyY4Pv7_YF8fInLCd2_QA3LimKYM3wD64kRdnwp7blwG2dI_s7UGnfUae-4_dOmuTrxpYCi32G_KTzB3PfmxIerH8=@pm.me>
In-Reply-To: <877cbfwqre.fsf@all.your.base.are.belong.to.us>
References: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me> <172141323037.13293.5496223993427449959.git-patchwork-notify@kernel.org> <877cbfwqre.fsf@all.your.base.are.belong.to.us>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 36979acc2c453f638e5b7816cd84ef3ac5d0971e
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, September 13th, 2024 at 7:51 AM, Bj=C3=B6rn T=C3=B6pel <bjorn@ke=
rnel.org> wrote:

> I'm getting some build regressions for out-of-tree selftest build with
> this patch on bpf-next/master. I'm building the selftests from the
> selftest root, typically:
>=20
> make O=3D/output/foo SKIP_TARGETS=3D"" \
> KSFT_INSTALL_PATH=3D/output/foo/kselftest \
> -C tools/testing/selftests install
>=20
> and then package the whole output kselftest directory, and use that to
> populate the DUT.
>=20
> Reverting this patch, resolves the issues.
>=20
> Two issues:
>=20
> 1. The install target fails, resulting in many test scripts not copied
> to the install directory (e.g. test_kmod.sh).
> 2. Building "all" target fails the second time.
>=20
> To reproduce, do the following:
>=20
> Pre-requisite
> Build the kernel for yourfavorite arch -- my is RISC-V at moment ;-)
>=20
> make O=3D/output/foo defconfig
> make O=3D/output/foo kselftest-merge
> make O=3D/output/foo
> make O=3D/output/foo headers
>=20
> 1. Install fail
> make O=3D/output/foo TARGETS=3Dbpf SKIP_TARGETS=3D"" \
> KSFT_INSTALL_PATH=3D/output/foo/kselftest \
> -C tools/testing/selftests install
>=20
> 2. Build "all" fails the second time
> make O=3D/output/foo TARGETS=3Dbpf SKIP_TARGETS=3D"" \
> KSFT_INSTALL_PATH=3D/output/foo/kselftest \
> -C tools/testing/selftests
>=20
> make O=3D/output/foo TARGETS=3Dbpf SKIP_TARGETS=3D"" \
> KSFT_INSTALL_PATH=3D/output/foo/kselftest \
> -C tools/testing/selftests
>=20
>=20
> Any ideas on a workaround?

Hi Bj=C3=B6rn.

I was able to reproduce the problem on bpf-next/master.

I found that in commit
https://git.kernel.org/bpf/bpf-next/c/f957c230e173 [1] the file
tools/testing/selftests/bpf/test_skb_cgroup_id.sh was deleted, but not
removed from the TEST_PROGS list in tools/testing/selftests/bpf/Makefile

Because of that rsync command (invoked by install target) fails:

    rsync: [sender] link_stat "/opt/linux/tools/testing/selftests/bpf/test_=
skb_cgroup_id.sh" failed: No such file or directory (2)
    rsync error: some files/attrs were not transferred (see previous errors=
) (code 23) at main.c(1333) [sender=3D3.2.3]
    make[1]: *** [../lib.mk:175: install] Error 23
    make[1]: Leaving directory '/opt/linux/tools/testing/selftests/bpf'
    make: *** [Makefile:259: install] Error 2
    make: Leaving directory '/opt/linux/tools/testing/selftests'


After I removed test_skb_cgroup_id.sh from TEST_PROGS list, the
install target completed successfully.

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index f04af11df8eb..df75f1beb731 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -132,7 +132,6 @@ TEST_PROGS :=3D test_kmod.sh \
        test_tunnel.sh \
        test_lwt_seg6local.sh \
        test_lirc_mode2.sh \
-       test_skb_cgroup_id.sh \
        test_flow_dissector.sh \
        test_xdp_vlan_mode_generic.sh \
        test_xdp_vlan_mode_native.sh \

Could you please check on your side if this helps? Maybe there are
other issues.

[1] https://lore.kernel.org/bpf/20240813-convert_cgroup_tests-v4-4-a33c0345=
8cf6@bootlin.com/

>=20
> (And not related to this patch; It's annoying that "bpf" is the default
> SKIP_TARGETS in kselftest. A bit meh 2024. ;-))
>=20
>=20
> Bj=C3=B6rn
>=20


