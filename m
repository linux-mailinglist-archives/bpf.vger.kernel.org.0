Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D74F549CF6
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 21:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348353AbiFMTKs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 15:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349231AbiFMTIo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 15:08:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204505002A
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 10:06:02 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w17so440199wrg.7
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KoHbfQqPxgY9yzkcDMM8WJkeOP/2rasHhf0aBaG7YMk=;
        b=CGQlrM5BP7x7O5U5HXhVD5E6vhiC48JFPNq/iEHbZugUGF1PH9mRo1PEbdLg95PhIT
         85sgUpFKPx6kQ0goj4wa4ZGoO+Agj+ijb78wILvKTIUWV4R1ylkwaTwj+QJNJ59U3kV2
         EvmdCDyDRC6z34zBOyxBfhggAWuE5PeN3eIW7NxGN0nA1/Ff9Mlb5Dpwf6qQHpvIU873
         CYR4KBRtjQ6a/yi3Qft7sU6fZOAU5sBJsiPl6NCNDhcKTH294QdGfYDpV70YW4zda0vY
         0pahJvLUSaRLuf63uiUYZCaC4Jvi0Vs7J+7ZzBHghgaKHmKJvIquFADEf+ZbvuP2pIaT
         t5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoHbfQqPxgY9yzkcDMM8WJkeOP/2rasHhf0aBaG7YMk=;
        b=hhodJHlf6vtYJKg0i6PjtddCjHMlmNHqnKqJ7KZac/qat1FqYBRNEJQn3dVpbrsKDs
         Z4wZoN2iKEesrugQJmi8JAOWsyP15Hj2aALtPbL/GBpJ09tA72KpJ8h7PlMVwG1eEP6o
         Aj2/SfGF85Ydgv3yfuDoXjMJMpKlofYgSjlvUC3RmkY1LVVugV7kDgo0RJXa8QRFQZXJ
         1A5UA9ejUHR9DJ4XTQLR0Z4p3b3WGD3yIKnZg24LVLi4hGifCMgzucZ9iLRsRpLzpLzG
         CaiiWalLGkG5FEEtjTkK/xRcFaqeoDNG7FxYEtFEkWuh+scC8xJpLAmVkN4CNFkv9Wzy
         IuRg==
X-Gm-Message-State: AJIora/WaVmPdApYiwxk0cUKfXJtOzZmgkm2EHtDiNoGgvCydWRcKmo9
        pSf7IJhGXgHv4egEcsc7zpGzAiAhNUaJSnNi+15u2A==
X-Google-Smtp-Source: AGRyM1vH+ZqkS8LKL5LOCrHzAkkw8d8wc3YcYVokHj4BKFHYsc3/bdOlTwXRmbj6z9xJr4PtQ+69Y4b8cHmSbVkBgOY=
X-Received: by 2002:adf:f688:0:b0:215:6e4d:4103 with SMTP id
 v8-20020adff688000000b002156e4d4103mr779245wrp.372.1655139960476; Mon, 13 Jun
 2022 10:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220610194435.2268290-7-yosryahmed@google.com>
 <202206110544.D5cTU0WQ-lkp@intel.com> <CAJD7tkZqCrqx0UFHVXv3VMNNk8YJrJGtVVy_tP3GDTryh375PQ@mail.gmail.com>
 <20220611195706.j62cqsodmlnd2ba3@macbook-pro-3.dhcp.thefacebook.com>
In-Reply-To: <20220611195706.j62cqsodmlnd2ba3@macbook-pro-3.dhcp.thefacebook.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 13 Jun 2022 10:05:24 -0700
Message-ID: <CAJD7tkba1Ojd+jd7WCa5Lc4sr=3e=4E4_UviHyhLtPfxZcyzpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 6/8] cgroup: bpf: enable bpf programs to
 integrate with rstat
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michal Hocko <mhocko@kernel.org>, kbuild-all@lists.01.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
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

On Sat, Jun 11, 2022 at 12:57 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 10, 2022 at 02:30:00PM -0700, Yosry Ahmed wrote:
> >
> > AFAICT these failures are because the patch series depends on a patch
> > in the mailing list [1] that is not in bpf-next, as explained by the
> > cover letter.
> >
> > [1] https://lore.kernel.org/bpf/20220421140740.459558-5-benjamin.tissoires@redhat.com/
>
> You probably want to rebase and include that patch as patch 1 in your series
> preserving Benjamin's SOB and cc-ing him on the series.
> Otherwise we cannot land the set, BPF CI cannot test it, and review is hard to do.

Sounds good. Will rebase do that and send a v3.
