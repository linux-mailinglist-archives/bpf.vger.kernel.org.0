Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE196286D4
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 18:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiKNRTS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 12:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbiKNRTD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 12:19:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35ADE60
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 09:19:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f126-20020a255184000000b006cb2aebd124so10948770ybb.11
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 09:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPyOIT+iOd2zpQIM4nVFb9Ghi+ceo2ipY05otTRNVf4=;
        b=lS4ccKHvfcRKb16iE//WrX+3tnM4ex7qmsmyD3AhR2nF8qiULAUaIUi9TcRbVXBEV2
         UhJAmhbBNq779ZFq/kqNS+lfnPhJq/wRJNqJrKR/Gjgh5vzKsO4O/BLftoBSljde+Tbe
         +NuoQriBWFbp9sQw94HlkYgvI1ZFDUA9Ujbj/bwSv1in6hWM8DM827SvbjyGcNzGKKAW
         18EZ4PkaCn3TRxBOqi5cllwd3efYoKNL2y6kRUr0goY58MGzlnybFWpZQM80jIPFNlUG
         YY3XePFWatM8k/X0X8lVkaGIoHpcuArmR2akouaSiYJzWqPTGGq4+SbyAiJRhCMuOiH5
         arKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPyOIT+iOd2zpQIM4nVFb9Ghi+ceo2ipY05otTRNVf4=;
        b=YHGh2aRUuctXcwofDNsbSIjyZ+iXcF/s6IZZT2FQHM883hktJjfosamlHlXuVNhm8B
         6ASO6CLZpSEL2FlQGAhp7tE7EPlhAjjJ9pzD2X/Vp9ZSMMhBRPQAAkQgdFb00ZijyY/w
         JR8sWP3RtGRolKqhYwNTfAzDyJ53dhl3DVX61Tyb3fJFbP+xafLQzainTfNNB9fecna5
         aSojzl5ngd5RtuB+Uh+W1PVjw06tTetqrudHB2otF9HUs7yiLCIL4mhk91woY60K39vA
         wypBM8Pjbttd3e/6xva/r/YF+r8c0iWkr+EEOKoaflO27nbCrQHj95iCFS5Bvg05FNAy
         DDkQ==
X-Gm-Message-State: ANoB5pmMK5eyoah78Yf9S2bhbIts5EolZDr+Fiphvxl266QwOUN0YBLP
        sJUoFG7p/aQfadEPHvGwL7OSuZE=
X-Google-Smtp-Source: AA0mqf7HIZ5AyreVg88s3W88J4L0v5b6iADyAYPd0WpdTlsyVtpuvLpcfICaz+nB44SVlsDCJQkXx+Q=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:360d:0:b0:6cb:ec9b:952d with SMTP id
 d13-20020a25360d000000b006cbec9b952dmr12583496yba.384.1668446342231; Mon, 14
 Nov 2022 09:19:02 -0800 (PST)
Date:   Mon, 14 Nov 2022 09:19:00 -0800
In-Reply-To: <20221113190648.38556-1-tegongkang@gmail.com>
Mime-Version: 1.0
References: <20221113190648.38556-1-tegongkang@gmail.com>
Message-ID: <Y3J4hJFl2pZacGCb@google.com>
Subject: Re: [PATCH v2 0/3] libbpf: Fixed various checkpatch issues
From:   sdf@google.com
To:     Kang Minchul <tegongkang@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/14, Kang Minchul wrote:
> This patch series contains various checkpatch fixes
> in btf.c, libbpf.c, ringbuf.c.

> I know these are trivial but some issues are hard to ignore
> and I think these checkpatch issues are accumulating.

> v1 -> v2: changed cover letter message.

> Kang Minchul (3):
>    libbpf: checkpatch: Fixed code alignments in btf.c
>    libbpf: Fixed various checkpatch issues in libbpf.c
>    libbpf: checkpatch: Fixed code alignments in ringbuf.c

Acked-by: Stanislav Fomichev <sdf@google.com>

>   tools/lib/bpf/btf.c     |  5 +++--
>   tools/lib/bpf/libbpf.c  | 45 +++++++++++++++++++++++++----------------
>   tools/lib/bpf/ringbuf.c |  4 ++--
>   3 files changed, 33 insertions(+), 21 deletions(-)

> --
> 2.34.1

