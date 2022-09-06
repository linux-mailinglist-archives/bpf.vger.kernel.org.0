Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EF55AF855
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 01:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiIFXS4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 19:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIFXSy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 19:18:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C05868A7
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 16:18:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11CB96172F
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 23:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D66C4347C
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 23:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662506332;
        bh=tuyjzQt64jwjQwYuD7tPlKfss63NwH7MdoF+wOkwVAo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=flPpQvMB2pWCzB9DTrvkcq8tnhK5BJ83bu8GOg1SUTz/OHFXjzCRHwbOaXH6D7lHv
         FupoeF9FCO9n1Zp5G1auGuJY0YYS3R3uERt4uoWiU/Ds0qtdFeDAkhT0pf8N+3KkD5
         6FRiwMp+dJqkK2keecmBnv1mmNbxq3GWpcW5cKhx+rVUtS9VnlNfHwP9sxKxbLjjPh
         ifYSMjFCcij4+PAck8vynnUGWS7blvQwi2tYFUVWhSv1V35NS1TUL+PLJr/j8tb5hX
         h4NC1iW635b9kQqmvC2t8kcJHMjkzG+yIe77p11WAd32U407J2Dot0U1ZHfnNMi7Ww
         IbQKn03Xqht0w==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-127d10b4f19so6219809fac.9
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 16:18:52 -0700 (PDT)
X-Gm-Message-State: ACgBeo1mySNJe7Q4zzDqz09zJ9dcKXmouuQ78KRETEmxijlfqsrYz4P+
        37jfwSwKOac0Aa8uxT39P9olOmVGX68tcrS+FU8=
X-Google-Smtp-Source: AA6agR4Rv8cKC36x20ZY4rHR7+l0/HQBT2MyVUUTd8iYC+fzbRQ4fpd4i7AqUPXEtMQVDXJQJmBtSIqqkKpHQELyjBU=
X-Received: by 2002:a05:6870:32d2:b0:127:f0b4:418f with SMTP id
 r18-20020a05687032d200b00127f0b4418fmr389042oac.22.1662506331628; Tue, 06 Sep
 2022 16:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220906133613.54928-1-quentin@isovalent.com> <20220906133613.54928-4-quentin@isovalent.com>
In-Reply-To: <20220906133613.54928-4-quentin@isovalent.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 6 Sep 2022 16:18:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7YrYAzVfbj+Ycq9nc9ztRHfWjqqaCJWQQBDiOzz9UhVw@mail.gmail.com>
Message-ID: <CAPhsuW7YrYAzVfbj+Ycq9nc9ztRHfWjqqaCJWQQBDiOzz9UhVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpftool: Split FEATURE_TESTS/FEATURE_DISPLAY
 definitions in Makefile
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Andres Freund <andres@anarazel.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 6, 2022 at 6:44 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> Make FEATURE_TESTS and FEATURE_DISPLAY easier to read and less likely to
> be subject to conflicts on updates by having one feature per line.
>
> Suggested-by: Andres Freund <andres@anarazel.de>
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>

Acked-by: Song Liu <song@kernel.org>
