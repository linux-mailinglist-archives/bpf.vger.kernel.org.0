Return-Path: <bpf+bounces-53832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666F6A5C8C4
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 16:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A3F3A4927
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD6D25E80C;
	Tue, 11 Mar 2025 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjAeXbgA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397F1E98EC
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707871; cv=none; b=lC7jheRQuqzu4HdrTsBSghkd/0jco45ZHlPz6tmPPwdb0wBPfKjEtRaOfDX6BZbLVn0rneRWg1wbm6HFHdYUqlVZikECcrfbov2O8eLETRtKJve0rSi/a8NDv4v1F3oO2y4ESqptjTOcSKEf/aDmq3jEKntWVkhT6/gpvUTav64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707871; c=relaxed/simple;
	bh=VeyTVbqSXK1wjF/eFdxHpYyf/69PmvXtegmSu3sXDok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vlac053/z0cfe+sGR4CzCflOggPuK6Wrz95nbylMAPeS4YaD8VWH9gBxvocVo1OreNQakIixxbl1GrrQCrq3GCMQ7vl5f7Xyv7xjshcntSFCeElkNkj8uXvbr5kucL/Sm39S6Vdr5BOjASN5nRp1MO5MyuO61FePWpgx0BtARCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjAeXbgA; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso5173120a12.2
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741707868; x=1742312668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vls8NVAZBqIMn3z2XtOTm7DXDPZKSXzwp6eF6aHn9EQ=;
        b=CjAeXbgALjXR9jLwuCea49BosjPZYZOfUSsAMyQYof0xVjj6mnF4o0eLJTdARTCRtu
         OCXYKsKtyblmqegBrKN4mDwgIfcb0ZpDuSLDaTtMLQ73XDr96hBsqNfL+2FyDa92rxiO
         J05XXHdr4aG5ul6+YzAPJ57y6V9WWiLu/U5V7NicmTl7sFEG4fyjvFzMarCtLtBajNb2
         WN04aA61O7f9zQ9Ntu0ln514JBzIk8GFKJwOe4bZkIS+z8KTZbzA9HrBVRvDptTLl/Dj
         1/WAC24T+fx/SSTRAVNDLg38d2/xIPDHUo6GAru3I2m1ElzhmoVNYjMVUAsUKIDA3tTU
         yOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741707868; x=1742312668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vls8NVAZBqIMn3z2XtOTm7DXDPZKSXzwp6eF6aHn9EQ=;
        b=NTfORnm4FloTM6wYvpR12VuW6zoO8YZUWZAFVrmptmx7GNTaAz2WQ9v04+AiZtc2nM
         7p7k63jgoxGh0Rx2uzm2zQLH5oawdt8i3yEbvUITiem9vj34K0fVjC5nL/vdLK4Z/NAa
         6qKE1XTbjh3Iz8UIxRoXYbEqzwwVxnybKoDRVwkyN7/9OqZ2P4gFYDC0oq3E5dxYzShX
         MUjbjNUGajPixHXJsTga8wr3/DZFSnS9S0+IiOPg7FFyK95OsUBI1w62L+HDl3m6PmTA
         yGf/1R6QaxpYk50b2e/HKk2h0YZ/rZNALGYE+o+27c9at/6gRu3nb17bQw+tJjInBw1/
         Gr7A==
X-Gm-Message-State: AOJu0YyvBOoXZguNEXOSBStZE02Ie58IpKoXshJA5lpLMXd01fooOQvE
	hu6KqsEq11Mo1eqNxJ8khMUJECVk8Kf1LKb+lQNdqKlb4BfwhNxvBtfiR3rYCidQQUT3NHI4/uG
	dt4jpK3zZEP/MJ+V3yb4Zf6REuzc=
X-Gm-Gg: ASbGncs+kRKbV31Y/y+JCYBi/2ZQH+NHlgeKXG0Pi7WyUttSYFH+zOJ8LpeLtJKitoJ
	scw2vRBncO7Bw9KxljoAIihUDu2YlY2/+3YRYUeWlVxAn41pWtV10LcIYc8PJWRy/10J9jeuB18
	W0kfj8vpU/RgdjVbjOXU33jeOidCpw99JVDFKGZhxVtTTZQEDzHrWUrEM2RA==
X-Google-Smtp-Source: AGHT+IH+BlsvoHsF8HF/mVcrBWKW9LDXs5Zx/wW7CUNDUpWIHTRFGnBdTbyo1GdaDnxT4m1Eft0cfebJOuHx3sqskjA=
X-Received: by 2002:a05:6402:13cc:b0:5e6:17e6:9510 with SMTP id
 4fb4d7f45d1cf-5e617e69fefmr15397181a12.6.1741707867338; Tue, 11 Mar 2025
 08:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311154244.3775505-1-memxor@gmail.com>
In-Reply-To: <20250311154244.3775505-1-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 11 Mar 2025 16:43:51 +0100
X-Gm-Features: AQ5f1JoIr1wYS_evNNceshjLfJr92-oO2vSYb38h-wBz0Efdg1TQxt2bWdURYcU
Message-ID: <CAP01T7622-6+e4K_O+AH978Jbp=M8HBe5ho2H4yS4FoTJ8=COQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix arena_spin_lock
 compilation on PowerPC
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Mar 2025 at 16:42, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Venkat reported a compilation error for BPF selftests on PowerPC [0].
> The crux of the error is the following message:
>   In file included from progs/arena_spin_lock.c:7:
>   /root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:122:8:
>   error: member reference base type '__attribute__((address_space(1)))
>   u32' (aka '__attribute__((address_space(1))) unsigned int') is not a
>   structure or union
>      122 |         old = atomic_read(&lock->val);
>
> This is because PowerPC overrides the qspinlock type changing the
> lock->val member's type from atomic_t to u32.
>
> To remedy this, import the asm-generic version in the arena spin lock
> header, name it __qspinlock (since it's aliased to arena_spinlock_t, the
> actual name hardly matters), and adjust the selftest to not depend on
> the type in vmlinux.h.
>
>   [0]: https://lore.kernel.org/bpf/7bc80a3b-d708-4735-aa3b-6a8c21720f9d@linux.ibm.com
>
> Fixes: 0201027a026c ("selftests/bpf: Introduce arena spin lock")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Venkat, please help test, as CI and I don't have access to a PowerPC machine.

Thanks!

