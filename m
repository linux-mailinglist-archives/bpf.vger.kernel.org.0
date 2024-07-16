Return-Path: <bpf+bounces-34935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65886933484
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 01:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBF1284366
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 23:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93590143733;
	Tue, 16 Jul 2024 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9A6R1lx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9377249F5
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721172092; cv=none; b=q+/SfEOR96oSi+raj7fyaigp3o43RyVSvueYv41Vt3as4+bc+SLmbFUTlcPjdY4MyRX5RRV8PJxcaOBQcViJo/xVxHDPdMdFEZSYqwRY9L0ui9l+802rn4bZd+td6XaxADSjwHdPD9nGFiI5Ya+1GiyiRPY5d5euotuAqqAImyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721172092; c=relaxed/simple;
	bh=xcqdtq5IzFakVW022/y7nqTUhH8Bkp3qouxyc1ttMwc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwjtvlgGypadMycC72g/EBJ0cXrIZXdLHACEPCtwd0K8NZW6qWAUr2Z/O7cGG672Xcrq/rS32NAqAZZtEAqSUxK9X2fMMdrSCYsI9hz5LIekV76CwM+WTd6N6sWWRII7SsZMQBNvAN/EiD5H0BbHQ1Hf/nsm6Ez5ibjWrqrumKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9A6R1lx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fb1c69e936so34401695ad.3
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 16:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721172090; x=1721776890; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x7J/zY+rUazHv6XtzacoInxXJyJEb2GaLPROVLAhtfY=;
        b=m9A6R1lxjCfrFWEmLGrcA2EsburukUbVOqRkuWSQR3ug0pLTxFOi0B8o8LdN4k6cwK
         6Q2hrsMMSSoaFSmM2RUUM8RyqRx/UBSVo46grB/vxEDLeYeEMh7uMaKGKdwTaurGouql
         1i6dYYASatDkAna1uvK0YVrJc7BKNwYFmA7dEYpBk/CGh1VRHvNvaFZoTOrd4nYGeHm2
         z+O65VmKegIw/Gu4GIbb1Bv9RJ2nfznEl9sxfwQdXWD0GU/BqOBlJEgulCQT8uQonBnn
         6sFeaMSpi44qqKqge5T3O1LCh7hCh1YYdcCBPO0bYjStRZUSyEhzjq0/I8hL57PkeTUw
         HILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721172090; x=1721776890;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7J/zY+rUazHv6XtzacoInxXJyJEb2GaLPROVLAhtfY=;
        b=llyrg+8I2p3N7yQJN3Yh1CHCEuvBTB7vuld1cVDVQu1IOsXfVjTKiU0raFInuVCVFo
         5FqCZn701IT2N9ye5cGC80OtwmtFmJ1Jp+pj4yKC1J/KCDQans+ky52GkDWZ4s7VNuqf
         aahILpHEsQLu1LUuBK+lfQ3yb19usAwsSykFHrgd0QciB/GC609Cx26Cr0w7cm2ah1O7
         BfisD/+25toCNMg2V1DP+RgdULnaO6KKZITjwSut9CFI6K0IJMjyo+2bKuq2m+ZLzyAa
         SPckzUQBklwQhV6+8hSDMn0813RTx1YsIzAlsBxWWlhkLOnmZ7kI55052tYxmClnkpzG
         fs2w==
X-Forwarded-Encrypted: i=1; AJvYcCXCGD9pXOM9JpKVAbwC02cxeks7dAVHEp33C6eTqYyNYh3twQbbDAnHFynp6SHZF4ShrCU9uuE1BSwwHqxP2ASWNvNf
X-Gm-Message-State: AOJu0YzvsprVW81N5/NlhisLBbcKNm5u63Zwm2/HA2RQVwfIDGWLQebh
	/3hGbvi9syAILNlTEhXrlXzDBWpoiIRsNoGJXA9473k62DkILVH0AV9pRQ==
X-Google-Smtp-Source: AGHT+IFed6QfE1pKhNqNVibJcXzBxpVcPKjf/MAeoQQgGCrepezPIgfxrJMrpIbwtaR43LQdxvY2gA==
X-Received: by 2002:a17:902:c40c:b0:1fb:6ea1:4c with SMTP id d9443c01a7336-1fc3d951074mr33762065ad.23.1721172089808;
        Tue, 16 Jul 2024 16:21:29 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc384ecsm63876925ad.208.2024.07.16.16.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 16:21:29 -0700 (PDT)
Message-ID: <bcee1451ef43fd08675e1296b1ce82058cd29d94.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for
 test objects
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Ihor Solodrai
	 <ihor.solodrai@pm.me>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>,
 "andrii@kernel.org" <andrii@kernel.org>, "mykolal@fb.com" <mykolal@fb.com>
Date: Tue, 16 Jul 2024 16:21:24 -0700
In-Reply-To: <CAEf4Bzatg_CsKf7HeekaO3ZroXWg1ceJBgZ9KPWf2VkK1yKQ6Q@mail.gmail.com>
References: 
	<gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me>
	 <dcbf532f-bf17-bb8c-f798-987bce607e5d@iogearbox.net>
	 <R36QrBuK6nQziAeE9Xb-8295ISr8B1ofPVAdWaR3rygfaDiHUl2I5EmG2xoCrEskurmOmclGak3JXWwxso43KR9M1LHsdOIt48XS6xe3PVI=@pm.me>
	 <4d757f19ac6f7e17da2e87f482f129e75c6decf8.camel@gmail.com>
	 <CAEf4BzY4kXRSci3Lb6ZFT7++6fics-w4_8rYMB4vCEHgrCWEnQ@mail.gmail.com>
	 <b97340645b9a730df46e69b03b3ccba39816c414.camel@gmail.com>
	 <CAEf4BzYFad_hhk+ju1_Y+JeDGmOeD-Ur=+Yvfu2vkbR3frR6SQ@mail.gmail.com>
	 <k7SpuAM7weZyfgdgXEHzOiDkk8iBsBrl7ZsTpvhKQNvijS8cWjJrBN9DVOxF45edRXxA2POvIu9cZce3bF2FmoFOEbfevr09X-1c1pKgZrw=@pm.me>
	 <CAEf4Bzatg_CsKf7HeekaO3ZroXWg1ceJBgZ9KPWf2VkK1yKQ6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, Jul 14, 2024 at 6:17=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
> On Friday, July 12th, 2024 at 12:06 PM, Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> > So, bear with me for a moment please.
> > We have 3 test_progs/smth.c files that depend on a few .bpf.o files at =
runtime,
> > but do not include skel files for those .bpf.o, namely:
> > - core_reloc.c
> > - verifier_bitfield_write.c
> > - pinning.c
>
> Is this an exhaustive list, or did you mean it just as an example?

My bad, I looked only at the tests that failed on CI, there are indeed
more dependencies.

On Mon, 2024-07-15 at 10:44 -0700, Andrii Nakryiko wrote:
> But I think the right direction is to get rid of file-based loading of
> .bpf.o in favor of a) proper skeleton usage (lots of work to rewrite
> portions of file, so not very hopeful here) or b) a quick-fix-like
> equivalent and pretty straightforward <skel>___elf_bytes() replacement
> everywhere where we currently load the same bytes from file on the
> disk.

I don't really see a point in migrating tests to use skels or
elf_bytes if such migration does not simplify the test case itself.
By test simplification I mean at-least removal of some
bpf_object__find_{map,program}_by_name() calls.

I looked through the grep results and sorted those into buckets:
- test changes don't simplify anything:
  - bpf_obj_id.c
  - bpf_verif_scale.c
  - btf.c
  - btf_endian.c
  - connect_force_port.c
  - core_reloc.c
  - fexit_bpf2bpf.c
  - global_data.c
  - lwt_redirect.c
  - lwt_reroute.c
  - map_lock.c
  - pkt_access.c
  - pkt_md_access.c
  - queue_stack_map.c
  - resolve_btfids.c
  - sk_assign.c
  - skb_ctx.c
  - skb_helpers.c
  - task_fd_query_rawtp.c
  - task_fd_query_tp.c
  - tp_attach_query.c
  - trampoline_count.c
  - xdp_adjust_frags.c
  - xdp_adjust_tail.c
  - xdp_attach.c
  - xdp_info.c
  - xdp_perf.c
- skel usage would somewhat simplify the test:
  - get_stack_raw_tp.c
  - global_data_init.c
  - global_func_args.c
  - kfree_skb.c
  - l4lb_all.c
  - load_bytes_relative.c
  - pinning.c
  - probe_user.c
  - rdonly_maps.c
  - select_reuseport.c
  - stacktrace_map.c
  - stacktrace_map_raw_tp.c
  - tailcalls.c
  - test_overhead.c
  - xdp.c
- can be migrated to test_loader:
  - reference_tracking.c
  - tcp_estats.c
 =20
Given the large number of test cases that don't seem to benefit from
skel rework, I think we would need to handle direct dependencies
somehow, e.g.:
- by writing down these dependencies in the makefile, or
- by adding "fake" #include <smth.skel.h>, or
- by adding "true" #include <smth.skel.h> and using elf_bytes, or
- by adding a catch-all clause in the makefile, e.g. making test
  runner depend on all .bpf.o files.

On Mon, 2024-07-15 at 10:44 -0700, Andrii Nakryiko wrote:
> see above, elf_bytes is a quick and dirty way to get rid of file
> dependencies and turn them into .skel.h dependency without having to
> change existing tests significantly (which otherwise would be tons of
> work).

I assume that the goal here is to encode dependencies via skel.h files
inclusion. For bpf selftests presence of skel.h guarantees presence of
the freshly built object file. Why bother with elf_bytes rework if
just including the skel files would be sufficient?

  ---

The catch-all clause in the current makefile looks as follows:

    $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
    		     $(TRUNNER_BPF_PROGS_DIR)/%.c			\
    		     $(TRUNNER_BPF_PROGS_DIR)/*.h			\
    			 ...

This makes all .bpf.o files dependent on all BPF .c files.
.bpf.o files rebuild is the main time consumer, at-least for me.

I think that simply replacing this catch all by something like:

    $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_BPF_OBJS)

on top of v2 of this patch-set is a good stop gap solution:
it is simple, explicit and brings most of the speedup.
People rebuilding test_progs would only pay for compilation of BPF
object files that had been changed.

---

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index 557078f2cf74..11316ccb5556 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -628,13 +628,16 @@ ifneq ($2:$(OUTPUT),:$(shell pwd))
        $(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
 endif
=20
+# some X.test.o files have runtime dependencies on Y.bpf.o files
+$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_BPF_OBJS)
+
 $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)                      \
                             $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)           \
                             $(RESOLVE_BTFIDS)                          \
                             $(TRUNNER_BPFTOOL)                         \
                             | $(TRUNNER_BINARY)-extras
        $$(call msg,BINARY,,$$@)
-       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
+       $(Q)$$(CC) $$(CFLAGS) $$(filter-out %.bpf.o, $$(filter %.a %.o,$$^)=
) $$(LDLIBS) -o $$@
        $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
        $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftoo=
l \
                   $(OUTPUT)/$(if $2,$2/)bpftool

