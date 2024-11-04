Return-Path: <bpf+bounces-43887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BFD9BB6A2
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 14:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE5D1C22427
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05F02AE77;
	Mon,  4 Nov 2024 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjjIyBEb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C013B5A1
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728094; cv=none; b=Dif3OUxYcqMvxv7N+8843jh+XJLsrZzJwmHnlU+ESIzE46VKccN7s11PppdWBoitRApALeUKy8nYdEItlNxNpGWVrI6QyWNqSyPjspqhhJgM00PWvlUE5Pg9C38KdceOyMyP7VhpvqdwWU1jJki+CxNiU+Jh5QsyHvPSYruupWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728094; c=relaxed/simple;
	bh=JYZSXBZTz0WIfkRwuO1XQYFFilb795Awi04eGagzzdQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irN8jvKL66wrJSTqd+EfvfLmOWa5hibAIx8hiR255L48/5viJ8e5YHXSTJcxvzSlDuc4KkFbbFaNpyFmiH+eFeS1HtJ/4F1TWcpsl0+uVEccyOaJYBzkM5NUMRMAaxHwm9r3bS0Wyao+Fs65kn38wvF37SOh+adGBW7lpiGm5Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjjIyBEb; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a68480164so670265666b.3
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 05:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730728091; x=1731332891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aW2ky+UhDaeVYVbcp+szPUh3BM8/2Lb7R20ikMVj1QA=;
        b=TjjIyBEbeVi0d9xSwbWmpMaJgzV05Hialbi3TrevJAV0PMErEh9Ji97gJqyEXm+5cA
         9em9o8uDZust68WLjaocZXf1adSSjF836sWS+u4tS21NBdZbWULvDFDWwf44R/MivjII
         rj8fS5SKNP8XM7oitvEY+dSFsRQFxW6GM6sLnpO2j+b33h5YawWgE4A2vD/CrNhjiyL+
         KLdYv3a/ogbKrmay3LyL80AFtuhUJ6cvY5tgZAHh9u1GvGyeIU7Lok2WJyFk9uxo8hhd
         0JkXQS2SADYl0AxbB64Q3SH3zeWrgF7ey1vff6jW3nRXBYhtqk2tCzF61YlU6YlLCFA4
         pD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730728091; x=1731332891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aW2ky+UhDaeVYVbcp+szPUh3BM8/2Lb7R20ikMVj1QA=;
        b=tkFlRfuYbtAsNdqQOCBootR9jPohZ1NW/BAQMp7jcK/tQshZa0e5jmCL7wLkK5InS8
         nEMCSh/VGa1M/reKWzDW3ifhA5mnA2gf7zFCCRFh4pDA1+oQd1/VPvYJh+nSUu/3pWRm
         +zpcnIgr8tBlZRzsySGE6GzOH2FWUGkGbxeXd9Ylzixy/CyIFxAX9t/xmaNcUT9ES7c9
         94hcFD+elJ3jV3WZG5RKeXqkEYhh8+kkB4UkxwFKAvlbVrgxl0KaMRD5YcZK2HLpceaZ
         mX4/b/VPLaqFUD334pijWD2iXhpSxcni2AKujpgzqbjfOWnfX+1RztSarq/OwHAcD17N
         OWvQ==
X-Gm-Message-State: AOJu0YzdEvM4RMbqMmzPCe8wifKnVRI39Irj48t2pTLIMZ4k8+d8HTbL
	MRI2y6ivSScbFspL/au5EY/5whoe8k/PU9xZr3V590pBavP058qw
X-Google-Smtp-Source: AGHT+IGQJLJbokzYe4Ay5ie2zBw37lmcafTOIFtVCRVr5bqmUdKOFN+qJsSC2BB0zoEYd7rlIHOqVw==
X-Received: by 2002:a17:906:478f:b0:a99:f56e:ce40 with SMTP id a640c23a62f3a-a9de6166952mr3136991266b.47.1730728090603;
        Mon, 04 Nov 2024 05:48:10 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5664d3fdsm556982466b.186.2024.11.04.05.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:48:10 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 4 Nov 2024 14:48:07 +0100
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <olsajiri@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
	kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 0/3] Handle possible NULL trusted raw_tp
 arguments
Message-ID: <ZyjQl6vRyJnjO6hy@krava>
References: <20241103184144.3765700-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103184144.3765700-1-memxor@gmail.com>

On Sun, Nov 03, 2024 at 10:41:41AM -0800, Kumar Kartikeya Dwivedi wrote:
> More context is available in [0], but the TLDR; is that the verifier
> incorrectly assumes that any raw tracepoint argument will always be
> non-NULL. This means that even when users correctly check possible NULL
> arguments, the verifier can remove the NULL check due to incorrect
> knowledge of the NULL-ness of the pointer. Secondly, kernel helpers or
> kfuncs taking these trusted tracepoint arguments incorrectly assume that
> all arguments will always be valid non-NULL.
> 
> In this set, we mark raw_tp arguments as PTR_MAYBE_NULL on top of
> PTR_TRUSTED, but special case their behavior when dereferencing them or
> pointer arithmetic over them is involved. When passing trusted args to
> helpers or kfuncs, raw_tp programs are permitted to pass possibly NULL
> pointers in such cases.
> 
> Any loads into such maybe NULL trusted PTR_TO_BTF_ID is promoted to a
> PROBE_MEM load to handle emanating page faults. The verifier will ensure
> NULL checks on such pointers are preserved and do not lead to dead code
> elimination.
> 
> This new behavior is not applied when ref_obj_id is non-zero, as those
> pointers do not belong to raw_tp arguments, but instead acquired
> objects.
> 
> Since helpers and kfuncs already require attention for PTR_TO_BTF_ID
> (non-trusted) pointers, we do not implement any protection for such
> cases in this patch set, and leave it as future work for an upcoming
> series.
> 
> A selftest is included with this patch set to verify the new behavior,
> and it crashes the kernel without the first patch.
> 
>  [0]: https://lore.kernel.org/bpf/CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com
> 
> Changelog:
> ----------
> v1 -> v2
> v1: https://lore.kernel.org/bpf/20241101000017.3424165-1-memxor@gmail.com
> 
>  * Add patch to clean up users of gettid (Andrii)
>  * Avoid nested blocks in sefltest (Andrii)
>  * Prevent code motion optimization in selftest using barrier()
> 
> Kumar Kartikeya Dwivedi (3):
>   bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
>   selftests/bpf: Clean up open-coded gettid syscall invocations
>   selftests/bpf: Add tests for raw_tp null handling

thanks a lot for fixing this! lgtm

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  include/linux/bpf.h                           |  6 ++
>  kernel/bpf/btf.c                              |  5 +-
>  kernel/bpf/verifier.c                         | 75 +++++++++++++++++--
>  .../selftests/bpf/benchs/bench_trigger.c      |  3 +-
>  .../bpf/bpf_testmod/bpf_testmod-events.h      |  8 ++
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 +
>  tools/testing/selftests/bpf/bpf_util.h        |  9 +++
>  .../bpf/map_tests/task_storage_map.c          |  3 +-
>  .../selftests/bpf/prog_tests/bpf_cookie.c     |  2 +-
>  .../selftests/bpf/prog_tests/bpf_iter.c       |  6 +-
>  .../bpf/prog_tests/cgrp_local_storage.c       | 10 +--
>  .../selftests/bpf/prog_tests/core_reloc.c     |  2 +-
>  .../selftests/bpf/prog_tests/linked_funcs.c   |  2 +-
>  .../bpf/prog_tests/ns_current_pid_tgid.c      |  2 +-
>  .../selftests/bpf/prog_tests/raw_tp_null.c    | 25 +++++++
>  .../selftests/bpf/prog_tests/rcu_read_lock.c  |  4 +-
>  .../bpf/prog_tests/task_local_storage.c       | 10 +--
>  .../bpf/prog_tests/uprobe_multi_test.c        |  2 +-
>  .../testing/selftests/bpf/progs/raw_tp_null.c | 32 ++++++++
>  .../bpf/progs/test_tp_btf_nullable.c          |  6 +-
>  20 files changed, 183 insertions(+), 31 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
>  create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null.c
> 
> 
> base-commit: e626a13f6fbb4697f8734333432dca577628d09a
> -- 
> 2.43.5
> 

