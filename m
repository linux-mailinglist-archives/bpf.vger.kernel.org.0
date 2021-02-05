Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CC6310A44
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 12:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhBEL27 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 06:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhBEL0e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 06:26:34 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEA9C061793
        for <bpf@vger.kernel.org>; Fri,  5 Feb 2021 03:25:38 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id f2so7276469ljp.11
        for <bpf@vger.kernel.org>; Fri, 05 Feb 2021 03:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ybV/Q5ENUMIhgRk5s2OR+HoiY2KcQU9r+v27kuJbtR8=;
        b=crimDMBEWitNjsIbVpcaquXgjeB+n9+crvhC9pGtHmdsOgjI5om/GVruMiPwHgemEs
         qYQ0UGx63W3AW/dnUpri7PaJXQxXY1NhyRRieqXoPzcmwyecWfoSrQtjsNm1vsMxVcok
         EDesDAbegNKha8sg6KS8s8e8cu8Q0EKIM2750=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ybV/Q5ENUMIhgRk5s2OR+HoiY2KcQU9r+v27kuJbtR8=;
        b=dP5VuaQiIWL/wQA+hGbKrHTk9nbYx9uoTxpgt1bXQIYgap+Xtc+Vaj8sHZgDWuB4Tx
         4AZ+M7MR1wlIKdJl3O9Pu/6q8UjIGfNbrIYQuHJZvZLxoufwB0Jv6G172JkTf9v+uN6u
         HCkrtUXEEV84aavSJ5KOEqHb2/wZzCmdZR6bBrw8k27pygtxYKaezQjvoNxI+/Dy5TbV
         8IGgIpVxmOEGgZ8Gf7SNX9+GxXNBccPTELLIVi9y50IVlgglQ9sP+28b0p4BKBPrWsx9
         Z56ROxR/LFlUSu3Wk/RDuuUECbpxzpK8NxgBUWga+xa3gr3QEKcc8wr3dzKVBM4EZ/Um
         Tqkw==
X-Gm-Message-State: AOAM53112bU4WJQROgG++upalSJfOq9aR7ZjJyN2H9Q3/4xziCRHml2E
        JNzY2WWa8zLSURAzRQm/etIYG2+itOprsiWY
X-Google-Smtp-Source: ABdhPJz9IZnUD3NRp5XvUhmrWV+tQiG6fjwXNRo7mKLHAOD+HO91GfbL/vfF5TwzquCn2VQ3EJN8iA==
X-Received: by 2002:a05:651c:106f:: with SMTP id y15mr2388459ljm.418.1612524337258;
        Fri, 05 Feb 2021 03:25:37 -0800 (PST)
Received: from cloudflare.com (83.24.202.200.ipv4.supernova.orange.pl. [83.24.202.200])
        by smtp.gmail.com with ESMTPSA id x27sm954141lfu.151.2021.02.05.03.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:25:36 -0800 (PST)
References: <20210203041636.38555-1-xiyou.wangcong@gmail.com>
 <20210203041636.38555-3-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [Patch bpf-next 02/19] skmsg: get rid of struct sk_psock_parser
In-reply-to: <20210203041636.38555-3-xiyou.wangcong@gmail.com>
Date:   Fri, 05 Feb 2021 12:25:35 +0100
Message-ID: <87ft2a4uz4.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 03, 2021 at 05:16 AM CET, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> struct sk_psock_parser is embedded in sk_psock, it is
> unnecessary as skb verdict also uses ->saved_data_ready.
> We can simply fold these fields into sk_psock.
>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

This one looks like a candidate for splitting out of the series, as it
stands on its own, to make the itself series smaller.

Also, it seems that we always have:

  parser.enabled/bpf_running == (saved_data_ready != NULL)

Maybe parser.enabled can be turned into a predicate function.

[...]
