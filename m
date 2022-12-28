Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B906571F1
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 03:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiL1CAa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Dec 2022 21:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiL1CAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Dec 2022 21:00:20 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9687BE2
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 18:00:19 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b2so14777407pld.7
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 18:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sDNJyoqySS7OuZocSaXSAnU0JfxoqN7vb+Ckrbopv+Y=;
        b=hzgWZgCQGON9q+alhJey0ViSHB+wAr2GHDO9Y/WS7C3c8culxkg2G2Yxn/4SGclOxF
         I/Ss1OeaBGIFJRNhFrFJjEh+vw3XxKqzRUImAztE95JUwGD9p+cZjMDC5AjkJSwmdJJz
         TowcuQFEI1EYfrbjBPrwwPCWjCBBe5/MwO7wkTQwJVfx+GPfnPesCyo1DbAxyLO1sSFN
         Mpf09GKsBzwV8A/gBxswer0X40jr4U+WkfAHAc6SWJEdXzXiKinKB8+TfC+Tj29aI3qv
         +dtXE7idjMdWtClqewld6kFeva9oQqhoEpT/mZg0zpkq2NuqPY8jlrlBZjJjbxFu8cfb
         q7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDNJyoqySS7OuZocSaXSAnU0JfxoqN7vb+Ckrbopv+Y=;
        b=uLEk/fb7NmXNcfhZYh5PrMUUxE/uLWpKMAkodyM3Xcx5fRBwWKtj0dodH2LkGUIAmu
         tFn41FuhcBGwsMoDpzeHZJ/3AEDre5z+ykBNOoIEobL3hseesV8h825PWsR7yoP9rAoe
         x0SXKa4z4cv6+Q0fQBoz7D5c/CaH++NTZLgKpStw5a4c9Choc6Wk3w2UX6Uj/4QQrZ4b
         JkkhRBzl3UXVwbQNBS3weps/VAau2fbjUrVfLuLQG8r7CGTftniUhzqJmSHYl2lIIPIL
         h3wGqwHi/Djw4umrGcjWgrbE+iv2lna8ui2I6iYAVOs4w5K+sLJUXfb3U3SVaJpbpiAQ
         8czA==
X-Gm-Message-State: AFqh2kpX/soo0pCSvmMUzJgwh3O8p/VrwkzfTA/kRWiRery/wVLJwOXq
        nLbE9ObkicMI6Vzs+OX/UAH1abh37ns=
X-Google-Smtp-Source: AMrXdXvY38hrFW9xiyy0LzYcFGDw4iawDN37dbwjQdq8N2SUVGTZgzBKZJUtO7q+ZOH7Xf53zKzpcQ==
X-Received: by 2002:a17:902:ea81:b0:192:6b94:7a89 with SMTP id x1-20020a170902ea8100b001926b947a89mr13225464plb.43.1672192819202;
        Tue, 27 Dec 2022 18:00:19 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:68a7])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b00189651e5c26sm9680352pla.236.2022.12.27.18.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 18:00:18 -0800 (PST)
Date:   Tue, 27 Dec 2022 18:00:15 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 7/7] bpf: unify PTR_TO_MAP_{KEY,VALUE} with
 default case in regsafe()
Message-ID: <20221228020015.xquaykefotqmok7r@macbook-pro-6.dhcp.thefacebook.com>
References: <20221223054921.958283-1-andrii@kernel.org>
 <20221223054921.958283-8-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223054921.958283-8-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 22, 2022 at 09:49:21PM -0800, Andrii Nakryiko wrote:
> Make default case in regsafe() safer. Instead of doing byte-by-byte

I love the patches 1-6, but this one is not making it safer.
It looks to be going less safe route.
More below.

> comparison, take into account ID remapping and also range and var_off

ID remapping is handled by the patch 6 in regs_exact().
This patch adds range and var_off check as default.
Which might not be correct in the future.

> checks. For most of registers range and var_off will be zero (not set),
> which doesn't matter. For some, like PTR_TO_MAP_{KEY,VALUE}, this
> generalized logic is exactly matching what regsafe() was doing as
> a special case. But in any case, if register has id and/or ref_obj_id
> set, check it using check_ids() logic, taking into account idmap.

That was already done in patch 6. So the commit log is misleading.
It's arguing that it's a benefit of this change while it was in the previous patch.

> With these changes, default case should be handling most registers more
> correctly, and even for future register would be a good default. For some
> special cases, like PTR_TO_PACKET, one would still need to implement extra
> checks (like special handling of reg->range) to get better state
> equivalence, but default logic shouldn't be wrong.

PTR_TO_BTF_ID with var_off would be a counter example where
such default of comparing ranges and var_off would lead to issues.
Currently PTR_TO_BTF_ID doesn't allow var_off, but folks requested this support.
The range_within() logic is safe only for types like PTR_TO_MAP_KEY/VALUE
that start from zero and have uniform typeless blob of bytes.
PTR_TO_BTF_ID with var_off would be wrong to do with just range_within().

SCALARS and PTR_TO_BTF_ID will likely dominate future bpf progs.
Keeping default as regs_exact (that does ID match) is safer default.

Having said all that the focus on safety should be balanced with focus on performance
of the verifier itself.
The regsafe is the hottest function.
That first memcmp used to be the hottest part of the whole verifier.
I suspect this refactoring won't change the perf profile, but we can optimize it.
Assuming that SCALAR, PTR_TO_BTF_ID and PTR_TO_MAP will be the majority of types
we can special case them and refactor comparison to only things
that matter to these types. var_off and min/max_value are the biggest part
of bpf_reg_state. They should be zero for PTR_TO_BTF_ID, but we already check
that in other parts of the verifier. There is no need to compare zeros again
in the hottest regsafe() function.
Same thing for SCALAR. Doing regs_exact() with big memcmp and then finer range_within()
on the same bytes is probably wasteful and can be optimized.
We might consider reshuffling bpf_reg_state fields again depending on cache line usage.
I suspect doing "smart" reg comparison we will be able to significantly
improve verification speed. Please consider for a follow up.

I've applied the first 6 patches.
