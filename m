Return-Path: <bpf+bounces-43401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6185E9B517D
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 19:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E836F283E39
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 18:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42D1DC068;
	Tue, 29 Oct 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hePpxqTf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55738BEA
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224820; cv=none; b=HqR40/VtzSGsJnm9Oh7rzXHAgoxT5u3SFV9A8ZteKQKpYKxMO79joRhJ7aVqUGMX8AYDOc8J/SSxBq9bn1WAb0DihcVdQbmQ8gueSTOdqibwEa/P9bO1Fk0BD0Tfj+0ZO1thxW9GlcK7agpyKaUGrR53dMYwgIGXJk+Yig/cgUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224820; c=relaxed/simple;
	bh=JJ2QzGK2SmX1Xay+klYrJbWqtLdf/7rgCWX1MIBjODk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Lrx1En1DFezApToq9oULIy2Ea2vhxCgZsvJFpkFwrPh8II/VIEcsp+7VgQjfyX4D22HNo/cJEZnkRwh0bLrlKoxY2+DSFg5DHmbYNt+LA1ZjSWKkfEBRgInv+csZy/r2Q7wb9SqHMzmd+Z1k8rVgWGgtkG0uujAbwPWcJBy9eW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hePpxqTf; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so4853634a12.0
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730224817; x=1730829617; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tx2LwBUUzV68X4R8AjvQ+LNS4UkzmEZA1sJtxLQ4Iuw=;
        b=hePpxqTf+2S7fztZHUcWXgxvav3tZ3U2wlBIH/42yLOJtNiW3ywqK+gRKRiaRKWF31
         mEkh7TvBqDExTI53JbwxnkBKLecoi4TkqK6qxhZqhEi7sEJiRMc1maBg6g/Ip0G5Te2L
         LsHjVrsKW/kXtzRxe6kCHbqiAZNArjYXqHvhFFbpgiX04L6HaxVGevjoLezMe7lHZeH6
         pvCLLTOdaiEuOAZ/vBpO20XKN1cEuDInM5JiOKRTkJSoZBGDFzYWiEej0R0qMp+BfY8R
         lERRHVxYVq0K9ovREyA1iTldh4z1RfsDce8uHhhYIkfzl5+ejakcsN+zciyX5Eizf4Je
         hxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730224817; x=1730829617;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tx2LwBUUzV68X4R8AjvQ+LNS4UkzmEZA1sJtxLQ4Iuw=;
        b=dY8EVJ1TCbZRWNcgBxTQw+IpPOX/9Z9lsc1rRDcsCKK3T0HAhyClnSvW73adSaJlgZ
         mWw4K1NUeJJlKFdEAEfhzoVd3+xRF7kogXvzqFYpl1Be1pc92PizJ+S0mdUKMotixT8M
         Nfn6JKjlgxRDHdc9EW6SQydaPPvl7LATax1lhP5AGM6KHBBEYB2LmQqr44XJHiiFUC7x
         uOst4NPXswdhtRT55th20YDzLwV7HXB0wc7E/IKxbwd/lUY6YfjWisJBQM7DFmrlzDGJ
         J/X4VajxqwP5XjteEwhV6f+BGrcLJzFVEg5O/D9yfKD66A53emgaSc095/In8CKnNCSu
         lvfQ==
X-Gm-Message-State: AOJu0Yw61qX+tPQyICphFQVzAR9XTc0cNDrZ2OowjlBcFGopvMN0mnZ3
	nWal3cGOv44+LwZh/hvFzRWI7cLK2HzHdhcyI9KI0kxZepqYCZm9xRH3drmxwWFCadatIkosdK+
	IuJmdK1DGtfKf1omw6LYdGR+b+Qbd4vds
X-Google-Smtp-Source: AGHT+IHVlo/vSavWQkYyz05GLF9BkN/GpCROTFAWeD/Sho/nFHyxwUVeXBPh+vwgWphVGA2m/P14EONWZ27a5biPKic=
X-Received: by 2002:a05:6a20:e605:b0:1d9:2994:ca2b with SMTP id
 adf61e73a8af0-1d9a83d627fmr17831850637.19.1730224817072; Tue, 29 Oct 2024
 11:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 29 Oct 2024 11:00:04 -0700
Message-ID: <CAEf4BzbNMDKpnv_Zdg6+OfnW8VAP_af8MyuOWPJPSb7jOzaa9Q@mail.gmail.com>
Subject: [ANNOUNCEMENT] libbpf v1.5.0 release
To: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Libbpf v1.5.0 has been released ([0]).

It's been almost 7 months (!) since the last release, so we can say
that v1.5 is a nicely aged release by now. As you can see below from
the release notes, there aren't all that many new features and APIs in
libbpf, which I take as a good sign of libbpf's maturity. A big part
of v1.5 is actually addressing various bugs and usability
shortcomings, and generally rounding up the overall user experience.
All of this is important and these improvements are driven by various
real-world production use cases. See the detailed changelog for
yourself, below.

Thanks to everyone contributing fixes, features, code reviews, as well
as feature requests and bug reports!

## User space-side features and APIs
- libbpf can now open (but not load!) BPF objects of non-native
endianness, enabling cross-architecture support for BPF skeleton
generation and BPF object introspection;
- BPF skeleton will now auto-attach `SEC(".struct_ops")` maps as part
of `<skeleton>__attach()` call;
- BPF kprobe session programs support (`SEC("kprobe.session")`);
- allow specifying kernel module name for fentry/fexit BPF programs
(`SEC(fentry/module:function`);
- libbpf recognizes `LIBBPF_LOG_LEVEL` environment variable, which can
be used to set default log verboseness;
- BPF ringbuf APIs that limit maximum number of consumed records at a
time (`ring_buffer__consume_n()`, `ring__consume_n()`);
- distilled BTF support (`btf__distill_base()`, `btf__relocate()`);
- BPF link-based attachment of `BPF_PROG_TYPE_SOCKMAP` programs
(`bpf_program__attach_sockmap()`);
- `bpf_object__token_fd()` API to fetch BPF token FD of a BPF object, if any;

## BPF-side features and APIs
- fixes for fetching syscall arguments on arm64, s390x, risc-v architectures;
- better GCC-BPF source code compatibility;
- `__bpf_fastcall` support for a few BPF helpers;
- `__uptr` annotation definition added to `bpf/bpf_helpers.h` API header;

## Bug fixes
- fixes and improvements around handling missing and nulled out
`struct_ops` programs;
- fixed `mmap()`-ing logic for global data, fixing interop between
generic `bpf_object__open()` APIs and BPF subskeletons;
- BPF skeleton backwards compatibility handling fixes;
- handle LTO-produced `*.llvm.<hash>` symbols better;
- feature detection fixes in the presence of BPF token inside user namespace;
- older kernels have broken PID filtering logic for multi-uprobes,
libbpf now detects this and avoids the use of multi-uprobes for USDTs;
- fix accidental drop of `FD_CLOEXEC` flag during BPF map reuse;
- few BTF dumper formatting fixes;
- a few more small fixes all around.

  [0] https://github.com/libbpf/libbpf/releases/tag/v1.5.0
  [1] Full Changelog: https://github.com/libbpf/libbpf/compare/v1.4.0...v1.5.0

-- Andrii

