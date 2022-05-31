Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8528C539642
	for <lists+bpf@lfdr.de>; Tue, 31 May 2022 20:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbiEaS05 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 14:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiEaS04 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 14:26:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063C510FDC
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 11:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD085B81116
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 18:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51069C385A9
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 18:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654021612;
        bh=f6NLvPbCPzG4RC79nG1zeI5o58aoGIlRUn7uJz/tMF8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XcJqIFi80KeCGVuIoXlJEcR8CDAdBCfHWbuTJwn4ZNGI6Kpoc2R/b/bPD9lws+ey6
         KF6d3inoq7fDaClgmMhY2qoKv1rXM7jPpQ6rGaNTaWmwsO2yinIQZQEMmE/xEipytK
         YbQXgne9BOKNbW7PFRCCm5+4KWFTGhHRtKQeiyHBuNXy50H8X2i3R2sukmOI2Rlh5V
         mnn0KfwL8GBcm3cqOIyk+qK5UURaK2YVqSB3y4yuv7uaWWD4RWoS4ZLCL0YLynBK32
         djSt6KwdDU0AsdS1zFi39qkOjA7aabjZe/QT/acIbvjFPj3zvGBBFbu6nAw8fBqwAI
         AbbScv3LQo28w==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-300312ba5e2so149931547b3.0
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 11:26:52 -0700 (PDT)
X-Gm-Message-State: AOAM533DSmYP/2tiWPf8wcLFhLoWBXx6k3jj9NhPd9ATVFn5MUDuGkCT
        bgvkhoPHFpCMwFpKGcZNbOEoLzTou1wkbDijabw=
X-Google-Smtp-Source: ABdhPJyGlUdw0koKjvvF4PROmxB9cKvBt42mmlk0pxswjnpY5uKD1SiyGzHgx77BT20EjxzlWfCCSmetXm7+iFfIz7I=
X-Received: by 2002:a81:107:0:b0:2fe:f667:5d40 with SMTP id
 7-20020a810107000000b002fef6675d40mr65330307ywb.73.1654021611339; Tue, 31 May
 2022 11:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220529223646.862464-1-eddyz87@gmail.com> <20220529223646.862464-2-eddyz87@gmail.com>
In-Reply-To: <20220529223646.862464-2-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 31 May 2022 11:26:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6dy7Vp2nLObCZ_4O5temisvhV5xUqK=HjrG+cU7rAguA@mail.gmail.com>
Message-ID: <CAPhsuW6dy7Vp2nLObCZ_4O5temisvhV5xUqK=HjrG+cU7rAguA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: specify expected
 instructions in test_verifier tests
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 29, 2022 at 3:37 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Allows to specify expected and unexpected instruction sequences in
> test_verifier test cases. The instructions are requested from kernel
> after BPF program loading, thus allowing to check some of the
> transformations applied by BPF verifier.
>
> - `expected_insn` field specifies a sequence of instructions expected
>   to be found in the program;
> - `unexpected_insn` field specifies a sequence of instructions that
>   are not expected to be found in the program;
> - `INSN_OFF_MASK` and `INSN_IMM_MASK` values could be used to mask
>   `off` and `imm` fields.
> - `SKIP_INSNS` could be used to specify that some instructions in the
>   (un)expected pattern are not important (behavior similar to usage of
>   `\t` in `errstr` field).
>
> The intended usage is as follows:
>
>   {
>         "inline simple bpf_loop call",
>         .insns = {
>         /* main */
>         BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
>         BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2,
>                         BPF_PSEUDO_FUNC, 0, 6),
>     ...
>         BPF_EXIT_INSN(),
>         /* callback */
>         BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
>         BPF_EXIT_INSN(),
>         },
>         .expected_insns = {
>                 BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
>                 SKIP_INSN(),

nit: SKIP_INSNS(),

>                 BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, 8, 1)
>         },
>         .unexpected_insns = {
>         BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0,
>                         INSN_OFF_MASK, INSN_IMM_MASK),
>         },
>         .prog_type = BPF_PROG_TYPE_TRACEPOINT,
>         .result = ACCEPT,
>         .runs = 0,
>   },
>
> Here it is expected that move of 1 to register 1 would remain in place
> and helper function call instruction would be replaced by a relative
> call instruction.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

[...]

>
> +static __u32 roundup_u32(__u32 number, __u32 divisor)
> +{
> +       if (number % divisor == 0)
> +               return number / divisor;
> +       else
> +               return number / divisor + 1;
> +}

Do we really need this roundup? If so, maybe give it a different name?

> +
> +static int get_xlated_program(int fd_prog, struct bpf_insn **buf, int *cnt)
> +{
> +       struct bpf_prog_info info = {};
> +       __u32 info_len = sizeof(info);
> +       int err = 0;
> +
> +       if (bpf_obj_get_info_by_fd(fd_prog, &info, &info_len)) {
> +               err = errno;
> +               perror("bpf_obj_get_info_by_fd failed");
> +               goto out;
> +       }
> +
> +       __u32 xlated_prog_len = info.xlated_prog_len;
> +       *cnt = roundup_u32(xlated_prog_len, sizeof(**buf));
> +       *buf = calloc(*cnt, sizeof(**buf));
> +       if (!buf) {
> +               err = -ENOMEM;
> +               perror("can't allocate xlated program buffer");
> +               goto out;
> +       }
> +
> +       bzero(&info, sizeof(info));
> +       info.xlated_prog_len = xlated_prog_len;
> +       info.xlated_prog_insns = (__u64)*buf;
> +
> +       if (bpf_obj_get_info_by_fd(fd_prog, &info, &info_len)) {
> +               err = errno;
> +               perror("second bpf_obj_get_info_by_fd failed");
> +               goto out_free_buf;
> +       }
> +
> +       goto out;

Maybe just return 0 here, and ...

> +
> + out_free_buf:
> +       free(*buf);
> + out:

... remove label "out:".

> +       return err;
> +}
> +

Other than these, looks good to me.

Acked-by: Song Liu <songliubraving@fb.com>
