Return-Path: <bpf+bounces-35134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288C2937E91
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 03:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5025E1C21408
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 01:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE2D8F4E;
	Sat, 20 Jul 2024 01:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyHc7di9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1C8BE2
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721437754; cv=none; b=RNqyyFnRId2JERHXxz4veFZdtu7dz2lHWlXCPId7fRJiP1P1PHNy1VZoK2w7q7OTS340V54d51K3VigEoCCJ0ITTwC1eRlAMSeGm/PUcbCtRsofHwquYeqvxqisxzjymYXAx1N55T8uQ8rBiTi9ebQm685y9wnVR2lUKjS8pSPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721437754; c=relaxed/simple;
	bh=ZFy1aySu9a5h4q71/tzVafiRixmcN8DqZ1SWwn5ZcqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPyK6uMfed5F1zHvOwzTJIhZBQzEt3IrYLzSdfI1v1eIyX2kG7i/ojnlYD1m7XXb2RwUsBMpVSXXzZeBkaAESIMAmufVehzK2j+06F82zcYzn7dwDI2AC3oC8C3iDTQmw2QchfZaSwB9Dr6ouJlhiqZC10uJBvmNkRwOto8nS3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyHc7di9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-367ab76d5e1so811200f8f.3
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 18:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721437751; x=1722042551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxEtRpTPyxIJDoxKbTn1/GyYZZ45P+RAueEV58v297Y=;
        b=IyHc7di9lQhXE4Q732CfhO1lBpCiUZaQUMMULmMAT/6PPpyDZKKOiQTDaDXGztCeDo
         QxYfWj4dWJjDFtlGkkzknG8xpqtOOB6hDiT5yF9E3Wk5tpYpLT9so45AgTyEXv1z5SLU
         VLQoID/3LwLOeP/l/0dBba4JTAtg8ltynWOHzVRh/s3EOb9aP0bgB+WYfv3Jxv8qM/Sv
         vBYNPmcw25Yz3Qt+GXUHGOrTqpnPSaVSuDbWXVqwVo2JbSQUx6yapSXCe7jshHa0vhfi
         xUfYCR5bemOVHuWdDA8i42gmZrk4GZyHBmNX0m4f6R4xcFOfvRoC2L6BEBONaRqjdogB
         vleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721437751; x=1722042551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxEtRpTPyxIJDoxKbTn1/GyYZZ45P+RAueEV58v297Y=;
        b=InQpvjwCKTUU/jYbpu2Wd/uxB1rHkMvreLl1eIa7E3h0PJ9UuobQHRWhuR6ebX4q6K
         gjPKQ66mU0dm8oGTppXVeCT+j/Emo9/4EzVqikIWJQj/b/3vHDVwqvKGicgQ6bJVZyjD
         illXhZE/rweyrSdvTeGit/hmQ8j+LR4tKmtCDVWsX6QPDuczn7G7tUf/pIERXh5+ar4A
         W4pDo9oBLz1mBU3r+wpK1DPQF7adcyNLesOlUHcD9WyWQ2GED/PeXAQ4vcdNH2ZcmCub
         Hu52xyLs/acGGrRHdrtwFPGfk/XMGmvJVKg1gUsqKPqdsjaJwIYyvfA4hoiCBuYwowbs
         hV1Q==
X-Gm-Message-State: AOJu0YzijBGkyIz6W4i1gCSMHvw9ks6bXOx7AFm10u6TUexVWV8SjVr4
	9jRP9KWunleZg60uG9l11DxZh1ONB6NZeqZZh7V3tUjECI1DXTIjryLLsCf2GnDSpyYXYpw0ugC
	xSqSj1y7NqIGxi3ciFdzwDAxOSbU=
X-Google-Smtp-Source: AGHT+IF8vFBQkyJHkqkqO7SpLTnRFMQdqbHZOTUOOtCMEVI/BqymDBCJWqkLifegMjrBk/xgvv801N6ezRir7o7XYPQ=
X-Received: by 2002:adf:e50e:0:b0:367:8aa2:d41f with SMTP id
 ffacd0b85a97d-369bbc69d82mr19581f8f.51.1721437750691; Fri, 19 Jul 2024
 18:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718205158.3651529-1-yonghong.song@linux.dev> <20240718205203.3652080-1-yonghong.song@linux.dev>
In-Reply-To: <20240718205203.3652080-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Jul 2024 18:08:59 -0700
Message-ID: <CAADnVQ+C--rr_C=dCqwGhZux4JQSHJvAazgem1L8OGx7CC6+nw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] [no_merge] selftests/bpf: Benchmark
 runtime performance with private stack
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 1:52=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> The following are the jited progs with private stack:
>
> subprog:
> 0:  f3 0f 1e fa             endbr64
> 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
> 9:  66 90                   xchg   ax,ax
> b:  55                      push   rbp
> c:  48 89 e5                mov    rbp,rsp
> f:  f3 0f 1e fa             endbr64
> 13: 49 b9 70 a6 c1 08 7e    movabs r9,0x607e08c1a670
> 1a: 60 00 00
> 1d: 65 4c 03 0c 25 00 1a    add    r9,QWORD PTR gs:0x21a00
> 24: 02 00
> 26: 31 c0                   xor    eax,eax
> 28: c9                      leave
> 29: c3                      ret

Thanks for doing the benchmarking.
It's clear now that worst case overhead is ~5%.
Could you do one more benchmark such that the 'main prog'
below stays as-is with setup of r9 and push/pop r9,
but in the subprog above there is no 'movabs r9 + add r9' ?
To simulate the case when a big function with a large stack
triggers private-stack use, but it calls a subprog without
a private stack.
I think we should see a different overhead.
Obviously subprog won't have these two extra insns that setup r9
which would lead to something like ~4% slowdown vs 5%,
but I feel the overhead of pure push/pop r9 around calls
will be lower as well, because r9 is not written into inside subprog.
The CPU HW should be able to execute such push/pop faster.
I'm curious what it is.

> main prog:
> 0:  f3 0f 1e fa             endbr64
> 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
> 9:  66 90                   xchg   ax,ax
> b:  55                      push   rbp
> c:  48 89 e5                mov    rbp,rsp
> f:  f3 0f 1e fa             endbr64
> 13: 49 b9 88 a6 c1 08 7e    movabs r9,0x607e08c1a688
> 1a: 60 00 00
> 1d: 65 4c 03 0c 25 00 1a    add    r9,QWORD PTR gs:0x21a00
> 24: 02 00
> 26: 48 bf 00 d0 5b 00 00    movabs rdi,0xffffc900005bd000
> 2d: c9 ff ff
> 30: 48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
> 34: 48 83 c6 01             add    rsi,0x1
> 38: 48 89 77 00             mov    QWORD PTR [rdi+0x0],rsi
> 3c: 41 51                   push   r9
> 3e: e8 46 23 51 e1          call   0xffffffffe1512389
> 43: 41 59                   pop    r9
> 45: 41 51                   push   r9
> 47: e8 3d 23 51 e1          call   0xffffffffe1512389
> 4c: 41 59                   pop    r9
> 4e: 41 51                   push   r9
> 50: e8 34 23 51 e1          call   0xffffffffe1512389
> 55: 41 59                   pop    r9
> 57: 31 c0                   xor    eax,eax
> 59: c9                      leave
> 5a: c3                      ret
>

Also pls share 'perf annotate' of JIT-ed asm.
I wonder where the hotspots are in the code.

