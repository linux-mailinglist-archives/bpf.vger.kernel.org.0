Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3EA3800E6
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 01:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhEMXbp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 19:31:45 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.94]:22681 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229460AbhEMXbo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 May 2021 19:31:44 -0400
X-Greylist: delayed 1468 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 May 2021 19:31:44 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 5B9616A5A
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 18:06:04 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hKP6lg0sI8uM0hKP6lzNAi; Thu, 13 May 2021 18:06:04 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=P/DOzPKGp6J3WJCwGHyjpqer5CmLgvUAudqD0ateSBw=; b=x9c5/ZCt1KdADTYIlOge0eVWZ+
        HX9ICIrVZTe50m/NQeax/gIV5mvFhlO0Ze6Inhq27CJFpCCEoPBlC043pQVvnt6td4TV7Bv9eajon
        PP4ux726262s5A7khx7hsTKwvzea3bD7/VvKgz7ajvg6SvQPuNz0+Rbd48HufhUEaiyr2/LNIkJwy
        Zq8YE1BbQtjdB0Hg1O2IGpCsLyOdx4qFVjdBCNlk4TGW8zWpG6+IL/eqczFhWNCvZJGGQhso979kF
        aICgyBsoxdlRDfCE6SjiRyhmGRQDOA2wWRV/kDqzrB2H9CUdTaQJXa0K/hB2x4Pmm9rtcaSk9QxjL
        6pD/Zk9w==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:35730 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lhKOz-004AGP-CY; Thu, 13 May 2021 18:05:57 -0500
Subject: Re: [PATCH][next] bpf: Use struct_size() in kzalloc()
To:     patchwork-bot+netdevbpf@kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210513215049.GA215271@embeddedor>
 <162094681128.5074.13510794749219416919.git-patchwork-notify@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <481dc1e0-4313-7b77-2456-ebcebed296d9@embeddedor.com>
Date:   Thu, 13 May 2021 18:06:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <162094681128.5074.13510794749219416919.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lhKOz-004AGP-CY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:35730
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/13/21 18:00, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net-next.git (refs/heads/master):

[..]

> Here is the summary with links:
>   - [next] bpf: Use struct_size() in kzalloc()
>     https://git.kernel.org/netdev/net-next/c/fe0bdaec8dea

Awesome. :)

Thanks, Dave.
--
Gustavo
