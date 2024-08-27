Return-Path: <bpf+bounces-38214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3362961A13
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 00:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD48284D30
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 22:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95F71D3656;
	Tue, 27 Aug 2024 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laGMwdkd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB67D176AD8
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724798409; cv=none; b=Sgup5dNKfRupW7Hvt7KoAZUC7Y2yVK76a/WwlVHR0XLGmEh41c5BeAEJJ9ajB/h4LdnX0JCQqnRtfrmSjp2IojAa3T227dwOGVmWBhWcVmTmn5ZNGMZi+ku97X9ZbctCsg2wFflx2DFw/MPvWlbnTD7fl6VMi861u05B+EenioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724798409; c=relaxed/simple;
	bh=mScWz+k8aRYTbjs9bXYRdtuisU4Q4ipuOaLisTMLFWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9bxoEvWbik49wQur20zlx4qCIlYIIuNAwd5UYO7+bsVWYJa49Wzob9qATA9Vl6gpE/vTL/Dxwgz8DERginliW1F/kRN5kVdSe1Q6qRuzb5vljwlJ6t0znU/meR4+gNmbrnPtf+UkoN5F1yXM6dsJNy4X5xLcg/B1q2F+20qloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laGMwdkd; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d439583573so4413189a91.3
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724798407; x=1725403207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaUbaJ/gL7mUOE16yxQCc8QT6cpq/+d6nAZ3+KUNtz8=;
        b=laGMwdkdUAjah43OtIzWPAyWYBDJwpktd/5M8ZzRvCERwWw25YeEpo7Xx7+gSxpKhD
         tTAC3gYi8QQvtfLNzRcfkwZzeGic0xu1p7CbSCrPC1aEvRno9uNSEL+htN7UOFoOMgnh
         OoaqcKJ+TWhd41vmqosmVGIMLUx1vtvVUV8/PVDwJkN9SgS3fdKCQTNt79DH5QR6mDDR
         RRXLg11bTjMzMRxc14Ji43zvAKggt/ahbmrIIc5gn8WQLgc2JfJV3R5i7g8Q36BQ35Ob
         YjGJc2Bb8K510QyWKDLGiLpPT4VWxvoAvS/gPWp+hP4V7CgZi+wG9tZsKYlA93/cxonJ
         OjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724798407; x=1725403207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaUbaJ/gL7mUOE16yxQCc8QT6cpq/+d6nAZ3+KUNtz8=;
        b=WaYSDghtuSjkvRg1VbAYDafqdcxxXQtBtqAvuMqh0XkxoaULuWHPIX1okTo9O1koRj
         3C+hAfkzLT+GY9DRA+KFRa266EHff5y5lNK6IW8kbBUguwJpbOLJ4h+RsfamTs6/A7Wh
         7hR40dzteRvhhsu3OVgqDe+2JKrn9OYjiwE5QW8KxNgV48jPLlILBz0i7kcFP03aCKo9
         CMOcT6EnVPwJbNeGASxxbM9dH/f8hKTF7JRSfF/BrW41+OAiSpbho8p6xVweIbDUls08
         idJzZv9WDFxjiTwIeFE6x95/K1kYP3TSaXFbV352O9yhqkqN1tuimRcQGh4zwwoyIOr8
         VnXg==
X-Gm-Message-State: AOJu0Yy6byqn/2I5F9MdmBvQFrTb1WgmFP9+E+0jrKDFXlXrKo36E7hB
	x97UARF0Kq4N4+4AHZnphXwnxyPe6ZudlJZIYo0Z/y2ijUwEeSIUDUIwZGuffBCqtogRjeGMvtK
	3rff5efs8FIx6bk4DlWN+14Yhw+M=
X-Google-Smtp-Source: AGHT+IEPW4DPNhdas4vRpdntlkZiTRxVbHyRFIsw+1k1F5kMf9Td5V52RKBU2RlDrepXH6cfp/Q+0r1JRi/Dyy2PMmc=
X-Received: by 2002:a17:90a:987:b0:2c9:63ef:95b9 with SMTP id
 98e67ed59e1d1-2d8440e7e96mr219037a91.14.1724798406889; Tue, 27 Aug 2024
 15:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823222033.31006-1-daniel@iogearbox.net> <20240823222033.31006-4-daniel@iogearbox.net>
In-Reply-To: <20240823222033.31006-4-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Aug 2024 15:39:54 -0700
Message-ID: <CAEf4BzbTKGi0+2y84oRH=q5ZjhAQ8SMJAOrq8f0GnNjZaqf++g@mail.gmail.com>
Subject: Re: [PATCH bpf 4/4] selftests/bpf: Add a test case to write into .rodata
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 3:20=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
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
> ---
>  .../selftests/bpf/prog_tests/tc_links.c       |  1 +
>  .../selftests/bpf/prog_tests/verifier.c       |  2 +
>  .../selftests/bpf/progs/verifier_const.c      | 42 +++++++++++++++++++
>  3 files changed, 45 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_const.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/te=
sting/selftests/bpf/prog_tests/tc_links.c
> index 1af9ec1149aa..92c647dfd6f1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
> @@ -9,6 +9,7 @@
>  #define ping_cmd "ping -q -c1 -w1 127.0.0.1 > /dev/null"
>
>  #include "test_tc_link.skel.h"
> +#include "test_const.skel.h"
>
>  #include "netlink_helpers.h"
>  #include "tc_helpers.h"
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 9dc3687bc406..c0cb1a145274 100644
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
> @@ -140,6 +141,7 @@ void test_verifier_cfg(void)                  { RUN(v=
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
> index 000000000000..81302d9738fa
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
> +const long foo =3D 42;

nit: would be "safer" to mark it as "const volatile long" to prevent
whatever smartness compiler might decide to do

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
>

