Return-Path: <bpf+bounces-70424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D2ABBE9C4
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 18:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFD53B3D87
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80D21B0437;
	Mon,  6 Oct 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USqI2nT1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C30EEDE
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767364; cv=none; b=eTlBi+NZhdTKPqKDPxPSPiLIjMNgRE09vPDpfSSuCnPVKdlAwn+Ejt+2oq2I5m010soECEVEolIXnXmhvb9J8IV6ec0FGn7jq6Vua0FGfoocy8a+0KS7xlsIfxnuh0Hg7YjFkV7qXioTZOUL2XOMPK/QbHEAckFcRCzc2SrgJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767364; c=relaxed/simple;
	bh=k6d9nspIl8of5tO8CEgDH3xMf4QLrN3jL9WuCtzNEbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rl5KCsFtjSLyYRlEFVQGL4ghvk8Eber78WOcLYDoLEIE1uQmUMp8KIbZ7usgll21ghKKG29B+q6w3Poll5r7y0x3NRzejFbwZ8MzSvdXx4hXIqT7SNgJ/MCyfpKrti0phk0+o3pEMp/rJ4US/fhLnFTwr+MLurbWWFE2pppjosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USqI2nT1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so4820010a91.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759767362; x=1760372162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g12kBL0xaiND6vxIhDWxiR0rqUsruAdT/PEsLGn27Fo=;
        b=USqI2nT1u8RoSRA/SfJpFIXr2rARoHo3AK8PWT4rksCYWn9y7thsSF89uDWgs8d+FM
         64qrlOF00NGXeatzoa0xlJNxka6+os9gkifRQPDP/W/vs7a021DXnhs83JVYvmue625P
         /W6H1TCynbwZSSAgIx1iSOXr4cgtlmMP6qYvWcBwphpiOwyPIULAmHmVThswjlXaM46o
         lqXANVjNGs7bv3fHGdPXvdju6TTwgjpt5R/4QrxIo1psAuWtXNnkYlW5008++GxxpFN/
         U3vVFi/9x2UiLoj+03y+vW9YpHvk+cuCs73d1Zm9tsAfzuPnzmaNJCUaX9nDSsSNyA4m
         mwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767362; x=1760372162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g12kBL0xaiND6vxIhDWxiR0rqUsruAdT/PEsLGn27Fo=;
        b=tFiZcIxsULgBzkvnHrRmfbbcYUqLh9v87ZSX68Biy5ElWgusdo6oYQ+IbZegaQCj3i
         U64M2sSPybd7KynnLP/89GyAcyYoOsLWvRQuD9kRIvm1iiFApUCBUwofXUoTNDhhZszd
         oXTZoPtO2MKavrG34ZsaGCXmRf+WA1Gbvy+96bLmsVe96rH/tIsVFFekHvzC958L58ED
         OlvLkmbdMZTqWCJinehgyTVW+rPPGoKrmcI7MKZ60VddtzDx9hXxcJk8MfE9TadvKHE1
         bCCrQLp12+PiRlFRZFO7qyXBvG6r99OpOL/IJMCudo7IkIQB/fCV9k7xFOs58Lpj/sA7
         Pkaw==
X-Gm-Message-State: AOJu0YyI7BhjTCl8ldFVTwQvW+OxKpMX+RTbHr53a6mLKJKvRqk4unHt
	wOjEdi9zbaTEy+zi6G8D8GtgZIgKfNGHwMsTezu6Ge64cH9RU113itXLTxYQitU00ZS67WchIrR
	/hZmg/hqE5f6BjBbZW9CBD0JvrQHR5rw=
X-Gm-Gg: ASbGnctApKn8FHHSDHWTFSh6uAgZ2Bt/zx3yUiKnSXH1T57VqlOnDqUrwmZPxbK6Gdc
	NRnPJp4xgex03WgfKvtEE9hQPpRWJ718cSjAN6U+7KnnG/KnbcMRhWPa0ao2Os0NO+nONLCQH9m
	BtLOcF45CVH2jBKas9Pyxcf6AFslBYeChMt3YmlEXWR9s+/1nPRkMsSHpwnDqHAow8XZwfbFKoq
	pPoRuMGsP5/fSiB8fwcrPgmnBrHM7dfx3qgTy13o1ylBmQ=
X-Google-Smtp-Source: AGHT+IFjQR10mKtXdezbUiUOrsydKoKJgbiG5kQgS6pATQDMHTQ7F8pDgy71JNz3Bai2hExARdgbAXWam1qSIRMlV8E=
X-Received: by 2002:a17:90b:3a8d:b0:32d:dc3e:5575 with SMTP id
 98e67ed59e1d1-339c27085b7mr14109523a91.5.1759767361924; Mon, 06 Oct 2025
 09:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
 <20251003160416.585080-11-mykyta.yatsenko5@gmail.com> <CAEf4Bzbw+udD6Fud2WshVrCK=mGqisjagZrapsQwM=0G9ipesg@mail.gmail.com>
 <62376422-6d60-42b9-b09e-393396fb7302@gmail.com>
In-Reply-To: <62376422-6d60-42b9-b09e-393396fb7302@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Oct 2025 09:15:49 -0700
X-Gm-Features: AS18NWA6TC5zMvzWCDRvlOKm3qqYCQaofXK5sWncke_vU_BaJot_-wOxV3kiIGU
Message-ID: <CAEf4BzZq1er3=zCDT2f0FivbqX-7nF_oTXmB+5eX+B7O4ZtAOA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 10/10] selftests/bpf: add file dynptr tests
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 4:50=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 10/3/25 21:02, Andrii Nakryiko wrote:
> > On Fri, Oct 3, 2025 at 9:04=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Introducing selftests for validating file-backed dynptr works as
> >> expected.
> >>   * validate implementation supports dynptr slice and read operations
> >>   * validate destructors should be paired with initializers
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   .../selftests/bpf/prog_tests/file_reader.c    |  81 ++++++
> >>   .../testing/selftests/bpf/progs/file_reader.c | 241 ++++++++++++++++=
++
> >>   .../selftests/bpf/progs/file_reader_fail.c    |  57 +++++
> >>   3 files changed, 379 insertions(+)
> >>   create mode 100644 tools/testing/selftests/bpf/prog_tests/file_reade=
r.c
> >>   create mode 100644 tools/testing/selftests/bpf/progs/file_reader.c
> >>   create mode 100644 tools/testing/selftests/bpf/progs/file_reader_fai=
l.c
> > Non-sleepable file dynptr can fail to read, so this test is a bit
> > fragile. Let's have a sleepable test (fentry.s or something like
> > that?)
> This is sleepable, because it runs in task work callback.

ah, I missed task_work, great

(but then also for completeness let's have non-sleepable test as well,
especially with MADV_PAGEOUT it should be reliably failing and with
PAGEIN should be succeeding)

> >
> > Plus, can you please add a test that validates that we do page in file
> > contents even if it was not physically in memory? see madvise(addr,
> > page_sz, MADV_PAGEOUT) in selftests
> I tried to tell kernel to evict those pages via: posix_fadvise(fd, 0, 0,
> POSIX_FADV_DONTNEED);
> I'll rework to madvise(addr, page_sz, MADV_PAGEOUT)

ok, thanks. and just keep in mind that addr has to be page-aligned for
this to work reliably

> >
> >> +int err;
> >> +void *user_ptr;
> >> +char buf[1024];
> >> +char *user_buf;
> >> +volatile const __u32 user_buf_sz;
> >> +volatile const __s32 test_type =3D -1;
> >> +
> >> +static int process_vma(struct task_struct *task, struct vm_area_struc=
t *vma, void *data);
> >> +static int search_elf(struct file *file);
> >> +static int validate_large_file_read(struct file *file);
> >> +static int task_work_callback(struct bpf_map *map, void *key, void *v=
alue);
> >> +
> >> +SEC("raw_tp/sys_enter")
> >> +int on_getpid(void *ctx)
> >> +{
> >> +       struct task_struct *task =3D bpf_get_current_task_btf();
> >> +       struct elem *work;
> >> +       int key =3D 0;
> > this will be called for every syscall in the system, regardless of the
> > process, so you probably need to filter this by process ID?
> >
> >> +
> >> +       work =3D bpf_map_lookup_elem(&arrmap, &key);
> >> +       if (!work) {
> >> +               err =3D 1;
> >> +               return 0;
> >> +       }
> >> +       bpf_task_work_schedule_signal(task, &work->tw, &arrmap, task_w=
ork_callback, NULL);
> >> +       return 0;
> >> +}
> >> +
> > [...]
> >
> >> +static long process_vma_unreleased_ref(struct task_struct *task, stru=
ct vm_area_struct *vma,
> >> +                                      void *data)
> >> +{
> >> +       struct bpf_dynptr dynptr;
> >> +
> >> +       if (!vma->vm_file)
> >> +               return 1;
> >> +
> >> +       err =3D bpf_dynptr_from_file(vma->vm_file, 0, &dynptr);
> >> +       return err ? 1 : 0;
> >> +}
> >> +
> >> +SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
> >> +__failure __msg("Unreleased reference id=3D") int on_nanosleep_unrele=
ased_ref(void *ctx)
> > nit: keep annotations on separate line from the function itself
> >
> >> +{
> >> +       struct task_struct *task =3D bpf_get_current_task_btf();
> >> +
> >> +       bpf_find_vma(task, (unsigned long)user_ptr, process_vma_unrele=
ased_ref, NULL, 0);
> >> +       return 0;
> >> +}
> >> +
> >> +SEC("xdp")
> >> +__failure __msg("Expected a dynptr of type file as arg #0")
> >> +int xdp_wrong_dynptr_type(struct xdp_md *xdp)
> >> +{
> >> +       struct bpf_dynptr dynptr;
> >> +
> >> +       bpf_dynptr_from_xdp(xdp, 0, &dynptr);
> >> +       bpf_dynptr_file_discard(&dynptr);
> >> +       return 0;
> >> +}
> >> +
> >> +SEC("xdp")
> >> +__failure __msg("Expected an initialized dynptr as arg #0")
> >> +int xdp_no_dynptr_type(struct xdp_md *xdp)
> >> +{
> >> +       struct bpf_dynptr dynptr;
> >> +
> >> +       bpf_dynptr_file_discard(&dynptr);
> >> +       return 0;
> >> +}
> >> --
> >> 2.51.0
> >>
>

