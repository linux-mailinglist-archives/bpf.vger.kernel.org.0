Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEEC31C223
	for <lists+bpf@lfdr.de>; Mon, 15 Feb 2021 20:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBOTEw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 14:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhBOTEn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Feb 2021 14:04:43 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65269C061786
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 11:03:47 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d3so12098537lfg.10
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 11:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=s2C8PR7Gw4nEOJjGQJh6Mj6huaxWG6Cou9QsccUmAuA=;
        b=qNGCMbvYw/SuMQffIqeeQ0c2icVOpqU4R6jom0su94hoz2p7qz1SMas0Ty+qv/D5jb
         4Mk1bdruniODXXLZ0gqrI6QYp9sX70TgN7c6+4+VF4R4reOB0e9K52sm8vt+7ZKD3MJA
         DoeXzioosVJgtO/lKCjhMmxLPbabKiSBcRE4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=s2C8PR7Gw4nEOJjGQJh6Mj6huaxWG6Cou9QsccUmAuA=;
        b=TH3grJLFQ3rs+ApaOvk8oD7JsbJmEaN804NbjYDbS2YxoO2CeXilwHncBCcN+IzszD
         DdZRPpNqqQIyZenr6V7lOy99Ha5MEcC+/7HvE6HxDhtNRJmctI6tqvYyUarWJ+UkUxBn
         Y3SK6ubbYPDqp552CQuaA9NfTJyLfTICoF7JYS8WrV0UxSigxLZ0Hm8SpfIFcIs4ztzX
         VatNdl2JCtEzCJCzqruMIjE5Rd7Z1u3/PeeECHO4PglqL7fCbKyoVUMV/h3g5i9nGO5k
         KmB8umeWESpiuVtGArg7mg2qtyD8+t5jEqc0zrstAScHKaAoD04aqE4jQs5TnN8JoO6d
         R0UA==
X-Gm-Message-State: AOAM533WVMN/tzFfkW4d+ima+xrWKhJWXI0c9oC6vqu65VzxVizTjnEE
        Qd1WVAyXrCco3Pv0tKGsPyjH3A==
X-Google-Smtp-Source: ABdhPJyk2gE5I+5RXz4Iki3O88Ruc5DilknvQWG0LZF/ygyZlaEroo4fH80n0fyCu5hZEawJIb91Lg==
X-Received: by 2002:ac2:4349:: with SMTP id o9mr10385634lfl.415.1613415825757;
        Mon, 15 Feb 2021 11:03:45 -0800 (PST)
Received: from cloudflare.com (83.24.183.171.ipv4.supernova.orange.pl. [83.24.183.171])
        by smtp.gmail.com with ESMTPSA id w9sm1793224lfn.308.2021.02.15.11.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 11:03:45 -0800 (PST)
References: <20210213214421.226357-1-xiyou.wangcong@gmail.com>
 <20210213214421.226357-3-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [Patch bpf-next v3 2/5] skmsg: get rid of struct sk_psock_parser
In-reply-to: <20210213214421.226357-3-xiyou.wangcong@gmail.com>
Date:   Mon, 15 Feb 2021 20:03:44 +0100
Message-ID: <87lfbp40hb.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 13, 2021 at 10:44 PM CET, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> struct sk_psock_parser is embedded in sk_psock, it is
> unnecessary as skb verdict also uses ->saved_data_ready.
> We can simply fold these fields into sk_psock, and get rid
> of ->enabled.
>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
