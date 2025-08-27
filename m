Return-Path: <bpf+bounces-66749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC30B38F62
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 01:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CB136809A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 23:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123B93101A9;
	Wed, 27 Aug 2025 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m42/UaVE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EAC1DB127
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756338620; cv=none; b=VL6ldkWXjJcPMBTNS/W4drON8Wu4fEQ9IHcU/U++iGIRMhwQZJ05EqCho2LcYjUQLDFFrO//AwIf4AQigJ3dmsbn9Hn5jTbfsD1imr4EUKJYi8s46AomCCnw28NsQhIBeNEX6sXGcyg1CENXir768D+KQoV8sBjxFge8ZBeJ3so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756338620; c=relaxed/simple;
	bh=l2whlIqqADX/4KgqhK+dm2Y8xYrcC+lUTCjMz3QKpKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZ/o9S8Wb2kcvMDeEhg8Sja7imhG1uUCUEvVvcIK0TRgANyfOSPdVHbTgNpkfc6DGRMct+ScB/5IWUp+jPOOOKRHq8OriEmINixdl84RYJ4ACQDARRp4IjXoJ97gvjI8OAoZUQ+ptEPr5+fIZJGJD1qnXicrcZmm/gKeKB1ayr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m42/UaVE; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-afe6fe7c89bso229151866b.0
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 16:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756338617; x=1756943417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N/uok6UQ7aIzUIXHrTrAmBxMRs7hRhERWiipZtezGig=;
        b=m42/UaVEXyfQw8x1bxoMLx4PaHDX/SjqctwecUYnDWgVtmqorQ55zgGzOmVvzgW1sN
         XcMIjlXb0fzOb1Vx5qsKthwR6iW/8WgaX8f/ZqJYG9odC7spXnJtc+6Hi2dmLdHtbujC
         Kbn6MWGoR4SpVq05AMNyn7oaWAB1m+EGtA1A7180irnHE+evmZD5zYyFHgJ4tYNRfarC
         eOKFhBpzv2ao+mud8iuOTfurte42dCfMdEkUgxgb+EU2ZwuK5R6Dvcdm1OFfY0WADV9Y
         yPr/Zv5oThLffK4q0ikSzL8vum2Nvu8XK2MFIF7J56pEeTcjX9VauWzzXsKMC5g9F/hL
         /CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756338617; x=1756943417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/uok6UQ7aIzUIXHrTrAmBxMRs7hRhERWiipZtezGig=;
        b=ipmrBy3HJrTi0jEWIVF9KetRDrkrATbwabZduoVWuR/WpVIKwjgkhEhpI6jvX2t3AW
         a1E/63kEXCgOIRIPI17Tt4aSdqdZB4CroXAi1J5JeFrsshwMdhhPgpAz4WTN+COS80yN
         NgDRsZ6bSLS6uykrh09lveaIUNBdA06+DgDrRzjDBNj2k90UHpMT0i28otOFyOGIB8cn
         7HRgaCCQaFXRZwd5zKZ80/skdXBliUgae44vl7mGuGvAkigzD0qgIIr1ON8/ZCFSCztb
         Ss+JaW3jUVsClAqs6mFA0fq3Y2YShpemVvwbeHR9lLpdlAqYDOIzmpL43J2o7H/rLst9
         3INg==
X-Forwarded-Encrypted: i=1; AJvYcCXcq6LK3q12mrjZ3JcQ7QzP9AyAFrEDqXmV1YcmpUYEU4sH6zxhqfLUhyfPdOn7VtfNliI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+shR0uM8pT76Q5RPXcf0lgU9GYfYJtr9/ry37y3NEx5O6qmPA
	AX5m/KLp6gzR6kozjqTnVpTX9f7YuSedHrqkqZiyR8oeLeu+SqC9yvoF84nacpkDRFugxof4qqz
	2Gh/MRMwGmvtGIvieqQvJfCJRm8Q8VuA=
X-Gm-Gg: ASbGncvP4Z9zLYsKRajWiOYL04pJQuEsXAiver1jtkkAliubPuHDcx0gazJoUFdNCd6
	Gf++X+Ly396yNme0EMWnEXTQNMBAsAdertkRpjofsp0u/XxVgHojf/7oTVdPxFamW1XwiRuelAQ
	qL0xiqbORcCp6TCDwXBkBLP3I43iNahz2JIFWRdry2L/uQGUPfXMpJ1OpCoIXJGv9EcZceRVX1C
	LZOLfu3D3c5V0QYxSHTELKro880Wp+6yJSEhgLs+Y9msiNWU8ieU8yPQiDJCA==
X-Google-Smtp-Source: AGHT+IGJYRWHQCIQTgxXXWdxs8/65pGpjs2aOZms52f0b4KjrwCWior5rBPR8qWiwHEzzLlPWHGLaPmiiv/uxXcS9Ss=
X-Received: by 2002:a17:906:f582:b0:ad2:e08:e9e2 with SMTP id
 a640c23a62f3a-afeafec9809mr655765266b.27.1756338616846; Wed, 27 Aug 2025
 16:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827153728.28115-1-puranjay@kernel.org> <20250827153728.28115-4-puranjay@kernel.org>
 <543975dd-6173-455d-a1a0-aca7806c2b31@linux.dev>
In-Reply-To: <543975dd-6173-455d-a1a0-aca7806c2b31@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Aug 2025 01:49:40 +0200
X-Gm-Features: Ac12FXxEO7y8KNePWZX-ymlBc0FNpqSTEY3XeEqDmgT5-A5J6FBx-61VdCjBaCw
Message-ID: <CAP01T74ER-zYGwewD3fHKXEfGAOXHq_QKpTEXnE9RQTFgc3LOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Add tests for arena fault reporting
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 21:55, Yonghong Song <yonghong.song@linux.dev> wrote:
>
>
>
> On 8/27/25 8:37 AM, Puranjay Mohan wrote:
> > Add selftests for testing the reporting of arena page faults through BPF
> > streams. Two new bpf programs are added that read and write to an
> > unmapped arena address and the fault reporting is verified in the
> > userspace through streams.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >   .../testing/selftests/bpf/prog_tests/stream.c | 33 +++++++++++++++-
> >   tools/testing/selftests/bpf/progs/stream.c    | 39 +++++++++++++++++++
> >   2 files changed, 71 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
> > index 36a1a1ebde692..8fdc83260ea14 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/stream.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
> > @@ -41,6 +41,22 @@ struct {
> >               "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> >               "|[ \t]+[^\n]+\n)*",
> >       },
> > +     {
> > +             offsetof(struct stream, progs.stream_arena_read_fault),
> > +             "ERROR: Arena READ access at unmapped address 0x.*\n"
> > +             "CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> > +             "Call trace:\n"
> > +             "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> > +             "|[ \t]+[^\n]+\n)*",
> > +     },
> > +     {
> > +             offsetof(struct stream, progs.stream_arena_write_fault),
> > +             "ERROR: Arena WRITE access at unmapped address 0x.*\n"
> > +             "CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> > +             "Call trace:\n"
> > +             "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> > +             "|[ \t]+[^\n]+\n)*",
> > +     },
> >   };
> >
> >   static int match_regex(const char *pattern, const char *string)
> > @@ -63,6 +79,7 @@ void test_stream_errors(void)
> >       struct stream *skel;
> >       int ret, prog_fd;
> >       char buf[1024];
> > +     char fault_addr[64] = {0};
>
> You can replace '{0}' to '{}' so the whole array will be initialized.
>
> >
> >       skel = stream__open_and_load();
> >       if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
> > @@ -85,6 +102,14 @@ void test_stream_errors(void)
> >                       continue;
> >               }
> >   #endif
> > +#if !defined(__x86_64__) && !defined(__aarch64__)
> > +             ASSERT_TRUE(1, "Arena fault reporting unsupported, skip.");
> > +             if (i == 2 || i == 3) {
> > +                     ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
> > +                     ASSERT_EQ(ret, 0, "stream read");
> > +                     continue;
> > +             }
> > +#endif
> >
> >               ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof(buf), &ropts);
> >               ASSERT_GT(ret, 0, "stream read");
> > @@ -92,8 +117,14 @@ void test_stream_errors(void)
> >               buf[ret] = '\0';
> >
> >               ret = match_regex(stream_error_arr[i].errstr, buf);
> > -             if (!ASSERT_TRUE(ret == 1, "regex match"))
> > +             if (ret && (i == 2 || i == 3)) {
> > +                     sprintf(fault_addr, "0x%lx", skel->bss->fault_addr);
> > +                     ret = match_regex(fault_addr, buf);
> > +             }
> > +             if (!ASSERT_TRUE(ret == 1, "regex match")) {
> >                       fprintf(stderr, "Output from stream:\n%s\n", buf);
> > +                     fprintf(stderr, "Fault Addr: 0x%lx\n", skel->bss->fault_addr);
>
> This will fault addr even for i == 0 or i == 1 and those address may be confusing
> for test 0/1.
>
> > +             }
> >       }
> >
> >       stream__destroy(skel);
> > diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
> > index 35790897dc879..9de015ac3ced5 100644
> > --- a/tools/testing/selftests/bpf/progs/stream.c
> > +++ b/tools/testing/selftests/bpf/progs/stream.c
> > @@ -5,6 +5,7 @@
> >   #include <bpf/bpf_helpers.h>
> >   #include "bpf_misc.h"
> >   #include "bpf_experimental.h"
> > +#include "bpf_arena_common.h"
> >
> >   struct arr_elem {
> >       struct bpf_res_spin_lock lock;
> > @@ -17,10 +18,17 @@ struct {
> >       __type(value, struct arr_elem);
> >   } arrmap SEC(".maps");
> >
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_ARENA);
> > +     __uint(map_flags, BPF_F_MMAPABLE);
> > +     __uint(max_entries, 1); /* number of pages */
> > +} arena SEC(".maps");
> > +
> >   #define ENOSPC 28
> >   #define _STR "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
> >
> >   int size;
> > +u64 fault_addr;
> >
> >   SEC("syscall")
> >   __success __retval(0)
> > @@ -76,4 +84,35 @@ int stream_syscall(void *ctx)
> >       return 0;
> >   }
> >
> > +SEC("syscall")
> > +__success __retval(0)
> > +int stream_arena_write_fault(void *ctx)
> > +{
> > +     struct bpf_arena *ptr = (void *)&arena;
> > +     u64 user_vm_start;
> > +
> > +     barrier_var(ptr);
>
> Do we need this barrier_var()? I tried llvm20 and it works fine without the
> above barrier_var().

Puranjay should add some context in the commit log or comments for
this, but I think the reason was that we found that GCC would diagnose
accesses into ptr assuming it points into the actual typeof(arena)
object defined in the C file (which is the right thing to do from a
language standpoint), but that obviously leads to misdiagnosis once we
access something in struct bpf_arena that goes out of bounds for this
type. So laundering the pointer through barrier_var gets rid of the
provenance information and the warning/error is gone.

But it would be better to add a comment since it's not obvious why.

>
> > +     user_vm_start =  ptr->user_vm_start;
> > +
>
> Remove this line.
>
> > +     fault_addr = user_vm_start + 0xbeef;
> > +     *(u32 __arena *)(user_vm_start + 0xbeef) = 1;
>
> Simplify to *(u32 __arena *)fault = 1;
>
> > +
>
> Remove this line.
>
> > +     return 0;
> > +}
> > +
> > +SEC("syscall")
> > +__success __retval(0)
> > +int stream_arena_read_fault(void *ctx)
> > +{
> > +     struct bpf_arena *ptr = (void *)&arena;
> > +     u64 user_vm_start;
> > +
> > +     barrier_var(ptr);
>
> Is this necessary?
>
> > +     user_vm_start =  ptr->user_vm_start;
> > +
>
> Remove this line.
>
> > +     fault_addr = user_vm_start + 0xbeef;
> > +
>
> Remove this line.
>
> > +     return *(u32 __arena *)(user_vm_start + 0xbeef);
>
> return*(u32 __arena *)fault_addr.
>
> > +}
> > +
> >   char _license[] SEC("license") = "GPL";
>

