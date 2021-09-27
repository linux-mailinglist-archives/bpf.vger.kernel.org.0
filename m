Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2854195D0
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 16:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhI0ODi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 10:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbhI0ODe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 10:03:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F6CC061783
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 07:01:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u18so76520930lfd.12
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=s9j0LgQC+YVJViqWRdjpPa26B5KzaV4iAKUPDeJDa7M=;
        b=fzL0q7aexhqMCVNkHA17E7KdXD6r5ZARfBPIXA4DYqjT6IQ4dVqeD1JNs+FlGCpwI7
         g1E7fPed0+u35YE5OEYz2s1x0pXzoDZ1KWkhwEz/zyQNsP1ckGj1owsJcELaPQTLAEnV
         wzXHFK2bClY/3RFvaOqElw1PLAZfRvNTaWFi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=s9j0LgQC+YVJViqWRdjpPa26B5KzaV4iAKUPDeJDa7M=;
        b=LVWYGAb4Ua1H629GllDB2kfWUR97W6P5/9fUwS4DtBv4y4+jUNsga0vx9OJpWKUw2r
         odM8saqrv/opLOnN1OGFVUlU2baI9Qw6lIE0z+Qy/ahM0Z6k0/rLreFMyPdL5FwlhcPF
         iz2J0Dac7VXJyxywek58Nkb+CmqNdsB9x2mnPJJ4t5sCetmu26xylLHWp9AJAO6C1N5e
         hmAp2YNZm6nDhv5WcHIpsQ8Rv41ksbYDTqEnNV2A7cT2f+ZT26EbMGWfYn0rOnui0n1t
         TvnnsSO4tc/Bkxt1j2FZJbHsnUHSu8Sso7enP/PiMvi+GVmMwPT2nakofP44LUcaSQ+q
         0fyA==
X-Gm-Message-State: AOAM533lMCJVKqCIfFz1q45OeZljVbJBQFHd4lVRORahnlQ3mhPORrr6
        F7mDlIJkBjJ+VbGNjSZCwSWDLw==
X-Google-Smtp-Source: ABdhPJwMx0WJg6o5/zvf8pCndWw5tsEjVtVB+Sej46yznRBrg+antKzEtDG47vGlQmjM2NVVMsgSig==
X-Received: by 2002:a05:6512:23a1:: with SMTP id c33mr4668734lfv.518.1632751280890;
        Mon, 27 Sep 2021 07:01:20 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-480d-6f00-ff34-bf12-0ef2-5071.aa.ipv6.supernova.orange.pl. [2a01:110f:480d:6f00:ff34:bf12:ef2:5071])
        by smtp.gmail.com with ESMTPSA id j26sm1605501lfk.287.2021.09.27.07.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 07:01:20 -0700 (PDT)
References: <20210924095542.33697-1-lmb@cloudflare.com>
 <20210924095542.33697-5-lmb@cloudflare.com>
 <a076398b-f1da-c939-3c71-ac157ad96939@iogearbox.net>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, kernel-team@cloudflare.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/4] bpf: export bpf_jit_current
In-reply-to: <a076398b-f1da-c939-3c71-ac157ad96939@iogearbox.net>
Date:   Mon, 27 Sep 2021 16:01:18 +0200
Message-ID: <871r5aglsh.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 27, 2021 at 03:34 PM CEST, Daniel Borkmann wrote:
> On 9/24/21 11:55 AM, Lorenz Bauer wrote:
>> Expose bpf_jit_current as a read only value via sysctl.
>> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
>> ---

I find exposing stats via system configuration variables a bit
unexpected. Not sure if there is any example today that we're following.

Maybe an entry under /sys/kernel/debug would be a better fit?

That way we don't have to commit to a sysctl that might go away if we
start charging JIT allocs against memory cgroup quota.

Although that brings up question against which cgroup iptables xt_bpf
allocations should be charged? Root cgroup?
