Return-Path: <bpf+bounces-27794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EA38B1C6B
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 10:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384612842C4
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 08:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320806BFA3;
	Thu, 25 Apr 2024 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxtWeEBs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC426E60F
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032237; cv=none; b=g3xrWwjNsn2ykQeDU0VCCxRjfZg3ncckik90To6kBxaGqKALwdwjryncSc0FOJVsz7XzQ2J4+TxNqN4GYKQ6+wsorRwr9Den1H1WLnkXBy1yZ7h0unJPKN5T1eHEjfcBZrHAEqCZkXdlzFD+jIr0rrl3HviN+VDBDn0SoAxW06U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032237; c=relaxed/simple;
	bh=l5O5Wkdmsa6y1yMJXw/fkri0a0YDeiH0B4WSSQJaWf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4XovcLTVazcibpNxIuIDNOH4dESCCIvL1U+Q4cdvUF1GtiV6Mbw/w4GXs0OsFw3SRImyBVMqiOEibU8ksx6f9OeUBW0X9U9j/FkAPz7cFXoKlP5IvNVGRGvxu3Nb4NYrZom+En4PrZ2d5Xg2Vt7UvynvSYyuXWfJCzDxxRg/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxtWeEBs; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6a04c581ee3so4633316d6.0
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714032233; x=1714637033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwpnQtc2A+732cL2zqgyk2pxrYXEcIQYr7z3qBcJW1Q=;
        b=kxtWeEBs2QxWysGxn9sGqpjELxf0n186aqDoWuYhmztybINMoh6DwUZdZs2vXo9LxI
         TvziYFF70BND4fZDlXRrqHvI/At8W8zrM5ZdsdnDldK4kuZkyRnIKzHDK9Wxn4ldUevN
         YSNCNTXiNIbp9Tl3K0yn2S4dOzyVBNu9Q2ey3R77SapY31INBUMXAxwcCX/7vQo95pv2
         tl0tWn6MeDHPsbc8DeDrabBmo8CovyPGEaZVG8uXL1/yCE+OeWX9g4h2mLR0Oo3NnVzu
         YxpRc13M49BQnLy7GECA5kFZRIp/v2AoJubUYWJQRNa4BH1yV1eQsE5Fau2Bhm4oYfAM
         JveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714032233; x=1714637033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwpnQtc2A+732cL2zqgyk2pxrYXEcIQYr7z3qBcJW1Q=;
        b=vCV7qPWtar/ZVuE3XbOanowDs1nM4ftmlLNYklwyyyRdC76VaDyetqraYkVmV3AObU
         HraOkT/Lr0Rn6zJY0kJTDz4YF+zHWtawA87DWAXS27U/JaSnU6xclY0eITxDmbRuOi22
         bXhkvSmovqBiABomZxZ8PO/biqps1355//6ggGihLVZELHx7uNWTvu5iqHKV0fMsG0n8
         7V0Yt7N2/f6zsFPXhgdDugMF1jbiKM+loJcSqzRSSE3Qq8kCBDiWDwdy8/USClHKvLJh
         f6kCdesBZ2g8r2KQB3LSabMPrxEWL7+DK08wx8H1Lx9bKjCFcfl3N3h3j3Uz30JXGPDb
         ELRA==
X-Forwarded-Encrypted: i=1; AJvYcCWrj5AVpERbe2MdTgLT7lGpiDSweqCxY8NcbFAg8FyYtQfEkUta9X4qxv85TDitIYaKmGqKezoIdG9TVFBTRwg3rZht
X-Gm-Message-State: AOJu0YzEdqxjimVXH0lanCj/1NTFFNPRQ2lNJO/yBxiF00mtSiu4O2A1
	YeiLm5iI+7TMSVSXOmZs5kQvJx3nvFvA8hg6OfPFW96OxWx/WUbVWdna84fvZrPa0zQhLbVlu4p
	riKGSu8Bmdz2qSo62dZovFJpLEPY=
X-Google-Smtp-Source: AGHT+IGJlwQY8nlr8blqiFZkSo10ueKkFFDIXDETsranVMCjHc7hF0OUE/Z04nM7epzJSNIoEg2TuqN6kp+NYBzgL5w=
X-Received: by 2002:a05:6214:11ad:b0:6a0:82ae:f0b with SMTP id
 u13-20020a05621411ad00b006a082ae0f0bmr5545477qvv.33.1714032233491; Thu, 25
 Apr 2024 01:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411131127.73098-1-laoar.shao@gmail.com> <CALOAHbCBxGbLH0+1fSTQtt3K8yXX9oG4utkiHn=+dxpKZ+64cw@mail.gmail.com>
 <CAEf4BzbynKkK_sct2WdTrF2F+RJ1tD3F6nYAew+Gq82qokgQGA@mail.gmail.com>
 <CALOAHbBBDwxBGOrDWqGf2b8bRRii8DnBHCU9cAbp_Sw-Q6XKBA@mail.gmail.com> <f455382b-d983-48d7-831d-f2ae4b8757b3@linux.dev>
In-Reply-To: <f455382b-d983-48d7-831d-f2ae4b8757b3@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 25 Apr 2024 16:03:16 +0800
Message-ID: <CALOAHbCdJpGf=ETXdPo4GbXQ0POsHsCJ+geXd5PYPshz=j3XWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Add a generic bits iterator
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 2:05=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 4/24/24 10:36 PM, Yafang Shao wrote:
> > On Thu, Apr 25, 2024 at 8:34=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >> On Thu, Apr 11, 2024 at 6:51=E2=80=AFAM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> >>> On Thu, Apr 11, 2024 at 9:11=E2=80=AFPM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> >>>> Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have been
> >>>> added for the new bpf_iter_bits functionality. These kfuncs enable t=
he
> >>>> iteration of the bits from a given address and a given number of bit=
s.
> >>>>
> >>>> - bpf_iter_bits_new
> >>>>    Initialize a new bits iterator for a given memory area. Due to th=
e
> >>>>    limitation of bpf memalloc, the max number of bits to be iterated
> >>>>    over is (4096 * 8).
> >>>> - bpf_iter_bits_next
> >>>>    Get the next bit in a bpf_iter_bits
> >>>> - bpf_iter_bits_destroy
> >>>>    Destroy a bpf_iter_bits
> >>>>
> >>>> The bits iterator can be used in any context and on any address.
> >>>>
> >>>> Changes:
> >>>> - v5->v6:
> >>>>    - Add positive tests (Andrii)
> >>>> - v4->v5:
> >>>>    - Simplify test cases (Andrii)
> >>>> - v3->v4:
> >>>>    - Fix endianness error on s390x (Andrii)
> >>>>    - zero-initialize kit->bits_copy and zero out nr_bits (Andrii)
> >>>> - v2->v3:
> >>>>    - Optimization for u64/u32 mask (Andrii)
> >>>> - v1->v2:
> >>>>    - Simplify the CPU number verification code to avoid the failure =
on s390x
> >>>>      (Eduard)
> >>>> - bpf: Add bpf_iter_cpumask
> >>>>    https://lwn.net/Articles/961104/
> >>>> - bpf: Add new bpf helper bpf_for_each_cpu
> >>>>    https://lwn.net/Articles/939939/
> >>>>
> >>>> Yafang Shao (2):
> >>>>    bpf: Add bits iterator
> >>>>    selftests/bpf: Add selftest for bits iter
> >>>>
> >>>>   kernel/bpf/helpers.c                          | 120 ++++++++++++++=
+++
> >>>>   .../selftests/bpf/prog_tests/verifier.c       |   2 +
> >>>>   .../selftests/bpf/progs/verifier_bits_iter.c  | 127 ++++++++++++++=
++++
> >>>>   3 files changed, 249 insertions(+)
> >>>>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits=
_iter.c
> >>>>
> >>>> --
> >>>> 2.39.1
> >>>>
> >>> It appears that the test case failed on s390x when the data is
> >>> a u32 value because we need to set the higher 32 bits.
> >>> will analyze it.
> >>>
> >> Hey Yafang, did you get a chance to debug and fix the issue?
> >>
> > Hi Andrii,
> >
> > Apologies for the delay; I recently returned from an extended holiday.
> >
> > The issue stems from the limitations of bpf_probe_read_kernel() on
> > s390 architecture. The attachment provides a straightforward example
> > to illustrate this issue. The observed results are as follows:
> >
> >      Error: #463/1 verifier_probe_read/probe read 4 bytes
> >      8897 run_subtest:PASS:obj_open_mem 0 nsec
> >      8898 run_subtest:PASS:unexpected_load_failure 0 nsec
> >      8899 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
> >      8900 run_subtest:FAIL:659 Unexpected retval: 2817064 !=3D 512
> >
> >      Error: #463/2 verifier_probe_read/probe read 8 bytes
> >      8903 run_subtest:PASS:obj_open_mem 0 nsec
> >      8904 run_subtest:PASS:unexpected_load_failure 0 nsec
> >      8905 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
> >      8906 run_subtest:FAIL:659 Unexpected retval: 0 !=3D 512
> >
> > More details can be found at:  https://github.com/kernel-patches/bpf/pu=
ll/6872
> >
> > Should we consider this behavior of bpf_probe_read_kernel() as
> > expected, or is it something that requires fixing?
>
> Maybe to guard the result with macros like __s390x__ to differentiate
> s390 vs. arm64/x86_64? There are some examples in prog_tests/* having
> such guards. probe_user.c:#if defined(__s390x__)
> test_bpf_syscall_macro.c:#if defined(__aarch64__) || defined(__s390__)
> xdp_adjust_tail.c:#if defined(__s390x__) xdp_do_redirect.c:#if
> defined(__s390x__)
>

That's feasible. Thank you for your suggestion. I'll make the necessary cha=
nges.

--=20
Regards
Yafang

