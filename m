Return-Path: <bpf+bounces-34616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A854B92F3FE
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 04:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366081F23306
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 02:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354FE8F6A;
	Fri, 12 Jul 2024 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/75MWmh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8F8F40
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720750908; cv=none; b=NvxrT3H4Y5RiaUioAxCxui+VnJlltkEO4q1RCmVXKkxVPmCBQCIM1kotSlFyMAT6nb1YJRyPCdApONl7gSTUHzi6lUZnkXgegDswLn5ZZUpxDGEDleWFmu+YwEfHsul6+eEJ4vUqI7C58J0X8y1QPsGIotK/LkSQJWc+Oh7MnaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720750908; c=relaxed/simple;
	bh=+TmJyryfbvrRevVfHps695g1eqKcquLp1wz9+kO8NlE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/9OfcwGCNovxC8uHELarKPgw2XQz02dSL96mK7en4cthY2FowfAoJD+s7Of06B6YUBvrq/Vh7zRUfQda0UkviOetJLYmYJ9Mmkgb73xCMGgSbSWjf93N9RMgtUmbp4Pf4C2OxFNML/D21D1uYWvnxj9W8NgGcjITztM4rTCWaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/75MWmh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fa2ea1c443so12579395ad.0
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 19:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720750907; x=1721355707; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i2wI12ivCBI8SS3q3VOQhfDI4KK2W9SZu9B1enuBuNs=;
        b=C/75MWmhOpYQ7WT66tOgDpKK922bxIhBxeamx4THbAN9S4smfsemhfimjZu6FDsN3L
         U34cfwno/pF5g5a4r0Nls6e9Av+ifeA+cBB1ETvTPByHSXZQPyYlFBP4AqTU7eN4gBag
         tiuOo5DxBeMpYHH9wecgeInffcyxyAK5Lwwkcn06VuU7Aillvhtz4HOeU9La9GaeevlF
         20Np8hLPr6fFLf5SdvyrgnAXs3y8YgJ+1nFNKBLxNhCZbIoPkuPu1iKYdlheJbRFSrk/
         ga0G9tOGCdmUZgmsaUokRZ8sZq97csyYLK12OnYXNBy6F++94ImNWT0IO7oS5aZg9t5o
         sEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720750907; x=1721355707;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2wI12ivCBI8SS3q3VOQhfDI4KK2W9SZu9B1enuBuNs=;
        b=A68CfxSkJbsjej67hdpbx1YQ36tWUaH5zMph0lqfTt7D6s9gs8IBea0dK9sIJjDOrJ
         sC30SgdPYIkVqeGi+htjA64WWRVAJJAGuNm4A1rp9GDDQqd/pZx6AjkVMdQ99IbK26eW
         krZIm7B5E7yBZcj4f6EVAp5AhjJwIqRCU1hLlVvlMHmIIPGeTQlH5afKIpgkvrbi8EKb
         ARJDe5WjqBTUOOAwQlPCeX0+0yPfudCwjhAGdEjdHeyl7RsFncS3OPNuaOd9MGYMpIr8
         r5hYLx5AczhGQe21T10vKbCp526GFpMw6+Hi2ZHg59cNcmAbpc1snckZi4DtDKzf+/2q
         0rYg==
X-Forwarded-Encrypted: i=1; AJvYcCXCDNfC39K/Bb7oIbrmaJWBPbzGvoL9e+HUvhU8daPO2HmDAs9XcD/xA6zwoMAzSEqFepXwcLGiLeiTx/e2aVcKKRbY
X-Gm-Message-State: AOJu0YzDPBI+7KtMCf/6LdYNLDgkJrKSU1vQlUvi33fodzB37tM5jYML
	wpyM6TlWEVOiOI97+VpsuByBH+uJq/HlQ6AsehSpJYhDjLy6ffJ0
X-Google-Smtp-Source: AGHT+IFczWoaJXguogvz6jCJ9iCgHDwcfd51QSVj/qrP5+hzD+g5fdqMdc1MtQdcH0dPjpxizd4Bdg==
X-Received: by 2002:a17:902:d490:b0:1fb:4f91:6728 with SMTP id d9443c01a7336-1fbb6d5fee1mr92798205ad.42.1720750906516;
        Thu, 11 Jul 2024 19:21:46 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab7fd3sm56817765ad.150.2024.07.11.19.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 19:21:46 -0700 (PDT)
Message-ID: <3586ffa2dfbee094aaa8a76ab5f570df37ef4b35.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: use auto-dependencies for test
 objects
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, "bpf@vger.kernel.org"
	 <bpf@vger.kernel.org>
Cc: "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org"
 <andrii@kernel.org>,  "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "mykolal@fb.com" <mykolal@fb.com>
Date: Thu, 11 Jul 2024 19:21:41 -0700
In-Reply-To: <17b05c0408489fd5ca474ae8ba3b7a3cc376f484.camel@gmail.com>
References: 
	<Naz7DRaOm6WPfVO0YqehujmRBSUi1RDWI6XYE-9zcqusFHfJ9VXevAlYMbcYORj2r8277pIQlbO5qHcpBrJpbeHAscLS9eo1AoKlkEiwt5k=@pm.me>
	 <17b05c0408489fd5ca474ae8ba3b7a3cc376f484.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-11 at 16:19 -0700, Eduard Zingerman wrote:

[...]


> While re-testing the patch I've noticed a strange behaviour:
> $ cd <kernel>/tools/testing/selftests/bpf
> $ git clean -xfd .
> $ make -j14
> $ touch progs/atomics.c=20
> $ make -j14 test_progs
>   CLNG-BPF [test_maps] atomics.bpf.o
>   CLNG-BPF [test_maps] atomics.bpf.o
>   CLNG-BPF [test_maps] atomics.bpf.o
>   GEN-SKEL [test_progs] atomics.lskel.h
>   GEN-SKEL [test_progs-cpuv4] atomics.lskel.h
>   GEN-SKEL [test_progs-no_alu32] atomics.lskel.h
>   TEST-OBJ [test_progs] arena_htab.test.o
>   TEST-OBJ [test_progs] atomics.test.o
>   ... many lines ...
>   TEST-OBJ [test_progs] uprobe_multi_test.test.o
>   TEST-OBJ [test_progs] usdt.test.o
>   TEST-OBJ [test_progs] verify_pkcs7_sig.test.o
>   TEST-OBJ [test_progs] vmlinux.test.o
>   TEST-OBJ [test_progs] xdp_adjust_tail.test.o
>   TEST-OBJ [test_progs] xdp_metadata.test.o
>   TEST-OBJ [test_progs] xdp_synproxy.test.o
>   BINARY   test_progs
> 16:15:34 bpf$ make -j14 test_progs
>   TEST-OBJ [test_progs] bpf_iter.test.o
>   TEST-OBJ [test_progs] bpf_nf.test.o
>   TEST-OBJ [test_progs] bpf_obj_id.test.o
>   TEST-OBJ [test_progs] btf.test.o
>   TEST-OBJ [test_progs] btf_write.test.o
>   TEST-OBJ [test_progs] cgrp_local_storage.test.o
>   TEST-OBJ [test_progs] iters.test.o
>   TEST-OBJ [test_progs] lsm_cgroup.test.o
>   TEST-OBJ [test_progs] send_signal.test.o
>   TEST-OBJ [test_progs] sockmap_basic.test.o
>   TEST-OBJ [test_progs] sockmap_listen.test.o
>   TEST-OBJ [test_progs] trace_vprintk.test.o
>   TEST-OBJ [test_progs] usdt.test.o
>   TEST-OBJ [test_progs] xdp_metadata.test.o
>   BINARY   test_progs
> 16:15:37 bpf$ make -j14 test_progs
>   TEST-OBJ [test_progs] bpf_obj_id.test.o
>   TEST-OBJ [test_progs] sockmap_listen.test.o
>   TEST-OBJ [test_progs] xdp_metadata.test.o
>   BINARY   test_progs
> 16:15:39 bpf$ make -j14 test_progs
>   TEST-OBJ [test_progs] sockmap_listen.test.o
>   BINARY   test_progs
> 16:15:41 bpf$ make -j14 test_progs
> make: 'test_progs' is up to date.
>=20
> Interestingly enough, this does not happen with your off-list version of
> the patch shared this morning, the one with order-only dependency for .d:
>=20
>   +$(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o: $(TRUNNER_TESTS_DIR)=
/%.c | $(TRUNNER_OUTPUT)/%.test.d
>=20
> Could you please double-check what's going on?

After some investigation it turned out that behaviour is specific to LLVM.
Under certain not yet clear conditions clang writes .d file *after* writing=
 .o file.
For example:

{llvm} 19:15:59 bpf$ rm ringbuf.test.o; make `pwd`/ringbuf.test.o; ls -l --=
time-style=3Dfull-iso `pwd`/ringbuf.test.{o,d}
  TEST-OBJ [test_progs] ringbuf.test.o
-rw-rw-r-- 1 eddy eddy   1947 2024-07-11 19:16:01.059016929 -0700 /home/edd=
y/work/bpf-next/tools/testing/selftests/bpf/ringbuf.test.d
-rw-rw-r-- 1 eddy eddy 160544 2024-07-11 19:16:01.055016909 -0700 /home/edd=
y/work/bpf-next/tools/testing/selftests/bpf/ringbuf.test.o

Note that ringbuf.test.d is newer than ringbuf.test.o.
This happens on each 10 or 20 run of the command.
Such behaviour clearly defies the reason for dependency files generation.

The decision for now is to avoid specifying .d files as direct dependencies
of the .o files and use order-only dependencies instead.
The make feature for reloading included makefiles would take care
of correctly re-specifying dependencies.

[...]

