Return-Path: <bpf+bounces-74603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 344B5C5FCA6
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 01:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB95B35E042
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 00:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA70191F92;
	Sat, 15 Nov 2025 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9QxcI4i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D78F49
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 00:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763168340; cv=none; b=bsgGa7GMvlXV7JUGA6WhCqIfFjL+U0hRK1x7LcWvv2BF1bFqwaEqNnEvHMlrvruM6iejt2c57aKTvtanx6FAV0rBo+fjbcZfGOcvqTu/WAqDNYImKoRJYzkwOYyL+6w1y0ke6LdmBOQwcyAnz9QCg8a1PD1raaDWwEjJpIq6YGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763168340; c=relaxed/simple;
	bh=SkRwbioypMQl7LrzNzh80vHiu6VHXj/6j7JHJysEFl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Joq9pEALolYm4ihOEGPS8vPjVg6mKD+zO++RZgSUoVWcOc/CtD5e9ahstqZA/b9h25zlT6UQ1URvfXPlRm4XDL1V2asx5w/JRlGz3s0n+5efsjLv6aIpUse2w2/l2bqojR7oCpYSg3on6+Evjek/ymem+MwwK+wwZwr4WbtjDOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9QxcI4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD10C4CEF8;
	Sat, 15 Nov 2025 00:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763168339;
	bh=SkRwbioypMQl7LrzNzh80vHiu6VHXj/6j7JHJysEFl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=E9QxcI4iBSFCzE2iq3LqjoU1Ed0zu+SdSVJVaTAxUmm5RwKTsu88O8TtRRGHnhOdA
	 lQcgYGEvgnLB0pMRyEoKc0qdsN2MxXpQC+/r4y2WwmMNogDK79YFLjoyOUOW2KJB+R
	 iU2ab9NZ1PufL6tWcSunPNH+jhkorbYTIr0orUrCUhgSWkwb3Vzq66bQEt/q8OVarS
	 2za3ZvmrxQg2RbjxncuqAuIcklTcY1fuv1JfhFxrOuhJblDA90EgQVWdWRAjaHtdt/
	 3rtDnBnseotpFsPsLbFtUj+mtsd0bcPMQBRVHip9kgBMxzH/Jk4hbP44IFxj/xLIqt
	 npCja3HK6C2oA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel
 Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests: bpf: test non-sleepable
 arena allocations
In-Reply-To: <CAADnVQLABi2vLBnUq3LAQS29nNySvq6ieBrMAKpB8EJ8D4XM-Q@mail.gmail.com>
References: <20251114111700.43292-1-puranjay@kernel.org>
 <20251114111700.43292-5-puranjay@kernel.org>
 <CAADnVQLABi2vLBnUq3LAQS29nNySvq6ieBrMAKpB8EJ8D4XM-Q@mail.gmail.com>
Date: Sat, 15 Nov 2025 00:58:56 +0000
Message-ID: <mb61p5xbc3ycv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Nov 14, 2025 at 3:17=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
>>
>> +
>> +       /* Allocate 2051 pages (more than 1024) at once to test the limi=
t of kmalloc_nolock() */
>> +       pages =3D bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NODE=
, 0);
>
> Please explain the choice of 2051 a bit better.
> I think you wanted to do 3 steps and last one not aligned to 1024 ?

Yes, I wanted to exercise the loop a couple of times and also do an
iteration that is not aligned to test all edge cases. Will add a better com=
ment.

>> +       if (!pages)
>> +               return -1;
>> +
>> +       bpf_for(i, 0, 2051)
>> +                       pages[i * PAGE_SIZE] =3D 123;
>> +       bpf_for(i, 0, 2051)
>> +                       if (pages[i * PAGE_SIZE] !=3D 123)
>> +                               return i;
>> +
>> +       bpf_arena_free_pages(&arena, pages, 1025);
>
> free less on purpose?

This is should be 2051 too, missed updating it here.


