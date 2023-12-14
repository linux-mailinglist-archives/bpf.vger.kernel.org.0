Return-Path: <bpf+bounces-17752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D3981240C
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 473B7B21211
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA6263D;
	Thu, 14 Dec 2023 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfbmiWQG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E12A3
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 16:45:35 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-28ae571b2edso915132a91.3
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 16:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702514734; x=1703119534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nu5N8uc3QjNEMbFWg3EKf3LO9vaoexnnB4OtDwbkG6I=;
        b=mfbmiWQGFLTmH8ibQSf17G738iBjpXAulN5yu3Jn0Bs9IkUUBU5/ShVkD06GcrXhaY
         /mpB5jUzfhORPYMSO+frHyh8cX50jYJOMf8NADkGByF5E+09cTuMNH6H8sSf/yqns6+V
         rcH8fdsEWZLnoG1MJEUd6cd6b0+gYGLRSJL5bN7Vq2coJEnZfzkNjRrJJ4RrOX1Oo+Rb
         3ZrRDGJ0IUNJ2UutCYEwEz3RlfwzkBagOHSLUBqvE5/pDQT8mpfQw6UL1ZqbgkAKDhv2
         R0drdT6YzyyPGEsimfmPI9hXeL8lmpbovyUq6Kmwbk2Ubcz86LhANDhKn0PUC2Qc45rc
         /jjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702514734; x=1703119534;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nu5N8uc3QjNEMbFWg3EKf3LO9vaoexnnB4OtDwbkG6I=;
        b=HiB7TKbiVzXfDHOSdLUfLVlXEKkBW1z2vUf53w8iMo0woxcuFOK70DlEP3MtJSoATD
         3PirRYFsOithA7s/ij3h3IvVs7ZaAIXX53mg/bqQMispj5E0eZTeMielyN2gMxhjR3Zl
         +N42caImfCSHz7gNq2JI0znqAIOmX1vPuVq0LnHDkkoMlduRn+y9ePxRik+ViP2aYeg+
         InDKBqARFFBhP5UlpcTMQT+W5eU6/rx+IEih1CJRpZ8AlI7nHTDKyk79juOexDMbp8Ly
         GxZcCqX6amB+YR480IP+cmWek3aeLNYShtQwA6CTysqCYhlSTNOIVGCwYyggXAGIQfbb
         /cIA==
X-Gm-Message-State: AOJu0YwDckZa5ZipVFHtswFXvhAh0DY7+igZ26Kz0QEahZhIsHTIqjUt
	T+eJoe4E0IJFUrf/8BpCuPaUzfQYJiqYog==
X-Google-Smtp-Source: AGHT+IFaV0HcZbkMKhw3yLQwCWOA5iRjrY6VbWbqP6pgeW0uG5ZQIWLt3Zgv/E3RwNlTFsJkCM6vsg==
X-Received: by 2002:a17:90b:3d89:b0:286:6cc1:8653 with SMTP id pq9-20020a17090b3d8900b002866cc18653mr4797734pjb.56.1702514734492;
        Wed, 13 Dec 2023 16:45:34 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001d0969c5b68sm11136451plk.139.2023.12.13.16.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 16:45:33 -0800 (PST)
Date: Wed, 13 Dec 2023 16:45:32 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: andrii@kernel.org, 
 kernel-team@meta.com
Message-ID: <657a502ca6c3f_4415620819@john.notmuch>
In-Reply-To: <20231213190842.3844987-1-andrii@kernel.org>
References: <20231213190842.3844987-1-andrii@kernel.org>
Subject: RE: [PATCH v3 bpf-next 00/10] BPF token support in libbpf's BPF
 object
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> Add fuller support for BPF token in high-level BPF object APIs. This is the
> most frequently used way to work with BPF using libbpf, so supporting BPF
> token there is critical.
> 
> Patch #1 is improving kernel-side BPF_TOKEN_CREATE behavior by rejecting to
> create "empty" BPF token with no delegation. This seems like saner behavior
> which also makes libbpf's caching better overall. If we ever want to create
> BPF token with no delegate_xxx options set on BPF FS, we can use a new flag to
> enable that.
> 
> Patches #2-#5 refactor libbpf internals, mostly feature detection code, to
> prepare it from BPF token FD.
> 
> Patch #6 adds options to pass BPF token into BPF object open options. It also
> adds implicit BPF token creation logic to BPF object load step, even without
> any explicit involvement of the user. If the environment is setup properly,
> BPF token will be created transparently and used implicitly. This allows for
> all existing application to gain BPF token support by just linking with
> latest version of libbpf library. No source code modifications are required.
> All that under assumption that privileged container management agent properly
> set up default BPF FS instance at /sys/bpf/fs to allow BPF token creation.
> 
> Patches #7-#8 adds more selftests, validating BPF object APIs work as expected
> under unprivileged user namespaced conditions in the presence of BPF token.
> 
> Patch #9 extends libbpf with LIBBPF_BPF_TOKEN_PATH envvar knowledge, which can
> be used to override custom BPF FS location used for implicit BPF token
> creation logic without needing to adjust application code. This allows admins
> or container managers to mount BPF token-enabled BPF FS at non-standard
> location without the need to coordinate with applications.
> LIBBPF_BPF_TOKEN_PATH can also be used to disable BPF token implicit creation
> by setting it to an empty value. Patch #10 tests this new envvar functionality.
> 
> v2->v3:
>   - move some stray feature cache refactorings into patch #4 (Alexei);
>   - add LIBBPF_BPF_TOKEN_PATH envvar support (Alexei);

We can do same thing from golang ebpf lib when we get around to adding it.
Looks good to me.

I see its merged but, Ack for me.

> v1->v2:
>   - remove minor code redundancies (Eduard, John);
>   - add acks and rebase.
> 
> Andrii Nakryiko (10):
>   bpf: fail BPF_TOKEN_CREATE if no delegation option was set on BPF FS
>   libbpf: split feature detectors definitions from cached results
>   libbpf: further decouple feature checking logic from bpf_object
>   libbpf: move feature detection code into its own file
>   libbpf: wire up token_fd into feature probing logic
>   libbpf: wire up BPF token support at BPF object level
>   selftests/bpf: add BPF object loading tests with explicit token
>     passing
>   selftests/bpf: add tests for BPF object load with implicit token
>   libbpf: support BPF token path setting through LIBBPF_BPF_TOKEN_PATH
>     envvar
>   selftests/bpf: add tests for LIBBPF_BPF_TOKEN_PATH envvar
> 
>  kernel/bpf/token.c                            |  10 +-
>  tools/lib/bpf/Build                           |   2 +-
>  tools/lib/bpf/bpf.c                           |   9 +-
>  tools/lib/bpf/btf.c                           |   7 +-
>  tools/lib/bpf/elf.c                           |   2 -
>  tools/lib/bpf/features.c                      | 478 +++++++++++++++
>  tools/lib/bpf/libbpf.c                        | 573 ++++--------------
>  tools/lib/bpf/libbpf.h                        |  37 +-
>  tools/lib/bpf/libbpf_internal.h               |  36 +-
>  tools/lib/bpf/libbpf_probes.c                 |   8 +-
>  tools/lib/bpf/str_error.h                     |   3 +
>  .../testing/selftests/bpf/prog_tests/token.c  | 347 +++++++++++
>  tools/testing/selftests/bpf/progs/priv_map.c  |  13 +
>  tools/testing/selftests/bpf/progs/priv_prog.c |  13 +
>  14 files changed, 1065 insertions(+), 473 deletions(-)
>  create mode 100644 tools/lib/bpf/features.c
>  create mode 100644 tools/testing/selftests/bpf/progs/priv_map.c
>  create mode 100644 tools/testing/selftests/bpf/progs/priv_prog.c
> 
> -- 
> 2.34.1
> 
> 



