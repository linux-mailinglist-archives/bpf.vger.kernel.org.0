Return-Path: <bpf+bounces-50809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EBAA2CF06
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4E416D358
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 21:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A891B87CE;
	Fri,  7 Feb 2025 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aINefycw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6191B040E
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963803; cv=none; b=otqHcBL8M5kgqwlQ8lMPke7o4yzu8CRBb/zKlCOP4feUXhwILnQmSEv818kQ2lZ4Q5Df0Mg787d7+8TsmKbDpD7NgSpy/WdpqczQMSMEmfDxF9nVCvRipZKjTXtesueu00YprkxEZ4muxfCRGB1zx4bSoz2Lhpjbks8P3am02GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963803; c=relaxed/simple;
	bh=8dRlDI5WmSmXm0KKjj2yjaKPB4VGUf/sFQBj7bC46Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax+1OOgiXrGfbHaDj4LPJUeO5nUGUGgJyYmgbQIv32SypjbrgZAgQF0IkWZtUK7DWE1jO0VbSpfJEqc5oOvGmoex36j2IXhW+XY31VBzdOJ+GxjPrBOn+y8NKEtsBHYDxDErGVpQs3VtNm1WrY3xzETm0jdHEv0DML4a/FvLbNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aINefycw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f032484d4so45655ad.0
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 13:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738963801; x=1739568601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WpmqbDlVKgWI46RiBOd7cmqJb5HFtWlucmHwOHZfM5g=;
        b=aINefycwRwhIpwSPcrB9tIHeZv0hVncY+2bhaCAQ/ZMYfNpbj0+V4jqPbASXrjG6BT
         SIPR7C9pQRRJrXfVzPPeeTQLul4lJHXaaRGcOOO3pvL4+CB41W+6CC2/yzhTe2tYMHVv
         WfevarCD3iKkWXmysP9HpH4bml8KtI3Gp9OqKSvt5LAFDTf8Gi6lTkpZOyXdixAGGBfk
         cXx6EmZmeRlfS9Lv/yBK3hf1RSgqPE+kvudXMbZkBKSYLpZpcvBkt8sogLkRL7toH75G
         psZ578OvlI0W4R/u1e+a8dwm8utPs+ZbJgY2Zf3XTKf6s4kf74lBI2e8LHJRK8wsyZVs
         Eb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738963801; x=1739568601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpmqbDlVKgWI46RiBOd7cmqJb5HFtWlucmHwOHZfM5g=;
        b=XlOdW49qtuABjVQWrhOxNyuvWtyS4J7YZqsB3EtMNXVjaO9PvRMmUPUMgqp/8U++hR
         FdlaQIulF8pyP02W+CPvyszzkeuov7dIolJ6cMsdb+MA9DOfn8f4SjaS6oOEnIkhZ2Gm
         lXY2ORR++wFT4gcMh4lyHBFCTGtJL6GzqxERzTHexB8/s3FHEefUOQoKIrd/9zdi+Put
         nWnejsErMK0g+9JHN1a51PyheK8bEMKzdbQsjgD8+e56Xa7eAkyICXL9xK6VbEs1Yozx
         0jTH7B7JXoHJrX1bbdQbi/02wzAtaPQYUqRCtY9zCNc0tMLq7H+o7M93B5T47cDosjY0
         XBwQ==
X-Gm-Message-State: AOJu0YwdbtmeGbuqmWrrGUWK0jtjIjinCeY74w7Evb3oRymeDRkbfQsb
	EPaZjxDNQm2DdHjh8aeLEPRjLsuKtWIG5GucYcOFnXRpfHcY9+lF56p4509Y3p/wAU38Tww4avH
	EjC8b
X-Gm-Gg: ASbGnctyUmm3Q0yDHmbV1dbCbGThZMLgityv0xz3sYG24BTILUaKuTNPJehOxep2Tdh
	HBKw7Kjb9syrK/st/8YoHGIk5Ucxm/hWOXoyo+zTY3moc8fsSDOrEA/4IyTEkSCnx8fsSW1IxWm
	kh3s0df12CQgmP7ZiWHFNRo2EmjW0njclj+X1MIlWeGScRG6dqAmH1ifZTK1IHqProX7Nd9tOqM
	eBf7yo5d8B22lH9ddo3TTQwwcRLNMcbgJ3QbC4APbWZPGjS3laHjH0JAdXkXZQk3pkRBt9JkFn8
	oqR5YaSl3dKojo52MhtCkn8HLjjjQ1QPQ67iRIjEmEtVLnTODt9LRQ==
X-Google-Smtp-Source: AGHT+IHP6x7/nnWTD43CmRO0CpbJGNj6KB/SNxwdoOzxC7LfXgdBO2BKOfnZMBUjldNgUy6Lg8WukQ==
X-Received: by 2002:a17:902:aa08:b0:20c:f40e:6ec3 with SMTP id d9443c01a7336-21f69e34933mr559535ad.22.1738963800724;
        Fri, 07 Feb 2025 13:30:00 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa2d831a1csm1670429a91.44.2025.02.07.13.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:29:59 -0800 (PST)
Date: Fri, 7 Feb 2025 21:29:54 +0000
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yingchi Long <longyingchi24s@ict.ac.cn>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/9] Introduce load-acquire and store-release
 BPF instructions
Message-ID: <Z6Z7UsB-AGD_Xhdq@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1738888641.git.yepeilin@google.com>

On Fri, Feb 07, 2025 at 02:04:54AM +0000, Peilin Ye wrote:
> Peilin Ye (9):
>   bpf/verifier: Factor out atomic_ptr_type_ok()
>   bpf/verifier: Factor out check_atomic_rmw()
>   bpf/verifier: Factor out check_load_mem() and check_store_reg()
>   bpf: Introduce load-acquire and store-release instructions
>   arm64: insn: Add BIT(23) to {load,store}_ex's mask
>   arm64: insn: Add load-acquire and store-release instructions
>   bpf, arm64: Support load-acquire and store-release instructions
>   selftests/bpf: Add selftests for load-acquire and store-release
>     instructions
>   bpf, docs: Update instruction-set.rst for load-acquire and
>     store-release instructions
> 
>  .../bpf/standardization/instruction-set.rst   | 114 ++++++--
>  arch/arm64/include/asm/insn.h                 |  12 +-
>  arch/arm64/lib/insn.c                         |  29 ++
>  arch/arm64/net/bpf_jit.h                      |  20 ++
>  arch/arm64/net/bpf_jit_comp.c                 |  87 +++++-
>  arch/s390/net/bpf_jit_comp.c                  |  14 +-
>  arch/x86/net/bpf_jit_comp.c                   |   4 +
>  include/linux/bpf.h                           |  11 +
>  include/linux/filter.h                        |   2 +
>  include/uapi/linux/bpf.h                      |  13 +
>  kernel/bpf/core.c                             |  63 ++++-
>  kernel/bpf/disasm.c                           |  12 +
>  kernel/bpf/verifier.c                         | 234 +++++++++++-----
>  tools/include/uapi/linux/bpf.h                |  13 +
>  .../selftests/bpf/prog_tests/arena_atomics.c  |  50 ++++
>  .../selftests/bpf/prog_tests/verifier.c       |   4 +
>  .../selftests/bpf/progs/arena_atomics.c       |  88 ++++++
>  .../bpf/progs/verifier_load_acquire.c         | 190 +++++++++++++
>  .../selftests/bpf/progs/verifier_precision.c  |  47 ++++
>  .../bpf/progs/verifier_store_release.c        | 262 ++++++++++++++++++
>  20 files changed, 1164 insertions(+), 105 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_load_acquire.c
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_store_release.c

Looks like the llvm-18 CI job passed but the llvm-17/gcc ones failed.
I'll debug with llvm-17 and see if I need different #ifdef guards for
the new tests.

Thanks,
Peilin Ye


