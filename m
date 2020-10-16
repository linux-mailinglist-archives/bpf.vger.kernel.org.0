Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9AD28FFD1
	for <lists+bpf@lfdr.de>; Fri, 16 Oct 2020 10:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405074AbgJPIMq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Oct 2020 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405029AbgJPIMN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Oct 2020 04:12:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9D1C061755
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2020 01:12:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x16so1517941ljh.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2020 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=A4ib7j7aHMB5AZLZqqJ7kHKqCwJSjJ7AV9PvDxTPhD8=;
        b=YSw2kXsvB4Fuhm5ctlwdEuIiw9szo4zxhZvIrDk68AoiVxMV0MVznZsciZHzrSGdbF
         yGsUpnExe7McrSV0FeOX4qejEs6ZliuseMNHVu5fahoIwn/DgJr1WA2DiD8slSeB7IiV
         fwiHDB7Z3bEbGKFYABXoRmX37sL4ASKuXFjqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=A4ib7j7aHMB5AZLZqqJ7kHKqCwJSjJ7AV9PvDxTPhD8=;
        b=J9KPNGc2d9jfbdxhfx62E0EgmZfWnixyaTiyLqlgCYpnk6XZ8b6dugucDsnqzqCUZU
         B/oQQK8YZ6j48vrWsXq3+KAJ9WPeWrBs4xxqcnnXbQhWvat5UJglC622EutroKH08qID
         LfnLOqW6AJQuu2LdbciVK62E9TDwpmzdJ6CKW6QkYFqmbqcS1gxqvWI25/fUeFx0qLIT
         Z6lSwsaLvGjlZiKUbqDprTRWPSl629NMJs98Om/GTULIcqC+5TUpghSRJTM+zlYIfMss
         cjGNxfqW6B0xBo6am1lFWOs1u3ymcB29uSACNcBkaYQk6F6ZgP0Q1c0fODWWF+Mx2309
         mWGg==
X-Gm-Message-State: AOAM531PVw+DkfoEK+RJ3pDVX/SlZ/miD2H9KKOt3WT9ofEIan55EioT
        zA48lXSiVP0byH758MXo+jyATw==
X-Google-Smtp-Source: ABdhPJyJW5Ve+xVPu/bKbLSeKxgSIVOrxYmNFbuLg3jeKlkNkgvACMFzQZmdtlfxfQ6Q8ACtL6lXZA==
X-Received: by 2002:a2e:7216:: with SMTP id n22mr1069971ljc.187.1602835929933;
        Fri, 16 Oct 2020 01:12:09 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id m132sm579890lfa.34.2020.10.16.01.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 01:12:09 -0700 (PDT)
References: <160239226775.8495.15389345509643354423.stgit@john-Precision-5820-Tower> <160239302638.8495.17125996694402793471.stgit@john-Precision-5820-Tower>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org, lmb@cloudflare.com
Subject: Re: [bpf-next PATCH 4/4] bpf, selftests: Add three new sockmap tests for verdict only programs
In-reply-to: <160239302638.8495.17125996694402793471.stgit@john-Precision-5820-Tower>
Date:   Fri, 16 Oct 2020 10:12:08 +0200
Message-ID: <87blh2vbc7.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 11, 2020 at 07:10 AM CEST, John Fastabend wrote:
> Here we add three new tests for sockmap to test having a verdict program
> without setting the parser program.
>
> The first test covers the most simply case,
>
>    sender         proxy_recv proxy_send      recv
>      |                |                       |
>      |              verdict -----+            |
>      |                |          |            |
>      +----------------+          +------------+
>
> We load the verdict program on the proxy_recv socket without a
> parser program. It then does a redirect into the send path of the
> proxy_send socket using sendpage_locked().
>
> Next we test the drop case to ensure if we kfree_skb as a result of
> the verdict program everything behaves as expected.
>
> Next we test the same configuration above, but with ktls and a
> redirect into socket ingress queue. Shown here
>
>    tls                                       tls
>    sender         proxy_recv proxy_send      recv
>      |                |                       |
>      |              verdict ------------------+
>      |                |      redirect_ingress
>      +----------------+
>
> Also to set up ping/pong test
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Looks like setup commands got filtered out by git commmit.

[...]
