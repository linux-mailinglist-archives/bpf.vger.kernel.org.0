Return-Path: <bpf+bounces-48179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D52AA04DF6
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 00:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3014C7A259A
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 23:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C205D1F7098;
	Tue,  7 Jan 2025 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="nB2caj5t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3741DF27C
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736294307; cv=none; b=m8iFYUoX8sPdZeHUqJK8al2CUcgJayX2o6b0EqpCSCWwRBQTaDhaBhLEOAOP+4AWHCU1MVmXE/2b46t7Dz0P6iwIRfYxaYxY/0akQgNZhhVtNwIcdKZEkozVp5Zt1/oKdUAya25mUEfkaAFbaypuNO045gUL4gWNNwDAEiUW/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736294307; c=relaxed/simple;
	bh=PX6WR0ighR1FSHCgnyKiI7BWq3tm+IIkI6Hj915cUvk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=W4PYDgGKC4dVvU0EsGoaQDj2J+Nv6rk0Jc5gs1UNdHzkxEDrTEk2oHdLwVW6h3xzazJQc9bCJRdOhAQEVyROJkfdADhuG4I68cBZMxR59OQSFbbh6j2PDkvakVsZ0MFsZ3bSxOn8jYxaLVlGKmDPt9t8fYhnGAYZM3gYyWN+CiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=nB2caj5t; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736294302; x=1736553502;
	bh=WzkslidAtiEky4gugCpwHrhwgYrEOLgNVfO/MW6XYvE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=nB2caj5th+8zfyNTOYnzZRTn8ovt0m4217Gtxqlk7XygxmdZ9xfVHgj6WjubcsTm3
	 ndiLb/bjMVDxOWb5JTprFPpU4g3wK6P/A0dRIQzxiPzkSkCGJhLEAzl0nUX/e9w+a8
	 EqwDIpK957awtr31G/E8m2Nlgo00+0rLSkOTqb0jnANfwHe92ZJZSyDg33SWB8nrld
	 SGZ4UlX7Or61v6fjcBSNGGg7YBnPvRv6GhGZlH9XfKAt+FvWVXadqb088BvemX99im
	 Wx6ymuOnjEolrRKVbl2m+tt1jcrw0Md4ctlW2dW13d0kvjtAWntKCr+2/wm+VIvmAC
	 OYbZ31TESf2hA==
Date: Tue, 07 Jan 2025 23:58:18 +0000
To: bpf@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, jose.marchesi@oracle.com
Subject: [PATCH] selftests/bpf: add -std=gnu11 to BPF_CFLAGS and CFLAGS
Message-ID: <20250107235813.2964472-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: ebc102b249da6a071d02bc2d823b554ce60b4e34
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Latest versions of GCC BPF use C23 standard by default. This causes
compilation errors in vmlinux.h due to bool types declarations.

Add -std=3Dgnu11 to BPF_CFLAGS and CFLAGS. This aligns with the version
of the standard used when building the kernel currently [1].

For more details see the discussions at [2] and [3].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Makefile#n465
[2] https://lore.kernel.org/bpf/EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzXm2qi=
6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=3D@pm.me/
[3] https://lore.kernel.org/bpf/20250106202715.1232864-1-ihor.solodrai@pm.m=
e/

CC: Jose E. Marchesi <jose.marchesi@oracle.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/testing/selftests/bpf/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index d5be2f94deef..ea9cee5de0f8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -41,7 +41,7 @@ srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
 srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
 endif
=20
-CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic=09=09=09=09=09\
+CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic -std=3Dgnu11=09=09=09=09\
 =09  -Wall -Werror -fno-omit-frame-pointer=09=09=09=09\
 =09  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)=09=09=09\
 =09  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)=09=09\
@@ -447,6 +447,7 @@ CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG)=
,$(CLANG_TARGET_ARCH))
 BPF_CFLAGS =3D -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)=09\
 =09     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)=09=09=09\
 =09     -I$(abspath $(OUTPUT)/../usr/include)=09=09=09\
+=09     -std=3Dgnu11=09=09 =09=09=09=09=09\
 =09     -fno-strict-aliasing =09=09=09=09=09\
 =09     -Wno-compare-distinct-pointer-types
 # TODO: enable me -Wsign-compare
@@ -787,9 +788,12 @@ $(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/netwo=
rk_helpers.o $(OUTPUT)/xdp
 =09$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
=20
 # Make sure we are able to include and link libbpf against c++.
+CXXFLAGS +=3D $(CFLAGS)
+CXXFLAGS :=3D $(subst -D_GNU_SOURCE=3D,,$(CXXFLAGS))
+CXXFLAGS :=3D $(subst -std=3Dgnu11,-std=3Dgnu++11,$(CXXFLAGS))
 $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOB=
J)
 =09$(call msg,CXX,,$@)
-=09$(Q)$(CXX) $(subst -D_GNU_SOURCE=3D,,$(CFLAGS)) $(filter %.a %.o %.cpp,=
$^) $(LDLIBS) -o $@
+=09$(Q)$(CXX) $(CXXFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
=20
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
--=20
2.47.1



