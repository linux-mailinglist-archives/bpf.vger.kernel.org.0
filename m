Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279543E9FB2
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 09:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhHLHpM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Aug 2021 03:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbhHLHpL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Aug 2021 03:45:11 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABA7C061798
        for <bpf@vger.kernel.org>; Thu, 12 Aug 2021 00:44:46 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u13so9265738lje.5
        for <bpf@vger.kernel.org>; Thu, 12 Aug 2021 00:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=NyaJ++B2aCALocOuAObqcKcOAmgrUg5bGvDOtyDp6g4=;
        b=ZThf3UyfBrydNivu27GZd40opCaeQrKBIniLPfKSbyGha3shvMTbgKqqfB6guaY3dJ
         PafMyc+EzEh7XtQTuI49FbssnbIxYHMoWzHmrauxylPT9Mt46+FPpX5qNKGTqPd7ZKWe
         ZzyWv8VH8ohL1nz7zPx6URcrfQSremb7EOZzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=NyaJ++B2aCALocOuAObqcKcOAmgrUg5bGvDOtyDp6g4=;
        b=lqv6vKFSAhOjQsVl0+HplUPWWzl/S+TryKPVG7+FdsHZul9elxAC5XuUpb2Hbkq9ZK
         /7TdkFH4YLtB6VKjIRuiItGqN2kVDQDRxHBZhJ7e9iaTLlRfp/0L6fCFA2YlOkT8qXV/
         TZZ1oy1zFDRmQJiJDvFTonU8CzAyfQEJrxR5c9cXlOHLvM+LeQSjjAJj+hjl8DFB/JtD
         H9bncHAXJoeIyiwc960veehW1Q0zGqHggGLc+HNXRCHDm2jdTkXjtEu3/iOkEUnPwYsG
         xW29G/L1CKHOSE+AV3WGLn9si1dbB/5JtikFiW0VJYxUubGNJ7sFQJp8LT3Px9gX7vet
         r/kQ==
X-Gm-Message-State: AOAM530TUgOuP7a+ImsgSaj83EhJKHM3Latq1OmzTKLrZ4frlD/MZjYn
        KgZy+2HOEC9uytGqCFtmRis5rA==
X-Google-Smtp-Source: ABdhPJwnv0ye2HmxRqyGrc5NOVLhwwSpA2xpRHBC2r3XU1dM5VlR9kdld9A5hu1c/6eVz7Y0b5wZ9Q==
X-Received: by 2002:a05:651c:554:: with SMTP id q20mr2057331ljp.172.1628754284537;
        Thu, 12 Aug 2021 00:44:44 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:480d:6f00:ff34:bf12:ef2:5071])
        by smtp.gmail.com with ESMTPSA id e21sm187097lfq.240.2021.08.12.00.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 00:44:43 -0700 (PDT)
References: <20210809194742.1489985-1-jiang.wang@bytedance.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Jiang Wang <jiang.wang@bytedance.com>
Cc:     netdev@vger.kernel.org, cong.wang@bytedance.com,
        duanxiongchun@bytedance.com, xieyongji@bytedance.com,
        chaiwen.cc@bytedance.com, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 0/5] sockmap: add sockmap support for unix
 stream socket
In-reply-to: <20210809194742.1489985-1-jiang.wang@bytedance.com>
Date:   Thu, 12 Aug 2021 09:44:43 +0200
Message-ID: <87v94bcdjo.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 09, 2021 at 09:47 PM CEST, Jiang Wang wrote:
> This patch series add support for unix stream type
> for sockmap. Sockmap already supports TCP, UDP,
> unix dgram types. The unix stream support is similar
> to unix dgram.
>
> Also add selftests for unix stream type in sockmap tests.
>
>
> Jiang Wang (5):
>   af_unix: add read_sock for stream socket types
>   af_unix: add unix_stream_proto for sockmap
>   selftest/bpf: add tests for sockmap with unix stream type.
>   selftest/bpf: change udp to inet in some function names
>   selftest/bpf: add new tests in sockmap for unix stream to tcp.
>
>  include/net/af_unix.h                         |  8 +-
>  net/unix/af_unix.c                            | 91 +++++++++++++++---
>  net/unix/unix_bpf.c                           | 93 ++++++++++++++-----
>  .../selftests/bpf/prog_tests/sockmap_listen.c | 48 ++++++----
>  4 files changed, 187 insertions(+), 53 deletions(-)
>
> v1 -> v2 :
>  - Call unhash in shutdown.
>  - Clean up unix_create1 a bit.
>  - Return -ENOTCONN if socket is not connected.
>
> v2 -> v3 :
>  - check for stream type in update_proto
>  - remove intermediate variable in __unix_stream_recvmsg
>  - fix compile warning in unix_stream_recvmsg
>
> v3 -> v4 :
>  - remove sk_is_unix_stream, just check TCP_ESTABLISHED for UNIX sockets.
>  - add READ_ONCE in unix_dgram_recvmsg
>  - remove type check in unix_stream_bpf_update_proto
>
> v4 -> v5 :
>  - add two missing READ_ONCE for sk_prot.
>
> v5 -> v6 :
>  - fix READ_ONCE by reading to a local variable first.

For the series:

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
