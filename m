Return-Path: <bpf+bounces-44504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0652B9C3C6D
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 11:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E811C21EFA
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 10:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33EE15A86A;
	Mon, 11 Nov 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blRadHfI"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA7175D3A
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322230; cv=none; b=pLW6+E77JQ1bG5pG2NguD/+mlhBIiS7QzHPpWumG5tnKOOkKI3jYM7wCXHPFsPRmS/r1liCoRyApsIROV8XwlqUn4nlKzauERqAPfohrGs5jEqmEH9YngUp42PYZdT4sG2vVR3AQB7zFnjKkSX/rZA7xItGfnqYaOGUdkKTBLww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322230; c=relaxed/simple;
	bh=doRzZPf0Ko2+PLSxfO+f7mcmvgwk/bMwKyNo7VcyGQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aO0/p/Gsf1m184DaecRX2kYo5KxI2nX3BJt5DBCplMIL8kMLsdQP5WzgS3yGxba9bGjQ+S2eeF6BIwPMf7h9K1q6oOz1g39ggTdhQtrgPHQfN4wLSMEmHeO2GFAuvpbhXcNxlaNMqB+pkFaw9T15fcGTHpC5lkuzgjURFMHS8vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blRadHfI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731322225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2qKra3tVe3eIhio8G4Jfbjq/36fQNSKWhnbsMLAFog=;
	b=blRadHfISVZx/+TriYx87gCfb5oAgOB6nCtMj0uF9JR7AIwg3Qce79b/A4P6lpUBbAJUSD
	9aHQZ2ATT7DAnVo34apD1fddSOGD3N8I7ZQHA//R7T1Mij5RiXSIi4zPoTI1UHfBVZuxYo
	Ab4z/2bEqDA6REIb6vfVJ8o4OCInPjQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-r8Me5cacMjSMyQmdYiwwxA-1; Mon, 11 Nov 2024 05:50:23 -0500
X-MC-Unique: r8Me5cacMjSMyQmdYiwwxA-1
X-Mimecast-MFC-AGG-ID: r8Me5cacMjSMyQmdYiwwxA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5016d21eso2383103f8f.3
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 02:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322222; x=1731927022;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2qKra3tVe3eIhio8G4Jfbjq/36fQNSKWhnbsMLAFog=;
        b=dgfH87VDdZWHj/dqw1qEG7ZcACcgEk3IhxytLcuxD/GmoslogVGnhUshTrEbconCAM
         sc9GKBdcdQX2tpHT9ed58dod9u/rrlC69L6WYj5C6puQQsaEpmUD80HVf5Mfe7Q3qK7e
         woz2vFtcYT4t1Ayo/STQDd6vyKUgny4yp+WgQlPv1V7bs9XP2sClXwbNWfOd2C7Lnikx
         jXsvDwLYVHqacQPKNWj3XqjduWEZYAaLjPKaKwR8JNLBbrBIsk8RckifMkV2B1qQFnK1
         FW0/UGQligc+LE5AdFpRRtxFTmvZXP8ZZLqM/gUstmA4ynPb1huACpgbm7w3lBrYJTJc
         a2UA==
X-Gm-Message-State: AOJu0Yw8Vek2WSTyh2feokLPRK7A9l+ofOK73K6x0Yym4skxPK7Wncyi
	YoJW13F+okW4Gj2nTXqrf/B74Kc/TeCNLHVEPMb0TgOLvEeDnjoI0Zm7s+q49Fr72gw0mTZwDQh
	oTEqTZ2meRMOin7N+lJkyS9MyZr/c5njSQIUKanaFAbiMeO1KYg==
X-Received: by 2002:a05:6000:20ca:b0:381:f5a7:3e85 with SMTP id ffacd0b85a97d-381f5a73e92mr5907816f8f.26.1731322222372;
        Mon, 11 Nov 2024 02:50:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHds3BAm6PB92coIQQkR5FhdvoYxcpE/r1FFYF13ZXVnyXWyYfOblIQriBkLXs5S9EO80GSCA==
X-Received: by 2002:a05:6000:20ca:b0:381:f5a7:3e85 with SMTP id ffacd0b85a97d-381f5a73e92mr5907795f8f.26.1731322221893;
        Mon, 11 Nov 2024 02:50:21 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9978afsm12470268f8f.52.2024.11.11.02.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:50:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id F3B3D164CC12; Mon, 11 Nov 2024 11:50:19 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Consolidate kernel modules
 into common directory
In-Reply-To: <830dfc5c-5ad0-4fda-87f6-b1d7177e590f@redhat.com>
References: <20241107-bpf-selftests-mod-compile-v2-1-ef781fe9ca95@redhat.com>
 <830dfc5c-5ad0-4fda-87f6-b1d7177e590f@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 11 Nov 2024 11:50:19 +0100
Message-ID: <87bjym59jo.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Viktor Malik <vmalik@redhat.com> writes:

> On 11/7/24 11:33, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> The selftests build four kernel modules which use copy-pasted Makefile
>> targets. This is a bit messy, and doesn't scale so well when we add more
>> modules, so let's consolidate these rules into a single rule generated
>> for each module name, and move the module sources into a single
>> directory.
>>=20
>> To avoid parallel builds of the different modules stepping on each
>> other's toes during the 'modpost' phase of the Kbuild 'make modules', we
>> create a single target for all the defined modules, which contains the
>> recursive 'make' call into the modules directory. The Makefile in the
>> subdirectory building the modules is modified to have a .PHONY target
>> which also touches a 'modules.built' file. This way we can add this file
>> as a dependency on the top-level selftests Makefile, thus ensuring that
>> the modules are always rebuilt if any of the dependencies in the
>> selftests change. The .PHONY target doesn't cause spurious rebuilds
>> since we track all the dependencies in the parent directory Makefile and
>> only call make in the subdirectory if anything changes.
>>=20
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>> Changes in v2:
>> - Rebase on bpf-next, incorporating Viktor's EXTRA_CFLAGS patch
>> - A few small adjustments to the module Makefile recipe
>> - Link to v1: https://lore.kernel.org/r/20241031-bpf-selftests-mod-compi=
le-v1-1-1a63af2385f1@redhat.com
>> ---
>>  tools/testing/selftests/bpf/Makefile               | 62 +++++++--------=
-------
>>  .../selftests/bpf/bpf_test_modorder_x/Makefile     | 19 -------
>>  .../selftests/bpf/bpf_test_modorder_y/Makefile     | 19 -------
>>  .../testing/selftests/bpf/bpf_test_no_cfi/Makefile | 19 -------
>>  tools/testing/selftests/bpf/bpf_testmod/Makefile   | 20 -------
>>  .../testing/selftests/bpf/prog_tests/core_reloc.c  |  2 +-
>>  tools/testing/selftests/bpf/progs/bad_struct_ops.c |  2 +-
>>  tools/testing/selftests/bpf/progs/cb_refs.c        |  2 +-
>>  tools/testing/selftests/bpf/progs/epilogue_exit.c  |  4 +-
>>  .../selftests/bpf/progs/epilogue_tailcall.c        |  4 +-
>>  tools/testing/selftests/bpf/progs/iters_testmod.c  |  2 +-
>>  tools/testing/selftests/bpf/progs/jit_probe_mem.c  |  2 +-
>>  .../selftests/bpf/progs/kfunc_call_destructive.c   |  2 +-
>>  .../testing/selftests/bpf/progs/kfunc_call_fail.c  |  2 +-
>>  .../testing/selftests/bpf/progs/kfunc_call_race.c  |  2 +-
>>  .../testing/selftests/bpf/progs/kfunc_call_test.c  |  2 +-
>>  .../selftests/bpf/progs/kfunc_call_test_subprog.c  |  2 +-
>>  .../testing/selftests/bpf/progs/local_kptr_stash.c |  2 +-
>>  tools/testing/selftests/bpf/progs/map_kptr.c       |  2 +-
>>  tools/testing/selftests/bpf/progs/map_kptr_fail.c  |  2 +-
>>  tools/testing/selftests/bpf/progs/missed_kprobe.c  |  2 +-
>>  .../selftests/bpf/progs/missed_kprobe_recursion.c  |  2 +-
>>  tools/testing/selftests/bpf/progs/nested_acquire.c |  2 +-
>>  tools/testing/selftests/bpf/progs/pro_epilogue.c   |  4 +-
>>  .../selftests/bpf/progs/pro_epilogue_goto_start.c  |  4 +-
>>  tools/testing/selftests/bpf/progs/sock_addr_kern.c |  2 +-
>>  .../selftests/bpf/progs/struct_ops_detach.c        |  2 +-
>>  .../selftests/bpf/progs/struct_ops_forgotten_cb.c  |  2 +-
>>  .../selftests/bpf/progs/struct_ops_maybe_null.c    |  2 +-
>>  .../bpf/progs/struct_ops_maybe_null_fail.c         |  2 +-
>>  .../selftests/bpf/progs/struct_ops_module.c        |  2 +-
>>  .../selftests/bpf/progs/struct_ops_multi_pages.c   |  2 +-
>>  .../selftests/bpf/progs/struct_ops_nulled_out_cb.c |  2 +-
>>  .../bpf/progs/test_kfunc_param_nullable.c          |  2 +-
>>  .../selftests/bpf/progs/test_module_attach.c       |  2 +-
>>  .../selftests/bpf/progs/test_tp_btf_nullable.c     |  2 +-
>>  .../testing/selftests/bpf/progs/unsupported_ops.c  |  2 +-
>>  tools/testing/selftests/bpf/progs/wq.c             |  2 +-
>>  tools/testing/selftests/bpf/progs/wq_failures.c    |  2 +-
>>  .../bpf/{bpf_testmod =3D> test_kmods}/.gitignore     |  0
>>  tools/testing/selftests/bpf/test_kmods/Makefile    | 25 +++++++++
>>  .../bpf_test_modorder_x.c                          |  0
>>  .../bpf_test_modorder_y.c                          |  0
>>  .../bpf_test_no_cfi.c                              |  0
>>  .../bpf_testmod-events.h                           |  0
>>  .../bpf/{bpf_testmod =3D> test_kmods}/bpf_testmod.c  |  0
>>  .../bpf/{bpf_testmod =3D> test_kmods}/bpf_testmod.h  |  0
>>  .../bpf_testmod_kfunc.h                            |  0
>>  48 files changed, 82 insertions(+), 158 deletions(-)
>>=20
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index edef5df08cb2536260f8910b2ebd2b89dbd0ebd2..1c35e29e3e94d86eb5619db5=
cb20e2d42772fe60 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -152,13 +152,15 @@ TEST_PROGS_EXTENDED :=3D with_addr.sh \
>>  	with_tunnels.sh ima_setup.sh verify_sig_setup.sh \
>>  	test_xdp_vlan.sh test_bpftool.py
>>=20=20
>> +TEST_KMODS :=3D bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.k=
o \
>> +	bpf_test_modorder_y.ko
>> +TEST_KMOD_TARGETS =3D $(addprefix $(OUTPUT)/,$(TEST_KMODS))
>> +
>>  # Compile but not part of 'make run_tests'
>>  TEST_GEN_PROGS_EXTENDED =3D \
>>  	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
>> -	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
>> -	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
>> -	xdp_features bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
>> -	bpf_test_modorder_y.ko
>> +	test_lirc_mode2_user xdping test_cpp runqslower bench xskxceiver \
>> +	xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata xdp_features
>>=20=20
>>  TEST_GEN_FILES +=3D liburandom_read.so urandom_read sign-file uprobe_mu=
lti
>>=20=20
>> @@ -173,8 +175,9 @@ override define CLEAN
>>  	$(Q)$(RM) -r $(TEST_GEN_PROGS)
>>  	$(Q)$(RM) -r $(TEST_GEN_PROGS_EXTENDED)
>>  	$(Q)$(RM) -r $(TEST_GEN_FILES)
>> +	$(Q)$(RM) -r $(TEST_KMODS)
>>  	$(Q)$(RM) -r $(EXTRA_CLEAN)
>> -	$(Q)$(MAKE) -C bpf_testmod clean
>> +	$(Q)$(MAKE) -C test_kmods clean
>>  	$(Q)$(MAKE) docs-clean
>>  endef
>>=20=20
>> @@ -240,7 +243,7 @@ endif
>>  # to build individual tests.
>>  # NOTE: Semicolon at the end is critical to override lib.mk's default s=
tatic
>>  # rule for binaries.
>> -$(notdir $(TEST_GEN_PROGS)						\
>> +$(notdir $(TEST_GEN_PROGS) $(TEST_KMODS)				\
>>  	 $(TEST_GEN_PROGS_EXTENDED)): %: $(OUTPUT)/% ;
>>=20=20
>>  # sort removes libbpf duplicates when not cross-building
>> @@ -294,37 +297,15 @@ $(OUTPUT)/sign-file: ../../../../scripts/sign-file=
.c
>>  		  $< -o $@ \
>>  		  $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypt=
o)
>>=20=20
>> -$(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard b=
pf_testmod/Makefile bpf_testmod/*.[ch])
>> -	$(call msg,MOD,,$@)
>> -	$(Q)$(RM) bpf_testmod/bpf_testmod.ko # force re-compilation
>> -	$(Q)$(MAKE) $(submake_extras) -C bpf_testmod \
>> -		RESOLVE_BTFIDS=3D$(RESOLVE_BTFIDS)     \
>> +test_kmods/modules.built: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard t=
est_kmods/Makefile test_kmods/*.[ch])
>
> One problem with this approach is that modules are not recompiled after
> the user manually removes the .ko files:
>
>     $ find -name "*.ko" -delete
>     $ make
>       MOD      bpf_testmod.ko
>     cp: cannot stat 'test_kmods/bpf_testmod.ko': No such file or directory
>     make: *** [Makefile:308:
> /bpf-next/tools/testing/selftests/bpf/bpf_testmod.ko] Error 1
>
> Not sure if that's a common use-case but it feels like one way to force
> recompilation of modules so people may actually want to use it.

Yeah, fair point. I played around with it a bit more, and I think I
found a way (using .NOTPARALLEL) to make this work (and get rid of the
'modules.built' file entirely). Will respin.

>> +	$(Q)$(RM) test_kmods/*.ko test_kmods/*.mod.o # force re-compilation
>
> This means that we always recompile all modules, right? IMHO it's not a
> problem (at least not at the moment as there are few modules and the
> compilation is fast) but I'm just pointing it out.

Yeah, it does. I don't think this is a huge issue, though, and with the
.NOTPARALLEL approach it actually helps to rebuild them all in one go,
as we'll otherwise only rebuild one module (if there's a change in one
of the prereqs), but we'll still end up with no-op recursive make calls
for the other modules because make can't properly track dependencies
across the kernel module build (you can try removing the 'rm' from v3 to
see what I mean). So all in all I think this is OK.

-Toke


