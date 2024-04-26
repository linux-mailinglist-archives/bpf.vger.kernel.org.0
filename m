Return-Path: <bpf+bounces-27891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B028B2FA6
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 07:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD78E282167
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 05:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DF913A259;
	Fri, 26 Apr 2024 05:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZHQRs26"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE801849
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714107921; cv=none; b=g5zeQGdYaGok/N32Q2zs0GM4mgAw4saIhpwGwJeW1y0l3IeuQDx0r4aQg/DIUxjlqaHMg83rbfcJm+W51Hf6k33S2KV7Q7H1jGBnjhPHsgKGaGWaMUSAjjqynQUklavK3ckezx1fEfdEVoPV8FzdqxqDPoMu0VNSXDlD5iNuc2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714107921; c=relaxed/simple;
	bh=N4VLdnFRpp54iZ/pQ4RMo0eVgZjryEkOjUGssdqb7S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ux3h+5Z8B5nwqyrzgE6zj+rqgJ8SPI4Re1Lbs3R18mSO5ToAzIqBQbbjJlv5NuebtszWIjE1NRlrh4jOMdnEBTQdlKaM4pZzzd8/pIlMdPYBzGUImQq9wPDQQ0NOg4dZYjSqVXk+JPZ7I0QyOatbMrNNRwEVaUQ9OaJ1Aia5iAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZHQRs26; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6a073f10e8eso9151236d6.2
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 22:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714107918; x=1714712718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ4GQ+JdvlXogJZTb4q21kJw2Q0NjFLGEV/OpDnIrsQ=;
        b=HZHQRs26Y1xME8CeTw82YOjiOwtBHNd1A3qKg9JQOtHQ8djds9e9EL4YvkdCau/ogd
         /8UbofejrJAzC1OCNKSh+cBYOlHllrkqTzekKUXk3RMe6ldV1wxBb1hBfCYz0gKZVICb
         IhJWqGuDMe9JzopHtL5ye8Dx7WGd1mvCnG9UOMGs+5jqNdaqSOdyNxjmPC/opE97yF+H
         BZcXVLRlGoB6Znc2P9jGjnHUWUmcPJMVEfq5oh5eR1I+Ckt9692FfRwZfZf89nEAeJ6g
         5PjEPtqGZcZ1id/4k86hZhYfp8yTDcDNin28oiR3HK6CB/5pjQyQH/jMzZSvtWYngf0Q
         U/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714107918; x=1714712718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZ4GQ+JdvlXogJZTb4q21kJw2Q0NjFLGEV/OpDnIrsQ=;
        b=NscALHK/4413lTsajfHPkwSVryx9oiG22Ezo7ZtBH90Noz39QwUO5b23tVRTQkLcfJ
         1IsYAaURKEqKe1Gerix9YUMphlqYWP1GuxNsQhqPQX4H/CQVv870ZNT6oBLQQjh7Ez44
         TJyFIeAYd6CA9jtiE5EXy6BqnbtKkKIhjkkfaYTE39CMO4qDp3/nRsanjsiWka+Lg5lM
         WFPA4TZ+GYw2UmIXwetBlFvvxM1DioVIdaKY4/kmGBitHxHdcdlIVyV8Vf3tAFsTwWj1
         bOwxh41ZbhWrIFjQa+gRkpfaZrUPbH7DtJrLUjgfFYrchDfICm3aH/jrc7FsLgRu68Nr
         RriQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6RBHyb9OSSZObG2qX47HMxg3EyA29SrmGZqVLwNzSQMKqqPoFRNwmzOT6a99Uzx7nT7vmnO+jfe+NWZysBRMAFw3u
X-Gm-Message-State: AOJu0YxX+GDGQESsYb4apZ6qpwKE+KdfHnnFoQvfFg9sGMbg3IHLTV/4
	GjahzLjY/x/a3eqzzmwtmy74BD23tUBz9G7mhoEkaSbHhGq9SbOZYU+h+Krf21yz4aigneSxcW3
	wSxsAAmOE2eVTb08rE4pDmZlnmy0=
X-Google-Smtp-Source: AGHT+IE0SgRxNGhUNbz/uWQ3Kx4kIzTEDdnCrnS517aqi0PkJi86gtR0Sf3mcaWeV7YB8Bzbca9zodcxyNkco9CKaSs=
X-Received: by 2002:a05:6214:300b:b0:6a0:556e:4c3d with SMTP id
 ke11-20020a056214300b00b006a0556e4c3dmr2015475qvb.44.1714107918451; Thu, 25
 Apr 2024 22:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411131127.73098-1-laoar.shao@gmail.com> <CALOAHbCBxGbLH0+1fSTQtt3K8yXX9oG4utkiHn=+dxpKZ+64cw@mail.gmail.com>
 <CAEf4BzbynKkK_sct2WdTrF2F+RJ1tD3F6nYAew+Gq82qokgQGA@mail.gmail.com>
 <CALOAHbBBDwxBGOrDWqGf2b8bRRii8DnBHCU9cAbp_Sw-Q6XKBA@mail.gmail.com> <CAEf4BzZDUQextxUZGVDsctUhM718nvq+XX=HQSbUVaRkxXi3Tg@mail.gmail.com>
In-Reply-To: <CAEf4BzZDUQextxUZGVDsctUhM718nvq+XX=HQSbUVaRkxXi3Tg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 26 Apr 2024 13:04:41 +0800
Message-ID: <CALOAHbDQEaSncsAAt7_JGU_nXWBjp=4o-zgXxiy0kSZPg93cgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Add a generic bits iterator
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:15=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 24, 2024 at 10:37=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > On Thu, Apr 25, 2024 at 8:34=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Apr 11, 2024 at 6:51=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > On Thu, Apr 11, 2024 at 9:11=E2=80=AFPM Yafang Shao <laoar.shao@gma=
il.com> wrote:
> > > > >
> > > > > Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have b=
een
> > > > > added for the new bpf_iter_bits functionality. These kfuncs enabl=
e the
> > > > > iteration of the bits from a given address and a given number of =
bits.
> > > > >
> > > > > - bpf_iter_bits_new
> > > > >   Initialize a new bits iterator for a given memory area. Due to =
the
> > > > >   limitation of bpf memalloc, the max number of bits to be iterat=
ed
> > > > >   over is (4096 * 8).
> > > > > - bpf_iter_bits_next
> > > > >   Get the next bit in a bpf_iter_bits
> > > > > - bpf_iter_bits_destroy
> > > > >   Destroy a bpf_iter_bits
> > > > >
> > > > > The bits iterator can be used in any context and on any address.
> > > > >
> > > > > Changes:
> > > > > - v5->v6:
> > > > >   - Add positive tests (Andrii)
> > > > > - v4->v5:
> > > > >   - Simplify test cases (Andrii)
> > > > > - v3->v4:
> > > > >   - Fix endianness error on s390x (Andrii)
> > > > >   - zero-initialize kit->bits_copy and zero out nr_bits (Andrii)
> > > > > - v2->v3:
> > > > >   - Optimization for u64/u32 mask (Andrii)
> > > > > - v1->v2:
> > > > >   - Simplify the CPU number verification code to avoid the failur=
e on s390x
> > > > >     (Eduard)
> > > > > - bpf: Add bpf_iter_cpumask
> > > > >   https://lwn.net/Articles/961104/
> > > > > - bpf: Add new bpf helper bpf_for_each_cpu
> > > > >   https://lwn.net/Articles/939939/
> > > > >
> > > > > Yafang Shao (2):
> > > > >   bpf: Add bits iterator
> > > > >   selftests/bpf: Add selftest for bits iter
> > > > >
> > > > >  kernel/bpf/helpers.c                          | 120 ++++++++++++=
+++++
> > > > >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> > > > >  .../selftests/bpf/progs/verifier_bits_iter.c  | 127 ++++++++++++=
++++++
> > > > >  3 files changed, 249 insertions(+)
> > > > >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bi=
ts_iter.c
> > > > >
> > > > > --
> > > > > 2.39.1
> > > > >
> > > >
> > > > It appears that the test case failed on s390x when the data is
> > > > a u32 value because we need to set the higher 32 bits.
> > > > will analyze it.
> > > >
> > >
> > > Hey Yafang, did you get a chance to debug and fix the issue?
> > >
> >
> > Hi Andrii,
> >
> > Apologies for the delay; I recently returned from an extended holiday.
> >
> > The issue stems from the limitations of bpf_probe_read_kernel() on
> > s390 architecture. The attachment provides a straightforward example
> > to illustrate this issue. The observed results are as follows:
> >
> >     Error: #463/1 verifier_probe_read/probe read 4 bytes
> >     8897 run_subtest:PASS:obj_open_mem 0 nsec
> >     8898 run_subtest:PASS:unexpected_load_failure 0 nsec
> >     8899 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
> >     8900 run_subtest:FAIL:659 Unexpected retval: 2817064 !=3D 512
> >
> >     Error: #463/2 verifier_probe_read/probe read 8 bytes
> >     8903 run_subtest:PASS:obj_open_mem 0 nsec
> >     8904 run_subtest:PASS:unexpected_load_failure 0 nsec
> >     8905 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
> >     8906 run_subtest:FAIL:659 Unexpected retval: 0 !=3D 512
> >
> > More details can be found at:  https://github.com/kernel-patches/bpf/pu=
ll/6872
> >
> > Should we consider this behavior of bpf_probe_read_kernel() as
> > expected, or is it something that requires fixing?
> >
>
> I might be missing something, but there is nothing wrong with
> bpf_probe_read_kernel() behavior. In "read 4" case you are overwriting
> only upper 4 bytes of u64, so lower 4 bytes are garbage. In "read 8"
> you are reading (upper) 4 bytes of garbage from uninitialized
> data_dst.

The issue doesn't lie with the dst but rather with the src. Even after
initializing the destination, the operation still fails. You can find
more details in the following link:
https://github.com/kernel-patches/bpf/pull/6882. It appears that
bpf_probe_read_kernel() encounters difficulties when dealing with
non-long-aligned source addresses.

>
> So getting back to iter implementation. Make sure you are
> zero-initializing that u64 value you are reading into?
>

It has been zero-initialized:

+ kit->nr_bits =3D 0;
+ kit->bits_copy =3D 0;

--=20
Regards
Yafang

