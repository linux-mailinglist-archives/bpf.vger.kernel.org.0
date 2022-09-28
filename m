Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EFD5ED3F0
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 06:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiI1EiF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 00:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiI1EiE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 00:38:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782D01114E0
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 21:38:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hy2so24619864ejc.8
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 21:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rOY301qLwmDonIwHJC+aTUK6O323RTm4FnTgV0eDLzY=;
        b=EeTB+QfYhtSQ4Wl2uzCkXkDbV79zTwIOmgs6m9kt891QAl7aUp13SDRcleJRmqNd/F
         KMoi0kiOjYGMQ+MmWjBrU8Bz8sBs9it4xj9MtHBlfa/waSH1r2GaFqKcW2mYOd5AiOjZ
         cSaD5gxO+T+mWols5vADk3/VDGU3dWIUu3MyniQwEKeVB54ZiI26tx5VMGXNnSnWuP4c
         piO0m2d8B/c7tblLut0SoMtj5vjQOSEL0BglzhkhLEm8pYlGEbr6F/3gx+mOuEznTNM/
         b4ptlvSkYsziskrrcKh5y+ci/99kgvdRHNvSMEC3Upop0LCXsOWlciR5/D0U+PmGk2RM
         FnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rOY301qLwmDonIwHJC+aTUK6O323RTm4FnTgV0eDLzY=;
        b=p+SETf6YrPu6Hpwf1rIWqPz2Tln3CWnKIpLhXLdmKVWkOFMjClnKW/Rb5ZuGUuOj/s
         LEenueEhsfEIRaeY0cz2ekvxVftui1B0Ub+XYxfwnrrLtozIly5bZUQbbzuynQN7lECI
         NCChnoqr7nG9FtXNs4zySsMe34TzkUpg8EI3lH6HpHCp1bSEra+Q3ys3pCYhimiSmUh5
         MaGfFnHUtTezIT9vxa3QXwOU5dGnySxJxO3ExYnF0X67XXK2VwyiDs5HkIQ7XCVCtPJf
         1xzAO25X5CIsJASRgQKUHw4rlJxzQpdf+xBs1brCW6TXmhaeUKjjnQ06l1M34xKRZb2d
         xARQ==
X-Gm-Message-State: ACrzQf3xuoObiD2sww23Dv5pJr0CAr7v51kj7NCQRlJGyZX+KSj7Ug1m
        ObfhI3R1h3mQBrIHvhYj0QJj9nUF/5SUwPqbebs=
X-Google-Smtp-Source: AMsMyM47yb/LwuVD6JlZ4eCCT36bV6KDal8mi2qWur0nEgrKloQktDaugVW9KRkJYtsE4cb4mZcpUrBDZyjhIIKFly8=
X-Received: by 2002:a17:907:a421:b0:783:c25a:cee0 with SMTP id
 sg33-20020a170907a42100b00783c25acee0mr8815106ejc.94.1664339881884; Tue, 27
 Sep 2022 21:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220926012535.badx76iwtftyhq6m@MacBook-Pro-4.local> <ca0c97ae-6fd5-290b-6a00-fe3fe2e87aeb@huaweicloud.com>
 <20220927011949.sxxkyhjiig7wg7kv@macbook-pro-4.dhcp.thefacebook.com>
 <3c7cf1a8-16f2-5876-ff92-add6fd795caf@huaweicloud.com> <CAADnVQL_fMx3P24wzw2LMON-SqYgRKYziUHg6+mYH0i6kpvJcA@mail.gmail.com>
 <2d9c2c06-af12-6ad1-93ef-454049727e78@huaweicloud.com> <CAADnVQLWQcjYypR2+6UxhKrLOnpRQtB3PZ0=xOtjGpkEhWbH3g@mail.gmail.com>
 <81cae2d7-189d-0db2-f306-e015b48165a0@huaweicloud.com>
In-Reply-To: <81cae2d7-189d-0db2-f306-e015b48165a0@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 27 Sep 2022 21:37:50 -0700
Message-ID: <CAADnVQJxgYbX3aVutmAFNX9xGM5XyCVyg_RFed6JaRqekm6dbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/13] Add support for qp-trie with dynptr key
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
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

On Tue, Sep 27, 2022 at 8:27 PM Hou Tao <houtao@huaweicloud.com> wrote:
> > Also please use 'map_perf_test 4'.
> > I doubt 1000 vs 10240 will make a difference, but still.
> Will do. The suggestion is reasonable. But when max_entries=1000,
> use_percpu_counter will be false.

... when the system has a lot of cpus...
The knobs in the microbenchmark are there to tune it
to observe desired behavior. Please mention the reasons to
use that specific value next time.
When N things have changed it's hard to do apples-to-apples.
