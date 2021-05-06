Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A29D375454
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 15:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhEFNFN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 May 2021 09:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhEFNFM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 May 2021 09:05:12 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CE3C061574
        for <bpf@vger.kernel.org>; Thu,  6 May 2021 06:04:14 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u25so6939710ljg.7
        for <bpf@vger.kernel.org>; Thu, 06 May 2021 06:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=rfyDPSaExhGqWdD0Vl3n68Y6e9r0XyGED7SRPeVnz3k=;
        b=NTafAriqCw6reAWtQHdrao9cce5/R9kLRVlK4kMGTG908vr+w9l1L9848zgkGOrxoG
         wwYiErSMB/Q0o56brqDoU7PdskxdkSicQuB055vq8hJ2P+LduddGnpEofNzjnDVXBSxT
         4m4yj62gDRTHw5n67Bd/IdKhtrXPIJakMpGPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=rfyDPSaExhGqWdD0Vl3n68Y6e9r0XyGED7SRPeVnz3k=;
        b=LZvCipLw9S4RuZvLrSX5WMY/n/IuFuaKUbKa8MASaclh08M5/zeCPxunWeEZVeP1JE
         Tf3UPTIb4TCYnl4Lk2UdLqurOg66rgHDE/YIJeaECltJgy7ApdkGcHJ3V82i1gcZk8rn
         i4vgf+ULyOAzAfCmz/GhH66JDYpcAk7pavmGYOi9SMLJjyo8e+zMFeJSGkoj8UT8ad2O
         vfsE1O1QtOnrvxxZIsGHnCFxEYe1s6rtpoC68jvgywTjSam9gXZhkUCDTtYM0CZRV76o
         ZaRVnNMTQxgzJOWpwZGoXyFc7Q3IDCIWaikAvIE8j9qGjVYYDHiP25nPElsCXxeLSisQ
         9FSQ==
X-Gm-Message-State: AOAM531HlEfpDKJDUZ243vvJHVIwmJdJOrEc2U8c8dx9K5zp3hlxK01B
        zPfJwwCJshYFFCmIGQt4O7VzHw==
X-Google-Smtp-Source: ABdhPJxZ+lbttu4iz+KVaXk+YzeRYKFF1i+5A25K9OwZJtz5OXLAukfE975wr0K2kdblDddN74iOfA==
X-Received: by 2002:a2e:8891:: with SMTP id k17mr3235116lji.11.1620306250755;
        Thu, 06 May 2021 06:04:10 -0700 (PDT)
Received: from cloudflare.com (83.31.64.64.ipv4.supernova.orange.pl. [83.31.64.64])
        by smtp.gmail.com with ESMTPSA id w20sm856314ljj.97.2021.05.06.06.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 06:04:09 -0700 (PDT)
References: <20210426025001.7899-1-xiyou.wangcong@gmail.com>
 <20210426025001.7899-4-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        jiang.wang@bytedance.com, duanxiongchun@bytedance.com,
        wangdongdong.6@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [Patch bpf-next v3 03/10] af_unix: implement
 ->psock_update_sk_prot()
In-reply-to: <20210426025001.7899-4-xiyou.wangcong@gmail.com>
Date:   Thu, 06 May 2021 15:04:07 +0200
Message-ID: <87o8doui7s.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 26, 2021 at 04:49 AM CEST, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> unix_proto is special, it is very different from INET proto,
> which even does not have a ->close(). We have to add a dummy
> one to satisfy sockmap.
>
> And now we can implement unix_bpf_update_proto() to update
> sk_prot.
>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

[...]

> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> new file mode 100644
> index 000000000000..b1582a659427
> --- /dev/null
> +++ b/net/unix/unix_bpf.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Cong Wang <cong.wang@bytedance.com> */
> +
> +#include <linux/skmsg.h>
> +#include <linux/bpf.h>
> +#include <net/sock.h>
> +#include <net/af_unix.h>
> +
> +static struct proto *unix_prot_saved __read_mostly;
> +static DEFINE_SPINLOCK(unix_prot_lock);
> +static struct proto unix_bpf_prot;
> +
> +static void unix_bpf_rebuild_protos(struct proto *prot, const struct proto *base)
> +{
> +	*prot        = *base;
> +	prot->close  = sock_map_close;
> +}

I think we also need unhash so that socket gets removed from sockmap
on disconnect, that is connect(fd, {sa_family=AF_UNSPEC, ...}, ...).
