Return-Path: <bpf+bounces-50426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD75A2781D
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A980164103
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 17:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446352153D2;
	Tue,  4 Feb 2025 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjHkC+sZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A12144AD
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689365; cv=none; b=Fqk6lFHcNNVPtHc3fMO1p4w6GJc3lrrwOChcKPzejRds/ejGaq5JaTUr0j9ddqG6D15nZmTyax3VIfgp1SjsPOspcDM5BqZmO+J8aV/uFPh3V58YITXX8mg5vZSqzaMMtBcOK1Xx6+zdkM9irA/bx4repZqDOB+CMw21bSspgVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689365; c=relaxed/simple;
	bh=1gJRhbGbAMNEA88gf7rhV7SJBebHJW3hPLMwxD+NuEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrmjUew775/P3Be/+EvJA0vq40bdoQnbs8mWZFH/HLM30pdmypQeTsHQXLoJpgzaK+DKRcEAqX/sOuf+oKsNXMXOhaWMOMBkNfEXVAXBi1IiTBWn5769SAZiRS/gIzpKIxT93wY3YJsg18kh4xBrSbeORrN4zISpFLrUdMFYb6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjHkC+sZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso43798055e9.2
        for <bpf@vger.kernel.org>; Tue, 04 Feb 2025 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738689362; x=1739294162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gJRhbGbAMNEA88gf7rhV7SJBebHJW3hPLMwxD+NuEw=;
        b=DjHkC+sZOaTuBaYV3EDge418g28zT5lUy0Ix8EsBYlI96lYijhYKVFs/WiwMLMN6zM
         3AnT4iM6hcDTz5wxT2xrs8bPEhDXDPkaUjSx9MVvVMY3mDik9jiVPC1yC8n7F/1vJSkL
         o3EgQL3fh7galaf38lsiPvuLhuBSKdPqsQZ5Kfz/fv64tXBclhFN+ZtJUS6MUCTOQF2Y
         NLoXH+qBgdmQvKdn37TanMCGv/8mp2Ig++epyS9EHEesfGkRZA0ULx0AgilgvzE3mCXe
         xIP0M30AZEyPx4KcQX6r0NzKCzDwdsoqbftgaznMcZm3zZyyLIrklV8jaaYX6TESFa9T
         QMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738689362; x=1739294162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gJRhbGbAMNEA88gf7rhV7SJBebHJW3hPLMwxD+NuEw=;
        b=TLaILm0Dz9bItyHltE1QMkXnuOdmzPL/51n7HIg9NpTzsXVXiPVyjIr1NlDSxefpc6
         ium2fvRPZUy1SrFmpgAFXnFR+bm6y2EIf47RjYvS5enCELnS9cfVzGWuIBKW7XC0MBFR
         KSKykKGI6zXeOe2oi3zh5G2Yo8ygXhVsNkjnqdmjbzmp+GPgAgRkpiTGmvamH9vrNKHc
         ijIzWtrxVB132fLHM23PWlJkA+8rcSsfY0ntzflRHeuo/HBYnCnezdUd+oYe/YG4OQem
         A7Y4sdVBFKxvFy09r8Gpqo37R2S2dFUdHDN8JDFsJRpwF5Ern2htNUAYIkHdh0gHEUsg
         5YLw==
X-Gm-Message-State: AOJu0YwSAsUkozKHtoe9aNch47RlCIdir1kl5K3ZwaKctEpnE70JIvST
	+LMNFi8Ig8Tzx5M1+b5vzS7cvKb0PJzvtEtyhFQGTE5wU8n+jo0GJm+wj7Y4WEbei+klFgeXcZR
	86Y7e6SVyEEzyoeL8xezGIzEK9s4=
X-Gm-Gg: ASbGncu1WostDO7nsuKyFZRMfS87GXrmFDo8APYElaIc/h9+VSYdwiJy+J8y1vcFSX4
	xOUvv64jyPK3gz3xgFuIy4yyeIDLQ8TGX4IBLj7qhE6W18wjWgFFmu6A7n6hnSZDKuXc7+XI+sp
	G4ecnNPOS1u0JX
X-Google-Smtp-Source: AGHT+IE8UbxUR7hQRLpoliJ1l0K8c/FQPBKDmJArLv5xVEqORCcvnRDk8Cn5zG4uzUOwSLNz4r3ZwpQ0Ks6zssGTI1Q=
X-Received: by 2002:a5d:5586:0:b0:385:e429:e59e with SMTP id
 ffacd0b85a97d-38c520b03d6mr16107393f8f.52.1738689361994; Tue, 04 Feb 2025
 09:16:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHnJ_vj-bbZhUqoDrf0wXEh8gEUVwq34WMXfHRo5=nx5FAL4OA@mail.gmail.com>
 <CAHnJ_vhEwtqFtjjEX3DN03e1_vKSBu4e2cOAdinzgtrs2aPjUw@mail.gmail.com>
In-Reply-To: <CAHnJ_vhEwtqFtjjEX3DN03e1_vKSBu4e2cOAdinzgtrs2aPjUw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Feb 2025 17:15:51 +0000
X-Gm-Features: AWEUYZkQb9MA1vN0dHVxYn7XvYV6lwBxx6ioSFDt_a29X7wH-0fAzpsR4srqv5w
Message-ID: <CAADnVQ+MWfoeJCUSyRka8uAOQs=aqMppV3EiqT8jzRrfFkw0Uw@mail.gmail.com>
Subject: Re: LSF/MM + BPF ATTEND - Topic 1 for discussion
To: Aryan Kaushik <aryankaushik666@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 2:00=E2=80=AFAM Aryan Kaushik <aryankaushik666@gmail=
.com> wrote:
>
> Hi Team
>
> Hope this mail find you well.
>
> Topic 1: Practical Applications of WebAssembly (WASM) in Filesystems,
> Memory Management, and eBPF
>
> Description: WebAssembly (WASM) is emerging as a powerful technology
> for secure, efficient execution in various computing environments.
> This session will focus on how WASM can be leveraged in filesystems,
> memory management, and eBPF.
>
> Key discussion points include:
>
> 1. WASM=E2=80=99s lightweight execution model and its impact on memory ef=
ficiency
> 2. How WASM interacts with filesystems and operates within sandboxed
> environments
> 3. Potential synergies between WASM and eBPF for secure, efficient
> execution in cloud-native and kernel-space applications
> 4. Real-world examples of WASM implementations in security and
> performance-critical environments
> 5. Challenges and opportunities in integrating WASM into Linux subsystems
>
> My Contribution: Given my interest in both WASM and security-focused
> computing, I=E2=80=99d like to explore how WASM can enhance performance a=
nd
> security in system-level applications.
> I=E2=80=99m particularly interested in discussing its potential for secur=
e
> execution, memory isolation, and integration with eBPF for
> next-generation cloud and kernel-space workloads.

These topics sound like an interesting academic research,
but it's not clear how any of it is applicable to linux kernel development.
There is no wasm in the kernel.
If the goal is to introduce wasm in the kernel then it should be
stated as such.
If it's all user space related then lsfmmbpf conference is not
the right forum for such discussion.
It can happen on bpf mailing list or elsewhere instead.

