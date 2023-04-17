Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18EA6E4FA8
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjDQRxE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 13:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjDQRxD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 13:53:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609186A7C
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 10:52:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o9-20020a05600c510900b003f17012276fso2708546wms.4
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 10:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681753978; x=1684345978;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sshm0ERABfhwM6hxgypFqwwhQpHBnStmXx8Iw9l68EM=;
        b=seRj7/kybsiMImqTQH+C5gNOlShgRajhMm3pomJUnBs36k9Aj4laPIftyRVYFHyltc
         LtamZAbbFvt3W1cxX5W5n2Mfg+1uchMqYqHOhrmmsSRYg9msw5hRX5k9WTMaXLMUUQHV
         UMGYr8YHKC7m67nifH5cgnckQaCLQxkHwjppbxmkLyzuMDQxRmQF9QfXeqwm4NoeI/8V
         wE27STJPpu9lwMNxaoykLWT3OOjrn6rqSeculkvSk8SECAvTJhW5IFslSW7qt4YuAaf4
         qgwdUgoTJGtBf27/cxhF1bnI8oYeHZrHQZl3TD8Hv0ooSgH5oUFm/lgOYHrwlUxfwJG2
         3Alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753978; x=1684345978;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sshm0ERABfhwM6hxgypFqwwhQpHBnStmXx8Iw9l68EM=;
        b=Sv1BFS3WSeGaBsDtUNld24lof+ofWbut/rUoRC3gbvgnKaay5E77uHzIQPiyfhiJee
         TqvJeyg+tfVhBsMVflvCn073+qblPUDIFdFtBi51jzoF6rhlu/KYlNQAXSEeIzelkm0J
         CLMcuZjNehpsMiuMkWLtmpcQq4r1h2SY4Xr6S+MUXtqduTLQd0TxWgcYmNlC2A9dmjD0
         5o21zrc3ekAfQOJt4J0PAY9Dd+c6PmW/tHqvEPIFeqhJjVPBhMi/mkap2tLfEolD6L8F
         uksdQrEGH7wC/lYXNhplQN0BBa2sCo4dwQhU4+5D0tjw/ZN4tqesrGc48Td+W/GVJ7X7
         IVnA==
X-Gm-Message-State: AAQBX9dOavPrIMC2aar7BhOWnorUeXRDV3spSKSVIdZUAnoWyEuc/D78
        1nX7/S0imijaaJKuovDl0Gg=
X-Google-Smtp-Source: AKy350ay+SNlHeCg7fJpHyjbQcNbyXQKNXT22m/416vZnFR5Wt5AcqzHDOBeqV7aemJJRg5KiAIQfQ==
X-Received: by 2002:a7b:c7d6:0:b0:3ed:3268:5f35 with SMTP id z22-20020a7bc7d6000000b003ed32685f35mr11287671wmk.18.1681753977551;
        Mon, 17 Apr 2023 10:52:57 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c230f00b003f16fdc6233sm6143640wmo.47.2023.04.17.10.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:52:56 -0700 (PDT)
Message-ID: <f5fadb2274b4e7ddf09a6e6e65a92fed05be4169.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add a selftest for checking
 subreg equality
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Date:   Mon, 17 Apr 2023 20:52:55 +0300
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

Maybe add a few comments in the test case?
E.g.:

--- a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
+++ b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
@@ -13,10 +13,16 @@ __naked void subreg_equality(void)
        call %[bpf_ktime_get_ns];                       \
        *(u64 *)(r10 - 8) =3D r0;                         \
        r2 =3D *(u32 *)(r10 - 8);                         \
+       /* At this point upper 4-bytes of r2 are 0,     \
+        * thus the w3 =3D w2 should propagate register id, \
+        * so that w2 < 9 comparison would also propagate \
+        * range for r3.                                \
+        */                                             \
        w3 =3D w2;                                        \
        if w2 < 9 goto l0_%=3D;                           \
        exit;                                           \
 l0_%=3D: if r3 < 9 goto l1_%=3D;                           \
+       /* r1 read is illegal at this point */          \
        r0 -=3D r1;                                       \
 l1_%=3D: exit;                                           \
 "      :

Also, do we need a negative test?
(E.g. like this one but with r2 =3D r0 w/o u32 read from stack).

