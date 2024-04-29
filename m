Return-Path: <bpf+bounces-28117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82B98B5EF9
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CFC1C20C27
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80B084D1D;
	Mon, 29 Apr 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQSRvQLP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DB4824AA
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408091; cv=none; b=ZhscJdOTLW2A3enCCmYGAatif8ElbxGIml4gEtNFeHGRkKwxLJBQoGt8oT4DELBRh0IpR97Cw/N7o8SLxf87FXi/Aft2xw+qA/SVwhE6L0LaGm3D4eBxpFE/RQWI/QBP8uNKYruZEeKKlrU3upnHIyUZLmgGW2uxnTBmtJlVgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408091; c=relaxed/simple;
	bh=y0JI5OSepdfc1mkADxz6xPVZrhKn2kYmOwx3Ng5ZEiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=el3/xMyXztpw1nIixHL8Qq71Wtrs6+buvvr60tDQnN+z8IOnVb63uclQa2/jNb4HabLN3vZOEYkQKpHcjy/TgAMT6bOaaS+Kzf/M37H6wYwUbV/8KZM2i8n9a2Y73zSvYk9yf1DpQiTU8gLj8Ut5t4YlefunS3oqohPZmzizO+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQSRvQLP; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d8b519e438so3581829a12.1
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714408089; x=1715012889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pp2B+hoEmrhn7yboH9rR40/PmucoPR8tdJKUVoFRxbA=;
        b=FQSRvQLPqa/5vjV0a+vCQ7w754YHt9Gx1TwBAyaghXx3C3Sc7kiOfOF23lxGGjFr+X
         qDgHxtYHz3YuLEML52RQnlZPL7UNsWOdLTG62PLk0U2u00c6WftBX0HTVjKNcRZsOmiU
         QAAaPVjkZyxraD0ubGcUA/THVweqpYopYiIQ4nwkZh1K8X37BdDIuzq+GG1GT98rCe3w
         xu2lM5OFb8sujffL8EpF5c4VtPMlSqbVbeSL8iNbuqE4RvpF7UoILH5pnKYFU4MowOMa
         cXpxILyrkjn1GdiSWKlC/ni7ctMW4QlH18cgA1A6EkAC1zQ1a9sohN95ag0q38Q4AXhr
         +4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714408089; x=1715012889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pp2B+hoEmrhn7yboH9rR40/PmucoPR8tdJKUVoFRxbA=;
        b=qDEE3ZjuDIIemsfyWgbI0khDQfQBlCDin4r3Idk4g/R/TC/W1s5y5Suu/8jxdE7mGF
         PLf2Q3XK7PylNQ7fGIkBkxM2l27y/7Cx+RfZFW7d3FHmYk6uNJ6ywmSL9w3o2uoh0QeX
         eYKahL6J3RN6/fxClRdL7macyX87yqkVBJiYiu6aX6gAOZNviJ2JZ5cMM4roWADUBEjT
         LsqKFR2q+Dg2u3p0ksJ5V1ITw0nieyqPTpnqoMTGzShX5h51Qdnntesocam00udcMhap
         53x6qCM1Qo42BxhrV5nvp7MsWeCRanbSS0mVa9oXXrZ4MsrVAwxtYZisEcFOc78UglP4
         av0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtf6V/KW69i1O9gd6d9ENu5EkFjNMiCBBcMTyQGg8bFP+hsmBDo0MZyv6ngwfdf5MaPlFg51MWUfZxeZ9Xu2JyzyO1
X-Gm-Message-State: AOJu0YxSxIREfVTAYF7Iy1trhXD2PkDkJ3DzFOjOAP/ugg6QJ943Psb9
	H5XNlSjPUeBNzXNiVJ+5MvwoMm/1fhJmkpLWqPpZ7ws5Bq6TbBN1xG9zpJ6y/ZnHCJ0K231ID/Y
	GYjE8rPGhLBYoT0nFZS/x2ow42NFK7w==
X-Google-Smtp-Source: AGHT+IFqrNpcqjgEDaF4B4Qwv/e+7H9q9dWHgkv2Ag5tun5JFA5LDZ+ifLGJ3BTog87xnA9jrXT8bIEZRFsjx/OZrA0=
X-Received: by 2002:a17:90b:19d0:b0:2af:ff3:e14a with SMTP id
 nm16-20020a17090b19d000b002af0ff3e14amr96504pjb.16.1714408088206; Mon, 29 Apr
 2024 09:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411131127.73098-1-laoar.shao@gmail.com> <CALOAHbCBxGbLH0+1fSTQtt3K8yXX9oG4utkiHn=+dxpKZ+64cw@mail.gmail.com>
 <CAEf4BzbynKkK_sct2WdTrF2F+RJ1tD3F6nYAew+Gq82qokgQGA@mail.gmail.com>
 <CALOAHbBBDwxBGOrDWqGf2b8bRRii8DnBHCU9cAbp_Sw-Q6XKBA@mail.gmail.com>
 <CAEf4BzZDUQextxUZGVDsctUhM718nvq+XX=HQSbUVaRkxXi3Tg@mail.gmail.com>
 <CALOAHbDQEaSncsAAt7_JGU_nXWBjp=4o-zgXxiy0kSZPg93cgQ@mail.gmail.com>
 <CAEf4BzZbWTM-NtpEHM-c8z01YQrTCJX9VuWBViR1K5Fo-1Tt5A@mail.gmail.com> <CALOAHbC8k6B4mbp-7YPQ9Q8QP+HAKt6oexZm9vdUVe6+Z8shHA@mail.gmail.com>
In-Reply-To: <CALOAHbC8k6B4mbp-7YPQ9Q8QP+HAKt6oexZm9vdUVe6+Z8shHA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 09:27:55 -0700
Message-ID: <CAEf4BzYUKyCun15SN3YAiJJkaK0409sXWNLzdAnuQFOqo3Rowg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Add a generic bits iterator
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 6:47=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Sat, Apr 27, 2024 at 12:51=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Apr 25, 2024 at 10:05=E2=80=AFPM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > >
> > > On Fri, Apr 26, 2024 at 2:15=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Apr 24, 2024 at 10:37=E2=80=AFPM Yafang Shao <laoar.shao@gm=
ail.com> wrote:
> > > > >
> > > > > On Thu, Apr 25, 2024 at 8:34=E2=80=AFAM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Apr 11, 2024 at 6:51=E2=80=AFAM Yafang Shao <laoar.shao=
@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Apr 11, 2024 at 9:11=E2=80=AFPM Yafang Shao <laoar.sh=
ao@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, =
have been
> > > > > > > > added for the new bpf_iter_bits functionality. These kfuncs=
 enable the
> > > > > > > > iteration of the bits from a given address and a given numb=
er of bits.
> > > > > > > >
> > > > > > > > - bpf_iter_bits_new
> > > > > > > >   Initialize a new bits iterator for a given memory area. D=
ue to the
> > > > > > > >   limitation of bpf memalloc, the max number of bits to be =
iterated
> > > > > > > >   over is (4096 * 8).
> > > > > > > > - bpf_iter_bits_next
> > > > > > > >   Get the next bit in a bpf_iter_bits
> > > > > > > > - bpf_iter_bits_destroy
> > > > > > > >   Destroy a bpf_iter_bits
> > > > > > > >
> > > > > > > > The bits iterator can be used in any context and on any add=
ress.
> > > > > > > >
> > > > > > > > Changes:
> > > > > > > > - v5->v6:
> > > > > > > >   - Add positive tests (Andrii)
> > > > > > > > - v4->v5:
> > > > > > > >   - Simplify test cases (Andrii)
> > > > > > > > - v3->v4:
> > > > > > > >   - Fix endianness error on s390x (Andrii)
> > > > > > > >   - zero-initialize kit->bits_copy and zero out nr_bits (An=
drii)
> > > > > > > > - v2->v3:
> > > > > > > >   - Optimization for u64/u32 mask (Andrii)
> > > > > > > > - v1->v2:
> > > > > > > >   - Simplify the CPU number verification code to avoid the =
failure on s390x
> > > > > > > >     (Eduard)
> > > > > > > > - bpf: Add bpf_iter_cpumask
> > > > > > > >   https://lwn.net/Articles/961104/
> > > > > > > > - bpf: Add new bpf helper bpf_for_each_cpu
> > > > > > > >   https://lwn.net/Articles/939939/
> > > > > > > >
> > > > > > > > Yafang Shao (2):
> > > > > > > >   bpf: Add bits iterator
> > > > > > > >   selftests/bpf: Add selftest for bits iter
> > > > > > > >
> > > > > > > >  kernel/bpf/helpers.c                          | 120 ++++++=
+++++++++++
> > > > > > > >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> > > > > > > >  .../selftests/bpf/progs/verifier_bits_iter.c  | 127 ++++++=
++++++++++++
> > > > > > > >  3 files changed, 249 insertions(+)
> > > > > > > >  create mode 100644 tools/testing/selftests/bpf/progs/verif=
ier_bits_iter.c
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.39.1
> > > > > > > >
> > > > > > >
> > > > > > > It appears that the test case failed on s390x when the data i=
s
> > > > > > > a u32 value because we need to set the higher 32 bits.
> > > > > > > will analyze it.
> > > > > > >
> > > > > >
> > > > > > Hey Yafang, did you get a chance to debug and fix the issue?
> > > > > >
> > > > >
> > > > > Hi Andrii,
> > > > >
> > > > > Apologies for the delay; I recently returned from an extended hol=
iday.
> > > > >
> > > > > The issue stems from the limitations of bpf_probe_read_kernel() o=
n
> > > > > s390 architecture. The attachment provides a straightforward exam=
ple
> > > > > to illustrate this issue. The observed results are as follows:
> > > > >
> > > > >     Error: #463/1 verifier_probe_read/probe read 4 bytes
> > > > >     8897 run_subtest:PASS:obj_open_mem 0 nsec
> > > > >     8898 run_subtest:PASS:unexpected_load_failure 0 nsec
> > > > >     8899 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
> > > > >     8900 run_subtest:FAIL:659 Unexpected retval: 2817064 !=3D 512
> > > > >
> > > > >     Error: #463/2 verifier_probe_read/probe read 8 bytes
> > > > >     8903 run_subtest:PASS:obj_open_mem 0 nsec
> > > > >     8904 run_subtest:PASS:unexpected_load_failure 0 nsec
> > > > >     8905 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
> > > > >     8906 run_subtest:FAIL:659 Unexpected retval: 0 !=3D 512
> > > > >
> > > > > More details can be found at:  https://github.com/kernel-patches/=
bpf/pull/6872
> > > > >
> > > > > Should we consider this behavior of bpf_probe_read_kernel() as
> > > > > expected, or is it something that requires fixing?
> > > > >
> > > >
> > > > I might be missing something, but there is nothing wrong with
> > > > bpf_probe_read_kernel() behavior. In "read 4" case you are overwrit=
ing
> > > > only upper 4 bytes of u64, so lower 4 bytes are garbage. In "read 8=
"
> > > > you are reading (upper) 4 bytes of garbage from uninitialized
> > > > data_dst.
> > >
> > > The issue doesn't lie with the dst but rather with the src. Even afte=
r
> > > initializing the destination, the operation still fails. You can find
> >
> > Are you sure the operation "fails"? If it would fail, you'd get a
> > negative error code, but you are getting zero. Which actually makes
> > sense.
> >
> > I think you are just getting confused by big endianness of s390x, and
> > there is nothing wrong with bpf_probe_read_kernel().
> >
> > In both of your tests (I pasted your code below, it would be better if
> > you did it in your initial emails) you end up with 0x200 in *upper* 32
> > bits (on big endian) and lower bits are zeros. And __retval thing is
> > 32-bit (despite BPF program returning long), so this return value is
> > truncated to *lower* 32-bits, which are, expectedly, zeroes.
>
> Thank you for clarifying. The presence of the 32-bit __retval led to
> my misunderstanding :(
>
> >
> > So I think everything works as expected, but your tests (at least)
> > don't handle the big-endian arch well.
>
> The issue arises when the dst and src have different sizes, causing
> bpf_probe_read_kernel_common() to handle them poorly on big-endian
> machines. To address this, we need to calculate the offset for
> copying, as demonstrated by the following
>
>    bpf_probe_read_kernel_common(&kit->bits_copy + offset, size,
> unsafe_ptr__ign);
>
> One might wonder why this calculation is not incorporated directly
> into the implementation of bpf_probe_read_kernel_common() ?

Let's stop talking about
bpf_probe_read_kernel/bpf_probe_read_kernel_common doing anything
wrong or not handling anything wrong. It's not, it's correct. Your
code is *using* it wrong, and that's what we'll have to fix. The
contract of bpf_probe_read_kernel is in terms of memory addresses of
source/destination *bytes* and the *common* size of both source and
destination. bpf_probe_read_kernel() cannot know that you are passing
a pointer to int or long or whatever, it's just a void * pointer. So
if you are writing bytes over long, you need to take care of adjusting
offsets to accommodate big-endian.

It's a distraction to talk about bpf_probe_read_kernel() here (but
it's useful to understand its contract).

>
> >
> > __description("probe read 4 bytes")
> > __success __retval(0x200)
> > long probe_read_4(void)
> > {
> >     int data =3D 0x200;
> >     long data_dst =3D 0;
> >     int err;
> >
> >     err =3D bpf_probe_read_kernel(&data_dst, 4, &data);
> >     if (err)
> >         return err;
> >
> >     return data_dst;
> > }
> >
> > SEC("syscall")
> > __description("probe read 8 bytes")
> > __success __retval(0x200)
> > long probe_read_8(void)
> > {
> >     int data =3D 0x200;
> >     long data_dst =3D 0;
> >     int err;
> >
> >     err =3D bpf_probe_read_kernel(&data_dst, 8, &data);
> >     if (err)
> >         return err;
> >
> >     return data_dst;
> >
> > }
> >
> > > more details in the following link:
> > > https://github.com/kernel-patches/bpf/pull/6882. It appears that
> > > bpf_probe_read_kernel() encounters difficulties when dealing with
> > > non-long-aligned source addresses.
> > >
> > > >
> > > > So getting back to iter implementation. Make sure you are
> > > > zero-initializing that u64 value you are reading into?
> > > >
> > >
> > > It has been zero-initialized:
> > >
> > > + kit->nr_bits =3D 0;
> > > + kit->bits_copy =3D 0;
> > >
> >
> > ok, then the problem is somewhere else, but it doesn't seem to be in
> > bpf_probe_read_kernel(). I'm forgetting what was the original test
> > failure for your patch set, but please double check again, taking into
> > account the big endianness of s390x.
> >
>
> If we aim to make it compatible with s390, we need to introduce some
> constraints regarding the bits iteration.
>
> 1. We must replace nr_bits with size:
>
>   bpf_iter_bits_new(struct bpf_iter_bits *it, const void
> *unsafe_ptr__ign, u32 size)
>
> 2. The size must adhere to alignment requirements:
>
>         if (size <=3D sizeof(u64)) {
>                 int offset =3D IS_ENABLED(CONFIG_S390) ? sizeof(u64) - si=
ze : 0;
>
>                 switch (size) {
>                 case 1:
>                 case 2:
>                 case 4:
>                 case 8:
>                         break;
>                 default:
>                         return -EINVAL;
>                 }
>
>                 err =3D bpf_probe_read_kernel_common(((char
> *)&kit->bits_copy) + offset, size, unsafe_ptr__ign);
>                 if (err)
>                         return -EFAULT;
>
>                 kit->size =3D size;
>                 kit->bit =3D -1;
>                 return 0;
>         }
>
>         /* Not long-aligned */
>         if (size & (sizeof(unsigned long) - 1))
>                 return -EINVAL;
>
>         ....
>
> Does this meet your expectations?
>

I don't think you need to add any restrictions or change anything to
be byte-sized. You just need to calculate byte offset and do a bit
shift to place N bits from the mask into upper N bits of long on
big-endian. You might need to do some masking even for little endian
as well.

Which is why I suggested investing in simple but thorough tests. Write
down a few bit mask patterns of variable length (not just
multiple-of-8 sizes) and think about the sequence of bits that should
be returned. And then codify that.

Then check that both little- and big-endian arches work correctly.

This is all a bit tricky because kernel's find_next_bit() makes the
assumption that bit masks are long-based, while this bits iterator
protocol is based on bit sizes, which are not necessarily multiples of
8 bits. So after you copy memory as bytes, you might need to clear
(and shift, for big endian) some bits. Use simple but non-symmetrical
bit masks to test everything.

> --
> Regards
>
>
>
> Yafang

