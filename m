Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132E6693278
	for <lists+bpf@lfdr.de>; Sat, 11 Feb 2023 17:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBKQdb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Feb 2023 11:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBKQda (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Feb 2023 11:33:30 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807D026865;
        Sat, 11 Feb 2023 08:33:20 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ml19so22840928ejb.0;
        Sat, 11 Feb 2023 08:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7if2fbfRRSFYDEmNHfpuBDlMGC3nYuSCmiF4Q5BSVWg=;
        b=PhgFQlViAMIgKqb1lBc7PfK8zIh2/u2pqeBCl2qdQeXHC7+rGwdGJ3SBJZl0QBnuTq
         SgD8GdI1inxET6QJcHtjVv1DYK64FJg+ZkK2hPgR/+kb9EiM0Tfb6YEPH5S+56yR1/yy
         COaPMbsyWxmrlmz6RSEPMdXlFfFNqDaFG0P+UbHtG+MjgCA69em/Pos7LBW6DTHLAESD
         iSV0BUD8gYNp81pySEFA50TMd9oeYZgTD+3/18GN7V4AKzfD76OOOpWDas89JrciN3pn
         XuWGT7T8lfLgf7RB9nDQBysl3y8ec0bn6i4ClW0PLY2FCw7c8/azPG6y+MwA4TB/WQIR
         xrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7if2fbfRRSFYDEmNHfpuBDlMGC3nYuSCmiF4Q5BSVWg=;
        b=xLG43iMXgxiUZUj4ZHbqyWw0ysgusJjW5KcuiBctIxWCXjCCfw0aN1CelfCVaAgswu
         ErRuk5gp5qQ78NRf9CB/hEJwBlSLoIncAjbv9XBWO5xSKhUrMDwZljZLqMuuj9uG6yWb
         MU3t0MXt7wM4t/5lm5yyM+fSSaFI8cE3RwrClMV3RgNkRVPDFtYiAjyRVMu/vHQt5c5k
         cW7lcGR29B90sCMmgPPgOB+eKOz4Ja6iyfDA49XdSBs03T4DXstckD+63EsAki1gLtQZ
         li5zzJ6g0VqmkuOuZX8ckbRmJm2FJhs6/PIBcWO/9FrUUrTr4/qqsReowFe6q7s+7K1z
         1LpA==
X-Gm-Message-State: AO0yUKUKgAvVy5xwtcfzpxZzRTHBSoJEdhqVLo0Y6WxqQe3g/7bKvkzK
        uoZfvqX7ti4PnKNm0c1qKPZRYSvDgyfrOfCHpZs=
X-Google-Smtp-Source: AK7set9x0qDFB8PN1n0uCZ3J0PXpYorqy0SisS6BSYWfedPWZKOyICGYF9Yt3l31jCHC7agASOItYjnULS+hIgaD+74=
X-Received: by 2002:a17:906:12c1:b0:877:747d:4a85 with SMTP id
 l1-20020a17090612c100b00877747d4a85mr2471660ejb.3.1676133198993; Sat, 11 Feb
 2023 08:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com> <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
 <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com> <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
 <e205d4a3-a885-93c7-5d02-2e9fd87348e8@meta.com> <CAADnVQLCWdN-Rw7BBxqErUdxBGOMNq39NkM3XJ=O=saG08yVgw@mail.gmail.com>
 <20230210163258.phekigglpquitq33@apollo> <CAADnVQLVi7CcW9ci62Dps4mxCEqHOYvYJ-Fant-0kSy0vPZ3AA@mail.gmail.com>
 <bf936f22-f8b7-c4a3-41a1-c3f2f115e67a@huaweicloud.com>
In-Reply-To: <bf936f22-f8b7-c4a3-41a1-c3f2f115e67a@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 11 Feb 2023 08:33:07 -0800
Message-ID: <CAADnVQKecUqGF-gLFS5Wiz7_E-cHOkp7NPCUK0woHUmJG6hEuA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
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

On Fri, Feb 10, 2023 at 5:10 PM Hou Tao <houtao@huaweicloud.com> wrote:
> >> Hou, are you plannning to resubmit this change? I also hit this while testing my
> >> changes on bpf-next.
> > Are you talking about the whole patch set or just GFP_ZERO in mem_alloc?
> > The former will take a long time to settle.
> > The latter is trivial.
> > To unblock yourself just add GFP_ZERO in an extra patch?
> Sorry for the long delay. Just find find out time to do some tests to compare
> the performance of bzero and ctor. After it is done, will resubmit on next week.

I still don't like ctor as a concept. In general the callbacks in the critical
path are guaranteed to be slow due to retpoline overhead.
Please send a patch to add GFP_ZERO.

Also I realized that we can make the BPF_REUSE_AFTER_RCU_GP flag usable
without risking OOM by only waiting for normal rcu GP and not rcu_tasks_trace.
This approach will work for inner nodes of qptrie, since bpf progs
never see pointers to them. It will work for local storage
converted to bpf_mem_alloc too. It wouldn't need to use its own call_rcu.
It's also safe without uaf caveat in sleepable progs and sleepable progs
can use explicit bpf_rcu_read_lock() when they want to avoid uaf.
So please respin the set with rcu gp only and that new flag.
