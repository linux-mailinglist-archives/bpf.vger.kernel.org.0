Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F866B113C
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 19:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCHSn0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 13:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCHSn0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 13:43:26 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECDE61328
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 10:43:24 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x3so69462216edb.10
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 10:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678301003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHKEkKo2f+bJa/v4EILQnxriheiTilRQhx4AsC8l8Ws=;
        b=NoPAC6bOfsa8mD7qYXm+I28yznZUnknI6yiKpEHG2eN/uF8ijha/HhEc4d9yN7AxCw
         1zZght1MvoONkva4JcHmNF1VIDzxNPaZU6rzUpSCkwbQJLqoZUyZBzDTljgVmN5Pn+3O
         PQXCT2Qo3HYgHICsqx3t5HIIGU7ARboiLgJ6W7RcS1AI9tY8voF+jPHAfIdWNxJ62E+4
         Kr54Hkhr+pbcrdYk/4W+uJGpR/c7D2TL+nch+7pC0ecrfyX9yFJBahVy2rsov+G6WAg6
         ldPA7OdeHoL6LyiticsuqcgkEgOcyxzbdR8+HKCgx3w5cCS6xC0KDRmg/RIOeJAGz5sP
         1ZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678301003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHKEkKo2f+bJa/v4EILQnxriheiTilRQhx4AsC8l8Ws=;
        b=1zC1e1epZAnZ4/43Xxm3pP6XrzThxGUELhNEElM89857K0cyxK8bCzBFyq7v3GvCas
         ZLV+4ermQiKKMOIjYynnlm3smOZcOGdrznVzSVh+ebuu4QJOoIcOTgH1TMjlSFJ2damS
         0PmCJY+Eyj767H5LKvwPgqXW27nOGcGvZTyX5Tozb45/Ep1B3OPSv/QAjcdVstNbFWKr
         6wsPULipBrvvuaQvn3+O9MmAf6SF2Rt6Ah1ATiCwsNtEQfdmizrE1MQpNDkUQzVsdW6L
         sqVzZPJRYj+TSqVG/802xia9by2jzWW4yOTuwCvpSNQc2UBVE2LsI6685HVHI/eiJocM
         pjKQ==
X-Gm-Message-State: AO0yUKXgcjUrO84vIBmCERiJUxvceySiwCynQrcjC7ex5CU6ZnLJmGTE
        kcyYc+jpJXbtF99UmQK6yB0zegrrVsQDCLSufcc=
X-Google-Smtp-Source: AK7set/110iruZFsekFxAqoaG3KWXgZi8oMbG8aeXN3bB+zw5Ghnu7ixK0mNNfThrG8aoFV66MS/QfynY1Rs1ksyHLA=
X-Received: by 2002:a50:9f8b:0:b0:4ad:7265:82db with SMTP id
 c11-20020a509f8b000000b004ad726582dbmr10608426edf.1.1678301002643; Wed, 08
 Mar 2023 10:43:22 -0800 (PST)
MIME-Version: 1.0
References: <20230307233307.3626875-1-kuifeng@meta.com> <20230307233307.3626875-10-kuifeng@meta.com>
 <CAEf4BzauUuFYfUVFSRY6u=NmVUfbmY1pH-p7yXMEWFN1SDjejA@mail.gmail.com>
 <8678e7e0-ae7a-3230-89d8-af071f800b04@gmail.com> <CAEf4BzYMxyrcbRg+BN2xCM8a5g3E5eCxrJWC22fAWFg4YNWw5w@mail.gmail.com>
 <b3867a6b-12fc-2eee-83eb-09d520058620@gmail.com>
In-Reply-To: <b3867a6b-12fc-2eee-83eb-09d520058620@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Mar 2023 10:43:09 -0800
Message-ID: <CAEf4BzYS1MTuHP2=ijGiF7MBBOEJTxZfMNCcFz1RUx7my87efQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 9/9] selftests/bpf: Test switching TCP
 Congestion Control algorithms.
To:     Kui-Feng Lee <sinquersw@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
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

On Wed, Mar 8, 2023 at 10:10=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 3/8/23 09:18, Andrii Nakryiko wrote:
> > On Wed, Mar 8, 2023 at 7:58=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.co=
m> wrote:
> >>
> >>
> >>
> >> On 3/7/23 17:10, Andrii Nakryiko wrote:
> >>> On Tue, Mar 7, 2023 at 3:34=E2=80=AFPM Kui-Feng Lee <kuifeng@meta.com=
> wrote:
> >>>>
> >>>> Create a pair of sockets that utilize the congestion control algorit=
hm
> >>>> under a particular name. Then switch up this congestion control
> >>>> algorithm to another implementation and check whether newly created
> >>>> connections using the same cc name now run the new implementation.
> >>>>
> >>>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> >>>> ---
> >>>>    .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 38 ++++++++++++
> >>>>    .../selftests/bpf/progs/tcp_ca_update.c       | 62 ++++++++++++++=
+++++
> >>>>    2 files changed, 100 insertions(+)
> >>>>    create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_updat=
e.c
> >>>>
> >>>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/t=
ools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> >>>> index e980188d4124..caaa9175ee36 100644
> >>>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> >>>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> >>>> @@ -8,6 +8,7 @@
> >>>>    #include "bpf_dctcp.skel.h"
> >>>>    #include "bpf_cubic.skel.h"
> >>>>    #include "bpf_tcp_nogpl.skel.h"
> >>>> +#include "tcp_ca_update.skel.h"
> >>>>    #include "bpf_dctcp_release.skel.h"
> >>>>    #include "tcp_ca_write_sk_pacing.skel.h"
> >>>>    #include "tcp_ca_incompl_cong_ops.skel.h"
> >>>> @@ -381,6 +382,41 @@ static void test_unsupp_cong_op(void)
> >>>>           libbpf_set_print(old_print_fn);
> >>>>    }
> >>>>
> >>>> +static void test_update_ca(void)
> >>>> +{
> >>>> +       struct tcp_ca_update *skel;
> >>>> +       struct bpf_link *link;
> >>>> +       int saved_ca1_cnt;
> >>>> +       int err;
> >>>> +
> >>>> +       skel =3D tcp_ca_update__open();
> >>>> +       if (!ASSERT_OK_PTR(skel, "open"))
> >>>> +               return;
> >>>> +
> >>>> +       err =3D tcp_ca_update__load(skel);
> >>>
> >>> tcp_ca_update__open_and_load()
> >>>
> >>>> +       if (!ASSERT_OK(err, "load")) {
> >>>> +               tcp_ca_update__destroy(skel);
> >>>> +               return;
> >>>> +       }
> >>>> +
> >>>> +       link =3D bpf_map__attach_struct_ops(skel->maps.ca_update_1);
> >>>
> >>> I think it's time to generate link holder for each struct_ops map to
> >>> the BPF skeleton, and support auto-attach of struct_ops skeleton.
> >>> Please do that as a follow up, once this patch set lands.
> >>
> >> Got it.
> >>
> >>>
> >>>> +       ASSERT_OK_PTR(link, "attach_struct_ops");
> >>>> +
> >>>> +       do_test("tcp_ca_update", NULL);
> >>>> +       saved_ca1_cnt =3D skel->bss->ca1_cnt;
> >>>> +       ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
> >>>> +
> >>>> +       err =3D bpf_link__update_map(link, skel->maps.ca_update_2);
> >>>> +       ASSERT_OK(err, "update_struct_ops");
> >>>> +
> >>>> +       do_test("tcp_ca_update", NULL);
> >>>> +       ASSERT_EQ(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
> >>>> +       ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
> >>>
> >>> how do we know that struct_ops programs were triggered? what
> >>> guarantees that? if nothing, we are just adding another flaky
> >>> networking test
> >>
> >> When an ack is received, cong_control of ca_update_1 and ca_update_2
> >> will be called if they are activated.  By checking ca1_cnt & ca2_cnt, =
we
> >> know which one is activated.  Here, we check if the ca1_cnt keeps the
> >> same and ca2_cnt increase to make that ca_update_2 have replaced
> >> ca_update_1.
> >
> > I just don't see anything in the test ensuring that ack is
> > sent/received, so it seems like we are relying on some background
> > system activity and proper timing (unless I miss something, which is
> > why I'm asking), so this is fragile, as in CI environment timings and
> > background activity would be very different and unpredictable, causing
> > flakiness of the test
>
>
> The do_test() function creates two sockets to form a direct connection
> that must receive at least one acknowledgment packet for the sockets to
> progress into an ESTABLISHED state.  If they don't, that means it fails
> to establish a connection.

yeah, my bad, I *completely* missed `do_test("tcp_ca_update", NULL)`
(even though I went specifically looking for something like that).
It's all good here.


>
> >
> >>
> >>>
> >>>> +
> >>>> +       bpf_link__destroy(link);
> >>>> +       tcp_ca_update__destroy(skel);
> >>>> +}
> >>>> +
> >>>>    void test_bpf_tcp_ca(void)
> >>>>    {
> >>>>           if (test__start_subtest("dctcp"))
> >>>> @@ -399,4 +435,6 @@ void test_bpf_tcp_ca(void)
> >>>>                   test_incompl_cong_ops();
> >>>>           if (test__start_subtest("unsupp_cong_op"))
> >>>>                   test_unsupp_cong_op();
> >>>> +       if (test__start_subtest("update_ca"))
> >>>> +               test_update_ca();
> >>>>    }
> >>>> diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_update.c b/too=
ls/testing/selftests/bpf/progs/tcp_ca_update.c
> >>>> new file mode 100644
> >>>> index 000000000000..36a04be95df5
> >>>> --- /dev/null
> >>>> +++ b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
> >>>> @@ -0,0 +1,62 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +
> >>>> +#include "vmlinux.h"
> >>>> +
> >>>> +#include <bpf/bpf_helpers.h>
> >>>> +#include <bpf/bpf_tracing.h>
> >>>> +
> >>>> +char _license[] SEC("license") =3D "GPL";
> >>>> +
> >>>> +int ca1_cnt =3D 0;
> >>>> +int ca2_cnt =3D 0;
> >>>> +
> >>>> +#define USEC_PER_SEC 1000000UL
> >>>> +
> >>>> +#define min(a, b) ((a) < (b) ? (a) : (b))
> >>>> +
> >>>> +static inline struct tcp_sock *tcp_sk(const struct sock *sk)
> >>>> +{
> >>>> +       return (struct tcp_sock *)sk;
> >>>> +}
> >>>> +
> >>>> +SEC("struct_ops/ca_update_1_cong_control")
> >>>> +void BPF_PROG(ca_update_1_cong_control, struct sock *sk,
> >>>> +             const struct rate_sample *rs)
> >>>> +{
> >>>> +       ca1_cnt++;
> >>>> +}
> >>>> +
> >>>> +SEC("struct_ops/ca_update_2_cong_control")
> >>>> +void BPF_PROG(ca_update_2_cong_control, struct sock *sk,
> >>>> +             const struct rate_sample *rs)
> >>>> +{
> >>>> +       ca2_cnt++;
> >>>> +}
> >>>> +
> >>>> +SEC("struct_ops/ca_update_ssthresh")
> >>>> +__u32 BPF_PROG(ca_update_ssthresh, struct sock *sk)
> >>>> +{
> >>>> +       return tcp_sk(sk)->snd_ssthresh;
> >>>> +}
> >>>> +
> >>>> +SEC("struct_ops/ca_update_undo_cwnd")
> >>>> +__u32 BPF_PROG(ca_update_undo_cwnd, struct sock *sk)
> >>>> +{
> >>>> +       return tcp_sk(sk)->snd_cwnd;
> >>>> +}
> >>>> +
> >>>> +SEC(".struct_ops.link")
> >>>> +struct tcp_congestion_ops ca_update_1 =3D {
> >>>> +       .cong_control =3D (void *)ca_update_1_cong_control,
> >>>> +       .ssthresh =3D (void *)ca_update_ssthresh,
> >>>> +       .undo_cwnd =3D (void *)ca_update_undo_cwnd,
> >>>> +       .name =3D "tcp_ca_update",
> >>>> +};
> >>>> +
> >>>> +SEC(".struct_ops.link")
> >>>> +struct tcp_congestion_ops ca_update_2 =3D {
> >>>> +       .cong_control =3D (void *)ca_update_2_cong_control,
> >>>> +       .ssthresh =3D (void *)ca_update_ssthresh,
> >>>> +       .undo_cwnd =3D (void *)ca_update_undo_cwnd,
> >>>> +       .name =3D "tcp_ca_update",
> >>>> +};
> >>>
> >>> please add a test where you combine both .struct_ops and
> >>> .struct_ops.link, it's an obvious potentially problematic combination
> >>>
> >>> as I mentioned in previous patches, let's also have a negative test
> >>> where bpf_link__update_map() fails
> >>
> >> Sure
> >>
> >>>
> >>>> --
> >>>> 2.34.1
> >>>>
