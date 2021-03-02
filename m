Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901D132B336
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352485AbhCCDuC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579223AbhCBQqr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 11:46:47 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6004DC061A2D
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 08:32:05 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id k12so15699372ljg.9
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 08:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQihGGsHn2Ec1V5JNWmQEWb+2T5lqpeyNq/VKNaEHRw=;
        b=E6cwBE5VzlV4wVDgZ+5gfHO3FSSotA0JLRjTSZdu7Bb7zSfQ/wTreBDQhnVBdNVO0P
         BmEv42CMpVK7DbnhKX6fiE4gqmwCmby9jvYIPF3++DRR6GDQipmcvet6zeKbeOFhwVjn
         9f9svBYlPd0qNABkFpXH8BuQNzAFjzNzfhXdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQihGGsHn2Ec1V5JNWmQEWb+2T5lqpeyNq/VKNaEHRw=;
        b=bHQ50j2ejJfvYY4dGdZZ8FPjxyKiwGJT49aWsZ8lcPeZYvLCTBrRQy0m/FNR/Wi43B
         FDECV1HGM39pe8e7t8wHwwNpUQxNfewDM5RjoBkfwIKnHMTPO9j1Enc6dSuzkf6Anp+x
         O8GZd+oftjq53XVU3YE02ATRlrm/PRTTh0nQu09/EhUtNaMQucGTIbBxlXAxzVBths/8
         BDV9TWHG7eDq0oh/cvgfOv/BSLipFwzJ1vjKZxNjaDaDwJXXLKk6jNo4c/8t5vW4wGDB
         GzVbbX3EH+Ye1qLXKoqoU9fTm8HOnsElH2EClNcYCqqsvdHTxMRacQjfruVhW3IX2lAI
         oXHA==
X-Gm-Message-State: AOAM531yF850VhZv4ODo7JAxWQ3DH8EE88o4oszGDwy/NaVh7OpGvj9M
        nruE4RXrMPYJIgDZwR3Hi24JvqDnRA7K9g5wWTk4Qw==
X-Google-Smtp-Source: ABdhPJyqTCMe34NCYpbrf7DiAJUDrgXX6BaBkGrG0BXnYkXVOSQp6WYMnnPCYNt3vtXA9wfKPEJHoEWayR97nwfzEkY=
X-Received: by 2002:a05:651c:1318:: with SMTP id u24mr12776204lja.426.1614702723884;
 Tue, 02 Mar 2021 08:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20210302023743.24123-1-xiyou.wangcong@gmail.com> <20210302023743.24123-10-xiyou.wangcong@gmail.com>
In-Reply-To: <20210302023743.24123-10-xiyou.wangcong@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 2 Mar 2021 16:31:53 +0000
Message-ID: <CACAyw9-wmN-pGYPkk4Ey_bazoycWAn+1-ewccTKeo-ebpHqyPA@mail.gmail.com>
Subject: Re: [Patch bpf-next v2 9/9] selftests/bpf: add a test case for udp sockmap
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2 Mar 2021 at 02:38, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> From: Cong Wang <cong.wang@bytedance.com>
>
> Add a test case to ensure redirection between two UDP sockets work.

I basically don't understand how splicing works, but watching from the
sidelines makes me think it'd be good to have more thorough tests.
tools/testing/selftests/bpf/test_sockmap.c has quite elaborate tests
for the TCP part, it'd be nice to get similar tests going for UDP. For
example:

* sendfile?
* sendmmsg
* Something Jakub mentioned: what happens when a connected, spliced
socket is disconnected via connect(AF_UNSPEC)? Seems like we don't
hook sk_prot->disconnect anywhere.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
