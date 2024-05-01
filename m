Return-Path: <bpf+bounces-28314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760678B8439
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 04:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3F31C225DF
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 02:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD1210940;
	Wed,  1 May 2024 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ujl59Stm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1CEAF1
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714529563; cv=none; b=RCVsjXpRJWugjxIIy60N9zkI407Zc3dLmB0+Cqbm2wwi/HLFHr+a5VPPgqbaq4+Km5VtZIAwFAqO6S1/FBdwBhjofDKm+9S9nAK58+85V5bLnWpAqXGgUpzBf6rFg9kgc5fBEW10aBg9CzCRd1w7cBXD9KV4IZntchJX4WHh1eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714529563; c=relaxed/simple;
	bh=ptuagniy3XByTjwVvrXPY6TeW8skvuKOV5dNPD0OMYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmhxLD1vVJZPIsaWn81rvFkrXr0TZGHeXdDhrH2l378hKyuQUyKXiIatKzbsKGtS1CXGdrUQhI06ggoQwOFQHGlhA40tWRB2/WBFkNka75eqfoPhWSTSwLFNwX9lybH86KBeDqW3YhZLIhEknMr8EMNr2xlh/dsnH/BzM/rYrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ujl59Stm; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4375ddb9eaeso39381321cf.3
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 19:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714529560; x=1715134360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txHT81/3bwLqERD6FJ01ZUQhnEvQrw7qjaBFlUjalyM=;
        b=Ujl59StmQuBizSfhCrePJQegKcCkfKUWGSryjMocLWk7l+hmc8hOBUyCIpUvKf3Ov9
         4oFR9zPD54VFqthb/VzH8OPVVLvUOQeHe6zEKAXhesBHWqUym9uu/yVK9jICo7SjEeFH
         k49RR52H9kyQK28TZAr5DOL//2PhhBzKahGg9OvbYvmgTNTGzsNNxnjtRL1aY25Tr27t
         yid/ZVLhhyfGKt5/SDX42Gp1e+Mkx2YD6igdgzLLfR52F6OlU5NjfbL9av/31ssv5Fhz
         15rvOhTyuRXmH0k8N9QuXHobkF8d6X4fvE/nJunI8XhnloqyEFJv/AGkws+2ybl/3tjJ
         wz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714529560; x=1715134360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txHT81/3bwLqERD6FJ01ZUQhnEvQrw7qjaBFlUjalyM=;
        b=bNCBk/tx1d9JpEY3O2dPeuZvqvS3VFsAuiQWYJkBAn5Z0hpY0y2/ECTwMMy0AuXI4s
         KrSPhwN7bLXQq6DaAHU74nLhugYKY7xAgbU5wZI7tfWzZCdHAob+tlcouaOfxKMHQE+J
         mOC3yy3vtqINcRnn4AUUqd23tqQQ3M10ZG2ifDNPLUJeHqNQgDS9/LPLIzua273POYUl
         T74B8x49KGr6ZBu0tm69kbcy9mCnxByI6tLj5lVGoOl5hfJKabaek4cFfqVHFhsX7uHX
         TP1LKbaNdKJWSwwzJZsIIzPZnvG28j+Ew7IG6CbJQqeK93HKbGJqd1haYgh6KfZ16MxE
         DCKA==
X-Forwarded-Encrypted: i=1; AJvYcCVVyanVxNwuFOkOH+KD276K85gz2XwNmTNDLRTnG7yTktrRlpb/ybxqgnsJ9DjRv7bBBqXkANtgzIwoZGIUdIQ3w0iM
X-Gm-Message-State: AOJu0Yx94O6T+M2Yisa9sQ9wPqbgZePXwAIYC7TX1y8SbMkMRghLFrXi
	eKt2qUBIxrvj0Sr9rRpf2H0EKhIA9f9obmCeiDQJl9mf2uBQPfyWWH7IVTVk59AWn1OE2FicIkZ
	Q/jotYlOpsMok7Zx0PhIpJT9aWcs=
X-Google-Smtp-Source: AGHT+IESsIBOaKlMODLKwhRXEyKWr5kemDNWRaDzai+DIDLof/RjKmOTwVRpsIfAn7hDPiBkJFxbdfo+Oh2Tw3h8iHs=
X-Received: by 2002:a05:6214:20a5:b0:6a0:aa2d:eac1 with SMTP id
 5-20020a05621420a500b006a0aa2deac1mr1112533qvd.52.1714529560387; Tue, 30 Apr
 2024 19:12:40 -0700 (PDT)
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
 <CAEf4BzZbWTM-NtpEHM-c8z01YQrTCJX9VuWBViR1K5Fo-1Tt5A@mail.gmail.com>
 <CALOAHbC8k6B4mbp-7YPQ9Q8QP+HAKt6oexZm9vdUVe6+Z8shHA@mail.gmail.com> <CAEf4BzYUKyCun15SN3YAiJJkaK0409sXWNLzdAnuQFOqo3Rowg@mail.gmail.com>
In-Reply-To: <CAEf4BzYUKyCun15SN3YAiJJkaK0409sXWNLzdAnuQFOqo3Rowg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 1 May 2024 10:12:03 +0800
Message-ID: <CALOAHbCtj8bD5d7_2CAv7Km38StVEd8zdZRA20h-F9LpTVSfMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Add a generic bits iterator
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:28=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Apr 28, 2024 at 6:47=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Sat, Apr 27, 2024 at 12:51=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Apr 25, 2024 at 10:05=E2=80=AFPM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> > > >
> > > > On Fri, Apr 26, 2024 at 2:15=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Wed, Apr 24, 2024 at 10:37=E2=80=AFPM Yafang Shao <laoar.shao@=
gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Apr 25, 2024 at 8:34=E2=80=AFAM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Apr 11, 2024 at 6:51=E2=80=AFAM Yafang Shao <laoar.sh=
ao@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Apr 11, 2024 at 9:11=E2=80=AFPM Yafang Shao <laoar.=
shao@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}=
, have been
> > > > > > > > > added for the new bpf_iter_bits functionality. These kfun=
cs enable the
> > > > > > > > > iteration of the bits from a given address and a given nu=
mber of bits.
> > > > > > > > >
> > > > > > > > > - bpf_iter_bits_new
> > > > > > > > >   Initialize a new bits iterator for a given memory area.=
 Due to the
> > > > > > > > >   limitation of bpf memalloc, the max number of bits to b=
e iterated
> > > > > > > > >   over is (4096 * 8).
> > > > > > > > > - bpf_iter_bits_next
> > > > > > > > >   Get the next bit in a bpf_iter_bits
> > > > > > > > > - bpf_iter_bits_destroy
> > > > > > > > >   Destroy a bpf_iter_bits
> > > > > > > > >
> > > > > > > > > The bits iterator can be used in any context and on any a=
ddress.
> > > > > > > > >
> > > > > > > > > Changes:
> > > > > > > > > - v5->v6:
> > > > > > > > >   - Add positive tests (Andrii)
> > > > > > > > > - v4->v5:
> > > > > > > > >   - Simplify test cases (Andrii)
> > > > > > > > > - v3->v4:
> > > > > > > > >   - Fix endianness error on s390x (Andrii)
> > > > > > > > >   - zero-initialize kit->bits_copy and zero out nr_bits (=
Andrii)
> > > > > > > > > - v2->v3:
> > > > > > > > >   - Optimization for u64/u32 mask (Andrii)
> > > > > > > > > - v1->v2:
> > > > > > > > >   - Simplify the CPU number verification code to avoid th=
e failure on s390x
> > > > > > > > >     (Eduard)
> > > > > > > > > - bpf: Add bpf_iter_cpumask
> > > > > > > > >   https://lwn.net/Articles/961104/
> > > > > > > > > - bpf: Add new bpf helper bpf_for_each_cpu
> > > > > > > > >   https://lwn.net/Articles/939939/
> > > > > > > > >
> > > > > > > > > Yafang Shao (2):
> > > > > > > > >   bpf: Add bits iterator
> > > > > > > > >   selftests/bpf: Add selftest for bits iter
> > > > > > > > >
> > > > > > > > >  kernel/bpf/helpers.c                          | 120 ++++=
+++++++++++++
> > > > > > > > >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> > > > > > > > >  .../selftests/bpf/progs/verifier_bits_iter.c  | 127 ++++=
++++++++++++++
> > > > > > > > >  3 files changed, 249 insertions(+)
> > > > > > > > >  create mode 100644 tools/testing/selftests/bpf/progs/ver=
ifier_bits_iter.c
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.39.1
> > > > > > > > >
> > > > > > > >
> > > > > > > > It appears that the test case failed on s390x when the data=
 is
> > > > > > > > a u32 value because we need to set the higher 32 bits.
> > > > > > > > will analyze it.
> > > > > > > >
> > > > > > >
> > > > > > > Hey Yafang, did you get a chance to debug and fix the issue?
> > > > > > >
> > > > > >
> > > > > > Hi Andrii,
> > > > > >
> > > > > > Apologies for the delay; I recently returned from an extended h=
oliday.
> > > > > >
> > > > > > The issue stems from the limitations of bpf_probe_read_kernel()=
 on
> > > > > > s390 architecture. The attachment provides a straightforward ex=
ample
> > > > > > to illustrate this issue. The observed results are as follows:
> > > > > >
> > > > > >     Error: #463/1 verifier_probe_read/probe read 4 bytes
> > > > > >     8897 run_subtest:PASS:obj_open_mem 0 nsec
> > > > > >     8898 run_subtest:PASS:unexpected_load_failure 0 nsec
> > > > > >     8899 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
> > > > > >     8900 run_subtest:FAIL:659 Unexpected retval: 2817064 !=3D 5=
12
> > > > > >
> > > > > >     Error: #463/2 verifier_probe_read/probe read 8 bytes
> > > > > >     8903 run_subtest:PASS:obj_open_mem 0 nsec
> > > > > >     8904 run_subtest:PASS:unexpected_load_failure 0 nsec
> > > > > >     8905 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
> > > > > >     8906 run_subtest:FAIL:659 Unexpected retval: 0 !=3D 512
> > > > > >
> > > > > > More details can be found at:  https://github.com/kernel-patche=
s/bpf/pull/6872
> > > > > >
> > > > > > Should we consider this behavior of bpf_probe_read_kernel() as
> > > > > > expected, or is it something that requires fixing?
> > > > > >
> > > > >
> > > > > I might be missing something, but there is nothing wrong with
> > > > > bpf_probe_read_kernel() behavior. In "read 4" case you are overwr=
iting
> > > > > only upper 4 bytes of u64, so lower 4 bytes are garbage. In "read=
 8"
> > > > > you are reading (upper) 4 bytes of garbage from uninitialized
> > > > > data_dst.
> > > >
> > > > The issue doesn't lie with the dst but rather with the src. Even af=
ter
> > > > initializing the destination, the operation still fails. You can fi=
nd
> > >
> > > Are you sure the operation "fails"? If it would fail, you'd get a
> > > negative error code, but you are getting zero. Which actually makes
> > > sense.
> > >
> > > I think you are just getting confused by big endianness of s390x, and
> > > there is nothing wrong with bpf_probe_read_kernel().
> > >
> > > In both of your tests (I pasted your code below, it would be better i=
f
> > > you did it in your initial emails) you end up with 0x200 in *upper* 3=
2
> > > bits (on big endian) and lower bits are zeros. And __retval thing is
> > > 32-bit (despite BPF program returning long), so this return value is
> > > truncated to *lower* 32-bits, which are, expectedly, zeroes.
> >
> > Thank you for clarifying. The presence of the 32-bit __retval led to
> > my misunderstanding :(
> >
> > >
> > > So I think everything works as expected, but your tests (at least)
> > > don't handle the big-endian arch well.
> >
> > The issue arises when the dst and src have different sizes, causing
> > bpf_probe_read_kernel_common() to handle them poorly on big-endian
> > machines. To address this, we need to calculate the offset for
> > copying, as demonstrated by the following
> >
> >    bpf_probe_read_kernel_common(&kit->bits_copy + offset, size,
> > unsafe_ptr__ign);
> >
> > One might wonder why this calculation is not incorporated directly
> > into the implementation of bpf_probe_read_kernel_common() ?
>
> Let's stop talking about
> bpf_probe_read_kernel/bpf_probe_read_kernel_common doing anything
> wrong or not handling anything wrong. It's not, it's correct. Your
> code is *using* it wrong, and that's what we'll have to fix. The
> contract of bpf_probe_read_kernel is in terms of memory addresses of
> source/destination *bytes* and the *common* size of both source and
> destination. bpf_probe_read_kernel() cannot know that you are passing
> a pointer to int or long or whatever, it's just a void * pointer. So
> if you are writing bytes over long, you need to take care of adjusting
> offsets to accommodate big-endian.
>
> It's a distraction to talk about bpf_probe_read_kernel() here (but
> it's useful to understand its contract).
>
> >
> > >
> > > __description("probe read 4 bytes")
> > > __success __retval(0x200)
> > > long probe_read_4(void)
> > > {
> > >     int data =3D 0x200;
> > >     long data_dst =3D 0;
> > >     int err;
> > >
> > >     err =3D bpf_probe_read_kernel(&data_dst, 4, &data);
> > >     if (err)
> > >         return err;
> > >
> > >     return data_dst;
> > > }
> > >
> > > SEC("syscall")
> > > __description("probe read 8 bytes")
> > > __success __retval(0x200)
> > > long probe_read_8(void)
> > > {
> > >     int data =3D 0x200;
> > >     long data_dst =3D 0;
> > >     int err;
> > >
> > >     err =3D bpf_probe_read_kernel(&data_dst, 8, &data);
> > >     if (err)
> > >         return err;
> > >
> > >     return data_dst;
> > >
> > > }
> > >
> > > > more details in the following link:
> > > > https://github.com/kernel-patches/bpf/pull/6882. It appears that
> > > > bpf_probe_read_kernel() encounters difficulties when dealing with
> > > > non-long-aligned source addresses.
> > > >
> > > > >
> > > > > So getting back to iter implementation. Make sure you are
> > > > > zero-initializing that u64 value you are reading into?
> > > > >
> > > >
> > > > It has been zero-initialized:
> > > >
> > > > + kit->nr_bits =3D 0;
> > > > + kit->bits_copy =3D 0;
> > > >
> > >
> > > ok, then the problem is somewhere else, but it doesn't seem to be in
> > > bpf_probe_read_kernel(). I'm forgetting what was the original test
> > > failure for your patch set, but please double check again, taking int=
o
> > > account the big endianness of s390x.
> > >
> >
> > If we aim to make it compatible with s390, we need to introduce some
> > constraints regarding the bits iteration.
> >
> > 1. We must replace nr_bits with size:
> >
> >   bpf_iter_bits_new(struct bpf_iter_bits *it, const void
> > *unsafe_ptr__ign, u32 size)
> >
> > 2. The size must adhere to alignment requirements:
> >
> >         if (size <=3D sizeof(u64)) {
> >                 int offset =3D IS_ENABLED(CONFIG_S390) ? sizeof(u64) - =
size : 0;
> >
> >                 switch (size) {
> >                 case 1:
> >                 case 2:
> >                 case 4:
> >                 case 8:
> >                         break;
> >                 default:
> >                         return -EINVAL;
> >                 }
> >
> >                 err =3D bpf_probe_read_kernel_common(((char
> > *)&kit->bits_copy) + offset, size, unsafe_ptr__ign);
> >                 if (err)
> >                         return -EFAULT;
> >
> >                 kit->size =3D size;
> >                 kit->bit =3D -1;
> >                 return 0;
> >         }
> >
> >         /* Not long-aligned */
> >         if (size & (sizeof(unsigned long) - 1))
> >                 return -EINVAL;
> >
> >         ....
> >
> > Does this meet your expectations?
> >
>
> I don't think you need to add any restrictions or change anything to
> be byte-sized. You just need to calculate byte offset and do a bit
> shift to place N bits from the mask into upper N bits of long on
> big-endian. You might need to do some masking even for little endian
> as well.
>
> Which is why I suggested investing in simple but thorough tests. Write
> down a few bit mask patterns of variable length (not just
> multiple-of-8 sizes) and think about the sequence of bits that should
> be returned. And then codify that.
>
> Then check that both little- and big-endian arches work correctly.
>
> This is all a bit tricky because kernel's find_next_bit() makes the
> assumption that bit masks are long-based, while this bits iterator
> protocol is based on bit sizes, which are not necessarily multiples of
> 8 bits. So after you copy memory as bytes, you might need to clear
> (and shift, for big endian) some bits. Use simple but non-symmetrical
> bit masks to test everything.
>

The reason for using 'size' instead of 'nr_bits' lies in the nature of
the pointer 'unsafe_ptr__ign', which is of type void *. Due to this
ambiguity in the type, the 'size' parameter serves to indicate the
size of the data being accessed. For instance, if the type is u32,
then the 'size' parameter corresponds to sizeof(u32)

    u32 src =3D 0x100;
    bpf_for_each(bits, bit, &src, sizeof(u32));

This approach shields the user of the bits iterator from concerns
about endianness, simplifying usage.

Conversely, if we were to use 'nr_bits', the user would need to
account for endianness themselves. In other words, the user would be
responsible for calculating the offset of 'src'.For instance, on a
big-endian machine, if the 'src' is of type u64 and the user only want
to iterate over 32 bits, the code would appear as follows:

    u64 src =3D 0x100;
    bpf_for_each(bits, bit, ((void *)&src) + (sizeof(u64) - (32 + 7) / 8), =
32);

It may indeed be less user-friendly. However, I can make the
adjustment as you suggested, given that it aligns with the pattern
observed in bpf_probe_read_kernel_common().

--
Regards
Yafang

