Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FE83216CB
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 13:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhBVMe6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 07:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhBVMdt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Feb 2021 07:33:49 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4566BC06174A
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 04:32:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l13so4625902wmg.5
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 04:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=V9F50EK0Q8zCGFxB+1uR1BuJV7kQ98LuLS69LykNs2Q=;
        b=hJAt76MiQkPmwJW7zRlmlHKD2Pgulo/mo7FAO3fnJlxg9rhJt6HeCibdMrdL5yq+Nc
         DCFjD0t/BJW6mTr6tOVchbxbJsmo+/p2L1vUIotMxKs04xlmxp56mD2IwBaziE4UAvkV
         KCy8xZJcKbtgL2NXUBUvPw0fw0H2syMluGhfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=V9F50EK0Q8zCGFxB+1uR1BuJV7kQ98LuLS69LykNs2Q=;
        b=YGB2PJ8GKWUAa2vCA6SBFIPsvNATqJg4K6vsVVIswUjT1opqZuU0DyzZiD5HSmjSax
         oqwW/1MFxg43fcD42Ai4UUJwn5acVv6FFI0wONYQi6ptj2NnyLXcaeKzSmEV01Ufx9a1
         KrBx7UwMcXzD4U52M270yEYehcjPEgB5o4Hm7Iwu675m9G91t7TD18w+1Apej/m1L9dD
         WhPyANisPyBCXKFTD3UTSTrlQQfdfzeaMcUTf0uYSYYPMTiqUJHpYJMYJ0C+JI/Vhynb
         7rd3RbS89IuCqdCO/dmfNMgCG5n4zQIBsiLcUixM62vd2XpVPNs6M5i9JNkR+CQW+pBV
         +Jiw==
X-Gm-Message-State: AOAM531qKHkKpTN9pZpgnWf+ODWI/5+ZoWhu0QgkEnCY9fQ1xwJE6JVf
        giZwuQNEMj5PqGwr+w7/pK9JIg==
X-Google-Smtp-Source: ABdhPJzc+Lir2UYjCZ5dHJDCjJXh5hZQBKGvUHdr7M2bbfK+8oP5E2JcUpM3bU9OvyVQ5W6ui2vFuA==
X-Received: by 2002:a1c:e446:: with SMTP id b67mr20206427wmh.65.1613997173009;
        Mon, 22 Feb 2021 04:32:53 -0800 (PST)
Received: from cloudflare.com (79.184.34.53.ipv4.supernova.orange.pl. [79.184.34.53])
        by smtp.gmail.com with ESMTPSA id w4sm24907658wmc.13.2021.02.22.04.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 04:32:52 -0800 (PST)
References: <20210220052924.106599-1-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v6 0/8] sock_map: clean up and refactor code
 for BPF_SK_SKB_VERDICT
In-reply-to: <20210220052924.106599-1-xiyou.wangcong@gmail.com>
Date:   Mon, 22 Feb 2021 13:32:51 +0100
Message-ID: <877dn0470s.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 20, 2021 at 06:29 AM CET, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> This patchset is the first series of patches separated out from
> the original large patchset, to make reviews easier. This patchset
> does not add any new feature or change any functionality but merely
> cleans up the existing sockmap and skmsg code and refactors it, to
> prepare for the patches followed up. This passed all BPF selftests.
>
> To see the big picture, the original whole patchset is available
> on github: https://github.com/congwang/linux/tree/sockmap
>
> and this patchset is also available on github:
> https://github.com/congwang/linux/tree/sockmap1
>
> ---

Thanks for the effort. It definitely looks like an improvement to me.

-Jakub
