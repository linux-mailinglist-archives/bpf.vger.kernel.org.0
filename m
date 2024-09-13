Return-Path: <bpf+bounces-39866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E09978A7C
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 23:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1551F24CD7
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 21:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B809E1509A5;
	Fri, 13 Sep 2024 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO8ZsIa6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149D13CF82
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726262222; cv=none; b=N5haWg6eIbjwHxcpC+E5aIbDyk/vnivhQKhsQaIhwgyLP26LyYtsrpqbLEQ5rwkxiMz/oRDDBkES5E5DB3LAdzhqWQfBJgdVqebIL5i2MYNDOn4mdck85gi9UaYDKhUaz209W8X7pWxWQH4017EI8GT9gVhvsYP0PZxnkY/kfzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726262222; c=relaxed/simple;
	bh=dUfnn9jK8x370YOJ2TbKk3fNH9s4VsXlu2fKsdUkXvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXHaD7YamVGa3xgXkyYIB/KjI1r9SPeudS/fwTy71+cZyCZvRulA7zpPqhhST/fYSHyM1O75FefXqspEZQbXRGqb+LLKQx5GytLUoswf3miih6jLIISzbe2QrHnl9Kcorm47c7ku9W+O3yB3GebiCPBEkKb1uW6La8LbEZQ09Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VO8ZsIa6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20536dcc6e9so10621955ad.2
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726262220; x=1726867020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQm5KbccffGwhR4G/nHdz02fKgnTAPfc7J6+rEHhYi0=;
        b=VO8ZsIa6k2Y8FbenbdcwLGgjDwLExiqOWI18NCBqKiB6YAfMvpwE2vYBfZACuV8MW8
         prVBqni4u4t/qrsbYGQ/Lwfr1bIzgTRo1xKbS8XWGCJye1ZYzS7tcjA+ZjH9wrr1IJu6
         HH3Wki6UJjHwjNZ/XgvACvbIQdL6Rs+QBH4uaKKVyZ48umvbgOznd8sfA1QHqjAF8M9n
         OctY7jaRvE1OIA6VEG2XI+djAVIE9TWuI9qt9PiYGNrR25MTANH9zzqBIpGpkq8U2NWJ
         fnWMu46YYc/5F3Z4SrT0qI76FQ7CPcwh9239a+dOENsR453AlXVffA+4VnBhR6QBov06
         8grA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726262220; x=1726867020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQm5KbccffGwhR4G/nHdz02fKgnTAPfc7J6+rEHhYi0=;
        b=nXuUNPRHvMCZuQ7J5o8CftDTQVRnA2ObdlTnR9c49NEMwk6i1azgOFEw8V85Hgmh0r
         YVHMpta23azZlQdvv6Wbt8aaYo1UQLOmctSt0l5HNSJkD3fK5+sOyvbwyzp4kuE6Vbxv
         OkB4cuOhZR2Nn5BPf3Ug0mYzTGVy7Qbj/JhuMsMynbqBZ26lq4iMBF8IeoC2bfccShJp
         edMyIO4a2zUrWQyIbq0Q/wFnXyXVMMM0UOQn3gOY27fbuDhYXZGh3pouNQ74OMLU+UO9
         royTVdI58yRlwa+D5QHXtytjaAQpv409XNioP7Nkc9wExBzdNfqxNgr6x7qUgAmWwD4z
         LFog==
X-Forwarded-Encrypted: i=1; AJvYcCVqK9CY7escAx0vAOCzgpf3FW1szzfLSlcb/jCUUx3UshwN4S0zzFbzJwI5w5ntEG8U63g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN41pnFmcwR7mhXufhXvb9ao2O3Wt0GjOamyKk26KGGN9UDFOm
	49KlDbCsm2Kx/dkiFJdXqDyO9RJNHC4JjfkNsxnc/61iO15xM2sJ3e8hAN66EYrFuDHRIMsnSWX
	Om6T14fLdfXZEtZ0irNsrdvX4I8U=
X-Google-Smtp-Source: AGHT+IFWRRIZhEatNrd7VGRzJ1RbloOg6jHwGyRx2Kjro19GGCGUBNVQNJj4kaYDpD9zM6P5JUV27rrJkc4bWxdGW6A=
X-Received: by 2002:a17:90b:1806:b0:2d8:f12f:6bed with SMTP id
 98e67ed59e1d1-2dbb9dc122emr5242859a91.3.1726262219941; Fri, 13 Sep 2024
 14:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
 <0170cd7d95df0583770c385c1e11bd27dfacf618b71b6e723f0952efc0ce9040@mail.kernel.org>
 <CAEf4BzZgAkSkMd6Vk3m1D-0AVqXp06PaBPr+2L7Dd3WRgJ8JvA@mail.gmail.com>
 <20240913085402.9e5b2c506a8973b099679d04@kernel.org> <CAEf4BzZEoNHgcLDPTPQ=yyQTZtEZoVrGbBbeTf3vqe_wcpS6EA@mail.gmail.com>
 <20240913175935.bb0892ab1e6052efc12c6423@kernel.org>
In-Reply-To: <20240913175935.bb0892ab1e6052efc12c6423@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Sep 2024 14:16:47 -0700
Message-ID: <CAEf4BzbJCnmHyb7X+RNqJGdcq0k8hM-MxjC5Lhtq+APgvdB2XQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/19] tracing: fprobe: function_graph: Multi-function
 graph and fprobe on fgraph
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: kernel-ci@meta.com, bot+bpf-ci@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, bpf <bpf@vger.kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 1:59=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Thu, 12 Sep 2024 18:55:40 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Thu, Sep 12, 2024 at 4:54=E2=80=AFPM Masami Hiramatsu <mhiramat@kern=
el.org> wrote:
> > >
> > > On Thu, 12 Sep 2024 11:41:17 -0700
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > + BPF ML
> > > >
> > > > On Thu, Sep 12, 2024 at 8:35=E2=80=AFAM <bot+bpf-ci@kernel.org> wro=
te:
> > > > >
> > > > > Dear patch submitter,
> > > > >
> > > > > CI has tested the following submission:
> > > > > Status:     FAILURE
> > > > > Name:       [v14,00/19] tracing: fprobe: function_graph: Multi-fu=
nction graph and fprobe on fgraph
> > > > > Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?=
series=3D889822&state=3D*
> > > > > Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10=
833792984
> > > > >
> > > > > Failed jobs:
> > > > > test_progs-aarch64-gcc: https://github.com/kernel-patches/bpf/act=
ions/runs/10833792984/job/30061791397
> > > > > test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patche=
s/bpf/actions/runs/10833792984/job/30061791836
> > > > > test_progs-s390x-gcc: https://github.com/kernel-patches/bpf/actio=
ns/runs/10833792984/job/30061757062
> > > > > test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/=
bpf/actions/runs/10833792984/job/30061757809
> > > > >
> > > > > First test_progs failure (test_progs-aarch64-gcc):
> > > > > #132 kprobe_multi_testmod_test
> > > > > serial_test_kprobe_multi_testmod_test:PASS:load_kallsyms_local 0 =
nsec
> > > > > #132/1 kprobe_multi_testmod_test/testmod_attach_api_syms
> > > > > test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> > > > > trigger_module_test_read:PASS:testmod_file_open 0 nsec
> > > > > test_testmod_attach_api:PASS:trigger_read 0 nsec
> > > > > kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kp=
robe_test1_result: actual 0 !=3D expected 1
> > > > > kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kp=
robe_test2_result: actual 0 !=3D expected 1
> > > > > kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kp=
robe_test3_result: actual 0 !=3D expected 1
> > > > > kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected=
 kretprobe_test1_result: actual 0 !=3D expected 1
> > > > > kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected=
 kretprobe_test2_result: actual 0 !=3D expected 1
> > > > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected=
 kretprobe_test3_result: actual 0 !=3D expected 1
> > > > > #132/2 kprobe_multi_testmod_test/testmod_attach_api_addrs
> > > > > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > > > > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > > > > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > > > > test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> > > > > trigger_module_test_read:PASS:testmod_file_open 0 nsec
> > > > > test_testmod_attach_api:PASS:trigger_read 0 nsec
> > > > > kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kp=
robe_test1_result: actual 0 !=3D expected 1
> > > > > kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kp=
robe_test2_result: actual 0 !=3D expected 1
> > > > > kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kp=
robe_test3_result: actual 0 !=3D expected 1
> > > > > kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected=
 kretprobe_test1_result: actual 0 !=3D expected 1
> > > > > kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected=
 kretprobe_test2_result: actual 0 !=3D expected 1
> > > > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected=
 kretprobe_test3_result: actual 0 !=3D expected 1
> > > > >
> > > >
> > > > Seems like this selftest is still broken. Please let me know if you
> > > > need help with building and running BPF selftests to reproduce this
> > > > locally.
> > >
> > > Thanks, It will be helpful. Also I would like to know, is there any
> > > debug mode (like print more debug logs)?
> >
> > So first of all, the assumption is that you will build a most recent
> > kernel with Kconfig values set from
> > tools/testing/selftests/bpf/config, so make sure you  append that to
> > your kernel config. Then build the kernel, BPF selftests' Makefile
> > tries to find latest built kernel (according to KBUILD_OUTPUT/O/etc).
> >
> > Now to building BPF selftests:
> >
> > $ cd tools/testing/selftests/bpf
> > $ make -j$(nproc)
> >
> > You'll need decently recent Clang and a few dependent packages. At
> > least elfutils-devel, libzstd-devel, but there might be a few more
> > which I never can remember.
> >
> > Once everything is built, you can run the failing test with
> >
> > $ sudo ./test_progs -t kprobe_multi_testmod_test -v
> >
> > The source code for user space part for that test is in
> > prog_tests/kprobe_multi_testmod_test.c and BPF-side is in
> > progs/kprobe_multi.c.
>
> Thanks for the information!
>
> >
> > Taking failing output from the test:
> >
> > > > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected=
 kretprobe_test3_result: actual 0 !=3D expected 1
> >
> > kretprobe_test3_result is a sort of identifier for a test condition,
> > you can find a corresponding line in user space .c file grepping for
> > that:
> >
> > ASSERT_EQ(skel->bss->kretprobe_testmod_test3_result, 1,
> > "kretprobe_test3_result");
> >
> > Most probably the problem is in:
> >
> > __u64 addr =3D bpf_get_func_ip(ctx);
>
> Yeah, and as I replyed to another thread, the problem is
> that the ftrace entry_ip is not symbol ip.
>
> We have ftrace_call_adjust() arch function for reverse
> direction (symbol ip to ftrace entry ip) but what we need
> here is the reverse translate function (ftrace entry to symbol)
>
> The easiest way is to use kallsyms to find it, but this is
> a bit costful (but it just increase bsearch in several levels).
> Other possible options are
>
>  - Change bpf_kprobe_multi_addrs_cmp() to accept a range
>    of address. [sym_addr, sym_addr + offset) returns true,
>    bpf_kprobe_multi_cookie() can find the entry address.
>    The offset depends on arch, but 16 is enough.

This feels quite sloppy, tbh...

>
>  - Change bpf_kprobe_multi_addrs_cmp() to call
>    ftrace_call_adjust() before comparing. This may take a
>    cost but find actual entry address.

too expensive, unnecessary runtime overhead

>
>  - (Cached method) when making link->addrs, make a link->adj_addrs
>    array too, where adj_addrs[i] =3D=3D ftrace_call_adjust(addrs[i]).
>
> Let me try the 3rd one. It may consume more memory but the
> fastest solution.

I like the third one as well, but I'm not following why we'd need more memo=
ry.

We can store adjusted addresses in existing link->addrs, and we'll
need to adjust them to originals (potentially expensively) only in
bpf_kprobe_multi_link_fill_link_info(). But that's not a hot path, so
it doesn't matter.

>
> Thank you,
>
> >
> > which is then checked as
> >
> > if ((const void *) addr =3D=3D &bpf_testmod_fentry_test3)
> >
> >
> > With your patches this doesn't match anymore.
>
> It actually enables the fprobe on those architectures, so
> without my series, those test should be skipped.

Ok, cool, still, let's fix the issue.

>
> Thank you,
>
> >
> >
> > Hopefully the above gives you some pointers, let me know if you run
> > into any problems.
> >
> > >
> > > Thank you,
> > >
> > > >
> > > > >
> > > > > Please note: this email is coming from an unmonitored mailbox. If=
 you have
> > > > > questions or feedback, please reach out to the Meta Kernel CI tea=
m at
> > > > > kernel-ci@meta.com.
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

