Return-Path: <bpf+bounces-48606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F1DA09EB0
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 00:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7700188CF45
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 23:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D34220699;
	Fri, 10 Jan 2025 23:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="adb4BO2+"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C49B24B24E
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736551642; cv=none; b=lVsyoGBOaF1v9l9hSF2+LHZkAFm/QvqiPkn7+l0SbKkoBrnH5TXlEVQOGduSg3fnEyMHaOhw5uKiG2m8PDN2ayK2wDETVQ7n99uofvccnXRMtoxwrZnI/TDKYUGVwyySWJVebvRnf++HTwpepXmo0VpUEZWKHcmZUduI+cvsP1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736551642; c=relaxed/simple;
	bh=Y3I78nuG/+Sio+fd77xDTy2Z7weF37r2M4C230az/WY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LiNGi8TELRiySdz5MesueoxSe7sS2VUU3VFWmF617eHgu/bY7e/3bubpZRQRTvvnate3P0+7kOjrlZ+5rw8RgOUqTeq22Ur2HLajINb7kUujTqMFmlSyX+wgMEmrhxvylHFHAoy4RVgeLRkqsGERb/rssnC3zlFvdAoo+Hnq1nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=adb4BO2+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8774B203D5F3;
	Fri, 10 Jan 2025 15:27:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8774B203D5F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736551641;
	bh=Y3I78nuG/+Sio+fd77xDTy2Z7weF37r2M4C230az/WY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=adb4BO2+EAyCwUVQlLDI8ZW32DtZ4SKEkRE1zY7Z3D9d+dbUw0pRsw/J21bZPSTgT
	 6ayt+A8fKlZnCTIHj9nPi2xQ4P/QTnYsIOMV9ckOPkwpdLZoah2E940vyyYrFh8VEN
	 cH32kp165UEFPPCzrK252QSbFzV+K1cbQFcbZG3o=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, nkapron@google.com, Matteo Croce
 <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Moore
 <paul@paul-moore.com>, code@tyhicks.com, Francis Laniel
 <flaniel@linux.microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>
Subject: Re: [POC][RFC][PATCH] bpf: in-kernel bpf relocations on raw elf files
In-Reply-To: <CAADnVQLxgD_7GYWZZ49aY2LqVYOy4uGvK2ikm7MJ1Cj60VPNaw@mail.gmail.com>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
 <CAADnVQLxgD_7GYWZZ49aY2LqVYOy4uGvK2ikm7MJ1Cj60VPNaw@mail.gmail.com>
Date: Fri, 10 Jan 2025 15:27:13 -0800
Message-ID: <87ikqm45da.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Jan 9, 2025 at 1:47=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>>
>> This is a proof-of-concept, based off of bpf-next-6.13. The
>> implementation will need additional work. The goal of this prototype was
>> to be able load raw elf object files directly into the kernel and have
>> the kernel perform all the necessary instruction rewriting and
>> relocation calculations. Having a file descriptor tied to a bpf program
>> allowed us to have tighter integration with the existing LSM
>> infrastructure. Additionally, it opens the door for signature and proven=
ance
>> checking, along with loading programs without a functioning userspace.
>>
>> The main goal of this RFC is to get some feedback on the overall
>> approach and feasibility of this design.
>
> It's not feasible.
>
> libbpf.a is mainly a loader of bpf ELF files.
> There is a specific format of ELF files, a convention on section names,
> a protocol between LLVM and libbpf, etc.
> These things are stable api from libbpf 1.x pov.
> There is a chance that they will change in libbpf 2.x.
> There are no plans to do so now, but because it's all user space
> there is room for changes.
> The kernel doesn't have such luxury.
> Hence we cannot copy paste libbpf into the kernel and make
> it parse the same ELF data, since it will force us to support
> this exact format forever.
> Hence the design is not feasible.
>

Noted.=20=20

> This was discussed multiple times on the list and at LSFMMBPF, LPC
> conferences over the years.
>
> But if the real goal of these patches to:
>
>> open the door for signature and provenance
>> checking, along with loading programs without a functioning userspace.
>
> then please take a look at the light skeleton.
> There is an existing mechanism to load bpf ELF files without libbpf
> and without user space.
> Search for 'bpftool gen skeleton -L'.

Our goal is to have verifiable ebpf programs that are portable across
multiple kernels. I looked into light skels, it appears that all the
instruction relocations are calculated during skeleton generation and a
static instruction buffer containing those fixed relocation results is
passed into the kernel? For some relocs, those values would be
deterministic, making that a non-issue. For others that rely on btf data
or kernel symbols those might not be portable anymore.

Would it be amenable to possibly alter the light skeleton generation
code to pass btf and some other metadata into the kernel along with
instructions or are you trying to avoid any sort of fixed dependencies
on anything in the kernel other than the bpf instrucion set itself?

-blaise

>
> Also there were prototype patches to add signature checking on
> top of the light skeleton,
> and long discussions on the list and conferences about 'gate keeper' conc=
ept.

