Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3E04DA298
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 19:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346805AbiCOSqJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 14:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241627AbiCOSqH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 14:46:07 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED7731DF5
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:44:55 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id h63so4297878iof.12
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzF4KB+WHt/+sXqYKuQL58IqJCbYuQXxruWc3jk7uCU=;
        b=qagkk1DdnIPv5eQDEfUWeDR5v2o7ZS6/NMlDWSsT4e/9XUTiRiIc4tcnF3qDD0ZCt9
         qkafZT+IYyY7K/+K0P0BMM9BRlugBYLHBb/+nUu4gsp2WQPSVyoLi5FHyYnun10Jrykz
         PhpRVG+DLSCukpRBUL9ITJL0MOHfucRy1gad1pnz/5ywfvxwGA147Q4jxpLFN0p7Fd4I
         pfEnHOcSPrEGmiXBrFKyEhPclZ4blYwzhu7BU+wlReezOJYoUYtGFiG231osob4zd4+7
         RSyKFpKG5/h5D/VROv/LIZ4tcgqw5EuD2YKZNa9hQJEVn35r+BR2mQ9uzd56Uv7oFsEa
         BbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzF4KB+WHt/+sXqYKuQL58IqJCbYuQXxruWc3jk7uCU=;
        b=caFHzvEujF/kum1jzLAjPMoJnIlXgOEiIGys05AWL5r0CC6nQfxavbJvUi2lavgSvf
         xrXgXfuIyg35LK73KQ+O8AcmIatZ5bQa/8xsqLztT5d13Pc32jmXTu66VnjiCg8ug/Hc
         Oc6gXWXr371WRxlQMO/YXSLY/oA5Ze/CrDwNt6jwj4zrFtBcx1omKJWjC4jWPahV1a1X
         WX7uG21eoYWQ5rLkq/P3xziicefThR661B3PAIF9HbQCyldbxNXrQo0vMbrf/+mhzaMW
         +xtmHNjKugxUnn1AbHeim1STEUvFMfku9ZH6A8dDaJbJr5jvArsIeoRPhY8MTknwQCOf
         SUqg==
X-Gm-Message-State: AOAM531KE/ah5ZA5BmqK4siYOgC1KzsEOESCxcKAx53YoSR+uaFzyk86
        wEc07UKHf2TIZ+lzyh+JFAASuJubrlyR+ORKN5I=
X-Google-Smtp-Source: ABdhPJyMxOmCOwUKVY/tBtT5H+5HwPlt16My7HvWvXpPwemkUslM0sRB0yQVPM/HcBSH4N3u+QT4fEdokmexwzTSPvo=
X-Received: by 2002:a05:6638:33a8:b0:319:cb5c:f6d9 with SMTP id
 h40-20020a05663833a800b00319cb5cf6d9mr19095890jav.93.1647369894413; Tue, 15
 Mar 2022 11:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <7c20ed355c2f587d3e1c81a6b398cb8f68304780.1647342110.git.lorenzo@kernel.org>
In-Reply-To: <7c20ed355c2f587d3e1c81a6b398cb8f68304780.1647342110.git.lorenzo@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Mar 2022 11:44:43 -0700
Message-ID: <CAEf4BzZFGv-_5U8LL=Jzr8MqL5F5F0i=gz+06nJOc961Ta54KA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] samples: bpf: convert xdp_router_ipv4 to XDP
 samples helper
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Tue, Mar 15, 2022 at 4:06 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Rely on the libbpf skeleton facility and other utilities provided by XDP
> sample helpers in xdp_router_ipv4 sample.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  samples/bpf/Makefile               |   9 +-
>  samples/bpf/xdp_router_ipv4.bpf.c  | 180 +++++++++++
>  samples/bpf/xdp_router_ipv4_kern.c | 186 ------------

hm... git should be able to record this as a rename and the result
patch will be much smaller, only showing what really changed. Can you
check where this went wrong?

Please also add libbpf_set_strict_mode(LIBBPF_STRICT_ALL) to enable
stricter "libbpf 1.0" mode. Thanks!

>  samples/bpf/xdp_router_ipv4_user.c | 462 ++++++++++++-----------------
>  4 files changed, 377 insertions(+), 460 deletions(-)
>  create mode 100644 samples/bpf/xdp_router_ipv4.bpf.c
>  delete mode 100644 samples/bpf/xdp_router_ipv4_kern.c
>

[...]
