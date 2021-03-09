Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAF7331B7B
	for <lists+bpf@lfdr.de>; Tue,  9 Mar 2021 01:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCIAMB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 19:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbhCIALw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Mar 2021 19:11:52 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF0DC06174A
        for <bpf@vger.kernel.org>; Mon,  8 Mar 2021 16:11:52 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id t29so8157596pfg.11
        for <bpf@vger.kernel.org>; Mon, 08 Mar 2021 16:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=32beJwyfpZhKQxbfivcYR5MFPhtm4p2qpaUPHZBwjr4=;
        b=peP5aYNzuBsrBx27vu66t1M96wA2PaAKqX+aJ4tS168TsSGmgEeEKrMorK2G/UM2qp
         BcpiL7qFU+hnL2CBC+lxhOZGArNSEMmqo2AvYnduqP9cFVlMizHr6h7+DuQ0qE3a5ip1
         IKhmEPDda6b5/w2L3l1ez0hSbTLoayWaeOoWIKFEI73aIM6wFgWRr6tX7XrUSLglHQvs
         GdNcnTHvf5PqbauqgrPOFfuc6dIEHiW+l13ic/3NV7SxsbbW37ktDYXKz4srxU1WaMie
         wsrku4/Z11cBvB1UgLY3DTtTPqFWurw6QhGR6AcDZOocH4SI1mei4QdQ2e4Xzo2aTvk8
         4lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=32beJwyfpZhKQxbfivcYR5MFPhtm4p2qpaUPHZBwjr4=;
        b=BR2lM7FNfhCoJuCjLty2S1JcWjkZ9d++qiZnKceSx3pRuvYXk7z9I4Z0pGRxM1ZUeW
         qhFCTJn1+wxo/62//2e/NQW7A+Awm17eo0Fe3uo/lOkt06yhOGdVQ4cDXOxtZKfz2MEo
         jbqgUCiIvQ9wjBI45qyfarXMHsiXNFf20o45sjJFwU4OsZh0dj7Hm9TN2JAvMJQcoxXW
         IWB0L3WLDPjrnXywIrouhVu6G3cfcDStuTDfFuXgS25eX+wdI8pgqnq8txQIIPhCnb/t
         f6y/Fu7X3h9WfslwIY8EVgQORdzZM69mtYMyjp+WICUNU67KSCdmBJRDsvK9w3gbuiiG
         LYCw==
X-Gm-Message-State: AOAM531kYX89yPB2kd/1t0l20Iiw6Ig25WkQruc6CmkxRaFHeDgh3Mox
        WEJ0ilxkz8dWNJhqFu+I8ewJeYXKD82HLMFBK4/fi5yaDaef0A==
X-Google-Smtp-Source: ABdhPJxSEp0U0bajgh/tFpafPp1khiasZWaQES5vMk/PBjGGDidwf7CBA4Gvu2/MIVFM5nAok4YK41Eo4fIu36Nwgx8=
X-Received: by 2002:aa7:8b11:0:b029:1fa:4ae4:18ba with SMTP id
 f17-20020aa78b110000b02901fa4ae418bamr492952pfd.64.1615248711519; Mon, 08 Mar
 2021 16:11:51 -0800 (PST)
MIME-Version: 1.0
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 8 Mar 2021 16:11:40 -0800
Message-ID: <CAM_iQpXJ4MWUhk-j+mC4ScsX12afcuUHT-64CpVj97QdQaNZZg@mail.gmail.com>
Subject: bpf timer design
To:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc:     Dongdong Wang <wangdongdong.6@bytedance.com>,
        duanxiongchun@bytedance.com, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, all

I have been thinking about eBPF timer APIs, it looks harder than I thought.

The API's themselves are not hard, here is what I have:

int bpf_timer_setup(struct bpf_timer *timer, void *callback_fn,
                    void *callback_ctx, u64 flags);
int bpf_timer_mod(struct bpf_timer *timer, u64 expires);
int bpf_timer_del(struct bpf_timer *timer);

which is pretty much similar to the current kernel timer API's.

The struct bpf_timer is a bit tricky, we still have to save the kernel timer
there but we do not want eBPF programs to touch it. So I simply save a pointer
to kernel timer inside:

struct bpf_timer {
       void *ptr;
};

but we obviously have to prevent eBPF programs from dereferencing it
with the verifier.

The hardest part is on the verifier side, we have to check:

1. Whether a timer is initialized before use. For example:

struct bpf_timer t;
bpf_timer_mod(&t, bpf_jiffies64() + HZ);

2. Whether a timer is still active before exiting. For example:

struct bpf_timer t;
bpf_setup_timer(&t, ....);
bpf_timer_mod(&t, bpf_jiffies64() + HZ);
//end of the eBPF program

I do not see any existing mechanism for checks like these, so potentially need
a lot of work.

And, unlike bpf_for_each_map_elem(), the timer callback is asynchronous, this
makes it harder to check its callback context etc..

Any thoughts and suggestions?

Thanks!
