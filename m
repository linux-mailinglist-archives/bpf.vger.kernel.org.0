Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B504B53D3B4
	for <lists+bpf@lfdr.de>; Sat,  4 Jun 2022 00:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241680AbiFCWwW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 18:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiFCWwW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 18:52:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3062673
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 15:52:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2130761B7D
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 22:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D87C34115
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 22:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654296738;
        bh=BYCEbgVtJrYycoc8hf1rHO3fG10T4VkQ5rLnCAuP1aI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HcG1CYUkRmy6c01Dd4gTWm3nJ3aq1Iq2iDTxv5ai1qWceGPar0H6e7kxppryFaq/w
         +h1dbeF8T19mX2OKK/ZzQ1SVAAGxTYMHIFXWZfrx112eZIQcQ1Da2FH21WYJ27lOEy
         1laXv4yibY6fOehGcs6bGAr1IotJ3LkvbyFLfCIHujeo73zHMNFztLZnRRYTELtuMc
         gx+0r0Ei0kRaS38wpSGPOAUBcwJIldYME7F3psZXABxr+TWzCAFcmGTK7R7jOZn/mw
         6Aaxp6CYrnGJCCIHBgle3UiD0x3NLN6owx8ztMUjLFnJoFfgIt2Z+XTTfHgoFDGWJb
         f56LLUbN4aHpw==
Received: by mail-yb1-f177.google.com with SMTP id v22so16197996ybd.5
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 15:52:18 -0700 (PDT)
X-Gm-Message-State: AOAM532zd2ag5t7iaicTyint5svfw0MeRiJ+c85PnmS6R02hctMN0FND
        BffKooBjFC1dGOfeMGJQyD0ACeLYHVyafxDcFRk=
X-Google-Smtp-Source: ABdhPJyFBxR9mKpNaLRIFQvS2hPSBVDvMngmQhwfI7LMDGMCNMFpbuEcab0oRiQOwTBB2z6/AePIuoorR4yc/4rvEB8=
X-Received: by 2002:a25:a242:0:b0:651:a78d:4636 with SMTP id
 b60-20020a25a242000000b00651a78d4636mr13229640ybi.9.1654296737527; Fri, 03
 Jun 2022 15:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220603141047.2163170-1-eddyz87@gmail.com> <20220603141047.2163170-6-eddyz87@gmail.com>
In-Reply-To: <20220603141047.2163170-6-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 3 Jun 2022 15:52:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6k-O3jd5jaQTC8vPO1S1S=gYANDg8A28-yx=EnZi-OzA@mail.gmail.com>
Message-ID: <CAPhsuW6k-O3jd5jaQTC8vPO1S1S=gYANDg8A28-yx=EnZi-OzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/5] selftests/bpf: BPF test_prog selftests
 for bpf_loop inlining
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
> Two new test BPF programs for test_prog selftests checking bpf_loop
> behavior. Both are corner cases for bpf_loop inlinig transformation:
>  - check that bpf_loop behaves correctly when callback function is not
>    a compile time constant
>  - check that local function variables are not affected by allocating
>    additional stack storage for registers spilled by loop inlining
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>

With some nitpick below.

[...]

> +static void check_stack(struct bpf_loop *skel)
> +{
> +       const int max_key = 12;
> +       struct bpf_link *link = bpf_program__attach(skel->progs.stack_check);
> +       int map_fd;
> +
> +       if (!ASSERT_OK_PTR(link, "link"))
> +               return;
> +
> +       map_fd = bpf_map__fd(skel->maps.map1);
> +
> +       if (!ASSERT_GE(map_fd, 0, "bpf_map__fd"))
> +               goto out;
> +
> +       for (int key = 1; key <= max_key; ++key) {

Let's move the definition of i to the beginning of the function.

> +               int val = key;
> +               int err = bpf_map_update_elem(map_fd, &key, &val, BPF_NOEXIST);
> +
> +               if (!ASSERT_OK(err, "bpf_map_update_elem"))
> +                       goto out;
> +       }
> +
> +       usleep(1);
> +
> +       for (int key = 1; key <= max_key; ++key) {
ditto.

> +               int val;
> +               int err = bpf_map_lookup_elem(map_fd, &key, &val);
> +
> +               if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
> +                       goto out;
> +               if (!ASSERT_EQ(val, key + 1, "bad value in the map"))
> +                       goto out;
> +       }
> +
> +out:
> +       bpf_link__destroy(link);
> +}
> +

[...]
