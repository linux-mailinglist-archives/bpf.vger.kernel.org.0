Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616FC6E4F84
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 19:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjDQRow (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 13:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjDQRor (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 13:44:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661E57DBF
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 10:44:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d8-20020a05600c3ac800b003ee6e324b19so13500481wms.1
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681753477; x=1684345477;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=djkGFGmJPiQykcnQhkJjWDA4TFvepf8NEjqMKOiA1bM=;
        b=X+txT8sBxoTGp11fI3gEp9/+RnQsS9hznen+We2sU2GGJ7CVQDdfWz7Mbng3gV1AYz
         SEfGY42emJoFN2YPRF66lKTvgp1Ly15eGHPU6U7zvFJQnD7N1xqMeKNey5mVvkcs+Kqw
         2XgfYwD7o90Ar3N8BFic42P0LjKyuooPoNpgz8kn99q/5W6+74noRkkmfCE2GJCANTa3
         oPIrGtHUQi7gE5FpZVnIdT5EIfLQBHv61GqECu8QGXTJuHeSO/J6OWQoP+xtQn5imtr7
         ALjaR+R8bj67Jb8IDYhf4BOu2MKvjwPgJr2Pzdx3vSje+AqS9x4D/51Zil23FbbJJe/o
         jrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753477; x=1684345477;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=djkGFGmJPiQykcnQhkJjWDA4TFvepf8NEjqMKOiA1bM=;
        b=NUufGKZaUlNA8xvZVq9FMp2MXDaty9ii6Bzx92U4qDwSI8Ui3He3eqTe65uWGib7Hw
         +H4os4iD8yX0hKZyZd2AdGae3XFelIjWbTeBChuhb/wwXsQUzQ4CiZ2b2krUP2AlQB8y
         H0z/LyGplxSFtdOCJblods5BsebRIs4US7uadXtq1QgteRmDsZAa/3hLz1OXYnJ/fgO9
         QM9a5aUB/560kU/bG0MbUuZbMu4GxL3vZzRbf7wN9/E6n9Et3WA1NyB+sPnnz5Dfg8Jp
         jwesNm2pKdsSQq7iRmhZchacVLZ1BYFGAIPQoZs/WJs/d8HuwXc5iMjQhOIYtgSt6MdO
         8LVw==
X-Gm-Message-State: AAQBX9cPDvHk8zR8Uvy9QLEIxM/wKsH+YEEm1LUcgtiJJsTheVJEdo91
        n1m1Tgkh/cMBjS8u3ojvpZrgA8ikshc=
X-Google-Smtp-Source: AKy350YuTYgLVC36kG2YgRxq34ntG1yOEcFoB86TTum3+UTWJxa2OWa6ihXoWn8JXRoPYdPShHSsKQ==
X-Received: by 2002:a1c:4c18:0:b0:3f1:6e88:5785 with SMTP id z24-20020a1c4c18000000b003f16e885785mr5322225wmf.14.1681753476785;
        Mon, 17 Apr 2023 10:44:36 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b003f080b2f9f4sm16235592wmq.27.2023.04.17.10.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:44:36 -0700 (PDT)
Message-ID: <07ac6b82b6b3f4a5609ea087645199711a4aa7ba.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add a selftest for checking
 subreg equality
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Date:   Mon, 17 Apr 2023 20:44:35 +0300
In-Reply-To: <20230416232813.2389072-1-yhs@fb.com>
References: <20230416232808.2387432-1-yhs@fb.com>
         <20230416232813.2389072-1-yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 2023-04-16 at 16:28 -0700, Yonghong Song wrote:
> Add a selftest to ensure subreg equality if source register
> upper 32bit is 0. Without previous patch, the new test will
> fail verification.
>=20
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
>  .../selftests/bpf/prog_tests/verifier.c       |  2 ++
>  .../selftests/bpf/progs/verifier_reg_equal.c  | 27 +++++++++++++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_reg_equal.=
c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 73dff693d411..25bc8958dbfe 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -31,6 +31,7 @@
>  #include "verifier_meta_access.skel.h"
>  #include "verifier_raw_stack.skel.h"
>  #include "verifier_raw_tp_writable.skel.h"
> +#include "verifier_reg_equal.skel.h"
>  #include "verifier_ringbuf.skel.h"
>  #include "verifier_spill_fill.skel.h"
>  #include "verifier_stack_ptr.skel.h"
> @@ -95,6 +96,7 @@ void test_verifier_masking(void)              { RUN(ver=
ifier_masking); }
>  void test_verifier_meta_access(void)          { RUN(verifier_meta_access=
); }
>  void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack);=
 }
>  void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writ=
able); }
> +void test_verifier_reg_equal(void)            { RUN(verifier_reg_equal);=
 }
>  void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
>  void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill)=
; }
>  void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr);=
 }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c b/too=
ls/testing/selftests/bpf/progs/verifier_reg_equal.c
> new file mode 100644
> index 000000000000..91e42dec89ad
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +SEC("socket")
> +__description("check w reg equal if r reg upper32 bits 0")
> +__success
> +__naked void subreg_equality(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_ktime_get_ns];			\
> +	*(u64 *)(r10 - 8) =3D r0;				\
> +	r2 =3D *(u32 *)(r10 - 8);				\
> +	w3 =3D w2;					\
> +	if w2 < 9 goto l0_%=3D;				\
> +	exit;						\
> +l0_%=3D:	if r3 < 9 goto l1_%=3D;				\
> +	r0 -=3D r1;					\
> +l1_%=3D:	exit;						\
> +"	:
> +	: __imm(bpf_ktime_get_ns)
> +	: __clobber_all);
> +}
> +
> +char _license[] SEC("license") =3D "GPL";

