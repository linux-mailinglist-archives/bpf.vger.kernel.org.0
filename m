Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EBA62605E
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 18:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiKKRYp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 12:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiKKRYo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 12:24:44 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71AC11446
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 09:24:38 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3691e040abaso49648867b3.9
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 09:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oLwdwH2iAEgpnAz+mtOY4qcv9up65QS/Jk5D4kfx4Gg=;
        b=IncDKJz+4LK/Qxvc7XierXnLtoiGTIpejj1vSwJcJPjfTgfgyAF8wJ5TIVBU4yNeo9
         eEn0mwEHVD8Y9R3/amPQCFNmENPD4o/+7Yv22JCvgaT5R/rovPoe4/HO1TU9lqHeCbUw
         Lwr9NyvI0Ye/GW+x8PD2R8gC3nWywA4KSdsOUwBTdbUVr0879pT+K0hLIrx+rLZN9NiJ
         ot9LzHQK1kcYD6iXWUsCyB28k20g1/DsgK3vUi7mCNsfWZ6dVMBOeu0//zZO/0wUDPb8
         jBVCqLt0kav4AT/ZcLpVDe4INLZFxcJCdwZngup61WB/+P2wwottpqIzjD30TbAT3qgq
         qtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLwdwH2iAEgpnAz+mtOY4qcv9up65QS/Jk5D4kfx4Gg=;
        b=BW1+9cUczDP4/0jA2AmAxxUdIxE4Mt2ovFjQAHdEcsL2cWCM8SZ/5SMAq5KT5m2EpR
         p3FNsznvw7HYp7Buq5nfq6tewIjZNFRpogA2TLrXMt/2ZPqGhjeBhdosCnzk5AZERMMP
         z/8Ys7yU4unc65Gjw3QfUJsF0kne60XD6pGrcbFOvCEuEzH2gmPVp94TdcpmN8a53m5c
         5Ibc9/95XgSM5C47imfL5oyklvzajtPHTHIwzPy5ihtpCqjaxrPeDdvTzEajVlnhaqYf
         qpqDeNBNbHw2UnN27iIGubnw2ReoL7+EV93uyfI1rK7ekrCqeYvVuv8OhE+Mg6nEHoq8
         dC6A==
X-Gm-Message-State: ANoB5pnQ+jpgkngeRtN8cZFPGBsv6psw3ZMtDQ13U8UauGNBmuS+HEr9
        l0u13t27vvgX9WsyjzQU8LOTCOFLH0uTfEycamFebw==
X-Google-Smtp-Source: AA0mqf5uutRAQx7Pm/IgRbudIUjUZLLNvv8vOpIXP1Ezr7hSLt8z7GVuZloOGFy65P1L6vRZZZcNMChHAf2WyAe33JE=
X-Received: by 2002:a81:5b09:0:b0:361:38f5:abbb with SMTP id
 p9-20020a815b09000000b0036138f5abbbmr2850178ywb.102.1668187477748; Fri, 11
 Nov 2022 09:24:37 -0800 (PST)
MIME-Version: 1.0
References: <20221111063417.1603111-1-houtao@huaweicloud.com>
 <20221111063417.1603111-2-houtao@huaweicloud.com> <00e96d17-bde6-d060-7cc0-bf4a2a0065e0@meta.com>
In-Reply-To: <00e96d17-bde6-d060-7cc0-bf4a2a0065e0@meta.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 11 Nov 2022 09:24:26 -0800
Message-ID: <CA+khW7j2Lq=THJv8Ci6aAoxhTDH2b7k8H1OqDpC++pjE4_ZYSA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/3] bpf: Pin iterator link when opening iterator
To:     Yonghong Song <yhs@meta.com>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 11, 2022 at 8:31 AM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 11/10/22 10:34 PM, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > For many bpf iterator (e.g., cgroup iterator), iterator link acquires
> > the reference of iteration target in .attach_target(), but iterator link
> > may be closed before or in the middle of iteration, so iterator will
> > need to acquire the reference of iteration target as well to prevent
> > potential use-after-free. To avoid doing the acquisition in
> > .init_seq_private() for each iterator type, just pin iterator link in
> > iterator.
> >
> > Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
>
> Thanks. LGTM. Once this patch went through bpf and circulated back to
> bpf-next, you can revert the change for the following patches:
>     f0d2b2716d71  bpf: Acquire map uref in .init_seq_private for
> sock{map,hash} iterator
>     3c5f6e698b5c  bpf: Acquire map uref in .init_seq_private for sock
> local storage map iterator
>     ef1e93d2eeb5  bpf: Acquire map uref in .init_seq_private for hash
> map iterator
>     f76fa6b33805  bpf: Acquire map uref in .init_seq_private for array
> map iterator
> in bpf-next.
>
> Acked-by: Yonghong Song <yhs@fb.com>

Acked-by: Hao Luo <haoluo@google.com>

Thanks!
