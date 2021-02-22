Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06313216AD
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 13:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhBVM3l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 07:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhBVM3d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Feb 2021 07:29:33 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12F6C061574
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 04:28:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b3so18872227wrj.5
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 04:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=bNV1QvcJ/YkEdk4GKhB2UU/f9zwud99Ms+9a7yoCE4o=;
        b=lq0B6gsyj5jgBpITyBgnZnerfC/124UgbsWPXFBsyzWhfu0JxCtqocuQCADdfFbBhv
         3eAeYEc8Jl9J4Fgk0Ow0g45gT2cUKXNPhh9RJ/GLC+yNDzrfykPKsAmHehZ3Ah6uIWon
         vMiJTByitrbFEA8MUrS6vD32hr4xSGMynlG9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=bNV1QvcJ/YkEdk4GKhB2UU/f9zwud99Ms+9a7yoCE4o=;
        b=FbUEc2sM0jucdCegx985NbkCrZe7n13qgLAsSlc6/xlvrQ9LltmSeVCy7zabli22rc
         htxChKMLwoQuZtHKBpD6ihgTGsvb0ErTvPpcgvxeDMwnxDt6+ceV/FJKt3icG8kNOsVQ
         UGaoaDN+j8lOfB7EhsIwPx8HxRNkK9bw5bd2BfiVYjJ8ojnRBBAI2avKL3Yw37s9nymK
         IQT0h4kJgL8sPKEC7pAzG0+h5GzZ3snxjEvV8YFNHgO8C90cXgXudkaIvNkY811rLCU7
         3piFzJQZ2UqvokB+dZEiE/8OOvBZD345JHzwq7HK+YTeQZ3NPiLnaKWTyiHcXIhKpVMp
         C1nw==
X-Gm-Message-State: AOAM533csYXTZHk/xOCk/nV6qehBOoMhWMtXYN4i8zeRXRbKtATUQSVk
        WvzvfJ4MY7ufKrMvTvnGpUJ5Qw==
X-Google-Smtp-Source: ABdhPJxztsuiyBExH4+kF7BoprzRwWT1+c1oeqS8+jxudKRoms5A1wq8CuqYLu/HdWpUzScfO9gZPg==
X-Received: by 2002:adf:f6ce:: with SMTP id y14mr21461821wrp.294.1613996916349;
        Mon, 22 Feb 2021 04:28:36 -0800 (PST)
Received: from cloudflare.com (79.184.34.53.ipv4.supernova.orange.pl. [79.184.34.53])
        by smtp.gmail.com with ESMTPSA id x18sm27553929wrs.16.2021.02.22.04.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 04:28:35 -0800 (PST)
References: <20210220052924.106599-1-xiyou.wangcong@gmail.com>
 <20210220052924.106599-6-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [Patch bpf-next v6 5/8] sock_map: rename skb_parser and
 skb_verdict
In-reply-to: <20210220052924.106599-6-xiyou.wangcong@gmail.com>
Date:   Mon, 22 Feb 2021 13:28:34 +0100
Message-ID: <87czws477x.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 20, 2021 at 06:29 AM CET, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> These two eBPF programs are tied to BPF_SK_SKB_STREAM_PARSER
> and BPF_SK_SKB_STREAM_VERDICT, rename them to reflect the fact
> they are only used for TCP. And save the name 'skb_verdict' for
> general use later.
>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Reviewed-by: Lorenz Bauer <lmb@cloudflare.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

skb_parser also appears in:

tools/testing/selftests/bpf/test_sockmap.c:int txmsg_omit_skb_parser;
tools/testing/selftests/bpf/test_sockmap.c:     {"txmsg_omit_skb_parser", no_argument,      &txmsg_omit_skb_parser, 1},
tools/testing/selftests/bpf/test_sockmap.c:     txmsg_omit_skb_parser = 0;
tools/testing/selftests/bpf/test_sockmap.c:     if (!txmsg_omit_skb_parser) {
tools/testing/selftests/bpf/test_sockmap.c:             if (!txmsg_omit_skb_parser) {
tools/testing/selftests/bpf/test_sockmap.c:     /* Tests that omit skb_parser */
tools/testing/selftests/bpf/test_sockmap.c:     txmsg_omit_skb_parser = 1;
tools/testing/selftests/bpf/test_sockmap.c:     txmsg_omit_skb_parser = 0;

But I understand that changing the option name could break scripts or CI
setups. And even if that's not the case it can be cleanup up later.

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
