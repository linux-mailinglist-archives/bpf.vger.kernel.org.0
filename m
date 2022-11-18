Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A003362FD75
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 19:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiKRS7C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 13:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbiKRS6O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 13:58:14 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4956BF72
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 10:58:03 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id io19so5341269plb.8
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 10:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=41UfXATwMCxVMYr2NMGOXZlLAsgQFrtoXxMLmxu3UVQ=;
        b=ABDgtA2yCP1w33Lchy4yul8b/hEsbYBtwc9EmbCM0qnBaGMtLWE0Smt+bszqCvPERQ
         nsFx/lKogp1+ZEMpOX9AFfAzk9le3D2tNNZxXNkJeUvRH5Kt4Agc2RIZZbNTd1my0IEV
         xrmto/Mst/d4aZymLjRXEWtq7JzjgfyiJZi+NhfQy92gk/PygPGRcWwoLlnqTFeb0+Z9
         bnHVWUXViTTjeFVEJifMB1rmn4rlOulrVMPhD6wHQuQIXAaM792so4mwvMWPlNdTDyoF
         sXldKB+W2+7LRfU8ST1ycZS7QBzTk9ETzkg9mznqb8IDavYkiKO6iJ51zFufvnnnpQDq
         ASzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41UfXATwMCxVMYr2NMGOXZlLAsgQFrtoXxMLmxu3UVQ=;
        b=kQH0ZBq/4wU5yy6+I1z7fWup7VsCDsBqrrDzRPI3y8dTS3jCj8HTVNE1tAhenxA97r
         4HjrZa5JIoamfdcC6MG2L9sH0//NO6+qreFe3MsBTsJ1HZFuv18u4LtcomTNTVo2C3Bg
         rmQDEPzE6DO26jWM7HVM4IjwCsAkSDkAmXm3xZOA3lMFvv7iK8Ol80QIpLMccZd4yzUV
         24l9QOw4QTRAz3mgJQN9Slrdk3kCpwnCu4QcDdKq2BsXtoihulSJ/M8jMucOd1N1+koG
         5888WUe8rQoo48wN+2ozpD5prcmBXjmfNAZIUKObZfskDw0A9gop4/tRcjNAaOT/EngD
         AiZg==
X-Gm-Message-State: ANoB5pnBXNyHMNSDJf7EvWn6D26XfcOPosu0EI0fAJqV17pwNdwDpL+m
        xjD62xcjAxh1VmmDmRSpby1074BqJfwxe4uCeHshLQ==
X-Google-Smtp-Source: AA0mqf7Pcput0MLEPQOxHpaW+84SKUvzySwwYel6OKzcYo31XYlr/0yLIJNikHvbiafRqpSCEMnoKzgbWvDmzHB4XZ4=
X-Received: by 2002:a17:902:70c9:b0:176:a0cc:5eff with SMTP id
 l9-20020a17090270c900b00176a0cc5effmr772395plt.128.1668797883106; Fri, 18 Nov
 2022 10:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20221111063417.1603111-1-houtao@huaweicloud.com>
 <20221111063417.1603111-2-houtao@huaweicloud.com> <33b5fc4e-be12-3aa8-b063-47aa998b951c@linux.dev>
 <CAADnVQ+Mxb8Wj3pODPovh9L1S+VDsj=4ufP3M70LQz4fSBaDww@mail.gmail.com>
 <CA+khW7gA3PgMwX5SmZELRdOATYeKN3XkAN9qKUWpjFU-M6YZjw@mail.gmail.com>
 <43bcd243-eea0-6cbe-b24b-640311fa1a83@linux.dev> <6159bf91-21c7-3fb0-e211-a40e85fd5bdc@huaweicloud.com>
 <339eae51-675d-64a4-eef7-9ff70dba880c@linux.dev>
In-Reply-To: <339eae51-675d-64a4-eef7-9ff70dba880c@linux.dev>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 18 Nov 2022 10:57:51 -0800
Message-ID: <CA+khW7j42UAigHPvFcOMLJNJ2wxmuUqzS8xWMO_VqPLrZs0Wfg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/3] bpf: Pin iterator link when opening iterator
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Hou Tao <houtao1@huawei.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Thu, Nov 17, 2022 at 11:34 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 11/17/22 5:52 PM, Hou Tao wrote:
> > Hi,
> >
> > On 11/17/2022 2:48 PM, Martin KaFai Lau wrote:
<...>
> > Rather than adding the above logic for iterator link, just pinning the start
> > cgroup in .init_seq_private() will be much simpler.
>
> Yeah, it is better to fix the bug without changing the behavior when all the
> link fds are closed and pinned files are removed.  In particular this will make
> the link iter works differently from other link types.
>
> I can see pinning a link inside an iter is a generic solution for all iter types
> but lets continue to explore other ways to refactor this within the kernel if it
> is really needed instead of leaking it to the user space.  (not saying this
> refactoring belongs to the same patch set.  lets fix the current bug first.)
>
> > prepare_seq_file() has already acquired an extra reference of the currently
> > attached program, so it is OK to read the iterator after the close of iterator
> > link fd. So what do you think ?
>
> Right, it is my understanding also that the prog refcnt has been acquired during
> the iter creation.

Sounds good to me. The fact that the iter holds a reference to the
program is what I missed in my reply. Both solutions are correct.
Because of that, I don't have a strong opinion on either of them now.
:)
