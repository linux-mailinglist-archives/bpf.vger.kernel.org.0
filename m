Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4106162B2EE
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 06:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiKPFnQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 00:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiKPFnP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 00:43:15 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DADC38C
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 21:43:14 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id bj12so41419614ejb.13
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 21:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+uVYVC1IsyRibZiskPpQmqHqIsNepLyAUfybOMLz6ns=;
        b=Lw4yzlxjQ7EM5Fdxx2jvmhUY14guzuQjFq0W2nrp8t3IJMk+8avspToXudqhC0P3Vq
         CXR/FoG+s/dH7Dz0OLHSQzuIIcNm34kbx58GbGCqq6M7PjwsgUXyMTziwhVnqhQd5DNC
         7Kdqgyq5+qRghhYKwjeg1y4isvDqYbkesXjSq+XlRnrTavQltMYg7RuYlP4RpYRDPSei
         jFqeJzgQIe1ghIPg8vH0mkGNb0+APCEuoYtifUW0D4tEkcs8XpR1zenpcOnyH7h5TZyP
         n9yLcJjx486F0GZUoI+ATLhTsdYLpQTxyQplwypqBYg/H0WfyQm0C2hzcBQm6Wu7Cn71
         WT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uVYVC1IsyRibZiskPpQmqHqIsNepLyAUfybOMLz6ns=;
        b=O6Rqr/RAMQ0DI4VwcSQ1K5FI7MRSaZeRR3uR24BDbDvIcVQR+ubhFbKUkB1Eb9KMlA
         Z2r39UN6Qeat6H5/ac+hscGSnXqtjjiEvn67l3MxWBE0YdSrdYE0C0RkrWCIMMGJot+V
         OzeQmYaGjIZ5KvM3tNCCzc3i65EPQOT5MIHIqQB+rzHkxI9G5ilf62qxKN7rfTTCzW6A
         tvUmcOy95f1eIQ+qnvV6khXp8XJy1fUxb7InropT2uYjGmbPLtT9BjZRl5YL2WTH1ewP
         kdSa2UAUXPgsTJpdEoTFCjNVcPIPL0u4uIYC08yLl+c9s38vOGlXqfCTyouBpaF8dCe3
         S6SA==
X-Gm-Message-State: ANoB5pnR26JCm16q6uir25MDSFJW4ruFUaQFTW4/25ymBx81xR49pg1y
        pOmqy41Wicz04JJ/lV+dwlkK2pAGJUIZ7JrGu28=
X-Google-Smtp-Source: AA0mqf4t/fwPB/PTgNlmobxsk5Bnj5K+9NxaW3AKKnJJakv6fWF08MuggL5JN2fDn7vF3RvAA8nsxQuBCrd9zHi8U8k=
X-Received: by 2002:a17:906:a3cc:b0:78d:513d:f447 with SMTP id
 ca12-20020a170906a3cc00b0078d513df447mr263931ejb.708.1668577393142; Tue, 15
 Nov 2022 21:43:13 -0800 (PST)
MIME-Version: 1.0
References: <20221111063417.1603111-1-houtao@huaweicloud.com>
 <20221111063417.1603111-2-houtao@huaweicloud.com> <33b5fc4e-be12-3aa8-b063-47aa998b951c@linux.dev>
 <CAADnVQ+Mxb8Wj3pODPovh9L1S+VDsj=4ufP3M70LQz4fSBaDww@mail.gmail.com> <71933d25-b160-3e19-c544-1e12b934f07f@huaweicloud.com>
In-Reply-To: <71933d25-b160-3e19-c544-1e12b934f07f@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Nov 2022 21:43:01 -0800
Message-ID: <CAADnVQLdJVUsM-ZsOjsCS1aQZkzDQD-iBr_hDLG_OAs5xrmBFg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/3] bpf: Pin iterator link when opening iterator
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 6:40 PM Hou Tao <houtao@huaweicloud.com> wrote:
> >
> > Also pls target this kind of change to bpf-next especially
> > when there is a consideration to revert other fixes.
> > This kind of questionable fixes are not suitable for bpf tree
> > regardless of how long the "bug" was present.
> The reason to post the fix to bpf tree instead bpf-next is that cgroup iterator
> is merged in v6.1 and I think it is better to merge the fix into v6.1 instead of
> v6.2. And patchset v1 is not a questionable fixes, because iterator link has
> already acquired the reference of the start cgroup.

These "fixes are not suitable for bpf tree regardless of how long the
"bug" was present".
