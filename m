Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22E93AD930
	for <lists+bpf@lfdr.de>; Sat, 19 Jun 2021 11:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhFSJ74 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Jun 2021 05:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFSJ74 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Jun 2021 05:59:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD55C061574
        for <bpf@vger.kernel.org>; Sat, 19 Jun 2021 02:57:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i94so13599743wri.4
        for <bpf@vger.kernel.org>; Sat, 19 Jun 2021 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=XueTZP0lJWRa+YYcBCK2kcxXtuLOB7N9Tj1uRvxqI4Y=;
        b=bxdn7bPoHNyyfEITdiYAa3jYyMKrYYrLZ2okGa/9yN7mE0/8t2ukzX7uG3wpyXVBc3
         Cggj1pFvytDIX5x2jCoCME5Zlg/MQBZYO+UZiInNPNFlNZ35qmqmw3wECQaoL3CItbrG
         ZHpb2g3Ga17gbpPdtHRBBO0dSdeQVAOOf8LHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=XueTZP0lJWRa+YYcBCK2kcxXtuLOB7N9Tj1uRvxqI4Y=;
        b=sOObe3y6RpYMGFdPVLuyggh03o4PvTj9l/yQADF0VZKzCYkSexBXLc1MqBBxWQYHCv
         /C9o/D8QjEGCt2a/QLdarxfCn36AsIbXzBcDHPn1KFK2vMTRa3HL4kKr7WvHK0w+Ln7+
         t3zI9mSwMmN2cE8e6DUhkAVvF7Kzguy39YZIReL4D4yLoPhS6CYJNbR98Ts2ep7on4Dd
         22JC3vMKKalbBier8i9g+OKPVeyMLeRLzxHccjkt5hJuyXIjf7SdOPCmyG3NHzI6QvIt
         eUXNIdLcMH/0QOJebVpcSl9Ej9V2AEcqGi4IcvtlZEwzpJ1Jxfxe+l5dWnuZxePDL9bT
         wN+w==
X-Gm-Message-State: AOAM532hd0FLs6qrgf4+sc2PDEnSM25Q9uSg5lFVzGhFfFXlaQVsyrKo
        8v98nuECqJaM/aWnraN9fYOVOQ==
X-Google-Smtp-Source: ABdhPJzkPTkjIp9K040HAR+2wX0CyG1Ioa4k+/Hv9GVXoav1Gv2/DMDUo4b+UISAM+0QHhY+44dKPg==
X-Received: by 2002:adf:cd10:: with SMTP id w16mr17519423wrm.200.1624096664308;
        Sat, 19 Jun 2021 02:57:44 -0700 (PDT)
Received: from cloudflare.com (79.191.61.26.ipv4.supernova.orange.pl. [79.191.61.26])
        by smtp.gmail.com with ESMTPSA id l16sm12673795wmq.28.2021.06.19.02.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 02:57:43 -0700 (PDT)
References: <20210615021342.7416-1-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH RESEND bpf v3 0/8] sock_map: some bug fixes and
 improvements
In-reply-to: <20210615021342.7416-1-xiyou.wangcong@gmail.com>
Date:   Sat, 19 Jun 2021 11:57:42 +0200
Message-ID: <874kdu6usp.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 15, 2021 at 04:13 AM CEST, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> This patchset contains a few bug fixes and improvements for sock_map.
>
> Patch 1 improves recvmsg() accuracy for UDP, patch 2 improves UDP
> non-blocking read() by retrying on EAGAIN. With both of them, the
> failure rate of the UDP test case goes down from 10% to 1%.
>
> Patch 3 is memory leak fix I posted, no change since v1. The rest
> patches address similar memory leaks or improve error handling,
> including one increases sk_drops counter for error cases. Please
> check each patch description for more details.
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
>
> ---

For the series:

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
