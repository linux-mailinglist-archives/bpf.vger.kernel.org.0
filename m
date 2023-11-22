Return-Path: <bpf+bounces-15717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CEB7F5490
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 00:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1185281677
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 23:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AC02134C;
	Wed, 22 Nov 2023 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIdfiplP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD4211F
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 15:29:55 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507bd644a96so358002e87.3
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 15:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700695793; x=1701300593; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIJ2qRH5oXdQyHDnetnRmxuN5Np+979cvwVqH6ESkjU=;
        b=IIdfiplPpjtaqxHb8iL9bpj4zcMr5yMCK86boUrI/KsszCnjeOJPBeCPK/c+f8MaaY
         koZPludJODvJwbbWG5z/9JqTSZKDE2b0ysoFOAJk+3MZG4e0W6l96t8taqNjnv6Y5g5q
         0Q7WTh0DkGI6tH5Gr9zPeiIBxqhfo9vzY0wKUVPTSMrzH2kelCT2zmCome2xUHNUVA3w
         Nqiyg4fNPT/AIgjLyBXi7OJrX0IbJWOztznWXaFV8VoaXNDJofj6e0VYe5jJyr/Qs9uA
         zdCrGObNpE93HSARzfN4yTE93niVSV/DBaNEPoWfeUDSEABn5z22qFkw40WAC2q/DFIV
         82pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700695793; x=1701300593;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jIJ2qRH5oXdQyHDnetnRmxuN5Np+979cvwVqH6ESkjU=;
        b=FgjZ0drjLlRnPlTjTsdiQjK2I924RqRr1ixEylX+hxFmSSrRAt1NWypVD4HKvIjqNP
         DVMpHwrtq7q9UMkrxTnA3yyPRU6nT78qtVCqeo2vQwFaYMxMXZIftr4n0spkGaKJuTwK
         1sawEXHB+zSOLIm6uiFUFRoLb40F7XirOSjoXufujpkIC0c9wi4wpFZaRkh6BJ83Dynm
         brwiXpqHm6mW5wTYcMWggEUVwr+hAIyl97CX7I2/zQFvFt0UjO/kSBtJpxcM1xiEvpsE
         q0VF+bWCIRNhM6wtd6KCriOqrGixRirFYk2QU31Kxc5KkVZOcyjPxxH0GEHOYvVvHYpk
         wjbA==
X-Gm-Message-State: AOJu0YwDJZZEATC5wvZYG7FLUurHWdyGKr2fFHJ/G+EmNImoLt/W7gBe
	XUqBT3rh3+wAInHmbRchKO0VMqe8wzU=
X-Google-Smtp-Source: AGHT+IHrEiOR7SXhEo+6Z2HyyID9aXIF+FuBuIsDmiiZcZWcU6Ddwb1pX4+LSTbyLps3nCbSYTq3SA==
X-Received: by 2002:a05:6512:3d0a:b0:50a:aa30:f9d7 with SMTP id d10-20020a0565123d0a00b0050aaa30f9d7mr3758075lfv.67.1700695793165;
        Wed, 22 Nov 2023 15:29:53 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id dw16-20020a0565122c9000b0050aab360f96sm2959lfb.164.2023.11.22.15.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 15:29:52 -0800 (PST)
Message-ID: <bb8b9193aa1cc32e76614c5edcee320f2a4c0594.camel@gmail.com>
Subject: [ANNOUNCEMENT] libbpf v1.3.0 release
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com
Date: Thu, 23 Nov 2023 01:29:50 +0200
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Libbpf v1.3.0 has been released ([0]).

It has been over 4 months since the release of libbpf v1.2.2, and a
significant number of new features are now available.
So it looks like a good time for a new release.

A big thank you to all the contributors that are constantly making
libbpf a better BPF loader library!

Please find the summary of libbpf v1.3.0 changes below.

## User space-side features and APIs

- support for `netfilter` programs is added:
  - `SEC("netfilter")` is now available
  - API function `bpf_program__attach_netfilter()` is now available
- support for `tcx` BPF programs is added:
  - the following new SEC definitions are now available:
    - `SEC("tc/egress")`
    - `SEC("tc/ingress")`
    - `SEC("tcx/egress")`
    - `SEC("tcx/ingress")`
  - the following SEC definitions are now considered legacy:
    - `SEC("tc")`
    - `SEC("action")`
    - `SEC("classifier")`
  - functions `bpf_prog_attach_opts()` and `bpf_prog_query_opts()` are
    extended to work with `tcx` programs, plus two new API functions
    are added:
    - `bpf_prog_detach_opts()`
    - `bpf_program__attach_tcx()`
- support for multi-uprobe programs is added:
  - the following new SEC definitions are now available:
    - `SEC("uprobe.multi")`
    - `SEC("uprobe.multi.s")`
    - `SEC("uretprobe.multi")`
    - `SEC("uretprobe.multi.s")`
  - plus a new API function:
    - `bpf_program__attach_uprobe_multi()`
- support for section `SEC("usdt.s")` is added for sleepable `usdt`
  programs;
- support for Unix domain socket cgroup BPF programs is added the
  following new SEC definitions are now available:
  - `SEC("cgroup/connect_unix")`
  - `SEC("cgroup/sendmsg_unix")`
  - `SEC("cgroup/recvmsg_unix")`
  - `SEC("cgroup/getpeername_unix")`
  - `SEC("cgroup/getsockname_unix")`
- new `LIBBPF_OPTS_RESET()` utility macro;
- new `bpf_object__unpin()` function to complement existing `bpf_object__pi=
n()`;
- new API functions for work with ring buffers:
  - `ring_buffer__ring()`
  - `ring__producer_pos()`
  - `ring__consumer_pos()`
  - `ring__avail_data_size()`
  - `ring__size()`
  - `ring__map_fd()`
  - `ring__consume()`
- `path_fd` support for `bpf_obj_pin()` and `bpf_obj_get()`;
- uprobe SEC matcher extended to allow golang symbols;
- uprobe support for symbols versioning;
- `bpf_map__set_value_size()` can now be used to resize memory mapped
  region for memory mapped maps;
- `struct bpf_xdp_query_opts` extended with `xdp_zc_max_segs` output field;
- basic BTF sanity check pass added to reject bogus BTF.

## BPF-side features and APIs

- triple-underscore flavors for kfunc relocation: like with CO-RE
  structs `___.*` suffix is ignored when kfunc relocations are
  resolved;
- `__percpu_kptr` macro definition in `bpf_helpers.h`;
- support for exception callbacks, use
  `__attribute__(btf_decl_tag("exception_callback:<func_name>"))`
  to specify exception callback for a program;

## Bug fixes

- fix for btf_dump__dump_type_data() when type contains bitfields;
- fix for correct work of offsetof() and container_of() macro with CO-RE;
- no longer attempt to load modules BTF when resolving CO-RE
  relocations if CAP_SYS_ADMIN are absent;
- regex based function search for "kprobe.multi/" programs no longer
  attempts to trace functions that cannot be traced;
- bpf_program__set_type() no longer resets sec_def if it is set to a
  custom fallback SEC handler;
- fix for memory leak possible after bpf_program__set_attach_target() call;

[0] https://github.com/libbpf/libbpf/releases/tag/v1.3.0
[1] Full Changelog: https://github.com/libbpf/libbpf/compare/v1.2.2...v1.3.=
0

Best regards,
Eduard


