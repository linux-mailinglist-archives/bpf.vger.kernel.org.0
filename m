Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E06F56B543
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2019 06:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbfGQEDy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jul 2019 00:03:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38383 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQEDy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Jul 2019 00:03:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so1635211pgu.5
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2019 21:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=qUVjvveLSFGTrCu0Qk1Ewt2MB9ElwIbfiXPxIfTt4TI=;
        b=uWjV80+YJret+2Y4NFU3lDDVJHNSxGEFGkDHEm55MsBWCb0KCEsIc9efGtUQQ5Yht6
         KDzbRX3pP/GMrGVTtrudUDBksjvSTJI6WVsjNqEhevRFUcXKfTR7cG82F97VVNdQ1tMQ
         w7TAXfzkWHIpzQvh6EsmuJ5gkHPoO6SquleRjLBvpJ0F9CMZTYlrxhbieBUrq+qy8uk/
         RVcfh7Z82UcNJ5s6VoHv6weIqOe+yXXrbqWWjiNIti+DGO5Ca1K8xCg2ZQMbqIls93Xq
         BemyGq2lQXkh4wMPK+QALn26RfpRsue1VpPYhx+pQrvWO3IYg1HNfq3N3rhXrNA/aWNO
         1L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=qUVjvveLSFGTrCu0Qk1Ewt2MB9ElwIbfiXPxIfTt4TI=;
        b=pyutFsVv7fy33W4KfRO9+wePXQSqifelitC8iyRnvk6kenwDTIJRD8SPlLnWesE4oJ
         e/ThCVv8tJgXLOH5SkWlpWs51IX+1uEZNyng+6dWtkA+IjuxqVGVZbhbUVs6D6QQrlax
         hwBN7Z8Gv3eotbLrOPEDCWvJChmeGSczzajFf74rN/nIU49Qj1DzDSD3Q6AI67Vc2Tav
         BhXZgVMOIBzfgnAOXFK9T14tmfMQdcjohd/OqQXiPEtSkJrvFoy5xn5fGGozA4tQCpNX
         5I0v1C/9DxQ/NFZNTdY8t3UYEW0Q3C33Uo8hkttHPIF3xLvbcskHOyWceTiKftlyMK5v
         utKA==
X-Gm-Message-State: APjAAAUVt1O1Uj2KaLXz7c7O4MbcV6JVJ+ZwTaWA6hiJbu2Izu0x5rnf
        QOFAiJS1Ir9p0ffU485tj+r3ag==
X-Google-Smtp-Source: APXvYqyH+bKbrPUmGxlyJ2ePuub+fczUhqnNquIiznL3eAQMyxsl+dqGDFUHOlPBFZkh26ZGo9UGAQ==
X-Received: by 2002:a63:6c02:: with SMTP id h2mr35890374pgc.61.1563336233223;
        Tue, 16 Jul 2019 21:03:53 -0700 (PDT)
Received: from cakuba.netronome.com (c-71-204-185-212.hsd1.ca.comcast.net. [71.204.185.212])
        by smtp.gmail.com with ESMTPSA id b1sm21159707pfi.91.2019.07.16.21.03.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 21:03:52 -0700 (PDT)
Date:   Tue, 16 Jul 2019 21:03:49 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        edumazet@google.com, bpf@vger.kernel.org
Subject: Re: [bpf PATCH v3 0/8] sockmap/tls fixes
Message-ID: <20190716210349.61249036@cakuba.netronome.com>
In-Reply-To: <156322373173.18678.6003379631139659856.stgit@john-XPS-13-9370>
References: <156322373173.18678.6003379631139659856.stgit@john-XPS-13-9370>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Jul 2019 13:49:01 -0700, John Fastabend wrote:
> Resolve a series of splats discovered by syzbot and an unhash
> TLS issue noted by Eric Dumazet.

I spent most of today poking at this set, and I'll continue tomorrow.
I'm not capitulating yet, but if I can't get it to work for tls_device
soon, I'll make a version which skips the unhash for offload for now..
