Return-Path: <bpf+bounces-65400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D3DB21844
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 00:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2D7464421
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F2E277009;
	Mon, 11 Aug 2025 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7VsB0d1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2277A221FC9
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950820; cv=none; b=pUpyXxClqLrqeu/0QMfrUi8HprBapVeiLnQ8D5HuKLtapNTXOZqBCE9d/M6zW3wUADRjWJiUiWBOTDLgFFA30ICH7dZKIkDathoVJFxttqx8XKN/Ozz6648DOgX/ZADmXSreHg+lZoCIMXxJZ+yO08KrgI4Nc5ga1GphQn+CH0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950820; c=relaxed/simple;
	bh=dL794EfEHytNyeO9iROdlZzBXbWT5d8yCfj/FT+Njbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6JEJ01S/M8GYRBvwy08Zh6wkXG6bVW60JE7Es2SDqQFOXDK48llfweJO5qUmPzhH5LiciQFcF99buIypqSqZKd1HIt0pXJ5qJ/CXSCyz343uIhZ5kql9Vk3tobibHa18q2ZLGnsssAfXpgU30H3RbDzYdQ5GQXDLPntX0v2sXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7VsB0d1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A192AC4CEF7
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754950819;
	bh=dL794EfEHytNyeO9iROdlZzBXbWT5d8yCfj/FT+Njbk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i7VsB0d1zFtUCRGUQ9+PCSBnpm/pYopHHpQUXuZaQGN6hq+x2yOGF98WTFkVL01ln
	 S5KK1n5jUOHcMFm+0R7fveZbs4qO9hkNADezeqQ4Hecs7puSxoi3L5teu+RHXLDsdv
	 z7E0PEQQMbsY4nHmjyTV5i4Bv60CDW/v3EXAza4xMDguvtLQlNK+4mzMx3v0xFVK33
	 0Y0lBkL6vuwJu9qvh63kKOACg0efsMsMaNvNXeFDiNtr+O7a8N0mkBBCPxM6Mu7QX4
	 gSbDReTQcqHeqrVB9G6jRc3Ul1fBYLnyPuoyIgVmmCEwNLWkYV/tCEmP1Fg90LywQT
	 lD1UyJ3NhIJRw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so7554090a12.3
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 15:20:19 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz20K8OY+rbVQKmwDqf59XkPCNVJndXfLzCUGCK5wTCuhJRYTrx
	DVH7ePAXga6u7cE6uPfp7bIkDYGfXssF1K498oKFlKrW7/QfcLD/q8dsTPkAMkbzzNvLKhG+zeC
	yoG6/gzcAuhnXhMZW2tQrlATc+kb0+opByjSS1IJQ
X-Google-Smtp-Source: AGHT+IGrrTJZ4YFe2orW4HiV1kP4DlTxBFucWhLcOXEv2Lp6p5DVB+i+rcsowHRGwCDHpzLQuuXwSjRZOtDF5smE7L0=
X-Received: by 2002:a05:6402:5214:b0:615:990c:6d56 with SMTP id
 4fb4d7f45d1cf-617e2b70364mr13075682a12.4.1754950818187; Mon, 11 Aug 2025
 15:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721211958.1881379-1-kpsingh@kernel.org> <20250721211958.1881379-13-kpsingh@kernel.org>
 <CAADnVQJ28MimhbBKr6ck85zBVCa9vf96aZzq0H3ZOQ-zvgzWxg@mail.gmail.com>
In-Reply-To: <CAADnVQJ28MimhbBKr6ck85zBVCa9vf96aZzq0H3ZOQ-zvgzWxg@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 12 Aug 2025 00:20:07 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5qyA2eVnnF1eOLFZqrF0HsFUnD753r+aUWartyHsMd0g@mail.gmail.com>
X-Gm-Features: Ac12FXz1mC6TjZZCXlmk7Mq_4K2Rst7Hl4LhfB1VOBZ123jjntXjsBOoejREwXM
Message-ID: <CACYkzJ5qyA2eVnnF1eOLFZqrF0HsFUnD753r+aUWartyHsMd0g@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] selftests/bpf: Enable signature verification for
 all lskel tests
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"

[...]

> >         $(Q)diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
> > -       $(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
> > +       $(Q)$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
> >         $(Q)rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
>
> Does it mean that it makes all lskel tests to be signed tests ?
> It's great that CI green lights it, but imo it's an overkill.
> Let's have a few signed tests instead of making all of them.

Updated:

diff --git a/tools/testing/selftests/bpf/Makefile
b/tools/testing/selftests/bpf/Makefile
index 1295ff8f26ff..e473e2d780fb 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -496,15 +496,16 @@ LINKED_SKELS := test_static_linked.skel.h
linked_funcs.skel.h             \
                test_subskeleton.skel.h test_subskeleton_lib.skel.h     \
                test_usdt.skel.h

-LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c           \
-       trace_printk.c trace_vprintk.c map_ptr_kern.c                   \
+LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c  \
        core_kern.c core_kern_overflow.c test_ringbuf.c                 \
        test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c

+LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
+
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
        kfunc_call_test_subprog.c
-SKEL_BLACKLIST += $$(LSKELS)
+SKEL_BLACKLIST += $$(LSKELS) $$(LSKELS_SIGNED)

 test_static_linked.skel.h-deps := test_static_linked1.bpf.o
test_static_linked2.bpf.o
 linked_funcs.skel.h-deps := linked_funcs1.bpf.o linked_funcs2.bpf.o
@@ -551,6 +552,7 @@ TRUNNER_BPF_SKELS := $$(patsubst
%.c,$$(TRUNNER_OUTPUT)/%.skel.h,   \
                                               $$(TRUNNER_BPF_SRCS)))
 TRUNNER_BPF_LSKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.lskel.h,
$$(LSKELS) $$(LSKELS_EXTRA))
 TRUNNER_BPF_SKELS_LINKED := $$(addprefix $$(TRUNNER_OUTPUT)/,$(LINKED_SKELS))
+TRUNNER_BPF_LSKELS_SIGNED := $$(patsubst
%.c,$$(TRUNNER_OUTPUT)/%.lskel.h, $$(LSKELS_SIGNED))
 TEST_GEN_FILES += $$(TRUNNER_BPF_OBJS)

 # Evaluate rules now with extra TRUNNER_XXX variables above already defined
@@ -602,6 +604,15 @@ $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o
$(BPFTOOL) | $(TRUNNER_OUTPUT)
        $(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o)
        $(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o)
        $(Q)diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
+       $(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name
$$(notdir $$(<:.bpf.o=_lskel)) > $$@
+       $(Q)rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
+
+$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
+       $$(call msg,GEN-SKEL,$(TRUNNER_BINARY) (signed),$$@)
+       $(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$<
+       $(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o)
+       $(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o)
+       $(Q)diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
        $(Q)$$(BPFTOOL) gen skeleton $(LSKEL_SIGN)
$$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
        $(Q)rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)

@@ -654,6 +665,7 @@ $(TRUNNER_TEST_OBJS:.o=.d):
$(TRUNNER_OUTPUT)/%.test.d:                     \
                            $(TRUNNER_EXTRA_HDRS)                       \
                            $(TRUNNER_BPF_SKELS)                        \
                            $(TRUNNER_BPF_LSKELS)                       \
+                           $(TRUNNER_BPF_LSKELS_SIGNED)                \
                            $(TRUNNER_BPF_SKELS_LINKED)                 \
                            $$(BPFOBJ) | $(TRUNNER_OUTPUT)

