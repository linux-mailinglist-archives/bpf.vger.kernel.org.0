Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B112F62067C
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 03:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiKHCLe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 21:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKHCLd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 21:11:33 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959A311813
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 18:11:32 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3321c2a8d4cso121932787b3.5
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 18:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8qNth/yBs47kqk63NS307GifPyJ3/7hDzkF3aG9cUc=;
        b=IPUBMfsxHv3uJ6lgjBHaScLwqGLIm8P44UVojtSj/S4fLirrwLg6TmqxkZ1iaNAqRU
         EHzWYLveOxDexro43sNfzwBjOnRyUgZUuYcrnDGU4L2rax2o4ZMiLCtzD1PraUMtBrnx
         dN6eo64bpMfypN7vP9XXOXKJU/XgIle66qrRuha+xkohvPt0vPSA7yGCVI22IjS7/U0k
         t8ewptaXkZVUlKnEmzCcZ3teYxNKuE9QlS9nASp5z5/hjgkYlFAiYCs05bPukWT0tG6G
         tr1pxNj8gXfpEB7CTvpTQx8ckmzkrO42KFagmSDz82AKgW4rwtf3rEZlIXiRptVZqFtm
         3KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8qNth/yBs47kqk63NS307GifPyJ3/7hDzkF3aG9cUc=;
        b=ppPLrT4jnScfVYGgb9ZNOrp4y4xgodoRC25YrA86mUytkkUcWDJowxEQweSYWXHSIv
         R6g7kK4zUgbQIaooPlF9v4qO4rmNWa64TN8bmM9wL2UFOroogrrJfQ7nGqII/SslzNbP
         SYOUbuAkhef+0AQ053clWOfK7mJMa81VchSRoQF24RWoXR1Xo0thHhIGpNSd/5GFjC7S
         9KOaTvjcCQsnrrKuw5sgl42JdijdgYqgB0w6vT9H+nDhRkxFNgv4ZPRhBDe2gN5FW2lb
         ixjSnopmHtsBKIWRg9IMjk4HFV5fQwC1LkAqR6Uhqy4YxaTYl1vOpTsBW2EM2f7V+Ogv
         HA5g==
X-Gm-Message-State: ACrzQf27Dyv2BftuD31m9qha691/aTWY8f9I08zJqKHM0sixUuZthxsa
        m2qYspVn+qic0St/AcQqNUbg+Q68+meFjDLU93CO5g==
X-Google-Smtp-Source: AMsMyM5RQm0SfaRSTU5XmAr7YpA5xXcN5CYVoSGrTdJMSItSA27YQI+BPTiEqMVI8qLPBlqJCq+fLCDqIDH+s9Yn0yw=
X-Received: by 2002:a81:920e:0:b0:368:25a5:e82d with SMTP id
 j14-20020a81920e000000b0036825a5e82dmr52500335ywg.375.1667873491603; Mon, 07
 Nov 2022 18:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20221107074222.1323017-1-houtao@huaweicloud.com>
 <20221107074222.1323017-2-houtao@huaweicloud.com> <a4721692-82bf-05eb-a1fa-72ddb5d1461b@meta.com>
In-Reply-To: <a4721692-82bf-05eb-a1fa-72ddb5d1461b@meta.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 7 Nov 2022 18:11:20 -0800
Message-ID: <CA+khW7jmm4UWXve_kzXdh4sv8cFbFKNYQ-G-XCJ6qGRW1_verg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/3] bpf: Pin the start cgroup in cgroup_iter_seq_init()
To:     Yonghong Song <yhs@meta.com>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Tejun Heo <tj@kernel.org>, houtao1@huawei.com
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

On Mon, Nov 7, 2022 at 1:59 PM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 11/6/22 11:42 PM, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > bpf_iter_attach_cgroup() has already acquired an extra reference for the
> > start cgroup, but the reference will be released if the iterator link fd
> > is closed after the creation of iterator fd, and it may lead to
> > User-After-Free when reading the iterator fd.
> >
> > So fixing it by acquiring another reference for the start cgroup.
> >
> > Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>

There is an alternative: does it make sense to have the iterator hold
a ref of the link? When the link is closed, my assumption is that the
program is already detached from the cgroup. After that, it makes no
sense to still allow iterating the cgroup. IIUC, holding a ref to the
link in the iterator also fixes for other types of objects.

Hao
