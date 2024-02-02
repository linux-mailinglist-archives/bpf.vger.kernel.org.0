Return-Path: <bpf+bounces-21104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45884847C64
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55404B219D4
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32A012C7E6;
	Fri,  2 Feb 2024 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwtaYN+p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE515FF01
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706913580; cv=none; b=UgReHjV6I6nw1uFSJEcQbRQtQvXjuD57Y30yF+zfs5MXGY8+gQBYcO+C87ywC4hdxQLtpbepMmxCRYoxklA4tS15UPnhyT5NY5W4vWMiYk6F1s2G/8pQuFrf7X/8Zn9/VOuq/lFxRcrMRjh3rq9fwRZWaqtnXatetdru55RkZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706913580; c=relaxed/simple;
	bh=EwaTG8ymKBypNkcTbelCYfrc9covtsVfN2J9HBMqda8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwptY1b0JuQFy/hOMyWF1tyhjJdY469DRC4DweZSIGqWspEbuvbITJTs4eN7T0Gd+BBnz8JufuIWLbM8xfPZAxVMZhXviqImQETrK3E341ZfjIf/Mbfe4pM+4kEvSdhwc1XregCPWsKCWMbw0WdIEOFZtmTwcKO8CW5faiIhon4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwtaYN+p; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e02597a0afso277205b3a.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706913577; x=1707518377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upBhrwD4lklSX7g2evNAVAAZGtKV5cYLKmQ91TBjS14=;
        b=YwtaYN+pptHnMmuD7/6CZUZdd1kpGLBhULZ1d62JsNn+Tzsj7AM0GNZsmeZOTtxuYS
         dHLVQzIVB283ZIBZgzyXcB2IiHOBUubIr0Q9Si4mOfcfY1ZvvSaIvcBKyRCIgwk9IcUZ
         zmnJL2IfYT+KeNXBkl3SJXGItMBzU0WmNSaj/qJi0ydiS+DeyRN/rupSXvHfge2oPDyR
         /qBW7ebL5+NJXSdl74xaTloC/sXNCCUq9gEIHFo0x7Kq96/SaLZOPD29NS2xM5Ta8AHG
         0r9vJnMeolifYlCiiT7POtgbDMLEMhJ6wCDiGxiSb6U6s8MO6BCBOg7YimXseTwR+MEz
         4Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706913577; x=1707518377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upBhrwD4lklSX7g2evNAVAAZGtKV5cYLKmQ91TBjS14=;
        b=wLDjznkjhQn/9M1oegGjeJn/4tG9PixiQD+BaI+oi9BYWold7424NaTwVAtEM8nxcZ
         zDKXczSwX0NW+UYAF4/4A2Aqi4iXCA3L0/0csbFb64l+T/zQvD68i+sqx75lOBkxoAXF
         dO2c2g4SXomBt5PnRhLDD95Z+KjLuuLaSilUjsJtNHe0AHoNhnze4Zww6uMgYHr1KGBU
         U1lA8hDzgm6TObEVTPJjh/oCerCc2bqu+UiYdYKijXJR+sszUpYvx0wFcWQmQpfniIVf
         JuJvy7sLrZwjYyy3A30YDtsh5eQdSBA6AdBYxhAoqvqwuOq9VTuPw7wXwhMdGRIXhWRD
         W9nw==
X-Gm-Message-State: AOJu0YzS5U/cyRUxNJWnO+LzXrtDrwFN045w+YG2ugwTOmQ/sip8sob1
	+y/n4zuzYKEH7ticFKsQh7YqUCFfAHYmCeSMSQL2E2fkxfxYf3gnL5KQ9dqU8GqCQplR6QUoyGB
	YJ5Z/7wr1tKKZQ/bNvrAcucR8Kro=
X-Google-Smtp-Source: AGHT+IH4MlQYF8L5m5aOn/UiWT8uZooLMX5imwe6+TrUrm8qzgrcxkTRwS/Bq9YwWtILKYx5NMqtozqAgBXmUnQYGpg=
X-Received: by 2002:a05:6a00:1ca2:b0:6de:3a3c:4d0d with SMTP id
 y34-20020a056a001ca200b006de3a3c4d0dmr4460602pfw.2.1706913576860; Fri, 02 Feb
 2024 14:39:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202162813.4184616-1-aspsk@isovalent.com>
In-Reply-To: <20240202162813.4184616-1-aspsk@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Feb 2024 14:39:24 -0800
Message-ID: <CAEf4Bzam9-bthtGM7BO2ELu_RJwcnkJZEoyV8zFyPV4oa05JPA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 0/9] BPF static branches
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 8:34=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> This series adds support for mapping between xlated and original
> instructions offsets, mapping between xlated and jitted instructions
> offsets (x86), support for two new BPF instruction JA[SRC=3D1]
> (goto[l]_or_nop) and JA[SRC=3D3] (nop_or_goto[l]), and a new syscall to
> configure the jitted values of such instructions.
>
> This a follow up to the previous attempt to add static keys support
> (see [1], [2]) which implements lower-level functionality than what
> was proposed before.
>
> The first patch .
> The second patch adds xlated -> original mapping.
> The third patch adds .
>
> The fourth patch adds support for new instructions.
> And the fifth patch adds support for new syscall.
>
> The following patches are included:
>   Patch 1 is a formal bug fix
>   Patch 2 adds the xlated -> original mapping
>   Patch 3 adds the xlated -> jitted mapping
>   Patch 4 adds tests for instructions mappings
>   Patch 5 adds bpftool support for printing new instructions
>   Patch 6 add support for an extended JA instruction
>   Patch 7 add support for kernel/bpftool to display new instructions
>   Patch 8 adds a new BPF_STATIC_BRANCH_UPDATE syscall
>   Patch 9 adds tests for the new ja* instructions and the new syscall
>
> Altogether this provides enough functionality to dynamically patch
> programs and support simple static keys.
>
> rfc -> v1:
> - converted to v1 based on the feedback (there was none)
> - bpftool support was added to dump new instructions
> - self-tests were added
> - minor fixes & checkpatch warnings
>
>   [1] https://lpc.events/event/17/contributions/1608/attachments/1278/257=
8/bpf-static-keys.pdf
>   [2] https://lore.kernel.org/bpf/20231206141030.1478753-1-aspsk@isovalen=
t.com/
>   [3] https://github.com/llvm/llvm-project/pull/75110
>
> Anton Protopopov (9):
>   bpf: fix potential error return
>   bpf: keep track of and expose xlated insn offsets
>   bpf: expose how xlated insns map to jitted insns
>   selftests/bpf: Add tests for instructions mappings
>   bpftool: dump new fields of bpf prog info
>   bpf: add support for an extended JA instruction
>   bpf: Add kernel/bpftool asm support for new instructions
>   bpf: add BPF_STATIC_BRANCH_UPDATE syscall
>   selftests/bpf: Add tests for new ja* instructions
>
>  arch/x86/net/bpf_jit_comp.c                   |  73 ++++-
>  include/linux/bpf.h                           |  11 +
>  include/linux/bpf_verifier.h                  |   1 -
>  include/linux/filter.h                        |   1 +
>  include/uapi/linux/bpf.h                      |  26 ++
>  kernel/bpf/core.c                             |  67 ++++-
>  kernel/bpf/disasm.c                           |  33 ++-
>  kernel/bpf/syscall.c                          | 115 ++++++++
>  kernel/bpf/verifier.c                         |  58 +++-
>  tools/bpf/bpftool/prog.c                      |  14 +
>  tools/bpf/bpftool/xlated_dumper.c             |  18 ++
>  tools/bpf/bpftool/xlated_dumper.h             |   2 +
>  tools/include/uapi/linux/bpf.h                |  26 ++
>  .../bpf/prog_tests/bpf_insns_mappings.c       | 156 ++++++++++
>  .../bpf/prog_tests/bpf_static_branches.c      | 269 ++++++++++++++++++
>  .../selftests/bpf/progs/bpf_insns_mappings.c  | 155 ++++++++++
>  16 files changed, 1002 insertions(+), 23 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insns_mapp=
ings.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_static_bra=
nches.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_insns_mappings.=
c
>
> --
> 2.34.1
>

This fails to build in CI ([0]). I'll take a look at the patches next
week, sorry for the delay.

  [0] https://github.com/kernel-patches/bpf/actions/runs/7762232524/job/211=
72303431?pr=3D6380#step:11:77

