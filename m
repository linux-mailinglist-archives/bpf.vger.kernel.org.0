Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B8E14855B
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 13:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbgAXMqA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 07:46:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32792 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387574AbgAXMqA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 07:46:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so2389804lji.0
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2020 04:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=4XkP3XLOh0nhayuHg8yQANWqL4XcErc8i0KEhWGVI5w=;
        b=pJ2traqMIEBz89vTlCvmqNCjxA0dgLCemW0DuwXv7HCJPmpmz4D6FQXOIJuwcmkWVN
         ZBsAd3wxZtIAiDigSmxi4/m2a+Ck2JgKflDV1wiFmhJ5b4QMcPRMfoBaO6bthqhrYYyE
         xbxi52IMmgUdz4EX8iXPFUp9Yl2u6w3xkBHCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=4XkP3XLOh0nhayuHg8yQANWqL4XcErc8i0KEhWGVI5w=;
        b=Wr59L64yGbixpjR8Swu8FsgawSZWUay3/x5Iqfg1/qj1qPtx9s4/K5kg5lEm0AuD3X
         sF2s0ECBLyHi6DLudAOMJ0c1zcYZushsQM6ZeqxAh8Gy0VGlwjwcQcgff0lUBb91Q0yT
         MpxhBXfwrir6ly68rtwWmtaheEyKfXf7sqXBTDg8PV4tDEUhzzxIvdfahVOJaiQuOXke
         DgtON9o7mC5mTLTncdM0UO2LCICdek0jlD2QZHkfvimbz/WDZCAybg+9OdTPCaKDldd7
         chnQVlJMpxusEgfhoXbSqicrCsZaA3LyRFV6y/zmlpkYnndgYN508tVkMkO+rEHaBVP6
         ylTg==
X-Gm-Message-State: APjAAAWOch1+EJyi3K96q2bw3LaIdh0q5eeoNXOXRgJjGnQEnzzICPZQ
        3QQSrLfnDenw/8nXvUAA5WzApw==
X-Google-Smtp-Source: APXvYqxSA7g27hjTyBey14Cy6XKoiAAJfwkh7rb8FJPBpBaJm+8bvoRFgntL7BvazURh9RFylGJtng==
X-Received: by 2002:a2e:9804:: with SMTP id a4mr2011803ljj.10.1579869957666;
        Fri, 24 Jan 2020 04:45:57 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id s2sm3001343lji.53.2020.01.24.04.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 04:45:56 -0800 (PST)
References: <20200123165934.9584-1-lmb@cloudflare.com> <20200124112754.19664-1-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/4] Various fixes for sockmap and reuseport tests
In-reply-to: <20200124112754.19664-1-lmb@cloudflare.com>
Date:   Fri, 24 Jan 2020 13:45:55 +0100
Message-ID: <871rrp2fb0.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 24, 2020 at 12:27 PM CET, Lorenz Bauer wrote:
> I've fixed the commit messages, added Fixes tags and am submitting to bpf-next instead
> of the bpf tree.
>
> There is still the question whether patch #1 needs to preserve O_RDONLY, which John
> can hopefully answer.
>
> Lorenz Bauer (4):
>   selftests: bpf: use a temporary file in test_sockmap
>   selftests: bpf: ignore FIN packets for reuseport tests
>   selftests: bpf: make reuseport test output more legible
>   selftests: bpf: reset global state between reuseport test runs
>
>  .../bpf/prog_tests/select_reuseport.c         | 44 ++++++++++++++++---
>  .../bpf/progs/test_select_reuseport_kern.c    |  6 +++
>  tools/testing/selftests/bpf/test_sockmap.c    | 15 +++----
>  3 files changed, 49 insertions(+), 16 deletions(-)

For the series:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
