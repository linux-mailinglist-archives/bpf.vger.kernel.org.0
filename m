Return-Path: <bpf+bounces-28315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632BD8B84C9
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 06:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8097A1C22999
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 04:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD922E822;
	Wed,  1 May 2024 04:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeCQL24Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7162D600
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 04:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536875; cv=none; b=l96DGhDKlnTcYZADiGvq1W6aSWxAdTsChq0IrRAlR/UeXPryAHHo/hJT18d9OLPOsCiV9bR8vmi//mZf2CfwEoRc2U72pwKRYLMKFXGHnPJj3XkfbTKHXY6NWGJQU5LTGSY2Gxtoq4+LXZw6S7nmqwNrwfaSdm73Wl/niuDDJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536875; c=relaxed/simple;
	bh=D7hmHsBvYVX36UmQMq9YHWsAKAToCJ7h4BhMy1r5C4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLgz0vqcOFXiaxT2WABL+bJ2eGUc3fSRmdGDJc9XI6TEt+K/VCp9FHVpX5Gozgiw9zmtUJh+yzM/xjtCMDPkQBU/cQxZ6Bq3Hm69hayJsWk+A0bpRhRw6OexB1qWvNxn2yV3KYETlAw/2XqtYqBLJc6fd9qG9jcEr7Xn5LCH108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeCQL24Q; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so5916083b3a.2
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 21:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536872; x=1715141672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Abo4t0slw3uv1XKbhgvubdN37NHE421BjLzJAkhQYt8=;
        b=KeCQL24QJcM+mCv9ZXUT0GBmEl5PygBjbgNDEVp6MYRLdZKV7hVYB9iDRoWBqJD6Ur
         wIc6A4aDXXhpCbMYWSOtzz+uWqY9770M+XXv7OEoXC2BcO4Lyp9CTlqtZS2e0/s12Hnq
         jGk/BFuwsdEXn46todDeOV23aOWiMyVQnIhYTd5l0EO+CIc+A4kTOp7l3kpIcE/EIaBz
         RHo+pZq7Q3m4knfn4+6YUGt1y4aKOp3fCuIwt86JPa4Yfb+y+if/gB/0GbT4Jkp5fTZH
         BQO0ZHjkkzf3CLAKHC8OvIxgCm8TZvMqkHX+vW4hR91DgQesS7x5PVJi7uDH+4qA49sd
         AOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536872; x=1715141672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Abo4t0slw3uv1XKbhgvubdN37NHE421BjLzJAkhQYt8=;
        b=TKTTFxj04or0L668ox6Cc6mTAWCu4mpWbITnmlK2d5ssaNfGHiIjY5OvGmSwUQy7ld
         HnJuB2YnPpA38N3y2nPtVBxd0j/G6LTkbEMjy04mczLoEWB4989R3bLiNrL5Mhtl7KRK
         zkhs7kp3nl5xpDonX2VcQInww0Ph0mskhF5u28/KnhY7CZKOkoWndzwkEXRVji4k566d
         LcB6M172NZcMc3IHPFyZkU8E9HtEvbWGNJ5cVf4zf9OjcSeW3oEbRQzPBTt+lMbcz3pB
         UpzTt9HdspEhMXDt22Xh0Qe+mK5nbgp2yDPDPv92n8/KKyhg2oTuaS9BK/sppMgAok39
         p/bw==
X-Forwarded-Encrypted: i=1; AJvYcCWvwTTCKwF9uIV39h3MbWwbPUUJDLc8IijSue2h6CjaUJmKkDq6a0e9rl8eLSkBBCbd15MwfecVMJ4MA+o7TxiUZP11
X-Gm-Message-State: AOJu0YygRCfNxugUPEdxEU9JeKvzLxk6A0WNpzz69yNBGWQ+ETMzdo8I
	jadPMnTJIxBi4UmpEroWR1Xu7/6MF7y/HNHpyoQTdy9GZvBWpylzp6gAYdO9oHmlBKas4uM4O4j
	GWEuDkzvjyTS+w4Hrq2WxYpxNeao=
X-Google-Smtp-Source: AGHT+IEIMV9sF7+aH6bNShe1aQ59h9DF9sCdeurm/9y3TpxTv7+WxHRofAjlev0/ATQH7Va+AR6ZY803AJsSrwjSbuY=
X-Received: by 2002:a05:6a20:2584:b0:1a3:ae4a:930 with SMTP id
 k4-20020a056a20258400b001a3ae4a0930mr2071295pzd.33.1714536871480; Tue, 30 Apr
 2024 21:14:31 -0700 (PDT)
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
 <CALOAHbC8k6B4mbp-7YPQ9Q8QP+HAKt6oexZm9vdUVe6+Z8shHA@mail.gmail.com>
 <CAEf4BzYUKyCun15SN3YAiJJkaK0409sXWNLzdAnuQFOqo3Rowg@mail.gmail.com> <CALOAHbCtj8bD5d7_2CAv7Km38StVEd8zdZRA20h-F9LpTVSfMA@mail.gmail.com>
In-Reply-To: <CALOAHbCtj8bD5d7_2CAv7Km38StVEd8zdZRA20h-F9LpTVSfMA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Apr 2024 21:14:19 -0700
Message-ID: <CAEf4BzZiqB4Pk7-YUF3VOZ+=hxwKSxKpdbyPCWBmeZ0LkLzHdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Add a generic bits iterator
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 7:12=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Tue, Apr 30, 2024 at 12:28=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, Apr 28, 2024 at 6:47=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > On Sat, Apr 27, 2024 at 12:51=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Apr 25, 2024 at 10:05=E2=80=AFPM Yafang Shao <laoar.shao@gm=
ail.com> wrote:
> > > > >
> > > > > On Fri, Apr 26, 2024 at 2:15=E2=80=AFAM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 24, 2024 at 10:37=E2=80=AFPM Yafang Shao <laoar.sha=
o@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Apr 25, 2024 at 8:34=E2=80=AFAM Andrii Nakryiko
> > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Apr 11, 2024 at 6:51=E2=80=AFAM Yafang Shao <laoar.=
shao@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Apr 11, 2024 at 9:11=E2=80=AFPM Yafang Shao <laoa=
r.shao@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Three new kfuncs, namely bpf_iter_bits_{new,next,destro=
y}, have been
> > > > > > > > > > added for the new bpf_iter_bits functionality. These kf=
uncs enable the
> > > > > > > > > > iteration of the bits from a given address and a given =
number of bits.
> > > > > > > > > >
> > > > > > > > > > - bpf_iter_bits_new
> > > > > > > > > >   Initialize a new bits iterator for a given memory are=
a. Due to the
> > > > > > > > > >   limitation of bpf memalloc, the max number of bits to=
 be iterated
> > > > > > > > > >   over is (4096 * 8).
> > > > > > > > > > - bpf_iter_bits_next
> > > > > > > > > >   Get the next bit in a bpf_iter_bits
> > > > > > > > > > - bpf_iter_bits_destroy
> > > > > > > > > >   Destroy a bpf_iter_bits
> > > > > > > > > >
> > > > > > > > > > The bits iterator can be used in any context and on any=
 address.
> > > > > > > > > >
> > > > > > > > > > Changes:
> > > > > > > > > > - v5->v6:
> > > > > > > > > >   - Add positive tests (Andrii)
> > > > > > > > > > - v4->v5:
> > > > > > > > > >   - Simplify test cases (Andrii)
> > > > > > > > > > - v3->v4:
> > > > > > > > > >   - Fix endianness error on s390x (Andrii)
> > > > > > > > > >   - zero-initialize kit->bits_copy and zero out nr_bits=
 (Andrii)
> > > > > > > > > > - v2->v3:
> > > > > > > > > >   - Optimization for u64/u32 mask (Andrii)
> > > > > > > > > > - v1->v2:
> > > > > > > > > >   - Simplify the CPU number verification code to avoid =
the failure on s390x
> > > > > > > > > >     (Eduard)
> > > > > > > > > > - bpf: Add bpf_iter_cpumask
> > > > > > > > > >   https://lwn.net/Articles/961104/
> > > > > > > > > > - bpf: Add new bpf helper bpf_for_each_cpu
> > > > > > > > > >   https://lwn.net/Articles/939939/
> > > > > > > > > >
> > > > > > > > > > Yafang Shao (2):
> > > > > > > > > >   bpf: Add bits iterator
> > > > > > > > > >   selftests/bpf: Add selftest for bits iter
> > > > > > > > > >
> > > > > > > > > >  kernel/bpf/helpers.c                          | 120 ++=
+++++++++++++++
> > > > > > > > > >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> > > > > > > > > >  .../selftests/bpf/progs/verifier_bits_iter.c  | 127 ++=
++++++++++++++++
> > > > > > > > > >  3 files changed, 249 insertions(+)
> > > > > > > > > >  create mode 100644 tools/testing/selftests/bpf/progs/v=
erifier_bits_iter.c
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.39.1
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > It appears that the test case failed on s390x when the da=
ta is
> > > > > > > > > a u32 value because we need to set the higher 32 bits.
> > > > > > > > > will analyze it.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Hey Yafang, did you get a chance to debug and fix the issue=
?
> > > > > > > >
> > > > > > >
> > > > > > > Hi Andrii,
> > > > > > >
> > > > > > > Apologies for the delay; I recently returned from an extended=
 holiday.
> > > > > > >
> > > > > > > The issue stems from the limitations of bpf_probe_read_kernel=
() on
> > > > > > > s390 architecture. The attachment provides a straightforward =
example
> > > > > > > to illustrate this issue. The observed results are as follows=
:
> > > > > > >
> > > > > > >     Error: #463/1 verifier_probe_read/probe read 4 bytes
> > > > > > >     8897 run_subtest:PASS:obj_open_mem 0 nsec
> > > > > > >     8898 run_subtest:PASS:unexpected_load_failure 0 nsec
> > > > > > >     8899 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
> > > > > > >     8900 run_subtest:FAIL:659 Unexpected retval: 2817064 !=3D=
 512
> > > > > > >
> > > > > > >     Error: #463/2 verifier_probe_read/probe read 8 bytes
> > > > > > >     8903 run_subtest:PASS:obj_open_mem 0 nsec
> > > > > > >     8904 run_subtest:PASS:unexpected_load_failure 0 nsec
> > > > > > >     8905 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
> > > > > > >     8906 run_subtest:FAIL:659 Unexpected retval: 0 !=3D 512
> > > > > > >
> > > > > > > More details can be found at:  https://github.com/kernel-patc=
hes/bpf/pull/6872
> > > > > > >
> > > > > > > Should we consider this behavior of bpf_probe_read_kernel() a=
s
> > > > > > > expected, or is it something that requires fixing?
> > > > > > >
> > > > > >
> > > > > > I might be missing something, but there is nothing wrong with
> > > > > > bpf_probe_read_kernel() behavior. In "read 4" case you are over=
writing
> > > > > > only upper 4 bytes of u64, so lower 4 bytes are garbage. In "re=
ad 8"
> > > > > > you are reading (upper) 4 bytes of garbage from uninitialized
> > > > > > data_dst.
> > > > >
> > > > > The issue doesn't lie with the dst but rather with the src. Even =
after
> > > > > initializing the destination, the operation still fails. You can =
find
> > > >
> > > > Are you sure the operation "fails"? If it would fail, you'd get a
> > > > negative error code, but you are getting zero. Which actually makes
> > > > sense.
> > > >
> > > > I think you are just getting confused by big endianness of s390x, a=
nd
> > > > there is nothing wrong with bpf_probe_read_kernel().
> > > >
> > > > In both of your tests (I pasted your code below, it would be better=
 if
> > > > you did it in your initial emails) you end up with 0x200 in *upper*=
 32
> > > > bits (on big endian) and lower bits are zeros. And __retval thing i=
s
> > > > 32-bit (despite BPF program returning long), so this return value i=
s
> > > > truncated to *lower* 32-bits, which are, expectedly, zeroes.
> > >
> > > Thank you for clarifying. The presence of the 32-bit __retval led to
> > > my misunderstanding :(
> > >
> > > >
> > > > So I think everything works as expected, but your tests (at least)
> > > > don't handle the big-endian arch well.
> > >
> > > The issue arises when the dst and src have different sizes, causing
> > > bpf_probe_read_kernel_common() to handle them poorly on big-endian
> > > machines. To address this, we need to calculate the offset for
> > > copying, as demonstrated by the following
> > >
> > >    bpf_probe_read_kernel_common(&kit->bits_copy + offset, size,
> > > unsafe_ptr__ign);
> > >
> > > One might wonder why this calculation is not incorporated directly
> > > into the implementation of bpf_probe_read_kernel_common() ?
> >
> > Let's stop talking about
> > bpf_probe_read_kernel/bpf_probe_read_kernel_common doing anything
> > wrong or not handling anything wrong. It's not, it's correct. Your
> > code is *using* it wrong, and that's what we'll have to fix. The
> > contract of bpf_probe_read_kernel is in terms of memory addresses of
> > source/destination *bytes* and the *common* size of both source and
> > destination. bpf_probe_read_kernel() cannot know that you are passing
> > a pointer to int or long or whatever, it's just a void * pointer. So
> > if you are writing bytes over long, you need to take care of adjusting
> > offsets to accommodate big-endian.
> >
> > It's a distraction to talk about bpf_probe_read_kernel() here (but
> > it's useful to understand its contract).
> >
> > >
> > > >
> > > > __description("probe read 4 bytes")
> > > > __success __retval(0x200)
> > > > long probe_read_4(void)
> > > > {
> > > >     int data =3D 0x200;
> > > >     long data_dst =3D 0;
> > > >     int err;
> > > >
> > > >     err =3D bpf_probe_read_kernel(&data_dst, 4, &data);
> > > >     if (err)
> > > >         return err;
> > > >
> > > >     return data_dst;
> > > > }
> > > >
> > > > SEC("syscall")
> > > > __description("probe read 8 bytes")
> > > > __success __retval(0x200)
> > > > long probe_read_8(void)
> > > > {
> > > >     int data =3D 0x200;
> > > >     long data_dst =3D 0;
> > > >     int err;
> > > >
> > > >     err =3D bpf_probe_read_kernel(&data_dst, 8, &data);
> > > >     if (err)
> > > >         return err;
> > > >
> > > >     return data_dst;
> > > >
> > > > }
> > > >
> > > > > more details in the following link:
> > > > > https://github.com/kernel-patches/bpf/pull/6882. It appears that
> > > > > bpf_probe_read_kernel() encounters difficulties when dealing with
> > > > > non-long-aligned source addresses.
> > > > >
> > > > > >
> > > > > > So getting back to iter implementation. Make sure you are
> > > > > > zero-initializing that u64 value you are reading into?
> > > > > >
> > > > >
> > > > > It has been zero-initialized:
> > > > >
> > > > > + kit->nr_bits =3D 0;
> > > > > + kit->bits_copy =3D 0;
> > > > >
> > > >
> > > > ok, then the problem is somewhere else, but it doesn't seem to be i=
n
> > > > bpf_probe_read_kernel(). I'm forgetting what was the original test
> > > > failure for your patch set, but please double check again, taking i=
nto
> > > > account the big endianness of s390x.
> > > >
> > >
> > > If we aim to make it compatible with s390, we need to introduce some
> > > constraints regarding the bits iteration.
> > >
> > > 1. We must replace nr_bits with size:
> > >
> > >   bpf_iter_bits_new(struct bpf_iter_bits *it, const void
> > > *unsafe_ptr__ign, u32 size)
> > >
> > > 2. The size must adhere to alignment requirements:
> > >
> > >         if (size <=3D sizeof(u64)) {
> > >                 int offset =3D IS_ENABLED(CONFIG_S390) ? sizeof(u64) =
- size : 0;
> > >
> > >                 switch (size) {
> > >                 case 1:
> > >                 case 2:
> > >                 case 4:
> > >                 case 8:
> > >                         break;
> > >                 default:
> > >                         return -EINVAL;
> > >                 }
> > >
> > >                 err =3D bpf_probe_read_kernel_common(((char
> > > *)&kit->bits_copy) + offset, size, unsafe_ptr__ign);
> > >                 if (err)
> > >                         return -EFAULT;
> > >
> > >                 kit->size =3D size;
> > >                 kit->bit =3D -1;
> > >                 return 0;
> > >         }
> > >
> > >         /* Not long-aligned */
> > >         if (size & (sizeof(unsigned long) - 1))
> > >                 return -EINVAL;
> > >
> > >         ....
> > >
> > > Does this meet your expectations?
> > >
> >
> > I don't think you need to add any restrictions or change anything to
> > be byte-sized. You just need to calculate byte offset and do a bit
> > shift to place N bits from the mask into upper N bits of long on
> > big-endian. You might need to do some masking even for little endian
> > as well.
> >
> > Which is why I suggested investing in simple but thorough tests. Write
> > down a few bit mask patterns of variable length (not just
> > multiple-of-8 sizes) and think about the sequence of bits that should
> > be returned. And then codify that.
> >
> > Then check that both little- and big-endian arches work correctly.
> >
> > This is all a bit tricky because kernel's find_next_bit() makes the
> > assumption that bit masks are long-based, while this bits iterator
> > protocol is based on bit sizes, which are not necessarily multiples of
> > 8 bits. So after you copy memory as bytes, you might need to clear
> > (and shift, for big endian) some bits. Use simple but non-symmetrical
> > bit masks to test everything.
> >
>
> The reason for using 'size' instead of 'nr_bits' lies in the nature of
> the pointer 'unsafe_ptr__ign', which is of type void *. Due to this
> ambiguity in the type, the 'size' parameter serves to indicate the
> size of the data being accessed. For instance, if the type is u32,
> then the 'size' parameter corresponds to sizeof(u32)
>
>     u32 src =3D 0x100;
>     bpf_for_each(bits, bit, &src, sizeof(u32));
>
> This approach shields the user of the bits iterator from concerns
> about endianness, simplifying usage.
>
> Conversely, if we were to use 'nr_bits', the user would need to
> account for endianness themselves. In other words, the user would be

Well, not exactly. Only if they try to cleverly use int/long for
bitmask instead of sticking to an array of bytes. All this endianness
comes into effect only when you are dealing with something else than
pure bytes. And if they do, I think it's ok to expect them to deal
with endianness correctly. (But also for little endian it will just
work even if they don't think much about it).

So I'd keep it as nr_bits and define an interface based on `char *` or
`void *` to make it clear we are dealing with bits in arbitrary-sized
byte arrays.

But if someone has strong opinions otherwise, I'd be happy to hear
some other arguments, of course. I just think it's confusing to be
dealing with *bit*masks but in terms of byte sizes, tbh.

And also, consider that in practice most users will be dealing with
sizeof(u32) or sizeof(u64) (or larger, but multiple-of-4-or-8-bytes)
bit masks. But the implementation has to be correct for all valid
inputs and use cases.

> responsible for calculating the offset of 'src'.For instance, on a
> big-endian machine, if the 'src' is of type u64 and the user only want
> to iterate over 32 bits, the code would appear as follows:
>
>     u64 src =3D 0x100;
>     bpf_for_each(bits, bit, ((void *)&src) + (sizeof(u64) - (32 + 7) / 8)=
, 32);
>
> It may indeed be less user-friendly. However, I can make the
> adjustment as you suggested, given that it aligns with the pattern
> observed in bpf_probe_read_kernel_common().
>
> --
> Regards
> Yafang

