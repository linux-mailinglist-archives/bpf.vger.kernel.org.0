Return-Path: <bpf+bounces-21704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13B8850395
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 09:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4422B284FB3
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 08:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D64333CCF;
	Sat, 10 Feb 2024 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdozAs83"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9D33CE2
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707555295; cv=none; b=Ild6vwDDu4ENj2mzSBYzN4ZnzNyRDu+UJOBwdKWD32woHeGL51VM5Ev96ojFnKca5ScNziRb1qJ74xqHXNgMbqWkSXdHtmSTZ4+FG1iYASv6ixjMUCVpUJ9i+jZTODn3xZETnKJ0dJxSmN2nRyz8hJkW6FJa9SiRcmqRZY1N+qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707555295; c=relaxed/simple;
	bh=s49cPy0LCmuDBvHXBJhLB8Xj7iI8r0q48+ebyuL55Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MF6pPLSJ801bvWJSrGmYsiXljpIvLpPoWesGHmCOHoCec6E95ReKwD2Mqg9IyBxPcquqntx0CTHvWUFq1tVQCyWyNWsi2xjqtM9YX87spy1BLdPUJChqB9VcXV5R+ti/1TqQMl3ndxzDOGBV+bv4meOnxx1q95PjesLsZmT5pgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdozAs83; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a293f2280c7so239358066b.1
        for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 00:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707555293; x=1708160093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s49cPy0LCmuDBvHXBJhLB8Xj7iI8r0q48+ebyuL55Qs=;
        b=VdozAs83JbUSFw8xdTwv+kVzY7DnW7FXgG3vaBktXlS9RpGUM0MWfOn7M0nVeljdPr
         dXw1bFWS15XM2obLk8N5X+S4zBQEr5fReE9N0BSE4NWMeQXsCMqvoGt6XG5tSrmDMdil
         yLIR0Gosx50T4TaiiK/JsMyAF2dxgaQDiSSjjemToK7H+oD1gNIgi3THLMgVlEyAgGE6
         3/rENt/L/INCxIFCuNZlTkvyPA0R+IOiNq+C337/dqBG/l0a+fHpK+qUm/1nNMRxXX7S
         zv1YZUPBEwPwgeRJj5ADR/XnJDEZdsoPxKHLZrQXGgCweqaTnSq+zaBCFOgbH3o901gg
         JNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707555293; x=1708160093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s49cPy0LCmuDBvHXBJhLB8Xj7iI8r0q48+ebyuL55Qs=;
        b=VZeRt7mTN+KsvzBIfVsYAu/gnrfqXIvG6zL0+g6JjX/oNm+4mwlP/YGSnyxE9o9JT1
         WJm+EopAMj8lxjEp8lxK4G8PqDMJbALi5i8qzWVHuGVrk35KOMgsrZEv50wD50ebEZYZ
         8KdVV90fwLSY/ZMX4ZdZ89f42Wn9WCzTw+zWQNL8mBJIQGrXfQnHLcDjlZ9PRhZD8kHk
         /U0Vmg0Nm2aVMab4gjHZcFIDhok8xMlVmAQi0nTEH8kz4XE73C/z10jVHv02MuCSP+n5
         EszUc2SuAMvzzbtOjmIhorhL0OV1joAZIP5cD/aWgS/DLpS/8prMvsJh2/wmCS+uqhfu
         GTGg==
X-Gm-Message-State: AOJu0Yxcx5hRVu7OzI10PetW8JbH+etZ46JyUCrm/p2Yk8EZsySR4XNZ
	NKGBm9OEeoIU8z/rlDKo5GEVqj6YVdA34sYQHi0XHApSxPPr53tjaJ5ZLzsk9EMzgEVUnaQ8Ou1
	UYpcW5mWJ5IJG0uviVMRYjvGOgkZ/Bnve1Dzc5A==
X-Google-Smtp-Source: AGHT+IEqZsutruTPSbrmyTuFvuuVDWI7DATdcQyJXYCBSkQkGt6FxEBJyp5WjAJa20K7Bh/nKaIkGSRSpDmwSk+6OqU=
X-Received: by 2002:a17:907:20a8:b0:a3b:f72d:9c2b with SMTP id
 pw8-20020a17090720a800b00a3bf72d9c2bmr1127834ejb.39.1707555292695; Sat, 10
 Feb 2024 00:54:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-17-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-17-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 10 Feb 2024 09:54:16 +0100
Message-ID: <CAP01T743Mzfi9+2yMjB5+m2jpBLvij_tLyLFptkOpCekUn=soA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 16/20] bpf: Add helper macro bpf_arena_cast()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, tj@kernel.org, brho@google.com, hannes@cmpxchg.org, 
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 05:07, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce helper macro bpf_arena_cast() that emits:
> rX = rX
> instruction with off = BPF_ARENA_CAST_KERN or off = BPF_ARENA_CAST_USER
> and encodes address_space into imm32.
>
> It's useful with older LLVM that doesn't emit this insn automatically.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

But could this simply be added to libbpf along with bpf_cast_user and
bpf_cast_kern? I believe since LLVM and the verifier support the new
cast instructions, they are unlikely to disappear any time soon. It
would probably also make it easier to use elsewhere (e.g. sched-ext)
without having to copy them.

I plan on doing the same eventually with assert macros too.

