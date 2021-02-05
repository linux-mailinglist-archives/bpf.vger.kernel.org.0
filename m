Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698363109B6
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 12:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhBEK77 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 05:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhBEK5v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 05:57:51 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9BEC061794
        for <bpf@vger.kernel.org>; Fri,  5 Feb 2021 02:53:19 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u4so7207257ljh.6
        for <bpf@vger.kernel.org>; Fri, 05 Feb 2021 02:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=2AY0VjV9ml5fXmjzc4EJ9Mkfak5UWnHEv1BMDM5PloI=;
        b=j1WP0ltfvS/xSuWwfvXeQ60+vJwsiwFmjtG688V86gkAzE/WG2WnFBDfLJcOj9NBw8
         exKwNKQ7ov13TMqiebfAvGffNUZrF9FmvRsngSrrcI2ZFD+8sCQ22mUmQIUfcZko9sHP
         DlgypH6SXX5HSBy7yHl43w1fA7eQAfLkdHqms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=2AY0VjV9ml5fXmjzc4EJ9Mkfak5UWnHEv1BMDM5PloI=;
        b=Rl9BbvFp8WMyW03vj5GIzf/DkeIxIF1jC7IGDTFaKLCWifqPmFACiViCHP/DFcs65h
         X/HwErbeZ74XTAD0fzP10iyr9jy/HtneilJdaC/MOgYUORTCRYS0k5fOIyvjZAcUwHFY
         V1opFxUo9jq+ISOKZl8VB8eXqXSqpSZmxHMAIhK6qEV/APgM/7PNkZERWZQOPUtQpQ60
         KxU6s5tNePTcljfPidbgCiqguf1CeNXponz7P/uBUhSJpu8jUcSaY/FJPy7o8ap/OMtQ
         KmYIE1L8YnBENnvqLYS0Y1ONEzOUCYGeXiFiXaXEHX3zsflqsmDcTiGZcxjJA1lEQfZG
         vL+w==
X-Gm-Message-State: AOAM531Y1GpsW02kITFKa7R5dPGQ/QEMgkEFSXkDCek6reDsoEgMdipF
        GM2jVirHkJLwNbHgUT8wp00GLw==
X-Google-Smtp-Source: ABdhPJyf7a3IprDYHXjBYYUxVMvuM+D+eNwsHexaOuZh94UBQkdwXP7c1t2Zh3ILDZy9mfYucCiU3g==
X-Received: by 2002:a2e:9ed1:: with SMTP id h17mr2248180ljk.160.1612522397629;
        Fri, 05 Feb 2021 02:53:17 -0800 (PST)
Received: from cloudflare.com (83.24.202.200.ipv4.supernova.orange.pl. [83.24.202.200])
        by smtp.gmail.com with ESMTPSA id j5sm950077lfr.173.2021.02.05.02.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 02:53:16 -0800 (PST)
References: <20210203041636.38555-1-xiyou.wangcong@gmail.com>
 <20210203041636.38555-19-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [Patch bpf-next 18/19] selftests/bpf: add test cases for unix
 and udp sockmap
In-reply-to: <20210203041636.38555-19-xiyou.wangcong@gmail.com>
Date:   Fri, 05 Feb 2021 11:53:15 +0100
Message-ID: <87h7mq4wh0.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 03, 2021 at 05:16 AM CET, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> Add two test cases to ensure redirection between two
> AF_UNIX sockets or two UDP sockets work.
>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

If you extract a helper for creating a pair of connected sockets that:

 1) delegates to socketpair() for AF_UNIX,
 2) emulates socketpair() for INET/DGRAM,

then tests for INET and UNIX datagram sockets could share code.

[...]
