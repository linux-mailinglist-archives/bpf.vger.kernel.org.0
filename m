Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090E243482F
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJTJtT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 05:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230063AbhJTJtQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 05:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634723221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MmnjAvIGZuMXOqe+/bXaxv87jyZihvkxREajhAeaycU=;
        b=C5Y2Ow4zS2eZqWjPndNoCcTQWQV1WWQzKFzCumF9arWkx7M+zAn8+yd+bWPRAcLd+nvc1/
        VR4iaIqSVvG2v1XsJWwTuTC8qoJN7T3Y1/ySJOZkZI8EqBZ02hCoxAiYNLKyq2GBXnrmMI
        SZzypQdXpPY2R6XbODVWLOgNlfzkoNw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-bHSLDfq0P9SygSzlFxpO1Q-1; Wed, 20 Oct 2021 05:47:00 -0400
X-MC-Unique: bHSLDfq0P9SygSzlFxpO1Q-1
Received: by mail-ed1-f69.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so20456996edv.10
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 02:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MmnjAvIGZuMXOqe+/bXaxv87jyZihvkxREajhAeaycU=;
        b=ifsNDdL538mU/0bHI6DQCF/3G68kghHNzLOLPJWf3b10R9BJxKiUcF3ORG0XM3ks5n
         0BqfiK2zcLJQsYIWLdtTy29ODuOarzGYtzrssbbmSokB1Zcxu1IE+COCcnTG2qe3iiXu
         bRFIDN+OtIo6vTTtmv/g6pstxyjWdm1W4/MTnRPqVjiz/zGFImGTXpzHWx9tz5Ppc6Mt
         mXtDue+szYCsEkdGht6mW7ZsirSc0leaWaC3L8DEYW++vepd+R4Q3nIoYJDm8Xp4iBT7
         1eF+zFqYmWdmABfw57aMuZN1/LjB9z7lHSCs0TKlZJPzjxu6WG86X/qtQq2B4RI9ISEZ
         1HrA==
X-Gm-Message-State: AOAM530MNwN0zXIsVLIf1MyPByXp/Lo9l1NFHu1njYZmZznQBHE6Zq9g
        3TeCo39AfBr493pw5jfGb6yhdSTB01hqGiPtny68pV7YI6XMhtEGNtDxytH0JdmiSJvoqo02fK7
        35+ESFsccJ2WH
X-Received: by 2002:a05:6402:5216:: with SMTP id s22mr63058915edd.167.1634723219324;
        Wed, 20 Oct 2021 02:46:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ3Q6WhuzYdoLd1Ppez0eKaTA+F9/YDV65ZJKGvJfgG5Yp18XvUpLGeeHgiyLpU6/pIfe44w==
X-Received: by 2002:a05:6402:5216:: with SMTP id s22mr63058884edd.167.1634723218938;
        Wed, 20 Oct 2021 02:46:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b7sm806718ejl.10.2021.10.20.02.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 02:46:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DEF5B180262; Wed, 20 Oct 2021 11:46:57 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Maxim Mikityanskiy <maximmi@nvidia.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@chromium.org>,
        Joe Stringer <joe@cilium.io>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Maxim Mikityanskiy <maximmi@nvidia.com>
Subject: Re: [PATCH bpf-next 07/10] bpf: Add helpers to query conntrack info
In-Reply-To: <20211019144655.3483197-8-maximmi@nvidia.com>
References: <20211019144655.3483197-1-maximmi@nvidia.com>
 <20211019144655.3483197-8-maximmi@nvidia.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Oct 2021 11:46:57 +0200
Message-ID: <87ilxsf2pa.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> +#if IS_BUILTIN(CONFIG_NF_CONNTRACK)

This makes the helpers all but useless on distro kernels; I don't think
this is the right way to go about it. As Kumar mentioned, he's working
on an approach using kfuncs in modules; maybe you can collaborate on
that?

-Toke

