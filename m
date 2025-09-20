Return-Path: <bpf+bounces-69116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A802B8D212
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 00:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59B71B24490
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 22:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8413F215767;
	Sat, 20 Sep 2025 22:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPKPsY/n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BED235061
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758408779; cv=none; b=dCtZ/cyVyzI9xaL05pPYpbOCoQUDJ84Y7156MwXRAgy4d561lYsa0U8aSi1SpynMmCmIQmaSuAj6IENnkW+3cd295/worDZikqRkJgn+uHcHjK/BaU7UX3fCprHKv81zlrHoRaRvkIFqgksxdxWln0fqB7RTHzvfTmCz4Umz0xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758408779; c=relaxed/simple;
	bh=reRTPtQAthwKgObWVo/Wt0ddLr+Qh0DZVwsxBR0bSLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQ4SNVcM92LM/XnLFYtx474TE6KzL3JuFSBBWkfdhoYvWxBhz3qbu62MZ64mI9wJSMh1TIZ0s9hm89Y1bSB6rc4t0m88ljfCFtKU5K/7za1mQi6KM75iYU2+VIMvcyBRCzjMRUvAIwjfygMNtReJC/XxycwrxAuA/IOvDt5SIU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPKPsY/n; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f29dd8490so31476915e9.1
        for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 15:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758408775; x=1759013575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hByHjzKVFlJ0hb3OVZFwDdFdJhvtPj02pfKFEGVjQAs=;
        b=WPKPsY/n5edgdYfVGUGMst8ivwQi0VNCoR5s2ZTBLOHcqe7SVcVLE0DL8/k3fBdVUz
         2Ruv9qdkUp4jkJqmLvwSvXJ4v3FkEjQLXj4AzRONpk4tL5J4IVBdekOs/mdytvpa3TnC
         ru1KwklGQ1/6qTcGDABDCva2VG4ZVnGqNKmOTCGQZj+DIBXTU+9kwr4w64Pet/Q7jiDd
         84LHAApNpZaJe4dnSO2DuyQgThYHBLQ0Jbz2FP//JKKi2Ke9G7ohwQVBeCEGrJkTVvkw
         eCAPWWku/5xR8FXAv2nnAnn9JI+h2y35Yhk0Rutn9LfmHU8qkpTEBWFi1SGH298qwK5f
         oQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758408775; x=1759013575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hByHjzKVFlJ0hb3OVZFwDdFdJhvtPj02pfKFEGVjQAs=;
        b=o/QEachssJQmnnUwfIqBibz8tumxFWNOJ2x3WbVXHL79TrjYSuxHVf0jJ7sjCOUslE
         QVgQX5npM3J3z/S6f7H/6mJsLsndSiuX/MmgZGwQTIWv5Ffi/ZpIkK/FYrajx0i58IzK
         NwD+INLysIaM9r1aiczpmcLs468idJmEqy/p8ZJIdrgd5KQi1KRX4g4Wp5ByoGoOQ26M
         zaFZxniCwqM3wVUyDOW7eLdx6K+AEDfKFB8FaoA1KzJ9S+j7eLmY9CEXaGZlfnrco8m6
         7q5S3qLl3AVJoayxfVlgskq5as9BeQ9fasIJpPCCWBDCbtNU90yuZ6Z4TNX6U2g3uFKf
         Lyhw==
X-Gm-Message-State: AOJu0YwCPRaMVslKuyREEe6ota6ZPSPGMiAsO3yM5qfozhuM6OvGOQkU
	BRqboABSL25+Vn4nxF32mFpapIB2jFAIISgjkOp3QLb7hLnYl9MmJ9tHDbXjaG59LzUGnu/71l1
	JPyQzGTijT0kJmYEm9ic1XmuJ9Dgsmd+PrPny
X-Gm-Gg: ASbGnct9eWdYsrNrMVcLsWfURKdp1i04cLGLCddpoEZozACdgpCcKE1ZICXWzhZ5foW
	Ipqj4uUfEhMnOihTtyKMnktzP7Rkb08HrpQizUQgkl2z2+db2I6/x0oxVel+ujOgkPsWka8kXW1
	Jx0iLWMaat6Hzj/w0CJifXu+UyxjAgaEg4sLUWPJgpaC3PWOBMcw4jpYeRUdKndyeS8OLJ/GsUC
	AIHzaRNzAX3aD9RIlP1Ln1ZtqX3rB/TOb5R
X-Google-Smtp-Source: AGHT+IHxYfSsFOhzw0vU20ruiUegchSn8CkejnJy7G11FbedB01NLKaZOgG6RbjBNWcvTtL00xjEBS4gte4zjcCzPZc=
X-Received: by 2002:a05:6000:2509:b0:3e8:e52:31c5 with SMTP id
 ffacd0b85a97d-3ee7c5542d1mr7400885f8f.2.1758408775427; Sat, 20 Sep 2025
 15:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920045805.3288551-1-yonghong.song@linux.dev>
In-Reply-To: <20250920045805.3288551-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 20 Sep 2025 15:52:44 -0700
X-Gm-Features: AS18NWBbL1RmYfGTjRJVlz-sntSqSDs_m9pdWOug9U2A7wiLQZE7YRTDUj-FO3A
Message-ID: <CAADnVQL=vMa0a2zRtbaH64ft4ipTTBaM4tLeiAF9J6sVqUha0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix selftest verifier_arena_large failure
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 9:58=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> With latest llvm22, I got the following verification failure:
>
>   ...
>   ; int big_alloc2(void *ctx) @ verifier_arena_large.c:207
>   0: (b4) w6 =3D 1                        ; R6_w=3D1
>   ...
>   ; if (err) @ verifier_arena_large.c:233
>   53: (56) if w6 !=3D 0x0 goto pc+62      ; R6=3D0
>   54: (b7) r7 =3D -4                      ; R7_w=3D-4
>   55: (18) r8 =3D 0x7f4000000000          ; R8_w=3Dscalar()
>   57: (bf) r9 =3D addr_space_cast(r8, 0, 1)       ; R8_w=3Dscalar() R9_w=
=3Darena
>   58: (b4) w6 =3D 5                       ; R6_w=3D5
>   ; pg =3D page[i]; @ verifier_arena_large.c:238
>   59: (bf) r1 =3D r7                      ; R1_w=3D-4 R7_w=3D-4
>   60: (07) r1 +=3D 4                      ; R1_w=3D0
>   61: (79) r2 =3D *(u64 *)(r9 +0)         ; R2_w=3Dscalar() R9_w=3Darena
>   ; if (*pg !=3D i) @ verifier_arena_large.c:239
>   62: (bf) r3 =3D addr_space_cast(r2, 0, 1)       ; R2_w=3Dscalar() R3_w=
=3Darena
>   63: (71) r3 =3D *(u8 *)(r3 +0)          ; R3_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D(0x0; 0xff))
>   64: (5d) if r1 !=3D r3 goto pc+51       ; R1_w=3D0 R3_w=3D0
>   ; bpf_arena_free_pages(&arena, (void __arena *)pg, 2); @ verifier_arena=
_large.c:241
>   65: (18) r1 =3D 0xff11000114548000      ; R1_w=3Dmap_ptr(map=3Darena,ks=
=3D0,vs=3D0)
>   67: (b4) w3 =3D 2                       ; R3_w=3D2
>   68: (85) call bpf_arena_free_pages#72675      ;
>   69: (b7) r1 =3D 0                       ; R1_w=3D0
>   ; page[i + 1] =3D NULL; @ verifier_arena_large.c:243
>   70: (7b) *(u64 *)(r8 +8) =3D r1
>   R8 invalid mem access 'scalar'
>   processed 61 insns (limit 1000000) max_states_per_insn 0 total_states 6=
 peak_states 6 mark_read 2
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   #489/5   verifier_arena_large/big_alloc2:FAIL
>
> The main reason is that 'r8' in insn '70' is not an arena pointer.
> Further debugging at llvm side shows that llvm commit ([1]) caused
> the failure. For the original code:
>   page[i] =3D NULL;
>   page[i + 1] =3D NULL;
> the llvm transformed it to something like below at source level:
>   __builtin_memset(&page[i], 0, 16)
> Such transformation prevents llvm BPFCheckAndAdjustIR pass from
> generating proper addr_space_cast insns ([2]).
>
> Adding support in llvm BPFCheckAndAdjustIR pass should work, but
> not sure that such a pattern exists or not in real applications.
> At the same time, simply adding a memory barrier between two 'page'
> assignment can fix the issue.
>
>   [1] https://github.com/llvm/llvm-project/pull/155415

Applied, but this is a serious issue.
We were hoping that arena will be immune from llvm doing pointless
"optimization" all the time and breaking the verifier.
Looks like it's not.
Let's fix BPFCheckAndAdjustIR or improve handling of
__builtin_memset for arena asap.

