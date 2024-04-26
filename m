Return-Path: <bpf+bounces-27943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798248B3D36
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 18:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304A728833D
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546C315B551;
	Fri, 26 Apr 2024 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODrLedtY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B415B120
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150266; cv=none; b=iuoNa7c53m8u90S3NMslo69hBO5/lHZFChgJM16EhyTppsPQbvZS/cqA7algWi1zhGucFP2u8nPG7DjX1Je28UE20DHk0WJ5e1f0zkBc5SpUWsvWz4H4TEh7bRPYvp3QVMLPZHmSdpgPFgCZdRLnjZXN4rwWe852fpZPqUnwJzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150266; c=relaxed/simple;
	bh=ZhwNCHCPbwknUA/AAko94NLtIwae7LasoKSgGPeSiTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muHClw2L9SOZ1QGdyBs+wYEPJn3/zV9uOfJvL6pTZCyDozb9FOMtAHQXGKaLGr+nhX8tK8ii8wOZh8VQHdKlMTW/gJx8N1z9QELoBYYN3UZprth/Z7fQCst+rkydZYnL/B9vyb94viop9vPrJ0wiV/XHb9HrqsJwRxVFp8fKZn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODrLedtY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3ca546d40so19688745ad.3
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714150265; x=1714755065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDNR/ANTiY/ndkKCEL6bJgdb8SU5EqrTQJtdJEN/adA=;
        b=ODrLedtY8Xq0DwzgPrMANqWiiFTge7voRaQScGbuX9orPbVGjTA8FWaf0i1JG5tT25
         HZ4/Qy3nKcGz6oLftrvnvNfm9zqUpXav2IkaLwaM6tIFmWFPJgUU8RRfztKf3P73l9Wh
         6jd4RATyUPvNpk+A/drdT+L/nsvDFRvruh6MhyhuMh+JtWN3Yk2Kzhk3ytq2Ix8VJVSn
         Unj4PWlL8vqTCZ/rfJOD+qkilse3TqmVb2/Zutunah2IF7RyZPAuxCAz8k7J7kS+i2KU
         NvQbtytUL1s+hlz1rfeQ3MrkTAXJLu9mUVPoAQtKJixm3XtkKaJt9EYcR9WNhd2TaH4/
         ujQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714150265; x=1714755065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDNR/ANTiY/ndkKCEL6bJgdb8SU5EqrTQJtdJEN/adA=;
        b=gdO+voQRe5mdBDF58fPQAUsEprbFP8wY9PyA67T5ssmTL2YsfbHtC67uoaHc3aghGm
         UXq1A1BemE3jqg3TDBO0AXaRlKigOhcj/qCVmDjj1+JMHSSV8+t4nrtyAQuhNb+wH+oH
         Ow0d6MfH/H/NsJ7pdqVYUiTGaQSH5V2L1P3mSW9APEBd3tEaAfw8WWl9biWsI+fFMic1
         crxIP2jNEmJkU+i1Oo9HzzIaiVul5gMKZY2DZRCiwzsGWvglpBPfYAv1FTtR1RneiZzX
         qLveL7a8gM+XUSUKFbPwv4CKMucczVWHlyOFf1iuI3AsbWFBfdoLsWTvUiJeHHBfvCgL
         QfYw==
X-Forwarded-Encrypted: i=1; AJvYcCXGBzuY1QFLkUVsRYgwBNPDfTeWSCHq8xVEiEqWLpwndpk6hiFgOxeARCeUA1St9TdP6qMJ9TiovKNJp1x4G1/VWVFE
X-Gm-Message-State: AOJu0YxlspKAdwvr41u33WCcy2MfhX6nT+8AP2ory8HoUAOhfQFz85HI
	vlpqqCn9o2p79wq1x6kCbwM2iEdqHIR5g/uCU7+RJOp+E7Ut0BaE6OGalt/aE8FYz4Fhl0PhBMK
	5OKQ34BBL3RR5wQWr8VB+M+DcJiM=
X-Google-Smtp-Source: AGHT+IE0oxn3tz8O8obeD38eXFd6FN4mskMqurJ+SfUy+7WENZixTnq5xlTIT0/wUf1NbZnnf4Zi+NZLvPZ1zA4duyE=
X-Received: by 2002:a17:903:11c3:b0:1e5:5bd7:87a4 with SMTP id
 q3-20020a17090311c300b001e55bd787a4mr3628816plh.16.1714150264625; Fri, 26 Apr
 2024 09:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411131127.73098-1-laoar.shao@gmail.com> <CALOAHbCBxGbLH0+1fSTQtt3K8yXX9oG4utkiHn=+dxpKZ+64cw@mail.gmail.com>
 <CAEf4BzbynKkK_sct2WdTrF2F+RJ1tD3F6nYAew+Gq82qokgQGA@mail.gmail.com>
 <CALOAHbBBDwxBGOrDWqGf2b8bRRii8DnBHCU9cAbp_Sw-Q6XKBA@mail.gmail.com>
 <CAEf4BzZDUQextxUZGVDsctUhM718nvq+XX=HQSbUVaRkxXi3Tg@mail.gmail.com> <CALOAHbDQEaSncsAAt7_JGU_nXWBjp=4o-zgXxiy0kSZPg93cgQ@mail.gmail.com>
In-Reply-To: <CALOAHbDQEaSncsAAt7_JGU_nXWBjp=4o-zgXxiy0kSZPg93cgQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 09:50:51 -0700
Message-ID: <CAEf4BzZbWTM-NtpEHM-c8z01YQrTCJX9VuWBViR1K5Fo-1Tt5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Add a generic bits iterator
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 10:05=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> On Fri, Apr 26, 2024 at 2:15=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Apr 24, 2024 at 10:37=E2=80=AFPM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > >
> > > On Thu, Apr 25, 2024 at 8:34=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Apr 11, 2024 at 6:51=E2=80=AFAM Yafang Shao <laoar.shao@gma=
il.com> wrote:
> > > > >
> > > > > On Thu, Apr 11, 2024 at 9:11=E2=80=AFPM Yafang Shao <laoar.shao@g=
mail.com> wrote:
> > > > > >
> > > > > > Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have=
 been
> > > > > > added for the new bpf_iter_bits functionality. These kfuncs ena=
ble the
> > > > > > iteration of the bits from a given address and a given number o=
f bits.
> > > > > >
> > > > > > - bpf_iter_bits_new
> > > > > >   Initialize a new bits iterator for a given memory area. Due t=
o the
> > > > > >   limitation of bpf memalloc, the max number of bits to be iter=
ated
> > > > > >   over is (4096 * 8).
> > > > > > - bpf_iter_bits_next
> > > > > >   Get the next bit in a bpf_iter_bits
> > > > > > - bpf_iter_bits_destroy
> > > > > >   Destroy a bpf_iter_bits
> > > > > >
> > > > > > The bits iterator can be used in any context and on any address=
.
> > > > > >
> > > > > > Changes:
> > > > > > - v5->v6:
> > > > > >   - Add positive tests (Andrii)
> > > > > > - v4->v5:
> > > > > >   - Simplify test cases (Andrii)
> > > > > > - v3->v4:
> > > > > >   - Fix endianness error on s390x (Andrii)
> > > > > >   - zero-initialize kit->bits_copy and zero out nr_bits (Andrii=
)
> > > > > > - v2->v3:
> > > > > >   - Optimization for u64/u32 mask (Andrii)
> > > > > > - v1->v2:
> > > > > >   - Simplify the CPU number verification code to avoid the fail=
ure on s390x
> > > > > >     (Eduard)
> > > > > > - bpf: Add bpf_iter_cpumask
> > > > > >   https://lwn.net/Articles/961104/
> > > > > > - bpf: Add new bpf helper bpf_for_each_cpu
> > > > > >   https://lwn.net/Articles/939939/
> > > > > >
> > > > > > Yafang Shao (2):
> > > > > >   bpf: Add bits iterator
> > > > > >   selftests/bpf: Add selftest for bits iter
> > > > > >
> > > > > >  kernel/bpf/helpers.c                          | 120 ++++++++++=
+++++++
> > > > > >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> > > > > >  .../selftests/bpf/progs/verifier_bits_iter.c  | 127 ++++++++++=
++++++++
> > > > > >  3 files changed, 249 insertions(+)
> > > > > >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_=
bits_iter.c
> > > > > >
> > > > > > --
> > > > > > 2.39.1
> > > > > >
> > > > >
> > > > > It appears that the test case failed on s390x when the data is
> > > > > a u32 value because we need to set the higher 32 bits.
> > > > > will analyze it.
> > > > >
> > > >
> > > > Hey Yafang, did you get a chance to debug and fix the issue?
> > > >
> > >
> > > Hi Andrii,
> > >
> > > Apologies for the delay; I recently returned from an extended holiday=
.
> > >
> > > The issue stems from the limitations of bpf_probe_read_kernel() on
> > > s390 architecture. The attachment provides a straightforward example
> > > to illustrate this issue. The observed results are as follows:
> > >
> > >     Error: #463/1 verifier_probe_read/probe read 4 bytes
> > >     8897 run_subtest:PASS:obj_open_mem 0 nsec
> > >     8898 run_subtest:PASS:unexpected_load_failure 0 nsec
> > >     8899 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
> > >     8900 run_subtest:FAIL:659 Unexpected retval: 2817064 !=3D 512
> > >
> > >     Error: #463/2 verifier_probe_read/probe read 8 bytes
> > >     8903 run_subtest:PASS:obj_open_mem 0 nsec
> > >     8904 run_subtest:PASS:unexpected_load_failure 0 nsec
> > >     8905 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
> > >     8906 run_subtest:FAIL:659 Unexpected retval: 0 !=3D 512
> > >
> > > More details can be found at:  https://github.com/kernel-patches/bpf/=
pull/6872
> > >
> > > Should we consider this behavior of bpf_probe_read_kernel() as
> > > expected, or is it something that requires fixing?
> > >
> >
> > I might be missing something, but there is nothing wrong with
> > bpf_probe_read_kernel() behavior. In "read 4" case you are overwriting
> > only upper 4 bytes of u64, so lower 4 bytes are garbage. In "read 8"
> > you are reading (upper) 4 bytes of garbage from uninitialized
> > data_dst.
>
> The issue doesn't lie with the dst but rather with the src. Even after
> initializing the destination, the operation still fails. You can find

Are you sure the operation "fails"? If it would fail, you'd get a
negative error code, but you are getting zero. Which actually makes
sense.

I think you are just getting confused by big endianness of s390x, and
there is nothing wrong with bpf_probe_read_kernel().

In both of your tests (I pasted your code below, it would be better if
you did it in your initial emails) you end up with 0x200 in *upper* 32
bits (on big endian) and lower bits are zeros. And __retval thing is
32-bit (despite BPF program returning long), so this return value is
truncated to *lower* 32-bits, which are, expectedly, zeroes.

So I think everything works as expected, but your tests (at least)
don't handle the big-endian arch well.

__description("probe read 4 bytes")
__success __retval(0x200)
long probe_read_4(void)
{
    int data =3D 0x200;
    long data_dst =3D 0;
    int err;

    err =3D bpf_probe_read_kernel(&data_dst, 4, &data);
    if (err)
        return err;

    return data_dst;
}

SEC("syscall")
__description("probe read 8 bytes")
__success __retval(0x200)
long probe_read_8(void)
{
    int data =3D 0x200;
    long data_dst =3D 0;
    int err;

    err =3D bpf_probe_read_kernel(&data_dst, 8, &data);
    if (err)
        return err;

    return data_dst;

}

> more details in the following link:
> https://github.com/kernel-patches/bpf/pull/6882. It appears that
> bpf_probe_read_kernel() encounters difficulties when dealing with
> non-long-aligned source addresses.
>
> >
> > So getting back to iter implementation. Make sure you are
> > zero-initializing that u64 value you are reading into?
> >
>
> It has been zero-initialized:
>
> + kit->nr_bits =3D 0;
> + kit->bits_copy =3D 0;
>

ok, then the problem is somewhere else, but it doesn't seem to be in
bpf_probe_read_kernel(). I'm forgetting what was the original test
failure for your patch set, but please double check again, taking into
account the big endianness of s390x.

> --
> Regards
> Yafang

