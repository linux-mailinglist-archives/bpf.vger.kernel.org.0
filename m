Return-Path: <bpf+bounces-73732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6DEC381B7
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 22:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEB83B22A2
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 21:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A5B296BB3;
	Wed,  5 Nov 2025 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYBgyUMu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01051FDA89
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379289; cv=none; b=hYlbmY1A1dK5O5z30ZKr3l05KgoFUADSX9BBlxO3zg9oA3QBPhWzQR3L2a5+GYQlnWxXvdRqgw9te50WH6WENQJNliohJaqj4sbBGtxsgJl63Na4ZLZFVLFiCIiMKyAgSZCiQ6G+SdMtkNwOTn+4NjeyrfEMTdagFxGq3ZNkAlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379289; c=relaxed/simple;
	bh=P0Zq7AmjYBg5aWT8wMjYV+faAPyaxTkSuPunMY+fNCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVSNk5YEvDSdrYLZDI0KP2onhTfvHDAjnoPo+XzT7SU+aY6+Jv6siHRNiQdkWlDaDxckpFyyfUNexqE4kJ+bYwmlDFA7QcCfZchNplZHrNii/3r0+YNCpm6d9GzuH4vxpXsY7hjIV7/DbswB1vYvc5C4H0Hxl8MdjMo4qBdJHjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYBgyUMu; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so496166a12.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 13:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762379286; x=1762984086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwVhNgclWxcTnKhRN49L9uFV5X+diduJfxI+zvTNccI=;
        b=GYBgyUMuIe1BytfJd6OAyL/3wMslaLSyY7iEApedkv2xRxZNJ7RrDW29MqRSFVmhqh
         IQOz5IvRZU6EngVIk8MzLPFJGfEpmh1MrEhRBdleLaeOTX78/Y7VRAGxdZH9uN5vz5kK
         ar7hT8rpICXi5Bsu0ty6uAWLahyxb9/DG7KCQ0AAikTc1QNNj2gYvwVn78ix9gUTUbKw
         1JQBpKPyefFeAXv+9U75RC4Nkr0E8ocS5Us4vm9kZz4zC5Wn646NOewcI0fWC163GOj6
         vOoQSRo/LEYRyEF/kYT1Y3hIj35UA1nWutUExmpFqi1P5DNYtpanv5Vk25pZpaJWBQxT
         SOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762379286; x=1762984086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwVhNgclWxcTnKhRN49L9uFV5X+diduJfxI+zvTNccI=;
        b=IYyV3cFs4xzZXJVrWuQlOex1PbUjxIyc/FREHYYpqyrtDjj5pIwAv/NteSzH6q8F4b
         1xXt9lAZoJucQq9uM1JNpGDKiKyheI38bfnjtuaj5Hi28jbZnuNlmU2rjmAOWCd7k9qE
         dCcdouve9SczUdQVo9/Vwts/tAMnEg0hkaGQsSDudUg3u7gBSNKjjFRT3I8AuFHHFZk1
         E2HXtzDRs5UTXj4izcinaclMxu0hGXjFo5mz7jCwST/aKoV0ld7GhzLoAL+lwbuFZgrq
         +lkRwB6/TYii3Oqjvf00fs2nHIgTBMbWOQRNcWcPC90VpC0QFGf93rcSkS2ElrgbP9+9
         jOWA==
X-Gm-Message-State: AOJu0Yx/k/94MNXPjHhoAw53ruSBZFfsx1tBhj/kKZ7IdA/mqhy3p/7Z
	gPh+q/AQoBIioGUpo60ZgHn6GFnLRcIiOw38K2ZcYX2REyCCzI22y5GK
X-Gm-Gg: ASbGncvW1WClN/OTz5ZzaaXqVbs57NPWCNqqLZRRV3LRTFjyQKX7zZl2COiXSA02s0u
	PofGchbAhFUCkYK7EL7+GoeHl0FwGyK/8q+0nyiTa87nt+9yNN+ugCn7TyXfqutEouZAHPq30Yz
	Y3WWEKCv1w8+OhgQA4r6SpiijYNf+ACt/xo4VqQ3PBuwo/h2hKWNZIYIsGOOokNca+XtRN4IqG7
	IT54dTQ9MmpdaMJFxSBSRCqnn81siJvjGd6G4tMmhiycNTMKLbvhbVhCe8lQ+JnOwUkBkhXgRwG
	tixtmtYBKFzNIVxwVr18z+HsQX33B8JhRoUTNO8nb9SXMFotHP6sH4ezSayqW6IAH5V3vdLeeuU
	Vm28AbRbwuZRLag9KtFehF6YPwHH5cyrG8GilmnS/ZNWA+7FnOIh7LF48mOZwWOF65Y663juIPs
	r8gpOPcU2R3kXgTCTSJLw/
X-Google-Smtp-Source: AGHT+IHiSoqmACR7GcxznuByOi0y211aFOQl8w+2ZM+eKKCHtOADEqzJvcTzsDR1i8wwjCx9oxohZA==
X-Received: by 2002:a05:6402:1d4a:b0:640:9eb3:366e with SMTP id 4fb4d7f45d1cf-64105b73a19mr4048775a12.25.1762379285855;
        Wed, 05 Nov 2025 13:48:05 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eb6sm200653a12.14.2025.11.05.13.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:48:05 -0800 (PST)
Date: Wed, 5 Nov 2025 21:54:17 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v11 bpf-next 00/12] BPF indirect jumps
Message-ID: <aQvHiSXN72/Q1qE+@mail.gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
 <7463cbcabcd06016d7dfbd858f4e089c4acd88f1.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7463cbcabcd06016d7dfbd858f4e089c4acd88f1.camel@gmail.com>

On 25/11/05 12:51PM, Eduard Zingerman wrote:
> On Wed, 2025-11-05 at 09:03 +0000, Anton Protopopov wrote:
> > This patchset implements a new type of map, instruction set, and uses
> > it to build support for indirect branches in BPF (on x86). (The same
> > map will be later used to provide support for indirect calls and static
> > keys.) See [1], [2] for more context.
> > 
> > Short table of contents:
> > 
> >   * Patches 1-6 implement the new map of type
> >     BPF_MAP_TYPE_INSN_SET and corresponding selftests. This map can
> >     be used to track the "original -> xlated -> jitted mapping" for
> >     a given program.
> > 
> >   * Patches 7-12 implement the support for indirect jumps on x86 and add libbpf
> >     support for LLVM-compiled programs containing indirect jumps, and selftests.
> > 
> > The jump table support was merged to LLVM and now can be
> > enabled with -mcpu=v4, see [3]. The __BPF_FEATURE_GOTOX
> > macros can be used to check if the compiler supports the
> > feature or not.
> > 
> > See individual patches for more details on the implementation details.
> 
> I retested this series with upstream clang [1] (includes latest
> changes for relocations handling from Yonghong), and all works as
> expected.
> 
> The series is ready to land from my perspective.
> (AI has a few notes on tests, though).

Thanks.  The fixes to the latest AI comments are as follows:

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
index ea1cd3cda156..d138cc7b1bda 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
@@ -90,7 +90,7 @@ static void check_one_map_two_jumps(struct bpf_gotox *skel)
 
 	for (i = 0; i < prog_info.nr_map_ids; i++) {
 		map_fd  = bpf_map_get_fd_by_id(map_ids[i]);
-		if (!ASSERT_GE(map_fd, 0, "bpf_program__fd(one_map_two_jumps)"))
+		if (!ASSERT_GE(map_fd, 0, "bpf_map_get_fd_by_id"))
 			return;
 
 		len = sizeof(map_info);
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index cf852318eeb2..269870bec941 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -406,7 +406,7 @@ static void check_no_map_reuse(void)
 
 	/* correctness: check that prog is still loadable without fd_array */
 	extra_fd = prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
-	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD): expected no error"))
+	if (!ASSERT_GE(extra_fd, 0, "bpf(BPF_PROG_LOAD): expected no error"))
 		goto cleanup;
 
 cleanup:

> [1] f60e69315e9e ("[llvm] Emit canonical linkage correct function
> symbol (#166487)")
> 
> > v10 -> v11 (this series):
> > 
> >   * rearranged patches and split libbpf patch such that first 6 patches
> >     implementing instruction arrays can be applied independently
> 
> I actually tried applying first 6 patches and then removing patch #3
> "libbpf: Recognize insn_array map type", nothing broke: kernel and
> selftests compile, relevant selftests passing.

The `test_progs -a libbpf_str` should fail without this patch.

> So, not sure if splitting patch #3 as a separate thing is really
> necessary.
> 
> > 
> >   * instruction arrays:
> >     * move [fake] aux->used_maps assignment in this patch
> > 
> >   * indirect jumps:
> >     * call clear_insn_aux_data before bpf_remove_insns (AI)
> > 
> >   * libbpf:
> >     * remove the relocations check after the new LLVM is released (Eduard, Yonghong)
> >     * libbpf: fix an index printed in pr_warn (AI)
> > 
> >   * selftests:
> >     * protect programs triggered by nanosleep from fake runs (Eduard)
> >     * patch verifier_gotox to not emit .rel.jumptables
> > 
> 
> [...]

