Return-Path: <bpf+bounces-27836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC3F8B2818
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 20:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA724282A17
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E17915252D;
	Thu, 25 Apr 2024 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdWUFQF0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FED15218E
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068927; cv=none; b=l8qu1b7O3eqTyeHXTlkk7xTxqlYtDnRHzx60k1wbGltjx8ay/0O3NLWNIA4hNeHZqaDFRgMmL2BFozMhSYPEe2wbJ5MlfkpVoNZtQHPDjXvw0iB5i7jh086N3X8EzA2Zn8823Sg1+02GLVnRHngHW9fvAAUl8sQIeN9C4vb54PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068927; c=relaxed/simple;
	bh=L08g+kyYMYek47d9SJteN9u4Xd4IwHYPJQHj3TT2RNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0yOZpGWOgUWedKkcN3/0LrVKDOenSf8DCgZossXHbwdlA16AbT7AwQEmhjWRH7QY+RMaUZULpUhNythG851+NJ1cm966LFoT0dld7U2M8PXBc78jmwzAB99GhOk6+9Tee/m/mDYRRlVYkFE8v5ppRjcxqXettNsm2aJJYG+2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdWUFQF0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-53fa455cd94so999671a12.2
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 11:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714068923; x=1714673723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hqQYGN6gcRRmXpjzfmZN1xvzxO8FRUarSLeSlaKE3A=;
        b=AdWUFQF0kJ0G90NaV7RwhnImO3v7ZOHKbQg6+hfD26UrXD8W1mvNLxznoavbwciWFS
         7/DMnvf9z16xbV+8n1PeoT5fBvHbjvEEs3vdHfA6jBwQt8HXkFE4TAiEncQEpaPXVUa5
         PTMRk3OHsiktZK79zP49DeW+NaabwMaXskyYsQFHUnVjwMxqVjDYp0msogi4QWczyiMi
         Iw3qZwJMtiO+NJoRBq0N5xZbumHNwcQqR7fvvbyQ/M7Js+h09apEwBDVOpAQoMBnb+eI
         X3Px3pFHb3dBwoDgsLkyq/kVyv01huW+tzu4fuMJA9rLTVhy5Py9ip+oxykfEWakwUjc
         8QSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068923; x=1714673723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hqQYGN6gcRRmXpjzfmZN1xvzxO8FRUarSLeSlaKE3A=;
        b=exnzYE3JsosEXyfey9OoB/UvR9YLxROURldT4yWIrtyJ9XWGFS9IueY4kShU+C7ulC
         KZy7/xqBMht9NUKLVRORhvypI16pQnPvQ3olTUM93a2Nvb+TNtU0D1acpcnTN34JFjKs
         xha56wPKuqEp+UxwoV+sJyCfkRwoNYpPrNEY4yIMYTgwr95jZZe1pRhu2TVFGsvjkS/e
         9w08aRf/jJwcltf+PMnnYQZa/axzDBxNabGQSnE1Y7/1tQCprg7UVqRlCbODu584ZIcm
         gS/BRD276nhqFIVhhm/YD8awaDW5ZjyR0lPl3ZuEHk8M+/ZTZdfNgpmRAfDjlkgWvchZ
         TOjg==
X-Forwarded-Encrypted: i=1; AJvYcCUdhF6/0v0q9Y6ev4jKjGYf883bPCwmt+PNUHndhMyrnuFP58AH+dClbj+Zu+YrBcX79m/21mlOCvcSao1/xAtmGKxG
X-Gm-Message-State: AOJu0YwCim3BpmVYMcdfkUSGzXbrFl9fBwOwRfSZXmVZ5ydykbUzqnl/
	nWGqGdpU/gkd75i8V4P6/RGXGMe9d0I8UX8sdKyL0mRtNzQloKd8hhbnzthOSZPz/H78wnq5jU0
	c9vhSDwoVkBliymm0r+RPmIQ5efw=
X-Google-Smtp-Source: AGHT+IGg33oGab9l9nyjumQ51d7owb6S07LFUnnIO8uDRosCjtEDEOh67fIl68dW6JK3eNypZOS22b/CvAEEnCHX1ng=
X-Received: by 2002:a17:90a:f306:b0:2ab:5681:3a7c with SMTP id
 ca6-20020a17090af30600b002ab56813a7cmr323236pjb.45.1714068923205; Thu, 25 Apr
 2024 11:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411131127.73098-1-laoar.shao@gmail.com> <CALOAHbCBxGbLH0+1fSTQtt3K8yXX9oG4utkiHn=+dxpKZ+64cw@mail.gmail.com>
 <CAEf4BzbynKkK_sct2WdTrF2F+RJ1tD3F6nYAew+Gq82qokgQGA@mail.gmail.com> <CALOAHbBBDwxBGOrDWqGf2b8bRRii8DnBHCU9cAbp_Sw-Q6XKBA@mail.gmail.com>
In-Reply-To: <CALOAHbBBDwxBGOrDWqGf2b8bRRii8DnBHCU9cAbp_Sw-Q6XKBA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Apr 2024 11:15:10 -0700
Message-ID: <CAEf4BzZDUQextxUZGVDsctUhM718nvq+XX=HQSbUVaRkxXi3Tg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Add a generic bits iterator
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:37=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> On Thu, Apr 25, 2024 at 8:34=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Apr 11, 2024 at 6:51=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > On Thu, Apr 11, 2024 at 9:11=E2=80=AFPM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have bee=
n
> > > > added for the new bpf_iter_bits functionality. These kfuncs enable =
the
> > > > iteration of the bits from a given address and a given number of bi=
ts.
> > > >
> > > > - bpf_iter_bits_new
> > > >   Initialize a new bits iterator for a given memory area. Due to th=
e
> > > >   limitation of bpf memalloc, the max number of bits to be iterated
> > > >   over is (4096 * 8).
> > > > - bpf_iter_bits_next
> > > >   Get the next bit in a bpf_iter_bits
> > > > - bpf_iter_bits_destroy
> > > >   Destroy a bpf_iter_bits
> > > >
> > > > The bits iterator can be used in any context and on any address.
> > > >
> > > > Changes:
> > > > - v5->v6:
> > > >   - Add positive tests (Andrii)
> > > > - v4->v5:
> > > >   - Simplify test cases (Andrii)
> > > > - v3->v4:
> > > >   - Fix endianness error on s390x (Andrii)
> > > >   - zero-initialize kit->bits_copy and zero out nr_bits (Andrii)
> > > > - v2->v3:
> > > >   - Optimization for u64/u32 mask (Andrii)
> > > > - v1->v2:
> > > >   - Simplify the CPU number verification code to avoid the failure =
on s390x
> > > >     (Eduard)
> > > > - bpf: Add bpf_iter_cpumask
> > > >   https://lwn.net/Articles/961104/
> > > > - bpf: Add new bpf helper bpf_for_each_cpu
> > > >   https://lwn.net/Articles/939939/
> > > >
> > > > Yafang Shao (2):
> > > >   bpf: Add bits iterator
> > > >   selftests/bpf: Add selftest for bits iter
> > > >
> > > >  kernel/bpf/helpers.c                          | 120 ++++++++++++++=
+++
> > > >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> > > >  .../selftests/bpf/progs/verifier_bits_iter.c  | 127 ++++++++++++++=
++++
> > > >  3 files changed, 249 insertions(+)
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits=
_iter.c
> > > >
> > > > --
> > > > 2.39.1
> > > >
> > >
> > > It appears that the test case failed on s390x when the data is
> > > a u32 value because we need to set the higher 32 bits.
> > > will analyze it.
> > >
> >
> > Hey Yafang, did you get a chance to debug and fix the issue?
> >
>
> Hi Andrii,
>
> Apologies for the delay; I recently returned from an extended holiday.
>
> The issue stems from the limitations of bpf_probe_read_kernel() on
> s390 architecture. The attachment provides a straightforward example
> to illustrate this issue. The observed results are as follows:
>
>     Error: #463/1 verifier_probe_read/probe read 4 bytes
>     8897 run_subtest:PASS:obj_open_mem 0 nsec
>     8898 run_subtest:PASS:unexpected_load_failure 0 nsec
>     8899 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
>     8900 run_subtest:FAIL:659 Unexpected retval: 2817064 !=3D 512
>
>     Error: #463/2 verifier_probe_read/probe read 8 bytes
>     8903 run_subtest:PASS:obj_open_mem 0 nsec
>     8904 run_subtest:PASS:unexpected_load_failure 0 nsec
>     8905 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
>     8906 run_subtest:FAIL:659 Unexpected retval: 0 !=3D 512
>
> More details can be found at:  https://github.com/kernel-patches/bpf/pull=
/6872
>
> Should we consider this behavior of bpf_probe_read_kernel() as
> expected, or is it something that requires fixing?
>

I might be missing something, but there is nothing wrong with
bpf_probe_read_kernel() behavior. In "read 4" case you are overwriting
only upper 4 bytes of u64, so lower 4 bytes are garbage. In "read 8"
you are reading (upper) 4 bytes of garbage from uninitialized
data_dst.

So getting back to iter implementation. Make sure you are
zero-initializing that u64 value you are reading into?


> --
> Regards
> Yafang

