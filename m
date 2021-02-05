Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A912310938
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 11:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhBEKfy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 05:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhBEKdr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 05:33:47 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECCBC06178B
        for <bpf@vger.kernel.org>; Fri,  5 Feb 2021 02:32:56 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id l12so7159195ljc.3
        for <bpf@vger.kernel.org>; Fri, 05 Feb 2021 02:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ucNiF/54fSEIyQRLlbhggIgy6UPMZeD+dP03iaABumU=;
        b=pe+m9KuPdcUIwfCDmdAy+6xleoNQd1Q4OMhbMAt6eCWzCBqs13MD9qYXTr9rpvdAvy
         7exO/AN0V92WbLsZeE+GPU2v3xaCCD4UEcpRnvbTjHG6YA+TdSRjEwbeMQp/RnKrNMio
         eT1kXwqkmGoXYPNmPu6+EkF+cWqBrghc+KtBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ucNiF/54fSEIyQRLlbhggIgy6UPMZeD+dP03iaABumU=;
        b=Dg6cluJOshD/5bjWwxFEzfOqAruP9nssgy8qDAo67h5+TRDjyamuikZvXqnFu3GPMc
         EcpU2irce1W+gna3AvVhmjzoTgYAp9R1gKi8PDQoIHYTdonugfsnAVei1Mvcp0Cfzym8
         prseUuuc1D6vAbOqGNOC/Hgx/bHWDFdDIE1pUCBkbvlOhCr6FaWbmcDHjNtqGEx64xIO
         QDeAcBjTqaHHQMMG0lGyTGOcTMrkWdsBDNVvWXzm12s7G9/aiNBAbzE4H6F/ZlBDv9H4
         RuQ7IpY1ecFVtTZx3bpjrpRTHxjVtAxjRHNjsmiEBPMGElM/MYRF4K6gYFJw5EhoJ65Z
         q5aw==
X-Gm-Message-State: AOAM530do4q9ZphcLRv42Lzzr38BBMGjBDDj1DzD5zo5iZ1nUyyIP3ZI
        CQFMI7bQ+1omjd1cZtcg49eFGA==
X-Google-Smtp-Source: ABdhPJy0WU5rdenLuLUxfigpO8VvBzC3NkI8ylmrVI6rRPSZjjvg+R8Ssjtw2Tw37rH7CM8+fU+JEQ==
X-Received: by 2002:a2e:9b52:: with SMTP id o18mr2246558ljj.173.1612521174696;
        Fri, 05 Feb 2021 02:32:54 -0800 (PST)
Received: from cloudflare.com (83.24.202.200.ipv4.supernova.orange.pl. [83.24.202.200])
        by smtp.gmail.com with ESMTPSA id r16sm945426lfr.223.2021.02.05.02.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 02:32:53 -0800 (PST)
References: <20210203041636.38555-1-xiyou.wangcong@gmail.com>
 <20210203041636.38555-2-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [Patch bpf-next 01/19] bpf: rename BPF_STREAM_PARSER to
 BPF_SOCK_MAP
In-reply-to: <20210203041636.38555-2-xiyou.wangcong@gmail.com>
Date:   Fri, 05 Feb 2021 11:32:52 +0100
Message-ID: <87im764xez.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 03, 2021 at 05:16 AM CET, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> Before we add non-TCP support, it is necessary to rename
> BPF_STREAM_PARSER as it will be no longer specific to TCP,
> and it does not have to be a parser either.
>
> This patch renames BPF_STREAM_PARSER to BPF_SOCK_MAP, so
> that sock_map.c hopefully would be protocol-independent.
>
> Also, improve its Kconfig description to avoid confusion.
>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  include/linux/bpf.h       |  4 ++--
>  include/linux/bpf_types.h |  2 +-
>  include/net/tcp.h         |  4 ++--
>  include/net/udp.h         |  4 ++--
>  net/Kconfig               | 13 ++++++-------
>  net/core/Makefile         |  2 +-
>  net/ipv4/Makefile         |  2 +-
>  net/ipv4/tcp_bpf.c        |  4 ++--
>  8 files changed, 17 insertions(+), 18 deletions(-)

We also have a couple of references to CONFIG_BPF_STREAM_PARSER in
tools/tests:

$ git grep -i bpf_stream_parser
...
tools/bpf/bpftool/feature.c:            { "CONFIG_BPF_STREAM_PARSER", },
tools/testing/selftests/bpf/config:CONFIG_BPF_STREAM_PARSER=y

[...]
