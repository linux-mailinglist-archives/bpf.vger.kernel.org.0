Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E676C18BD59
	for <lists+bpf@lfdr.de>; Thu, 19 Mar 2020 18:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgCSRA2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Mar 2020 13:00:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41910 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgCSRA2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Mar 2020 13:00:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id z22so2236251lfd.8
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2020 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=vtMkzIwErSV95ddMs8+z368iZRh2IGDxPAeyTBG0cRU=;
        b=DWnpDyFyEjuHzu+kRPx00hpMuT06IvaqqLSwmamJaN9ZNBGgnTK9dVYcoEswiuB9so
         2zppWBUEL5zX+7W7st4WJ9jc3k2T6d1kDdTytPDB8t+kMIV2ZJyj2IlkTO7DLiPxOiGx
         yRxuE+k07s8wSpC/DdTrKGRVHg8PluVX0yNT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=vtMkzIwErSV95ddMs8+z368iZRh2IGDxPAeyTBG0cRU=;
        b=Y7VLpjYmsnLNFmEkuTcAyA+cDJ36guEyeO+HoAIo+nzU4Tx3dlbYhMDOgWp32SjvBq
         +HelcT6vr0iKpX9w7rxKUr5LdF+7GJaeooAP5GXAwUh3kt2Fx+rfWW8v35DaBr8AO+3U
         J1d5O5J6OnxXLy4+K7Upi2yLAHX467+0l6LRy065+e0gXm25QqLOpwaesleosi2ZeUQj
         xGxwmfVQFL0Gz4VXrp6TR1HWUbqxzX/PpWQEnslIN++1OfesIf5E9Ta12pu3VvwcYcDD
         8d2MAgUY1BFBYdb1dWehran0PIg1zExhV0ITAxu728xUFi8hfZD1jKbgrjpmk/P0Ly7t
         bj6g==
X-Gm-Message-State: ANhLgQ3Tp1/2/6JFsYbbkiwZpPidOQWzlDuYnrehQONSzF4tGAKUdGn7
        tCGI8Q+UCIOOKawMa7Jqqp3QrQ==
X-Google-Smtp-Source: ADFU+vvvm/Zy8geTn5pwmr1xdKqSGIlU4wTLcd+FA6SFqyZdZVOBmSRCEIBDJWaa85K8mP1TxQOxEA==
X-Received: by 2002:a05:6512:6cd:: with SMTP id u13mr2791061lff.1.1584637226598;
        Thu, 19 Mar 2020 10:00:26 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id 64sm1793944ljj.41.2020.03.19.10.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:00:25 -0700 (PDT)
References: <20200319124631.58432-1-yuehaibing@huawei.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     lmb@cloudflare.com, daniel@iogearbox.net, john.fastabend@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: tcp: Fix unused function warnings
In-reply-to: <20200319124631.58432-1-yuehaibing@huawei.com>
Date:   Thu, 19 Mar 2020 18:00:24 +0100
Message-ID: <87fte4xot3.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 19, 2020 at 01:46 PM CET, YueHaibing wrote:
> If BPF_STREAM_PARSER is not set, gcc warns:
>
> net/ipv4/tcp_bpf.c:483:12: warning: 'tcp_bpf_sendpage' defined but not used [-Wunused-function]
> net/ipv4/tcp_bpf.c:395:12: warning: 'tcp_bpf_sendmsg' defined but not used [-Wunused-function]
> net/ipv4/tcp_bpf.c:13:13: warning: 'tcp_bpf_stream_read' defined but not used [-Wunused-function]
>
> Moves the unused functions into the #ifdef
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

In addition to this fix, looks like tcp_bpf_recvmsg can be static and
also conditional on CONFIG_BPF_STREAM_PARSER.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
