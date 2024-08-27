Return-Path: <bpf+bounces-38118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC9C95FE36
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 03:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B472829C7
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 01:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDA44C80;
	Tue, 27 Aug 2024 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="jMaCgknK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2672F26
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724721748; cv=none; b=Belu7SC7A8mhtCxkifK7dz9KTWYB8FoMWv9gR/HGCDxGyfqKr6db0nOcJwFbxO3K0Gk+30tShbJVhR8J4lHKikmSR2r4KHGN3PCl0k/2YRvCpPR3R6izbd32UdgiB8Mcs0XkM7LKkxQz9x0Tpr2kU77ZQwjdcfPpG4ygEa/3AWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724721748; c=relaxed/simple;
	bh=pTHgqlhqIF1FhMWYOVfl104D9Osq2jT9dgsAQt4H87I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peXXy9e5bVGm9tFtt/o8vh4ocV1J+W3YKq/e7m3KRRQ5lxGFVZVmRhspLr/KTl0OndNYRCyojhYwNTGh87ivhFL1ETg6/ufHqeFc2EYXheXrruvn5eyO3TfTpP5bR0op9kYzBSFwIqMsnP+ier2bstnUFkcAcQmkMSghr0F2T38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=jMaCgknK; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1724721738; x=1724980938;
	bh=c67yl5bHYZ7kFaiCr2EC1uh6VDHpytrcrNzwTkjZ4Lw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jMaCgknKoLQKI6iqwm/Aa9uj1xI7yOuaZJdQrPS3ZbUDg32FsjUglKQr1gNpnxtgE
	 3YgcvUjlUIHQA+cGFn9VK8C0/oNe1c6V/v5jheEG89F7Vl1C7mMm83LQEZewQDy5bL
	 tNxPTrQ8sin7afh9nZs12lavlBdZCHE1FL9qjZxyGpeubsOwuvDXhJMGkgP3aG6j3T
	 AtCJ4r2JJWp9AtjRMfUfLqyJxmceEA9t7QfdS0E7qycOnhMrpJKpP3weclJoIIA37b
	 zF5DJeWImfOm60FVO18vwoWwINMQSJZczvTo8kMV29MnCsR0hWI31QhggCrDfyXE6t
	 km3wjO4JZPsJA==
Date: Tue, 27 Aug 2024 01:22:15 +0000
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, "mykolal@fb.com" <mykolal@fb.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: compare vmlinux.h checksum when building %.bpf.o
Message-ID: <NlxQiywYmu4MyGt1DSHPsHoslAKqqqeFoMBQ04NZsJITsVCbnucbWel87tw50N0sU_TrQ1osPMNLt5_iTBisRhm2rYn262Ip0ZrJMAL0sYc=@pm.me>
In-Reply-To: <CAEf4BzaixE=-+YnowJhZMDk0SoVdZTHgx-X+3UwnJVUnXxkXzQ@mail.gmail.com>
References: <TCvb-R45mBUJOpoW3V-tLkH2XppfNXYbkv7Ph0ae8J9MZKWFvQ3nkJw74KKMbMzzpAvbwXBwRuBmhFOtHl0-jLLrIALH-_2_Zp-MZ9pPXPo=@pm.me> <CAEf4BzaixE=-+YnowJhZMDk0SoVdZTHgx-X+3UwnJVUnXxkXzQ@mail.gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 960950bb062de55713ddf4904499433096506834
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andrii, thanks for a review.

On Monday, August 26th, 2024 at 2:59 PM, Andrii Nakryiko <andrii.nakryiko@g=
mail.com> wrote:

[...]

> I'm not sure what md5sum buys us here, tbh... To compute checksum you
> need to read entire contents anyways, so you are not really saving
> anything performance-wise.
>=20
> I was originally thinking that we'll extend existing rule for
> $(INCLUDE_DIR)/vmlinux.h to do bpftool dump into temporary file, then
> do `cmp --silent` over it and existing vmlinux.h (if it does exist, of
> course), and if they are identical just exit and not modify anything.
> If not, we just mv temp file over destination vmlinux.h.

>=20
> In my head this would prevent make from triggering dependent targets
> because vmlinux.h's modification time won't change.
>=20
> Does the above not work?

I tried your suggestion and it works too. I like it better, as it's a
smaller change (see below).

A checksum was just the first idea I had about saving the previous
state of vmlinux.h, and I went with it. Copying an entire file seemed
excessive to me, but it's not necessary as it turns out.

Please let me know if the cmp version is ok, and I'll send v2 of the
patch.

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index c120617b64ad..25412b9194bd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -402,7 +402,8 @@ endif
 $(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
 ifeq ($(VMLINUX_H),)
 =09$(call msg,GEN,,$@)
-=09$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+=09$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $(INCLUDE_DIR)/.=
vmlinux.h.tmp
+=09$(Q)cmp -s $(INCLUDE_DIR)/.vmlinux.h.tmp $@ || mv $(INCLUDE_DIR)/.vmlin=
ux.h.tmp $@
 else
 =09$(call msg,CP,,$@)
 =09$(Q)cp "$(VMLINUX_H)" $@
@@ -516,6 +517,12 @@ xdp_features.skel.h-deps :=3D xdp_features.bpf.o
 LINKED_BPF_OBJS :=3D $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
=20
+HEADERS_FOR_BPF_OBJS :=3D $(wildcard $(BPFDIR)/*.bpf.h)=09=09\
+=09=09=09$(addprefix $(BPFDIR)/,=09bpf_core_read.h=09\
+=09=09=09                        bpf_endian.h=09\
+=09=09=09=09=09=09bpf_helpers.h=09\
+=09=09=09                        bpf_tracing.h)
+
 # Set up extra TRUNNER_XXX "temporary" variables in the environment (relie=
s on
 # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
 # Parameters:
@@ -566,8 +573,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:=09=09=
=09=09\
 =09=09     $(TRUNNER_BPF_PROGS_DIR)/%.c=09=09=09\
 =09=09     $(TRUNNER_BPF_PROGS_DIR)/*.h=09=09=09\
 =09=09     $$(INCLUDE_DIR)/vmlinux.h=09=09=09=09\
-=09=09     $(wildcard $(BPFDIR)/bpf_*.h)=09=09=09\
-=09=09     $(wildcard $(BPFDIR)/*.bpf.h)=09=09=09\
+=09=09     $(HEADERS_FOR_BPF_OBJS)=09=09=09=09\
 =09=09     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
 =09$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,=09=09=09\
 =09=09=09=09=09  $(TRUNNER_BPF_CFLAGS)         \
--=20
2.34.1



