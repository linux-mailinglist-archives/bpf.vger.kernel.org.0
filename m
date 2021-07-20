Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A743CF7E3
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhGTJux (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Jul 2021 05:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbhGTJqq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Jul 2021 05:46:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05973C061766
        for <bpf@vger.kernel.org>; Tue, 20 Jul 2021 03:27:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1291413wmc.1
        for <bpf@vger.kernel.org>; Tue, 20 Jul 2021 03:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=rX65FkhH+runkAdpmro2t/pfk/k6mjZsrM+ki2qYx3g=;
        b=f1h8c0NQNl2SWH+GpPorq7Fu7mLoeDAvzPvISlbwAfniKdtR3Jhkn7XM1Rf+wbgqfs
         doOlMH1ZF/42lkD/apAdLvSblz6uzukiMS7MSI1CiXeoc+ZXvJdWIsdqLmE34c1OUCCz
         RJVyXPLCfnFJTLv/DkCC/10tmA/56VKn5GYB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=rX65FkhH+runkAdpmro2t/pfk/k6mjZsrM+ki2qYx3g=;
        b=tEtECeUeo5uRIWd/k6nWIN8F3vi7lnTq5dJh23AlRzx8bwQ1MvtJokAO8wrDUo0lO3
         IGPqIxCXkc8LaHvrySVlqH3tluoyfAYGY1iXS6QAtYhkSdV+dMAYafEX0o/8T/WhQBDQ
         wRsM2J4FH9h5G9jdf8sscSCY8GvTUcKGIvZ9wTl5f4qZ6qxq7ypyqJRHCVmEcsWB9P/7
         TIbl2cp9DzxBArebvcgpMC5kGH5gMbsneikk8mypoR4sb6oFjZiCr2Zz9CZFsXN2kevo
         yxN8FlKJC3C0tKwnbwMlUoErGFmsVsOryuColUnjoVGn4NkucohYqnHy07jzMlCWPEAB
         herw==
X-Gm-Message-State: AOAM533gowVbYzTLpJxkeQ1PhNnUSkjkxym7PsFqJa4l2BWKCDwlArLL
        RY1tjsR0/3eNPbDKX+zQFzdjTw==
X-Google-Smtp-Source: ABdhPJwWMHxekz8/dtwQkLgCe5B9Z3ch1mEGtemRgoUpK6NV6EFYQkoeQH7hNbZXRkQIR2d8Yd8ylQ==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr21303180wmk.40.1626776843490;
        Tue, 20 Jul 2021 03:27:23 -0700 (PDT)
Received: from cloudflare.com (79.191.183.149.ipv4.supernova.orange.pl. [79.191.183.149])
        by smtp.gmail.com with ESMTPSA id u16sm28028569wrw.36.2021.07.20.03.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:27:23 -0700 (PDT)
References: <20210719214834.125484-1-john.fastabend@gmail.com>
 <20210719214834.125484-2-john.fastabend@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     daniel@iogearbox.net, xiyou.wangcong@gmail.com,
        alexei.starovoitov@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf 1/3] bpf, sockmap: zap ingress queues after stopping
 strparser
In-reply-to: <20210719214834.125484-2-john.fastabend@gmail.com>
Date:   Tue, 20 Jul 2021 12:27:22 +0200
Message-ID: <87v955qnzp.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 19, 2021 at 11:48 PM CEST, John Fastabend wrote:
> We don't want strparser to run and pass skbs into skmsg handlers when
> the psock is null. We just sk_drop them in this case. When removing
> a live socket from map it means extra drops that we do not need to
> incur. Move the zap below strparser close to avoid this condition.
>
> This way we stop the stream parser first stopping it from processing
> packets and then delete the psock.
>
> Fixes: a136678c0bdbb ("bpf: sk_msg, zap ingress queue on psock down")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

To confirm my understanding - the extra drops can happen because
currently we are racing to clear SK_PSOCK_TX_ENABLED flag in
sk_psock_drop with sk_psock_verdict_apply, which checks the flag before
pushing skb onto psock->ingress_skb queue (or possibly straight into
psock->ingress_msg queue on no redirect).
