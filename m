Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728B34383BC
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 15:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhJWNHl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Oct 2021 09:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhJWNHl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Oct 2021 09:07:41 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5599C061766
        for <bpf@vger.kernel.org>; Sat, 23 Oct 2021 06:05:21 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i24so98366lfj.13
        for <bpf@vger.kernel.org>; Sat, 23 Oct 2021 06:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=i3jm0zGM5LC5omMb5qmvwWtICccBmS+35Ozk8H/g9cM=;
        b=LEd5a89xODbpJbVYCjdp1siy7hEqsqeLlAiz/nXEpAlKUDz1SgxsyjLfXRgeAax6Ck
         OFj+N4J6Zq2QMQV25kyhq6SkJLoJEZ1Z25Mnsjzv+CCGDgpvBTMB9U9Key2At54G4GwW
         fiqrHzTwN0xmz2oLrVeZhqt4ABZM8SSbnI0Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=i3jm0zGM5LC5omMb5qmvwWtICccBmS+35Ozk8H/g9cM=;
        b=WBAeGGQkJJrFw/PlP7/NbC8O2XNAq4XxcJi1Lkys1yijeZhfO/ENBEqMmpOohAHGgI
         sJHnCMB8nDwiIPPgAQr1ucrWeib50QFvKe+/evMmICGQ1QrhcSI5zIA/Z2qzeZAnW5rl
         932isjdSI0hO6QMm3ilx3sDamv4Ubq/YHDH8I3i5hdhcn2TaU5achsQrLTgzYioRdsfY
         +9kXfL++o0TK5yx+LTBl3+Dtw74+/11VEYriFn+ZNPMIKHxYH+0p3BKb7YQemTR2PKVO
         hVEXGnivlQgdGrXvCCapx8YEU3tgLXwu0DFKYtBCcPR373BVqS+MpiJOsVzH2WuKy70u
         lCvQ==
X-Gm-Message-State: AOAM532r5gKMd5NYPg+oCno+zkQ0jAAQ+zJMoeQnyj/Zm2iPa+S6O7NQ
        YPU39qkB/lhi/+0FXssdqP46mw==
X-Google-Smtp-Source: ABdhPJzgIwgJR8fmU41ufiONMCMQ+6CTl5AxVu0MjPrPlIHk3M12vvKM03B88ZEOJXTBlk1K4qeWpg==
X-Received: by 2002:a05:6512:6d6:: with SMTP id u22mr5676447lff.624.1634994320043;
        Sat, 23 Oct 2021 06:05:20 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-480d-6f00-ff34-bf12-0ef2-5071.aa.ipv6.supernova.orange.pl. [2a01:110f:480d:6f00:ff34:bf12:ef2:5071])
        by smtp.gmail.com with ESMTPSA id t9sm1025413lfd.232.2021.10.23.06.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 06:05:19 -0700 (PDT)
References: <20211011191647.418704-1-john.fastabend@gmail.com>
 <20211011191647.418704-5-john.fastabend@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
        joamaki@gmail.com, xiyou.wangcong@gmail.com
Subject: Re: [PATCH bpf 4/4] bpf, sockmap: sk_skb data_end access incorrect
 when src_reg = dst_reg
In-reply-to: <20211011191647.418704-5-john.fastabend@gmail.com>
Date:   Sat, 23 Oct 2021 15:05:19 +0200
Message-ID: <87mtmzgacw.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 11, 2021 at 09:16 PM CEST, John Fastabend wrote:
> From: Jussi Maki <joamaki@gmail.com>
>
> The current conversion of skb->data_end reads like this,
>
>   ; data_end = (void*)(long)skb->data_end;
>    559: (79) r1 = *(u64 *)(r2 +200)   ; r1  = skb->data
>    560: (61) r11 = *(u32 *)(r2 +112)  ; r11 = skb->len
>    561: (0f) r1 += r11
>    562: (61) r11 = *(u32 *)(r2 +116)
>    563: (1f) r1 -= r11
>
> But similar to the case
>
>  ("bpf: sock_ops sk access may stomp registers when dst_reg = src_reg"),
>
> the code will read an incorrect skb->len when src == dst. In this case we
> end up generating this xlated code.
>
>   ; data_end = (void*)(long)skb->data_end;
>    559: (79) r1 = *(u64 *)(r1 +200)   ; r1  = skb->data
>    560: (61) r11 = *(u32 *)(r1 +112)  ; r11 = (skb->data)->len
>    561: (0f) r1 += r11
>    562: (61) r11 = *(u32 *)(r1 +116)
>    563: (1f) r1 -= r11
>
> where line 560 is the reading 4B of (skb->data + 112) instead of the
> intended skb->len Here the skb pointer in r1 gets set to skb->data and
> the later deref for skb->len ends up following skb->data instead of skb.
>
> This fixes the issue similarly to the patch mentioned above by creating
> an additional temporary variable and using to store the register when
> dst_reg = src_reg. We name the variable bpf_temp_reg and place it in the
> cb context for sk_skb. Then we restore from the temp to ensure nothing
> is lost.
>
> Fixes: 16137b09a66f2 ("bpf: Compute data_end dynamically with JIT code")
> Signed-off-by: Jussi Maki <joamaki@gmail.com>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
