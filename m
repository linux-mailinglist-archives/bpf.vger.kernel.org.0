Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7609228F0A1
	for <lists+bpf@lfdr.de>; Thu, 15 Oct 2020 13:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgJOLEo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Oct 2020 07:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbgJOLEn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Oct 2020 07:04:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4879C061755
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2020 04:04:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c21so2649369ljn.13
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2020 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=+b/YNm12GlyjKZkrJa+xNKLCvbZwV87rX2QqyldGjws=;
        b=Fs8Ur5yfSGlhm3tkrS8CaTuEgOsMPvCDMHTtKy9DHInI+lZwRQhcOZh2hwlHQqaO7F
         2X6ynm/BaHcMWsp22AP25p2+TmAtD/jrgb5gK5scngcc8AyGkE8U4u10sbpFyvCYlk95
         Dmdy6P23JeOLfAlzCd20iyiEa+yCMdKmmiiN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=+b/YNm12GlyjKZkrJa+xNKLCvbZwV87rX2QqyldGjws=;
        b=VgD0YOlJQu1pbVLJrQVodTUJtxh4CO+5QrCStgRfz099DyuOmEqcxAslz9JfJOL7mO
         5nP/wbg23eBiACyjRIjT/ufVS6AlRTgNEZek37WXbuwmnRLmHTuH6mKYOYGHayX81QWJ
         CFhZ1t2JwFFiyIBZZOvTs0ZFBH18CNhYfqlM3hbUrmRVfbBdVwyznz0nVbnG8IQmA9XL
         oNsvquXdojkfslZdXy0HSVcHeD3lERArme1US3tVubEwAQ1x6gR9fWnpdAb46/tCpQ4S
         T2wkW1xvaqX9zj1iBnNBdUwGtOMOTi3rYfxaQ2h6c//bJOk18y4XboszrcKW19Uv2E12
         pnYA==
X-Gm-Message-State: AOAM532L/XGDZwlgV0UkgdY7sf8yTlwQ3icZQbIHddNryr/TnXasL5gL
        PPk6VyrkMdzdQQ+y7nkpkHyTXg==
X-Google-Smtp-Source: ABdhPJwqoqunynjtcFWpGOq7Yf1tTxX9lASD0Qj/cwux40BxHvQAh3fld0SAKdqEZMLhkeSXHURtXQ==
X-Received: by 2002:a2e:8e8f:: with SMTP id z15mr1100477ljk.238.1602759881002;
        Thu, 15 Oct 2020 04:04:41 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id j12sm929026lfb.28.2020.10.15.04.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 04:04:40 -0700 (PDT)
References: <20201012170952.60750-1-alex.dewar90@gmail.com> <878sc9qi3c.fsf@cloudflare.com> <5f87d37225c32_b7602083@john-XPS-13-9370.notmuch>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sockmap: Don't call bpf_prog_put() on NULL pointer
In-reply-to: <5f87d37225c32_b7602083@john-XPS-13-9370.notmuch>
Date:   Thu, 15 Oct 2020 13:04:39 +0200
Message-ID: <875z7brbqw.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 15, 2020 at 06:43 AM CEST, John Fastabend wrote:

[...]

> Jakub, any opinions on if we should just throw an error if users try to
> add a sock to a map with a parser but no verdict? At the moment we fall
> through and add the socket, but it wont do any receive parsing/verdict.
> At the moment I think its fine with above fix. The useful cases for RX
> are parser+verdict, verdict, and empty. Where empty is just used for
> redirects or other socket account tricks. Just something to keep in mind.

IMO we should not fail because map updates can interleave with sk_skb
prog attachments, like so:

	update_map(map_fd, sock_fd);
	attach_prog(parser_fd, map_fd, BPF_SK_SKB_STREAM_PARSER);
	update_map(map_fd, sock_fd); // OK
	attach_prog(verdict_fd, map_fd, BPF_SK_SKB_STREAM_VERDICT);
	update_map(map_fd, sock_fd);

In practice, I would expect one process/thread to attach the programs,
while another is allowed to update the map at the same time.
