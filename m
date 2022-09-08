Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396775B2A92
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 01:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIHXqb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 19:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIHXp7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 19:45:59 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9317A61FD
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 16:45:57 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 15-20020a62170f000000b0053e304ef6c0so27686pfx.6
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 16:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=+8UqRlwg2Eh30NsKZDsV1n1FMTowS3u4/qd2HZlUcxQ=;
        b=P9hPJ+qLLWia5jIqCqSN7lKA4B3JfC2T9hi0DkV/PTuwBCxRekOAbumnQCAu95g8o+
         YB2n4bEjKOkuSY5t9gbmM4BvQCNwgwNJCvy91N0jwwRBZHrlXeTwv5W5V09cFF07muCG
         i8H9MZiV12yXXaqQ42KHjG+a6fJz9f6o5l+Jwv7W96NSvZJb156tc1ISfywtfPFIYUPR
         seTH8ea0/b0GZhjPcGIs8Y6Bt7O8j5YzPIjHCo2ZY5aP3yNlJDRlYi0SHFGDap8gXxZL
         MANW2bbuU3Ui3VfeAZ7g/ZZBbxw2PNTzx3/6F+mZjOtlJd+XeM7Qh+j/mLoiIGhp/Pj/
         a0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=+8UqRlwg2Eh30NsKZDsV1n1FMTowS3u4/qd2HZlUcxQ=;
        b=oGE7UzjpS18Mx01UfuQsd2HuMVNTDHWMnegxkwGET9CrRe5AZSgA4WEiUFqtZ2j/6e
         xP3xAGTRHrP85Rsb3ltt89UZrKMk/80VqXAvxf2bTybW3BHXuAFJV1k7bt39TZwcfaiS
         0gXR0NdfcPq45iB0WvxF07BDnFpPplgyvKH6rdNJBgAHyiXHUotjpnMFTqYth7z04TK7
         Fy63FzGO9Zt86+id6P+2jVXRvoCkUEj1OUR5LlUTnXT5F3TygrFuvzEVs95coCyVAXCw
         LuXVixJ8DkOiNK2pk2c0Wjulvv9hWsbJcOzXEiyMiY6lPW4nxfNrnQBv10HnZtzHZoTr
         Vn9g==
X-Gm-Message-State: ACgBeo0vZ08QLFvF9fD2oE5T4aU1fsqnCV4PjD6CpMP7pGvskW15BajZ
        0q0CAQHCH4pF1aAZzZ7vD1ggfZw=
X-Google-Smtp-Source: AA6agR7ycF8bbbe4nWIKuNLASR8Ww0jrpgWZJgwAVBXYCRFuYnjmarnNx8l2LgpOR+dGD7vkgKnpCUs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:8b44:0:b0:537:a35d:3c11 with SMTP id
 i4-20020aa78b44000000b00537a35d3c11mr11267814pfd.76.1662680757281; Thu, 08
 Sep 2022 16:45:57 -0700 (PDT)
Date:   Thu, 8 Sep 2022 16:45:55 -0700
In-Reply-To: <20220908230716.2751723-1-davemarchevsky@fb.com>
Mime-Version: 1.0
References: <20220908230716.2751723-1-davemarchevsky@fb.com>
Message-ID: <Yxp+sw9ivJmmAErV@google.com>
Subject: Re: [PATCH bpf-next] bpf: Add verifier support for custom callback
 return range
From:   sdf@google.com
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/08, Dave Marchevsky wrote:
> Verifier logic to confirm that a callback function returns 0 or 1 was
> added in commit 69c087ba6225b ("bpf: Add bpf_for_each_map_elem() helper").
> At the time, callback return value was only used to continue or stop
> iteration.

> In order to support callbacks with a broader return value range, such as
> those added in rbtree series[0] and others, add a callback_ret_range to
> bpf_func_state. Verifier's helpers which set in_callback_fn will also
> set the new field, which the verifier will later use to check return
> value bounds.

> Default to tnum_range(0, 0) instead of using tnum_unknown as a sentinel
> value as the latter would prevent the valid range (0, U64_MAX) being
> used. Previous global default tnum_range(0, 1) is explicitly set for
> extant callback helpers. The change to global default was made after
> discussion around this patch in rbtree series [1], goal here is to make
> it more obvious that callback_ret_range should be explicitly set.

>    [0]: lore.kernel.org/bpf/20220830172759.4069786-1-davemarchevsky@fb.com/
>    [1]: lore.kernel.org/bpf/20220830172759.4069786-2-davemarchevsky@fb.com/

> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
> Sending this separately from rbtree patchset as Joanne also needs this
> change for her usecase.

Not sure you need that given everybody's happy about it in the separate
thread, but for the sake of completion:

Reviewed-by: Stanislav Fomichev <sdf@google.com>
