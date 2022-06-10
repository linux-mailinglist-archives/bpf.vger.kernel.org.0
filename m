Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43086546C31
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 20:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244325AbiFJSPI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 14:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347635AbiFJSPH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 14:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFBC3CA60
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 11:15:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9292621D2
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 18:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E8DC34114
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 18:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654884905;
        bh=e7TBt6KOfZRmpKMDg6iS0sVLZyf8zukR/DLMsmHCqaY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EqJjykjP3Ti6bx/HfTFkoOBlVd5jP/hY/cagdO9jG3BFhh2I2sUUMPVdUcC6ow63d
         QYZikD/XO4edK8JNOMooIZZUst/SY+bzySNFTe96wbedK2Y114TuoIgFrXsnljB4lH
         AgWM+5d3HNz0j6/zjsbVmS+WdMJoGyps22JZ0LK4J9dGn5pvP0dCvXkc/N2KUg2/SQ
         ly4yAHiRRJuS8xxWp95b60vYfjfXAlBwqlroZ1GlKcLnFCo9HGPY8e0usG5IZlKHKQ
         xdlDJOZqX40vNQywHRoL3EUm7aI5B2dTlN8wyHimDuaWcJfBVIXl22rnK7Dq9he+Dd
         t0PHrhX/Y4MuA==
Received: by mail-yb1-f175.google.com with SMTP id k2so13461ybj.3
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 11:15:05 -0700 (PDT)
X-Gm-Message-State: AOAM533KBOK/MDYY8i0jWfzh9M0BDmGUlMUNjEn6oYOqoyoBQmQmG3Ex
        0duZ2/xc3agDiXTi+9i9FMJCHBM7jvqd3XO8XTM=
X-Google-Smtp-Source: ABdhPJyM6MwBYBpyVgL3Liv6xtWqzqh5qPt5Jm6s2klYU27php+UogKTK3ZLRcFQkJQ52FuSyaSCkx/dSAYlGrDuDcE=
X-Received: by 2002:a25:ad5f:0:b0:65c:9dc2:4ac3 with SMTP id
 l31-20020a25ad5f000000b0065c9dc24ac3mr44254189ybe.449.1654884904364; Fri, 10
 Jun 2022 11:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220608192630.3710333-1-eddyz87@gmail.com> <20220608192630.3710333-5-eddyz87@gmail.com>
In-Reply-To: <20220608192630.3710333-5-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 10 Jun 2022 11:14:53 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5OX43wjLqVppe8_NGEEkJWMpmX9QXGMQ0gMCVHNKLf_g@mail.gmail.com>
Message-ID: <CAPhsuW5OX43wjLqVppe8_NGEEkJWMpmX9QXGMQ0gMCVHNKLf_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/5] selftests/bpf: BPF test_verifier
 selftests for bpf_loop inlining
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
> A number of test cases for BPF selftests test_verifier to check how
> bpf_loop inline transformation rewrites the BPF program. The following
> cases are covered:
>  - happy path
>  - no-rewrite when flags is non-zero
>  - no-rewrite when callback is non-constant
>  - subprogno in insn_aux is updated correctly when dead sub-programs
>    are removed
>  - check that correct stack offsets are assigned for spilling of R6-R8
>    registers
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>

PS: I already acked v3, so you can include it in v4.
