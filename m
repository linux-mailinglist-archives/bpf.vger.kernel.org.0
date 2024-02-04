Return-Path: <bpf+bounces-21155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C10848F2A
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 17:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988FF28326B
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3AD22EE3;
	Sun,  4 Feb 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="HFTATYX1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B722374B
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063080; cv=none; b=qRlMJoNJfOk62yMTNrdYtwvn3AaVBvfz4b2IDDG0PBMAyBMcoTLywqGj773kMiyldyP4JV9GLA0KhgXrohvPed9FqwfULcTUfwSEbwAaJ/IfL8U/4xEM9RnqJ095fAoppBMDTwY43kJ1AoObpSuKDu/kWsVcKMBl8kxEXvkr5rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063080; c=relaxed/simple;
	bh=e5tU7PwjEwvJlL497kXpwtw19jqAMKLMwL64dnUJkVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcEiQejw1Wl5pyzEwGJ0H5lL86EaDSN51RpeN44wIgb6T3RZPqb05tNTF8IWMzCu2Vs/shEix1sjCeC9GIVudk7P6hxtX6sLZY32ipZNArIL/0IHgH4GnWFHIza+KHklMnuuYPxUeviBjWdS6Eb42k0sg7ZighGK0QEiAd3bVrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=HFTATYX1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fd72f721dso4553645e9.0
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 08:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1707063076; x=1707667876; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rq1Zm8tTDwMXABK+2Xyio8qd9VgVr/quyXQBu9z2ULE=;
        b=HFTATYX1zQICP1xpmV71fPPlUcJpZN/OozLstUgOrHs/iAJNea0cOnYGtxJnxJXC5b
         ajE8hR/9Rjo8Nq/MRWl4qo3VrrKhyZWi0At8NcrlovQS18txL3jEyTb6R3W4NO1JL9O6
         DpDdntqUBtVVrEzlkMo8ajyF/oy1tplXZ/6QvoLoTJydowIN/B1pjBqmYroLAfjPf0Ih
         J4m0J7tiT7WQp96TV9d+htyBRGzP3xDkzQqNle6R9l5AmefAV6aPMLp8mwAKwqX6AQNx
         s2fs+WBE31twSRd3rw4IOvLF2owfYUAlYZjae0R1Lep8EnAqfmPQN3ii19UoeiKdPCHC
         iIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707063076; x=1707667876;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rq1Zm8tTDwMXABK+2Xyio8qd9VgVr/quyXQBu9z2ULE=;
        b=NhTkaM/qAee7oGpC3+ANGLM1SvYN6FdwoULEz1jb9iNs9vTxNSpebfVOoKljgAhTOb
         eGyxa3HDZY+Ac9m10QycJlZc4e/d8ZCIDER7rSOG/963ssy97qfjLaKyTGcFZbXj1c+q
         8RhrR8SLzAf6HHzeX4i4X7Oo4m6xYvoeNUSHIFrgRsbKBRxkQO/Im/MKcGfyRCBRAH+5
         dKzmN+Yx/IUEVHS2OQjvy5nUchWGKJ4xVSZTYiKowiDVPp2rh4T4z9eVcMRYT5jUevyw
         mM3RpGtmeUpj02rjlujXHvXrFUW+vkimMQWu0Jv79q5AOlL4Hmutg3WVszYxpcR8AqxJ
         Pr7w==
X-Gm-Message-State: AOJu0YxwBWnKt1OGewXVLh/9tnozsejXm5W2CHyMjA3QfvJvQ0Xp1Zue
	OwobXT5+8YPiC3OFAgTNM1E5qjiNWbbM3rTqSOYw07bwP2SRDMyrLe/DAbSvo60=
X-Google-Smtp-Source: AGHT+IEv5AddRQ+jbW+8d71FM6RKhIQbmlN07TGnqwBlm01DIknEtRrFIaMZ1rAXNoHMtyZCNdE27Q==
X-Received: by 2002:a05:600c:a03:b0:40e:a255:8f53 with SMTP id z3-20020a05600c0a0300b0040ea2558f53mr3098368wmp.13.1707063076231;
        Sun, 04 Feb 2024 08:11:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUI7mR6yyNOEMsl6FyF1sFzfkh+K8mjXfJis25uKUochigKvs754d9CUMgy/kw9qzVju+/kSi6abzT79f664RG2SWrs0HxP4LM2aS8ZQknLUlOUy/o5Dd5xHV+RVauRGE2GjWRiAlmoA7UC4bxslazKzFMa0OOlU1n4PMpCNi6POM8nAozJBRJl8FOoHOF3FTnBOSeOEO76XKRKq6/DTqldNERqg//vG/Tmcx02yVJgY2WDquYXbqfT1OVVz7KP3N2kZW9h/2uWn5W+GQX7RnLYaQLbDOHKnWIlurKpPPLQQYyGprKuto0=
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id fm24-20020a05600c0c1800b0040ee8765901sm6122780wmb.43.2024.02.04.08.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 08:11:15 -0800 (PST)
Date: Sun, 4 Feb 2024 16:05:19 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 0/9] BPF static branches
Message-ID: <Zb+1v80I/xMZ0d9W@zh-lab-node-5>
References: <20240202162813.4184616-1-aspsk@isovalent.com>
 <CAEf4Bzam9-bthtGM7BO2ELu_RJwcnkJZEoyV8zFyPV4oa05JPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzam9-bthtGM7BO2ELu_RJwcnkJZEoyV8zFyPV4oa05JPA@mail.gmail.com>

On Fri, Feb 02, 2024 at 02:39:24PM -0800, Andrii Nakryiko wrote:
> On Fri, Feb 2, 2024 at 8:34 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > This series adds support for mapping between xlated and original
> > instructions offsets, mapping between xlated and jitted instructions
> > offsets (x86), support for two new BPF instruction JA[SRC=1]
> > (goto[l]_or_nop) and JA[SRC=3] (nop_or_goto[l]), and a new syscall to
> > configure the jitted values of such instructions.
> >
> > This a follow up to the previous attempt to add static keys support
> > (see [1], [2]) which implements lower-level functionality than what
> > was proposed before.
> >
> > The first patch .
> > The second patch adds xlated -> original mapping.
> > The third patch adds .
> >
> > The fourth patch adds support for new instructions.
> > And the fifth patch adds support for new syscall.
> >
> > The following patches are included:
> >   Patch 1 is a formal bug fix
> >   Patch 2 adds the xlated -> original mapping
> >   Patch 3 adds the xlated -> jitted mapping
> >   Patch 4 adds tests for instructions mappings
> >   Patch 5 adds bpftool support for printing new instructions
> >   Patch 6 add support for an extended JA instruction
> >   Patch 7 add support for kernel/bpftool to display new instructions
> >   Patch 8 adds a new BPF_STATIC_BRANCH_UPDATE syscall
> >   Patch 9 adds tests for the new ja* instructions and the new syscall
> >
> > Altogether this provides enough functionality to dynamically patch
> > programs and support simple static keys.
> >
> > rfc -> v1:
> > - converted to v1 based on the feedback (there was none)
> > - bpftool support was added to dump new instructions
> > - self-tests were added
> > - minor fixes & checkpatch warnings
> >
> >   [1] https://lpc.events/event/17/contributions/1608/attachments/1278/2578/bpf-static-keys.pdf
> >   [2] https://lore.kernel.org/bpf/20231206141030.1478753-1-aspsk@isovalent.com/
> >   [3] https://github.com/llvm/llvm-project/pull/75110
> >
> > Anton Protopopov (9):
> >   bpf: fix potential error return
> >   bpf: keep track of and expose xlated insn offsets
> >   bpf: expose how xlated insns map to jitted insns
> >   selftests/bpf: Add tests for instructions mappings
> >   bpftool: dump new fields of bpf prog info
> >   bpf: add support for an extended JA instruction
> >   bpf: Add kernel/bpftool asm support for new instructions
> >   bpf: add BPF_STATIC_BRANCH_UPDATE syscall
> >   selftests/bpf: Add tests for new ja* instructions
> >
> >  arch/x86/net/bpf_jit_comp.c                   |  73 ++++-
> >  include/linux/bpf.h                           |  11 +
> >  include/linux/bpf_verifier.h                  |   1 -
> >  include/linux/filter.h                        |   1 +
> >  include/uapi/linux/bpf.h                      |  26 ++
> >  kernel/bpf/core.c                             |  67 ++++-
> >  kernel/bpf/disasm.c                           |  33 ++-
> >  kernel/bpf/syscall.c                          | 115 ++++++++
> >  kernel/bpf/verifier.c                         |  58 +++-
> >  tools/bpf/bpftool/prog.c                      |  14 +
> >  tools/bpf/bpftool/xlated_dumper.c             |  18 ++
> >  tools/bpf/bpftool/xlated_dumper.h             |   2 +
> >  tools/include/uapi/linux/bpf.h                |  26 ++
> >  .../bpf/prog_tests/bpf_insns_mappings.c       | 156 ++++++++++
> >  .../bpf/prog_tests/bpf_static_branches.c      | 269 ++++++++++++++++++
> >  .../selftests/bpf/progs/bpf_insns_mappings.c  | 155 ++++++++++
> >  16 files changed, 1002 insertions(+), 23 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insns_mappings.c
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_static_branches.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/bpf_insns_mappings.c
> >
> > --
> > 2.34.1
> >
> 
> This fails to build in CI ([0]). I'll take a look at the patches next
> week, sorry for the delay.

Thanks Andrii!

>   [0] https://github.com/kernel-patches/bpf/actions/runs/7762232524/job/21172303431?pr=6380#step:11:77

Thanks, I will push a fix for this and some more fixes in v2 (besides
this doc build failure there's a missing mutex for poking text and
one NULL deref).

