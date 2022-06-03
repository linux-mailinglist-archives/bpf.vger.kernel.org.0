Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973BC53D348
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 23:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243524AbiFCVll (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 17:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiFCVll (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 17:41:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13A143EFA
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 14:41:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2735E61B39
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 21:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DA4C385B8
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 21:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654292498;
        bh=u2y0vSEInvLqWO2nudDzM1B6lW1Qwv81b46EPk5GAWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LakoLhcuLs+MS6RBVf1TXTdqi9HbNvg4mnQnmX2/WbMO6Le7ECNSTPuwDA43bs9xF
         sb6+epXHHTPt3BlFh3DMz16rbyFwaYvm8D3RW7ZkKHxYIN4LJNf/kRRCVzSE+9vqEI
         xSL1FeQ45+J4gfPC/boRZWrJf02oDWIr1yWm1sh8DU52PQxPm2BSJPUhdiFfK5vSVw
         6Mpdpkw1kDYtgpLzgjEKBGNdQ2/JW68qiYQeWJJHieatiy35NMQHd4mUQ27Y+wqKkq
         7neQxj1qvQzriUMhcoNA9qng3mr29TG/+/zFPd4ShTr46V42fHYO66Dq5VInNsiMw2
         9He+nzQpryfNA==
Received: by mail-yb1-f169.google.com with SMTP id f34so15958795ybj.6
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 14:41:38 -0700 (PDT)
X-Gm-Message-State: AOAM533c0bHSvasUENDGnZiDVqKoFwLs6aniS4MKENe52Ty6PR3xdtY/
        RAgYdHojDshO3BDTq+3iEx3AXXW0e2gbeyFPFig=
X-Google-Smtp-Source: ABdhPJySsqajM4wQ//GzN39Y7GtcQYGZwNB3JZ7LHUwdn93aFNqkNTXOyReH6uE9GLeS1PKITygtdVs/rL3DZgBZ0h8=
X-Received: by 2002:a25:8303:0:b0:65c:c9f7:3dbc with SMTP id
 s3-20020a258303000000b0065cc9f73dbcmr12263649ybk.259.1654292497605; Fri, 03
 Jun 2022 14:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220603141047.2163170-1-eddyz87@gmail.com> <20220603141047.2163170-3-eddyz87@gmail.com>
In-Reply-To: <20220603141047.2163170-3-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 3 Jun 2022 14:41:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4pM4O5U2PXLUBGORejEW_qDLAyrwB_7EyaRZ90ykTAxA@mail.gmail.com>
Message-ID: <CAPhsuW4pM4O5U2PXLUBGORejEW_qDLAyrwB_7EyaRZ90ykTAxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] selftests/bpf: allow BTF specs and func
 infos in test_verifier tests
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

On Fri, Jun 3, 2022 at 7:11 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> The BTF and func_info specification for test_verifier tests follows
> the same notation as in prog_tests/btf.c tests. E.g.:
>
>   ...
>   .func_info = { { 0, 6 }, { 8, 7 } },
>   .func_info_cnt = 2,
>   .btf_strings = "\0int\0",
>   .btf_types = {
>     BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
>     BTF_PTR_ENC(1),
>   },
>   ...
>
> The BTF specification is loaded only when specified.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>

[...]
