Return-Path: <bpf+bounces-63450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4DDB07AAB
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1915F1C24261
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 16:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8212F531B;
	Wed, 16 Jul 2025 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVBokedQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E4D1A238C
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682000; cv=none; b=ACKRnXQuyl0M8jGf1RmK1nRKfs+WsZK/ZzWZpbqgYPrM1T55pREP14QLhcBCGuBF6TvFUahPk/a7KqSIWL2G7xdM6eoaYnflCtskyGgnQ5/lPbXsdx8+LR5vLODRdmzbeA+HuJFB9bp+E4zkzhg009oaoE3ZFM9edBkz7zyw69I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682000; c=relaxed/simple;
	bh=r/lQeczghwBEU0SLq3yUnEllAxwJfhqJQD/1N7LajNE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kEQq7QZZnlo8nUlY6ZxOtiqIXyxUis61ZuC/g5UkCHJdkgKbq/zYBu88Op5iN/7Dy1FQMH4DW4ZCwUxBaMCv/F5wqZH9A1UpcwhwN4ahhruEzPiKzmBI4FwrfF+KK8021hQ3MO73hrhicCOea/T3TAb7LIWzFrIrbvCZ/MuJkUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVBokedQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so10409278a12.0
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752681983; x=1753286783; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4LZsJgE+6ewne7tJqziQlWxpX8SYNAsuZCXk9BK6MM0=;
        b=mVBokedQ6uDj1D9JNGzsyHLZc1tJLWZiuxrJWyiul/W+OTrXo7AC5T6BRT/gMpxtcD
         Xk/UutoBnBfUsfwKJmfjk1vJ3YBVe26VDB4CuqObqj/iUIZynr7uZ2iwCMrMlqMcV9W9
         9ypZPVZ5/LoTuVu/FcRPkvPxrKWobZqgTAOcjvT2nIIZlSz3O/v+Wg3ovfA3pJZucmjd
         HCSl59eqzylF4oKhCjQW1QxdIIM5NNlYjk+wFdlM/7iOLa8Q/7uZMJjniWUbRXq0zXhu
         Mo5JZo9m22+ieXnEdc2ZO7U/0HaMrRHjXvFc+9icTHA0piRwwJqQPeMYvEiroxbuURl2
         4CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752681983; x=1753286783;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4LZsJgE+6ewne7tJqziQlWxpX8SYNAsuZCXk9BK6MM0=;
        b=CpkgDeJxsD3as+3UcH1+lUQopR6CpIymtiCDg1OSdOVtZYuT1k9ELs5Xp6Ax04QWbS
         JTlaesxOJPFCGOVX8HhQ8IFyHYpuMgw3byfssc3ogQUV58LBpMD+59lOUcI+/bHJ9aFY
         0uc8DCIgixBX7MSERL+/k7thoee8apUSqGIWc3eKnjKTNyS70F55/BMjFj0No+nSh2B+
         uquvKx3ycdOXKQ7Sz3b5lTPJSTftbVlgJBsMeftqhWDCW7vdiE95ENRUQRAS/8NjTVbZ
         jB2VU8s9rgfzcfjUS1L7QEY85HAQQy5rwHXFSLkcVggLMeipKC8954A+8Sl6JkU9GMEt
         wj5g==
X-Gm-Message-State: AOJu0Yy7ARe7MkVzLuiB6sVfNbsVZweDM0jWe3H1S5ah8UMO2w67cbQ1
	5pkmP5sBN+8F3KAgFyGJZ/SQRCziH3gZuN41uGCyPrx5IcILGhTKaYneVf3YRfc+lXStL5EbuVQ
	HX4whkDZwGBlH2T45TJvo6U65vgXFjeHtnxH0
X-Gm-Gg: ASbGnctv2CnmfjJ3Tg2mElGAQJGjni5dHYXS+Ne7P7V4IrtfWy/etqn8aIUDXnZSjn0
	hlQdFjQsTakQxW6GXEIUD78te/MHjFh+3XGw/rp57zQfrsnzK+DB61nMxF1gyb1SQjpwNZdWNfq
	V4SQCLag/3N435JMJC5lhBuT5YbHjhWrlk1L1picLWudgHrJ4jBFPvBslL4fIOyJk1w+yv7uXjC
	zt4Dw==
X-Google-Smtp-Source: AGHT+IF6mFrThxdGk0kyL4JXEf5lwu7e5mKUbAxGH7DJVUBSgvl6bkBmx49BkcYuInosa1HSDi6CQraVo/ss5M8F5A4=
X-Received: by 2002:a17:907:1b09:b0:adb:23e0:9297 with SMTP id
 a640c23a62f3a-ae9cddf1040mr338107666b.17.1752681983119; Wed, 16 Jul 2025
 09:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Jul 2025 09:05:59 -0700
X-Gm-Features: Ac12FXw8-f_s-URuqZaDxZXjZ-HQrG3atR_ityf277vPrA26NcjrJ2RiW6tMn1M
Message-ID: <CAEf4BzZpsp6+yt_LybndxMBuy+qsjvzhyfT1a=TqPnjZ6tm1_A@mail.gmail.com>
Subject: [ANNOUNCEMENT] libbpf v1.6.0 release
To: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Libbpf v1.6.0 was just released ([0]). See the summary of features
below, as well as the link ([1]) to a full set of commits that went
into the fresh release. If you find anything wrong with the release,
please let us know ASAP, thank you!

Thanks a lot to all the contributors for making libbpf a better,
mature, powerful, and flexible library at the heart of the BPF
ecosystem!


## User space-side features

- add more control over BPF object lifetime with new preparation step
(`bpf_object__prepare()` API);
- libbpf will report symbolic error code (e.g., "-EINVAL") in addition
to human-readable error description;
- `bpf_prog_stream_read()` API;
- BPF token support when attaching BPF trampoline-based BPF programs
in `bpf_program__set_attach_target()`;
- BPF token support for `BPF_BTF_GET_FD_BY_ID` command;
- support multi-uprobe session (`SEC("uprobe.session")`) BPF programs;
- support `unique_match` option for multi-kprobe attachment;
- support creating and destroying qdisk with `BPF_TC_QDISC` flag;
- `bpf_program__attach_cgroup_opts()` which enables more precise
cgroup-based attachment ordering;
- libbpf will automatically take advantage of memory-mappable kernel
BTF (`/sys/kernel/btf/vmlinux`), if supported;
- `emit_strings` option for BTF dumper API, improving string-like data printing;
- add BPF program's func and line info accessors
(`bpf_program__{func,line}_info[_cnt]()` APIs);
- BPF linker supports linking ELF object files coming from memory
buffer and referenced by FD, in addition to file path-based APIs;
- small improvements to BTF dedup to handle rare quirky corner cases
produces by some compilers;


## BPF-side features

- `likely()` and `unlikely()` convenience macros;
- `__arg_untrusted` annotation for BPF global subprog arguments;
- `bpf_stream_printk()` macro for working with BPF streams;
- `bpf_usdt_arg_size()` API;


## Bug fixes

As usual, a bunch of bug fixes were landed, see full commit log for details.


  [0] https://github.com/libbpf/libbpf/releases/tag/v1.6.0
  [1] Changelog: https://github.com/libbpf/libbpf/compare/v1.5.0...v1.6.0

-- Andrii

