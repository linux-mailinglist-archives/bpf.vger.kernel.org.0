Return-Path: <bpf+bounces-39160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFA396FCF9
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5A91C22479
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A783156872;
	Fri,  6 Sep 2024 21:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNFe2vos"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985A71B85E1
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725656587; cv=none; b=OB/gIUViDu64Nf+PTO1yuboYHigp5YJ23tBSdIzqQarmSZOaE/vpPoD/NMNdDzSqjITvITg/GZY8ocTU+1uwnT2d8UhlwUON9kVk5CgAWJTvkfpYHofrTh5CeRGhuOekfqANgwC55zyVGNbyMCB4B2edmn+5vppR5TY0i2aTdJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725656587; c=relaxed/simple;
	bh=v8foNg4vJMDks0sZ4SlAFrucbYT8zjlFa/YllPKgNUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbUh1bgQz2xLhs5gLciNtSAaf7nlnWhauTGEfSMIvumtN0DdupE0AAib7L6z1+3bkGMHbJSCq6ctNjivVChHIb3eR41BnK3WW00LT6SKdxINezdvF0k+cyzf+WMijpABuwDcDID4pG2t/nC7bJQHYwU+s0VLrn3XV5bWr0OFQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNFe2vos; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d8881850d9so2092516a91.3
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 14:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725656585; x=1726261385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oskfa07sum0OuHUgggrzdnHKYFwP9rKJsFYmGv5VXWg=;
        b=iNFe2vossS8GjpO0nUELcuv7JVInYeaiWlqnZ0USIfrRF5/EkbmGcY9Wz2vmLtr+Zs
         L0zhO3TBS9eBLlr3usL89yUPOK1b29E0bdRUxGynmwaAXfOOqY/45Q1oH3x/d0bkhHsJ
         kWRQsiHp90W0tWqgsG6U8KzJA8Utyai2qXlW+AL8fHC7lTNGblr3aQ8Vnr4jIDKxTTtF
         +XT7DPXBtp9Wf+Nx6g8YegE4gayUAZdZ7YbzU7cZBQracJH1znzvKoQgp3r13x2ZOyJb
         rnmI2rQarEeBfpaRj72tdyWNFC4X4tUOSMpqN+vwCFPRcXDRydM/3N/shjlbkZdYnH4b
         eRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725656585; x=1726261385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oskfa07sum0OuHUgggrzdnHKYFwP9rKJsFYmGv5VXWg=;
        b=q7jWHPC97+Dh7IS3mbn6l5v7/WLTrJvh7ranA8MHgqpF2qGILanrYcfq2yqQfgkWD4
         jPN/ZwIptGswv1cF3M1FWoNW983v6uUPR601IK48LRyNvJhbkwX4Cpq3im3hHB8EZ49w
         /Kv8lYIB4VKyM1Shl1M3yu7GsOfb3/zq68eyF/2XX/xVVcgv5CrNrvQNzqA/A5alj1bx
         zLE5Ss3T3q5vqMNh4apz7xOjnU7ekKn04zSIm7fuGjqmB+NaOhqUicisv/wMa0Bsj5aH
         0FIBf+HqCZSDBSEUffC/q9aII9qQUyEqFYdyHsUH6xja4KUbfiEq68rDGk9uSkuTO3jn
         v9DA==
X-Gm-Message-State: AOJu0YxOnirmYpkP0/wIBC/vo04Z3wLgrt1Ur921vTpAMmLifh6B+fNW
	Qxo04dTuEuZjjlm5nORoqDJuTDbi+LNb5b6lRevgWymUkDTiQJKoPDdPw8xfdDYeZJCM9J8H0Uz
	lmxAHM/jHGuUPp9K6htl85yni3D+5514w
X-Google-Smtp-Source: AGHT+IHO+y75eN34ofMGP+khhDRR2MrKfSQFIzvEwbicDeRdI4UJdKXC5LeJgnBOgQzHU4VhF3EPrIrYa3apt9g+sBA=
X-Received: by 2002:a17:90a:c295:b0:2d8:71f4:1708 with SMTP id
 98e67ed59e1d1-2dad50228f9mr4511253a91.19.1725656584587; Fri, 06 Sep 2024
 14:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906135608.26477-1-daniel@iogearbox.net> <20240906135608.26477-8-daniel@iogearbox.net>
In-Reply-To: <20240906135608.26477-8-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 14:02:52 -0700
Message-ID: <CAEf4BzbGYLGjDyv2JBwxstnyYR9pajKoUwA6k2UtVp7G58oZCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 8/8] selftests/bpf: Add a test case to write
 into .rodata
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, shung-hsi.yu@suse.com, andrii@kernel.org, 
	ast@kernel.org, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 6:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> Add a test case which attempts to write into .rodata section of the
> BPF program, and for comparison this adds test cases also for .bss
> and .data section.
>
> Before fix:
>
>   # ./vmtest.sh -- ./test_progs -t verifier_const
>   [...]
>   ./test_progs -t verifier_const
>   tester_init:PASS:tester_log_buf 0 nsec
>   process_subtest:PASS:obj_open_mem 0 nsec
>   process_subtest:PASS:specs_alloc 0 nsec
>   run_subtest:PASS:obj_open_mem 0 nsec
>   run_subtest:FAIL:unexpected_load_success unexpected success: 0
>   #465/1   verifier_const/rodata: write rejected:FAIL
>   #465/2   verifier_const/bss: write accepted:OK
>   #465/3   verifier_const/data: write accepted:OK
>   #465     verifier_const:FAIL
>   [...]
>
> After fix:
>
>   # ./vmtest.sh -- ./test_progs -t verifier_const
>   [...]
>   ./test_progs -t verifier_const
>   #465/1   verifier_const/rodata: write rejected:OK
>   #465/2   verifier_const/bss: write accepted:OK
>   #465/3   verifier_const/data: write accepted:OK
>   #465     verifier_const:OK
>   [...]
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>  v1 -> v2:
>  - const volatile long (Andrii)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../selftests/bpf/prog_tests/verifier.c       |  2 +
>  .../selftests/bpf/progs/verifier_const.c      | 42 +++++++++++++++++++
>  2 files changed, 44 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_const.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index df398e714dff..e26b5150fc43 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -21,6 +21,7 @@
>  #include "verifier_cgroup_inv_retcode.skel.h"
>  #include "verifier_cgroup_skb.skel.h"
>  #include "verifier_cgroup_storage.skel.h"
> +#include "verifier_const.skel.h"
>  #include "verifier_const_or.skel.h"
>  #include "verifier_ctx.skel.h"
>  #include "verifier_ctx_sk_msg.skel.h"
> @@ -146,6 +147,7 @@ void test_verifier_cfg(void)                  { RUN(v=
erifier_cfg); }
>  void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_=
retcode); }
>  void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb)=
; }
>  void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_stor=
age); }
> +void test_verifier_const(void)                { RUN(verifier_const); }
>  void test_verifier_const_or(void)             { RUN(verifier_const_or); =
}
>  void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
>  void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg)=
; }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_const.c b/tools/t=
esting/selftests/bpf/progs/verifier_const.c
> new file mode 100644
> index 000000000000..5158dbea8c43
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_const.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Isovalent */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +const volatile long foo =3D 42;
> +long bar;
> +long bart =3D 96;
> +
> +SEC("tc/ingress")
> +__description("rodata: write rejected")
> +__failure __msg("write into map forbidden")
> +int tcx1(struct __sk_buff *skb)
> +{
> +       char buff[] =3D { '8', '4', '\0' };
> +       bpf_strtol(buff, sizeof(buff), 0, (long *)&foo);
> +       return TCX_PASS;
> +}
> +
> +SEC("tc/ingress")
> +__description("bss: write accepted")
> +__success
> +int tcx2(struct __sk_buff *skb)
> +{
> +       char buff[] =3D { '8', '4', '\0' };
> +       bpf_strtol(buff, sizeof(buff), 0, &bar);
> +       return TCX_PASS;
> +}
> +
> +SEC("tc/ingress")
> +__description("data: write accepted")
> +__success
> +int tcx3(struct __sk_buff *skb)
> +{
> +       char buff[] =3D { '8', '4', '\0' };
> +       bpf_strtol(buff, sizeof(buff), 0, &bart);
> +       return TCX_PASS;
> +}
> +
> +char LICENSE[] SEC("license") =3D "GPL";
> --
> 2.43.0
>

