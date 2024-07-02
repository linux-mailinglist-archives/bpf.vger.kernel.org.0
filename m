Return-Path: <bpf+bounces-33585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA8591EBE6
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC32B21968
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFF56FCB;
	Tue,  2 Jul 2024 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+krJ274"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3B423D7
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719880978; cv=none; b=R0f8c2yHhgIuzkxggYlJUYV9uqYJKQ0AvFw8zwcgP4x8Mhmb9wMDDFfmK7YUKTqK4RGZiQo8l34EiuOAWqI5YEXQtk8S6MpHV5kA2xX/MdcwHCYOmHKAv9MpyM3O5pvttY6eWoD3lFsUjUZE7KgMkIDWOBQJfPldmM4vwYiGJCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719880978; c=relaxed/simple;
	bh=YlanR0AprSCrS+5vfktIcmOIDYWdlowG5jCkM/StS60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMuNmB59/oer+Pyf++bRK5zqo70f/YCes0HUuNCCrwLY5NHypXLd+0RjR2hVKz3f8yDtp533CqPQ4phfpvc5JN72/KmcHY0Di5WwizyD8IUUJRCPa3ADe4Eqkp7UFdx7BZ0Q8EPNM8kgeY88PD7W7lqwlZoD5SPJ02K6OpOxYu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+krJ274; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-73aba5230b6so1850064a12.1
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 17:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719880976; x=1720485776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJcS19w/RphZ6N3KNUzfp7PwAVZnJf9OkHubzf1bP0o=;
        b=S+krJ274pRsIgivAZtf/W4FiZfWF/Wb+inuRhH6uu0nezsYQkk+xD8c7u7bP1f7tNy
         sku924pSAhezw5n6QhLS70uU6poBV0o4L5MqLYbv+zgnlWX3yhwjiDbhcIYQkfvByWr2
         Z5DWua5LjvA0/ZoBb2M++jJbXopKDrBIMP16PUYQcaXku0xv9dmQWpcYFA+rwMipfnCi
         l62lSsN8OmF9k8YaoLFkex0kR0SjqmzIlLvVjrD3nTFnt0/5UdLaSlYdKlAoA65daCv1
         /BDfHwfIzOv/upYy8rKLcbYZKGUdFTd50GtKJm6lAa9eOtHg+GvB5E4ylYPffBbEuFk2
         /Zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719880976; x=1720485776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJcS19w/RphZ6N3KNUzfp7PwAVZnJf9OkHubzf1bP0o=;
        b=DHV4MT2kQllPEce3/EtirCis+3v1jJZJjm/Q65K8T40k7Gh6qLLV8BmhqqtnssSvpB
         ksbDTHWydwDPyVPNDalgq932TMfUPBCwvO99P3c8a8pvZYc4glYD1hJ/Twlw3MPzNwBM
         71pSTqLf4vgLj1Yl007qhNQtgZaHxHQgboaau5x6LC8Tg51LylNR0vV+gQ4zyTVrf54S
         Yc94Daecop+TTX1OrKSYgveVOXbIlX38Qm5f4cc0tPpLk6M6ZFyeNMaDOpPeoei4sb+C
         kZYOPOX6CMYx/PLKL0MbBfBWsIB4cFpgy5fG50Lc/aFu5uz49bSOFVcI4+u0PlU4TtoG
         jENA==
X-Gm-Message-State: AOJu0Yza5msrgKhufn/610RhTAP9BPbJsmhLYarQVceZSG7JXbB7U1NF
	1PTlc/+ju6wEW4kDKUclAZ6IeBgBT9wTmiJcgTCMc66WOtjs4VhFwfgs0wHv6A7QYrsrrH8KNyH
	mPFoe6TC6GcKYLSrboy/Q8IEscC4=
X-Google-Smtp-Source: AGHT+IEAF3InoyDEXWAiItUqOkiv1JX9skrt7pTPkubC+MICiNj2nIGK5Ddj5OHvEu9biyMMDHstpJYocgMQe2A5o9g=
X-Received: by 2002:a05:6a20:cf84:b0:1be:c41d:b6b7 with SMTP id
 adf61e73a8af0-1bef624385dmr9814666637.19.1719880976336; Mon, 01 Jul 2024
 17:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com> <20240629094733.3863850-9-eddyz87@gmail.com>
In-Reply-To: <20240629094733.3863850-9-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 17:42:44 -0700
Message-ID: <CAEf4BzbKauxUgFq83V7Nq-g5GXUOtDYok1mXibocBLwiosz+Jw@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 8/8] selftests/bpf: test no_caller_saved_registers
 spill/fill removal
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 2:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Tests for no_caller_saved_registers processing logic
> (see verifier.c:match_and_mark_nocsr_pattern()):
> - a canary positive test case;
> - various tests with broken patterns;
> - tests with read/write fixed/varying stack access that violate nocsr
>   stack access contract;
> - tests with multiple subprograms.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |   7 +
>  .../selftests/bpf/progs/verifier_nocsr.c      | 437 ++++++++++++++++++
>  2 files changed, 444 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_nocsr.c
>

You don't seem to have a case where offset is not a multiple of 8
(though it would have to be a sub-register spill which would be
"rejected" anyway, so not sure if there is anything to add here)

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 6816ff064516..8e056c36c549 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -53,6 +53,7 @@
>  #include "verifier_movsx.skel.h"
>  #include "verifier_netfilter_ctx.skel.h"
>  #include "verifier_netfilter_retcode.skel.h"
> +#include "verifier_nocsr.skel.h"
>  #include "verifier_precision.skel.h"
>  #include "verifier_prevent_map_lookup.skel.h"
>  #include "verifier_raw_stack.skel.h"
> @@ -171,6 +172,12 @@ void test_verifier_meta_access(void)          { RUN(=
verifier_meta_access); }
>  void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
>  void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_c=
tx); }
>  void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_r=
etcode); }
> +void test_verifier_nocsr(void)
> +{
> +#if defined(__x86_64__)
> +       RUN(verifier_nocsr);
> +#endif /* __x86_64__ */

maybe #else <mark-as-skipped> ?

> +}
>  void test_verifier_precision(void)            { RUN(verifier_precision);=
 }
>  void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map=
_lookup); }
>  void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack);=
 }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_nocsr.c b/tools/t=
esting/selftests/bpf/progs/verifier_nocsr.c
> new file mode 100644
> index 000000000000..5ddc2c97ada6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_nocsr.c
> @@ -0,0 +1,437 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +#define __xlated_bpf_get_smp_processor_id              \
> +       __xlated(": w0 =3D ")                             \

how will this work for no_alu32 mode?

> +       __xlated(": r0 =3D &(void __percpu *)(r0)")       \
> +       __xlated(": r0 =3D *(u32 *)(r0 +0)")
> +
> +SEC("raw_tp")
> +__xlated("4: r5 =3D 5")
> +__xlated_bpf_get_smp_processor_id
> +__xlated("8: exit")
> +__success
> +__naked void simple(void)
> +{
> +       asm volatile (
> +       "r1 =3D 1;"
> +       "r2 =3D 2;"
> +       "r3 =3D 3;"
> +       "r4 =3D 4;"
> +       "r5 =3D 5;"
> +       "*(u64 *)(r10 - 16) =3D r1;"
> +       "*(u64 *)(r10 - 24) =3D r2;"
> +       "*(u64 *)(r10 - 32) =3D r3;"
> +       "*(u64 *)(r10 - 40) =3D r4;"
> +       "*(u64 *)(r10 - 48) =3D r5;"
> +       "call %[bpf_get_smp_processor_id];"
> +       "r5 =3D *(u64 *)(r10 - 48);"
> +       "r4 =3D *(u64 *)(r10 - 40);"
> +       "r3 =3D *(u64 *)(r10 - 32);"
> +       "r2 =3D *(u64 *)(r10 - 24);"
> +       "r1 =3D *(u64 *)(r10 - 16);"
> +       "exit;"
> +       :
> +       : __imm(bpf_get_smp_processor_id)
> +       : __clobber_all);
> +}

[...]

