Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBB34D8838
	for <lists+bpf@lfdr.de>; Mon, 14 Mar 2022 16:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiCNPgc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 11:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiCNPgc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 11:36:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3BF35DF8
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 08:35:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w7so27881533lfd.6
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 08:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=vrVzeUCiTHBFwdc63+qoZKSsykVZVjwS0M8XhkAXBgU=;
        b=Jd84SPnCigNqMT9Wv/rqu1kZEH66d3fU9aX1ui0q/IfDzzTu092j0TguXFAnnoiIWe
         TbPVv1wAt+B6VG5I7ZgJqJjdQft4ZHqqctwCa7cU3laaSj6mYyRJdn1q8odplj10UPNq
         leRQXjs1EPFanagh53JnfRJyDxQiCGZICkww0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=vrVzeUCiTHBFwdc63+qoZKSsykVZVjwS0M8XhkAXBgU=;
        b=Lmfcv4GPB77LFiLvCG1HZ7wRrhVoPR/XAb6WlAOnI+JBTA2PuYCMj23MaBj8VwhceF
         F+s94GKV+C0jFNtFdlygr4kU31DIg9xaHgjwwfYhGKp6WtlHqPUKzZTooBTUpi+3BJrl
         4NAUza/Q6Eo4ilI+CSGxxUhGVSiQsZ+lmko7Sd23t2Sk13gEafHUKZUueQQMCzYz0Nps
         cBIOGCIPbOfWNevfvi6bg0oc/55COHxlMfM53BdOEwnlGuJ6EOcOPoUzAELp1e//4zC1
         YPAW9hLNsfRlXt5GaiUFIN4xGCMTEZjkIw3wWnAzLfaZTFquXMrCZMsw/Oa6uFKREY9x
         Noiw==
X-Gm-Message-State: AOAM5304MhMVlNG6lYus2WU1SYUGWle7wPiCuPwzROuZ8N4Aq+zFdENM
        6jOPbxltPYDSlcCs8IMyNG/WNQ==
X-Google-Smtp-Source: ABdhPJwT1F98EsQvk77rvRUYg+vpIVH6dyoXx9+RpfAcjryoIoqAUIhQ/CuZr16+G02rEML5FjrHIA==
X-Received: by 2002:a05:6512:108a:b0:448:6519:3bc1 with SMTP id j10-20020a056512108a00b0044865193bc1mr12864193lfg.679.1647272120097;
        Mon, 14 Mar 2022 08:35:20 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-4809-d800-0000-0000-0000-0f9c.aa.ipv6.supernova.orange.pl. [2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id j9-20020a2ea909000000b0023742cb505dsm4000417ljq.82.2022.03.14.08.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 08:35:19 -0700 (PDT)
References: <20220314124432.3050394-1-wangyufen@huawei.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     ast@kernel.org, john.fastabend@gmail.com, daniel@iogearbox.net,
        lmb@cloudflare.com, davem@davemloft.net, kafai@fb.com,
        dsahern@kernel.org, kuba@kernel.org, songliubraving@fb.com,
        yhs@fb.com, kpsingh@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, sockmap: Manual deletion of sockmap
 elements in user mode is not allowed
Date:   Mon, 14 Mar 2022 16:30:30 +0100
In-reply-to: <20220314124432.3050394-1-wangyufen@huawei.com>
Message-ID: <87sfrky2bt.fsf@cloudflare.com>
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

On Mon, Mar 14, 2022 at 08:44 PM +08, Wang Yufen wrote:
> A tcp socket in a sockmap. If user invokes bpf_map_delete_elem to delete
> the sockmap element, the tcp socket will switch to use the TCP protocol
> stack to send and receive packets. The switching process may cause some
> issues, such as if some msgs exist in the ingress queue and are cleared
> by sk_psock_drop(), the packets are lost, and the tcp data is abnormal.
>
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---

Can you please tell us a bit more about the life-cycle of the socket in
your workload? Questions that come to mind:

1) What triggers the removal of the socket from sockmap in your case?

2) Would it still be a problem if removal from sockmap did not cause any
packets to get dropped?

[...]
