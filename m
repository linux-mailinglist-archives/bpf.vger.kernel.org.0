Return-Path: <bpf+bounces-28042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396AB8B4C08
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 15:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3641C20EB9
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8DE6D1C1;
	Sun, 28 Apr 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5gmsV61"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A76BFB8
	for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714312072; cv=none; b=ovdL61BKll0SsmAm2en2I+brG8VQ+BayN1JQ9IUs3Q/5mqnGVlKcrKmBfUF8U1EZmSwyzAsCddeNnonFzK5geSd9NPe4gXzudznUAKUcm0ZNQmao4nuvFKZmoHyZwytrNLV+b55kJ9iYHUeZ5QkpYGSQG4D6O8hJdKMR/fRlU34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714312072; c=relaxed/simple;
	bh=bU4+I/eFdS1jIyrsQE2mqkAxH1L4Satcme182lXSyFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsVk4Rfze0yoOkque1yhgfBePuUVmmY16TXatunYVBGd8yo5HB9ptE4D5HTjXqN7LLhp5C/s/kkN7FY9KEXydRdwKH06z6voWRmQ26t0vG0b5yEzzXTiXCMAmsiGlwlm1gCNqWAheWd5/YOBDKWoxKvL1VewmVbRaIknQM6pO0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5gmsV61; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6a06b12027cso43089296d6.0
        for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714312069; x=1714916869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pf/HGfSdQeM6WuZVJk21HlwzQqGln6MV1mh+8KUlFs=;
        b=K5gmsV61iC3Mpe7HYkL0jtfEnzSFox6Lln7wwq6WXe/uYNiQRFQMBsAoWIpk/+20/l
         YJr300AxPz4DvB1eVzUJ/NOu2b2XgIf9mDXC5xEcC4tTYKgilTtG+KqALINiiG5T3ql/
         klC88SxdkQa9SfgW1qNCBS52tDfoG9ibmOZrvnK6MU/gyJ+zrFGzkGYvdEZ6kSEsRhOC
         r9DUDCAnWmx5t35yBO+Jl/yEwixvi25YkVTQwnBYGEosa3Lk3C78kI7amGQ6P70FB5fc
         SKIIhLqfxr0oOhPI6hj1CvkQSzhPY5lz4QS4Vns2hipYF4g8TSxxIfyH39sKjpSA6pNS
         64lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714312069; x=1714916869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pf/HGfSdQeM6WuZVJk21HlwzQqGln6MV1mh+8KUlFs=;
        b=XnYqxrWnSyU5T5aNfibn7c2LHtCq53kAQcoSXYAz35UVJbz4KuFZCdYoR+mlPGa11a
         XBKPC1+l2J+8iGGFDu6MkBRn776RpiPq2wbxIlMQx9GgkAZiAW2CXU9loRUyseCxwLlk
         beVrXZ1/QkuZHfk0yyfXAozhkTEiXVWivtNO8vJv4vHpZKeShamH+SAux7kmcD2u76Pu
         Xca2dumM9+QFidbY+YCaAuvGIVCmGfvtVEhMpT8CJAZWZxqKt2N1CWWAdYDjOhUryQ8e
         +Sr/8HrOlkMxa2m9779GRaF3KXKAI6qGAfzXhug2tMKlGuuq+ohXT0HJmOLh/3xIVTbq
         ur8w==
X-Forwarded-Encrypted: i=1; AJvYcCUQ0h1bE2nelnrzi7UG1wvAfJ6Hd5ac5T4pAaM9+HjwogMYXqfYxDdY03SRKyHqrrjZLgBgQAR99pNVYv4L+Ph6k0ll
X-Gm-Message-State: AOJu0YwPJ8A76fRujow2NHfbiKyh0qeQKiSPK7tyEYfKxgHxfuSfAjXM
	YXvWlkPtkV0B9+bHdlruYansUbq5D0OQzBIhORbhOz8fa1wRozgEKJ7lrdIfH9ukF9i3iCW492y
	p+cCQwPUHRRXRPyYPClQmIYwxass=
X-Google-Smtp-Source: AGHT+IHYlBV23PW3Z/lnThO/598p95pPXzo9WTayT2uJtYgSNsOLvyRVGL5QcZjkq3ny4xAP9yAOhOwmkkJkX2QExdU=
X-Received: by 2002:a05:6214:248b:b0:6a0:ce01:e9d with SMTP id
 gi11-20020a056214248b00b006a0ce010e9dmr1199547qvb.30.1714312069077; Sun, 28
 Apr 2024 06:47:49 -0700 (PDT)
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
 <CALOAHbDQEaSncsAAt7_JGU_nXWBjp=4o-zgXxiy0kSZPg93cgQ@mail.gmail.com> <CAEf4BzZbWTM-NtpEHM-c8z01YQrTCJX9VuWBViR1K5Fo-1Tt5A@mail.gmail.com>
In-Reply-To: <CAEf4BzZbWTM-NtpEHM-c8z01YQrTCJX9VuWBViR1K5Fo-1Tt5A@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 28 Apr 2024 21:47:12 +0800
Message-ID: <CALOAHbC8k6B4mbp-7YPQ9Q8QP+HAKt6oexZm9vdUVe6+Z8shHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Add a generic bits iterator
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 12:51=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 25, 2024 at 10:05=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > On Fri, Apr 26, 2024 at 2:15=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Apr 24, 2024 at 10:37=E2=80=AFPM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> > > >
> > > > On Thu, Apr 25, 2024 at 8:34=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Thu, Apr 11, 2024 at 6:51=E2=80=AFAM Yafang Shao <laoar.shao@g=
mail.com> wrote:
> > > > > >
> > > > > > On Thu, Apr 11, 2024 at 9:11=E2=80=AFPM Yafang Shao <laoar.shao=
@gmail.com> wrote:
> > > > > > >
> > > > > > > Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, ha=
ve been
> > > > > > > added for the new bpf_iter_bits functionality. These kfuncs e=
nable the
> > > > > > > iteration of the bits from a given address and a given number=
 of bits.
> > > > > > >
> > > > > > > - bpf_iter_bits_new
> > > > > > >   Initialize a new bits iterator for a given memory area. Due=
 to the
> > > > > > >   limitation of bpf memalloc, the max number of bits to be it=
erated
> > > > > > >   over is (4096 * 8).
> > > > > > > - bpf_iter_bits_next
> > > > > > >   Get the next bit in a bpf_iter_bits
> > > > > > > - bpf_iter_bits_destroy
> > > > > > >   Destroy a bpf_iter_bits
> > > > > > >
> > > > > > > The bits iterator can be used in any context and on any addre=
ss.
> > > > > > >
> > > > > > > Changes:
> > > > > > > - v5->v6:
> > > > > > >   - Add positive tests (Andrii)
> > > > > > > - v4->v5:
> > > > > > >   - Simplify test cases (Andrii)
> > > > > > > - v3->v4:
> > > > > > >   - Fix endianness error on s390x (Andrii)
> > > > > > >   - zero-initialize kit->bits_copy and zero out nr_bits (Andr=
ii)
> > > > > > > - v2->v3:
> > > > > > >   - Optimization for u64/u32 mask (Andrii)
> > > > > > > - v1->v2:
> > > > > > >   - Simplify the CPU number verification code to avoid the fa=
ilure on s390x
> > > > > > >     (Eduard)
> > > > > > > - bpf: Add bpf_iter_cpumask
> > > > > > >   https://lwn.net/Articles/961104/
> > > > > > > - bpf: Add new bpf helper bpf_for_each_cpu
> > > > > > >   https://lwn.net/Articles/939939/
> > > > > > >
> > > > > > > Yafang Shao (2):
> > > > > > >   bpf: Add bits iterator
> > > > > > >   selftests/bpf: Add selftest for bits iter
> > > > > > >
> > > > > > >  kernel/bpf/helpers.c                          | 120 ++++++++=
+++++++++
> > > > > > >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> > > > > > >  .../selftests/bpf/progs/verifier_bits_iter.c  | 127 ++++++++=
++++++++++
> > > > > > >  3 files changed, 249 insertions(+)
> > > > > > >  create mode 100644 tools/testing/selftests/bpf/progs/verifie=
r_bits_iter.c
> > > > > > >
> > > > > > > --
> > > > > > > 2.39.1
> > > > > > >
> > > > > >
> > > > > > It appears that the test case failed on s390x when the data is
> > > > > > a u32 value because we need to set the higher 32 bits.
> > > > > > will analyze it.
> > > > > >
> > > > >
> > > > > Hey Yafang, did you get a chance to debug and fix the issue?
> > > > >
> > > >
> > > > Hi Andrii,
> > > >
> > > > Apologies for the delay; I recently returned from an extended holid=
ay.
> > > >
> > > > The issue stems from the limitations of bpf_probe_read_kernel() on
> > > > s390 architecture. The attachment provides a straightforward exampl=
e
> > > > to illustrate this issue. The observed results are as follows:
> > > >
> > > >     Error: #463/1 verifier_probe_read/probe read 4 bytes
> > > >     8897 run_subtest:PASS:obj_open_mem 0 nsec
> > > >     8898 run_subtest:PASS:unexpected_load_failure 0 nsec
> > > >     8899 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
> > > >     8900 run_subtest:FAIL:659 Unexpected retval: 2817064 !=3D 512
> > > >
> > > >     Error: #463/2 verifier_probe_read/probe read 8 bytes
> > > >     8903 run_subtest:PASS:obj_open_mem 0 nsec
> > > >     8904 run_subtest:PASS:unexpected_load_failure 0 nsec
> > > >     8905 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
> > > >     8906 run_subtest:FAIL:659 Unexpected retval: 0 !=3D 512
> > > >
> > > > More details can be found at:  https://github.com/kernel-patches/bp=
f/pull/6872
> > > >
> > > > Should we consider this behavior of bpf_probe_read_kernel() as
> > > > expected, or is it something that requires fixing?
> > > >
> > >
> > > I might be missing something, but there is nothing wrong with
> > > bpf_probe_read_kernel() behavior. In "read 4" case you are overwritin=
g
> > > only upper 4 bytes of u64, so lower 4 bytes are garbage. In "read 8"
> > > you are reading (upper) 4 bytes of garbage from uninitialized
> > > data_dst.
> >
> > The issue doesn't lie with the dst but rather with the src. Even after
> > initializing the destination, the operation still fails. You can find
>
> Are you sure the operation "fails"? If it would fail, you'd get a
> negative error code, but you are getting zero. Which actually makes
> sense.
>
> I think you are just getting confused by big endianness of s390x, and
> there is nothing wrong with bpf_probe_read_kernel().
>
> In both of your tests (I pasted your code below, it would be better if
> you did it in your initial emails) you end up with 0x200 in *upper* 32
> bits (on big endian) and lower bits are zeros. And __retval thing is
> 32-bit (despite BPF program returning long), so this return value is
> truncated to *lower* 32-bits, which are, expectedly, zeroes.

Thank you for clarifying. The presence of the 32-bit __retval led to
my misunderstanding :(

>
> So I think everything works as expected, but your tests (at least)
> don't handle the big-endian arch well.

The issue arises when the dst and src have different sizes, causing
bpf_probe_read_kernel_common() to handle them poorly on big-endian
machines. To address this, we need to calculate the offset for
copying, as demonstrated by the following

   bpf_probe_read_kernel_common(&kit->bits_copy + offset, size,
unsafe_ptr__ign);

One might wonder why this calculation is not incorporated directly
into the implementation of bpf_probe_read_kernel_common() ?

>
> __description("probe read 4 bytes")
> __success __retval(0x200)
> long probe_read_4(void)
> {
>     int data =3D 0x200;
>     long data_dst =3D 0;
>     int err;
>
>     err =3D bpf_probe_read_kernel(&data_dst, 4, &data);
>     if (err)
>         return err;
>
>     return data_dst;
> }
>
> SEC("syscall")
> __description("probe read 8 bytes")
> __success __retval(0x200)
> long probe_read_8(void)
> {
>     int data =3D 0x200;
>     long data_dst =3D 0;
>     int err;
>
>     err =3D bpf_probe_read_kernel(&data_dst, 8, &data);
>     if (err)
>         return err;
>
>     return data_dst;
>
> }
>
> > more details in the following link:
> > https://github.com/kernel-patches/bpf/pull/6882. It appears that
> > bpf_probe_read_kernel() encounters difficulties when dealing with
> > non-long-aligned source addresses.
> >
> > >
> > > So getting back to iter implementation. Make sure you are
> > > zero-initializing that u64 value you are reading into?
> > >
> >
> > It has been zero-initialized:
> >
> > + kit->nr_bits =3D 0;
> > + kit->bits_copy =3D 0;
> >
>
> ok, then the problem is somewhere else, but it doesn't seem to be in
> bpf_probe_read_kernel(). I'm forgetting what was the original test
> failure for your patch set, but please double check again, taking into
> account the big endianness of s390x.
>

If we aim to make it compatible with s390, we need to introduce some
constraints regarding the bits iteration.

1. We must replace nr_bits with size:

  bpf_iter_bits_new(struct bpf_iter_bits *it, const void
*unsafe_ptr__ign, u32 size)

2. The size must adhere to alignment requirements:

        if (size <=3D sizeof(u64)) {
                int offset =3D IS_ENABLED(CONFIG_S390) ? sizeof(u64) - size=
 : 0;

                switch (size) {
                case 1:
                case 2:
                case 4:
                case 8:
                        break;
                default:
                        return -EINVAL;
                }

                err =3D bpf_probe_read_kernel_common(((char
*)&kit->bits_copy) + offset, size, unsafe_ptr__ign);
                if (err)
                        return -EFAULT;

                kit->size =3D size;
                kit->bit =3D -1;
                return 0;
        }

        /* Not long-aligned */
        if (size & (sizeof(unsigned long) - 1))
                return -EINVAL;

        ....

Does this meet your expectations?

--
Regards



Yafang

