Return-Path: <bpf+bounces-71359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E098BEFE29
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 10:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5498E3E6AB8
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832A32EA489;
	Mon, 20 Oct 2025 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCY103Nr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6932641FB
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948340; cv=none; b=W4gXGOKhIS2BsVfE+oU9t7LoYLKa1uc1gVLPeFo4tMK7F0ifuVKsObcgLyYdqxFm87cJXbPAcvREz4MSse14zsg/jfoRWq4KTVzeph+RlVKXx0RvlMgRnGNfBkWs/TeZ30reiekuha7l1K0bArwtGmnEiW78qb4P3r8qH7/hZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948340; c=relaxed/simple;
	bh=2PmmRvYRajtIcis8ZZJraSCwJD0zMekDFskxTX4rFfc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX8S26lxDt2DXIV3kEOBphd4ByXpbyd2RSKkTPZYW6Tnwlhd7miyTsxiynMabyFZP6MsUlgxK+bEAmMfpCKQlUtjy/sdElMTmN/UVZStWl/iC3QUbwDydzDwroxcnS+cnd+ccVaoHaivk8S9GMoKirwscw0kIUbAhsiPBlFlAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCY103Nr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42420c7de22so1954627f8f.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 01:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760948337; x=1761553137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AKDB3bTSafSdFCWyt+djoXyXMdqdqsVLBv3IKr6ipus=;
        b=bCY103NrovGWzYHvLl5zJJI6oq0koe+h8jZ4g777zH9uBonHw1XZ13AeIvVJKBU+x3
         KP5hHG7+lssxYoe6hVqdmjwHk3MtRl9nUglk/Qfi9tRu/f+K+UFbYue19KQqWHEZW9lx
         pC3OvR3edvEUTBZuSVcTUWs572oEJhUS5WNBJKnukEOe5Wo3DCOb+MWhVRhs/iFhsN+b
         7ZSPBRxWmveRBQdeAIVbfPg7DQCsbZ5r90FBdu6qKgpA6UZVKHl+lPL1MflDFYHo+3fQ
         NW6B61VLEZKN42gXJvRgbp/6kV/ccfveYA79SvD9VT0CdyPoktp61u3WhzLqjiabIEd9
         m6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948337; x=1761553137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKDB3bTSafSdFCWyt+djoXyXMdqdqsVLBv3IKr6ipus=;
        b=eRyqLDhBtKkkFt6d4Rs4s5tlsYboxWbFs0/AMzKgBTFvJfERS0M8UUamhnQg0rkkIQ
         glFiy+jbmjhecGwfdQYP6snMlzWtqWR+oQ7UDv9k3R+XXbYG0arE0ehSSekVZ5OofaVk
         Fr7nRRbZedeIwJjCB10MYLRoG+ercAU7KbIMIJ6HKA+KpuVe3Saz3L0fY042ljPxQQWA
         OeI37r4c2Cpq+Nii7sXaB0BZd5070b27QYLEvPuu5I9gYuVjQyYfi3q0mVk7bCnT32sx
         vbUevnDTIKzxWVbL2MUcF5wIu4647wNjMWYmxEh8qye0xgSha7JHvt/g7pHZANZ/udHv
         SHUA==
X-Forwarded-Encrypted: i=1; AJvYcCXthjkBJav6ip/wHdO/bxnor+rguU8+oBVFI59a9bsOKNsxFznF1lp/bORZ7wq32M6grnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1CYWmxuG+uPZXM7n7TCYBxZzx3qjlapPxSaG351WFGAAZFYWw
	zWFO0GAePWQ5e2VZuh+y82t9BMPoVUG9r13+vTR9Hab0DAfHXS3KXq6S
X-Gm-Gg: ASbGncs5Fr22auXG7eHv76Y6DC+B/OvtafhyNQMqt9mi0b8SPYkGWlDYWlpkA1RRl8F
	CWwZ9CDJs4fGH89TbUjAf3Lta81heKyoEtCm8t/9vnLQHKZYhc+kF58ea+W4b8Wseiaer8DPrJB
	RyUySQsbreb514NJeAj5wyD8n+7WmnezkfNxky+rjSmGgfJM4k0Jc/520c5Avu1geZunhyv/y2B
	D6nT4fTqgOdA6/5RYHszsoC8VdSqS55uZxt2iuIL9D/thy0YFEfdABJRTla6uVjVVJcSllIlZyo
	debXozbAd6jGzv+3AgP14f00Bie4U5gHgbGVVgwcYQ+8eIYX8OtpyZRqFmA/4Kz0W72NnMonk61
	yzEiiAHszohHlIuqqJN5n4I6+2RQaQh4dpjwhogMvSAvMwhhl/b+NjuG3QTNr
X-Google-Smtp-Source: AGHT+IGcKsvs8EC9CVcjztRsgVVptFDcPyIrDjjr7wNCEk7lfeN5+5SrMh0QtnBC5ZQSI/xWIyuXMA==
X-Received: by 2002:a05:6000:2507:b0:427:370:20a3 with SMTP id ffacd0b85a97d-42704d96174mr9137492f8f.38.1760948336476;
        Mon, 20 Oct 2025 01:18:56 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3dabsm14612066f8f.16.2025.10.20.01.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:18:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 20 Oct 2025 10:18:53 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, mattbobrowski@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, leon.hwang@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 0/5] bpf: tracing session supporting
Message-ID: <aPXwbQgGOqAQfxbq@krava>
References: <20251018142124.783206-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018142124.783206-1-dongml2@chinatelecom.cn>

On Sat, Oct 18, 2025 at 10:21:19PM +0800, Menglong Dong wrote:
> Sometimes, we need to hook both the entry and exit of a function with
> TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> function, which is not convenient.
> 
> Therefore, we add a tracing session support for TRACING. Generally
> speaking, it's similar to kprobe session, which can hook both the entry
> and exit of a function with a single BPF program. Meanwhile, it can also
> control the execution of the fexit with the return value of the fentry.
> session cookie is not supported yet, and I'm not sure if it's necessary.

hi,
I think it'd be useful to have support for cookie, people that use kprobe
session because of multi attach, could easily migrate to trampolines once
we have fast multi attach for trampolines

jirka


> 
> For now, only x86_64 is supported. Other architectures will be supported
> later.
> 
> Menglong Dong (5):
>   bpf: add tracing session support
>   bpf: add kfunc bpf_tracing_is_exit for TRACE_SESSION
>   bpf,x86: add tracing session supporting for x86_64
>   libbpf: add support for tracing session
>   selftests/bpf: add testcases for tracing session
> 
>  arch/arm64/net/bpf_jit_comp.c                 |   3 +
>  arch/loongarch/net/bpf_jit.c                  |   3 +
>  arch/powerpc/net/bpf_jit_comp.c               |   3 +
>  arch/riscv/net/bpf_jit_comp64.c               |   3 +
>  arch/s390/net/bpf_jit_comp.c                  |   3 +
>  arch/x86/net/bpf_jit_comp.c                   | 115 ++++++++++-
>  include/linux/bpf.h                           |   1 +
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/btf.c                              |   2 +
>  kernel/bpf/syscall.c                          |   2 +
>  kernel/bpf/trampoline.c                       |   5 +-
>  kernel/bpf/verifier.c                         |  17 +-
>  kernel/trace/bpf_trace.c                      |  43 ++++-
>  net/bpf/test_run.c                            |   1 +
>  net/core/bpf_sk_storage.c                     |   1 +
>  tools/bpf/bpftool/common.c                    |   1 +
>  tools/include/uapi/linux/bpf.h                |   1 +
>  tools/lib/bpf/bpf.c                           |   2 +
>  tools/lib/bpf/libbpf.c                        |   3 +
>  .../selftests/bpf/prog_tests/fsession_test.c  | 132 +++++++++++++
>  .../selftests/bpf/progs/fsession_test.c       | 178 ++++++++++++++++++
>  21 files changed, 511 insertions(+), 9 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c
> 
> -- 
> 2.51.0
> 

