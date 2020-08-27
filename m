Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0499225510D
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 00:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgH0W3f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 18:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgH0W3e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 18:29:34 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D0DC061264
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 15:29:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so6365729wmi.1
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 15:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VpjIjxVjrw4iQmx0tewhD/g0v9AKMFe/1hTBt4NFhOg=;
        b=JV3QPzltyDjIVRpKWwTtmZcctrkFtESiLriUbBZcXe7r6Y8cWw9jtVkwl0WscMDULR
         R+rI0OknkwIROfT0VXkHZSYDFLvO4AKQVY8IjYGIe+g+pvOXMUmQmqQm09IlKyCYYi2R
         zfrF5miu4BLy1e9xG6+Den8VXMVKUZjWia/Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VpjIjxVjrw4iQmx0tewhD/g0v9AKMFe/1hTBt4NFhOg=;
        b=oVlgYQHT1U38KvO+sqgoWemTvU/G6s5UvLz/eOiT3tQdwxdzLmjB08LOBgKcMzAotn
         zYbphEOc++HVq4GHkfWZElpI4BmZptpFuizXbqkMRhvzKVhGPHR8aLpxTluv4uBGyJ5e
         VNR/803iexAmnm8P+cHrlhGQ3N3iqYMilEhlIwBG69OFUIIHWGQlFzsnIXyMhIQs6ccM
         JXnvBrpElNDK2Oc+Rjtmj4v4BImywlPCDA/MbsR+2RWMUze3vzPQDuuR9ZzkafLSuBIj
         qU367Q4cHtKge4XN+/dImnZIemx5+xliMZDieubxhY3wOGtkspYHLHUh9X+k2mTrCl5C
         qWWw==
X-Gm-Message-State: AOAM531bKO+iRb244523uI1jJXGyNov4cPliz4fno7KJdO8kUJSQugVL
        xBxcP5RMbg/+9YHB57fH1xPmyS7fc9UCsZHlZpg2Dg==
X-Google-Smtp-Source: ABdhPJzh91Xkzx9eIqvgCKuFb4fwoMU5rEGvQgaYNjMlmmutKlidkb21ZRo/6AGTtf6DkIL3V7Ym1HA7J0DKdE9UPBo=
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr999197wmf.26.1598567372615;
 Thu, 27 Aug 2020 15:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200827220114.69225-1-alexei.starovoitov@gmail.com> <20200827220114.69225-4-alexei.starovoitov@gmail.com>
In-Reply-To: <20200827220114.69225-4-alexei.starovoitov@gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 28 Aug 2020 00:29:22 +0200
Message-ID: <CACYkzJ7Ln-3EdWRL7hGrhMuzViuMpEc0nQQjx0SbpJfJ_FWOTg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/5] bpf: Add bpf_copy_from_user() helper.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>, josef@toxicpanda.com,
        bpoirier@suse.com, Andrew Morton <akpm@linux-foundation.org>,
        hannes@cmpxchg.org, Networking <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 28, 2020 at 12:01 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Sleepable BPF programs can now use copy_from_user() to access user memory.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: KP Singh <kpsingh@google.com>
