Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2A95B4279
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 00:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIIWYi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 18:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIIWYi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 18:24:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967B915FE0;
        Fri,  9 Sep 2022 15:24:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b35so4627392edf.0;
        Fri, 09 Sep 2022 15:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SW2I78khf6eSvDaV7dN2C7Cd6sRFTnjfW4IFiMGmSnY=;
        b=q6EZX4oyqC5KMwGTh7BTQBwjAWgCooLiBrF3nKuyZuJOg0/o3lqu8y9A4M+lMOEp0Z
         6iFhIQOc5+3zbIryudOcVH33YSjEDffJCJoA+Snk56QABRKqGixQE8QOi9oj3vXAxSBI
         gbAC8GYHcYA9kCsVibju1othvw1BKbMew5JQL9rSQwx5zMh40PyAliQf+bFCE2NNlGLn
         uS1AJqe3hgXA1VsoYu6Yhl89HwGTqO1Acs55QAYxpDH3gHntTpCpzexL+BEwbhCPZr4b
         mOkislUmPazWPN6G7BJdFOhWZJIBFjPhRXPdGD/py2f6dEUge5lslejqHq1VxGy6rQ96
         rgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SW2I78khf6eSvDaV7dN2C7Cd6sRFTnjfW4IFiMGmSnY=;
        b=zYwPGVGKLX3GJW8OBrAWgwIuztAZNx6xJaiWYSbNc0Cr4Zf6Hd8jlPBfDSh+WmhtIo
         P06nshEzV7D5V61CiaTfNbH9XODRzYfXHOeY8Omc2g/OaFErgRh6ojusaNtx7yqm3RcJ
         2RxydKi90C78WcZ2mXfff2gyB6++1rUXlnGmEpnIF86RCldZ/ZLasgosAYle6l4jTIKZ
         ohps2rk3LNHt1fxm7ABaen1BdX0bhGq/6wAECCGYH0SfLaocdShWj9E3GPvtyfRuc/7O
         kTxTfDkYrwnCJ/W6qcbg/qtv304F0FuaN4odMDSt3d1ypt69GybwTv14/PJ15euvhOYd
         rpFg==
X-Gm-Message-State: ACgBeo23gjjRKNfWbxTLXZ3nH5Eavnxmlg96QVOJfzSzDizLwnIfeNtw
        YWt/AkZcOb4zNI+M6k6wj7yrAg3LVfOSiNO1QMUD97fdtxU=
X-Google-Smtp-Source: AA6agR5cAk6aWrk2NFNMUm7yOQkgxoqf7Kxa60B8d1zyYx4HtS6Y2IC5g7gW/52Lu7k9yvJpICD6awb7uALUuQdLz4w=
X-Received: by 2002:a05:6402:10d2:b0:445:d9ee:fc19 with SMTP id
 p18-20020a05640210d200b00445d9eefc19mr12618059edu.81.1662762272016; Fri, 09
 Sep 2022 15:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220829091500.24115-1-donald.hunter@gmail.com>
In-Reply-To: <20220829091500.24115-1-donald.hunter@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Sep 2022 15:24:20 -0700
Message-ID: <CAEf4Bza1vGKeGj45wt_vxiQG=voeOU33KSGsjJ-qJERpuhdW8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/2] Add table of BPF program types to docs
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 29, 2022 at 2:15 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>
> Extend the libbpf documentation with a table of program types, attach
> points and ELF section names. The table uses data from program_types.csv
> which is generated from tools/lib/bpf/libbpf.c during the documentation
> build.
>
> Patch 1 adds subdir support to Documentation/Makefile and changes
> userspace-api/media to use this instead of being a special case.
>
> Patch 2 adds the program_types documentation with a new makefile in
> the libbpf doc directory to generate program_types.csv
>
> I plan to look at adding info about the format of section "extras" for
> each program type as a follow-on.
>
> v2 -> v3:
> Put program_types after API docs in TOC as suggested by Andrii Nakryiko
> Fix formatting as reported by Andrii Nakryiko
> Include USDT extras example as suggested by Andrii Nakryiko
> Include sample of program_types.csv as suggested by Andrii Nakryiko
>
> v1 -> v2:
> Automate the generation of program_types.csv as suggested by
> Andrii Nakryiko.
>
> Donald Hunter (2):
>   Add subdir support to Documentation makefile
>   Add table of BPF program types to libbpf docs
>
>  Documentation/Makefile                     | 16 ++++++-
>  Documentation/bpf/libbpf/Makefile          | 49 ++++++++++++++++++++++
>  Documentation/bpf/libbpf/index.rst         |  3 ++
>  Documentation/bpf/libbpf/program_types.rst | 32 ++++++++++++++
>  Documentation/bpf/programs.rst             |  3 ++
>  Documentation/userspace-api/media/Makefile |  2 +
>  6 files changed, 103 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/bpf/libbpf/Makefile
>  create mode 100644 Documentation/bpf/libbpf/program_types.rst
>
> --
> 2.35.1
>

This is marked as Changes Requested, so I presume there are some
fixes/updates pending on top of v3? BPF CI should probably be done as
a follow up, though.

But otherwise looks good to me and I appreciate the effort to improve
libbpf's documentations.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
