Return-Path: <bpf+bounces-35030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935FA9370CE
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 00:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CADA281D71
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 22:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B3714601C;
	Thu, 18 Jul 2024 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Ona2C909"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F067E782
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721342541; cv=none; b=sx0N8iMAuYEdSJ1xGqQZya7bo4SDtxhDq8lpL5/d9EzGHRbRpw9shCc56oL9BzzW1WZO8waIQ4vqF/Imx0erLFpz07t7N1iVK1N3UvMGvZrLAnL5SdVhSj9AlVXpA4dibK8MjYmifq1/Yhih90HrrT/XSJtzqIplHd6t+jTr6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721342541; c=relaxed/simple;
	bh=Hkt+BO4HhWLSSQQ8z1jDa0YQM7taAOTBVyjI1ZxNbVs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WsK4v51qgePnSRYIxk5vTRIx1hi0ldvM3WwLtDXnUM+y6hrNe6BzHhGgJiIRYg4gy5ZPcmHt9jbJmnEIA00A/L3MBm2VW0uZxhxXo9T4XchSzEwj5eLdAxVu+tNA/yhLcUhRyJoFWheZwZEZa2qs2jZCHmF18Fc9ulS3O0Vhgaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Ona2C909; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1721342537; x=1721601737;
	bh=8T4KSgHIxxkdNnMtvSKSUJLEUhzPxptdNBNw1lNGKXo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ona2C909OBTav/K2t3LoFjydrR5DUplvGeQakFv2zpAOj8sZf5UDYgRmM13SY7+95
	 C9/TtYNOGoB++xloDxlh0VxZ2funz1PUknYLch6oTx+1kC0/b7cTHXzmo+ne4cOU6A
	 m15ReoFJ2y1SQ8WOJDL/zXs9XPKMrR1E75jLLsBs1Vtf6JQa7VSuMa2kt01xlzze4y
	 CD1HOLZZaqJQxqn6uNP03jyeuIZIV+oMvAl/K5pBbgfAhIpHNYhNIesaBVSBHhP2Rh
	 41ECfJ54xMr/Alx9Bok852DweiScrx2yVOk7CtlgxmEC1MUDhlCM4xpGvt/c3Mb54V
	 b7kU4Y2Ge3ALA==
Date: Thu, 18 Jul 2024 22:42:12 +0000
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "mykolal@fb.com" <mykolal@fb.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for test objects
Message-ID: <qPy-7H7OLM_5N6g_SybDgMR7qG82-h_mvpJ6zx6r9hpvtTOpxT3qKYbK8PbvkVACTLVcP-REWGKXcPDGIVjuYi1EBEVPIiJeSgzAIcw1Llc=@pm.me>
In-Reply-To: <CAEf4BzZ+eDUAN8LE4duRqY+W4BkXoVx_TZbWj6fVLNzm9EeVsg@mail.gmail.com>
References: <gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me> <b97340645b9a730df46e69b03b3ccba39816c414.camel@gmail.com> <CAEf4BzYFad_hhk+ju1_Y+JeDGmOeD-Ur=+Yvfu2vkbR3frR6SQ@mail.gmail.com> <k7SpuAM7weZyfgdgXEHzOiDkk8iBsBrl7ZsTpvhKQNvijS8cWjJrBN9DVOxF45edRXxA2POvIu9cZce3bF2FmoFOEbfevr09X-1c1pKgZrw=@pm.me> <CAEf4Bzatg_CsKf7HeekaO3ZroXWg1ceJBgZ9KPWf2VkK1yKQ6Q@mail.gmail.com> <bcee1451ef43fd08675e1296b1ce82058cd29d94.camel@gmail.com> <CAEf4BzaLatHkXGZ5pmNSC+b5_iZKBeeGqkS-VE8SwXQySviUHg@mail.gmail.com> <e33b186a5f728a96987347964a622cab64543189.camel@gmail.com> <CAEf4BzZ+eDUAN8LE4duRqY+W4BkXoVx_TZbWj6fVLNzm9EeVsg@mail.gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: d24dd065b749051fecb052b38cd8bdda93b660c0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, July 18th, 2024 at 8:34 AM, Andrii Nakryiko <andrii.nakryiko@g=
mail.com> wrote:

[...]

> > > > - by adding a catch-all clause in the makefile, e.g. making test
> > > > runner depend on all .bpf.o files.
> > >=20
> > > do we actually need to rebuild final binary if we are still just
> > > loading .bpf.o from disk? We are not embedding such .bpf.o (embedding
> > > is what skeleton headers are adding), so why rebuild .bpf.o?
> > >=20
> > > Actually thinking about this again, I guess, if we don't want to add
> > > skel.h to track precise dependencies, we don't really need to do
> > > anything extra for those progs/*.c files that are not used through
> > > skeletons. We just need to make sure that they are rebuilt if they ar=
e
> > > changed. The rest will work as is because test runner binary will jus=
t
> > > load them from disk at the next run (and user space part doesn't have
> > > to be rebuilt, unless it itself changed).
> >=20
> > Good point. This can be achieved by making $(OUTPUT)/$(TRUNNER_BINARY)
> > dependency on $(TRUNNER_BPF_OBJS) order-only, e.g. here is a modified
> > version of the v2: https://tinyurl.com/4wnhkt32
>=20
>=20
> +1

I agree. I'll submit v4 with this change.


> > [...]
> >=20
> > > another side benefit of completely switching to .skel.h is that we ca=
n
> > > stop copying all .bpf.o files into BPF CI, because test_progs will be
> > > self-contained (thought that's not 100% true due to btf__* and maybe =
a
> > > few files more, which is sad and a bit different problem)
> >=20
> > Hm, this might make sense.
> > There are 410Mb of .bpf.o files generated currently.
> > On the other hand, as you note, one would still need a list of some
> > .bpf.o files, because there are at-least several tests that verify
> > operation on ELF files, not ELF bytes.

This seems worthwhile to look into, although I think it's a task
independent of this patch.


> > [...]
> >=20
> > > keep in mind that we do want to rebuild .bpf.o if libbpf's BPF-side
> > > headers changed, so let's make sure that stays (or happens, if we
> > > don't do it already)
> >=20
> > Commands below cause full rebuild (.test.o, .bpf.o) on v2 of this
> > patch-set:
> > $ touch tools/lib/bpf/bpf.h
> > $ touch tools/lib/bpf/libbpf.h
>=20
>=20
> yeah, ideally they wouldn't cause bpf.o rebuilds... I think we should
> tune .bpf.o to depend only on BPF-side headers (we'd need to hard-code
> them, but they don't change often: usdt.bpf.h, bpf_tracing.h,
> bpf_helpers.h, etc). I don't think we can get rid of BPF skeletons'
> dependency on bpftool (which depends on any libbpf change), though,
> so .skel.h will be regenerated due to any tiny libbpf change, but
> that's still better, as bpf.o building is probably the slowest part.

I tried a small experiment, and specifying particular lib/bpf headers
didn't help because of vmlinux.h

I grepped the list of headers with:

    $ grep -rh 'include <bpf/' progs | sort -u

    #include <bpf/bpf_core_read.h>
    #include <bpf/bpf_endian.h>
    #include <bpf/bpf_helpers.h>
    #include <bpf/bpf_tracing.h>
    #include <bpf/usdt.bpf.h>

Then, changed $(TRUNNER_BPF_OBJS) dependencies like this:

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index 66478446af9d..6fb03bb9b33a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -480,6 +480,13 @@ xdp_features.skel.h-deps :=3D xdp_features.bpf.o
 LINKED_BPF_OBJS :=3D $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
=20
+HEADERS_FOR_BPF_OBJS :=3D bpf_core_read.h        \
+                       bpf_endian.h            \
+                       bpf_helpers.h           \
+                       bpf_tracing.h           \
+                       usdt.bpf.h
+HEADERS_FOR_BPF_OBJS :=3D $(addprefix $(BPFDIR)/,$(HEADERS_FOR_BPF_OBJS))
+
 # Set up extra TRUNNER_XXX "temporary" variables in the environment (relie=
s on
 # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
 # Parameters:
@@ -530,14 +537,15 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:      =
                     \
                     $(TRUNNER_BPF_PROGS_DIR)/%.c                       \
                     $(TRUNNER_BPF_PROGS_DIR)/*.h                       \
                     $$(INCLUDE_DIR)/vmlinux.h                          \
-                    $(wildcard $(BPFDIR)/bpf_*.h)                      \
-                    $(wildcard $(BPFDIR)/*.bpf.h)                      \
+                    $(HEADERS_FOR_BPF_OBJS)                            \
                     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
        $$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,                      \
                                          $(TRUNNER_BPF_CFLAGS)         \
                                          $$($$<-CFLAGS)                \
                                          $$($$<-$2-CFLAGS))

This didn't help because

     $ touch ~/work/kernel-clean/tools/lib/bpf/bpf.h

triggers rebuild of vmlinux.h, which depends on $(BPFTOOL), and
bpftool depends on $(HOST_BPFOBJ) or $(BPFOBJ), and they in turn
depend on all files in lib/bpf.

And there is a direct dependency of $(TRUNNER_BPF_OBJS) on vmlinux.h,
which looks like a real dependency to me, but maybe I don't know
something.


