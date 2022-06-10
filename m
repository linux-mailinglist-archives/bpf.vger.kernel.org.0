Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016C8546C0A
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 19:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350228AbiFJR5P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 13:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350240AbiFJR5L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 13:57:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4887819C3A5
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 10:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3FB5621AF
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 17:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D02AC341C4
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 17:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654883829;
        bh=xyTgTLYCmPdFZ7QMPLvbKC8BjW3li3LNFGwHtu4KSiQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XSjIulhLQcAEEmmLqJkLQpJHo5sraDCjMe195xeGsKInaP+g1nYl9rKCm72J1MUhV
         6fiKKOlVJEr+N/+ODm3e6P3xQd0+h88NPFC0fM64Ybl7j/qS/a/v0pYYc9xWaLnMtb
         Qa73flEBqqCCYAa62b58IMW1xAj2q8++PcIkfX6Vf6xKXkVo2cPurva82eqBJp2j9q
         rhWAp0223e44iNcHKYs5Kk0Yp0CZKIp8iwj/izOewjNhDYE21UPnTRDku2Nuj3umr7
         JDHHLuvAexk3vUzctz0H4zVStrKupRz7ZSqD796f+zlOj5PpZ1DZyl/o6HR5yxfT+Y
         +lBQ45lDyiz2w==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-30ec2aa3b6cso279396947b3.11
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 10:57:09 -0700 (PDT)
X-Gm-Message-State: AOAM533ruqglcyfCU8GY+C7MLd4DLasbPs7luz0sgZ2OZrR8+0/Fsi+g
        8N7iyMNVrA/Gi0uiimGmpfoVs0Gf44eOP3kpJ1U=
X-Google-Smtp-Source: ABdhPJxcmOu4YcjXZifkWaUy+W6PSzKFcSEvikZ2aaPBbmeSBvsHQOoRVwPIMdJB1NlbU2B24nx+1e95KVvjAsU2Hww=
X-Received: by 2002:a0d:eb4d:0:b0:30c:9849:27a1 with SMTP id
 u74-20020a0deb4d000000b0030c984927a1mr48815414ywe.472.1654883828272; Fri, 10
 Jun 2022 10:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220608192630.3710333-1-eddyz87@gmail.com> <20220608192630.3710333-2-eddyz87@gmail.com>
In-Reply-To: <20220608192630.3710333-2-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 10 Jun 2022 10:56:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6wPevXzqQ2dMnVh3wfJ3bY4Lpzza3wnQ_HoaW1-Nj2kA@mail.gmail.com>
Message-ID: <CAPhsuW6wPevXzqQ2dMnVh3wfJ3bY4Lpzza3wnQ_HoaW1-Nj2kA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/5] selftests/bpf: specify expected
 instructions in test_verifier tests
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 8, 2022 at 12:27 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
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

[...]

>
> Here it is expected that move of 1 to register 1 would remain in place
> and helper function call instruction would be replaced by a relative
> call instruction.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>
