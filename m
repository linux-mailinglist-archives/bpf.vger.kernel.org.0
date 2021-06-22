Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5913B00BA
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 11:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFVJuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 05:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhFVJuu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Jun 2021 05:50:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB65C061574
        for <bpf@vger.kernel.org>; Tue, 22 Jun 2021 02:48:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dm5so21159409ejc.9
        for <bpf@vger.kernel.org>; Tue, 22 Jun 2021 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8RElOEKvFjVDV6P4V4jZfTHZh2xq8goB+o7Uy2R9On8=;
        b=PNXBWT02dfS8FqE1Q/wf5z9bqcxP+j2CyosODpK7IQNn+TElZpoF/HJw523KHpCwd5
         CQEULM8QGFRDTrKLgG8Z6GEeN+0H0Zxf8S36C9EfX5/iEJELDOehZGGHcNT3zx4YMGCz
         QtS0t1ba2e5lFd2A/t1uIEAGPE7sHHcX+6uswrkdjutpisbKoYQab1ctWGae/RGCQkfE
         ympmhOfTUYJ6WMqyzh+TPrFvbRAX7F9ZUxO8MvBBjcxlxEtFK+yKVNR4s9XOyQC4rzrg
         QwBri5bUUiyJArh9h9PbulPHlADaaK+k/Lio85lN1uJB0IhRePg2IXOjDQzcVBXzLf/6
         Jhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8RElOEKvFjVDV6P4V4jZfTHZh2xq8goB+o7Uy2R9On8=;
        b=KVSrbu4almUrFme5/1KF1YZs3dh0aRqalO/9SuS1TqdkbYycFEw85+lMMCSbdA2LdK
         bxSe9ZlkB2JCjsZ0RioZxJsmBKRvQDHhq+sUFe8Cr6Ha2PBSGEesjL1t978Gsj5exddU
         FD4ctS1uTndturxXsiq4qhyE5T+SIszcob8WMr75TjqalyXNT6LdSP3zXS7jKBZ91WmF
         H8rHPoRd88yOy6tsqMiY70dpEKrikMp6D6KpbHdBdvfzs0Q7VF4CRfbgus/3Ec0sqFUL
         puBr8nYMZS1vuWOBoX/OBD+Rza/wpNtr7FlWhC+NegFqXZNbO4WVcLYIOoBvcAk+AFUw
         Uc6g==
X-Gm-Message-State: AOAM532gDnhgVVM2nxa2hkUvcTGWud9h/NS1uqWb0khmF8IX4PB/fWB2
        3b0IYTtcbJQmqvWsut4rYzVQ/w==
X-Google-Smtp-Source: ABdhPJwT54mMYJbx4XCwLZiMsO86QqUxLUC66X2nMx+DeIJVS1Tq/kYOALMd264S1WlQS4JrtC8DBg==
X-Received: by 2002:a17:907:9c9:: with SMTP id bx9mr3035256ejc.144.1624355313123;
        Tue, 22 Jun 2021 02:48:33 -0700 (PDT)
Received: from [192.168.1.204] (83-86-74-64.cable.dynamic.v4.ziggo.nl. [83.86.74.64])
        by smtp.gmail.com with ESMTPSA id gx4sm2213955ejc.34.2021.06.22.02.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 02:48:32 -0700 (PDT)
Subject: Re: [PATCH bpf] Revert "bpf: program: Refuse non-O_RDWR flags in
 BPF_OBJ_GET"
To:     =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <zenczykowski@gmail.com>,
        =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Linux Network Development Mailing List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Lorenz Bauer <lmb@cloudflare.com>
References: <20210618105526.265003-1-zenczykowski@gmail.com>
From:   Greg Kroah-Hartman <gregkh@google.com>
Message-ID: <f3133985-dcc0-89be-4cfa-8ba16456e1b9@google.com>
Date:   Tue, 22 Jun 2021 11:48:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618105526.265003-1-zenczykowski@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/18/21 12:55 PM, Maciej Żenczykowski wrote:
> From: Maciej Żenczykowski <maze@google.com>
> 
> This reverts commit d37300ed182131f1757895a62e556332857417e5.
> 
> This breaks Android userspace which expects to be able to
> fetch programs with just read permissions.
> 
> See: https://cs.android.com/android/platform/superproject/+/master:frameworks/libs/net/common/native/bpf_syscall_wrappers/include/BpfSyscallWrappers.h;drc=7005c764be23d31fa1d69e826b4a2f6689a8c81e;l=124
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Greg Kroah-Hartman <gregkh@google.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Fixes: d37300ed1821 ("bpf: program: Refuse non-O_RDWR flags in BPF_OBJ_GET")
> Signed-off-by: Maciej Żenczykowski <maze@google.com>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@google.com>
