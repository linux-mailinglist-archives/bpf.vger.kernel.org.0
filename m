Return-Path: <bpf+bounces-16456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577C680141A
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 21:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896BB1C20B34
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F20756B79;
	Fri,  1 Dec 2023 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWynjeNB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F042715
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 12:11:50 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9ccf36b25so28826711fa.3
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 12:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701461508; x=1702066308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=co/GHwcxUv4oHVzXemq7VO4xd/jbxyrFPmlxL5yCYZw=;
        b=LWynjeNBsOXCrx9VLtVHdOzkK1LDpWsyidwF6HAbO9AaUt0dYB824FS6ByAoBGUDrM
         rRgvx9xr7bQ+WK688oY5WaUrja6v3k80YcnMHN4jgfkgMbmfD9tRIdPo9xeCB7qzG0It
         VsfK7MCB3O1bOGr2y6g5QhMdX+t54jvmsiJB0GJ/ISNtCTVj9vMB1FHjUPPFaz+IvRFJ
         5peYcWSiBOA0qaJUDkQyqsJ3BoEzH4i1yssPyOtVuCbBn3r7hCTak+jyNhMqsbrSbXPw
         E/fFSktRyY3nOm+R2JM5ai9mN7dp1Uvu+Ze1aOZlExRKShVXyAaNmYqzdxFTzbVgDESw
         cLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701461508; x=1702066308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=co/GHwcxUv4oHVzXemq7VO4xd/jbxyrFPmlxL5yCYZw=;
        b=C1Vyg+AhBWdpOItYMDV/WpYB1CF+qG2f4w8ksCNTu19NTpUFcJdb5aDJUZiRics9/e
         k7kFnhsOu7yndktr+qUYtMF6njhJIrNEo9ZogX69cbKx66HnDkEWGsFxdASTpS46e4HN
         RmJsXsrbxADVRHmdSMS9xz4dBEVYMwAejClyfCaKWhYeWPB60U2uDPNvTBWPL/rh40j9
         u30Ch6cP6nQ6cTAeIpebZOFHiDnsHVxTmZnedNKlWrT5trt8CMXarYvXs/cClXj1JXoL
         929Ul79xg1k0wc06FR7t3f87rgmYZICnM80TA9LCYkMbVbhPHdy7WE5Y0c1ZBA9v2Rb4
         1KxA==
X-Gm-Message-State: AOJu0YyaVw5KsXynrzNvhO4g8gsiLQ69p9b74BJGzeGRnUPQQmDrpYts
	YI0ELyZlnRqMrQff04yimGJgRNiP0we6K449uvFxZ9YTmtY=
X-Google-Smtp-Source: AGHT+IHh7XmhI6tQybgCta5Nai+DC6k5VPxmSLivdbLHck/Hbpc+oUQK49/OEvdRJS4AKOMa1gY5CRPnaYVmh9BUTGU=
X-Received: by 2002:a2e:9bc8:0:b0:2c9:e540:666e with SMTP id
 w8-20020a2e9bc8000000b002c9e540666emr476294ljj.96.1701461507718; Fri, 01 Dec
 2023 12:11:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201183359.1769668-1-andrii@kernel.org>
In-Reply-To: <20231201183359.1769668-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Dec 2023 12:11:35 -0800
Message-ID: <CAEf4BzYY4K96+B6wCrxVh7oapWb9Pe=Yt9bc59Bc=tyPuDXUxg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/11] BPF verifier retval logic fixes
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 10:34=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> This patch set fixes BPF verifier logic around validating and enforcing r=
eturn
> values for BPF programs that have specific range of expected return value=
s.
> Both sync and async callbacks have similar logic and are fixes as well.
> A few tests are added that would fail without the fixes in this patch set=
.
>
> Also, while at it, we update retval checking logic to use smin/smax range
> instead of tnum, avoiding future potential issues if expected range canno=
t be
> represented precisely by tnum (e.g., [0, 2] is not representable by tnum =
and
> is treated as [0, 3]).
>
> There is a little bit of refactoring to unify async callback and program =
exit
> logic to avoid duplication of checks as much as possible.
>
> v3->v4:
>   - add back bpf_func_state rearrangement patch;
>   - simplified patch #4 as suggested (Shung-Hsi);
> v2->v3:
>   - more carefullly switch from umin/umax to smin/smax;
> v1->v2:
>   - drop tnum from retval checks (Eduard);
>   - use smin/smax instead of umin/umax (Alexei).

This patch set must be cursed or something :) CI caught regression for
no-alu32 test_progs variant in test_bad_ret:

EXPECTED MSG: 'mark_precise: frame0: regs=3Dr0 stack=3D before 22: (b4) w0 =
=3D 0'

I'll check, fix, and will try again, maybe v5 will be luckier.

>
> Andrii Nakryiko (11):
>   bpf: rearrange bpf_func_state fields to save a bit of memory
>   bpf: provide correct register name for exception callback retval check
>   bpf: enforce precision of R0 on callback return
>   bpf: enforce exact retval range on subprog/callback exit
>   selftests/bpf: add selftest validating callback result is enforced
>   bpf: enforce precise retval range on program exit
>   bpf: unify async callback and program retval checks
>   bpf: enforce precision of R0 on program/async callback return
>   selftests/bpf: validate async callback return value check correctness
>   selftests/bpf: adjust global_func15 test to validate prog exit
>     precision
>   bpf: simplify tnum output if a fully known constant
>
>  include/linux/bpf_verifier.h                  |   9 +-
>  kernel/bpf/log.c                              |  13 ++
>  kernel/bpf/tnum.c                             |   6 -
>  kernel/bpf/verifier.c                         | 120 ++++++++++--------
>  .../selftests/bpf/progs/exceptions_assert.c   |   2 +-
>  .../selftests/bpf/progs/exceptions_fail.c     |   2 +-
>  .../selftests/bpf/progs/test_global_func15.c  |  34 ++++-
>  .../selftests/bpf/progs/timer_failure.c       |  36 ++++--
>  .../selftests/bpf/progs/user_ringbuf_fail.c   |   2 +-
>  .../bpf/progs/verifier_cgroup_inv_retcode.c   |   8 +-
>  .../bpf/progs/verifier_direct_packet_access.c |   2 +-
>  .../selftests/bpf/progs/verifier_int_ptr.c    |   2 +-
>  .../bpf/progs/verifier_netfilter_retcode.c    |   2 +-
>  .../selftests/bpf/progs/verifier_stack_ptr.c  |   4 +-
>  .../bpf/progs/verifier_subprog_precision.c    |  50 ++++++++
>  15 files changed, 212 insertions(+), 80 deletions(-)
>
> --
> 2.34.1
>

