Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8B9683AEB
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 01:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjBAAFa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 19:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjBAAF3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 19:05:29 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D207299
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 16:05:27 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 7so11285894pga.1
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 16:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w8A9vBT/khKMaGZggBlfcaoxdg/zaX7WQ2GHlPfZ9xs=;
        b=BiSpvB811IcBJct74KPKQULQwFcRN0Wg6Ar62bSSgLA3zig9AYd/fuex8mOqSUPSJ5
         Ziod9DDVVIQgSwvdnd6FioMZH2mxYqPmSkXelMU6CCiIp8HRvw1tog/oKIgQnrhpMIZw
         aBUu8itI0Sq+J8QKloY6eNIDrpdFjkXefbQ0uuFK7QW12BgBk0n0oNX68PmfFUDStSe2
         wIVNM2FYkwp4klqPWgCgMtXJIEZDyxZndFyilZ10JPT0SS1S1orCP13X222wVTHKrPWO
         g2Iw0peEIoMgZSWbrfkkaAAZAYt3YkysTEQ2FC9IOpLb5BQUJyaAcOyjLu9wpjM53cyk
         nBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8A9vBT/khKMaGZggBlfcaoxdg/zaX7WQ2GHlPfZ9xs=;
        b=F6XCbVcKA4dEaSGWzEF10LH0lvCTmltKs2dZbBV9qTQEYZbT1bFUiwLJA7dEtzIwh4
         /lqaWQVYLxNKjU0yG/pK1Fjg3coeniRhs4Ve7DLSAsVZ1J90uqfAl1yZmgRt7AQl1l4i
         +gYoWUAC/MQtgNlmoM6HjMDX1yl9EYrup+uKSz526wUpalwLVCBnN+FQD5vbxNEYWjQg
         Yfusre8jX1gU1f3etuS6AT4E/NEiEKFFQFrv2UAPzgy37oI1/QWXlt2hVyV48DWn7a3D
         UGSSaI6BFvp6OeMR0ba6gYd22af/p9oSk4qmIjLySGjrmiFIzgZzJUPVxxtumczxCnau
         0PaQ==
X-Gm-Message-State: AO0yUKXiP365BjxaLKw+guN8+EjgiGL5DVObo5dpwUiP4LyG6fQZvaAo
        KTS0kmkMYLasJRbX4IaENqd23XMOOHWBcPrGWNPzIQ==
X-Google-Smtp-Source: AK7set9l/4wp/xKINl4PM5P7x4+dC0lcSiZC7hllzJdRw5eYtA9+kDO5qRjUUrC9bYnufKTMSSBDyeVqchrW61Oiww8=
X-Received: by 2002:a05:6a00:a18:b0:58b:506d:d6ae with SMTP id
 p24-20020a056a000a1800b0058b506dd6aemr77372pfh.24.1675209926940; Tue, 31 Jan
 2023 16:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20230130181915.1113313-1-zwisler@google.com> <20230130181915.1113313-4-zwisler@google.com>
 <CAADnVQJ7KxEK92qOz0Ya4MrACHpxngSpG4W38xuGEgZmXEG-vQ@mail.gmail.com>
 <20230130145932.37cf6b73@gandalf.local.home> <CAADnVQ+F3Z70mu3-QyyNFyJ2qCkDXnMJCW-o+fcnZo=LWj5d9g@mail.gmail.com>
 <20230130183419.0626dc21@gandalf.local.home> <20230131005315.phdnhkeeconxxm3e@macbook-pro-6.dhcp.thefacebook.com>
 <20230131145048.6fac87d3@gandalf.local.home> <CAADnVQKpkuBdQWWGDBh13NCrx2WMPs4fVUyVujF4L-6XnjXFpg@mail.gmail.com>
In-Reply-To: <CAADnVQKpkuBdQWWGDBh13NCrx2WMPs4fVUyVujF4L-6XnjXFpg@mail.gmail.com>
From:   Ross Zwisler <zwisler@google.com>
Date:   Tue, 31 Jan 2023 17:05:15 -0700
Message-ID: <CAGRrVHzNcWx4Rws6GVi2UPRG1ZyzowBJQSqaS83WhsNVymU0Ww@mail.gmail.com>
Subject: Re: [PATCH 3/9] selftests/bpf: use canonical ftrace path
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 31, 2023 at 4:26 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> Fair enough. Please resubmit these two patches towards bpf-next
> with [PATCH bpf-next] subj, so that BPF CI can chew on it.

Will do, thanks.
