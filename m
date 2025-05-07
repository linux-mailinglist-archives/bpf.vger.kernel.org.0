Return-Path: <bpf+bounces-57693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A46AAE8AE
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 20:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE47B16B5A1
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 18:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CD128A73E;
	Wed,  7 May 2025 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b="VGbGjiiV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCC97263D
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746641737; cv=none; b=eGzEmu0bSGnb/cHJS8T9l8V2u77p/AM8DX0zSmYmy3NFf3aUptdXB2ZKkd1ApZZmT6OhaEUNUToZHplVTlbtwaZs4j+ugLI4NepSSMl74zTam5b9TanSU3z7l8kW70t6L21UIWR/hRZHFXfuaSP0W2fJhK9Gtoss0VE2Q/ab4Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746641737; c=relaxed/simple;
	bh=ZS2Qp378eZqS1cO2ySYQ630mIPP6LtVZqMXp9yCkPKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDV0NR1NFeCKKEpwbwS3aqbd3LeDuU8Mt6GEM5HV3KzG2qAe+Qy/Mx2/PoHoeucedPEU5AASMpEgpdmimQSiF+jIETBIJ1VawhTOadt/XP0SU4wT2Y6ay+q7HLGdcw0PCamyjgFVzgm8j2GVXYdkV3tKz1P38Rib0dqnXAXAoQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com; spf=pass smtp.mailfrom=riotgames.com; dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b=VGbGjiiV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riotgames.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e033a3a07so2953965ad.0
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1746641735; x=1747246535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=027RgEwnI73MpLPFkcDkamFR64j7qgKy5W40Rs3oAH4=;
        b=VGbGjiiVc5BKot9AddlEGb8jX/gFAXaqIFhoTfFfaY54Y1+Cihh4xmYx034EQyQP7F
         h6eNK24cJDjCoxXrl2TyAu2AehHqGZfFud80B9PqNi9kbYl3LHSY9J2uxQL1YnrWqjo5
         vnqDp4JOu4b4P5gASiDoZf5vq/IpXsHXA+lnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746641735; x=1747246535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=027RgEwnI73MpLPFkcDkamFR64j7qgKy5W40Rs3oAH4=;
        b=CanNFYl6E7J2YHl1Nc/WNHU0fp3P4POGah97QBl23sIwlTs7og9WoEK9HETbxCRYMd
         EdC/4l0JIwDgrOB7NiE8MlYN4fQ95z1M0hYeW6zxDMWgTHzvP5u5Dpe3IcNWUQ0mAhh7
         qfP0e9+BsCJBs751TZ+XZxujSfhX+qbUj59dx2d902VYqUU8IdsAOt4HYKNagSc4Q0AZ
         EE6LRvZwLcoXCrSeHBceDGGieiO7F1NXqqv9kK3/jy9F8dGV6sqeVQ2zTtwMxe3ZeSbN
         lUB8mXL5wst26iWf6Enl/8U+RxG9Mz5Pzxq+ixLdn5FAvQLWGe0dOTZwDY2P/nZosM22
         JWBw==
X-Gm-Message-State: AOJu0YzG6oleJa+AOzFDXmMsxzBIdAUghz2e42GWqmJMlAkS8880/foM
	vt9LL3qJnk9o1hh3/HvXaGWkbxTiAeR1L9fCB46i+Ld9zbrz1nH/umSSf4n6/SAoDJABOedYdy1
	qYCV1eucHXK06SYeDWbE8mdKPU/X7SpulPqTbUg==
X-Gm-Gg: ASbGncsvePbZuSoqMrFkZbwSvYUfjBXqw6KLtkbhYXgFgSx9b+fIddQzahM7FGhwPIK
	WWxbOjatsiREOfpjc/0tSdyK4MlfO5n5mlZXCyjfs/DOmZNlYzlsRDm7OsIdHcnfgfJXUPy2Exr
	UKW3NjikdbBV8JQn5d2dRA7w==
X-Google-Smtp-Source: AGHT+IHzn4iFXqvzGW1YEtVBeAXoPt9BX7oTsukuOFn3b8dheaB9VlNv8unQ8SsiRngdnYBPHVf90TXcM/K9Wwwrr8E=
X-Received: by 2002:a17:90b:1d43:b0:2ee:edae:780 with SMTP id
 98e67ed59e1d1-30aac1b4086mr7330817a91.15.1746641734555; Wed, 07 May 2025
 11:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com>
In-Reply-To: <20250420105524.2115690-1-rjsu26@gmail.com>
From: Zvi Effron <zeffron@riotgames.com>
Date: Wed, 7 May 2025 11:15:23 -0700
X-Gm-Features: ATxdqUEpVSG3Pqh8XGyyThfcj-ZMKKRhP3CAqSqBJ6OE7LCM4sImSUmBje20X5I
Message-ID: <CAC1LvL3Tkzb3RtbmzsspOHkmz+28g7qKP04Ni6+Dvj8jD2TWJg@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/4] bpf: Fast-Path approach for BPF program Termination
To: Raj Sahu <rjsu26@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, djwillia@vt.edu, 
	miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, doniaghazy@vt.edu, 
	quanzhif@vt.edu, jinghao7@illinois.edu, sidchintamaneni@gmail.com, 
	memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2025 at 3:56=E2=80=AFAM Raj Sahu <rjsu26@gmail.com> wrote:
>
> From: Raj <rjsu26@gmail.com>
>
> Motivation:
> We propose an enhancement to the BPF infrastructure to address the
> critical issue of long-running BPF programs [1,2,3,4]. While the verifier
> ensures termination by restricting instruction count and backward edges, =
the
> total execution time of BPF programs is not bounded. Certain helper funct=
ions
> and iterators can result in extended runtimes, affecting system performan=
ce.
>
> The existing BPF infrastructure verifies that programs will not indefinit=
ely
> loop or leak resources. However, helper functions such as `bpf_loop`,
> `bpf_for_each_map_elem`, and other iterative or expensive kernel interact=
ions
> can cause runtimes that significantly degrade system performance [6]. Cur=
rent
> detaching mechanisms do not immediately terminate running instances,
> monopolizing CPU. Therefore, a termination solution is necessary to swift=
ly
> terminate execution while safely releasing resources.
>
> Existing termination approach like the BPF Exception or Runtime hooks [5]=
 have
> the issue of either lack of dynamism or having runtime overheads: BPF
> Exceptions: Introduces bpf_throw() and exception callbacks, requiring sta=
ck
> unwinding and exception state management. Cleanup can only be done for
> pre-defined cancellation points.  Runtime Hooks: Proposes watchdog timers=
, which
> requires resource tracking, though minimal but non-zero runtime overheads=
.
>
> Design:
> We introduce the Fast-Path termination mechanism, leveraging the
> verifier's guarantees regarding control flow and resource management. The
> approach dynamically patches running BPF programs with a stripped-down ve=
rsion
> that accelerates termination. This can be used to terminate any given ins=
tance
> of a BPF execution. Key elements include:
>
> - Implicit Lifetime Management: Utilizing the verifier=E2=80=99s inherent=
 control flow
>   and resource cleanup paths encoded within the BPF program structure,
>   eliminating the need for explicit garbage collection or unwinding table=
s.
>
> - Dynamic Program Patching: At runtime, BPF programs are atomically patch=
ed,
>   replacing expensive helper calls with stubbed versions (fast fall-throu=
gh
>   implementations). This ensures swift termination without compromising s=
afety
>   or leaking resources.
>
> - Helper Function Adjustments: Certain helper functions (e.g., `bpf_loop`=
,
>   `bpf_for_each_map_elem`) include  mechanisms to facilitate early exits =
through
>   modified return values.
>

I understand that the motivation for this proposal is kernel safety, so per=
haps
my concern simply doesn't matter in that context, but I'm concerned about t=
he
possibility of data corruption, specifically data stored in maps.

There are many ways to write data into maps that (especially with JIT) do n=
ot
end up going through any helper functions. For example, once a pointer to a=
 map
value has been obtained, it can simply be written to update the map. That m=
eans
there is no helper to be patched to prevent the write.

My understanding is that with the Fast-Path termination mechanism, those wr=
ite
instructions will still be executed and will still update the map. But if t=
he
values they are writing are dependent on the results of any patched functio=
n
calls, the values will not be the intended ones which will result in data
corruption. This corruption would not impact the safety of the kernel, but
could cause problems for userspace applications relying on the map data.

Is that a correct understanding? If so, is that a concern that should be
addressed/mitigated?

> TODOs:
> - Termination support for nested BPF programs.
> - Policy enforcements to control runtime of BPF programs in a system:
> - Timer based termination (watchdog)
>         - Userspace management to detect low-performing BPF program and
>           terminated them
>
> We haven=E2=80=99t added any selftests in the POC as this mail is mainly =
to get
> feedback on the design. Attaching link to sample BPF programs to
> validate the POC [7].  Styling will be taken care in next iteration.
>
> References:
> 1. https://lpc.events/event/17/contributions/1610/attachments/1229/2505/L=
PC_BPF_termination_Raj_Sahu.pdf
> 2. https://vtechworks.lib.vt.edu/server/api/core/bitstreams/f0749daa-4560=
-41c9-9f36-6aa618161665/content
> 3. https://lore.kernel.org/bpf/AM6PR03MB508011599420DB53480E8BF799F72@AM6=
PR03MB5080.eurprd03.prod.outlook.com/T/
> 4. https://vtechworks.lib.vt.edu/server/api/core/bitstreams/7fb70c04-0736=
-4e2d-b48b-2d8d012bacfc/content
> 5. https://lwn.net/ml/all/AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03M=
B5080.eurprd03.prod.outlook.com/#t
> 6. https://people.cs.vt.edu/djwillia/papers/ebpf23-runtime.pdf
> 7. https://github.com/sidchintamaneni/os-dev-env/tree/main/bpf-programs-c=
atalog/research/termination/patch_gen_testing
>
>  arch/x86/kernel/smp.c          |   4 +-
>  include/linux/bpf.h            |  18 ++
>  include/linux/filter.h         |  16 ++
>  include/linux/smp.h            |   2 +-
>  include/uapi/linux/bpf.h       |  13 ++
>  kernel/bpf/bpf_iter.c          |  65 ++++++
>  kernel/bpf/core.c              |  45 ++++
>  kernel/bpf/helpers.c           |   8 +
>  kernel/bpf/syscall.c           | 375 +++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c          |  16 +-
>  kernel/smp.c                   |  22 +-
>  tools/bpf/bpftool/prog.c       |  40 ++++
>  tools/include/uapi/linux/bpf.h |   5 +
>  tools/lib/bpf/bpf.c            |  15 ++
>  tools/lib/bpf/bpf.h            |  10 +
>  tools/lib/bpf/libbpf.map       |   1 +
>  16 files changed, 643 insertions(+), 12 deletions(-)
>
> --
> 2.43.0
>
>

