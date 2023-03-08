Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397136AFBCB
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 02:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCHBLN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 20:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCHBLM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 20:11:12 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27547A226F
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 17:11:11 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u9so59834743edd.2
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 17:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678237869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZP4XhiOM5sZYoKXpjOOp/xp0FoqJT2dyXpdTManNbY=;
        b=Ekhdg76PKQqfc1Hr9fjwC3/tPf6b/DeaHe4+4r1WgYwIa+TP+kzYmyKwsYPFfyGhv7
         j6TzNTW42Mh2SpgIIBBXkxDkVj8sibxBcYJaN6SjS5EbdcksMe4hKpIGgQvTLRJz8/OE
         PFnLMeYkJNfuLK0BM/jFMusorwlKt1QEC9/i2GbrP+Q/+qsuCXtH7Led+HJBPkcLCke1
         gUDqTXtguglCrzpkB9Kya9NS4540lWTIx15qS4OD2hdbqP3mZIC4ZblLv/ef/DC2C4d9
         HkdwV22sNdVs9AeFOYVf8u8oV8vNdl2B3jjJKNujOqBqpFiV7T4LVDofZFOdiJQ31XOh
         n7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678237869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZP4XhiOM5sZYoKXpjOOp/xp0FoqJT2dyXpdTManNbY=;
        b=gNzHl7nR0qlLnNpNZNicMtMSGqIbtsuGiYdt9DvlMtqxI2+/imIVxRdILGhi+isJLV
         rLa+HxzUXwjGbwpGZ0FqFwnJ8S/cokayoGtfBq/vneKxCl5JiBTrRESFKzXOnW/cE8k6
         gAxWS80CUjqc1W+IyXOOcQAopVARwwKRsWDT2K9rpmyx0SOx1S9JzkSHnb+6F0VDyVcm
         7rBp+QMJsTkYKDfzV/OiR8LVhZTp+ekg5eTPf9AZcFCJEH5krUIUVyVYIbtmGLYqiOWk
         7ohfO0yk0AKjX4i7MI70l/59A2g4F40edznHBJUq//+hJfcHWn06v8S4wcSSkp0Q1EMd
         2biw==
X-Gm-Message-State: AO0yUKXXw+ssPxWLnYpGuGVrrrtQTOmgB14Ed/nuXJx64cplJQeNdTSp
        2Pn8fNbW+ZoKtYGSJ/lGDwD1a9Ngbxwwl3ZLBZ4=
X-Google-Smtp-Source: AK7set8/kotMTN2zTW3fFH2Vy/iuq0Dbn4GeOgPjw++niyYwyB0YRqLTND82eygPNugadqZEAMU98k65O2FPyE7WDUg=
X-Received: by 2002:a17:906:4bcb:b0:8b1:28f6:8ab3 with SMTP id
 x11-20020a1709064bcb00b008b128f68ab3mr8259961ejv.15.1678237869567; Tue, 07
 Mar 2023 17:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20230307233307.3626875-1-kuifeng@meta.com> <20230307233307.3626875-10-kuifeng@meta.com>
In-Reply-To: <20230307233307.3626875-10-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 17:10:57 -0800
Message-ID: <CAEf4BzauUuFYfUVFSRY6u=NmVUfbmY1pH-p7yXMEWFN1SDjejA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 9/9] selftests/bpf: Test switching TCP
 Congestion Control algorithms.
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 7, 2023 at 3:34=E2=80=AFPM Kui-Feng Lee <kuifeng@meta.com> wrot=
e:
>
> Create a pair of sockets that utilize the congestion control algorithm
> under a particular name. Then switch up this congestion control
> algorithm to another implementation and check whether newly created
> connections using the same cc name now run the new implementation.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 38 ++++++++++++
>  .../selftests/bpf/progs/tcp_ca_update.c       | 62 +++++++++++++++++++
>  2 files changed, 100 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index e980188d4124..caaa9175ee36 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> @@ -8,6 +8,7 @@
>  #include "bpf_dctcp.skel.h"
>  #include "bpf_cubic.skel.h"
>  #include "bpf_tcp_nogpl.skel.h"
> +#include "tcp_ca_update.skel.h"
>  #include "bpf_dctcp_release.skel.h"
>  #include "tcp_ca_write_sk_pacing.skel.h"
>  #include "tcp_ca_incompl_cong_ops.skel.h"
> @@ -381,6 +382,41 @@ static void test_unsupp_cong_op(void)
>         libbpf_set_print(old_print_fn);
>  }
>
> +static void test_update_ca(void)
> +{
> +       struct tcp_ca_update *skel;
> +       struct bpf_link *link;
> +       int saved_ca1_cnt;
> +       int err;
> +
> +       skel =3D tcp_ca_update__open();
> +       if (!ASSERT_OK_PTR(skel, "open"))
> +               return;
> +
> +       err =3D tcp_ca_update__load(skel);

tcp_ca_update__open_and_load()

> +       if (!ASSERT_OK(err, "load")) {
> +               tcp_ca_update__destroy(skel);
> +               return;
> +       }
> +
> +       link =3D bpf_map__attach_struct_ops(skel->maps.ca_update_1);

I think it's time to generate link holder for each struct_ops map to
the BPF skeleton, and support auto-attach of struct_ops skeleton.
Please do that as a follow up, once this patch set lands.

> +       ASSERT_OK_PTR(link, "attach_struct_ops");
> +
> +       do_test("tcp_ca_update", NULL);
> +       saved_ca1_cnt =3D skel->bss->ca1_cnt;
> +       ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
> +
> +       err =3D bpf_link__update_map(link, skel->maps.ca_update_2);
> +       ASSERT_OK(err, "update_struct_ops");
> +
> +       do_test("tcp_ca_update", NULL);
> +       ASSERT_EQ(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
> +       ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");

how do we know that struct_ops programs were triggered? what
guarantees that? if nothing, we are just adding another flaky
networking test

> +
> +       bpf_link__destroy(link);
> +       tcp_ca_update__destroy(skel);
> +}
> +
>  void test_bpf_tcp_ca(void)
>  {
>         if (test__start_subtest("dctcp"))
> @@ -399,4 +435,6 @@ void test_bpf_tcp_ca(void)
>                 test_incompl_cong_ops();
>         if (test__start_subtest("unsupp_cong_op"))
>                 test_unsupp_cong_op();
> +       if (test__start_subtest("update_ca"))
> +               test_update_ca();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_update.c b/tools/te=
sting/selftests/bpf/progs/tcp_ca_update.c
> new file mode 100644
> index 000000000000..36a04be95df5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +int ca1_cnt =3D 0;
> +int ca2_cnt =3D 0;
> +
> +#define USEC_PER_SEC 1000000UL
> +
> +#define min(a, b) ((a) < (b) ? (a) : (b))
> +
> +static inline struct tcp_sock *tcp_sk(const struct sock *sk)
> +{
> +       return (struct tcp_sock *)sk;
> +}
> +
> +SEC("struct_ops/ca_update_1_cong_control")
> +void BPF_PROG(ca_update_1_cong_control, struct sock *sk,
> +             const struct rate_sample *rs)
> +{
> +       ca1_cnt++;
> +}
> +
> +SEC("struct_ops/ca_update_2_cong_control")
> +void BPF_PROG(ca_update_2_cong_control, struct sock *sk,
> +             const struct rate_sample *rs)
> +{
> +       ca2_cnt++;
> +}
> +
> +SEC("struct_ops/ca_update_ssthresh")
> +__u32 BPF_PROG(ca_update_ssthresh, struct sock *sk)
> +{
> +       return tcp_sk(sk)->snd_ssthresh;
> +}
> +
> +SEC("struct_ops/ca_update_undo_cwnd")
> +__u32 BPF_PROG(ca_update_undo_cwnd, struct sock *sk)
> +{
> +       return tcp_sk(sk)->snd_cwnd;
> +}
> +
> +SEC(".struct_ops.link")
> +struct tcp_congestion_ops ca_update_1 =3D {
> +       .cong_control =3D (void *)ca_update_1_cong_control,
> +       .ssthresh =3D (void *)ca_update_ssthresh,
> +       .undo_cwnd =3D (void *)ca_update_undo_cwnd,
> +       .name =3D "tcp_ca_update",
> +};
> +
> +SEC(".struct_ops.link")
> +struct tcp_congestion_ops ca_update_2 =3D {
> +       .cong_control =3D (void *)ca_update_2_cong_control,
> +       .ssthresh =3D (void *)ca_update_ssthresh,
> +       .undo_cwnd =3D (void *)ca_update_undo_cwnd,
> +       .name =3D "tcp_ca_update",
> +};

please add a test where you combine both .struct_ops and
.struct_ops.link, it's an obvious potentially problematic combination

as I mentioned in previous patches, let's also have a negative test
where bpf_link__update_map() fails

> --
> 2.34.1
>
