Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521EF6661C1
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 18:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbjAKR0t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 12:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbjAKR0U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 12:26:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861FE35912
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 09:23:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D837BB81C94
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 17:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93201C43392
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 17:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673457765;
        bh=0EwjWBcGzYtrkXJvozst7vss4Aw2LwlIyhfVLIiUSRw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZaP7OuSOT05ceXj6tetTa7nHO+LaqNDdh7rH6K93rs4/pT+LV2W2Kc0ONWaebk3X4
         lzMmyyCSh4pi4nIcIe8kLozwBNPynTqkIUDrIj9spVOGGs9md9R1oxnIbMwMovtzk8
         2Wv63e2Vb477iOYX6OS3jPCgBjfKDd2gb5PXqTLFa0AXkp0ktmsK05jer+Z/Xz8A3p
         sJsSH+eOWQkBgAKgrZoxNOtodXrLqz2g0apVo8C+z1ckkHq92+B0Vn+isH4YxnRiSA
         hG7MUWo28B3RSwc2ksOAy+4mb2i9k1s2fO338ItJNSaNXQ4Cp73saxHsYROu9PgM5y
         /mp85zaTMwFhg==
Received: by mail-lj1-f178.google.com with SMTP id bn6so16710530ljb.13
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 09:22:45 -0800 (PST)
X-Gm-Message-State: AFqh2kpTExTtvYQYfscOdMAZOZNHKC9CIBRemX77Hff4ZZ82T0Grpq8+
        ZjLpPE2wgy8NTz0uXPl8SaOFASzB/qcA1CW5y4o=
X-Google-Smtp-Source: AMrXdXtb7KV7Un+eg3Tm+03DP4dBhsTXuh23n1GYKHB/WYdAQO0iwKV/wYV1GeuJRSh0YjnwED7hg5GHK3H8c1oPfXQ=
X-Received: by 2002:a05:651c:11d0:b0:289:1305:680d with SMTP id
 z16-20020a05651c11d000b002891305680dmr90846ljo.421.1673457763610; Wed, 11 Jan
 2023 09:22:43 -0800 (PST)
MIME-Version: 1.0
References: <20230111101142.562765-1-jolsa@kernel.org> <20230111101142.562765-2-jolsa@kernel.org>
In-Reply-To: <20230111101142.562765-2-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 11 Jan 2023 09:22:30 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7R1q8KpScVEANQ-Hm4_FFWvj96iGSdaKgY_PvRwYmr8g@mail.gmail.com>
Message-ID: <CAPhsuW7R1q8KpScVEANQ-Hm4_FFWvj96iGSdaKgY_PvRwYmr8g@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 2/2] bpf/selftests: Add verifier tests for
 loading sleepable programs
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 11, 2023 at 2:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding verifier tests for loading all types od allowed
> sleepable programs plus reject for tp_btf type.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

> ---
>  .../selftests/bpf/verifier/sleepable.c        | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/verifier/sleepable.c
>
> diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
> new file mode 100644
> index 000000000000..15da44f7ac8a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/verifier/sleepable.c
> @@ -0,0 +1,91 @@
> +{
> +       "sleepable fentry accept",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_TRACING,
> +       .expected_attach_type = BPF_TRACE_FENTRY,
> +       .kfunc = "bpf_fentry_test1",
> +       .result = ACCEPT,
> +       .flags = BPF_F_SLEEPABLE,
> +       .runs = -1,
> +},
> +{
> +       "sleepable fexit accept",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_TRACING,
> +       .expected_attach_type = BPF_TRACE_FENTRY,
> +       .kfunc = "bpf_fentry_test1",
> +       .result = ACCEPT,
> +       .flags = BPF_F_SLEEPABLE,
> +       .runs = -1,
> +},
> +{
> +       "sleepable fmod_ret accept",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_TRACING,
> +       .expected_attach_type = BPF_MODIFY_RETURN,
> +       .kfunc = "bpf_fentry_test1",
> +       .result = ACCEPT,
> +       .flags = BPF_F_SLEEPABLE,
> +       .runs = -1,
> +},
> +{
> +       "sleepable iter accept",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_TRACING,
> +       .expected_attach_type = BPF_TRACE_ITER,
> +       .kfunc = "task",
> +       .result = ACCEPT,
> +       .flags = BPF_F_SLEEPABLE,
> +       .runs = -1,
> +},
> +{
> +       "sleepable lsm accept",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_LSM,
> +       .kfunc = "bpf",
> +       .expected_attach_type = BPF_LSM_MAC,
> +       .result = ACCEPT,
> +       .flags = BPF_F_SLEEPABLE,
> +       .runs = -1,
> +},
> +{
> +       "sleepable kprobe/uprobe accept",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_KPROBE,
> +       .kfunc = "bpf_fentry_test1",
> +       .result = ACCEPT,
> +       .flags = BPF_F_SLEEPABLE,
> +       .runs = -1,
> +},
> +{
> +       "sleepable raw tracepoint reject",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_TRACING,
> +       .expected_attach_type = BPF_TRACE_RAW_TP,
> +       .kfunc = "sched_switch",
> +       .result = REJECT,
> +       .errstr = "Only fentry/fexit/fmod_ret, lsm, iter and kprobe/uprobe programs can be sleepable",
> +       .flags = BPF_F_SLEEPABLE,
> +       .runs = -1,
> +},
> --
> 2.39.0
>
