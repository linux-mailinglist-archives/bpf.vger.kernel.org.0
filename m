Return-Path: <bpf+bounces-69436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C22B96843
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6F814E2E3E
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF812417D9;
	Tue, 23 Sep 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg9LFbF5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B21F199FAB
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640461; cv=none; b=UcQKjWqGuYZVB46V/Q82XEQ4Uc9FQy/HadbvpTrxoQqdXVwymjyuNpf3xrNykq23MHhFAd4pM1E7S2LaKf01ajun09ap7zuGoGKCuXlmLJ/rjSkCpy+o+1jXr+4XjA+tb5LLegJqXNONQt60LAHAaOcU99UxwR3r7AP+nRMFSZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640461; c=relaxed/simple;
	bh=stFaqEF0h3ItJGc6ApogJrrV1oAX1YZ9/xU9uSqRk1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtknrxhxwmRTn5qES3hsM0yb8nPn8Hdz/74EMpn+UxeeOJfXQ2g/CNI6uBNGywEiox88PE5TtxLtHQn2bw6NziKr3zwPA3NvfImrb+8MdXG4ZEh5s+ibn64zAJO8cogH/qApzfelUKgzH69Y+nswrNVW8QJnVbD0YDFVAcEuevQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg9LFbF5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso4715101f8f.0
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758640458; x=1759245258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPDOSH1yZDlp2aJw08ydobLFxn+b0bKb+eMc25vgi08=;
        b=Pg9LFbF57v0vyuI543XyZc1ldpLMauAa909fcfFbtAkmpNy6hBPIZmL3ihPPL2bKu9
         9Hhlgqb1dOlEYTtha0UhvCM7I3xUGqfchqLGhTPJzGxloXsFIiuG9fRSA/yBG49vdZH6
         uu95S4ufLkXykdmjEEObQLZUmgH23JouEEoMptts4GCqZd7m+Bkc7e8/aNlr/f8RzbaP
         2Y2LQxellWPBT5ElbgsFrXDWEVFk+2Jxvy54mTQh4r/ndl6oemvDx18uvhirIvJcO+OQ
         eGkKDyBNZsykvc0sv2HX+StCLyE//pPBOuANCWFGFJ9e3CsRUckVnWYlwWuNzYjo1fI9
         v3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758640458; x=1759245258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPDOSH1yZDlp2aJw08ydobLFxn+b0bKb+eMc25vgi08=;
        b=mxq1TY+rOD6pVKEypQl7rzjYlyD3D9dBW9fYXgXHGP32jZ231p8oNaW8RBzgww2Lkv
         47hIldOPsWhT91I70UB4hbI9iTxfx5+ZP4FYXcZX59wjHtqAvhzUYu31q7J/AWJRT0pv
         9D66qam/Jea1xpsEmN9wHAgivBihpI6ZcyWhciG91bdo2QwcktRYYNsxtZ1PEvCxxaIT
         l00zatXa/B+weh8sfQbhpkjS2Djppdo4lDdTQurqx27qRbJICliPy6f1t2Hj3m6S6azR
         j1dl+wm54Ke8d5SCPT1ejEt2Tg/bocK7O8cU+xgCAFoPGx7J7yZHuOWfD2sQLivU+zKI
         1l3g==
X-Gm-Message-State: AOJu0YyO2Nkh42dV7k/RoE/INdxanuPoprfvna3Ed9uxsZQBe9OzPIm9
	4Uuiv/YmAsJchhRltRNhiTRxwKIZHWjxSo/wrnVLFvos9xpG0Nz2YC2Cs7Xk9YveEoMkAPC0j6H
	V5Ji0dLGN/Segve5XHRx+FJ8pyfcbVas=
X-Gm-Gg: ASbGnctM6ePVORZOINaa4jmW8Zi53VA1V8zyzLOtEIF7KB5miVXLuU3xvbL+9XYjCxk
	N4mqL9Af5ZZU7WHW0J8NpsCFE/XJ2btJtx2L3UDmhDO7SxruZAkUr0BEOvyodjOTL0iQoI56aRD
	t3EcCCdmdzBrTtu4CYLN/82BB+O/5Qabnngl4ltXLxLVT+EN5XoTvyVtYmZZPykXM+ef0jFRxpN
	frK/Q0n5FJ/86PaAFSLwHrgALtGQRxPksRV
X-Google-Smtp-Source: AGHT+IFOYIJT4b6RkQLKzuLEgHJoAHkg/xqKWXQtkuFemniuNtQFwWN5BOz6NgHtU2ULTmU+m7TY8V3QDxBkRq2pMCQ=
X-Received: by 2002:a5d:5f92:0:b0:3e9:a1cb:ea93 with SMTP id
 ffacd0b85a97d-405c6d11915mr2280497f8f.21.1758640457807; Tue, 23 Sep 2025
 08:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
 <20250913193922.1910480-4-a.s.protopopov@gmail.com> <CAADnVQJsuxh5HrNKW_-_yuO5FqLQ8S4A4YN9bZfRHhO5pt5Dtg@mail.gmail.com>
 <aNEnLZzOyEuNOtXu@mail.gmail.com> <CAADnVQKK80Vvph7W7PSwG_GAPwXZO_wNYOKt6h9LHjHhPcjHPA@mail.gmail.com>
 <aNGJT6IosAI7HP+B@mail.gmail.com> <CAADnVQJ=qN+x9vTwU=yskvwoe7vAqe=c7U6nLaKmP1u+jn0s3w@mail.gmail.com>
 <aNJuqgX9ZvULVDS4@mail.gmail.com>
In-Reply-To: <aNJuqgX9ZvULVDS4@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Sep 2025 08:14:05 -0700
X-Gm-Features: AS18NWDDS42qGjCyCvHXPSlzkgRaX1dpbY9bfA35GTNmNH_SYni5GisNOS1Pqcs
Message-ID: <CAADnVQK5aPH7g+kz8ZzrhPSJc93qB500gh4bj9Zrr=eyOfqg9Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/13] bpf, x86: add new map type:
 instructions array
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 2:49=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> Are you ok with just this for 1:1 correspondance:
>
>     if (atomic64_fetch_add_unless(&insn_array->used, 1, 1))
>         return -EBUSY;

Like that, but more canonical form:

if (atomic_xchg(&insn_array->used, 1))
  return -EBUSY;

