Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA541C9622
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 18:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEGQOM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 12:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726467AbgEGQOL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 12:14:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2ECC05BD09
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 09:14:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o134so7540201yba.18
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=elZRWiJacHTByu3IDRfBXpMhoFL/CH5h+5bxsr2OQXg=;
        b=YU6c+N8c+ZcLIZIBNoMxjFMalwkY43lobROB9W5vcW+Bhu/T1vaiSLF2ST3K06fV2G
         LRh18fw6EkndZPRUfXLGFv78n+AoZYQjSm4vsyCrhVBSJqvjAQYgA63U5wrx2XFwpJSf
         CLIsBrogp9KUAX6xqbkprvhie5Z3a7oqE1w3GKpnpcQAAI+NkKEb/Zymk7Iwq7Aw1/0Z
         gp3bi2oyFnb6RxYWUUpliM9Wj9wOX/rIl0fBK/aMvgSFMv+A3iwoL4RjtNuwYhL4H8Ir
         6TEeLEUBPV74RfZVl1jHRYjxwLHNbyXCwRNDBkxB8F0z7cZ54wKhhiobjIWBv4znkgGl
         Ntag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=elZRWiJacHTByu3IDRfBXpMhoFL/CH5h+5bxsr2OQXg=;
        b=i60pbu6Ssd2eTavVTZHkZbLkyzQcIP/cuLse3w6Q1Nm4JAmWbaM1AaVtgfD4GhzWTz
         g/QnMMNkvMgz0EtEhVeJ1QhbrrDo1DZOZHWDV+mM+ey1iVUcyPA6tW6f9oZRs0rgeAeB
         tY4uqZVyWYT7bCZ/NHXrL3ySfcZQnqEzEY4ht1NjXIdAwbj2zmR7xy+rXbE+U/3iamLn
         SKQ3cZuK812G3j9jJ3biQp8lRnOs2lBp8oazxC7XDT9pm2wPpY4jXK9PJ0yPaftuiPf7
         ceIn7crY/mTe9vCTZpsxHo2cpEHw/LiZb7BcD1XNPKNSdK7MKTFX4o16rJLtvoq2bSUX
         scjA==
X-Gm-Message-State: AGi0PuarXyIoIUY1VsdARKMrkSoGPPVX8df+/3hWDXHE4qKnVMX/853Q
        rV0mD/xE8BZcRTUgsfT1i4+KDS8=
X-Google-Smtp-Source: APiQypIcboNK6ML7gfW53TddA6VnCRdOaiBdLjWa0oUaxLBwFcX+wPnb9BzmKAXPxB7wwo1gK2HR77I=
X-Received: by 2002:a25:d705:: with SMTP id o5mr23643576ybg.219.1588868049600;
 Thu, 07 May 2020 09:14:09 -0700 (PDT)
Date:   Thu, 7 May 2020 09:14:07 -0700
In-Reply-To: <20200507061244.63ztqtmiid64xptv@kafai-mbp>
Message-Id: <20200507161407.GJ241848@google.com>
Mime-Version: 1.0
References: <20200506223210.93595-1-sdf@google.com> <20200506223210.93595-4-sdf@google.com>
 <20200507061244.63ztqtmiid64xptv@kafai-mbp>
Subject: Re: [PATCH bpf-next v3 3/5] selftests/bpf: move existing common
 networking parts into network_helpers
From:   sdf@google.com
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/06, Martin KaFai Lau wrote:
> On Wed, May 06, 2020 at 03:32:08PM -0700, Stanislav Fomichev wrote:
> > 1. Move pkt_v4 and pkt_v6 into network_helpers and adjust the users.
> > 2. Copy-paste spin_lock_thread into two tests that use it.
> Instead of copying it into two tests,
> can spin_lock_thread be moved to network-helpers.c?
spin_lock_thread doesn't look like something that can be reused
by other networking tests and looks very specific to
prog_tests/spinlock.c and prog_tests/map_lock.c. It might be
better with the copy-paste now because that thread definition
is closer to the place that uses it.

I don't feel strongly about it and can put it into network_helpers.
Let me know if you prefer it that way.
