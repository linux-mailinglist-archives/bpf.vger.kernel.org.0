Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFA7405F4D
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 00:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhIIWRT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 18:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbhIIWRS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 18:17:18 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD09C061574
        for <bpf@vger.kernel.org>; Thu,  9 Sep 2021 15:16:08 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v10so7009397ybm.5
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=u/FPYK1IWjl7CJh31tHuM4mcsWQo2ROdCZ/zThgYVII=;
        b=s6lzDaIN6ngQe3LkVxL6yDLdQaPzvNPvdJ4Z4SgbHh7Qpo/K0BojuCvK89xOC0EG9y
         Sgvp202qsRojWrkJLHa+43YmI0lxPlbmGjYdNuHMBGqc1JP5mqgwioMb1B8swrZbTGFE
         0ymZO3z5JVVRxCp7+LUlEfXPNS652N0hEKshrvJWXRD6HyGax/ofTtS3ExxPrDfQgauP
         Ybgk0DzTt5e0JUJ7aiqnSII2UoIWKdKEZsB9hB9t6zvGMsheYN2J9grJuOW37Y42BUrk
         84gYNUjzYpgTrXIBRg0gU11gDDjq4PfzzkVNZtL0IB7jybIgTtRweArbNo4+/XGCt5Yq
         4+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=u/FPYK1IWjl7CJh31tHuM4mcsWQo2ROdCZ/zThgYVII=;
        b=IcTtazTv3RbyeR9AEF/Oqyll7/hwFpbFQlkqPNbSsXTz1OsYif16OnCXH6xJPsArq9
         0mYEQ9YKqV1taxY/iyWeB7OLVUWSYedXqislDv0yxeJEjkb51wfK8WenaWQpTa706T+K
         LFY26CFU7+fFDMiy57opsK/7MHuLGQ08jcQQ2kwiBreqvxSNfsiTVCCEqhXbV96BGvX/
         Se0wdyN7j2X3hsLHmKNFriJliz3IQibiBvt+taqd+q9innCMFVnhagDmHLeAF8UWnB7l
         FQWJZm723HBKOMyuQl+Ly/zUoK122reIg9sugHn8SLMSGtYeRbqstEMhsPnbBs1FH0Ex
         KtDw==
X-Gm-Message-State: AOAM531hrjmyE2dZtWaXtxnQ7LPdk2pvReeoIJvTOBZerSWhe0HH+VDX
        Xn2u6qdPgtpvygxPNd/3+dcme9pprIZn8gMOZmLBxPS9I3JfOaVp
X-Google-Smtp-Source: ABdhPJz6l8ZDOXKsm3TJwgF3q92DeKinpuJmy/dcNcG+iXwbIB1VRLVv0Z3k10BkXeiaTWY6Q7bXteIo7SREdEr/B1U=
X-Received: by 2002:a05:6902:1546:: with SMTP id r6mr7369626ybu.268.1631225767910;
 Thu, 09 Sep 2021 15:16:07 -0700 (PDT)
MIME-Version: 1.0
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Fri, 10 Sep 2021 00:15:57 +0200
Message-ID: <CAM1=_QRyRVCODcXo_Y6qOm1iT163HoiSj8U2pZ8Rj3hzMTT=HQ@mail.gmail.com>
Subject: Actual tail call count limits in x86 JITs and interpreter
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@cilium.io>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I have done some investigation into this matter, and this is what I
have found. To recap, the situation is as follows.

MAX_TAIL_CALL_CNT is defined to be 32. Since the interpreter has used
33 instead, we agree to use that limit across all JIT implementations
to not break any user space program. To make sure everything uses the
same limit, we must first understand what the current state actually
is so we know what to fix.

Me: according to test_bpf.ko the tail call limit is 33 for the
interpreter, and 32 for the x86-64 JIT.
Paul: according to selftests the tail call limit is 33 for both the
interpreter and the x86-64 JIT.

Link: https://lore.kernel.org/bpf/20210809093437.876558-1-johan.almbladh@anyfinetworks.com/

I have been able to reproduce the above selftests results using
vmtest.sh. Digging deeper into this, I found that there are actually
two different code paths where the tail call count is checked in the
x86-64 JIT, corresponding to direct and indirect tail calls. By
setting different limits in those two places, I found that selftests
tailcall_3 hits the limit in emit_bpf_tail_call_direct(), whereas the
test_bpf.ko is limited by emit_bpf_tail_call_indirect().

I am not 100% sure that this is the correct explanation, but it sounds
very reasonable. However, the asm generated in the two cases look very
similar to me, so by looking at that alone I cannot really see that
the limits would be different. Perhaps someone more versed in x86 asm
could take a closer look.

What are your thoughts?

Johan
