Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9171A3216B2
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 13:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhBVMaj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 07:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhBVMaY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Feb 2021 07:30:24 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765C2C061786
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 04:29:28 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f137so209819wmf.3
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 04:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Um/pAjy6evc5KsuZIFI5b7KNbsTtb3tpuv1m3a0q7J4=;
        b=a0AzI0rXQ285SWuOENJHM8IagtB78Ge0b4+0LuieruoGSZqvz7hFYLu9xLBaP32tVn
         RV+7x/KgfhzO7rIVCqQOiYLblxknhC8EKtG3Bkxuc2dAqiXncRMpxcp11djf5gZs1yjy
         YJ1WL/AdEEJgfQnmkOqyu1wj7U12xMqO8hcp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Um/pAjy6evc5KsuZIFI5b7KNbsTtb3tpuv1m3a0q7J4=;
        b=B54UnBHikG6EvogYGpAOoX19/Kptz+5ToBbiM6d39mgXF1Y2BK8LU2szalBL2s1dQM
         hBvux56XYLBtCebuhPPaHPMYeM9hzSdrjdAGo2FVaNVDQHIM/ds+ekshwzk2WMsqBi4e
         l+lHe58rFbm3Zt00isnV5rSvQecrsnuEdYP1a5nEZWrRGoWqCArpg33eghUPvSyh0DHE
         p/0ARX1cjq06SpJ9panbPrjrmnsFsctGn2ho4vRBOMcoEVxrtvlMiurvOZhO7NqcahMS
         V/3M7szL0pBN24vssxlwLiji0jLdOLXjNilz3JLpkFasXD7mU5ZcLqxkZD5gcPhxX31d
         T3wQ==
X-Gm-Message-State: AOAM533G4zM8/1NJXeqSwGHLMeBxsTLnE1B5/3g/jX5laaCf9U2wi5J7
        g3ccfrD/Gfhk43a2Em5SpVSsEQ==
X-Google-Smtp-Source: ABdhPJzSp9EhYmjWwrD942KIJkvb7ao4IxqBsrwe5KqBXvOTQbNE8DpmG8JTyGUKpgoaEeE6q3MrSQ==
X-Received: by 2002:a05:600c:220f:: with SMTP id z15mr5456805wml.170.1613996967254;
        Mon, 22 Feb 2021 04:29:27 -0800 (PST)
Received: from cloudflare.com (79.184.34.53.ipv4.supernova.orange.pl. [79.184.34.53])
        by smtp.gmail.com with ESMTPSA id q15sm29726585wrr.58.2021.02.22.04.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 04:29:26 -0800 (PST)
References: <20210220052924.106599-1-xiyou.wangcong@gmail.com>
 <20210220052924.106599-7-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [Patch bpf-next v6 6/8] sock_map: make sock_map_prog_update()
 static
In-reply-to: <20210220052924.106599-7-xiyou.wangcong@gmail.com>
Date:   Mon, 22 Feb 2021 13:29:26 +0100
Message-ID: <87blcc476h.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 20, 2021 at 06:29 AM CET, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> It is only used within sock_map.c so can become static.
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Thanks for the cleanup.

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
