Return-Path: <bpf+bounces-8195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1A47835F0
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 00:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB23A1C209E7
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 22:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2943511713;
	Mon, 21 Aug 2023 22:45:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC21FC4
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:45:53 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AF91B0
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 15:45:45 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso5771396e87.2
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 15:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692657944; x=1693262744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DMvWUglQqYbzvi/5bQc2fcR994//9RRTeZRAQRPcpE=;
        b=BOWpYSceqxmNStS+zEnrMgm25+ZdHHjslMrF6JMFqFzsYJh36nyufudbiHoHoQ52Wa
         zJX6uBMqC4XLX1Dpvq0HA3OXGgfeGnBCe2MyxHnChT2kkuzGkWtL7JNoGecjCFq62Fzg
         KhwqA/ii7Ta5dQ36rvTSLlZ+UylMtK/SU0+LN3NljRxreTAgIkRi1DoRANDoc91DW+Nk
         u07xafm3sw/V0h+ZLV+Hla9b04kfa9fxy2bAYDlcE8+YyhgKOwAhpWosNfSVaCmVe6fD
         P2lRnmhVmNHD931nWuLxQA6bmvf6iYIRtnivj3ZRgaj0REs8TI4OgMHX0WqozZYsPSfx
         mTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692657944; x=1693262744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DMvWUglQqYbzvi/5bQc2fcR994//9RRTeZRAQRPcpE=;
        b=ZzMzRFUX90XrRXA0+sOcuiA0cRi3ezt11cA0V5jZnsxsPU5ONGfbgFMi2ei70vWjWc
         PHTa2KBYZ25a4c+PipO4IYaeYzdiaYg24zqoZayHrrwVQmgUTPZieGpUQ6Pyc+XKv32r
         OG92pSHVQpMIWxoA5JoMi3GZfb/2wyxIpMs68WxYXaXS2MbB73UltFcZLn/DYMxZ5sks
         A8CYBxZkjnTYEGevKIL3PQghTcLh+xwSKqFwn+VsfYPj4zbV5iax6q4sfPLUYvklenUr
         2cjXN3v7tAQ7A67qGLjPcQxrPP1C5ih7T64fGugilp20NLOM4MTjiCsdiJT+b8hENf4b
         kB2A==
X-Gm-Message-State: AOJu0Yzbprfj7xxHcNfO4y7r1WqRXaeCgmgY8MX8+B5KckbJhfMBGu3A
	1PjCEroJsb31gu+//tcVAOWddVIK/4FyCgQnEg8=
X-Google-Smtp-Source: AGHT+IHAL13MR8/zeSoCFiQ8buvmhOasmtAwVfCz9OrggudhLt7FKZ6T4feOYeGMzndQ1XajYmN9Y/f+wUv/A1P3biE=
X-Received: by 2002:a19:4f42:0:b0:500:7881:7b2f with SMTP id
 a2-20020a194f42000000b0050078817b2fmr3959038lfk.54.1692657943670; Mon, 21 Aug
 2023 15:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230818083920.3771-1-laoar.shao@gmail.com> <20230818083920.3771-3-laoar.shao@gmail.com>
In-Reply-To: <20230818083920.3771-3-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Aug 2023 15:45:32 -0700
Message-ID: <CAADnVQJ-BcSfPVL4J8DPA0XXgWtfUSXDzjnNeQvf1Z2SAASQ2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for allow_ptr_leaks
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 1:39=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> - Without prev commit
>
>   $ tools/testing/selftests/bpf/test_progs --name=3Dtc_bpf
>   #232/1   tc_bpf/tc_bpf_root:OK
>   test_tc_bpf_non_root:PASS:set_cap_bpf_cap_net_admin 0 nsec
>   test_tc_bpf_non_root:PASS:disable_cap_sys_admin 0 nsec
>   0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
>   ; if ((long)(iph + 1) > (long)skb->data_end)
>   0: (61) r2 =3D *(u32 *)(r1 +80)         ; R1=3Dctx(off=3D0,imm=3D0) R2_=
w=3Dpkt_end(off=3D0,imm=3D0)
>   ; struct iphdr *iph =3D (void *)(long)skb->data + sizeof(struct ethhdr)=
;
>   1: (61) r1 =3D *(u32 *)(r1 +76)         ; R1_w=3Dpkt(off=3D0,r=3D0,imm=
=3D0)
>   ; if ((long)(iph + 1) > (long)skb->data_end)
>   2: (07) r1 +=3D 34                      ; R1_w=3Dpkt(off=3D34,r=3D0,imm=
=3D0)
>   3: (b4) w0 =3D 1                        ; R0_w=3D1
>   4: (2d) if r1 > r2 goto pc+1
>   R2 pointer comparison prohibited
>   processed 5 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
>   test_tc_bpf_non_root:FAIL:test_tc_bpf__open_and_load unexpected error: =
-13
>   #233/2   tc_bpf_non_root:FAIL
>
> - With prev commit
>
>   $ tools/testing/selftests/bpf/test_progs --name=3Dtc_bpf
>   #232/1   tc_bpf/tc_bpf_root:OK
>   #232/2   tc_bpf/tc_bpf_non_root:OK
>   #232     tc_bpf:OK
>   Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/tc_bpf.c | 36 +++++++++++++++++++=
+++++-
>  tools/testing/selftests/bpf/progs/test_tc_bpf.c | 14 ++++++++++
>  2 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_bpf.c b/tools/test=
ing/selftests/bpf/prog_tests/tc_bpf.c
> index e873766..48b5553 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
> @@ -3,6 +3,7 @@
>  #include <test_progs.h>
>  #include <linux/pkt_cls.h>
>
> +#include "cap_helpers.h"
>  #include "test_tc_bpf.skel.h"
>
>  #define LO_IFINDEX 1
> @@ -327,7 +328,7 @@ static int test_tc_bpf_api(struct bpf_tc_hook *hook, =
int fd)
>         return 0;
>  }
>
> -void test_tc_bpf(void)
> +void tc_bpf_root(void)
>  {
>         DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex =3D LO_IFINDEX,
>                             .attach_point =3D BPF_TC_INGRESS);
> @@ -393,3 +394,36 @@ void test_tc_bpf(void)
>         }
>         test_tc_bpf__destroy(skel);
>  }
> +
> +void tc_bpf_non_root(void)
> +{
> +       struct test_tc_bpf *skel =3D NULL;
> +       __u64 caps =3D 0;
> +       int ret;
> +
> +       /* In case CAP_BPF and CAP_PERFMON is not set */
> +       ret =3D cap_enable_effective(1ULL << CAP_BPF | 1ULL << CAP_NET_AD=
MIN, &caps);
> +       if (!ASSERT_OK(ret, "set_cap_bpf_cap_net_admin"))
> +               return;
> +       ret =3D cap_disable_effective(1ULL << CAP_SYS_ADMIN | 1ULL << CAP=
_PERFMON, NULL);
> +       if (!ASSERT_OK(ret, "disable_cap_sys_admin"))
> +               goto restore_cap;
> +
> +       skel =3D test_tc_bpf__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "test_tc_bpf__open_and_load"))
> +               goto restore_cap;
> +
> +       test_tc_bpf__destroy(skel);
> +
> +restore_cap:
> +       if (caps)
> +               cap_enable_effective(caps, NULL);
> +}
> +
> +void test_tc_bpf(void)
> +{
> +       if (test__start_subtest("tc_bpf_root"))
> +               tc_bpf_root();
> +       if (test__start_subtest("tc_bpf_non_root"))
> +               tc_bpf_non_root();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_tc_bpf.c b/tools/test=
ing/selftests/bpf/progs/test_tc_bpf.c
> index d28ca8d..3e0f218 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_bpf.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_bpf.c
> @@ -1,5 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include <linux/pkt_cls.h>
> +#include <linux/ip.h>
> +#include <linux/if_ether.h>

Due to above it fails to compile:

In file included from progs/test_tc_bpf.c:4:
In file included from /usr/include/linux/ip.h:21:
In file included from /usr/include/asm/byteorder.h:5:
In file included from /usr/include/linux/byteorder/little_endian.h:13:
/usr/include/linux/swab.h:136:8: error: unknown type name '__always_inline'
  136 | static __always_inline unsigned long __swab(const unsigned long y)
      |        ^

