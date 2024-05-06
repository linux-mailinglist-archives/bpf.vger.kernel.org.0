Return-Path: <bpf+bounces-28681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD68BD0A1
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 16:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E0B1F23A83
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 14:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD306153584;
	Mon,  6 May 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPXlmeP4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7B15351B
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006817; cv=none; b=hisNCQcMKVafw7BtlHdtGeH+Twf9O87kedxTsUNpXbhR1F4Yfp+jsFv7b6BxAIowZnBVRt4mwPyy+O1JN3y6JfQ+PYAMnu5O+OumcGUDk9GK+nNlYrHUB/+WPbGwhKr/ojxy2IMoHihmrG62gljQa9oaDSQ8rjTN69VkNv3tuIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006817; c=relaxed/simple;
	bh=QtoHV+JH74/adDpTtAlHD+OlOZohxlWng/ziX5O8GJk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hx9cNwhMisM/wm8h7FZ6TQ1j/3YKu41f1uRZp33wvTgvVkDrwyocllhvU9hnto1DQjhDpqqvl1CfkcJsIcOoo//fxdsj57UG0MrgvFW5S6FT3yCrzyt05AYFP8/ul3P7zVKxCKHLt4a7z5/JANIus3ch3Ff07TB+uhpXR6aXnWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPXlmeP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C06C116B1;
	Mon,  6 May 2024 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715006816;
	bh=QtoHV+JH74/adDpTtAlHD+OlOZohxlWng/ziX5O8GJk=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=hPXlmeP4dDxNTZicwx/pRqnx12XPwBc8RWW3HEZIwZyaWnXdpHu+QDSSuQ0s1VgVP
	 GQ6fQpgDSfmWFrLwfW96k1rXdOYOK92jiUbg0ulen5Ue2KMSBoMVj7dxtRCJgFchdY
	 gci58xM6N8Uv75rIvEOrQz4B3eMwEXycTiuoPFz/UH1EkUllINiNGx5DZ2ijg3f9dJ
	 kbO1nf69p38djm0SqvBGRnwV/FMH/uC5Mq8oKC8rnS+t/OyZcUz4QO5SbI3Mg2sCwm
	 NwfUTSpIZl790aHfjWyKV53W77uzTJM0OzVohHZrPIUICpzHTZyoLZLULKbcA2+JhP
	 946IDfSfT40+A==
From: Puranjay Mohan <puranjay@kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, =?utf-8?B?QmrDtnJuIFQ=?=
 =?utf-8?B?w7ZwZWw=?=
 <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, bpf@vger.kernel.org, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, "Tiezhu
 Yang" <yangtiezhu@loongson.cn>, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH bpf] riscv, bpf: make some atomic operations fully ordered
In-Reply-To: <a5de8fa22c021c2df5f37f285c8d2247f1c6c1b0.camel@linux.ibm.com>
References: <20240505201633.123115-1-puranjay@kernel.org>
 <mb61p34qvq3wf.fsf@kernel.org>
 <a5de8fa22c021c2df5f37f285c8d2247f1c6c1b0.camel@linux.ibm.com>
Date: Mon, 06 May 2024 14:46:53 +0000
Message-ID: <mb61pcypz0zhe.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ilya Leoshkevich <iii@linux.ibm.com> writes:

>> Puranjay Mohan <puranjay@kernel.org> writes:
>>=20
>> > The BPF atomic operations with the BPF_FETCH modifier along with
>> > BPF_XCHG and BPF_CMPXCHG are fully ordered but the RISC-V JIT
>> > implements
>> > all atomic operations except BPF_CMPXCHG with relaxed ordering.
>>=20
>> I know that the BPF memory model is in the works and we currently
>> don't
>> have a way to make all the JITs consistent. But as far as atomic
>> operations are concerned here are my observations:
>
> [...]
>
>> 4. S390
>> =C2=A0=C2=A0 ----
>>=20
>> Ilya, can you help with this?
>>=20
>> I see that the kernel is emitting "bcr 14,0" after "laal|laalg" but
>> the
>> JIT is not.
>
> Hi,
>
> Here are two relevant paragraphs from the Principles of Operation:
>
>   Relation between Operand Accesses
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   As observed by other CPUs and by channel pro-
>   grams, storage-operand fetches associated with one
>   instruction execution appear to precede all storage-
>   operand references for conceptually subsequent
>   instructions. A storage-operand store specified by
>   one instruction appears to precede all storage-oper-
>   and stores specified by conceptually subsequent
>   instructions, but it does not necessarily precede stor-
>   age-operand fetches specified by conceptually sub-
>   sequent instructions. However, a storage-operand
>   store appears to precede a conceptually subsequent
>   storage-operand fetch from the same main-storage
>   location.
>
> In short, all memory accesses are fully ordered except for
> stores followed by fetches from different addresses.

Thanks for sharing the details.

So, this is TSO like x86

>   LAALG R1,R3,D2(B2)
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   [...]
>   All accesses to the second-operand location appear
>   to be a block-concurrent interlocked-update refer-
>   ence as observed by other CPUs and the I/O subsys-
>   tem. A specific-operand-serialization operation is
>   performed.
>
> Specific-operand-serialization is weaker than full serialization,
> which means that, even though s390x=C2=A0provides very strong ordering
> guarantees, strictly speaking, as architected, s390x atomics are not
> fully ordered.
>
> I have a hard time thinking of a situation where a store-fetch
> reordering=C2=A0for different addresses could matter, but to be on the sa=
fe
> side we should probably just do what the kernel does and add a
> "bcr 14,0". I will send a patch.

Thanks,

IMO, bcr 14,0 would be needed because, s390x has both

  int __atomic_add(int i, int *v);

and

  int __atomic_add_barrier(int i, int *v);

both of these do the fetch operation but the second one adds a barrier
(bcr 14, 0)

JIT was using the first one (without barrier) to implement the arch_atomic_=
fetch_add

So, assuming that without this barrier, store->fetch reordering would be
allowed as you said.

It would mean:
This litmus test would fail for the s390 JIT:

  C SB+atomic_fetch
=20=20
  (*
   * Result: Never
   *
   * This litmus test demonstrates that LKMM expects total ordering from
   * atomic_*() operations with fetch or return.
   *)
=20=20
  {
          atomic_t dummy1 =3D ATOMIC_INIT(1);
          atomic_t dummy2 =3D ATOMIC_INIT(1);
  }
=20=20
  P0(int *x, int *y, atomic_t *dummy1)
  {
          WRITE_ONCE(*x, 1);
          rd =3D atomic_fetch_add(1, dummy1);     /* assuming this is imple=
mented without barrier */=20
          r0 =3D READ_ONCE(*y);
  }
=20=20
  P1(int *x, int *y, atomic_t *dummy2)
  {
          WRITE_ONCE(*y, 1);
          rd =3D atomic_fetch_add(1, dummy2);    /* assuming this is implem=
ented without barrier */
          r1 =3D READ_ONCE(*x);
  }
=20=20
  exists (0:r0=3D0 /\ 1:r1=3D0)


P.S. - It would be nice to have a tool that can convert litmus tests
into BPF assembly programs and then we can test them on hardware after JITi=
ng.

Thanks,
Puranjay

