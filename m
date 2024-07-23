Return-Path: <bpf+bounces-35417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA3493A7AD
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 21:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67672847D4
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 19:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2BC1422AB;
	Tue, 23 Jul 2024 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Eg1uU+YP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A213E04C
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762748; cv=none; b=HY2kZ+PtDMjHhiE2Lyyq9rS0FXa6v1QIU4JrY7rADloH34UGkvh4r3SdPpcjEK4r8oToTQ5pBFAdVbFOuD9vK5OJnXJT1J9vqQDtiIWVcUPv4FPB7S4vawsDCi9UABobk0lWpaYtAVkbkNi94zbbYVIXh+rumUzy7C1/MpJadmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762748; c=relaxed/simple;
	bh=uEW8LG4aN+XdE8wJnO4D9KxMZeTEki/9d/CcEv9p94Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jv3iJ9Xr1DgUM1HslsYU+k9IXOdXTUekFVOa2WC2bL/CzmjFfI6XbrPvX2ineFkIJMJnn0ga6GtAdzELHk38JZfloZ8OWN4332Dt4zj7rHupTd9H2NmcbZBK1BGqnOPI/9pRBa4REhhADukG67vQrs3YY3Bbs1lkwZqxP5gex7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Eg1uU+YP; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1721762738; x=1722021938;
	bh=qkMKVu11tP05K2DSZmPJzy3+skOI4xRfmau7LxbxcWI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Eg1uU+YPTDafnkC5nMERhxXeccw5A1F+hO/a8NY0SbCqfLDM5suewnKpOHJLBVx98
	 hQPiClg97FgIyk7yiFIgdZIiOTLn71UVOqb/iMJIWmUgU3JDT8OHSkmb4bHI354Yzk
	 DeRnJhBId0DfhCO3TNHkIYyYGL5PIA9nHVB2hBSmNIgSTas3XftuMh1xvQJCKwFuy2
	 IySj7GUHYgQzyS1I1qyQfbxl1+hzxFA+azvrqDaIszyqsacwPEFFHqboQCTA0pUe88
	 g2ohfnRxQ7eHLgg/RSoimb6tJq1IPhC4HRVoXoEFZ5NOROVMj15wKCxSbDBo7C6wtC
	 xUdgvOh3erYDw==
Date: Tue, 23 Jul 2024 19:25:34 +0000
To: Ihor Solodrai <ihor.solodrai@pm.me>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, patchwork-bot+netdevbpf@kernel.org, bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Mykola Lysenko <mykolal@fb.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for test objects
Message-ID: <FnnOUuDMmf0SebqA1bb0fQIW4vguOZ-VcAlPnPMnmT2lJYxMMxFAhcgh77px8MsPS5Fr01I0YQxLJClEJTFWHdpaTBVSQhlmsVTcEsNQbV4=@pm.me>
In-Reply-To: <oNTIdax7aWGJdEgabzTqHzF4r-WTERrV1e1cNaPQMp-UhYUQpozXqkbuAlLBulczr6I99-jM5x3dxv56JJowaYBkm765R9Aa9kyrVuCl_kA=@pm.me>
References: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me> <172141323037.13293.5496223993427449959.git-patchwork-notify@kernel.org> <CAADnVQ+F6JKp1e61NC22wt8L9YEVAz9w648GvdV8hUrM3dkDFA@mail.gmail.com> <24a6649743528b2c8f44cc5415df32a3020b0951.camel@gmail.com> <oNTIdax7aWGJdEgabzTqHzF4r-WTERrV1e1cNaPQMp-UhYUQpozXqkbuAlLBulczr6I99-jM5x3dxv56JJowaYBkm765R9Aa9kyrVuCl_kA=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 759dec6cae85bd82ce31250eaa5bd06274c832ff
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii,

I looked over the v4 of the patch, and apparently I messed it up by
losing the v1 -> v2 change. So the issue with dump order of %.test.d
relative to %.test.o files is present on the master branch right now.

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index 74f829952..4bcb1d1ce 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -596,7 +596,7 @@ endif
 # Note: we cd into output directory to ensure embedded BPF object is found
 $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:                      \
                      $(TRUNNER_TESTS_DIR)/%.c                          \
-                     $(TRUNNER_OUTPUT)/%.test.d
+                     | $(TRUNNER_OUTPUT)/%.test.d
        $$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
        $(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$=
< $$(LDLIBS) -o $$(@F)

I can send this fix together with the condition for the clean targets
(so [1] can be discarded); or I can submit a separate change. Let me
know what you'd prefer.


I also had a discussion with Eduard off-list, he suggested trying to
remove explicit %.test.d targets altogether like this:

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 05b234248b38..f01dc1cc8af8 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -596,18 +596,12 @@ endif
>  # Note: we cd into output directory to ensure embedded BPF object is fou=
nd
>  $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:=09=09=09\
>  =09=09      $(TRUNNER_TESTS_DIR)/%.c=09=09=09=09\
> -=09=09      $(TRUNNER_OUTPUT)/%.test.d
> +=09=09      | $(TRUNNER_BPF_SKELS)=09=09=09=09\
> +=09=09      =09$(TRUNNER_BPF_LSKELS)=09=09=09=09\
> +=09=09      =09$(TRUNNER_BPF_SKELS_LINKED)
>  =09$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
>  =09$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< =
$$(LDLIBS) -o $$(@F)
>
> -$(TRUNNER_TEST_OBJS:.o=3D.d): $(TRUNNER_OUTPUT)/%.test.d:=09=09=09\
> -=09=09=09    $(TRUNNER_TESTS_DIR)/%.c=09=09=09\
> -=09=09=09    $(TRUNNER_EXTRA_HDRS)=09=09=09\
> -=09=09=09    $(TRUNNER_BPF_SKELS)=09=09=09\
> -=09=09=09    $(TRUNNER_BPF_LSKELS)=09=09=09\
> -=09=09=09    $(TRUNNER_BPF_SKELS_LINKED)=09=09=09\
> -=09=09=09    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
> -
>  include $(wildcard $(TRUNNER_TEST_OBJS:.o=3D.d))
>
>  $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:=09=09=09=09\
> --=20
> 2.45.2

This works almost as we want it, except for a situation when any
%.test.d gets deleted (say, due to local branch switch). In such case,
if one forgets to run `make clean`, there is no dependency of the
%.test.o on skels, and so they won't be properly updated.

After some discussion, me and Ed concluded that we shouldn't expect
people to remember to do clean in particular situations, especially if
consequences are not obvious. So the state after the suggested fixes
would be good enough.

[1] http://lore.kernel.org/K69Y8OKMLXBWR0dtOfsC4J46-HxeQfvqoFx1CysCm7u19HRx=
4MB6yAKOFkM6X-KAx2EFuCcCh_9vYWpsgQXnAer8oQ8PMeDEuiRMYECuGH4=3D@pm.me



