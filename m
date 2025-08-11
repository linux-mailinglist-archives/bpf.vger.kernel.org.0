Return-Path: <bpf+bounces-65385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03FEB2167E
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 22:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29F23B25B3
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 20:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467BC2E2DD0;
	Mon, 11 Aug 2025 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv8vSond"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034DA296BC7
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944305; cv=none; b=bdNORd2bChETFcHpqVbYZm+dQ2NA/8WvzejKwHEVgzY3jeQ46MhR/YJVKpyRmCkoW8JN8e/Mm1w6mrckJbMw3NrGdSuhiClHMJB/YWykoje9O2+eLisDrijI9iFvr7MBb9lWa7piRyXT2925qbBoSTnlySOI3N34xbMXWUGcebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944305; c=relaxed/simple;
	bh=gEHofmYE6X7gr18uSqcXNBu5QO4KE1a4eKl9ZzpMHzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnqPluchkjunaL71LPuguowRoDJffmbJtpolq46HBT889qMJazPW2hQGbLisAeplNm5n3WZ4AjisnoAn6lzCzZ99Y8SsecTIeI10SlvO8/aAmiQ+tJAxnUSwdJk+AliWxQmd53j/Q5WAEVAz2xAwDqvHMajJqJo0kvVCR62N2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv8vSond; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso8679915a12.1
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754944302; x=1755549102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bx/i9KAH12hoM10NFfXeHg93IpzHJhhLePPzpJ4MFdE=;
        b=hv8vSondSFzb+dM+BsuOPBAp2uZvQqys9DbHtgoQcoMTE93tOVOyaeIGzHXrP9yvBd
         FYPVqH0KIFc4ekKX7uj2w8vqhop9pMPe+DCswtGwJVUIwU4Qc9vrEp78VXUswf956MtN
         ab0/RqMFyBXCfmv7a4trqO0msYBdi8a7OAbOPVTMDoWKZq6LACfcBunrP54AWKQTx5nN
         UYLWdfXccPda2Esjx09oxrMtwDUhencqwuFlKhaX2/1dwsCupEQLaTR9Dx0aCfiiVAB3
         da2PHOxXUfNL/rD0WE6skb/YFe2+dl8fQ8oDWuMN2bYSpXBL/MQfBdb6ztwx4WIQnhFy
         qP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754944302; x=1755549102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bx/i9KAH12hoM10NFfXeHg93IpzHJhhLePPzpJ4MFdE=;
        b=hwEjWOwY7jKt0mnXHFa7FEpemK7QlG/no7+n6xGU26NNfN4ltpyYp8ZzVOEtyGGTLj
         a2/h64VKkPnjRqQ8Gmpaw5/np/Gj6MM81W1dF6APpLwlhJpDqSizw9Pr++OtlXZjNgGV
         l+rYRDhhniDPC4hxkGX15K8JN5N3Drv4QDBBwE0moyC3IV9XFV618IWyjFGri8wqil7B
         6uxSCz69dmcu0fLGweF3ByBkqc3GHvg9aIA1aVai1J6tVddTU7WfNMOeVme/RqpMsVFg
         XabyGnt6Kx0eLjSDPP1DwH9DN3T7hRsIWDMopDgZYES7pH+MHjq9RnpZupS08Y9pEX7S
         yySQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVHsvDoMwnE/W9mheOblE0yrLIEV+RMekn5b+qRnfEM5aoSY3j9LTtm+pj+w9zCmrxtUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLPsplWs+MzsQ9GSIqeI1WPfL7BN1d1zXTpDxYOHeL9++pcVL
	LAI4/xKWt6Cdxmzziri/a0c2JWXBbHAQ8m/Yma4v5vV47Mk/sJGOqRJA+fyPCNwksnnXdgv6yai
	QEgnWVlJxa5iK2rB7zHTjFcpfjRD1jQw=
X-Gm-Gg: ASbGncuwWi6JwUB1kknegmr9zMmNPTw8thhgqWexjedGIWYq9u7VstLyMxZQCQv7A5f
	9B9lSePfHa404zIdKNSG4N97ByiXNrLIF/knDq65hGunhDa4A17oySinsooUcRjD08mKiWMo3MB
	H5qOIURjeDkNiq6v7O5yDMlukBdaNhjz6nabkJ/ToWu2+/lEPI16l9si8lOaK00e37VAH8BdR9p
	mCI630hQxZyb7sRWWm4kWHYp6yYA/eX/26wt/Xa
X-Google-Smtp-Source: AGHT+IH7UNQEf/oJ5cYgXubv1hclgwtIZlzZFYtjXDD8J18S1F/Et+W8VOEl7HQrkt4s30seUelvZsZPNzA10T+JlvE=
X-Received: by 2002:a17:907:9281:b0:af8:fa64:917f with SMTP id
 a640c23a62f3a-af9c650abc2mr1356253366b.48.1754944302202; Mon, 11 Aug 2025
 13:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806085847.18633-1-puranjay@kernel.org> <20250806085847.18633-4-puranjay@kernel.org>
 <34ce4521-6dac-4f78-a049-e6bc928cbd28@linux.dev> <mb61ph5yjgt77.fsf@kernel.org>
 <CAP01T75_WiqLmJE7x==wagJTMfg2BoZkv6otexA6FGm-=UFXew@mail.gmail.com> <mb61pjz3a16za.fsf@kernel.org>
In-Reply-To: <mb61pjz3a16za.fsf@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 11 Aug 2025 22:31:03 +0200
X-Gm-Features: Ac12FXziI-IKAoMaTeZ9E99VGVzoaBQpi-1RLAuq1OayhaLcLkNSlBkf0VIz5kQ
Message-ID: <CAP01T74MoYn1aFF7BPgymKv8M8VZP+kOfvf73uXzsWejB5pfSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add tests for arena fault reporting
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Aug 2025 at 12:35, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > On Thu, 7 Aug 2025 at 15:25, <puranjay@kernel.org> wrote:
> >>
> >> Yonghong Song <yonghong.song@linux.dev> writes:
> >>
> >> > On 8/6/25 1:58 AM, Puranjay Mohan wrote:
> >> >> Add selftests for testing the reporting of arena page faults through BPF
> >> >> streams. Two new bpf programs are added that read and write to an
> >> >> unmapped arena address and the fault reporting is verified in the
> >> >> userspace through streams.
> >> >>
> >> >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >> >> ---
> >> >>   .../testing/selftests/bpf/prog_tests/stream.c | 24 ++++++++++++
> >> >>   tools/testing/selftests/bpf/progs/stream.c    | 37 +++++++++++++++++++
> >> >>   2 files changed, 61 insertions(+)
> >> >>
> >> >> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
> >> >> index d9f0185dca61b..4bdde56de35b1 100644
> >> >> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
> >> >> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
> >> >> @@ -41,6 +41,22 @@ struct {
> >> >>              "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> >> >>              "|[ \t]+[^\n]+\n)*",
> >> >>      },
> >> >> +    {
> >> >> +            offsetof(struct stream, progs.stream_arena_read_fault),
> >> >> +            "ERROR: Arena READ access at unmapped address 0x.*\n"
> >> >> +            "CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> >> >> +            "Call trace:\n"
> >> >> +            "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> >> >> +            "|[ \t]+[^\n]+\n)*",
> >> >> +    },
> >> >> +    {
> >> >> +            offsetof(struct stream, progs.stream_arena_write_fault),
> >> >> +            "ERROR: Arena WRITE access at unmapped address 0x.*\n"
> >> >> +            "CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> >> >> +            "Call trace:\n"
> >> >> +            "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> >> >> +            "|[ \t]+[^\n]+\n)*",
> >> >> +    },
> >> >>   };
> >> >>
> >> >>   static int match_regex(const char *pattern, const char *string)
> >> >> @@ -85,6 +101,14 @@ void test_stream_errors(void)
> >> >>                      continue;
> >> >>              }
> >> >>   #endif
> >> >> +#if !defined(__x86_64__) && !defined(__aarch64__)
> >> >> +            ASSERT_TRUE(1, "Arena fault reporting unsupported, skip.");
> >> >> +            if (i == 2 || i == 3) {
> >> >> +                    ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
> >> >> +                    ASSERT_EQ(ret, 0, "stream read");
> >> >> +                    continue;
> >> >> +            }
> >> >> +#endif
> >> >>
> >> >>              ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof(buf), &ropts);
> >> >>              ASSERT_GT(ret, 0, "stream read");
> >> >> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
> >> >> index 35790897dc879..58ebff60cd96a 100644
> >> >> --- a/tools/testing/selftests/bpf/progs/stream.c
> >> >> +++ b/tools/testing/selftests/bpf/progs/stream.c
> >> >> @@ -1,10 +1,15 @@
> >> >>   // SPDX-License-Identifier: GPL-2.0
> >> >>   /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> >> >> +#define BPF_NO_KFUNC_PROTOTYPES
> >> >
> >> > Do we have to defineBPF_NO_KFUNC_PROTOTYPES in the above? Without the above, we do not need
> >> > below extern bpf_res_spin_lock and bpf_res_spin_unlock.
> >> >
> >>
> >> If we don't define BPF_NO_KFUNC_PROTOTYPES then there are build failures
> >> for bpf_arena_alloc/free_pages() because the prototypes in vmlinux.h
> >> lack __arena attribute.
> >
> > I would address this by dropping the alloc/free.
> > Instead to work around "addr_space_cast insn in program without arena error",
> > insert a dummy store "ptr = &arena" in the program, where ptr is a
> > global void *.
> >
>
> I want to use alloc/free and not use a dummy address because because
> arena pointers are special as they are returned by alloc() with
> arena->user_vm_start added to them, and the
> bpf_prog_report_arena_violation() also adds back arena->user_vm_start to
> the 32 bit address received by the fault handler. If I use a random
> address in the bpf program, bpf_prog_report_arena_violation() will print
> a bogus address.

That is easy to address, you can simply cast &arena to struct
bpf_arena * to get the user_vm_start.
Then just deref user_vm_start + 0xdeadbeef.
Then we also have a stable address we can match in the regex.
It will also fix your problem of needing the alloc/free pair in the
first place, i.e. the lack of an arena map reference in the program.
Then we can drop this BPF_NO_KFUNC_PROTOTYPES kludge.

As Eduard pointed out, newer pahole already emits address_space tags in
kfuncs, so the vmlinux.h suppression shouldn't be needed either way.



>
> So, I think we should keep using alloc/free for this test because we
> want to test this arena->user_vm_start addition as well.
>
> Thanks,
> Puranjay

