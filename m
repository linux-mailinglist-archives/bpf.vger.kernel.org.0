Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4310355289F
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 02:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbiFUAg0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 20:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiFUAg0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 20:36:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B5718397
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 17:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07D88614FB
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 00:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72596C341C5
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 00:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655771784;
        bh=J9PhgRHUuBL6pCVdCD6glcHskFFkyuGfuBZqmPVHRXM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eCwxWLV6hnysbc4dxOHRCieE/vANku0nqbqka9ZrLJCPu/h9bPh/LIm9svykMSuMg
         M/zViHC3GeM9Pjl899FZhfhjLOPCILXq7vBfE5XyEUo7Mk3YJNLyuTUYIBW7WP4/lA
         aq2b/QNRlZGmURmpwA6FgITeybCxzGpvdb1GRagqIHWS3+VBAw+zWPYBDd2hB3viVK
         GYpSNKT5d6ZSzOTXej3kEpmcE0wZScqwtp+QRtD+SoZRJ0a96ZvS4YktZTCAIqfbZ8
         2mG2A3a1dyBhKTnl+aBQeXThYme4HYzGuzxZI9rw53CiJbxataWyLqKBlnaDFI1www
         fpscPmOkXVxLw==
Received: by mail-yb1-f171.google.com with SMTP id i15so16954865ybp.1
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 17:36:24 -0700 (PDT)
X-Gm-Message-State: AJIora/LLQOxoreusGxN+ZHotavtXsfThb6QINYIf300SRMGma+B7hsg
        0K3K479ZjctTpGGD//NavLEmUculSw0bJMt8cws=
X-Google-Smtp-Source: AGRyM1sEkqADHjlwhGxWRjgbiw0XTERBaTQwYKADZWxQ260DEvSl8G5wmVyJoKh+wVdYEWcVG3gD0mDV21+doDvZu50=
X-Received: by 2002:a05:6902:114c:b0:641:87a7:da90 with SMTP id
 p12-20020a056902114c00b0064187a7da90mr29543058ybu.561.1655771783522; Mon, 20
 Jun 2022 17:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220620235344.569325-1-eddyz87@gmail.com> <20220620235344.569325-5-eddyz87@gmail.com>
In-Reply-To: <20220620235344.569325-5-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 20 Jun 2022 17:36:12 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5jdje1OFYqkJbv4G6EdVcRWc4bN1qGxanw42p6truhCA@mail.gmail.com>
Message-ID: <CAPhsuW5jdje1OFYqkJbv4G6EdVcRWc4bN1qGxanw42p6truhCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/5] selftests/bpf: BPF test_verifier
 selftests for bpf_loop inlining
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
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

On Mon, Jun 20, 2022 at 4:54 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
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
