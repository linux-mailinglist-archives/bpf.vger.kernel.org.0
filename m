Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B571C9599
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 17:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgEGP4b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 11:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726788AbgEGP4b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 11:56:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041C3C05BD09
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 08:56:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z6so7432980wml.2
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 08:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AC1Za5zGOrYrzQ3ylTOdqDCV+DmhaWJwcek7sOgv4R4=;
        b=HkWWYV1O/oVabut+gRYAoj3de0MhAZImS+wodZxgDtmRf79dhCApqzRvU6Qkejx+ty
         Ka9o27W+bwldjm8I6WH0hv5ZWFlGNDMdn0Kvp4L/Mviga04Q1L0t8eussqdVb6gZC0ec
         E7qbCFnDtVrWE4nsHFAjyNhbyS0Jf4iG4lp/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AC1Za5zGOrYrzQ3ylTOdqDCV+DmhaWJwcek7sOgv4R4=;
        b=UF1PMHgRrmvB0jGPoZ/Sk+E11RHDUnAABpNDPluHRAAAeBL+qKWQ83SORbWKaEGs1x
         SOBlRBjKP7nPryyxdtSTUGwovHrQ4nx3dv4Gy58Cdz5hbcYoZOD7zform23WqQiI1xJt
         e7ov0FI7Xn6JrCApxtXDjZHplV1ikODbvhxwnjLH5s3er+PkA04QcCmI8Kyyr1YwjKYs
         rybzAJiGNEbGxs6FfbrLsNBrJpU8P+09S6E/+Q5wbZS69yus+EQiqi3BDPTrWaihVQbo
         u1x7bjXjSNqLhr3/lDm2vUaq6IAx+X7TCjp+8eFD710V2g1bo/ZCVjYIfBbfd4b8K7hC
         hc0g==
X-Gm-Message-State: AGi0PuY4sZ6wJpUn4t6ts4pd8XNTrF9kcmcAccO9+e7moBYMNQVowyiU
        zxn0go0OjPg03UEDaRHKwrBJdw==
X-Google-Smtp-Source: APiQypI3AKtAy1ug1pJSQMa35znl0oHFFwOfJZIeElPHJqnWWOYzUspzckoB3+IFBrrhSvRiwoX1tw==
X-Received: by 2002:a1c:7212:: with SMTP id n18mr11825240wmc.53.1588866983573;
        Thu, 07 May 2020 08:56:23 -0700 (PDT)
Received: from toad ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id g12sm465321wmk.1.2020.05.07.08.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 08:56:23 -0700 (PDT)
Date:   Thu, 7 May 2020 17:56:15 +0200
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Martin KaFai Lau <kafai@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Cc:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <davem@davemloft.net>, <ast@kernel.org>, <daniel@iogearbox.net>,
        Andrey Ignatov <rdna@fb.com>
Subject: Re: [PATCH bpf-next v3 1/5] selftests/bpf: generalize helpers to
 control background listener
Message-ID: <20200507175615.69909ea0@toad>
In-Reply-To: <20200507060921.bns5nfxuoy5c3tcu@kafai-mbp>
References: <20200506223210.93595-1-sdf@google.com>
        <20200506223210.93595-2-sdf@google.com>
        <20200507060921.bns5nfxuoy5c3tcu@kafai-mbp>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 6 May 2020 23:09:21 -0700
Martin KaFai Lau <kafai@fb.com> wrote:

> On Wed, May 06, 2020 at 03:32:06PM -0700, Stanislav Fomichev wrote:
> > Move the following routines that let us start a background listener
> > thread and connect to a server by fd to the test_prog:
> > * start_server_thread - start background INADDR_ANY thread
> > * stop_server_thread - stop the thread
> > * connect_to_fd - connect to the server identified by fd
> > 
> > These will be used in the next commit.
> > 
> > Also, extend these helpers to support AF_INET6 and accept the family
> > as an argument.
> > 
> > v3:
> > * export extra helper to start server without a thread (Martin KaFai Lau)
> > 
> > v2:
> > * put helpers into network_helpers.c (Andrii Nakryiko)
> > 
> > Cc: Andrey Ignatov <rdna@fb.com>
> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---

Thanks for extracting network_helpers. I've seen network syscall
wrappers repeat between the tests I've touched. Will be super useful to
have it in one place.

[...]

> I still don't see a thread is needed in this existing test_tcp_rtt also.
> 
> I was hoping the start/stop_server_thread() helpers can be removed.
> I am not positive the future tests will find start/stop_server_thread()
> useful as is because it only does accept() and there is no easy way to
> get the accept-ed() fd.
> 
> If this test needs to keep the thread, may be only keep the
> start/stop_server_thread() in this test for now until
> there is another use case that can benefit from them.
> 
> Keep the start_server() and connect_to_fd() in the new
> network_helpers.c.  I think at least sk_assign.c (and likely
> a few others) should be able to reuse them later.  They
> are doing something very close to start_server() and
> connect_to_fd().
> 
> Thoughts?

IMHO starting a thread to accept() a connection and close it is an
overkill. I wouldn't spawn a thread if I can get away with interleaving
client and server operations on sockets on the main thread. Makes the
test code easier to follow, and strace, for me.

