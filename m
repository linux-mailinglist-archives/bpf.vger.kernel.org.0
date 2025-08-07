Return-Path: <bpf+bounces-65208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F6AB1DABF
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 17:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D345C722E52
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36974268C63;
	Thu,  7 Aug 2025 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn2Exjmg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F291A0703
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754580346; cv=none; b=YBXL6s70D9LzigwP+LY3Pl4KtYBHcZXIK51FQFrkplf7Ras7HI3koOIeiLz6uc2oGXyCgX6CG14AoHflM+xpc/cYt9OG5WFKZxydAi48MtSpFMeFOeF5dAn2horo9WReL3/dt2V1agB87/Dtzcvy0eUP/JFradQz59Ya+manHiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754580346; c=relaxed/simple;
	bh=2ZNXeKBG5wK/DOxV4YkFtrbGl7slcpqwiz3m8CQUiW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnpMucpjd8BDgj4tpKdu4gZgshVIBpPVquwAKw9zrk0d79HRtTpH/PUyecbMyZxXPMSaCl4J7vX57IT4kM/LGHW5WoAN7PFtqduKxIHCcePQzUQNOzqXNreA40oUPPH2tRuBfuxHP1miR42Zctq3n1UZ84FckJy8XV+rzejFv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dn2Exjmg; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-af96524c5a9so156063066b.1
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 08:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754580343; x=1755185143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jQE/Vm8G7h5vgOazZpC2DAlmIptgUyHNNb/fFhJkpfc=;
        b=Dn2ExjmgOuM+MudIM2AozgAh58zyusryG6yU6Fcu6JUXBdL3Ink8AqX1732Ats/EhH
         GV+Dryxy2FZXQoP+pB7UAp/h2WM8f0ZbP/kP1FmzST+mXvrK1DymdxR+mPd9wB5h+H5N
         2VBsYgkdRV8ucWf2XxoAv4cKYDS5we+hpdYWo+6guoCUCliRR+Ot+P3L5a1cEdgdYeke
         CgASaUJY1G/oBoKBdw+PDo19LEPM7RrnOi0P+JJE9oZ8BgbT9v4mMnYM4YUqlcwpo0KI
         qGsP1cEh8FEEX07cEOtTeRQXNKOalK1jBFVExJ3YtTqEaWrqskjzREQGiXb5qQ1qBefu
         Ps4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754580343; x=1755185143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQE/Vm8G7h5vgOazZpC2DAlmIptgUyHNNb/fFhJkpfc=;
        b=eczteQ3WUcg8Dvu2kdnnEKKnPtC4TCzj1X3gjCtV4u+4SdOaTn+1Jh33HrnTuZ9a7l
         1bqmN31VzD6SxATfxm7dDcFq7tyTqdb9o4hx9YYO3sCrAjgMkK3ffsxvlU2TfrIA9DV6
         XxY9HbOtuwcW22fwTWp1rJns5b+mPkrA0uQ9OxMdJ64WAzJDN6t02PcOxQgjjHSDHHqy
         EHqf/0DUCQYq4A5dVy/49bKwreCEQh4oLKnnV5j870viv+t4HadkhhNA7n45nNdcZ/Lj
         /yK08lPcDc1mhMYn8qe0CZqRC+oiU4YZfUfr/XlYmuR7GkVGj29CZzhNzH+BFDzUX66L
         SztQ==
X-Forwarded-Encrypted: i=1; AJvYcCURbrrYzSL9T2PKX3mzP0u3JLxpTYSh+v/9nn56V23tYuR2TYg13O6y9xfbiMO8+YOLw7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhYJo2ZS8XkJ9lzMT/UzMXahxk0vxKtMwipHOaeIqgrhXvJPMD
	3RAAjJt7xJfHHlR2NCoEo7FzdJpXkBg2p+nDnXNRmnAZ7d6kEhZ49cBkj3nZF5NlgupVMY57z81
	tFALSFg+6VVuYYocY2l1uqy3ZSJCXkxg=
X-Gm-Gg: ASbGncvOKyXMUwvX/6o/vH3NOz5omYQloCTB9FPLSs3BqaXYntd/53QuSaJGuVxAiQb
	opHMUfloXboc0hatMG3TBCN4DI1bBIpXFcb0MeN++yaRH/UI6e1chWxA0OE3A7ZYgqLc0H3ihrQ
	tZ1vP2f54K4UgfjhyQ2ZoaCnP5RTBkQlf6NfrD67KIvQjFcJ/g6HzyTQ1C9jwJ/+8IAx/gpaOsE
	UICYl03vvjUGPYee3e1tU3NW+fAF2mpMJv5vsBQLD9X0AzrTb4=
X-Google-Smtp-Source: AGHT+IFp6bh5+SVsMy644xK1kbYwIc8+CtyTwwStoV9L2DYdpnYue0KGHkgq68wFKRFzxGlHo1eFTqbrkEFV1nKap0M=
X-Received: by 2002:a17:906:c14f:b0:ad8:ae51:d16 with SMTP id
 a640c23a62f3a-af992c3e9aamr658692766b.55.1754580342989; Thu, 07 Aug 2025
 08:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806085847.18633-1-puranjay@kernel.org> <20250806085847.18633-4-puranjay@kernel.org>
 <34ce4521-6dac-4f78-a049-e6bc928cbd28@linux.dev> <mb61ph5yjgt77.fsf@kernel.org>
In-Reply-To: <mb61ph5yjgt77.fsf@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 7 Aug 2025 17:25:06 +0200
X-Gm-Features: Ac12FXzzcDLboiWx96j5IeIzd4Raw63E38KXjoiwwUKXQIV2P78jt0zbfLQl16I
Message-ID: <CAP01T75_WiqLmJE7x==wagJTMfg2BoZkv6otexA6FGm-=UFXew@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add tests for arena fault reporting
To: puranjay@kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Aug 2025 at 15:25, <puranjay@kernel.org> wrote:
>
> Yonghong Song <yonghong.song@linux.dev> writes:
>
> > On 8/6/25 1:58 AM, Puranjay Mohan wrote:
> >> Add selftests for testing the reporting of arena page faults through BPF
> >> streams. Two new bpf programs are added that read and write to an
> >> unmapped arena address and the fault reporting is verified in the
> >> userspace through streams.
> >>
> >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >> ---
> >>   .../testing/selftests/bpf/prog_tests/stream.c | 24 ++++++++++++
> >>   tools/testing/selftests/bpf/progs/stream.c    | 37 +++++++++++++++++++
> >>   2 files changed, 61 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
> >> index d9f0185dca61b..4bdde56de35b1 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
> >> @@ -41,6 +41,22 @@ struct {
> >>              "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> >>              "|[ \t]+[^\n]+\n)*",
> >>      },
> >> +    {
> >> +            offsetof(struct stream, progs.stream_arena_read_fault),
> >> +            "ERROR: Arena READ access at unmapped address 0x.*\n"
> >> +            "CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> >> +            "Call trace:\n"
> >> +            "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> >> +            "|[ \t]+[^\n]+\n)*",
> >> +    },
> >> +    {
> >> +            offsetof(struct stream, progs.stream_arena_write_fault),
> >> +            "ERROR: Arena WRITE access at unmapped address 0x.*\n"
> >> +            "CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> >> +            "Call trace:\n"
> >> +            "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> >> +            "|[ \t]+[^\n]+\n)*",
> >> +    },
> >>   };
> >>
> >>   static int match_regex(const char *pattern, const char *string)
> >> @@ -85,6 +101,14 @@ void test_stream_errors(void)
> >>                      continue;
> >>              }
> >>   #endif
> >> +#if !defined(__x86_64__) && !defined(__aarch64__)
> >> +            ASSERT_TRUE(1, "Arena fault reporting unsupported, skip.");
> >> +            if (i == 2 || i == 3) {
> >> +                    ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
> >> +                    ASSERT_EQ(ret, 0, "stream read");
> >> +                    continue;
> >> +            }
> >> +#endif
> >>
> >>              ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof(buf), &ropts);
> >>              ASSERT_GT(ret, 0, "stream read");
> >> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
> >> index 35790897dc879..58ebff60cd96a 100644
> >> --- a/tools/testing/selftests/bpf/progs/stream.c
> >> +++ b/tools/testing/selftests/bpf/progs/stream.c
> >> @@ -1,10 +1,15 @@
> >>   // SPDX-License-Identifier: GPL-2.0
> >>   /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> >> +#define BPF_NO_KFUNC_PROTOTYPES
> >
> > Do we have to defineBPF_NO_KFUNC_PROTOTYPES in the above? Without the above, we do not need
> > below extern bpf_res_spin_lock and bpf_res_spin_unlock.
> >
>
> If we don't define BPF_NO_KFUNC_PROTOTYPES then there are build failures
> for bpf_arena_alloc/free_pages() because the prototypes in vmlinux.h
> lack __arena attribute.

I would address this by dropping the alloc/free.
Instead to work around "addr_space_cast insn in program without arena error",
insert a dummy store "ptr = &arena" in the program, where ptr is a
global void *.

>
> >> +
> >> +    page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> >> +    bpf_arena_free_pages(&arena, page, 1);
> >> +
>
> Thanks,
> Puranjay

