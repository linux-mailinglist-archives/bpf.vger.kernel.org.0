Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08D158A97D
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 12:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiHEKav (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 06:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240623AbiHEKaq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 06:30:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3709E248F8
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 03:30:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i128-20020a1c3b86000000b003a3a22178beso3772558wma.3
        for <bpf@vger.kernel.org>; Fri, 05 Aug 2022 03:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc;
        bh=Fj6CvmivrS9TPCyhKZOok91fag7o30GzVeMlkdrW5UY=;
        b=cscfL3NTbS6hrW9YRaDYe8O2B99CgwuZ396Af8zYT8/leAGXg6IRsbVOEu3ORRBrFa
         n1A2XRxnM1j7ypNMemvucqd8mMVq36kGgsqe3H+Zi4K9wousksUWwnXWsqHb4qi9cyOA
         MciAEOMmiwQIvhgyj+bjCZiroLfOpebuGlN7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc;
        bh=Fj6CvmivrS9TPCyhKZOok91fag7o30GzVeMlkdrW5UY=;
        b=ylDdYiTw9irssmL03pzU7AwYd+mkGoKTexnKW8RZfA4BfugDylUHVpdkRMLUDvbBHm
         TESZY4QzRGrTEXDk/TbpivunqvvORjWOnf7MosxdX1kpeZng6QUI6Tuh3YN3EC7aFxPG
         xNYPxEVPVcp2UjbXuORYAnb7dsFRpSlNCaTXIQmbH/OPbBZhHRy3QzQRyawxac2AZOi/
         wCugbAgu3w2goykWWeGbdbxviDteKx37bAvvU9HGww6ULELin35aGGIlrmyhQBSG/Plg
         imk0EqYrzq15xVw+4/sab2rVe07aUez59ulLwL+pvxNTCEwlSrYQa/BIEfuEoZyxMZ+P
         0XXg==
X-Gm-Message-State: ACgBeo2DPb8ywAI5meZGl1PIRwEH9sUtnNc/+vEsXI0vpTYxnFQtVjQm
        zyqzHylKQersT+WhKBIlZUrNRw==
X-Google-Smtp-Source: AA6agR59AieC5iYBstKo0qY2bhMRet0+L19AqHUBALTRhk6J+Kf8wmu3LcfZPUbzXe5puCQsazVxMA==
X-Received: by 2002:a1c:a1c5:0:b0:3a5:145b:3666 with SMTP id k188-20020a1ca1c5000000b003a5145b3666mr3938426wme.134.1659695443415;
        Fri, 05 Aug 2022 03:30:43 -0700 (PDT)
Received: from cloudflare.com (79.184.200.53.ipv4.supernova.orange.pl. [79.184.200.53])
        by smtp.gmail.com with ESMTPSA id az40-20020a05600c602800b003a310fe1d75sm9338955wmb.38.2022.08.05.03.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 03:30:42 -0700 (PDT)
References: <00000000000026328205e08cdbeb@google.com>
 <cover.1659676823.git.yin31149@gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     syzbot+5f26f85569bd179c18ce@syzkaller.appspotmail.com,
        paskripkin@gmail.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        18801353760@163.com, bpf@vger.kernel.org
Subject: Re: [PATCH net v5 0/2] net: enhancements to sk_user_data field
Date:   Fri, 05 Aug 2022 12:29:56 +0200
In-reply-to: <cover.1659676823.git.yin31149@gmail.com>
Message-ID: <87fsib9e3y.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 05, 2022 at 03:36 PM +08, Hawkins Jiawei wrote:
> This patchset fixes refcount bug by adding SK_USER_DATA_PSOCK flag bit in
> sk_user_data field. The bug cause following info:
>
> WARNING: CPU: 1 PID: 3605 at lib/refcount.c:19 refcount_warn_saturate+0xf4/0x1e0 lib/refcount.c:19
> Modules linked in:
> CPU: 1 PID: 3605 Comm: syz-executor208 Not tainted 5.18.0-syzkaller-03023-g7e062cda7d90 #0
>  <TASK>
>  __refcount_add_not_zero include/linux/refcount.h:163 [inline]
>  __refcount_inc_not_zero include/linux/refcount.h:227 [inline]
>  refcount_inc_not_zero include/linux/refcount.h:245 [inline]
>  sk_psock_get+0x3bc/0x410 include/linux/skmsg.h:439
>  tls_data_ready+0x6d/0x1b0 net/tls/tls_sw.c:2091
>  tcp_data_ready+0x106/0x520 net/ipv4/tcp_input.c:4983
>  tcp_data_queue+0x25f2/0x4c90 net/ipv4/tcp_input.c:5057
>  tcp_rcv_state_process+0x1774/0x4e80 net/ipv4/tcp_input.c:6659
>  tcp_v4_do_rcv+0x339/0x980 net/ipv4/tcp_ipv4.c:1682
>  sk_backlog_rcv include/net/sock.h:1061 [inline]
>  __release_sock+0x134/0x3b0 net/core/sock.c:2849
>  release_sock+0x54/0x1b0 net/core/sock.c:3404
>  inet_shutdown+0x1e0/0x430 net/ipv4/af_inet.c:909
>  __sys_shutdown_sock net/socket.c:2331 [inline]
>  __sys_shutdown_sock net/socket.c:2325 [inline]
>  __sys_shutdown+0xf1/0x1b0 net/socket.c:2343
>  __do_sys_shutdown net/socket.c:2351 [inline]
>  __se_sys_shutdown net/socket.c:2349 [inline]
>  __x64_sys_shutdown+0x50/0x70 net/socket.c:2349
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
>  </TASK>
>
> To improve code maintainability, this patchset refactors sk_user_data
> flags code to be more generic.
>
> Hawkins Jiawei (2):
>   net: fix refcount bug in sk_psock_get (2)
>   net: refactor bpf_sk_reuseport_detach()
>
>  include/linux/skmsg.h        |  3 +-
>  include/net/sock.h           | 68 +++++++++++++++++++++++++-----------
>  kernel/bpf/reuseport_array.c |  9 ++---
>  net/core/skmsg.c             |  4 ++-
>  4 files changed, 56 insertions(+), 28 deletions(-)

Thank you for the fix.

For the series:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
