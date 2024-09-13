Return-Path: <bpf+bounces-39785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032299776A7
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 03:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778AE1F253D9
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 01:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD63127B56;
	Fri, 13 Sep 2024 01:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYQCjLav"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111D51714B3
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 01:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192566; cv=none; b=gfbBB+k//0a6gzD7LFf8BVhhcVbeX9eW1riwAtOT7WM5665MbuYXpsKFy/sbYiwOMiC8151O+Snu1HN3PIE34H9piSwpZaZTCi5BF2yNw5sj3Iq5pkaEFvhFRqPPBg9mcCrZ9su3jFPqnpkwNapMmAQCxJHBJ9qFTy9HoALCqY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192566; c=relaxed/simple;
	bh=xUYR9HLdjSa2UIy9JJaxe8IcX7C/GFXyNuLGvU4cfYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqY6itcNX84/xjfozF0gVbqbB5MtK56VY1VG2y/naPg43m/vSHh75xX80u3h1tUjz4lyBONNH1T6I8n4nFSY6i/KdEp0B2wvMkkGArLq4MTK6Rrv6FIpfs81gnI3R43VX/K7r3xJ0QKb9AdbxO+Fl+Ri51sPZchL8KsoguRBxJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYQCjLav; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d86f713557so1133103a91.2
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 18:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726192552; x=1726797352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioXhfGz0wKHy3KSGBDXOIjV1WXbeXdEcmE6n1MeY/SI=;
        b=CYQCjLavh3lZkheG51820ScuKAyP2thLFNekCR89ZDxjwh/d/zwn5Gd5Ld4kaBO+K1
         XEAZlSKSnmSy2WJAk09kXWNQ2jEv92YW+tJecwAs9UMu2wkRNTTxHjuDakykvtltDE4m
         YvqBFfiCjV/U7Vug5HN1sguNCbLv7r1fqS4gDXkmB+8sUrl1AK3fco3i5/61+U3v9kuC
         iJYHBkG0fVcvTwfquYnTfOhyJtWTmrKZo57wAJXV5io6Pz5PUpELZY/oCh1FCQc+UFR+
         za4rZiRZlQeZAa6CydS3jVlRpYMwXMbMRI1qyQHKwZ7gPA0SSetofcuPW9xyzwnTX+5I
         OYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726192552; x=1726797352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioXhfGz0wKHy3KSGBDXOIjV1WXbeXdEcmE6n1MeY/SI=;
        b=IaO0wOXN5/cXb24jCwK+Oj0o4VxD2v6v7/P4w6uLmKM5QhTvWfjiKqJ14itoRxcEpt
         WZKKcVAVA2Mo2NK7cG1UAUAZLBLR8o+16gqLVn4d9uYOGQ+AoYGfSp0w8+UlIVi0EOUh
         DivLPgbUdWY9Hl9U3ayca1ABCNoEWg2+Wo2Yx8rCni+HhVv86qJxYZkpxkq/16RCdgbX
         oxxRKQs8zCq109+e36keYUUXsM+ExCyxIjDDkJIx9zbcu6piZB5eKjLsDaSRzdLz0n1s
         6FNtaTJoGFH5kd+KRlKUKyyW83AL/eZSX1ZYIqi4eEmGo8OcTPkIKsiy+wbWdI/etdRR
         VOAg==
X-Forwarded-Encrypted: i=1; AJvYcCVggW5uHYFvu/BjIJcghUzmYKsk/LR0vGt+Aywct7dVIuL/IXejmoBVqIoWjqrq4rf6seE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGlWqaCZ42Kee+00TL+fuOkmJFrCBB/qGQfbPDXFIitoh8I5F6
	mjtcACMIXMneHML47GzZf5EN5JnlGoJX1UqVxgjd6LS6DZkFxHKA2RMScYCzwlBhUCNSdq4zLC1
	UCPsK+bdA9+Mx551b+ZzK+L6Bv5Y=
X-Google-Smtp-Source: AGHT+IG/RjxZ/TgPppmZ/pOIPepTfHEBmHZVqGxRChs3pzWXkKCzLt1PmMiE3ebtyWwZa9i2/TWejpIbdPV3e7LRSwo=
X-Received: by 2002:a17:90a:f2c9:b0:2da:505e:77ad with SMTP id
 98e67ed59e1d1-2db9ffaefacmr4931940a91.6.1726192552091; Thu, 12 Sep 2024
 18:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
 <0170cd7d95df0583770c385c1e11bd27dfacf618b71b6e723f0952efc0ce9040@mail.kernel.org>
 <CAEf4BzZgAkSkMd6Vk3m1D-0AVqXp06PaBPr+2L7Dd3WRgJ8JvA@mail.gmail.com> <20240913085402.9e5b2c506a8973b099679d04@kernel.org>
In-Reply-To: <20240913085402.9e5b2c506a8973b099679d04@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Sep 2024 18:55:40 -0700
Message-ID: <CAEf4BzZEoNHgcLDPTPQ=yyQTZtEZoVrGbBbeTf3vqe_wcpS6EA@mail.gmail.com>
Subject: Re: [PATCH v14 00/19] tracing: fprobe: function_graph: Multi-function
 graph and fprobe on fgraph
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: kernel-ci@meta.com, bot+bpf-ci@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, bpf <bpf@vger.kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 4:54=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Thu, 12 Sep 2024 11:41:17 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > + BPF ML
> >
> > On Thu, Sep 12, 2024 at 8:35=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
> > >
> > > Dear patch submitter,
> > >
> > > CI has tested the following submission:
> > > Status:     FAILURE
> > > Name:       [v14,00/19] tracing: fprobe: function_graph: Multi-functi=
on graph and fprobe on fgraph
> > > Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?seri=
es=3D889822&state=3D*
> > > Matrix:     https://github.com/kernel-patches/bpf/actions/runs/108337=
92984
> > >
> > > Failed jobs:
> > > test_progs-aarch64-gcc: https://github.com/kernel-patches/bpf/actions=
/runs/10833792984/job/30061791397
> > > test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bp=
f/actions/runs/10833792984/job/30061791836
> > > test_progs-s390x-gcc: https://github.com/kernel-patches/bpf/actions/r=
uns/10833792984/job/30061757062
> > > test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/=
actions/runs/10833792984/job/30061757809
> > >
> > > First test_progs failure (test_progs-aarch64-gcc):
> > > #132 kprobe_multi_testmod_test
> > > serial_test_kprobe_multi_testmod_test:PASS:load_kallsyms_local 0 nsec
> > > #132/1 kprobe_multi_testmod_test/testmod_attach_api_syms
> > > test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> > > trigger_module_test_read:PASS:testmod_file_open 0 nsec
> > > test_testmod_attach_api:PASS:trigger_read 0 nsec
> > > kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kprobe=
_test1_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kprobe=
_test2_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kprobe=
_test3_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected kre=
tprobe_test1_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected kre=
tprobe_test2_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kre=
tprobe_test3_result: actual 0 !=3D expected 1
> > > #132/2 kprobe_multi_testmod_test/testmod_attach_api_addrs
> > > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > > test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> > > trigger_module_test_read:PASS:testmod_file_open 0 nsec
> > > test_testmod_attach_api:PASS:trigger_read 0 nsec
> > > kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kprobe=
_test1_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kprobe=
_test2_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kprobe=
_test3_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected kre=
tprobe_test1_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected kre=
tprobe_test2_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kre=
tprobe_test3_result: actual 0 !=3D expected 1
> > >
> >
> > Seems like this selftest is still broken. Please let me know if you
> > need help with building and running BPF selftests to reproduce this
> > locally.
>
> Thanks, It will be helpful. Also I would like to know, is there any
> debug mode (like print more debug logs)?

So first of all, the assumption is that you will build a most recent
kernel with Kconfig values set from
tools/testing/selftests/bpf/config, so make sure you  append that to
your kernel config. Then build the kernel, BPF selftests' Makefile
tries to find latest built kernel (according to KBUILD_OUTPUT/O/etc).

Now to building BPF selftests:

$ cd tools/testing/selftests/bpf
$ make -j$(nproc)

You'll need decently recent Clang and a few dependent packages. At
least elfutils-devel, libzstd-devel, but there might be a few more
which I never can remember.

Once everything is built, you can run the failing test with

$ sudo ./test_progs -t kprobe_multi_testmod_test -v

The source code for user space part for that test is in
prog_tests/kprobe_multi_testmod_test.c and BPF-side is in
progs/kprobe_multi.c.

Taking failing output from the test:

> > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kre=
tprobe_test3_result: actual 0 !=3D expected 1

kretprobe_test3_result is a sort of identifier for a test condition,
you can find a corresponding line in user space .c file grepping for
that:

ASSERT_EQ(skel->bss->kretprobe_testmod_test3_result, 1,
"kretprobe_test3_result");

Most probably the problem is in:

__u64 addr =3D bpf_get_func_ip(ctx);

which is then checked as

if ((const void *) addr =3D=3D &bpf_testmod_fentry_test3)


With your patches this doesn't match anymore.


Hopefully the above gives you some pointers, let me know if you run
into any problems.

>
> Thank you,
>
> >
> > >
> > > Please note: this email is coming from an unmonitored mailbox. If you=
 have
> > > questions or feedback, please reach out to the Meta Kernel CI team at
> > > kernel-ci@meta.com.
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

