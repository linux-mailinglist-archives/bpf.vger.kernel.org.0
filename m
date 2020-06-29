Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FF820E129
	for <lists+bpf@lfdr.de>; Mon, 29 Jun 2020 23:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgF2Uwh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jun 2020 16:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731343AbgF2TNY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:24 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5722C0A893C
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 00:42:26 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id o4so8522095lfi.7
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=dehoAPWG1C4zFRAsM2Hgz51wnypP3bkZmHH0inC/SE4=;
        b=HfRHaYe1bLPiZrP3enkwPCpjwaVwCHWeRiz6TUInU4PWdR2CQVF7DKY4T13zP/B4K4
         0EaxCRhvHXARTsFJKg9BnUm3QshCsc8n2IqVG/rX6v/vgukiSK8MnTL+wENyeG88SaLn
         PqCaBwQ0rgrxjbUKT+S/rYT2c3iQoxOIOO3Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=dehoAPWG1C4zFRAsM2Hgz51wnypP3bkZmHH0inC/SE4=;
        b=uREGFwCj5D5giJrEbpF9UGCs3fIL1jYErl0iKEuB4PVE/VaAnZjFORXNG9bsqvPUOU
         q/8r/Czpu2vidtLYEFA+/GuEAnjvE8uoNx6cfCnf1oqlBe5CShmKDkx6Tp3Tr0hx3i8h
         dgB28iwBTX9B2PZz71TXx9AHobD4GSQpeViFdu3gLwLq1AU2A64Hcqdx8gD9dinFY12q
         Xl6a+Q4VOLZO0xXqYCfOUQMWjL4YCWZsqMT12P/ZGrUFBqtGl1L07Cb/7ybWEOIEZZAT
         QXeluptO5gTT0Y8dlK3kC7XE8ZNx8PGHybDxpAc77hbfyV0Pdqy+EB7bOePegFcu//hT
         Wcog==
X-Gm-Message-State: AOAM533ojW2EoDNkdmG1kjQMloPRwmt8eWIqV+lUY8BWu5yLV0R5fYBf
        WA1DuDU+xZYg0E2asjfLIpI4EXuMW2u4AQ==
X-Google-Smtp-Source: ABdhPJwrtWoK6TAjkCMcGUSuVkzv9DxW/3FrqZvLStmAWpY/6EKvwNcFbQyy9OA4Sq7EnCigTcNxqA==
X-Received: by 2002:a05:6512:3398:: with SMTP id h24mr8399914lfg.135.1593416545225;
        Mon, 29 Jun 2020 00:42:25 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id e29sm7826437lfc.51.2020.06.29.00.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 00:42:24 -0700 (PDT)
References: <159312606846.18340.6821004346409614051.stgit@john-XPS-13-9370> <159312679888.18340.15248924071966273998.stgit@john-XPS-13-9370>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     kafai@fb.com, daniel@iogearbox.net, ast@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [bpf PATCH v2 2/3] bpf, sockmap: RCU dereferenced psock may be used outside RCU block
In-reply-to: <159312679888.18340.15248924071966273998.stgit@john-XPS-13-9370>
Date:   Mon, 29 Jun 2020 09:42:23 +0200
Message-ID: <87d05imi74.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 26, 2020 at 01:13 AM CEST, John Fastabend wrote:
> If an ingress verdict program specifies message sizes greater than
> skb->len and there is an ENOMEM error due to memory pressure we
> may call the rcv_msg handler outside the strp_data_ready() caller
> context. This is because on an ENOMEM error the strparser will
> retry from a workqueue. The caller currently protects the use of
> psock by calling the strp_data_ready() inside a rcu_read_lock/unlock
> block.
>
> But, in above workqueue error case the psock is accessed outside
> the read_lock/unlock block of the caller. So instead of using
> psock directly we must do a look up against the sk again to
> ensure the psock is available.
>
> There is an an ugly piece here where we must handle
> the case where we paused the strp and removed the psock. On
> psock removal we first pause the strparser and then remove
> the psock. If the strparser is paused while an skb is
> scheduled on the workqueue the skb will be dropped on the
> flow and kfree_skb() is called. If the workqueue manages
> to get called before we pause the strparser but runs the rcvmsg
> callback after the psock is removed we will hit the unlikely
> case where we run the sockmap rcvmsg handler but do not have
> a psock. For now we will follow strparser logic and drop the
> skb on the floor with skb_kfree(). This is ugly because the
> data is dropped. To date this has not caused problems in practice
> because either the application controlling the sockmap is
> coordinating with the datapath so that skbs are "flushed"
> before removal or we simply wait for the sock to be closed before
> removing it.
>
> This patch fixes the describe RCU bug and dropping the skb doesn't
> make things worse. Future patches will improve this by allowing
> the normal case where skbs are not merged to skip the strparser
> altogether. In practice many (most?) use cases have no need to
> merge skbs so its both a code complexity hit as seen above and
> a performance issue. For example, in the Cilium case we always
> set the strparser up to return sbks 1:1 without any merging and
> have avoided above issues.
>
> Fixes: e91de6afa81c1 ("bpf: Fix running sk_skb program types with ktls")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

LGTM. Sorry for the delay, needed to make sure I understand this.
