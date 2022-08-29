Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EB75A53B0
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 20:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiH2SCv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 14:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2SCu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 14:02:50 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937BE61D63
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 11:02:48 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id g21so6654591qka.5
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UeCjsqVX03HELV6Qxt26VdXhNVQmFOTxZbHveZi3Wic=;
        b=cUqah88qiqkMfKXIggmg3kkUscXJDGR5OrYwItkLbrscXP0wYnc6ckeka2erXb9+EK
         sMS+NHZt6ZJeQw5uULvYMQj02mdFaEp9RH0AfvLiKJs1hk2KIeSzdztoblg4GHwuYAqo
         xJeq1L3lg9LCT0kx6VYK7lxh2La6HHLVxdQnn1yW8dW25hwlg5PRUQsgU5boHtjoRdVD
         2dJ9e3wrNYW/kfW4g7WqzZoY8OzS/twBI5CP3iVmtwlxOE/oC9V6GgT6xG4x7+OqE3Zl
         sTXfjeW5XeJ2pFjxoriPT0yfEIdAhd+uiYl+xGpi8w3v08bruNKjvsBUwGxhCPUrdKMl
         xAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UeCjsqVX03HELV6Qxt26VdXhNVQmFOTxZbHveZi3Wic=;
        b=k5ICocZOs2iPd/SjTsXibgOwvD8Evqev9m38RrFgyOuyNXTgEWzZVu11HGLFninjQP
         DYmAjio0PIRC9ol24A6E4aXuiR1q5jAgL2U1FBYcNra25+QLh2WL8KCLc2Zkqn2VIh8k
         wfuNBOgyeUP9NTwrHseDjGtC4pa0OoW7H3n3D0psj0dVYBOY1RZFr4pAf7pPK8LeUtzW
         vNHcpIc2s26A3Ap0j4P3CBCRs6wawq40LXVoUoBVcPKvsnzo0iMfkoB2aFdVdRMS3zaZ
         tiBRwbV6idyrSoxry0hsCn9WWAMUpLm5I8FAsznpYZN84vn1P27XzaHI73eoRTeW7GH7
         v0yg==
X-Gm-Message-State: ACgBeo2OW2FJZ3wdDmQa1S0Vwexsb+j7zAxIYu35/6uZDh0X9sj1fPzL
        gyIpuPbCQwsMdxxyRJPFG5amq3KEpJN/jIJh6WbCwA==
X-Google-Smtp-Source: AA6agR5OBmeDJ16u+wpsLthSvl07+laB7IqnfG6IMHAL5xzAxarEXJcb+CwRWclg02qBxPnvrkbaCKG0Hlu9zMCSoWg=
X-Received: by 2002:a37:4d7:0:b0:6ba:c29a:c08f with SMTP id
 206-20020a3704d7000000b006bac29ac08fmr9048293qke.669.1661796167617; Mon, 29
 Aug 2022 11:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220826165238.30915-1-mkoutny@suse.com> <20220826165238.30915-5-mkoutny@suse.com>
 <CAJD7tkZZ6j6mPfwwFDy_ModYux5447HFP=oPwa6MFA_NYAZ9-g@mail.gmail.com>
 <20220829125957.GB3579@blackbody.suse.cz> <CAJD7tkZySzWgJgp4xbkpSstc_RMN_tJqt83-FFrxv6jASeg8CA@mail.gmail.com>
 <Ywz8J70t3508J62n@slm.duckdns.org>
In-Reply-To: <Ywz8J70t3508J62n@slm.duckdns.org>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 29 Aug 2022 11:02:36 -0700
Message-ID: <CA+khW7jZCN54nUonNLp59fTAqOtAk_Ror+PgrLBfufRcE-CnFQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] cgroup/bpf: Honor cgroup NS in cgroup_iter for ancestors
To:     Tejun Heo <tj@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Aditya Kali <adityakali@google.com>,
        Serge Hallyn <serge.hallyn@canonical.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Muneendra Kumar <muneendra.kumar@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 29, 2022 at 10:49 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Aug 29, 2022 at 10:30:45AM -0700, Yosry Ahmed wrote:
> > > I'd like to clarify, if a process A in a broad cgroup ns sets up a BPF
> > > cgroup iterator, exposes it via bpffs and than a process B in a narrowed
> > > cgroup ns (which excludes the origin cgroup) wants to traverse the
> > > iterator, should it fail straight ahead (regardless of iter order)?
> > > The alternative would be to allow self-dereference but prohibit any
> > > iterator moves (regardless of order).
> > >
> >
> > imo it should fail straight ahead, but maybe others (Tejun? Hao?) have
> > other opinions here.
>
> Yeah, I'd prefer it to fail right away as that's simple and gives us the
> most choices for the future.
>

Thanks Michal for fixing the cgroup iter use case! I agree that
failing straight ahead is better. I don't envision a use case that
wants the alternative.

> Thanks.
>
> --
> tejun
