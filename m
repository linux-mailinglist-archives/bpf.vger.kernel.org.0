Return-Path: <bpf+bounces-45413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3C79D5449
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 21:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F191F23296
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 20:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6880B1DBB19;
	Thu, 21 Nov 2024 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyTEEHGQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064E1DB943
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221833; cv=none; b=SJyW5TZjvvRm2rcSdhANVwijftbdt2tbG/OhYjCrTvJA4NnAetmNQGMJaKa4QmuJqSTTBJbqsrUascfCEeFfv1qxASPTyAsiiLHct667yfvQOxsIkZwgr5Wy6xHCLsbOYWyhyhonPI4tVbgSlPAr/6aZsIKQzRXn7LFCnm9w3nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221833; c=relaxed/simple;
	bh=BXVfCm0WaPVUkQd61jjVYmnmVg2EH0VPPUb4qmg0aNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j2n+t3XDfj/mXI94yWdos+rXASnaTVIB/B9++0tF6rnnHiaZRhCq4kAZ/kfGg1i0OGY0/i/9LBVoQJoJB4uG3rg0+XAWg41CBCZhgDBi8TdKndyNm2KcAiY8ClGtT1ZNNLBs/PymekQ7VnX4s3PJB/7OSnJCSgk3bXsIqN3x0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyTEEHGQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72487ebd2f5so1213881b3a.1
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732221832; x=1732826632; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u3TomkKtSodVzw0CP76inVWFrgVsEss2OTmX9eCp4GI=;
        b=cyTEEHGQhDTUu2EFlxWzPGHMVUM3CE/fRIBn0kBDeaaZ72F9ciK8PwvM1ixCsSotPv
         i4jmudg5RooQ8MD64Aa1P1VeJf/pnaa/Ufqg/dQ+FxFh4Xh0lTbMqoVx4OM1r52VBCDO
         L7t2ShkrgfIPyl06PgNgf5iCNfdPJgWmCWeWuqELer/Et8RCqJwOZNkcmVrDqMVlxrUt
         VtJgbbrBOwxSHEBhmFO/zWbnDGNfiPxNkgy544DfK+r0YPES1LYQxlhpivTYA96dZd1A
         LPMt2SmSmQ5VKFTLezvToWAq8+V7YrC17S2CDneXfirbrJztAtJH76eAvvo+6Ffmt1uU
         1S+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221832; x=1732826632;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u3TomkKtSodVzw0CP76inVWFrgVsEss2OTmX9eCp4GI=;
        b=jrbIto4+1Uc8SLooknhKFuUh3A6LICuM1lqE8Ip6VIxJB+Zej0Yh5jIUegD/N8duSU
         gly2hEf/prBU4cPfhVTkBf5I/a5axdUn1YBfhnjhCuqFnL4ZFFjw1k0Qwpa4GzhSVDRD
         njSf/Q5x37FObWguytxLsyoepRZEZZ9y0QQVdmFsDX+BV3tz2QkUhnHHXqAjP9h6xpcK
         ynVMk2NvYFsC1/qY30Odl+ptuKsCHxa2j+HN98rzGSN4L0OQfcGuVUQ1Z7oyzISxfVyU
         ep+lU1QrNIodcdgbooV7u2f/K9qPZrB6wzDWNeqqe9OaYSmxcjUv2b0RC3Cw14VDZxIv
         GJCA==
X-Forwarded-Encrypted: i=1; AJvYcCXEngJAgpwN5M3R4gSgAJ0YBq1n7RaUQXT+DdQ9LF9qaRM6CZigaw1jrdBdniN5ePLKFHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylN4etLsWypzdFnWAaAXsRfWLcHxsupW8jPL4COo5Nx8hWQND4
	aPI9q0bdW51k18VPhecuIX2ylbK1YEl/mFRRxdW17nmwXW9szvbH
X-Gm-Gg: ASbGncviwaXg1J+X4Dm0SUSzjtkJGtm63BvbB0kU6kD+l5kjRWiI/qLARyaWzre2FwR
	18PVo6bBC/pufLUpgkfipJ5v815y4OCNcD4yn1HLY0YplUh31cNpLYBj1+gym6Geq/JneG0CJ+j
	V9x59e7eTktXi52b9YvkKWioO5kMcbRbF88nd6IBVta36KVSEC/LbdTICMCcnVfRU6D5yDJsLjm
	7TMCouDenkem7xZBxGTZmE6kEeLgH6X72mXZ/MPHWuXgVg=
X-Google-Smtp-Source: AGHT+IE45DuQFDHTmvB67h4+l0ltCfjdq2aqCUQLyN4qBAvvwlZAeyNkgs8Qi4TcTu43E7uMf5Rx5w==
X-Received: by 2002:a05:6a00:2d98:b0:71e:3b8f:92e with SMTP id d2e1a72fcca58-724df3c96f5mr560257b3a.3.1732221831447;
        Thu, 21 Nov 2024 12:43:51 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de531b68sm185251b3a.111.2024.11.21.12.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:43:51 -0800 (PST)
Message-ID: <8db8d815dc263edd8d3883a770c0bc0ac511dd77.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 7/7] selftests/bpf: Add IRQ save/restore
 tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kernel-team@fb.com
Date: Thu, 21 Nov 2024 12:43:46 -0800
In-Reply-To: <20241121005329.408873-8-memxor@gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
	 <20241121005329.408873-8-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-20 at 16:53 -0800, Kumar Kartikeya Dwivedi wrote:
> Include tests that check for rejection in erroneous cases, like
> unbalanced IRQ-disabled counts, within and across subprogs, invalid IRQ
> flag state or input to kfuncs, behavior upon overwriting IRQ saved state
> on stack, interaction with sleepable kfuncs/helpers, global functions,
> and out of order restore. Include some success scenarios as well to
> demonstrate usage.
>=20
> #123/1   irq/irq_restore_missing_1:OK
> #123/2   irq/irq_restore_missing_2:OK
> #123/3   irq/irq_restore_missing_3:OK
> #123/4   irq/irq_restore_missing_3_minus_2:OK
> #123/5   irq/irq_restore_missing_1_subprog:OK
> #123/6   irq/irq_restore_missing_2_subprog:OK
> #123/7   irq/irq_restore_missing_3_subprog:OK
> #123/8   irq/irq_restore_missing_3_minus_2_subprog:OK
> #123/9   irq/irq_balance:OK
> #123/10  irq/irq_balance_n:OK
> #123/11  irq/irq_balance_subprog:OK
> #123/12  irq/irq_balance_n_subprog:OK
> #123/13  irq/irq_global_subprog:OK
> #123/14  irq/irq_restore_ooo:OK
> #123/15  irq/irq_restore_ooo_3:OK
> #123/16  irq/irq_restore_3_subprog:OK
> #123/17  irq/irq_restore_4_subprog:OK
> #123/18  irq/irq_restore_ooo_3_subprog:OK
> #123/19  irq/irq_restore_invalid:OK
> #123/20  irq/irq_save_invalid:OK
> #123/21  irq/irq_restore_iter:OK
> #123/22  irq/irq_save_iter:OK
> #123/23  irq/irq_flag_overwrite:OK
> #123/24  irq/irq_flag_overwrite_partial:OK
> #123/25  irq/irq_sleepable_helper:OK
> #123/26  irq/irq_sleepable_kfunc:OK
> #123     irq:OK
> Summary: 1/26 PASSED, 0 SKIPPED, 0 FAILED
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

The following error condition is not tested:
"arg#%d doesn't point to an irq flag on stack".
Also, I think a few tests are excessive.
Otherwise looks good.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/irq.c b/tools/testing=
/selftests/bpf/prog_tests/irq.c
> new file mode 100644
> index 000000000000..496f4826ac37
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/irq.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <irq.skel.h>
> +
> +void test_irq(void)
> +{
> +	RUN_TESTS(irq);
> +}

Nit: tools/testing/selftests/bpf/prog_tests/verifier.c
     could be used instead of a separate file.

> diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/self=
tests/bpf/progs/irq.c
> new file mode 100644
> index 000000000000..5301b66fc752
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/irq.c
> @@ -0,0 +1,393 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +SEC("?tc")
> +__failure __msg("BPF_EXIT instruction cannot be used inside bpf_local_ir=
q_save-ed region")

Nit: I know this is not a fault of this series, but the error message
     is sort of confusing. BPF_EXIT is allowed for irq saved region,
     just it has to be an exit from a sub-program, not a whole program.

> +int irq_restore_missing_1(struct __sk_buff *ctx)
> +{
> +	unsigned long flags;
> +
> +	bpf_local_irq_save(&flags);
> +	return 0;
> +}

[...]

Nit: don't think this test adds much compared to irq_restore_missing_2.

> +{
> +	unsigned long flags1;
> +	unsigned long flags2;
> +	unsigned long flags3;
> +
> +	bpf_local_irq_save(&flags1);
> +	bpf_local_irq_save(&flags2);
> +	bpf_local_irq_save(&flags3);
> +	return 0;
> +}

[...]

> +SEC("?tc")
> +__success
> +int irq_balance_n_subprog(struct __sk_buff *ctx)

Nit: don't think this test adds much given irq_balance_n()
     and irq_balance_subprog().

> +{
> +	local_irq_balance_n();
> +	return 0;
> +}

[...]


