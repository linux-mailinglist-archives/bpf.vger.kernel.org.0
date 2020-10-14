Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1115228DBEC
	for <lists+bpf@lfdr.de>; Wed, 14 Oct 2020 10:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgJNIqR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Oct 2020 04:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgJNIqR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Oct 2020 04:46:17 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81A6C051113
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2020 01:46:16 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m20so2321537ljj.5
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2020 01:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=WZzAvEzx83nvmn1jnQ1JsHRh7Bwi7GkshJQjuaqNhd8=;
        b=m2WQrD/hdTD5LjbHDAwGuoYOIGT0qzS7Rh2cRUH6c+z59FC5L21sfBT+CFxcdFn3rm
         yeIaHgqk+FbRNeIpMhUpqb0rxxrLN9Jp4j8eHxTKDq6naLPsInM3Rq8eMvRTuUBxL4uP
         2hRzm12E82CCk8DrGd4TgC2L4Kao7gMIGdvCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=WZzAvEzx83nvmn1jnQ1JsHRh7Bwi7GkshJQjuaqNhd8=;
        b=UFm4l9owfwAfWvvIwtr1OtdXTXwM1A3PEt3Lz92Uj31kMjEMCyWM8BM1K5dnW45Lcq
         yuQtVHXuyor5qvTV1bpJCEBHnZqNtJssQX9Q86QRuZ/sSe3YsL2xoxHWwC7p1/8F8p8L
         QUUWBrmUfwcrfCQBJHy80S49D310+ENBQdKNZ8BgVOb6pZ0c18zVvFqzg/K4Muqe7vBW
         lhZ6zpHIE2eqa36qF/C2gGJicX7b0Sp6I81AX0EdoOnxsvWvk/laFEi80z9WV9A/ISaT
         xuAoHZ8ktWgelJ3BcPFurjoVE/GEd+9Z2+xCzhBWv3L2BE8GqL5Hvef48OJOZtUl304Q
         FtBA==
X-Gm-Message-State: AOAM532OjGfN0bg9+sOywN+/H+Xfc/RYdB1L4CtJXUVIeS/YVWAyBaPG
        S4VOwtgjIK/puoeyChI3ENVCcA==
X-Google-Smtp-Source: ABdhPJwNpOAovNBhBYsFFDCiT34RRRcmevp3KQV8NZfuMYOl1uJJgvCOlNTAqwDR86oS5iVlVzy8sQ==
X-Received: by 2002:a2e:9d93:: with SMTP id c19mr1525646ljj.32.1602665175249;
        Wed, 14 Oct 2020 01:46:15 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id l188sm890871lfd.127.2020.10.14.01.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 01:46:14 -0700 (PDT)
References: <20201012091850.67452-1-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, kernel-team@cloudflare.com,
        kernel test robot <lkp@intel.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: sockmap: add locking annotations to iterator
In-reply-to: <20201012091850.67452-1-lmb@cloudflare.com>
Date:   Wed, 14 Oct 2020 10:46:13 +0200
Message-ID: <87a6wpqjoq.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 12, 2020 at 11:18 AM CEST, Lorenz Bauer wrote:
> The sparse checker currently outputs the following warnings:
>
>     include/linux/rcupdate.h:632:9: sparse: sparse: context imbalance in 'sock_hash_seq_start' - wrong count at exit
>     include/linux/rcupdate.h:632:9: sparse: sparse: context imbalance in 'sock_map_seq_start' - wrong count at exit
>
> Add the necessary __acquires and __release annotations to make the
> iterator locking schema palatable to sparse. Also add __must_hold
> for good measure.
>
> The kernel codebase uses both __acquires(rcu) and __acquires(RCU).
> I couldn't find any guidance which one is preferred, so I used
> what is easier to type out.
>
> Fixes: 0365351524d7 ("net: Allow iterating sockmap and sockhash")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
